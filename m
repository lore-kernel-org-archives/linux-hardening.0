Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6534B185
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138679; cv=none; b=J0K+TXyR2ET2uvT2QrbyaGLi1xJ0+V6CCfxXFzOo7cdpL8/G41mzaPcOmx9g8AWigxUr4TkL4iG8f0hM7tAuU8sRcUjdaom9IW4Wc23awanWzDQAqTCrmKjKXL5+gOXkyCaZHqnaiKcDgfSnrS10DJar9Z8dMCadrQ6qtSb+mwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138679; c=relaxed/simple;
	bh=qcX1d63axfEm3RBwV296f+6+sRglnyR7jSQ67K8y59Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZETH+YOWPCX+cC9ZhH0ym1zO0uYgvolY4Aq8TVv6E/rP8so652jX/NhevTfskOLwVIjbYKqFlVIrinYIY0TuuUAsl8Bryx1Ob45C275nKcYpxhJQ7T7dtXneFXSmrEfTrDj1+NJMW6xc2sWOmCWDvbxaNrs6CAm+v54iMXyGHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e9bgORKN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e9bgORKN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47114a40161so26770175e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761138676; x=1761743476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibo0NSWbl5C+bQQFmoxlAmjW8oHbuGgT0ysyiGqJH04=;
        b=e9bgORKNCvinL7GOYPu8YvUoJxoTl2TGNlE3olouBYpCj8UDZYpe50mTaaEIhMsdHx
         zgAgE3bththrbsAwdyfLI42nCYipcSIdpUXNye+DOPXbqsS8LMOWKMsjvZ4Gj+VhJJuo
         AYhfr7eP2G0a3d8xVqY9rNRxIph4adv45tjOK8d1oKM/uGvs5U03N5N0VHCkhGXhe9Bw
         /S5WppusOM1yuK+QfHmYLMM6LxZlSwpThS62/jv0W4EjFWOMCQNby2fERzbU/zgMTpyn
         npJf6sU8GVvLQXK/5S4KiChq8f5o2qToi6/IiMeu1513ZoeJxkJT1bqUXuUAlipaXUsR
         Oj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138676; x=1761743476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibo0NSWbl5C+bQQFmoxlAmjW8oHbuGgT0ysyiGqJH04=;
        b=O+LZpEHh/1dcLY043iTQ4zVOygR6yI+kf46ARGt1l+SkPHulBtI8rCwKo4kLWTBfhl
         AXjjCddld+IH4ose1lPk4XaTcjIYDXTLioS+rdXannPBPPapC8GLsuVSx8ylYHH9ini3
         JkKBOv2MKSDAqDHbo4SWKa35kHNf55JW9dL8vYa0BU8iMB04CozoRC8kTT+EuTp+kM3y
         Wst6Xx8xwZsoFvtf374lDGFbkadRxqwkLpd3pPiEvAN+rehfBhXAgmPz0IM72Jo6suGP
         pi1aGjYo7NHZnlxp0b98NTs3FIHWbHqH8fbFA4dU0KxtmVHv9ujTZK6L1y2djaLWp8E4
         vj9A==
X-Gm-Message-State: AOJu0YzH1DP6QKZyvva8GYyEYNabuPhVI2yOcV2EuFpNxHFRV9396rP9
	jdRFuvP/NXOeVOWzxiXIiJjGXfpSTEKGdmTz62iPfwx5cjZX7qAY/S26ujGDKe8GqeI=
X-Gm-Gg: ASbGncuAFt4iNELE8JVu763cUJzLKZbejIbl40BVX4Jw9UP4M99k5MUy6B0uiKapMzd
	aoZHkEuNcEdFODuBJl0m2AcIrWLdyiRhl1fmAeanBh4EVoP6ldmArV0sUmFeRn2tDo0EgsDq5Jd
	CG35nXlESHx6U1ZxjWOivvTGK3XI9k/lm3XRFkU2iz/A97/JqrZ7M/O2nFZcwQYILA7fkr7xjVp
	EBZN/tFf2vImW4h/0wcpm2O+d4aCpNS1ZQ4PQEfr2Ctev9BC5tMN06IWsgm7pnO3shneUKBjKA0
	ZTK7ZsdylO3sy2eF1S1igip0DqMGJR7Xj/NmKYp/EJm703d6f/R+UaU51ZpvC0nS9ZiRPW33gCZ
	vzugJnaRyDov9sSP6whZsAJIN+cQmuyKJkZnHx2rvxGhD1M0dUQO/z7N8m7joSvowO/EmT9I=
X-Google-Smtp-Source: AGHT+IF0wOtT5w+tdQQmrXZnXXSDYjp97opprFhrYP7Wm2xrNoUtmZ/FuBkt9NLdeFl+hYiIXGovig==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-4711786c79emr179394635e9.6.1761138675738;
        Wed, 22 Oct 2025 06:11:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm38839905e9.1.2025.10.22.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:11:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:10:46 +0200
Subject: [PATCH v2 07/10] arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gpio-shared-v2-7-d34aa1fbdf06@linaro.org>
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LQ6GmHpD/iWFySPYiWNs4nA4WFevXV0FDAv5KxrY5e0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+NfekSMiWGzrKtKuLqKr9X/aFL7erEPkinVg0
 Ya0yCZDb8qJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjX3gAKCRARpy6gFHHX
 cgEvD/sF0UNAC5n2ObDj20Wt2u2qe866svdBJRyT7vFi324TFqRE3bSjbOk9y/3g6LFT/ehBXIn
 g5lxm2qJ147ZK9Sm3UfKI3Kvwqq1sBLnhdGtoihARXjAn+De38GcqhOl24nvHJlvM9tGkHnnxNN
 YGp6a8Meo66SYHnbicVDA6n3CuHl85/Jpr9pIgpE1xll9bGifkT1okSqdNiE99fbZMpvt6LRnxK
 xuKuyzK3N5G9ZKUB/l1WzvlsTJNqCtn98hSufn9wJ1C/kQjZGVjh05hyf/Ww5pY5Ko8ntxmwMVu
 XT0raHo2LULYRMGPBYbXxASf1rtF31mIDi3XbCa4Aqq1sfdZmyhuiu7ikz/4peZ4Ls3MctkBan1
 PoFpHPK+X63q/Hui+iiIi7tiOrrLqQZmxyLyjCvlo04Z9IEUpp/ud5HmrpJEuc644DxLiknre+L
 C8/oJIZXPrMTpOvenMbanP06CADPW96Q4Xm6+eeL9j8/RvPVpkgwOi3LFJLfVUl5rswQjX2ODUV
 A+VhtQakOsX5i8Y/AU89XVDQExM28exRzPlc7qjo3j7O5s4cy3ZbzdlWBi68i1D5qmEJqXnC2WH
 bcq/Tv7Ul5b4jALao342Nt1r5rbCVZWQMqMTT8gaLmNjlS2rVvnKrWUfri+/WeiJhW1/rTAvX3V
 liFuFefP2GjBr9Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some qualcomm platforms use shared GPIOs. Enable support for them by
selecting the Kconfig switch provided by GPIOLIB.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d4f28e2d47acc700f80a165d44671..3dbff0261f0add0516d8cb3fd0f29e277af94f20 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -316,6 +316,7 @@ config ARCH_QCOM
 	select GPIOLIB
 	select PINCTRL
 	select HAVE_PWRCTRL if PCI
+	select HAVE_SHARED_GPIOS
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 

-- 
2.48.1

