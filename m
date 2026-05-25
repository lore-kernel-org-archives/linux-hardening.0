Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C96383987
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713435; cv=none; b=M5JVWDGUCj1wQijRGyCOGPiorIgrpauLmDRXV9BCgxGW4JMB+AvxhD9sq9lWmu4V7hkOHDSXKKcrxYunfkeKRtCpWWi5P3ptYVm0YkXpayMtnRyqu5sznLWj5HBVU/y0lxc/8lEJjHPMtxYYDvsqk/cnFplhUKBIyZ63llW4Hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713435; c=relaxed/simple;
	bh=j2bS/h+sguKS9/qgJjI48x6qOqG+tkwy92XDxvAI8yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgkaEDpEJqTwuAHGCQc6/m/GEKraTPJdXLZvly54SxFu+b5ddZLZJOiHxDASs+vMlVj74hHAW/GUYi8fqf93/zRcvrCU9nNjklGBEzpug35Est9QRoVHMnw89zhhP2Yat7G4QqmbxtREZ9FsMy+ob30fA/7de/ZaLnbSSrZpISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtCK1oVa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtCK1oVa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so60328255e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779713432; x=1780318232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeWjSlPEDikRvLF1aU9lZbkxd+9N7RugqZlM/tjJ0Bs=;
        b=ZtCK1oVakbBOBeF7teScTDXDYTb1wh47DRq3QNmsOu92Aq5LECw0ALWoFn3FU1E4/P
         bkUh2U2obVuEIG2qc7RDwPtio8DFxBLy92TskAwhJ6Lyest5jI3M6fUmxoVV/OwKeXWc
         80nsy9VNDab8k8wOyxPcynbwV4gpmFEd2wLFvn8BBPZR1u0mY9KzyOKs7abX2s3hCbYw
         +3ZRuAWPMJdUkHq6gfWX4Zj6/rBeDD0u3mdhvlOGVSOSqUY/v2keVXnVZIbPEUfY7OJ+
         lWkhRyp7PTcJl2d7/jteiZTD1ZHvkGts1CxZggu6eRv/o0Pm4iVtOmTNpAvPW0gluuad
         MlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713432; x=1780318232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeWjSlPEDikRvLF1aU9lZbkxd+9N7RugqZlM/tjJ0Bs=;
        b=n2LiMqiXgTvpcKZVMD5H3OCSYnNUolqgs87Xiv1KRG5EnThIIe0u6BVvyLzJdWzhjV
         d4sMjxdFmMI0kMtWsk3shQ5+znvEKN00Avhs0sKOJDcdswtVofDFvyk3o06AexoBrpFw
         xmClrl27PbSJqJBCIQNk8ojo+qx0kMPDXkHg0aWC1RH7rOdDr/G0GnthqYy+0QYxIIHZ
         Hxhcjl1BdvSVP+rwpraxgISZ28868TlgSnUyOG/er8EAPayxRYlgFdKAsliMCVt3Ch2g
         pz1azxTWHnMbs6zED7J71IJBeQTZ3hhWjbbXtemgYhB+CaS76Z6QIz1F7y+sa/gF/NAb
         XMVw==
X-Forwarded-Encrypted: i=1; AFNElJ/NCcpStZWtMI2PxkgHv+Voq/xuSgWjDOQmmMW4z1HeT7cWwPY99MPbp54jhGxeuMrSTJeryLa+3VQQxZinyXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHNHh8IUZCJxyZGmaEHqrP90lPl3qHPIizeYVi6MT7TZoNJ6y
	JiDlfxGZNhRIxuAIAt0816knpiL1pYLaZB3kTnLngFvuY7D71YGzajFjUFFIo37KvCc=
X-Gm-Gg: Acq92OFfiGBei0JEiWzL5Omq6u9IvH5bGoeydQunjMHkebWMRIYPeB8AZifnpahbect
	F9OtTH6MApaZqLxgkDKp04MD5aqTQxU2O0TarJu4S7AY3CCOG21c63UIV/4mP8Ygpwd394mYY2g
	rIr98e1Xk7mLdB+8GnFvyp9QLrZKEWq9aXZFz/lZ3Wv4jfAoBvlcZ3cuag/hY0/CZZpE7II5dr+
	QO1Gou1XAuve0D4gs4Ou0AkKSHrlRUm5BgFe1tiNhhEnYafOvb65k5PNbhehCP+VLJPZS/RSpaD
	6eWggWJ5F+WW/LEroNiqa1l9JDwJcQD0Rb+/u+oYGuOEK2DQD/zUjFbZXrCQ7E86zufkQpUbgwk
	PuqBpSIVTrraDqfTbeqTyQ+9KGy8NXDFqly7KtSvXHl20eyCnyYBnPfbAjbJZV+pHOzcKF6d8sh
	n54PrvNixKx0becjAblIBdjcmh7R0WSWjKcJN7nrq+ZzvmMzUWbWKuRHNRtgz4ZKgoGhJp1Yg1j
	oV4H9Y=
X-Received: by 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr151219345e9.9.1779713431711;
        Mon, 25 May 2026 05:50:31 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm241824825e9.4.2026.05.25.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:50:30 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 25 May 2026 12:50:23 +0000
Subject: [PATCH v5 3/5] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-acpm-tmu-v5-3-85fde739752e@linaro.org>
References: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
In-Reply-To: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
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
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779713428; l=988;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=j2bS/h+sguKS9/qgJjI48x6qOqG+tkwy92XDxvAI8yY=;
 b=wGj/ffuuA+IGQ5pRdRuMChnrz10mIrbyGhYYPnunxYqt6E370YQjJM3fCVLiK7mzpJhj+Uf/C
 82tUXkViWFXCDZJnfAcgY+c8oE7hfjIUHprgnbQm2BqPxOtrLUp7s5v
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..7ea3b9d95ccd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23660,6 +23660,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.54.0.746.g67dd491aae-goog

