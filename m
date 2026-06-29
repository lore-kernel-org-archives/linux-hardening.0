Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9437F727
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703548; cv=none; b=Ekim/4QrQKNPBt6kkB+ZvccFpJZTk7gZYFmQaNFX4xtNlwdNMfi8fv6f33VfE4Rs80FA5nw6gFyUC07cSb7hM6wBVc2SJZ69c8Gr90UQlZdgspiuboB7wAWyYGPxdDNFUj9DASSbxVddOtUefAOWM3rvimF46d98/U81PUA2vOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703548; c=relaxed/simple;
	bh=JXP8l6SZOlYJ3RZ86oWzg8ag9M+Lc2vnpFBpDW52rRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ixd1T6pJH47LUco5qLqFY5Fwc6soIWnFGucKN+mOHb5gUwHCcdubxTxZGcdZxY/B6CP1thmxJkKQ5bU06N144ZNgStMbLitvcaKnHjgS0Z8go5Vg5swAksdsduxxrMATEttDLAy4u8ABlmiW8oRDyf+/v2Rs3tUrqw4ioDnSdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjfTpbM2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjfTpbM2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847921eed4aso37461b3a.3
        for <linux-hardening@vger.kernel.org>; Sun, 28 Jun 2026 20:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782703546; x=1783308346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3IG9Yp6Pjl+c9PKNtEae4TwSgGvYdWevGerwBQ6zPI=;
        b=ZjfTpbM2M/CUQT/bbrx7V6a1X5PgPt8xFgCQDbW5ZV7ZgqH3EeX79H+yG9KbBvqZ3u
         FosDl0qkUuQlVsSrcZs2fscAIW6JnFAdYVxItTR3OIu8AfIdHuLHF9w3fFbBnBlR+Gbo
         4lPFV2yRBl4vpfOqaEtJx6eSaFoLNhCOaV4AKYlaQ+8JwlIs9CS8c6m2dt5G5aRPvSoT
         wcpQBPI3wx1uLBXmd4lu2N5df+tgrtIfGOedOKbTMhHf0emlN9WjQzLpOOp7yV+R4IJc
         EKCUhr8gLxBOAzLiMGnFzYxx6fr3lwPhRpxDEviw3eePlV2snmT3oiCaBE/OqtYwie5l
         yCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782703546; x=1783308346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3IG9Yp6Pjl+c9PKNtEae4TwSgGvYdWevGerwBQ6zPI=;
        b=oepByP7DXdp27hr15kbMiVokY9VD/l1ctoYTrD7LvAgXj3JA0Rh7ftmEdCFhT+FPDs
         VWoUiMA0ct2+juuz21CVKmj5JHuVOIAzUnuO7E9Xbe1cXLVtzaRqlPSXx6Ss8MFe4DzA
         JVHwfobdrzSPIT/tomIO7wH/LgIU/kXABQuZSMi93uwUfjWFPWFCnuAnGEZrpWNEp34C
         RYYXxZIuioM702lu+6jxaY6NwSIuYxumo38eJ2zgtBtdxY5VwupRr6d+lVIwDp5aXwYf
         g9AybMzr3kT3UHu5pf4TWAhRbWyqfZCkJer2WrXY4JVb6ltKLZw25e3bDAuAQxlE6GYD
         vqaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/g3SUNm0VtN3XOUCpPb90ogCpvGbeGm3R6h0BX4RHrKNDOZ9+RWkO9Y494xFxjddbBrUDPmqPfT1dHnXvVd+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzydl9kDp39HxQGnkwcy23hqV5AUD4or2Uf90zWbVCGuID9TdqF
	nhYJsDj9vlc87SCUY1YeJf9NeCEmDrwHLiwbM/WJYXaELr6FglAexU2v
X-Gm-Gg: AfdE7cknhOiju01jJK84fnNwYK7kT1tqUPY10wEuoV864oBa/Jxf8LFyNL057fW07j+
	HLk3WVALTM7MYxTFDBLElXCoMaKboPiRiXAGuJqrNt/JodN3vI+k5OJZSzKdyK8grNn1rQb5mwF
	br3HB5qi/0G4OEuH2lXao7qhbYOTx88CmCglgY303JQYG+x9RfS5coPWptTPjwniD3C3ZXqdwp/
	wRWa5vcbKhrtcSMBHXCalehx9/JctfRTlp8PDuCI0bio48Scy2ySGko9/madY+tD97D4xAA50nG
	bF3j0j6Q3K+yj7NPOMHv3vq0+9W0rsSW9wnTLnLzyekwDaDO3alPSCWdYb4FNGmXENx9iJBm9jC
	qlGAEBdQsMSQP8ZCE1jMQFXiYFGW3HuA8XsuvcW0T9BgssOB6fQij75ugYXqyYqVNeb2xS9DUM0
	kzfth+3Zc1q0kwzdRRkTQGcsUb5ETGPgH61sRD87WNJuFWyVNALvrLrDDlQkubRWjMdBHpMWNGk
	OflstNb+Q==
