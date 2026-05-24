Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4B14AD0D
	for <linux-hardening@vger.kernel.org>; Sun, 24 May 2026 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590794; cv=none; b=m82loJMkGjknFVi7pzFUif3sNr4iP4IEUfJRBp4Vuynm5RXfZ3e0Bvl4vLPmz4iGokefE9A7/xzTUP8v6mYCZpRGa9LEGp2CiPQ74f7YiZxTn7cJl2nGcExrwpWF/znRJF3MZOR9bCf0pTxvluJlNk4fKn78M1yDRO3sHiwj65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590794; c=relaxed/simple;
	bh=sd0brhKuTlvue1GF0dLTVV6+UoCkGinBIuinD5unjEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BO9tfKfML9cg15Y/x7YTe00L3zn0LUBlmZ1Fn81w1m7/NDvqXEtKlJRYQNKDQMKqP7bXd7s78RomGdFCnMstP/FLOdgtsvdbKgPNf9xCmgNRP7ZJRwk8HyAmt2vUergYnILs7TT9CwlKRL11lij2ZmJljLBjQM+jqPyv6OFJXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtEhhAgq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtEhhAgq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-838d0b7c950so6175189b3a.3
        for <linux-hardening@vger.kernel.org>; Sat, 23 May 2026 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590792; x=1780195592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciC6AwMqgRoG5tvc6gb6RBuyhx3t8/VvHt7IHCf9iAc=;
        b=XtEhhAgqYnOQmND9BxFvLocCL3b1cSimjJ1rIkNdPm4LBxFpcQeCXnr+VB6y+3e5MW
         vn/eNPIL5MTV/r+6LFiwsuYX1oJbpBQRwr5iB31DuJNIC8hDvVIQBzndtV12Xc4IHJlC
         JrBW95e6EkHxBmCN26uP5ARGk1rz0EKT6ry7WS4JlcnfFUojiZTXX53pbrMZd3TIVw7e
         e1hGOOwrYS1bM+wh75TZeZHQLoOdueLDo7b/OhDkVM73Y2/Fj/5MXgS6mzXYQ3W7yYYx
         yKBWVyqBHu88C6JZm0gzppjw6H2IBSsuHi0lsddlBC6Sg1Rf3BXtBE7CWyM7SKGtQrgv
         g74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590792; x=1780195592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciC6AwMqgRoG5tvc6gb6RBuyhx3t8/VvHt7IHCf9iAc=;
        b=Qum/r+iTg9xUkf2D3bVsm83gOg5O2a6vvfPIo+Pbhi+GstQmG6POSmDSX6kl3pLilZ
         UlNsQgPnJZzVrAPwPDyikyKnwVEhEQ07VRhXvGrkBYVc/IsqEbnIKKvNh/yHD5coTDOY
         3yBLAlghEanhEN1oazf3v9hcUz4x2uJR5wET5N0bZtjO58IFUK6aT6wxM99WDhLFetkC
         o78qmoJtzLKiU4Jc6KXtl1bWyW1TuKKmlmyAZRuf318GKZS1qwbvMAPB0fnvRqoVe7Jn
         lIXrUxVOVuXyNcaUBilUFv/Xd1lBJCF2lj2CC4ThyOB5XNNq3lFEHTaqnluIU2VysY8i
         SOMg==
X-Forwarded-Encrypted: i=1; AFNElJ8gk0Th043S6u4RZgzHD7lcB3+YI9wQZJthyUoC52Nf8SeiSVmA9c8AGIaW8Q0MelhmLWnlz8leumgwxUmYT8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsVVXN+PUNVZkIsqBpofnpgyQDE0uxNILgnfZTPioLmY70cy+
	gj10KV3ZE2DrSOfElQTr38NJ29JApkgTHELEShQLSvdcFCqz9rbZUWYO
X-Gm-Gg: Acq92OHyHeAMEf8Z9L45ecd3bwoKfKjZdfadhjRVh+DE92CD/BaDLVrzSnF6X3/eXtb
	lBhT4a90cKZuB7mn1e+e4tisS8OxYO2J2X97doCya9zp7Q5RswbFtxjkwXjLK9q7b1oRoWNzEWE
	gV+qCGUsRm02DTnMq9oFzgPSorXlk7mMp6V1hwAkABrQMM83S6QlQyXvwww2KUoq5JzaL9Rl6od
	phfWjC15k7SevC+V5gUsi32d7Dzrgzb+hTTUvMBqgDZtFCwxJZ8bR8Kii9d08fkIwopr3aNLb6F
	bWBb3hkKrNTjfxKkS50Ttayz9ZWOUgqnsFffx+6k61hhGcH83korLpUdJwAum3H1dpUdd964qg7
	KE26gYzAVNE51C33anMPxzvc+4pzomXDyRUJlt2iRFJeISoj1V7/m+VffqaG8/sUGyENuza4mAM
	o3zv/dniV7HWTkdRUyOCfp07/nTD/PlSV3GaXiulmK9P91oRf4YEPZNCzo0/bKkPdqesU/M/uu/
	VjKppk2kp5lBBbRYbO7iqqmJXc+xDCQybg=
X-Received: by 2002:a05:6a00:4f94:b0:83d:b11f:796c with SMTP id d2e1a72fcca58-8415f3d3adbmr9102216b3a.49.1779590791854;
        Sat, 23 May 2026 19:46:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc6e8esm5490202b3a.47.2026.05.23.19.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:46:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	linusw@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Sat, 23 May 2026 19:46:14 -0700
Message-ID: <20260524024614.182126-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 68 +++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..901e38b08962 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -57,7 +57,7 @@ struct omap_dmadev {
 	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
-	struct omap_chan **lch_map;
+	struct omap_chan *lch_map[] __counted_by(lch_count);
 };
 
 struct omap_chan {
@@ -1656,36 +1656,53 @@ static const struct omap_dma_config default_cfg;
 static int omap_dma_probe(struct platform_device *pdev)
 {
 	const struct omap_dma_config *conf;
+	struct omap_system_dma_plat_info *plat;
 	struct omap_dmadev *od;
+	int lch_count;
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
+	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
+					&lch_count)) {
+		dev_info(&pdev->dev,
+			 "Missing dma-channels property, using %u.\n",
+			 OMAP_SDMA_CHANNELS);
+		lch_count = OMAP_SDMA_CHANNELS;
+	}
+
+	od = devm_kzalloc(&pdev->dev, struct_size(od, lch_map, lch_count),
+			  GFP_KERNEL);
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
@@ -1730,19 +1747,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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
@@ -1754,12 +1758,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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

