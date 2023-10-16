Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B2347AA
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0fXqiC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B055DC433C8;
	Mon, 16 Oct 2023 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697493932;
	bh=yehbNpyhrwY+5OKnAwXS4+SAIG7u6g3BmUMck9Il2jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0fXqiC/U/SkvoRP9HJgm0THGVBbiF6IhO5dpFY+zdoiIe/ZBAvJpbXJvU6lUGJir
	 NuT9fgiYBvwwFQu2nAXYUWoIMeFe6A4M34JYdACEEgi1zJmHnfW6PhJESPRHgE/5B7
	 R6h41oq7jkuwITcR03Dk4Al1fMznT61PSovToKBbclkM7RLbfXcLi7sLlAEKgFvD2a
	 7Lnyy7jLPUkkW+sqopflFD59dZ1gSkWFs/dIsgBjlXdRCArOCIpAWMTsv/St6lqH+A
	 nDgn2KuKu4WOPRNGhjJNI+fFK2N96j/YW2kWDVQep6tWqGAuVHoevDH0N7FzvPzo45
	 FVt3PX1jkyPrQ==
Date: Mon, 16 Oct 2023 16:05:27 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2][next] clk: visconti: Fix undefined behavior bug in
 struct visconti_pll_provider
Message-ID: <57a831d94ee2b3889b11525d4ad500356f89576f.1697492890.git.gustavoars@kernel.org>
References: <cover.1697492890.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697492890.git.gustavoars@kernel.org>

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

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
Cc: stable@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/0a59a721d54b557076cc94eabeb694d463773204.1697076650.git.gustavoars@kernel.org/ 

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

