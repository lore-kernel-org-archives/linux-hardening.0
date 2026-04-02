Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617A3542D1
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099095; cv=none; b=WMhLHfx3iAhKTcNUCBWKBsLDPQZTHq1K3k/7ojzJpUvQ6s8F3JeTU3+n+aOn2WNqnxxn8yqnEC6cfJfIOZeLJPlaqRNMmaYI0bP3L6sUk+zx/ZHHZmXyyEeahRNOMSXlp/AHJk33YLJ9QgzUGhPKP5jhacfh1LWdmbqEmm8R8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099095; c=relaxed/simple;
	bh=uNa3V+l2+zMvQBRPMDJlv1PjVBSkIBsWCPDk3WYqUHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6/Zj0A3LRhsKRimd4V1GAZNvRB6mXPzJqBqJLYiIgLSX0RqX4XNJmpyM9ImpHGNHU4ufHzT5ifYU97XMVzXYOTGmrQ+up3z2UHHDONreF7GQwYU7rxSKCimEkF9W5P7QyC7PHHmZ3LHQhEGEaPmcbht6jj12gKKWOFVmfHh/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYhBndW9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYhBndW9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso214029a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775099093; x=1775703893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0ucHKBOty4mZVVfHvLn6hix9SbADzLEqJq1CauEJu4=;
        b=OYhBndW9zZGJBS2rebGgm5kyBN4rBegW/DNCCcbc4jDOK2sybbphlOY05o1fYyw1jI
         HVYdyX4tvuMgqMNFtWs/ZEX9hdH4rW5kVxaJQjQ1nDsZJ6I2qUKYF3RCxRwD29KNCcnM
         6HJWbmwZxG6wLpjzuP38mzBh8CS5ue5wT29jSXkR/7I0tRbuwL7lUmAQeCj4OeE5KeB2
         b97GuwYhGk7ctDmaRQFkSHSw0UI37zuk9VVTrouLZaYIXqKwcKlvcdXFCx7pdWZa5P7S
         7LAX022qqD9oecqSDREzy7tREFl1IC1RwsAFjHACxLsvURGSxOb7m409v+LBE+WYFKA2
         +L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775099093; x=1775703893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0ucHKBOty4mZVVfHvLn6hix9SbADzLEqJq1CauEJu4=;
        b=lk0AwJZNcahBE5c8uwmhjpYI9CMaTHSCvfg5OHjNBJv1qncoN0IWvlMpzMVmgi9AuL
         AshAmwdNJWoYAsf/uIwjGygKL7JjB091x1QMwHIHXQ4gnS4Tj22+nlqkpSx21bGXgoGC
         jwo/IMF0g/UghFOSqqlWr1yhII8BYGkV6icX2MV3DxwVD0FN1uXtrpdQ7sdF1qSHTxa+
         2PveTiJY/RizxqWW1M1joLSq8SVF9dY9A5zALqbDHhXnlgaMtPPu9gVmsaqzofl6eOZq
         Q23yJEa5jJjmZdLBZNatyO9zYBjTx+xQ8yAxugV1ZH/ZdXtRR5hVb19PyBsu/UYo8fI2
         mhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW++sEHWCqHJLdvih8H7jj22Nlm85LzYs/bOYAeq3MjtAO6NZNAusSx5hQowqsMFzrw/o9tOwwfF6iuy0TXgtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9rLb50Zi5Tk+RNwW3lXEEHOvisTwt6ngJ91IzU/ERYGX7PU3
	NYq88j6516azIC93a9ZI0lelnyI2T/AA7+3WdlKy1c/bsNFS9aM21DZV
X-Gm-Gg: ATEYQzzmL+ls3MMY+KlJcrBtDdCGiuT7By0zb/RtK9nUzL4d8C0ZSl5Step6JeGUlZ4
	huggXe3XCOr9u5A2w+PBCTqvP040Me9Nfh4XmGeJcI/2z+4iZWzU2ulVFvAH2uHKn9SmlOImUrh
	kknTz0p4vsD5yfTA1L123NPybDGzLuAEyp2qylp6pHnj/pDQiVAUvD24xXR1fxaDqQrR85yc2oE
	GafW4M2qkFyuDWzJOpJEvqtLqGVpVdFGus1ptDa70fjIAtHvkwOOy+fbXrraRkEOVtIhnyRFkcC
	23rIhUaRvFA2nbC5c07ZNHzQi6TwV9xL0cH7+hOY4ZbIsRaHUJ2tt/wVe+OwC/S514OBQrtzz57
	GOIADMkBcX8zmYMF7QaHyFpDWGkSeJM7q0ciivg2uMF6QiyBcl7bY0eqt+mbskUFqEfADoNsBdu
	uJEnmZQKPPemqr+OpWzzIvjsseE/P+dpDnIEhT4UX1xG9w2tryj5ztvWI=
X-Received: by 2002:a17:90b:2ecb:b0:35d:9482:2233 with SMTP id 98e67ed59e1d1-35dc6fc83b5mr5204534a91.24.1775099092867;
        Wed, 01 Apr 2026 20:04:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9379f3sm6395873a91.9.2026.04.01.20.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:04:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SOC CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 2/3] clk: samsung: cpu: use kzalloc_flex
Date: Wed,  1 Apr 2026 20:04:31 -0700
Message-ID: <20260402030432.101066-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402030432.101066-1-rosenp@gmail.com>
References: <20260402030432.101066-1-rosenp@gmail.com>
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

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/samsung/clk-cpu.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index ffc33e5decf5..ad08d6288baa 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -101,11 +101,11 @@ struct exynos_cpuclk {
 	const struct clk_hw			*alt_parent;
 	void __iomem				*base;
 	spinlock_t				*lock;
-	const struct exynos_cpuclk_cfg_data	*cfg;
 	const unsigned long			num_cfgs;
 	struct notifier_block			clk_nb;
 	unsigned long				flags;
 	const struct exynos_cpuclk_chip		*chip;
+	struct exynos_cpuclk_cfg_data		cfg[];
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
@@ -672,6 +668,15 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
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
+	memcpy(cpuclk->cfg, clk_data->cfg, num_cfgs * sizeof(*cpuclk->cfg));
 	cpuclk->alt_parent = alt_parent;
 	cpuclk->hw.init = &init;
 	cpuclk->base = ctx->reg_base + clk_data->offset;
@@ -687,29 +692,16 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
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
2.53.0

