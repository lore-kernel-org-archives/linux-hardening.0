Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434502;
	b=X2wfp0HebhnMhKp2pf7m3Cbbaw12WpN7Vz9brW4gkuQl17Q8AEcfmRPaUKoTela06X4p
	 6R+TR/tcJM7LsSpGvK06O0XuwaPyVfhwMqTDSr2XKNA8yMbUaN9xZOPyO96Q+MALrA3kN
	 bcbiwaDbY8NVs7wdqsT5KfpUV0pT8jGPgE2pRnnWlHdtrb4Tpi1v1h+LdAQDiy55K8EJv
	 djqPSdmNwV6KBusbtNqWXPfuCIqK2QGt61vQqOClzBexFCGI8Iok4ihw8Au4iiI9YoaKE
	 3HagaREipEzcQ+7ajdj4MFGots0sGYCvL1HprgQszrZYE4n34lqcELyN5tamHCnqMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LOO2h5QK8CfY8Gg/3IS9sOkN8AMCYlWmi2Pn5OTG2Oo=;
	b=RknepeaHttjZSYrG0k0My1yUEw8oc5JNESS/ZQzY2PV0T74VWRGiQUSK9adxbJ2CAF3i
	 74UejgSvV0YBf9trgzX5fJqMF3Z6UmNSTo0ew6zhj/BBOFg9U81VZHWQh8yfM3rIylhD2
	 BkZ5ubPat9sXsmH+97OOQD1tuC5dvCD2WQTey18wTxx78ckfUfXJe7x+IYlnp67H4+mcO
	 j5/Yp+yuSgbXvNJ0ANnwgPIYG7uz4wmywnaHSCySQTCDSoKmPs84dCaPBNbcgDjE0x4YL
	 SHSXaRCj/zEjIWM8ddbXiUFaeVetb+7+LajVE7V+OmMsypceCVKYP1fQ9MW0FBeQSQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yP81/8gz";
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CC60A6F78
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 22:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F3CC60A6F78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yP81/8gz
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8451a619da7so2229476a34.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434501; x=1795039301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOO2h5QK8CfY8Gg/3IS9sOkN8AMCYlWmi2Pn5OTG2Oo=;
        b=yP81/8gzn1Ll3IwuLCMoEbwPV0nMk1P0BANs+bgr5w90XkSeiq9vbfukn2+cw0IvPw
         BELqNQ/UghmV3vPpfIY8uKZTgtrVbFpFkqvuwLbl4B39z1o4mvXXvXHXaX3xYTjqfuUG
         mnFO6bx6foH0Is6jPiOc8vt0FWnJfcsvqwWjoaycm002osiIlKozAjH5bDuNMVpk2i36
         ZKOquwGqNrRDElTVfKSsv5qNhdEKrOxkDeN0B4q6wTQo1JzJCCbtVdLyqjZXiFINhoY3
         lZMcZnlzozw93HATT0hdeTPHF6qmMfm9P9J0qG0s87Dai2dmov4rGZOMxhx6gRoRlWDA
         ekMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434501; x=1795039301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOO2h5QK8CfY8Gg/3IS9sOkN8AMCYlWmi2Pn5OTG2Oo=;
        b=Fd3JkubJ1Uv1MbDahQluxPbUFhhyWLCiShxOT4ZFar6tztzEbIXj2W3YM2pm216k4S
         WFd977+KrT2zKuqCLiXX0MpK2ESTkD3wDfNUnBECyUf49YS6aMzXyb/OwqHAlYqoo7Va
         qtu+JU+9veu3Ewh7t+fQCHhQNWA/rhVbQvS9OsqBBEAwYsx1zz/I1bZwzUceoBp4aMLu
         wmSw9v/iVOaCiDuEaW66gSLgzTyaaxUarNd0uMSVMHAAbsCSzWx26FjmeREvEddGAAAy
         Jdbze6t89cLRcwIoQ57AYSo6TDoHOfMVVH14z4lk9ISORDBiI9gKuBUKTl1ZzKmOM0wk
         G5sg==
