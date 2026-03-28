Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D02D2382
	for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725428; cv=none; b=kix3CBXr1PE7RbpuNTuEbrY/PZVUkaD0ZvicoEvoqco71dJ9sgeHXnIdOnnWpu2jp12Ju5NbHKbjCoqR3QiOyyCLpENTemtk8LvUFyte9iXlzCBnQqQ2jMrRlIW1YPXSgNYMRymfXub99zjPcMNn2+p05K+akj7WraLeJ3SgKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725428; c=relaxed/simple;
	bh=KA91jLkFZtNxj2oGP5XZfhlzSkR2p/GJzKrWyVJLYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re/kAeA0Nc8YdKJ6TzLrjxhOKY8oUrtwO3tYQSDoLoeKGLRXSUpdFNjpV7+D2f1cCkb9s6LzrjgxiCjy4hlfOVuddgkG5YqcQpoIGzWpZNCI8RzfY8YRgX0LT6FMX3bRBmJ6kiS8S4LIu43eravJlpAIjvp5QJ9C2eHtZtvMgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAj61LVA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAj61LVA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829a9d08644so1691540b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725424; x=1775330224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4t9PIf27Y9InCdf+CxT4mVnKUfDVoG1AnPBiKECu30=;
        b=WAj61LVA/iFQVdVhuuBgdRFhudViLCQLEEI9uunrIegMrdMm20v3sRp7pFGGzLq4o+
         EpdMJWgIh1T6M+Pn600pgsGJnu8bO6HsfRVbbhh9O0nds+PplfGYl3qKIoad8STNtlCe
         bd6wTaB7xMsVS0SH+cHWijmlxDoKrHM0TNz1SMCyHfmPCJeUgCnkTFoBqHSRvU0td00Q
         0wxNKIqbsmvR7rCcf0fAZcNZFCfjwDxZGRLpZ1RBoqk0zK1CnKMOhfn6MT/e+ev6h4IU
         /6oKGXDjU/Ah+FKBfitlGK2+R7LKCgzOuT3fp7nbdvnubiSM15lqXIbv/1ZqcZ8Wc3D/
         73qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725424; x=1775330224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4t9PIf27Y9InCdf+CxT4mVnKUfDVoG1AnPBiKECu30=;
        b=HW4ELZCbQp2jNqF261H8uySGaRL8RZBOhYMRYXFplDgNqUiTloLs4z95+CR80jedWh
         QMLGGCTExucBJwv2UGADURGPwQKQcIXAfchYIfdF89I4T/i7VH6hAUMJfEJ/gidJHAQ/
         Zwpmng5tQAk47ruGfUCheIfoFcg3xs/VR0PHvH4TEYMHaPSf08LJvPMe3AC8MUjV236Y
         9RVf3yj65/WEiSZIV2uJMsGJNvqz7luwGwEBLKUt3U2Lvk22Vb3MwXrfm46iVFUGUAzR
         pnAPDx3Xg7KJxzc8eR4UEltq3pRbTz8dACGPsNBawXJjSXmAFzc4w6JgN9NrNpMaBO2s
         QARg==
X-Forwarded-Encrypted: i=1; AJvYcCVOgNZPLn2z9RBSWAASW5Ik92YKpddErXDw/9XhHSPooDjOQMU6mYo6W2p4jkSN4aXf5BKhhGLo8ke4HR683VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqq4zZ5gA8MrxlhGhhwaSpOCkguqCZzm3c1AmOoPfePsejHyM
	0o1oq+7Oki6KuxVtlULGKIgbFQNf6C4NzsCWKdnCGvsWQ8xV+Qb9HSQM
X-Gm-Gg: ATEYQzyOp+M3DJHhzReKutm5qaIUL/3GHSAC8FqqNPkOgcK1SVwu0DKP13MLPZPDSFf
	u8K6YSROXo6fQa2XiXw1UZO8xfTIGtqNLkrlsas4lnsG1VYkuGLrFo4Y4I4lvkgc+ebJ1yYaIup
	l9DP9J78dQh+qveW5dzOoIf/yqGfsTpgmuANkB4qsQluqyuiFiog5dMAXRYDp7WtjSTV+9Ftjer
	dV8cPkAWJwAwCLVyb+HRQj55SI6QtpTEDU1WC0QeIo6zkp7BXBi7gDzN7d+NUXEVE+3YOSCfjWx
	CFeX0FUHYHyUGysj/qt1v9ClFPaGLAHk/x7kHmI65Gx8Z/eyujyF/eWXfbcUukPfcr5/rGtZ9Dt
	5U9+qza2TX6paCBbfITCMxa0NPzyBfiBhtigE7hYyfy3AmIY6jcqKmxc7Z7coc6aX7dgbaFiS+6
	omLx4f4pJov0NIynaH7m9GCzm8aYfTrwX3yJP3ER/eL8upvxONs5xLnGk=
X-Received: by 2002:a05:6a00:bb0d:b0:82c:70a8:fae6 with SMTP id d2e1a72fcca58-82c95e71d96mr6682847b3a.22.1774725424350;
        Sat, 28 Mar 2026 12:17:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8464576sm2774950b3a.14.2026.03.28.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 12:17:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] dmaengine: hsu: use kzalloc_flex()
Date: Sat, 28 Mar 2026 12:16:46 -0700
Message-ID: <20260328191646.312298-1-rosenp@gmail.com>
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

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
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

