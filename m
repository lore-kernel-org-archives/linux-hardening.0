Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8421A426
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787485; cv=none; b=iMo7bMzNQhxUgPFcsso3s4GrzKjMDfLSiDEPnXaiV1gxN9x7BAiFvuHac+Pa/ImyQOxmvnUEY9NLM1UYfWtk/scZa+/WVmHKAQucWg/fxLv+W3SiBqsUSo2l/FrwOUOyi6YHcUaDbkg30o9NnUpUyM5g2r4K7pb2nQ+fcwC0jSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787485; c=relaxed/simple;
	bh=H1Q/+IWyWi+vB9ilQ6BLrSUry9GYCCCUwBI0kz8T7RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCgVQhANoUolWwD8DLrMb4cG/l5Dzclh4N9J4xk0WX1Z3phPSuz2mzcunobikVnTzi+om7ZkIoZToGhWwpUfalPkq8Rk2XimWYSjvWWRK1UhZdBgh8LtHK7HaxIjfOUIegSB1qdjwLOGTR0ZgQ3/VgHQ9edhCfi/OI53tj3QrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6jcOYWM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6jcOYWM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb705e7662so333250866b.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787481; x=1740392281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOx/QjhnUzr5iZf43d5r89IsS2FOdAlXvdjY2fxKvfY=;
        b=j6jcOYWMI+xBtGufFxtNgFXkcWHfBITO7ir/tJj4DdFAtVlkTQO72/L3+0sCKJg0xH
         BwfZtRHLBchmHXbktX6cEsV0ganx0LddNHdEsnEQEpLgnE1JOD4lnHLVAyCNv4mawObA
         V1njXv86+puXsxF1HH18+YIDGe8IgNsyi0Gy/l82d5LdYIrnVUAdwovpfisz01eMyMS6
         FwYQ1kAsHuS8KtNfIF/tQsMWDJsFk39noEwsiyenNvp8qhKy2p/NLVg7uokL4nt1rftN
         /ZXUlSoxGUYPWictch6imohZ8QbTXB4x3a6HvU6wuEbXbwXXqwIIYn4C+yIQ3fTjiG48
         A3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787481; x=1740392281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOx/QjhnUzr5iZf43d5r89IsS2FOdAlXvdjY2fxKvfY=;
        b=Ffa5gV0763Pc1iEvLuaBXkv18sYnH+kdyr2T2UkA5iHIxMkPIjr8SEPMIEWPmRBYrd
         Kfoq5BusSV3N1tkGzgdqTl7cC0GuvYbrRH1M6GMmTCheJw4SowMLnZV5ofvwNtB9Gxdk
         PT1HgFOlk9WnaR9WOes8QuDqPAQwUQD5Ec2d6T9u8yC2/hHCNYUjooSLba6jHdelWW14
         t1uO/4YCfHWDxhJLRhsZXglP4P/DEY4NTJMNzk2NLZSv2nTsBpvqTeSHlz+HBdTpAQzc
         tYARQ46v20X2D8Gihsrg5MByOUn/i8P6EzvJiqNwx0+l6uibTMZEOgJvcakoSdMX+LnM
         VY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbMDOoe/EXoADhp0ai9wwB00yOQp37REP2db9CgHmsKF6lWvz1DNW4zIaSK5Cclk2kkONgFW2JKDSkNYBc8Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LOEfve2cq3P9F6Xu66QkuN0+B81D2c7KkPqrDfOvJ/GmRTwD
	9yIlhgu18tZwk9cmhAVM4yaDN3w6adecrbYXbe2o7//i04CeBVQaCrxrCmgcqss=
X-Gm-Gg: ASbGncv45nWEdkx5+Hw6IGKoDeW5O+/g8mUO+g7uhmNnC7V5ECVfL51uMsvJ7GmgdbH
	sCXdv+0UWK0O9QoFPW6UjUcDOI+Q3B+be/KSgBEp/Afyf9PBzTNIA2xcYQ5o5pveMJr3HW+jcND
	UWgm1jezHKCXwE3H9ZXuH5D0L7/LToxm5D9+CVGkvEnTJF3PB7qMfg/+SeCLCBI866/zQ9rJoCQ
	XIGml+SZ+eMAOZO93aHMr+onDsj+ldnsjkdksZprvA9y1A4B2IfnKPEaGqO/l5MYjPCrdJyPw78
	mr1+jug+8SfyOSF2gzKXDibW
X-Google-Smtp-Source: AGHT+IEyhYoBsYp2nsZUxaNrWoEJIkJcEzeW3uR5U89aJyr/W0mS2FbZhC0xUYWaFE0athJ0Fx91Xg==
X-Received: by 2002:a17:906:4fd0:b0:ab6:fe30:f49e with SMTP id a640c23a62f3a-abb70cd5108mr714909166b.28.1739787481314;
        Mon, 17 Feb 2025 02:18:01 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:18:01 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 10/10] rng: qcom_rng: EXAMPLE: registering dev structure
Date: Mon, 17 Feb 2025 12:17:06 +0200
Message-ID: <20250217101706.2104498-11-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proof of concept on how devcd register core area works.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/crypto/qcom-rng.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 0685ba122e8a..a1509609f50c 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
+#include <linux/devcoredump.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -32,11 +33,13 @@
 #define QCOM_TRNG_QUALITY	1024
 
 struct qcom_rng {
+	char start[10];
 	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
 	struct hwrng hwrng;
 	struct qcom_rng_match_data *match_data;
+	char end[10];
 };
 
 struct qcom_rng_ctx {
@@ -192,6 +195,10 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->base))
 		return PTR_ERR(rng->base);
 
+	/* Setting some markers to easily recognize them afterwards */
+	strcpy(rng->start, "MD_RNG_ST");
+	strcpy(rng->end, "MD_RNG_en");
+
 	rng->clk = devm_clk_get_optional(&pdev->dev, "core");
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
@@ -218,6 +225,8 @@ static int qcom_rng_probe(struct platform_device *pdev)
 		}
 	}
 
+	devcd_register_core_area(&pdev->dev, rng, sizeof(*rng));
+
 	return ret;
 fail:
 	crypto_unregister_rng(&qcom_rng_alg);
@@ -228,6 +237,8 @@ static void qcom_rng_remove(struct platform_device *pdev)
 {
 	crypto_unregister_rng(&qcom_rng_alg);
 
+	devcd_unregister_core_area(&pdev->dev, qcom_rng_dev,
+				   sizeof(*qcom_rng_dev));
 	qcom_rng_dev = NULL;
 }
 
-- 
2.43.0

