Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E230EF88
	for <linux-hardening@vger.kernel.org>; Wed, 15 Apr 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223696; cv=none; b=VTq5Q7BugS3uhsDkQrK7qovknyVct/paiYCnM/CYW3b3178f9k/hLbjLMbuIWwA3XAyOBe1PjqZxEvbKGnSVstw4MgNQZgPjTuXF1ZUs7AbRxsnproXEVwAG2Ply12Qsp4bUKUxCq6ukHJsTmI8br2Ga8F6qhRqtBLWZcKWM40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223696; c=relaxed/simple;
	bh=tCSW40mdJktOK1h1VfrP3QQE4ZWe+0q0/kLHOByHApk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDCwydF/bqKhSo2pEYO5vIa32GXvVNGOoc2dhMsM5nlGG/5d1WbURXyvOn8YLtbpLBLMz5UqTo+yOYSMhDd8snTviKOtEYOeLnt693D7yIG0FkhTh/fBNsEoNURg1InSw3vU1eKKFQwtBwXjgD1c7DC2MHyQl7mvfA/Xmo0d6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scHr2tsG; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scHr2tsG"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d560ede296so743174985a.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223693; x=1776828493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLKjOgt0prGno2etyoUy7FVuq/6O60livyoOWpMDLDg=;
        b=scHr2tsGPNkK0eklazc83dke/VS8irTYyGPxqKBfopPNepWMbvV1fpaf3p580DjFEm
         5rMXdhaysAAsPgts9ydlq4uyDJUJ6RNIvTR1Yv+3qwYvjjWljVoDv8TdO2OiMYJYRAnU
         +Xldqv0bawAhi07m21K5vtdwMWJDgc3SeVvEJE9xGRDVogJWypYSRx5oUPMQJYH1wo8H
         y207mW+yyiBzEuDmVUfCvK9QBokXDZfelieqPWMISNAKCZSvkbMWcSn7A/+htwsvLLvB
         yCJFq7eaSjAMqANQnS6VLVCydPbPPDvkwx7aXPT/riVTe/CHd2XUrp7o99SKX1+KT+r9
         DVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223693; x=1776828493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLKjOgt0prGno2etyoUy7FVuq/6O60livyoOWpMDLDg=;
        b=PYHjwxqxgSf7C6wcpAxsu+3xowFR2R8qn9OZwmmEDXpMsLX/A9/ggxMRI9Y1BXLOHR
         ZvNdYHQasgkSZDwIEk7av08UJ5nkKCymz/EFYj1f9adbfqKnM8EHMdyBYszBfN7feTE/
         YY0fQGLRCliU8fLP/QCxonnPYT99uhu4n/UKZ5SjGKBnTlCT6L+aIbE4qRw+JH7KA4cb
         InFP0v8yNJJWOfQeZAkrF5GFlqzaPAiqbCoR/RB0vg6GYaDx5HfztDnzpqwJpK6GuPL/
         peAofjUuz3iaRIpDUN1HxUiMgTlXvhP9y698+Ly93LEU30eGbmjJbb+euWx5vQHGNP/A
         Aejg==
X-Forwarded-Encrypted: i=1; AFNElJ8vjosDa4jtDHXPGMD3iL6bPPIQ7N/Pnik9bdc3R/+CPN1xIfdrEhyCyI3g1a4y5p41dRnZRVMTtViN53pc/gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvt+qcV+bgbWHQPsNEzHpFsdCOvqtb9NhbRiDyNNx5a6Bk/ag0
	1LaxYls9eqyDmQ0Vi7/KfRnI/DOmfabRBxNtNuh1iyhRq1BD9wDzsYkN
X-Gm-Gg: AeBDiev7ibh2J796GMoWqAblzdInj2dFTs7aiTHWA1dzeV2M+pVCANhcYjQYio9U8lL
	laRn/5yC64pOn/0q8nwdODflRaU8pEkCPazu9Pw406RFsvqx+4Wa/Ih2rKzZ0xf1/nQzJ1dllpW
	7hsp52cnEQ+9SIIRFvAJ+KngwCjvoKqjKvcqcxFn32HwKSO+SCKVxYB43TV3zIT5qsKSsvUkIXa
	yuubMuB09/q3AtreyRRBGu/wbC0Fz/8DsTIEQL35Hz4utBooClkAMf+fWjaoZeM4RhdtBpEt7ub
	nUeTQaq1L5nxLk1GMXgijigetkTP5834lHyCT69N/2RR1v0aQ6P0OdFtRFLj6G1BsCw9fjG/Ou1
	8WG0PKn5eLkyT1GkLgYs9Y6zw4fhPD+Zyn99OcYD2L2e5pnOBNaI6oWntMK/PDsUNw11uqAFzmH
	e59tfoCGHlrzKv40epnSbyyvJx8Y08Xx/nvEY13QQ42bGUZLG4auYfIUc=
X-Received: by 2002:ac8:5f88:0:b0:50d:6838:964c with SMTP id d75a77b69052e-50dd5af0776mr330945371cf.18.1776223693139;
        Tue, 14 Apr 2026 20:28:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c974c2esm2578556d6.17.2026.04.14.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:28:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
Date: Tue, 14 Apr 2026 20:27:53 -0700
Message-ID: <20260415032753.6006-1-rosenp@gmail.com>
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

Apply the exact same treatment to struct hsu_dma and devm_kzalloc().

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: move back counting variable assignment, as requested.
 v3: update description.
 v2: address review comments.
 drivers/dma/hsu/hsu.c | 43 +++++++++++--------------------------------
 drivers/dma/hsu/hsu.h |  4 ++--
 2 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index f62d60d7bc6b..b1dd4fd1109b 100644
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

 	chip->hsu = hsu;

-	/* Calculate nr_channels from the IO space length */
-	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
-
-	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
-				 sizeof(*hsu->chan), GFP_KERNEL);
-	if (!hsu->chan)
-		return -ENOMEM;
+	hsu->nr_channels = nr_channels;

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

