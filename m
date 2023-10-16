Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAC381D8
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub0BOQHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94CDC433C7;
	Mon, 16 Oct 2023 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697493980;
	bh=D7fdEpe0zShD1pFuLK68iJJXBS2qGwVgntab6FWqrjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ub0BOQHxbWbUL85k9CgeLDCVNKg+n4jXSewv2gYqW1hfR3aBKTBygdAWyh75PAjOW
	 jxg8DoU0PVbfCtkElQZVFZhb+qZ0dHh/NM3NNWXtsgMFMEDTQvpiiaSWoqczCfTNNv
	 KWG92ncXKedXiJKitRh4LxKowpJicMN50Gik79sg4/ZLAnuVbCymw+Npe8nTmRE4rF
	 QQ68eBToPSHUGgVEMlMFAimZYnXuF9hQ+U2O5FMrPuoVmUK5IV4MqHayLzhJF6L4qf
	 tXNXSQJriezup5YH64Mfc7OMl+GsOyUjow+VZIAUKCoVJ6PRPrqb8IjJKPcZ2Khqde
	 GtamlmfPp70ug==
Date: Mon, 16 Oct 2023 16:06:16 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2][next] clk: visconti: Add bounds-checking coverage for
 struct visconti_pll_provider
Message-ID: <e3189f3e40e8723b6d794fb2260e2e9ab6b960bd.1697492890.git.gustavoars@kernel.org>
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

In order to gain the bounds-checking coverage that __counted_by provides
to flexible-array members at run-time via CONFIG_UBSAN_BOUNDS (for array
indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions),
we must make sure that the counter member, in this particular case `num`,
is updated before the first access to the flex-array member, in this
particular case array `hws`. See below:

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
case in `struct visconti_pll_provider`:

drivers/clk/visconti/pll.h:
 16 struct visconti_pll_provider {
 17         void __iomem *reg_base;
 18         struct device_node *node;
 19
 20         /* Must be last */
 21         struct clk_hw_onecell_data clk_data;
 22 };

Hence, we need to move the assignments to `ctx->clk_data.num` after
allocation for `struct visconti_pll_provider` and before accessing the
flexible array `ctx->clk_data.hws`. And, as assignments for all members
in `struct visconti_pll_provider` are originally adjacent to each other,
relocate all assignments together, so we don't split up
`ctx->clk_data.hws = nr_plls` from the rest. :)

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - None.

v1:
 - Link: https://lore.kernel.org/linux-hardening/675633f7ae9893371d35b238f06fd02a3acffebb.1697076650.git.gustavoars@kernel.org/

 drivers/clk/visconti/pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 1f3234f22667..e9cd80e085dc 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -329,12 +329,12 @@ struct visconti_pll_provider * __init visconti_init_pll(struct device_node *np,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < nr_plls; ++i)
-		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
 	ctx->node = np;
 	ctx->reg_base = base;
 	ctx->clk_data.num = nr_plls;
 
+	for (i = 0; i < nr_plls; ++i)
+		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
 	return ctx;
 }
-- 
2.34.1

