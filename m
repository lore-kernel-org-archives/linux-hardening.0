Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DC38E10A
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400245; cv=none; b=Bsgzx7SaJUaSboLLghHvDiMkMi8J7dpP0mF+nFDO9w2NVOt2DhJfSdw1iu1RqdkdpkdPVmu4di8A3EXx3bnvJpBCDkgTgLtR+sJqPZsTOjTy3OnMIlGvg5IW679aSkuDD7onI2tibkoWdyLyAW56hHFotqrp9v8F61BfZZJ/Y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400245; c=relaxed/simple;
	bh=4R2WX+ZJeXKAug4HVmP5YDimNXbTtbG2dMJBRwWnt8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofRxEfqS0PeSRyNXMevbUTJb/qE3XPRaGEOI3oSgVrIQhjZq7TBu8Hmyxsxx+JsQaAuna6QtEtbZRE6wwgWoL6XGV07JBdzUegN0MTlvLHjOWTozHoRYWAsKUKWOMzFYnm5HFGGxzgSBDGdPGZkdkIIgpkge5fE0B9uaAu7r7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDRj4jUg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDRj4jUg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso80655225e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400239; x=1769005039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYwhWQ9zZMnOKXaK1vSooK2Sr4WO9byJT6zo9omkZXo=;
        b=QDRj4jUgvMVjRvDUcaq3w2qIBMSbU3mMssLg+u3J9bnrzVBrrpWuge5W//ECWGgoPW
         G3fRuzXdDFenttMAvHUnp6aUVLwQo97GWTqaUdYcbLSB4Qd+Ku4MKvvPs8CJ30547Gxh
         xtPjOdIcyERGC7GHH7C9szZHtFgxVR8e1HKcr1hpEHIfE5nFM4URNjBC226sQjjuud/z
         jHRSdt4ty4tyjJbd3hoya101CFojKcL4GNFqPHo6i6HAU/v/5Od+Y57fJJquf9AhRGFi
         snrWQ3GBgvVzlGDbNCXCsbT3B0oLf2qWFwQt6UJx6/3PjwfSheWN5hEq0833aT4UpCt1
         0LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400239; x=1769005039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYwhWQ9zZMnOKXaK1vSooK2Sr4WO9byJT6zo9omkZXo=;
        b=Gy6f9XwgbGG/bpuYyjZkqzEbkVu5OiGcsto2uHPpFKP3GV3mwF6t7ZgOJC/WFsqn1f
         d4eFlRzDeq8MKi5GHustVFEwroIm1W0qiBk/rwADXePnmQxDJW+ZITGFj5MiDKGWFURH
         PYttJ0xMw0vFEQ+CpC2CFpAoEg5AnZjSMR9sHXAcYZjAuR2FpfL6fUjxbPBTRaA+QgjS
         uJXTGC0ER8JIfusEivpyiMZ5mePLYBM9mrImZCQxvclbC+djDCM5G5uw75lXbfyvpxBU
         SifhSSb9+q6iUTzFQrCs044kWLGn4ALP3nhyaSbGSYLy7IVNcj2PV5RZRqSlDybpuDTe
         IaXg==
X-Forwarded-Encrypted: i=1; AJvYcCVygw4IlMoiSPiZ94RUHMYHS2ylSNpkW4J6on3gHtUaTufc3wBoA2GVCAdYrl4hraLU2Bw3wf1RrFMo2PFqfBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmPm0OrAjr28uOiMbntC5UZ27S/ctwINh+TUCN6fHC9qFfzx2
	RytAuazgVI1mlIR9KAd+j+cr2Z+GUuG0cLtLJcmJr6xmFwR55ntmdFu3JedTnKZZrKM=
X-Gm-Gg: AY/fxX5ex3yHsVOxMISX2gOzkYwDzsBySInoIkifkTkHo5vTlcBTk+27ZGYQLSWPY5P
	m+8q4BEjTNYUHyCoc9DhS9rf/qjTtAc37kiPoBoOCyby3PrwIFLoFJqsnrTEjnVHC30Q/icNcpB
	aXOhnG+m8rBI4kNeo9Ddq0XHde3LFCfztx1eS6u6m2GoQsHi/7cWf9/S7zzoT3Y8YTbnd5ieAhk
	XPROT8EPSoQGH+D2LwmSZmoehGvxgYW4gRosCDzEryeWMMBv6W7kRjq/MPKYOLbX5mnlMqD05aT
	c60p+HNYGp+irCv4G9MwlM6UL4XopaSLRlSecQBy0r/2gU/2uxv94kVe9pxCps4Iq4FzuC3HG+V
	8//NJoIDu9h+O1cbh3/luB5ij0laT73BTrs9wROysvnNYcpzr8s2UrYxWHZrnyxczjcidtRaoaX
	fILPyIrry3Z1lCvlD62rFTYFWGqDwWofZ++in5haSIxEsmu0ybAqNqsRZm+EUNUm+dFUVF/Q==
X-Received: by 2002:a05:600c:35c6:b0:47d:900e:c646 with SMTP id 5b1f17b1804b1-47ee32e9818mr42733775e9.8.1768400238988;
        Wed, 14 Jan 2026 06:17:18 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:18 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 14 Jan 2026 14:16:36 +0000
Subject: [PATCH 8/8] arm64: defconfig: enable Exynos ACPM thermal support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-acpm-tmu-v1-8-cfe56d93e90f@linaro.org>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=969;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=4R2WX+ZJeXKAug4HVmP5YDimNXbTtbG2dMJBRwWnt8o=;
 b=VnsK9/fLTj9mjFXQo/4xOaDgDR3JfubzIq3NbGbuODD2OJ1c6XHTPf+LI9LbcMoZ3NCIW9wy/
 IJLw4Q7eeDiAhz67Bq9hsH5OJkql4RdLF5r4fJcduQpSKMK/g4HWwqv
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs that use the Alive Clock and Power Manager (ACPM)
protocol.

This ensures that thermal zones are properly exposed and handled on
platforms such as the GS101.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45288ec9eaf7365427d98195c48e2f8065a8bb1b..1bfe37857f51663c9d745cd575f107fef183008f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -752,6 +752,7 @@ CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_EXYNOS_ACPM_THERMAL=y
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_GENERIC_ADC_THERMAL=m

-- 
2.52.0.457.g6b5491de43-goog

