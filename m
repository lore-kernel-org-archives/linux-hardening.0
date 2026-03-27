Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5930C35C
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580402; cv=none; b=VFhRyobP/amDJjjq87bEhsPUC0ui0GzqdwvTE/7sAbK91yrlrP3Eao1KMsw/yLV5SccMgAnE35kzGskUlz8qumewGPJdqM/GFMO6eiUuQ884gnDsk6Sf7NuPSXL7XGJ0BpnjndF6bpbjbAnksGY1P6KXAry0ViSoO9ExGj9McLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580402; c=relaxed/simple;
	bh=hKwae93xmtHYAdjpVNsr+gAY5z09ypQ9lhd/Gtk52cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrU7D0ZENWfIkhcCEG8le1K9Y99kvA3aZEn2RDUCAEq/BfxpVTaXsVWyUH5euxhGs+riBqCzItTbuvH8ZDqNY2X7aY1xxra3FXvKwrIhqKgfzMrYkS0emDknNRYoSpoCCGpgI0HGo0tnpKQiODBziYdlalaTaFQhxTQqwbA5J6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcX3uQpZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcX3uQpZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aaed195901so7076855ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580401; x=1775185201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AE2oYD/S8jc9LBiWpGPXEFCYuSoSUhxv8UwWq86+mY=;
        b=rcX3uQpZJqRcRhVX63HBhEr/SikcY1kb29Lcm1S3LBTCgONVANSzO/vdJml9J9DQQJ
         mLOMiESny304tPuNyHnoATbeOFfgu6ttwgcMO1C+B+DJ/VEcYBejuaDyzKZzs4BFr3cZ
         b0jkIAmmG/ILbJMze/kKiB5lWR+/ti81fARnoPqjioZjQH3+u+YYB7Ja1kbe6hhFp2Zq
         gQ7dLw0wr2MA1u++EHgdAxhBCac/ciNSghG6pef32q8Z9vMVCMk9gmbYm+4nZEwHFtAA
         CvX40ynGeHKSqhOKvYr3XjifMF49Qa8AW60JAciTirZxwK26aXIHa2An0dvLWj8E9rUZ
         lbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580401; x=1775185201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AE2oYD/S8jc9LBiWpGPXEFCYuSoSUhxv8UwWq86+mY=;
        b=Liddw9X2bqhpy+3jHktnMbq0ao1/aRNancQgm5LGqmyyCTeZ1xc0XSZ78/3x12bgAG
         eisEDEPxHIdeP0Auq+jgxc5Qt1lg4HXnzHkMNZ19AyipQ6OVz6naNqKR4FdBz2LhfTt4
         uZRKukqhymINHJBIxVUUMF3p06Ix778Y0uKi44sInTRUOaE5oCiY+AQkES6Iku6dL3vj
         Q9B/3u2l2tDU3+8NcFN7Z78HjEdhBbAC71N2q3l5MnHbk5yGBCbBjQqoeUiAnDTUf4OD
         BYdrtfTN2GYTaPeq0WtMbVfTZM0ALmyP2fiid+5FFEsOQRYbKZkMxATUEep8pLl2jTWx
         k3nw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Su/jwuex8jpOKUK4bNK/8WrQFBc0RvZJI7DnWZD6MHC+GLl10kGw6Mytpdyu1N5rr4b+oQ+Xmu45fGLUEks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5gmoJ5wDBcnJDudICK5cuOODBli8FzqzmftmFDtjHMdpX1tLW
	n1jNtGcS9anXEHZID6qfHy0VieOvLQHgcvPbQ0tAaCSnDK8aVDf3qluj
X-Gm-Gg: ATEYQzzOD6TOE5F8baZPd1GcsDBjqeAy7tnk3ze5uh/u6mx80gDU3ejLdAHJXdK5gYb
	kI4fa5ETIqyvt9DZ0IAstgqDd+salKYI+wSRWp1hVG8kfwnlAw4AFSj1cruMqn4PhEZyF9rWcy2
	u6OjyQDs61ZSF3RGWu2yYQu1+a93U7pWQ0MKdnJPLt7jJd5+Eiz+LoFkZp7D9bxLbFDcuIn9W2M
	LAf8/61AgZleGBE4HgCmbd6SCKd/wbz5dTlhsWZT9F+oHJsVxsTLWm0UuJwIA9YDHG7Hkh8YPWW
	9jSaHffz23gUU56EfL0y/ESWw9daGu/CMkPjBJlKjNDMS0TYm7f+gH7oUmZzyoZTyvLNvMXwTd/
	CZ3fSjgKaduerICuyFInuWGYu/q0F4PWUUMqNNzV8pRPyg7gu6k+81AoUCqrb33xjjLkku+7fFU
	LqOVnR3svMdbCPmJbUW5JlEPHaOAOE6NoGDS65f6kz39da2TJ7JKWRZRgnNAoZrA63Sg==
