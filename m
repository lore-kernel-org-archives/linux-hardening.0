Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BD378D9C
	for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893644; cv=none; b=ou+mb0NHD+1G5NwZ1jwcm+yRZdyEvQvc2SKoXRewlNdj8cqCFMGpfjdcUm2wcALlkvkgMq7pkIrby2PCVxc3YDcGbNeOTd6fn4ak/FPxjZJ30H2KPhbBHcgUwLBzb+f/UQnbwJi6CmttqG52hacuTW44x8wJPmHQXRoxhbzxH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893644; c=relaxed/simple;
	bh=XB/FXyBc5Jaregb9hd8KLGeQNU5RAms9ksjPvVxmUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBlgQcosKbIfKvzbJtmBoOYLrJoJh06YkTzGgf7DOai8wKa/5NvbisUWcz9szPKhWhTvE57t2/GxdZjbeGO4xQLYwYbe2WjKGclI4e5Puphwphhp+Gpex8ZZDHSIvQiszUZlPXlokotSdJQbg09xxferwXBgt5eOemMpMMKt5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g68vZbOW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g68vZbOW"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so125690a91.0
        for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783893643; x=1784498443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIRKxzKpxKWrf9QwtK6Xlt/4yAtQNiP0hgI5FE3Urag=;
        b=g68vZbOWHuExJvNrqF7s8VcamZ1I01pKUZTiwYVI2CoqoxJuTVNGxgpngwq8NMWBw8
         xoIxA2Zij8YDYCR8I8Ge2ID8JOH8NN0VVpcG/45uaC167DzalqNcNIAoT80SXRph+Ibj
         smcUIxAYBqbqk21pxF8VHnm//z8Mq1gx0O61lGTpOcxGchQOC6WVjrcIYTt57bgNzHIS
         1WUuxczZUjG3GlYV2UFbWf0AMMU7ZHM2kgYCSnvUMd5Lsm2vypn0ZrsejdbO8RoMmPOO
         tTQecUB0naKAE1l7K4cAu2OK0MkXwUcW+kTdtuEU8ydgx/3gdR0IFqETkSd0l/Bmr2eH
         dwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893643; x=1784498443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIRKxzKpxKWrf9QwtK6Xlt/4yAtQNiP0hgI5FE3Urag=;
        b=q/qtag0ZhnkBE2RQ/0oKdb88LxIOVjmmkgKUT3XMy/GZYYQE1vlLNCvhDaYCAydqI2
         dA9zc5i+ioj4UoRrhmwcTrpuFUlgLWzqLGTt6fPwl07bhQvuGCMk+XW26MBrJWIMnpAi
         +KnQGj5979SEbdQFSo3cI0nYXMqvQcJv34gvh3xj6xuG4UCIC97uQPAshcsiqM13Ug7s
         AQvoES5wmHsJrg9UudONH3fV0YZRLLLLvJ+lr6e3NeL4OJSy/UHkkpjBFpZmR+pFicdw
         N8ZrZSo7MJRp14Bw+h2a297zgCNw2fWccVNFHyaPBLnH89BA7+8vHRhbZhYUcUfZrk82
         sXyw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/2ZjSaHczG7k1gsBMarKApB8W98+aoWeWBHG9Gckq4E4qT7BYB4b2S137iLYD7F3ljJSxP4qJivv4M6vz1pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLO/sLd1t5MuC9UW0A3FjUlAmw55ZEXwpVfQIDiFQmNRfT5iU8
	olwSWKUY66yO2jMDsPgLwLeBr4Wyh/ctkPp7Ra54FOXw3sFMTqvFzEKD
