Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ABC218AA5
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787478; cv=none; b=iypMC5JY8HO3N/mR74BmigRSi2m0bOQFS1vvTf8IF3wgSrb1gfJ9hBW+V6fmq8pABj4gKcpKTGt+tTo3cBAqUybwtsWuHuxDq8FVJuHrsKYCNqZqenpo2lWUpCZpC8hr4FugySHw8CNFsQT1jmbSRgjeY2hWIfV6UyQOll3ibcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787478; c=relaxed/simple;
	bh=aIDoW7X3UEqmkRU5fd1ed1f7Yb48yUxmvjsG6JEXMy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWAYD9RfhnXknf5QbDMaXl0KwQtzfi+7qh1vb1hjTK8cguEnFj6bwl093+YqAiuF1BIoYSs6r3dw4d60voLT/qXYCh/VkhLLIuhThliMZBPbckwbwwkqMpi6SJD0oViyVmtM4E91e5giXtqxC/8MZ8fIwTvwtlyjmvX9xw/uPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8twVDZo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8twVDZo"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb79af88afso297711866b.1
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787475; x=1740392275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjqSIaqjo22M/fJ6WrzBYInBLUW49xWtc11H9nbdufw=;
        b=o8twVDZojukUFWL3S8iI2AP6UXMtrVpRVaVZH5UvvmTEpXcZO1UpLxeF/YDscsxnCB
         S+jjnSTM2IasEld2rvi7OfFnTKUwwPSYqTk+coYyqOpzyHziSAl9zl9ev9M3FstDb+5+
         6cErzq/sJAhoxcjpkzUqzAsC7sjlrUrsgoclQu4UtPVOQaI9hsjGQJM+gNY4bjgXnNXq
         520EfVxXrR3v4tW+oAMjlHcgqhXKdqfbFznB/CwuROHoYjyRM1beA6qm27iN4iy2tif0
         Bs/ZBIll+F39RX/vEk+4u5isoI7LTWYnz8UsU8QLOJSPKMibWBQMwpbEJxaN1dZnHue9
         wutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787475; x=1740392275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjqSIaqjo22M/fJ6WrzBYInBLUW49xWtc11H9nbdufw=;
        b=c5fdm8oLEusd/ohq2Yqj53quvMoqq+7nfYNglToK/ocE0uQCkb+CFN3xBCHFiAIrtC
         Thv9e0CvbCfigVzp1iiaWlEyMxglARBaErpZpOu9JY4mh/sMIx3S0uXNmQBRWrLezszr
         rs7CN6XJBI+JlcUx0/kRIHkpxTXJ29w9vfyyxdu+sojdo2/tIXGvYSsG7jV6GwYkD4X+
         I3xWumf4CzmZVpF8sV7SBjvH8jE4m43IfJBwOvlsTr4YkjbZHJwZHNd0GyHxjRM2ly/w
         ypWlGC5zUxiEVFc9Uau1najMDOm7MzLOSJCkCofjMQAy2wEBikbqDs38McGi4pQkqXA9
         dddg==
X-Forwarded-Encrypted: i=1; AJvYcCWsn9BMWKILWSAVH5xpS/IwRCSJUYFpMw5EoVLwpwIx9ipUcQqP4x1h25dhLSzm/QcNQRlTAgk79oSK+kw20sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoH0JBQNSBkxCt8u9QYXybCDAaC0HtO2DuXE+rEJOmFR5ERZH5
	Vs1M5iUAEG/QhYFcsYnl97jybIb/ZVC/NHHb4BoSAs/mcn+fl5CZ6DwCYE3QHWY=
X-Gm-Gg: ASbGncsjRB0+VLlua4tlxHht8lCYVRvTRSeZ1nt412D8mh+X0i9xulM+6Qc8j1Ogefu
	FXiorBg+QavALoHF+NwXiTbi8tx27VyfaUuAC+50njIQvrXrDurobounTgwOH2HmfD+gRgsv3mv
	M6EjCDYUZNwn87xilhomNjQYOfjKmjkqMdlM+oqN1tldONoXBWLuTBfi88n4owVPCnW5PSmTd1X
	mLB7IG0VgjvzTaTcQ8NXl1LBZxkFuy+DzdO7EslHpp/WGYEvmG4hXYx0omCGu3BYJM+2X3SliGN
	fHhqnjMkAsbu4io/MZo6MsCC
X-Google-Smtp-Source: AGHT+IFlDyIupv/Dc3O4C3y1gwzt/272w46jucKO95aSvrTTvzjMkzKCPNIWu+2421TQveFqhl50lg==
X-Received: by 2002:a17:907:26ce:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-abb70de288cmr1064938866b.38.1739787474939;
        Mon, 17 Feb 2025 02:17:54 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:54 -0800 (PST)
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
Subject: [RFC][PATCH 06/10] qcom: smem: enable smem pstore backend
Date: Mon, 17 Feb 2025 12:17:02 +0200
Message-ID: <20250217101706.2104498-7-eugen.hristev@linaro.org>
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

Enable smem pstore backend that registers regions into the minidump
table.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 592819701809..f4d2646fcc0b 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1236,11 +1236,21 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	ret = qcom_smem_md_init(&pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "smem minidump backend init failed\n");
+
+	ret = qcom_register_pstore_smem(&pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "smem pstore backend registration failed\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
+	qcom_unregister_pstore_smem();
+
 	platform_device_unregister(__smem->socinfo);
 
 	hwspin_lock_free(__smem->hwlock);
-- 
2.43.0

