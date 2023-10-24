Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B923BB
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+irlN/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3DAC433C8;
	Tue, 24 Oct 2023 03:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698118255;
	bh=s2DIwsxOJaZ9zsr4JNYc5p8TJXF9cLRH/ZrueUMU/kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+irlN/7SvXYp9rwDXIKvQpmEp1WWku8+apGg+TVfCP465udfUJYadCRMK9AAbNoK
	 iREIT0vC+DttBAnedoilASso8OAjhgAMjaj5cj0tC4MY0xGgwqquKiuGSrbfiQGb2O
	 v5nW+j4MPmkNFTOppHzBJe+onzv/CMDhVIH0isAOZNGj7ZUKf5Ck6hZHfeI1YD/ieF
	 0MFpGg8VjcLhTNOdquKYlm5/ewuLOMx++rm7/epKbXEhjnmnKybjo0f90DLPMp3vaK
	 v5n6PGXSnr9X4DU/qqmJTkO/rHZRt/oE+xxu4GPquRjAbzcq2furfbP7edoJgAid6T
	 tm554wQKcSyww==
Date: Mon, 23 Oct 2023 21:30:52 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 1/2][next] clk: socfpga: Fix undefined behavior bug in
 struct stratix10_clock_data
Message-ID: <1da736106d8e0806aeafa6e471a13ced490eae22.1698117815.git.gustavoars@kernel.org>
References: <cover.1698117815.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698117815.git.gustavoars@kernel.org>

`struct clk_hw_onecell_data` is a flexible structure, which means that
it contains flexible-array member at the bottom, in this case array
`hws`:

include/linux/clk-provider.h:
1380 struct clk_hw_onecell_data {
1381         unsigned int num;
1382         struct clk_hw *hws[] __counted_by(num);
1383 };

This could potentially lead to an overwrite of the objects following
`clk_data` in `struct stratix10_clock_data`, in this case
`void __iomem *base;` at run-time:

drivers/clk/socfpga/stratix10-clk.h:
  9 struct stratix10_clock_data {
 10         struct clk_hw_onecell_data      clk_data;
 11         void __iomem            *base;
 12 };

There are currently three different places where memory is allocated for
`struct stratix10_clock_data`, including the flex-array `hws` in
`struct clk_hw_onecell_data`:

drivers/clk/socfpga/clk-agilex.c:
469         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
470                                 num_clks), GFP_KERNEL);

drivers/clk/socfpga/clk-agilex.c:
509         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
510                                 num_clks), GFP_KERNEL);

drivers/clk/socfpga/clk-s10.c:
400         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
401                                                  num_clks), GFP_KERNEL);

I'll use just one of them to describe the issue. See below.

Notice that a total of 440 bytes are allocated for flexible-array member
`hws` at line 469:

include/dt-bindings/clock/agilex-clock.h:
 70 #define AGILEX_NUM_CLKS	55

drivers/clk/socfpga/clk-agilex.c:
459         struct stratix10_clock_data *clk_data;
460         void __iomem *base;
...
466
467         num_clks = AGILEX_NUM_CLKS;
468
469         clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
470                                 num_clks), GFP_KERNEL);

`struct_size(clk_data, clk_data.hws, num_clks)`	above translates to
sizeof(struct stratix10_clock_data) + sizeof(struct clk_hw *) * 55 ==
16 + 8 * 55 == 16 + 440
		    ^^^
		     |
	allocated bytes for flex-array `hws`

474         for (i = 0; i < num_clks; i++)
475                 clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
476
477         clk_data->base = base;

and then some data is written into both `hws` and `base` objects.

Fix this by placing the declaration of object `clk_data` at the end of
`struct stratix10_clock_data`. Also, add a comment to make it clear
that this object must always be last in the structure.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: ba7e258425ac ("clk: socfpga: Convert to s10/agilex/n5x to use clk_hw")
Cc: stable@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - None, really. Just Cc linux-clk@vger.kernel.org this time.

Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.
 - Link: https://lore.kernel.org/linux-hardening/bb2ae50abf622d4b6fda1a326ce830627356ab7c.1697493574.git.gustavoars@kernel.org/

v1:
 - Link: https://lore.kernel.org/linux-hardening/5dd8483177dc8cd91d021170b6717f2e570bab03.1697059539.git.gustavoars@kernel.org/

 drivers/clk/socfpga/stratix10-clk.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index 75234e0783e1..83fe4eb3133c 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -7,8 +7,10 @@
 #define	__STRATIX10_CLK_H
 
 struct stratix10_clock_data {
-	struct clk_hw_onecell_data	clk_data;
 	void __iomem		*base;
+
+	/* Must be last */
+	struct clk_hw_onecell_data	clk_data;
 };
 
 struct stratix10_pll_clock {
-- 
2.34.1

