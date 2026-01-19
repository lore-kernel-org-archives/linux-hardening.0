Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A359718
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824540; cv=none; b=ks/XuDxAVGO9UzrC5GDUh6Fuk7jkUY2bb6XtGzf19jC91FHidRR8GZywhqQmhaR6XHBw/Bf1oj9DTw9fTuCC9clVWhBW6IIeNSEkjU5fPZ+dOMQatoEz5+6+obZ9iSk7MiaLyYN2pKmM05q4cHJ4DqPLb5upwlWBXZ0kNc7O91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824540; c=relaxed/simple;
	bh=pykdip+kkXufUlfCYLkhdMwhxg3VFd8rMtL8HJrLcEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx4YHDpzLdipfz1dPUKMKUnwzKLssSj9nRutBGOr7+qqf+zk4pRfb72FMdibwby5tZhd4lp7BAlOHmj5VImqcLZXV/LCDhVhgZagYJaSw9hLB68PDalDn487vGL1pl/bAid+7iOpppSzZ8m89/YDdiPYG8NsbdZjGMAmpaMIQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHXRgmFz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHXRgmFz"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432da746749so2107184f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 04:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824535; x=1769429335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sT+McEH0mapvqHwCrxtH/EF4dLPev+0QCK1+TJXdyk=;
        b=xHXRgmFzETIZcWa5HE5EhJ5+64tJAbKQ1twr0y6aBerc+Q8BlfPEXBIuFX0+Ymjrdp
         UxShKe5lO0/H3Ywpx7CgUji4gE1uZptjSpklLZ0jfNSTUUtHvfoadlkcPk5utLg4WvXy
         ARqmyVZmz62hB+vF2R90WZa8LtXc3N2X0eKyfs3W3REKDKom1RSqVQxCwzsWBF3pvSbD
         XZnv4KzedK3tILV0LtQPHgN+Pm/egNWikLilPURTQi9tc9NeX2TGt3UkDuxWtFwaNqId
         325DeLOS5MKKr/i9LoEjwrbYZFjAjmk16ujzKG5rzLpb6XBSA1DJnYzy0Y1XignAS2jw
         aKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824535; x=1769429335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3sT+McEH0mapvqHwCrxtH/EF4dLPev+0QCK1+TJXdyk=;
        b=VivvouciJVlJ5R0U2BOLDmOsO3VI6lJFLrp3U6Y3QkT5ig0Q53tiUiuncWF5x1NEpj
         dWXBW97u/FEcRYW1o0/L0QILrJocUVqLfy4TEuc7Eqeqomsgb8UpK0wIZvvhqicgSlhc
         1wLnLLMl8OBOrX2ExyVg1g5l5uCEYmueS9JJeU7i/yAvKGHt68+ek6OGtuFa9fXg+A7Z
         yxQRgwVdgmSTEK0ZnlJIGMcC9C6KWyoCU3MJQmswurNG8uGFuI+BTxJ79KmiPyYjBVRt
         UHDKG+l6aZAeKflTiuu3+GWZ1ojaYIjvmbZFP26RHDrXHHYVPRZC+XLf+VxY3Tynjo/S
         Po0g==
X-Forwarded-Encrypted: i=1; AJvYcCUWm+sWUMFJ8eoCMgDJP7zXEsBKA2kcyC4jZKoOLjTcVsMIFC078Gp7v1BlA1BAr0oqRDj5GauP8RquwtczZiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BX13azoAFzvN0pRkV8bdCBinSxVy/M/Xf0+hDR1XcliJVERK
	WSSKi98+Ib7LGal5/IKyNnZH/1wyphQDOAM5SR9O3p4r6+WWHq6HEimucf+qmcbuWQU=
X-Gm-Gg: AZuq6aJiENmOLpWAz9OZf99zr2SfQ7TWY39jihZnaYV4qcLyaXat4OLn7JwR2gE0+Pc
	4Fy/kvGoqtWvSgmkIDmmROrzKotRya5cRQkohuc6xmMG8Jyz5aPhZ9rsNO0EiUO1zWd2D3NBCNi
	6ZMNx0Du0rcUrWA5Xv6sJN4Eig7HPierz0NmlHCYnQjy9dSPdujodZnAV3fWu3oxtZK5hnECmUT
	VsNAX/NK8Zj1R5bf2N6ZrGmVa25tUQC5Ycpx1st5niDfpIOP84z2lQjoYzZ5cArP58ulf5rhBx/
	dH5B++umwTmDYznX0vcKxqV6AWVfQYGYkQEIxtpr108FHtMe/GV9FK5nIF3NwQ1GQB6EvlS0108
	8VgZeMnD7XbtIVqaftiBILK68z6jlzJnVmIu7tEhZhmkGsl43COg6bqd6HG+OSTSY8RsdDZccSp
	dhdlPXUMz1iq5UkJCJ1jnzNMaZMUAZ310xLsjFdZW1Y//Yciwu/WCeFNKgnIQZhukD0n6ZaA==
X-Received: by 2002:a05:6000:2505:b0:432:5b81:49c with SMTP id ffacd0b85a97d-43569bd463bmr11645564f8f.55.1768824534827;
        Mon, 19 Jan 2026 04:08:54 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:54 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 19 Jan 2026 12:08:49 +0000
Subject: [PATCH v2 3/7] firmware: samsung: acpm: Add
 devm_acpm_get_by_phandle helper
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-acpm-tmu-v2-3-e02a834f04c6@linaro.org>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=2702;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=pykdip+kkXufUlfCYLkhdMwhxg3VFd8rMtL8HJrLcEc=;
 b=mq6tHfgFD5v+dBnv9e/9P/zH0n4O+kG2DeWw28a7k1Ie25bdm6byhx1O/Jsmir3D59rhSmRB2
 PCtjiH30SmtCASeMud922mbZVmChdLaD2MzvcIIs6KDlOrDaN2jrrTO
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Introduce devm_acpm_get_by_phandle() to standardize how consumer
drivers acquire a handle to the ACPM IPC interface. Enforce the
use of the "samsung,acpm-ipc" property name across the SoC and
simplify the boilerplate code in client drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c             | 23 ++++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index cc045370f4b0dc6ccea99e3c2d6f86a43b2e9671..cf849ba23f09d8b1e7f91734a0a1cc064f7407c7 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -776,6 +776,29 @@ const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_acpm_get_by_node);
 
+/**
+ * devm_acpm_get_by_phandle - Resource managed lookup of the standardized
+ * "samsung,acpm-ipc" handle.
+ * @dev: consumer device
+ *
+ * Returns a pointer to the acpm_handle on success, or an ERR_PTR on failure.
+ */
+const struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
+{
+	const struct acpm_handle *handle;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "samsung,acpm-ipc", 0);
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	handle = devm_acpm_get_by_node(dev, np);
+	of_node_put(np);
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(devm_acpm_get_by_phandle);
+
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,
 	.acpm_clk_dev_name = "gs101-acpm-clk",
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 43d41e11ad2eb985e27a918ce3f9e9ac15a194ee..9485cdc1d91e86f9a9a8fc00722f3313e3000c6a 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -82,6 +82,7 @@ struct device;
 #if IS_ENABLED(CONFIG_EXYNOS_ACPM_PROTOCOL)
 const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
 						struct device_node *np);
+const struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev);
 #else
 
 static inline const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
@@ -89,6 +90,11 @@ static inline const struct acpm_handle *devm_acpm_get_by_node(struct device *dev
 {
 	return NULL;
 }
+
+static inline const struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __EXYNOS_ACPM_PROTOCOL_H */

-- 
2.52.0.457.g6b5491de43-goog

