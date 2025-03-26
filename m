Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0921D934D
	for <linux-hardening@vger.kernel.org>; Wed, 26 Mar 2025 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990887; cv=none; b=U0lNge4LXvsfYFuh1uGvenfVRmHUcX8UTJRGTz8J3QN7acEKJPyWJ/pIqJlFvolJQh2G657etXOfSDr5xZ0zUz7npE7J0sXlUp//AhCSpUh0c5K5sjWFlpdZswrb0Wd1WZPneqehraGfFSFE/eiRUrjmc6FWbm2gKyKL889JmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990887; c=relaxed/simple;
	bh=jjnSTG3I90Mn5Ca9Xyv++q9P6Z4yvrzjERBIMNIYWYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DppvbJZWIwbWz1xi0zxxFHlt9PC3E0uTPagM1EBZT+NOopyMzRVXa6FaPbdzrEQE0kLjahtrEBhvL/IqmCiadXggt3dk1iHK+l26WUybOaa34bfS+awtf/KxvahwX6Sq23Z2ADEo8KRcp/xYKztuxDUwwchWj7STIUAl6nmDF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7mlnSxa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7mlnSxa"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abec8b750ebso1220656966b.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Mar 2025 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742990882; x=1743595682; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EOvw4ltGt39X6cSYI+P/xxRhDM+qmj120OFm+7gNRo=;
        b=b7mlnSxacG68Yn+Zs3UdGrkbG3EXspdbFsoFxpILRuE109HxFjaaUvjlDsZAPvZpxL
         9yPtCF7AITdD3DEwz/V08f+7QVex/xwXrbN7mf5yIQRz2ILabI+EFPJ7ZXw+++XQpzVw
         x0j4jVH4jxQQH0JwvRNf+NBEwvPd/hmGVNKs7NAjrgPNgjiGFOQf/FLpIb2GBl6wwbru
         e+yEzpPdjaprSk8pYbGFAv84sAPlO1w3zplKw9RKD/UGQFoN6TtNWlEevvFBobitftDU
         WcYW/O7/kmT9qr52UQvHyc2ELtssW7XNZCBSWTbFWkTm8K+Kc8i53BBZjyDsNBiEzlcp
         g1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990882; x=1743595682;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EOvw4ltGt39X6cSYI+P/xxRhDM+qmj120OFm+7gNRo=;
        b=XlOsLHbdgxgKGTRj56ZGhzbyj6M9WDyCjrqdaFmu+4srJzP6H+S4plaoIEPc/1fj7e
         ns03qJTmT2IK0RROK4pteU1mYQZhno2x96XcSz7EJBWMrgaT+dT7KPW7kWWHdjM2yB8O
         SriGVBi4kdYlq4vqFtixw1D/t21rn+jKJNxdZ+rWY0e5bEX9VqI4PHDMl4JfgH+sB1Sc
         kwULPyptbzYBO1Qt3Mr0fGEAnIES59sE0r17e891TA5D88NYxwZX8B40e5mb7CNFAlki
         zMaqFKHxQgYCC3gErlkh0MXcXuNUN0sMBdCkAigDXhhSvlJ4xgda2dTj5xuxqiqe9f1Z
         M3zg==
X-Forwarded-Encrypted: i=1; AJvYcCWwcSWOUa7dZYiS4uhINHbgQffGgafBzqQ2PlvMxz25GB+IZ8O5M7y0Wm/FNazPrQD+n5ttsN+KlkrApyncvLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68v/+fSItltNtHn94efhHFKAlbGE+qnKPe6sKV2ar4lEo43sh
	MO9RzMGIBOmJebV579r/10/Vt1Rg0E2qRLYaOOsmdIg94OCb9GFmd04wNBxe+1k=
X-Gm-Gg: ASbGncvBBp8MUze1MZyWSuwGvRg2ZsLhAueNYFX8/uiSSIrSDfBwEBr6+7tqcE2gMX8
	qervSMv9aHaNtJsDnYcnlqk+qYMMDsKZxGhJ3KrfgR4zr/ndru8W1ayXIilSGt8gEKutdwMfPd8
	LH9gSWS396gWVwf1El++IlDUUF8Sb+HX1UprolGPr3yRp3bHYh28LI9mZcv7eguIaOKTG/R2pek
	24MtWiiWRWT/Sjy9fJKURzb3YG4VaVKtRY6JZQUkkX1/2f3SwXfbYyj6elopni7gYWMEEHe2e8s
	AhjEHhc/55VTcC2dM26njOA64VfY9Poso/WCQ3RRRoy6VHeCi/PWq14pg6q0kRMFqi3hV4yEmdh
	zuNvDimpZPVNcdrx6WUX7jcFWq0qJr5CcrGU/bZs=
X-Google-Smtp-Source: AGHT+IFpDQ47OkR0lnhRuhDWvB2zczsji7a4MYoKTE4Oj7Ls7vmFXhE9PL8k1vAEh0QTa7oPWlII7w==
X-Received: by 2002:a17:907:9694:b0:ac4:5ff:cef6 with SMTP id a640c23a62f3a-ac405ffd0f5mr1438770566b.31.1742990881985;
        Wed, 26 Mar 2025 05:08:01 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6ef561e4csm59334466b.119.2025.03.26.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:08:01 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Mar 2025 12:08:00 +0000
Subject: [PATCH] clk: s2mps11: initialise clk_hw_onecell_data::num before
 accessing ::hws[] in probe()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-s2mps11-ubsan-v1-1-fcc6fce5c8a9@linaro.org>
X-B4-Tracking: v=1; b=H4sIACDu42cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMz3WKj3IJiQ0Pd0qTixDzdZEsDS3OLVPOkZAMTJaCegqLUtMwKsHn
 RsbW1AHqshmBfAAAA
X-Change-ID: 20250326-s2mps11-ubsan-c90978e7bc04
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-hardening@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

With UBSAN enabled, we're getting the following trace:

    UBSAN: array-index-out-of-bounds in .../drivers/clk/clk-s2mps11.c:186:3
    index 0 is out of range for type 'struct clk_hw *[] __counted_by(num)' (aka 'struct clk_hw *[]')

This is because commit f316cdff8d67 ("clk: Annotate struct
clk_hw_onecell_data with __counted_by") annotated the hws member of
that struct with __counted_by, which informs the bounds sanitizer about
the number of elements in hws, so that it can warn when hws is accessed
out of bounds.

As noted in that change, the __counted_by member must be initialised
with the number of elements before the first array access happens,
otherwise there will be a warning from each access prior to the
initialisation because the number of elements is zero. This occurs in
s2mps11_clk_probe() due to ::num being assigned after ::hws access.

Move the assignment to satisfy the requirement of assign-before-access.

Cc: stable@vger.kernel.org
Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/clk-s2mps11.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 014db6386624071e173b5b940466301d2596400a..8ddf3a9a53dfd5bb52a05a3e02788a357ea77ad3 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -137,6 +137,8 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->num = S2MPS11_CLKS_NUM;
+
 	switch (hwid) {
 	case S2MPS11X:
 		s2mps11_reg = S2MPS11_REG_RTC_CTRL;
@@ -186,7 +188,6 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		clk_data->hws[i] = &s2mps11_clks[i].hw;
 	}
 
-	clk_data->num = S2MPS11_CLKS_NUM;
 	of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
 			       clk_data);
 

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250326-s2mps11-ubsan-c90978e7bc04

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

