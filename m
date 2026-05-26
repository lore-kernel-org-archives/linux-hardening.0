Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382ED3AB27F
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826427; cv=none; b=g8sql0Cr7PTwJ+Yvt4B1dTkyqMcCNnKGjg2hOFyl6xfJcyL9Fk7XI5e5eLizCvCigfv5PjTPJUxpsvlEircLTDTeS+nA/ccyncYwRJZspV/s04yjzQ0y7zI28yLnskD6K33WnpqUAaSBAkJZMIqtoumYXf6q04sUMLlUOVMWsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826427; c=relaxed/simple;
	bh=0yozOr3YMMLvIJ7Pg2i20S4dujIxpKQywfb9wu2kFuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYuMTcX5LyukJ7KbTQSIgVN5mBIHBWSdKs4gDKjyKTGRTZOdis4nzJe7rZ41xOcqJj7QAv1LdGmEAC1SH+1uTWSmRlTqpe1sWEgD8DUnGoERZv6B+e/IhfDV4VDdJbUfyIG130jqs5D21gH8yKpIsjwppOz53aRwWscU++RD8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6IncZVV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6IncZVV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516d634956fso53708061cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779826425; x=1780431225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWd93ZUjTZ6c+vkNq74krCnjTZmGTPFD0wYAFgGdBDk=;
        b=I6IncZVVMPbK8qkIkNla8FiG+HVGxUDKYhD/3gr+T7fKtXtHqBgxfzrBr3RkjeT6D1
         kgxgMqV90GhpkpY/vvjttREv3OugL5UxQ+hvZH64Jbvm5XOHlBx+JyTk5aPEunU9S7t3
         4pD2gImFalLPVS6BS05diuIGsSQ9geMdTygFxlVC7+a084oc+HXZ0AOUo4qRfySFGk2f
         WPKSr3m+BJhnlMbfOzrub4qomWk0zskIOJjiNpTThGNLE+V8RY+h/TKYmM69hQDaCCHg
         mBLRp3N17Bey7sbnIh5u//YFMBDYh3VLyADerV6UnkmsjgeDDp6J4yeqD+aLoOln0KcL
         MeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826425; x=1780431225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWd93ZUjTZ6c+vkNq74krCnjTZmGTPFD0wYAFgGdBDk=;
        b=m8QJrh5ZO5UpDLSzw4O1Os3FYxz1RxOtCd/i/FHySM0+lAAu89inqga7bGpYBkfhwL
         tFTEp+a8zOFLTPDPaZkMCCw+HiRp5hGiMWlSYVD9/U//3tI75ZVK5dE5RtDrjLdcAXPa
         R4ZHtV1QXUFYB8BuaK5iP+ZIX68o+ybH2GRK+G7ajJ8f1kLUw4NF6NhAF2fRS/iIf54S
         0pB8anJMFgRFrfhd45e/rqxlU54OBokFpXyrv1zCU5rRtC1jRTXAZY4L52XLF/TmY1im
         77QqaNJMMPSEg/u7RAEqzHJ5BiqMFGifGZlmhFRFiyJfhzZLp25Hi8tQFE8EmLHESN15
         Pl0g==
X-Forwarded-Encrypted: i=1; AFNElJ/5hoitjLTSSi2ZUain+veOwbuHniOWc93uGb9E6GAcJ2j5PkgBzVx5lBkWFCde7Rb2sJojU6CHalgxaGFHESg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Khcw8KG5i7zSHrTsAAycknSG/L5agdIvF431UruuGDX/CGYN
	miOK5lInFWFudNWsYx0Er7inDI3tKyU6jp9GnY4FNW/UpA6kok17J/nO
X-Gm-Gg: Acq92OE2NoR/2VOGFVtgaczgtBOyoZXWgT462dRMBbI5NZF+iI8oTAvUTH031gystQh
	ChcxyXELMPw1o9mPnJ3x+Jc7ub2GHHeu2f0YsZ64F/yjUssWor9ZcUnmk9VjwBQXOFcjqkAQhot
	9TpzZQ3yhhRVSWdx89LXMKjYYKYUJDFXlYqzZQ5kJAXi6DCQwPkC/O6BfpZ2DfwV0A9JocGOYzb
	X3HvX/kgG75KcqQZfUltB3jM6nHHyls/7r7LX0I1AmqADK1K4YSo0Vjm9v0Rec5Q3iOieiyHQaF
	A+cLd6PfCM9Q/kVTjtrMWqVQ2zpNr5cRRj+zLMxIcbWSLdP+2/+CaMw/yN+BRlgSeqe0e8mf7/3
	NzDqJnhF2HBvVfGlEnSpsmhHT5tu3oZs3yIF3iikhRxuT0/rNKYk0CVEWVnY6t4Csh8xqP0q/oB
	xrS24/t9w5rZWZ1Ic0LgJVyytD5ZPJZCX056qz7pfT/nKk8F/F8efEMsHxn+9/QlMLi+hDmgBa1
	fSL+lUsTzTGwylqmxRaic0rT0fc5PTK/gA=
X-Received: by 2002:a05:622a:8597:b0:50e:601a:2183 with SMTP id d75a77b69052e-516d440a362mr225416341cf.41.1779826424957;
        Tue, 26 May 2026 13:13:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170b691d15sm15563071cf.11.2026.05.26.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:13:44 -0700 (PDT)
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
Subject: [PATCHv2] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Tue, 26 May 2026 13:13:27 -0700
Message-ID: <20260526201327.13225-1-rosenp@gmail.com>
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
 v2: fix sashiko warnings
 drivers/dma/ti/omap-dma.c | 73 ++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..0cccd6663628 100644
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
@@ -1656,36 +1656,55 @@ static const struct omap_dma_config default_cfg;
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
@@ -1730,19 +1749,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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
@@ -1754,12 +1760,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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
@@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
+			return rc;
 		}
 	}
 
@@ -1852,7 +1853,7 @@ static void omap_dma_remove(struct platform_device *pdev)
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 	int irq;
 
-	if (od->cfg->may_lose_context)
+	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
 		cpu_pm_unregister_notifier(&od->nb);
 
 	if (pdev->dev.of_node)
-- 
2.54.0

