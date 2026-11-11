Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434607;
	b=KodBrPfrpNzYXpyZhYyEPOXfUJ6IgR9RleDPKB6zmb5Tp4I7nzUlMWxPCEOfMkCIZQ8J
	 ihFLaC435HZ7s0nezL9OoWAUbqCsKTQSCHk8WbiMYx1mhABD3Tx/Li+TrCNoNExaekApo
	 IUP2PsUwxWiRnoURDgkSJ/EBSQCpdHWNn1mDjPNoNak0TcNO448ztmK40mCZRgMW+Vplx
	 gJze3p+W7nGv+CVlTEvrcEgxqSsVhTtF+AH8k8ccvuVqN2TkQRXfiggJpMhqoslx/i/f2
	 jSZfbj59RsAazP/JZd0f5fnD31cBpMpGaGB48vI9Bb5/tSNfe3t5TM6Y29OYcEIt8Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sPfQCcrAfCjRkFz6L9qyGHzK9Ch2pW+l+JfxC7qRxyM=;
	b=ZhT60DZ83no/3LnJcGComJ7LfJNgP/+P8B+IkZJxA/scd+qpnacSsm5cA9dC65Ba8xHy
	 V3mk1IE75amzdhYhaCFSB8iCbjWo1JwDXaFYdkGdBseJIiCAcLyCAiIKs4EyUingmaL7p
	 AdSosje3mGvc1KpMFDKwcOnjWmjm4agIYDLdTovXPmGmIuJOvDl8cVlH33Fgkx4HIVKRk
	 t2KK8nEGqyT3yXE7HBAkJP8KNMXuqBhWJ4Brapi8TbRZwJcZeXPAb7piJDoJIUIcAP4Ae
	 SDGNJB/5pIaOrrnCDB/Ju/qXHH8G/KV1r5PXOx6uGKfIcFK7XQfvc0S1dQdfe7ArZZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iooi1+fh;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A8606A8BF
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 22:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A8A8606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iooi1+fh
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-833e671ee9fso3499075a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434606; x=1795039406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPfQCcrAfCjRkFz6L9qyGHzK9Ch2pW+l+JfxC7qRxyM=;
        b=iooi1+fhTQ0aUOc32ZhKgkz1O9UNMa+zxevmLbOPBz/mEWeXMHBi2BqC1slYqP/9/j
         H7AjQat29rhFlAvCMNtz9PLEjKdAzAcOZAIexQNKZmD0Bpo5ERjr1lpFdkzHGD9Cfzhj
         98+MetX7Clz8uHu9SGiGrycott2BLCOhVtNZMS6bRmlTfTF69bhqCZGk+gWC4Ns2a9L4
         LaHllhjjqG+3SIhrH/f3n4ua40qMEOXVft4F03gTp4+5OBjnhEWCsvO9hg0VUjEGGcUW
         Yn2x89N/4He4p0X1ApEbGP0/Tu760MYi4+LV1wrXVVo83TznQ8CHL+BqBdZ9WvI9+fsR
         TgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434606; x=1795039406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPfQCcrAfCjRkFz6L9qyGHzK9Ch2pW+l+JfxC7qRxyM=;
        b=oI8R9UbPSkSDMFZhr3GUjTQbkXIPu60nVHo8lNLq+qkB1TMjgiVWJh8ki6MwybkSsA
         hbeZevQmrirbhBO0AgAwuxnBGNJczJ+DM6IlR5KYNXNubAAOd+421xRyIKZdWIRc7WUb
         99M0oZfr/R29EcUX8VyGcfU2Nzhu8Tli2sQi4gTjYRU1/AWtHGymFoWpuQD4bsFESUkp
         XjTmofpJMfzFXdZRjOYezbGNYGZ08THLqj4OF4b18yaYCXr4nu+ipMzHH/1wLlkdKXe5
         sEvc/YMdpIKvBGXjRSEOUcV4ar1At/IzykQFBMjxLHyAd2rgwgb9eq87cQ1PI+fWy7fT
         VzHg==