X-Forwarded-Encrypted: i=1; AL+hErH0Hoh2au3KFjp0Mj0wML1GSfbwLhzabt1u3OYUIFzO96jiO3lCYrFDGi2lX9Tp+MiYoe7iln5c2/XCoF5UiEs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PHQYMwhBMzvjuD8efI3QkV3ao43VC2v2TjlD4b66CiUlYnk8Q
	Qk7cscdeggoQtVkB006TfBG5XbQpZRlO/zMEfwHRSnwpa9vBc6bdXwRC
X-Gm-Gg: AYBFou2ghHaS0kmcuxFItc/zA7qfmkyPvmj1/SRxTO0QPk+8GG/qYbLmczdNskLymkT
	rVVF1F2NEFQjwP1mNVUJNgHwZ9Ny1kqnVM7puMARes0aMZBIEtdSVDPhMUw8g8pr/eM+xsziEhM
	FhpQ/PRrh9pdXQF0qzPqb4E5JYHV/fgDXOpv2seTqx+a/MkyHC39SMFc5OD6+voZuc9l9In2GkZ
	lN7yNpkBJN8EKX07afvF2cdO+6/OraT8NmaP8WEUyy69/esU4R7EFHhRSn9J6s7Qbq86YcHRem5
	rrcb6EJTUdwe8NK+yyLC+IAaa311TIZIXmsovevTnUixKUzNL5cA3gKdCm7CZ/cNMLx8kCj+CHV
	0QF5Xkxm6L6uTDNxuPCmIOzMSp8wjC1T9snzvdFWr/lQoOO5DxNbn0uRnCuO/HCSEAiPYE+Xb04
	4gfGypRzo+FSot6iPWu4d6rK5KCfanlS/wJCIbLeO2914LJ2dlFi+lqROVETreq+Kjf1tMrkA87
	MHUkDd+qcXnp5MvaDGT3vox2QugNaq8IggDclpl1XoufpDBFPAhc+f0aaMvI613TlW1eD9b6kSf
	6hdaZhG39LRAvGLwwkJa57fKFGp2iWcMCQIUQhcpja80iVYE2t/PwjDszwsTR/7xCNr9B/wOWsk
	gRnL16usuL2tgjx72lGKKYF25ER/G/iO7y5rfaXNh/LZDxlxklQ5yKSkpcgq78y42r9SmlfeYWr
	q9Hg==
X-Received: by 2002:a05:6820:1ca8:b0:717:866:abef with SMTP id 006d021491bc7-7191789058bmr2582841eaf.34.1794434501099;
        Wed, 11 Nov 2026 14:01:41 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae23095c5csm4206140fac.16.2026.11.11.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:39 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Kees Cook <kees@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] drm/exynos: fimc: allocate formats as a flexible array member
Date: Wed, 11 Nov 2026 14:01:29 -0800
Message-ID: <20261111220129.12128-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The formats array is allocated separately with devm_kcalloc() and only
referenced through the fimc_context. Make it a flexible array member at
the end of the context and allocate both in one go.

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use devm_kzalloc_flex().
 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 9c2ad95799ee..9233cd3b2f04 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -99,7 +99,6 @@ struct fimc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -108,6 +107,7 @@ struct fimc_context {
 	struct fimc_scaler	sc;
 	int	id;
 	int	irq;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 static u32 fimc_read(struct fimc_context *ctx, u32 reg)
@@ -1273,19 +1273,16 @@ static int fimc_probe(struct platform_device *pdev)
 	if (exynos_drm_check_fimc_device(dev) != 0)
 		return -ENODEV;
 
-	ctx = devm_kzalloc_obj(dev, *ctx);
+	num_formats = ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
+	ctx = devm_kzalloc_flex(dev,*ctx, formats, num_formats);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
 	ctx->dev = dev;
 	ctx->id = of_alias_get_id(dev->of_node, "fimc");
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
-	formats = devm_kzalloc_objs(dev, *formats, num_formats);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	if (ctx->id < 3) {
 		limits = fimc_4210_limits_v1;
@@ -1319,9 +1316,6 @@ static int fimc_probe(struct platform_device *pdev)
 		formats[j].num_limits = num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* resource memory */
 	ctx->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->regs))
-- 
2.56.1

