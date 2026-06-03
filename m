Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EA480DD7
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491627; cv=none; b=K2PbxgYpXrJjtZcT84QDRnks0GkYEaJDN5xNBQLDU5yowdbGT9lqr4R+TbrP+UqSOC2D30ZR95VC4VvPGgojiAUviLLabiXua4R4JWuFy+Na8e0EHT8cWDWCuf/Gh8mj4JUpGEGwjWDsRK56NJw0zL746SqHokl4fLRsojuK/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491627; c=relaxed/simple;
	bh=APjGOr4rSujMx24P1jDIzhjkfbHKcFK80a9vPvVqD0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldrp/4vjx3t0MPNsA+akGFUg4XMzHOTOWluQUvtBAqUpYrG0k3/nCupSPL/e35AZyquUCrF02TtYOv2/aJzVoChX9fOIQhM0DCDuB93gquXuoQUgcS4GYTY0byVin4IyAENAche16eKBRUVAJNzi5VB/3DmAaxT1gaSFyKmMqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H60+FdSI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H60+FdSI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso27457435e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jun 2026 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780491622; x=1781096422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9xxE0a97UY7UPF7zz4jpUqke1DXutWR5PtyvwLwWtU=;
        b=H60+FdSIK0d3TQlXZqVLUkCtY/lctO0prfhYmP1S8D56KoexvFUQ6TKkoHr1o6uobv
         yECXpi74UwlsqROZbEacxQhfzQwScY8w5fiWTvPfV/N157MKzYsVsqExV6yFU/cbU4xY
         P6vhnrXVtLLBwJrrObutvjy2IYNcbWCXafLBpYrsDt+8tLetgVOL94dE2OZgr9ChJeMC
         UD4awGN1HEyKo6T7kVyjZCOEccZW+CahRv43up+sZWOkpw1B3MWFvEeJ4eos3x3blkai
         4bsk2fq+nEPIilwRowP1meKxZkqrCr4eY5DLLXewDRmmUukz69mUhKmJ0JSrfGf1DWjh
         PWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491622; x=1781096422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9xxE0a97UY7UPF7zz4jpUqke1DXutWR5PtyvwLwWtU=;
        b=qfFfkHLBamG5MM5WvUAbkvMGQSzexxB4vbaTeBvapWykmT1hSwbY87NVd3maWGGEoZ
         3HHozNgiLWK+18YZfkjzavAcSgRbrKhGYgF27WvI4zDvAOcw6Zo0olNLpkpU8TFHpUS4
         tRVocNSVy6FijdhuERtJ3up4YvSOLQMWlq6lyCOVO2wlQHfyOx0vHfLDFmwzomS73uuN
         b2lhFVUPUJv70CZXCBVhLgKUWEGaUm81D0XihtoGbeaVpDGJvOnDFqEo6X1GiYbjz8Xg
         DMrR+tgLT0gLfzGP8T0ayG3p8cb6+SmB1E6Ngk0sg9vfEVYgWTgDYPj2IJS/aH8CbBhc
         xueA==
X-Forwarded-Encrypted: i=1; AFNElJ8JteqFFdz9cllsC7UXnKTSlWaQmg9wa7h6/YsvdQCbIKUh5vfdTrJt+/yndKzyUAHQ/Tu/E8All5lfRC43CnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTYlJEMQmNedTMeTBf6ULAKsR2udpsus6ZpY3HghIJIB3Zh1H
	q4TsWoa0kIAAfrlACYGvPMcCmv7f41HklsFeodUriaUp89g0WAvI5x6R6xu8QiuVOGU=
X-Gm-Gg: Acq92OFqC3Drpn8K5wfoGJffYv6sSKJDv8yS+L7ok2hThBQPSII44UTzV6uV+V0acwd
	7evDYTdki3j9zB6OfiWzkwYk2v/N4AdC+pb87YcMPykPkwbE0U3KQyj9Y3wjY9yzd0X3k5v69Fc
	IeqAKmysq/Xa8pYaLUW1M0A8NcsXYCSiYfpANypu03VvgvLaKsaO47teH6tOdtYQICcLOXf+ngf
	ZO4uNAP1Y/lr3OCVYGf6vhtXg1AYgD8znF0rdk7frDKZg4tD1weE82w/FoGodAcp/nOo11j+jGn
	2I2chw355L+r23pmuP3TPhjWVBn6pr2ys9DdjbnVYy50l2551hHSZAG5OhOlTXpo6f+6zbvD1vf
	sebaDbt2oKXXOtL38Aw3IYFRI4P5pg7EuzKR4IbSDygMTIsKV3isCy03B6xiny3QC8s4RdceSlT
	Q6NOB07X2JtsYUOYDn65rW5RtmLFYa+PC8aG0qLE8uRuR1Yt5tmmKmIkEgm9g63AQTDyKIZXkQf
	wNQREzrG3rBtTc=
X-Received: by 2002:a05:600c:c174:b0:490:b2a6:8c2b with SMTP id 5b1f17b1804b1-490b5eb82b2mr55987505e9.10.1780491621605;
        Wed, 03 Jun 2026 06:00:21 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm149179045e9.14.2026.06.03.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:00:21 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Jun 2026 13:00:20 +0000
Subject: [PATCH v8 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-acpm-tmu-v8-5-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780491617; l=795;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=APjGOr4rSujMx24P1jDIzhjkfbHKcFK80a9vPvVqD0g=;
 b=gCX5AtDDJC3f+OxPmw3TNwWEn5IdXUI49obuY03uhwbjrXH3wrFPl2PrGLvyeK9L/I5KQ6xVA
 Fe+1lxEnh5cAHVbF9vZx+6xjJo7WU3pRmhyDsfkcxOP/ZiYgCxjet3d
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs (like Google GS101), used on pixel phones.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d905a0777f93..3fe76a4c2633 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -793,6 +793,7 @@ CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_EXYNOS_ACPM_THERMAL=m
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_GENERIC_ADC_THERMAL=m

-- 
2.54.0.1013.g208068f2d8-goog

