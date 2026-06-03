Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06A3E7BB6
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456110; cv=none; b=cCxp9T0O7O9lmuA/zNIdeEQ2G0G67ydK00pLO2yc7cXQye56TBIHYWVfVAF4N2h+p1prxuhhqX2WhavRapwOO5pcuMwxy1iKCNN3S8dZcmbHzN1SIbO733bOsfC1per6Ua9nWYkJVOcZSwm0dpzk4YdO5uQjOI5OGPKXBwFUaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456110; c=relaxed/simple;
	bh=34Zm3W7woqTMi8w3X3JA5sjumybeyKNHi38eRAQVT+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlHJPceutKFdFQHwdWhx5q79sG04b0aGDNiPfhd5stqCmltzcgGS7DQ9Di7zI+Az1q+zT17BOrow3sA4w9iFo181dkR04stzTKgkICii13JDizyxs97CXenczG/bfW9K/erF92Paaorpa7qocDnhksXyfVK9Vqk+R2qHgAAZuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkJj2lKP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkJj2lKP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so3041975a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456108; x=1781060908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USwZ93J2NNYew7Ti1RVaXMO67Ur9p4DSXE1j33WNuVA=;
        b=AkJj2lKPM8B0v0YonJE34FMtNClizjxYTrInkqFDett8hGvPe2Tc7Wk9jcsjdF9xpE
         90eJtXS2owcBDYj5+9h/nYlwhXXfPUJyzPfkNUJhs9AoL5WbL/5LBmSq15kCwgCwIgoR
         0MAPkm4TdSMFgsh7h+bsEw5s1sOpnqr0+d6BWBK3vYtGoZomy0EDS9Z9fgf4SRZSQ5BT
         8rTsmBfL/GdTv1Eby6GXi9h628uq1JlC9N3kdoqxSguLw9tWqxStaw76h27HYhPg/+ZR
         hyJd0oTYjdk6t+nc3ZiX2kLJwy9B0SBHRnxEgb+ZAbcJ3UCeLH0xGi1KGA0Tg+ezkixQ
         8eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456108; x=1781060908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USwZ93J2NNYew7Ti1RVaXMO67Ur9p4DSXE1j33WNuVA=;
        b=SmPW02i86pMTYkjE9jSf1XRBlnKO41a8Y2CANfykUN8TGPrs9I0mrIp91Pb3X3rKij
         bVe9VGL6UWp5noK4j/vPpObu/PvdzGDFZ1rBJyUP31JYP+sRau2V2ox/c/WIgDsg08cl
         gg+X7wjUUd9VbiKeely98PxiHIv4ct1KPcZigiJJzbxf0KKqQ/z2bnyCwvWIVQT1gO8u
         /hK5luWa63gb2R0SIX7K9iGnRZK73qsGsRWqqVywzYky4HAhGSawRhD/WZRjzv3piHk7
         7oX5s+sleZzItLEzinB0M/ftx+kinyaUDiJX6UOyHlrQLsphzy0lzqoQ1HX7Tkoz5Kqv
         0YNw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vf738Yzw6+NliUM0qKvmWIZKm1rM5jwupORTH3pVZRSy8LOSEbcd2D2TOWBXa6G4mGyOYNOeptXGoSCi89Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25KQd7qww4lusIIOTNGnUhHnnVmkP2XYE6hQljfU7KvCQYROo
	Lzyzb6D9/n9GffeyyZg1ab31QsEGtIDn1/K3PB8jdwdqUjX02mIPyZKb
X-Gm-Gg: Acq92OHG0ItECVQIXdgety5Mwl0YE6kG9CWL7o7bOUPpL3aa0GbnfpGIsUoP8ywCfFH
	k9UYKGx98Lkgmquwsqu3oMIixIXo8X+z0hIeCxDDzsrh6eOLgMKb6gtXcEkRuiOcdbavCEU/6vh
	w5qs6XPRYB6yMLEkBBJMA7LONa+k46DV6D8cCzSnQqybmXOZA8RkXz9rvHy7iWCcF45LdCWKwJ5
	8sHO5nd/fkTDnfoVjGqQVaemqFT5QnPJAKMKnXpzx7S9gaBwG0mwQh2UgFMHkIRJPtZ0DGXM8U9
	2g0VLa3usm5Q74aBBN4JW+RSgRqTbAVQysd7LiEJMtW45j1Nb/+2mo88c3w3xwxGbWTbUloPPoV
	cF/Gou7ax/CtvEWIBHJeCFw8N4KJs/0ID/LttZA5UTEv7QlLRbjxMzEOODoWb6G/rQIKG4ym0KW
	mTuk8A2jz2VLzKSaLDUxKKTvtxauK83zz8LNofrPQK4ALgZU2/y/65rvvC76zbHh5AKW6zxR4Mr
	atcN9/HiIt6mvT+jqIdlXb43vol5NOssNcCX0FJmA9Cbg==
X-Received: by 2002:a17:90b:1c0a:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-36e2dc53790mr1396861a91.0.1780456108116;
        Tue, 02 Jun 2026 20:08:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 8/8] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Tue,  2 Jun 2026 20:07:54 -0700