X-Received: by 2002:a17:903:98f:b0:2b0:b075:f2fb with SMTP id d9443c01a7336-2b0cdcb87e7mr10769425ad.35.1774580400926;
        Thu, 26 Mar 2026 20:00:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm44174115ad.59.2026.03.26.19.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:00:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: hsu: use kzalloc_flex
Date: Thu, 26 Mar 2026 19:59:43 -0700
Message-ID: <20260327025943.8178-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Remove hsu_dma_alloc_desc. It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/hsu/hsu.c | 37 ++++++++-----------------------------
 drivers/dma/hsu/hsu.h |  4 ++--
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index f62d60d7bc6b..150c6567eede 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -241,28 +241,10 @@ int hsu_dma_do_irq(struct hsu_dma_chip *chip, unsigned short nr, u32 status)
 }
 EXPORT_SYMBOL_GPL(hsu_dma_do_irq);
 
-static struct hsu_dma_desc *hsu_dma_alloc_desc(unsigned int nents)
-{
-	struct hsu_dma_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->sg = kzalloc_objs(*desc->sg, nents, GFP_NOWAIT);
-	if (!desc->sg) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void hsu_dma_desc_free(struct virt_dma_desc *vdesc)
 {
 	struct hsu_dma_desc *desc = to_hsu_dma_desc(vdesc);
 
-	kfree(desc->sg);
 	kfree(desc);
 }
 
@@ -276,10 +258,12 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;
 
-	desc = hsu_dma_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
+	desc->nents = sg_len;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		desc->sg[i].addr = sg_dma_address(sg);
 		desc->sg[i].len = sg_dma_len(sg);
@@ -287,7 +271,6 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 		desc->length += sg_dma_len(sg);
 	}
 
-	desc->nents = sg_len;
 	desc->direction = direction;
 	/* desc->active = 0 by kzalloc */
 	desc->status = DMA_IN_PROGRESS;
@@ -430,21 +413,17 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 	void __iomem *addr = chip->regs + chip->offset;
 	unsigned short i;
 	int ret;
+	unsigned short nr_channels;
 
-	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
+	/* Calculate nr_channels from the IO space length */
+	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
 	if (!hsu)
 		return -ENOMEM;
 
+	hsu->nr_channels = nr_channels;
 	chip->hsu = hsu;
 
-	/* Calculate nr_channels from the IO space length */
-	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
-
-	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
-				 sizeof(*hsu->chan), GFP_KERNEL);
-	if (!hsu->chan)
-		return -ENOMEM;
-
 	INIT_LIST_HEAD(&hsu->dma.channels);
 	for (i = 0; i < hsu->nr_channels; i++) {
 		struct hsu_dma_chan *hsuc = &hsu->chan[i];
diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
index 3bca577b98a1..f6ca1014bccf 100644
--- a/drivers/dma/hsu/hsu.h
+++ b/drivers/dma/hsu/hsu.h
@@ -71,11 +71,11 @@ struct hsu_dma_sg {
 struct hsu_dma_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct hsu_dma_sg *sg;
 	unsigned int nents;
 	size_t length;
 	unsigned int active;
 	enum dma_status status;
+	struct hsu_dma_sg sg[] __counted_by(nents);
 };
 
 static inline struct hsu_dma_desc *to_hsu_dma_desc(struct virt_dma_desc *vdesc)
@@ -115,8 +115,8 @@ struct hsu_dma {
 	struct dma_device		dma;
 
 	/* channels */
-	struct hsu_dma_chan		*chan;
 	unsigned short			nr_channels;
+	struct hsu_dma_chan		chan[] __counted_by(nr_channels);
 };
 
 static inline struct hsu_dma *to_hsu_dma(struct dma_device *ddev)
-- 
2.53.0

