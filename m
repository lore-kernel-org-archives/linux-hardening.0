Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477C3E51D9
	for <linux-hardening@vger.kernel.org>; Thu, 28 May 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968188; cv=none; b=Q2eJY9DQ5w6SKImJH5c6qI80uj2NluUj9y5nfrCArSjYYnjmaYsfgiIa5D4Qv5Vep4iS69/FkbVp6HZIFAj7wO6FBmB23kZLu3AVsm1aeVnKXreBdT+DPu6hKs9bxUDQU/Ah2PVAkMMrdUEr90LgDeJZgJamYkj/YieGOMBKu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968188; c=relaxed/simple;
	bh=Aobvj69DN8F6w0+Jb0r9TFQ6oCGfBu7fy/EjQhPy1lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E85qjla0yYI1sxmIVs2s+snB3Qs04QUS3ZyZTYUstQK/CYR+utpca9ovjZgF7jBtyORvnmRhus1puWldSXw+fUwJySPX5gsZ/RAoUx3VS/8QXRbypqrgm8IQfkzIGQR0YcD0R0Ego5lvBG/p10gQSybsUq3nZbJjUvSKjp7Px6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JS80tqNZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JS80tqNZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so134219445e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 28 May 2026 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779968183; x=1780572983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpUOS+9fsWY0UqlgRlGBSremc/v/5gxyA5J8k3968CI=;
        b=JS80tqNZjTwx+lUJcz3qQiVMLsMc6hrU6LFf9NvYdWVr8mxXyg3rHxnIcJNkOg7OEO
         creHdT/CzuN+IbwOun69wCtQvMuJtT9BEj3Dzc0533ZsFZCSgMLGsvyVJvroiy1EFXFJ
         5AgxNjKVnKnBv6Y3ocT7vso1iCyrGue6okSRqIuFNkUtHDLzpdTcCSndrG/Xa8eW/mO3
         lM/h8kbs5PalzV6AZ1m9ZjADEOuflA2xeZsO54iISgBUxv9XYb5U7wlpYOFU4eh1ugCS
         aw1hm0EXiaImxpkSd2x3KytsgicKWobpSSek9RO+bBQOlZyYksEiKfjT4cOsDvtBxJAr
         3tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968183; x=1780572983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wpUOS+9fsWY0UqlgRlGBSremc/v/5gxyA5J8k3968CI=;
        b=lNyM0Y2NcP2QvqTeCbeV7H6FYTk9i7n8tudUj8pUoDLpsu5cRHkUcS0JvmD3g2nvqd
         /4X1yCF2GUFkSiF+odxqSOHspqZlhiFDRZT5CpsfsvUwda5bZPuBxYImH8O26vJAGnh8
         N7/qrZPq6QzL1PrzOoAFWS//PWW85JKRC6C1z+Lo2trIbFOmmhcv4I5MiXJQxW/Xa0D/
         b+cWhEbA8PDLaraYq1kYHoPjisBx8lVGNptStvCPUYwYYJt8IxzEa4wDrmq+P7rQhKw8
         F9PJKDZN7qlAsGQ2d1idHas3OgFLLFIN+oYmdFh73XCJy42OSQ4HoZBBYTf41C98tz5i
         eOIA==
X-Forwarded-Encrypted: i=1; AFNElJ+hu1Xz/WAEVQifr2jxHsFb7euuoVKsAvTYUVdtQ30p+oWBhXwyP2JRgF9RXuIqi27MJ/1XvdDQpww2L9fFxQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82Oghj3Z4zZnMVbCWrmIEZ40Nz+SDIr2P9yxo/9GG3tITNP47
	MZlBrqaL/HtALpyp9HKB3NIhRX9AdQ//a/kaZ+ZAZJ8o7xhScMOmtw19FfKMoi5THmA0np1i5d/
	WstrbqK0=
X-Gm-Gg: Acq92OH0+P5BSK1VQJ4Wf8GAY44sALdM8K8b7QDxUHzHKpCxLctAkrL3TKvQ5QatM5P
	G+Hiwq7dKjgVeCKIp1N3SPZF8u9hRIo12+DF4WVqljG7gUzVh1W3Gd4Ykchi6IE5CMh2ES97A8S
	sRTTcGwPWD8UdCjIRphzAa80iUaYt1lT6/UH+2+jRp3irGoBRRY37QFbHyQbTY6MeWvljytqBLA
	sVS5Zauu2kNjQoWDYGS7Ks6dylbo7LQx8m6ktaQtiFiqOZYzqG+IMH2ZqdHVYEQkhaIm/2IUWmz
	VKTx9orZkrJ0IRqwQsiCUZx6dPJpVHapD0F9azCWmDChga1d9F2Yznqm2ocIEL6hJEvfdZTIRU1
	hAEQeVgfBxxTk6on9Zwud+57QYjNPxukadlu+BFQVepn5IDB790bc/PJG6u50/tDq3876cqLSPh
	xpbA20zmynYofRPLfQJ0zyugk78xfyx9oUdWy5UB17UanwLLyuVYu8jWTQl7EyguJ6UMJfk8HBi
	9UK/ubnMSJwzuyjiXpTvRgeZVEx
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr466725355e9.20.1779968183364;
        Thu, 28 May 2026 04:36:23 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a902bfsm60385715e9.12.2026.05.28.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:36:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 28 May 2026 11:36:18 +0000
Subject: [PATCH v6 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-acpm-tmu-v6-5-b4d7ce57594b@linaro.org>
References: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
In-Reply-To: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779968180; l=794;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Aobvj69DN8F6w0+Jb0r9TFQ6oCGfBu7fy/EjQhPy1lI=;
 b=IrVw2lxVCkAd6zW/JJPCyuIUKwWUWmwU9qRVAfB/8ZYIYZEo8nd4c6wq7R9RZmeF123hMczZw
 7EaqfiU+KYjBsr+EB35bTx2qZFhGyzz8N0BhvF5UIvxX1zl1H7Zm7/j
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
2.54.0.794.g4f17f83d09-goog