Message-ID: <20260603030754.288757-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the separately-allocated lch_map pointer array to a C99
flexible array member at the end of struct omap_dmadev and annotate it
with __counted_by(lch_count). The probe is reordered so platform_data
lookup and the lch_count determination happen before the parent
allocation, letting struct_size() size the FAM and the dedicated
devm_kcalloc() for lch_map go away.

Two allocations collapse into one and the runtime bounds checks from
__counted_by now apply to every lch_map[] access.

Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 72 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 7343325ce2b1..dab600604572 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -49,7 +49,7 @@ struct omap_dmadev {
 	const struct omap_dma_config *cfg;
 	struct notifier_block nb;
 	struct omap_dma_context context;
-	int lch_count;
+	u32 lch_count;
 	DECLARE_BITMAP(lch_bitmap, OMAP_SDMA_CHANNELS);
 	struct mutex lch_lock;		/* for assigning logical channels */
 	bool legacy;
@@ -58,7 +58,7 @@ struct omap_dmadev {
 	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
-	struct omap_chan **lch_map;
+	struct omap_chan *lch_map[] __counted_by(lch_count);
 };
 
 struct omap_chan {
@@ -1661,36 +1661,55 @@ static const struct omap_dma_config default_cfg;
 static int omap_dma_probe(struct platform_device *pdev)
 {
 	const struct omap_dma_config *conf;
+	struct omap_system_dma_plat_info *plat;
 	struct omap_dmadev *od;
+	u32 lch_count;
 	int rc, i, irq;
 	u32 val;
 
-	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
-	if (!od)
-		return -ENOMEM;
-
-	od->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(od->base))
-		return PTR_ERR(od->base);
-
 	conf = of_device_get_match_data(&pdev->dev);
 	if (conf) {
-		od->cfg = conf;
-		od->plat = dev_get_platdata(&pdev->dev);
-		if (!od->plat) {
+		plat = dev_get_platdata(&pdev->dev);
+		if (!plat) {
 			dev_err(&pdev->dev, "omap_system_dma_plat_info is missing");
 			return -ENODEV;
 		}
 	} else if (IS_ENABLED(CONFIG_ARCH_OMAP1)) {
-		od->cfg = &default_cfg;
-
-		od->plat = omap_get_plat_info();
-		if (!od->plat)
+		plat = omap_get_plat_info();
+		if (!plat)
 			return -EPROBE_DEFER;
 	} else {
 		return -ENODEV;
 	}
 
+	/* Number of available logical channels */
+	if (!pdev->dev.of_node) {
+		lch_count = plat->dma_attr->lch_count;
+		if (unlikely(!lch_count))
+			lch_count = OMAP_SDMA_CHANNELS;
+	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels", &lch_count)) {
+		dev_info(&pdev->dev, "Missing dma-channels property, using %u.\n",
+			 OMAP_SDMA_CHANNELS);
+		lch_count = OMAP_SDMA_CHANNELS;
+	}
+
+	if (lch_count > OMAP_SDMA_CHANNELS) {
+		dev_err(&pdev->dev, "invalid dma-channels value %u\n", lch_count);
+		return -EINVAL;
+	}
+
+	od = devm_kzalloc(&pdev->dev, struct_size(od, lch_map, lch_count), GFP_KERNEL);
+	if (!od)
+		return -ENOMEM;
+
+	od->lch_count = lch_count;
+	od->plat = plat;
+	od->cfg = conf ? conf : &default_cfg;
+
+	od->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(od->base))
+		return PTR_ERR(od->base);
+
 	od->reg_map = od->plat->reg_map;
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
@@ -1735,19 +1754,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 			 OMAP_SDMA_REQUESTS);
 	}
 
-	/* Number of available logical channels */
-	if (!pdev->dev.of_node) {
-		od->lch_count = od->plat->dma_attr->lch_count;
-		if (unlikely(!od->lch_count))
-			od->lch_count = OMAP_SDMA_CHANNELS;
-	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
-					&od->lch_count)) {
-		dev_info(&pdev->dev,
-			 "Missing dma-channels property, using %u.\n",
-			 OMAP_SDMA_CHANNELS);
-		od->lch_count = OMAP_SDMA_CHANNELS;
-	}
-
 	/* Mask of allowed logical channels */
 	if (pdev->dev.of_node && !of_property_read_u32(pdev->dev.of_node,
 						       "dma-channel-mask",
@@ -1759,12 +1765,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (od->plat->dma_attr->dev_caps & HS_CHANNELS_RESERVED)
 		bitmap_set(od->lch_bitmap, 0, 2);
 
-	od->lch_map = devm_kcalloc(&pdev->dev, od->lch_count,
-				   sizeof(*od->lch_map),
-				   GFP_KERNEL);
-	if (!od->lch_map)
-		return -ENOMEM;
-
 	for (i = 0; i < od->dma_requests; i++) {
 		rc = omap_dma_chan_init(od);
 		if (rc) {
-- 
2.54.0

