Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5764395257
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903459; cv=none; b=Qa8GB+ny5M0nfJNaQ4tJTQAoSOhZRgXWGs1wtsf3oM5PKlE46ftTOR2K2FVBlSJn3JnVRw4bCYz/sAI4RMuOFMb/lVTOnKdVmEa2rLEK0USUXy8LXSfztJDkeo+5CuEKOvw96kiTiFoVTlCpjqixrgPOauHzHjAiU6vqn36O70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903459; c=relaxed/simple;
	bh=V/J/NqbhMxWKwCmcNFvflHQXMGBiNkLsB+ZbVAlGsAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3biWXSDI1m3NblLf0x30flyx/Tvgzp3dUrK+e+BkDhGIqDvOL6+IkagTZ0FljIotFJ80sDoRf3YEoyETcNZ/fuTHLodvJiDwF4WFN+0LBAM8FNq2JlGCZkZin5rbh44kYtXfLCSyzWhEYNvpWEyln9bg0LOyZ963rQ5IXdd08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMPMLe5i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMPMLe5i"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so28057625ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774903457; x=1775508257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cE1sZcA1XZypV//xVG+QNtow8cQCW7Hc34/dIAf9N1g=;
        b=pMPMLe5ij5lAX8tC9T5lVyKmgSzQ3qxVbX9+n78FpE+EMotP88VfWxFmxzSTMzoKiM
         vKRwgDgDD5VcppmwlYcjKx1NSGj2IQX/BeqFIh7+NqjVunS4T4OTb307lMHZ+FBtPYVQ
         ZwNAoBfIQtTvM1ptJC9aKRHLUT8RlUH0ETHIqI65CzbgfXF9X0vwEtropwldd/N9BqBs
         r+EijLK/xHHbO3rtDj9zxuGmZgPcl9BhQ7bQ+JAczhOor1m5yJN5fkgaSi3yBjgwt4ok
         3eowV6jcyEUdH0Cqem7+lOTUWetkYsUUtG9ogQ8vXr9PE4HICWtmetNKUVDTm9+AGYXU
         ZbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903457; x=1775508257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE1sZcA1XZypV//xVG+QNtow8cQCW7Hc34/dIAf9N1g=;
        b=dxHEgdIorsu4ofhsdpB7ero2uUChdThyhHpLmCKA+WsKjcz69BQ2NMKESAhWpAXfHp
         Zv59iLHy4+Exa8yfcfpEykiOWNKyWe4DDWdEH0/kEiX400g8z/zNCnt/SH5kcK2lPEGc
         I6JBT0hwVRY1S4zAxNINDB3fjaXgWwFo3q+XXA3civWzBHQuNxUlpgxxILAbLR7toKZq
         XIEvribkXywL0jBp5atvqm+N9d4peZjxLzGicdKhMM83F0/g0Mb+08mYN9lAHS7N5i5t
         RmWabR+TgGRu1ddNVIRMBw3woSrkQjdzAzZ3zTTJybVx0/t9lNwmtOIHtV7qWKH3BE5B
         rA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7sXJntBu8MSR+vJ4zfGxw41pucjXaPxccNT5kceHRI9mhqcGh0o+gTUTLS2q69uN+HlqjLH6Y6MZvbnKvK1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYR+oABi2lhDPpAgodgefAEOQqKjDdXw9gtvZ8sbsRTB/uIOCL
	ctTTql0Vg7Dd3/51hy8y5/Jeb7SL/DQ3JkkjPK7A+ZAapuChmd2a0oDw
X-Gm-Gg: ATEYQzxEz/aAL3GnHF74dJVOiY18xFpk15pZWJL3x2uEMNzP1ZVK+k96zKoGVUiEA88
	VuoUmzN9UeBuZZdOgAz9XqKlAUvpNdFZehhSGqsverp0SMb8gxeuqo1e0NpCt43YY/p3SfZIPLs
	MTGDncp0B50CsodRKv+WTGk/GWS/r63ZynfTOxfWKnG98Wq9wxZWQ6KoWYVieQxmhl+kTDOZQqT
	IWeEISvfgkMibQ+uoa9vNNaTqUUo8hie3rW+Xet4S+6z2OgSqhob8gJzaYckz0Dih4xRVSCLICH
	ZiSu6jq0/589moyT7QMFF975E6nnjiR3z0zH+I6H99ypBhiZY1W0CoMhttjUWHdJ9JO3fTjw3fG
	T56/h4YJu4N7NzoxIngBtJHsJEMl1XwmumE8R4XxZumb5jByE+2RznsXaoC2K9x3CD1a3EauM01
	+Egayhn4N4SakVZsyky+U22fUNs6Qzessk/xWCFGp76goMbJ1aJpsHocI=
X-Received: by 2002:a17:903:19ee:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b0cdc2badbmr142210825ad.17.1774903457148;
        Mon, 30 Mar 2026 13:44:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5f5bsm92656805ad.82.2026.03.30.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:44:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] dmaengine: hsu: use kzalloc_flex()
Date: Mon, 30 Mar 2026 13:43:57 -0700
Message-ID: <20260330204357.4476-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis. Assign counting variable
after allocation as required by __counted_by.

Apply the exact same treatment to struct hsu_dma and devm_kzalloc().

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: update description.
 v2: address review comments.
 drivers/dma/hsu/hsu.c | 45 ++++++++++++-------------------------------
 drivers/dma/hsu/hsu.h |  4 ++--
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index f62d60d7bc6b..78a2352ada8c 100644
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

@@ -276,10 +258,15 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;

-	desc = hsu_dma_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;

+	desc->nents = sg_len;
+	desc->direction = direction;
+	/* desc->active = 0 by kzalloc */
+	desc->status = DMA_IN_PROGRESS;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		desc->sg[i].addr = sg_dma_address(sg);
 		desc->sg[i].len = sg_dma_len(sg);
@@ -287,11 +274,6 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 		desc->length += sg_dma_len(sg);
 	}

-	desc->nents = sg_len;
-	desc->direction = direction;
-	/* desc->active = 0 by kzalloc */
-	desc->status = DMA_IN_PROGRESS;
-
 	return vchan_tx_prep(&hsuc->vchan, &desc->vdesc, flags);
 }

@@ -428,22 +410,19 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 {
 	struct hsu_dma *hsu;
 	void __iomem *addr = chip->regs + chip->offset;
+	unsigned short nr_channels;
 	unsigned short i;
 	int ret;

-	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
+	/* Calculate nr_channels from the IO space length */
+	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
 	if (!hsu)
 		return -ENOMEM;

-	chip->hsu = hsu;
-
-	/* Calculate nr_channels from the IO space length */
-	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu->nr_channels = nr_channels;

-	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
-				 sizeof(*hsu->chan), GFP_KERNEL);
-	if (!hsu->chan)
-		return -ENOMEM;
+	chip->hsu = hsu;

 	INIT_LIST_HEAD(&hsu->dma.channels);
 	for (i = 0; i < hsu->nr_channels; i++) {
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

