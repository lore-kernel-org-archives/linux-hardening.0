Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B27E4
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg46DKy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95431C433C7;
	Thu, 12 Oct 2023 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697077059;
	bh=GWfBuFj92ThQwSFoJGmNN5lq51idDCBd7SCsrd8jqGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg46DKy1m+EfsDO0AGJ0OVNV9j5iFYUVB0G74TlBT1kJjl1S7SeV/Si8q6QJi8WTd
	 z7s6r3dh7LjvKosUTRg7Q6NWSKOyYAPjG4+eIbnCkHYFLnN0hHeIz8v7xHi/L2rodO
	 8xw39+Rh9BozeGiCu7iikMCLX8o3V7KceKkGGXDVvW9aehv0x6/vxaY7yDuvr72eGV
	 74MAXDgix+jX59VtehzPAlnmIDNDhOtKwh0UPC6I8oF4LtlBoz4aerGAQG8AOWxNrI
	 ZF2WWBFxN6dNdPWALN4FUZY+2sfWxmd98OEIjc8KlhUhUiO6eZn9QYUukkITVSbOq7
	 CAWQ1R5FBn5GA==
Date: Wed, 11 Oct 2023 20:17:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] clk: visconti: Fix undefined behavior bug in
 struct visconti_pll_provider
Message-ID: <0a59a721d54b557076cc94eabeb694d463773204.1697076650.git.gustavoars@kernel.org>
References: <cover.1697076650.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697076650.git.gustavoars@kernel.org>

`struct clk_hw_onecell_data` is a flexible structure, which means that
it contains flexible-array member at the bottom, in this case array
`hws`:

include/linux/clk-provider.h:
1380 struct clk_hw_onecell_data {
1381         unsigned int num;
1382         struct clk_hw *hws[] __counted_by(num);
1383 };

This could potentially lead to an overwrite of the objects following
`clk_data` in `struct visconti_pll_provider`, in this case
`struct device_node *node;`, at run-time:

drivers/clk/visconti/pll.h:
 16 struct visconti_pll_provider {
 17         void __iomem *reg_base;
 18         struct clk_hw_onecell_data clk_data;
 19         struct device_node *node;
 20 };

Notice that a total of 56 bytes are allocated for flexible-array `hws`
at line 328. See below:

include/dt-bindings/clock/toshiba,tmpv770x.h:
 14 #define TMPV770X_NR_PLL		7

drivers/clk/visconti/pll-tmpv770x.c:
 69 ctx = visconti_init_pll(np, reg_base, TMPV770X_NR_PLL);

drivers/clk/visconti/pll.c:
321 struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
322                                                         void __iomem *base,
323                                                         unsigned long nr_plls)
324 {
325         struct visconti_pll_provider *ctx;
...
328         ctx = kzalloc(struct_size(ctx, clk_data.hws, nr_plls), GFP_KERNEL);

`struct_size(ctx, clk_data.hws, nr_plls)` above translates to
sizeof(struct visconti_pll_provider) + sizeof(struct clk_hw *) * 7 ==
24 + 8 * 7 == 24 + 56
		  ^^^^
		   |
	allocated bytes for flex array `hws`

$ pahole -C visconti_pll_provider drivers/clk/visconti/pll.o
struct visconti_pll_provider {
	void *                     reg_base;             /*     0     8 */
	struct clk_hw_onecell_data clk_data;             /*     8     8 */
	struct device_node *       node;                 /*    16     8 */

	/* size: 24, cachelines: 1, members: 3 */
	/* last cacheline: 24 bytes */
};

And then, after the allocation, some data is written into all members
of `struct visconti_pll_provider`:

332         for (i = 0; i < nr_plls; ++i)
333                 ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
334
335         ctx->node = np;
336         ctx->reg_base = base;
337         ctx->clk_data.num = nr_plls;

Fix all these by placing the declaration of object `clk_data` at the
end of `struct visconti_pll_provider`. Also, add a comment to make it
clear that this object must always be last in the structure, and
prevent this bug from being introduced again in the future.

Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/clk/visconti/pll.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h
index 01d07f1bf01b..c4bd40676da4 100644
--- a/drivers/clk/visconti/pll.h
+++ b/drivers/clk/visconti/pll.h
@@ -15,8 +15,10 @@
 
 struct visconti_pll_provider {
 	void __iomem *reg_base;
-	struct clk_hw_onecell_data clk_data;
 	struct device_node *node;
+
+	/* Must be last */
+	struct clk_hw_onecell_data clk_data;
 };
 
 #define VISCONTI_PLL_RATE(_rate, _dacen, _dsmen, \
-- 
2.34.1