X-Received: by 2002:a05:6a00:ad06:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-845b3b89881mr15596736b3a.38.1782703546147;
        Sun, 28 Jun 2026 20:25:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-846c7f659ddsm1921771b3a.32.2026.06.28.20.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 20:25:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SOC CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 2/3] clk: samsung: cpu: use kzalloc_flex
Date: Sun, 28 Jun 2026 20:25:39 -0700
Message-ID: <20260629032540.2331559-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629032540.2331559-1-rosenp@gmail.com>
References: <20260629032540.2331559-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

As kmemdup_array is really kcalloc + memcpy and kzalloc_flex kzalloc +
kcalloc, kzalloc and kcalloc combine leaving the memcpy.

Add __counted_by for extra runtime analysis. Remove fake const num_cfgs.
It needs to be assigned for __counted_by to work.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/samsung/clk-cpu.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index ffc33e5decf5..37cf47533dc6 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -101,11 +101,11 @@ struct exynos_cpuclk {
 	const struct clk_hw			*alt_parent;
 	void __iomem				*base;
 	spinlock_t				*lock;
-	const struct exynos_cpuclk_cfg_data	*cfg;
-	const unsigned long			num_cfgs;
+	unsigned long				num_cfgs;
 	struct notifier_block			clk_nb;
 	unsigned long				flags;
 	const struct exynos_cpuclk_chip		*chip;
+	struct exynos_cpuclk_cfg_data		cfg[] __counted_by(num_cfgs);
 };
 
 /* ---- Common code --------------------------------------------------------- */
@@ -660,10 +660,6 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 		return -EINVAL;
 	}
 
-	cpuclk = kzalloc_obj(*cpuclk);
-	if (!cpuclk)
-		return -ENOMEM;
-
 	parent_name = clk_hw_get_name(parent);
 
 	init.name = clk_data->name;
@@ -672,6 +668,17 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	init.num_parents = 1;
 	init.ops = &exynos_cpuclk_clk_ops;
 
+	/* Find count of configuration rates in cfg */
+	for (num_cfgs = 0; clk_data->cfg[num_cfgs].prate != 0; )
+		num_cfgs++;
+
+	cpuclk = kzalloc_flex(*cpuclk, cfg, num_cfgs);
+	if (!cpuclk)
+		return -ENOMEM;
+
+	cpuclk->num_cfgs = num_cfgs;
+
+	memcpy(cpuclk->cfg, clk_data->cfg, num_cfgs * sizeof(*cpuclk->cfg));
 	cpuclk->alt_parent = alt_parent;
 	cpuclk->hw.init = &init;
 	cpuclk->base = ctx->reg_base + clk_data->offset;
@@ -687,29 +694,16 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 		goto free_cpuclk;
 	}
 
-	/* Find count of configuration rates in cfg */
-	for (num_cfgs = 0; clk_data->cfg[num_cfgs].prate != 0; )
-		num_cfgs++;
-
-	cpuclk->cfg = kmemdup_array(clk_data->cfg, num_cfgs, sizeof(*cpuclk->cfg),
-				    GFP_KERNEL);
-	if (!cpuclk->cfg) {
-		ret = -ENOMEM;
-		goto unregister_clk_nb;
-	}
-
 	ret = clk_hw_register(NULL, &cpuclk->hw);
 	if (ret) {
 		pr_err("%s: could not register cpuclk %s\n", __func__,
 		       clk_data->name);
-		goto free_cpuclk_data;
+		goto unregister_clk_nb;
 	}
 
 	samsung_clk_add_lookup(ctx, &cpuclk->hw, clk_data->id);
 	return 0;
 
-free_cpuclk_data:
-	kfree(cpuclk->cfg);
 unregister_clk_nb:
 	clk_notifier_unregister(parent->clk, &cpuclk->clk_nb);
 free_cpuclk:
-- 
2.54.0

