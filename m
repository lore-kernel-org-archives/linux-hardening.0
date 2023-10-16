Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82550381D8
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iulmUHub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C52C433C7;
	Mon, 16 Oct 2023 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697494076;
	bh=TW3IndpO2zBuBRlfI7R6Lfn0TK8diqp9tO2D/L4BKPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iulmUHubMW2dW1FIERm2jLQStEyM4rbu4ppCVqE7kAhhg0L9qIWrI1mEVmoF+j0iz
	 YlBH8SYs4++4CQ2ZoJuQYfejRUuS7kYKBkkms38l/AY0Ki0cgXe+iTn9tn6/AiDS98
	 /vp0RYVN/fNRXEEEmpuwm2BJTGO/31RmRPnnTC9wyeLS675dg60PuBAdaF1E0kSCJU
	 B4n9moXIe+xpzZkvIfNhgm86tX/QQCLIokQdbq2OmO54pytW9Y07x24x8bYvqnoCRJ
	 KKhebXPwiotrbX+nGURsnWG/fSBEmS90yIUjF4RDovUVBoCrtfPOUZydgMtk/kYjWo
	 QT+RDxLr7lZDg==
Date: Mon, 16 Oct 2023 16:07:52 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2][next] clk: socfpga: agilex: Add bounds-checking
 coverage for struct stratix10_clock_data
Message-ID: <f531ae35ef434b62f48534c67ad3b1013bff0536.1697493574.git.gustavoars@kernel.org>
References: <cover.1697493574.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697493574.git.gustavoars@kernel.org>

In order to gain the bounds-checking coverage that __counted_by provides
to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
we must make sure that the counter member, in this case `num`, is updated
before the first access to the flex-array member, in this case array `hws`.

commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") introduced `__counted_by` for `struct clk_hw_onecell_data`
together with changes to relocate some of assignments of counter `num`
before `hws` is accessed:

include/linux/clk-provider.h:
1380 struct clk_hw_onecell_data {
1381         unsigned int num;
1382         struct clk_hw *hws[] __counted_by(num);
1383 };

However, this structure is used as a member in other structs, in this
case in `struct sstratix10_clock_data`:

drivers/clk/socfpga/stratix10-clk.h:
  9 struct stratix10_clock_data {
 10         void __iomem            *base;
 11
 12         /* Must be last */
 13         struct clk_hw_onecell_data      clk_data;
 14 };

Hence, we need to move the assignments to `clk_data->clk_data.num` after
allocations for `struct stratix10_clock_data` and before accessing the
flexible array `clk_data->clk_data.hws`. And, as assignments for both
`clk_data->clk_data.num` and `clk_data->base` are originally adjacent to
each other, relocate both assignments together.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - None. 

v1:
 - Link: https://lore.kernel.org/linux-hardening/fd4cd8503316d536e1a84fa2ae5bdefdd4b24afe.1697059539.git.gustavoars@kernel.org/

 drivers/clk/socfpga/clk-agilex.c | 12 ++++++------
 drivers/clk/socfpga/clk-s10.c    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 6b65a74aefa6..8dd94f64756b 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -471,12 +471,12 @@ static int agilex_clkmgr_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->clk_data.num = num_clks;
+	clk_data->base = base;
+
 	for (i = 0; i < num_clks; i++)
 		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
-	clk_data->base = base;
-	clk_data->clk_data.num = num_clks;
-
 	agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
 	agilex_clk_register_c_perip(agilex_main_perip_c_clks,
@@ -511,12 +511,12 @@ static int n5x_clkmgr_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	clk_data->base = base;
 	clk_data->clk_data.num = num_clks;
 
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	n5x_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
 
 	n5x_clk_register_c_perip(n5x_main_perip_c_clks,
diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 3752bd9c103c..b4bf4e2d38e1 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -402,12 +402,12 @@ static int s10_clkmgr_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	clk_data->base = base;
 	clk_data->clk_data.num = num_clks;
 
+	for (i = 0; i < num_clks; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
 
 	s10_clk_register_c_perip(s10_main_perip_c_clks,
-- 
2.34.1