X-Gm-Gg: AfdE7cmuQwWPC56hk7NzOYmWouF/HaGfj6W9ydF0NQ/2W+wbjCV/d5Q1CPMcj7on6g0
	nc1mcWuefiTrLFdHOw2AquBiMprCVnGfhG546WxUErjm7aLaTz7uaw3qOi25Uz4w0X4yrLfTFrw
	SAmOrV8DuR+Lcb3z88VosEwAtaB+Nl7d/HdjqxxYWfpsxOBeh+We7pPcqrHjl8GGfJiuKnIdras
	dJIbGn3c/QGD8nLowlqNduDTziEc+prNAdXKTiooNAre2SWu4aPAXK6vvPpVcdUc75Kduleh1xk
	YMgy4mRq4BUzNNvn5p/gD8UydPdloh766mQblmv0c6NgodpDNOXefVK4kwZ3mKjeGtM7jbvTjF/
	7rfHBmIWIKNG7BKqtLZ0HqniaQR5+wYAy52K4m2FXw2kZDdTLLBG/U7/XxgUiwO+Hoe3NQuWt7N
	6CQVHLyWna5pQ8493WEjNjXPou40dpsf+6xFT5C4UNA8E8iPovvihuOf8+d5idsc4NaIv20jDB8
	JTRnEIY7y0dmxUtg7ZU0fEqmGkSXC6Blfsl3kVe4jikoR64t3CHMmJE23eBAfR1KltfF/vYSumn
X-Received: by 2002:a17:90b:2884:b0:387:e0db:bc22 with SMTP id 98e67ed59e1d1-38dc77b3846mr7049245a91.34.1783893642805;
        Sun, 12 Jul 2026 15:00:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm14856305eec.13.2026.07.12.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 1/2] dmaengine: idma64: use kzalloc_flex
Date: Sun, 12 Jul 2026 15:00:38 -0700
Message-ID: <20260712220039.924958-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712220039.924958-1-rosenp@gmail.com>
References: <20260712220039.924958-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Remove idma64_alloc_desc. It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct idma64_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/idma64.c | 30 ++++--------------------------
 drivers/dma/idma64.h |  4 ++--
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 5fcd1befc92d..d914f50ec309 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -192,23 +192,6 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 
 /* ---------------------------------------------------------------------- */
 
-static struct idma64_desc *idma64_alloc_desc(unsigned int ndesc)
-{
-	struct idma64_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->hw = kzalloc_objs(*desc->hw, ndesc, GFP_NOWAIT);
-	if (!desc->hw) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void idma64_desc_free(struct idma64_chan *idma64c,
 		struct idma64_desc *desc)
 {
@@ -223,7 +206,6 @@ static void idma64_desc_free(struct idma64_chan *idma64c,
 		} while (i);
 	}
 
-	kfree(desc->hw);
 	kfree(desc);
 }
 
@@ -307,10 +289,12 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;
 
-	desc = idma64_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
+	desc->ndesc = sg_len;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct idma64_hw_desc *hw = &desc->hw[i];
 
@@ -326,7 +310,6 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 		hw->len = sg_dma_len(sg);
 	}
 
-	desc->ndesc = sg_len;
 	desc->direction = direction;
 	desc->status = DMA_IN_PROGRESS;
 
@@ -541,18 +524,13 @@ static int idma64_probe(struct idma64_chip *chip)
 	unsigned short i;
 	int ret;
 
-	idma64 = devm_kzalloc(chip->dev, sizeof(*idma64), GFP_KERNEL);
+	idma64 = devm_kzalloc(chip->dev, struct_size(idma64, chan, nr_chan), GFP_KERNEL);
 	if (!idma64)
 		return -ENOMEM;
 
 	idma64->regs = chip->regs;
 	chip->idma64 = idma64;
 
-	idma64->chan = devm_kcalloc(chip->dev, nr_chan, sizeof(*idma64->chan),
-				    GFP_KERNEL);
-	if (!idma64->chan)
-		return -ENOMEM;
-
 	idma64->all_chan_mask = (1 << nr_chan) - 1;
 
 	/* Turn off iDMA controller */
diff --git a/drivers/dma/idma64.h b/drivers/dma/idma64.h
index d013b54356aa..1a67dbb24db5 100644
--- a/drivers/dma/idma64.h
+++ b/drivers/dma/idma64.h
@@ -113,10 +113,10 @@ struct idma64_hw_desc {
 struct idma64_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct idma64_hw_desc *hw;
 	unsigned int ndesc;
 	size_t length;
 	enum dma_status status;
+	struct idma64_hw_desc hw[] __counted_by(ndesc);
 };
 
 static inline struct idma64_desc *to_idma64_desc(struct virt_dma_desc *vdesc)
@@ -187,7 +187,7 @@ struct idma64 {
 
 	/* channels */
 	unsigned short all_chan_mask;
-	struct idma64_chan *chan;
+	struct idma64_chan chan[];
 };
 
 static inline struct idma64 *to_idma64(struct dma_device *ddev)
-- 
2.55.0