X-Forwarded-Encrypted: i=1; AL+hErHOiMYTFXalZdHwHnaHMMqRn576PtaUbAwaUMHuuCd7aFn4S0OhQ2wAY67TnSYffoBfpz65B8E0NFIJN0AXV8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U81iXSY40B/v6SMIN3ft+ilM0p222Fgg/0ddsa2vKoTZ9Xpzd
	DL3ItvKtbkbYzYw8tgB4L4EBfRmt3qgkIwihAym1ZojcfNBr7RVc8NgM
X-Gm-Gg: AYBFou3izBpOEIlKUIuFItB7o3nC8IT1dRywhfLlYu5s+LpKancfLzWkGsJjQsVKEzR
	g5mJtNzVxTVjSX7YDJTCvt2G2O49nbXTUGGgZix8VziMB8ywQv5aS9OopH45L8DtX8th7wy+fWO
	6cbrIQevz4K5a0G240z3SEfi9ItZu/15t6FivL9rRP+1OZGPq7dkCIhTtoOCuFys+S4fC+hLXmG
	R61R3S5+sBdn/xXLQMwVyDE6hdO0NjPKdY0fL4grOrB5IXLy0sCD+cNAFfylTLJXG8upjg32hHS
	z1uMCMXP57WFKM5ZrGRZPp8DL7R+ltAjG+JSTl6znvEqVvj706IWUFGlLv0Gm4cRPgovywLGhVU
	FQvH0Pv10LcTi4h2w44ShmgikkLfU7eHT2fzUUF21wWnaW5zEG5fgE1t4f8Rf2jdEkhfg9r8/Hs
	KV5WfxHs3oRYkWKThvJ/zZcmSqvkQw98QZZbgmYmSWWwvVy9dmWVtrPp2CtjAKtgxiaWY3Di8Tb
	4Ht3J6Z71D0rTPRTPUljjGJJpJxbcKbcMAt1lKDxV/3SX2k9Qz1qyVhb55Y1PeDU9d2vgt5+oRM
	N+JPrj5BKd1rTlzQyoDNwu2AbJudRd7rQV6X71NXRUMeYLIjNIkhirv/JCuJvEhgyEVXftGOVmf
	e4NoAc/rY/bprMtfFDaALazuHjWN4STF3WIjY80XmDD9t/fK2S3nc4oCSClX3AEIARp3Pv9+cv5
	bT
X-Received: by 2002:a05:6830:270b:b0:822:b35a:a2c3 with SMTP id 46e09a7af769-860f25eafa0mr3652101a34.3.1794434605465;
        Wed, 11 Nov 2026 14:03:25 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8615518d641sm236715a34.21.2026.11.11.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:03:24 -0800 (PST)
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
Subject: [PATCH v2] drm/exynos: gsc: allocate formats as a flexible array member
Date: Wed, 11 Nov 2026 14:03:08 -0800
Message-ID: <20261111220308.12684-1-rosenp@gmail.com>
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
referenced through the gsc_context. Make it a flexible array member at
the end of the context and allocate both in one go.

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use devm_kzalloc_flex()
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 4a07deeb382b..303e94df632a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -99,7 +99,6 @@ struct gsc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -110,6 +109,7 @@ struct gsc_context {
 	int	id;
 	int	irq;
 	bool	rotation;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 /**
@@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pdev)
 	struct gsc_context *ctx;
 	int num_formats, ret, i, j;
 
-	ctx = devm_kzalloc_obj(dev, *ctx);
+	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
+	ctx = devm_kzalloc_flex(dev, *ctx, formats, num_formats);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
+
 	driver_data = device_get_match_data(dev);
 	ctx->dev = dev;
 	ctx->num_clocks = driver_data->num_clocks;
 	ctx->clk_names = driver_data->clk_names;
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
-	formats = devm_kzalloc_objs(dev, *formats, num_formats);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	for (i = 0; i < ARRAY_SIZE(gsc_formats); i++) {
 		formats[i].fourcc = gsc_formats[i];
@@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev)
 		formats[j].num_limits = driver_data->num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* clock control */
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ctx->clocks[i] = devm_clk_get(dev, ctx->clk_names[i]);
-- 
2.56.1

