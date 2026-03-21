Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9812E11C7
	for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774064991; cv=none; b=HMK6bgTKq1cRRHC7kiw2onbKfQsxTSl8LqhjC7qN13M7JXoFNsKenyokkK0eNGNJEWM/8uqIWUR1fNCG/2RvS9N6cC7wbnVDzSbSUQgCR9h61pzufcawXU9wJiw+B0A5P3Wp7X3Ck9de1Spb9UC3qwRvYAtV+sP3LagL9TpEGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774064991; c=relaxed/simple;
	bh=sUucHyftZa0FYePXO3IcRk8QdWluSoIklCyhxwTdv74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDiUZpb3D1rvTGP56ZZ9/85PK6D+CrjQwQovsJ+eeq/b/SFedFy6/llh2h10J+ljFFzAqJbVwNnYo4D087lniZkibFgtSPy552tKoycY8+5GaEBEGvnr4TYAT4dVtjxLjmH0SBXhXfekGotH67tmhjCHUCbMAxPBRILSOjx8coE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO4Yesqh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO4Yesqh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b07069e2efso14106245ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774064989; x=1774669789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8rhPFZF8wJ82HmtlvMV9Pq9jCuJhWYy0x5uY1ldnvU=;
        b=XO4Yesqh9Gu7zSBwl6mwZ/+pFfrtNotjIlWpVI30X/PxgFfGH38hD9s5TtfJDuk0Nn
         f/dHbnKxdGsNdfGX5rJ/Jbq2UWhzvO+y73g2Z+/XuQWputQgOXZiig5sOTyvaj+rKxou
         tYXNSeVUnIAURC8m5jIA0kZRRVe0WjfCRcC3u8cTJR6VKSCP8e9nh6nlf7UzwarbzddV
         R2HGbN8zn85c+YLoY+RUCTpQwBc1nJeq3XCGT9VN5IeAC5f8dFgsPBtqcIUv6kPiAVrG
         NX64Yt/MgPv+g3xHmv+KAAkBy9bdPOBvYkUbmGu50mxIRwBwTLHPHaDCi1j+XeIIaLuN
         V9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774064989; x=1774669789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8rhPFZF8wJ82HmtlvMV9Pq9jCuJhWYy0x5uY1ldnvU=;
        b=B951IbSdYn6uglGY/QaPRoaoDCuPImCCeTlC4TduMElEG+jb6Ty+kGJL0Qss6x0Blh
         wUf1QsJ+6h1QpRm7wTU4HfLibkckHt34KQzep+tyxo9Xoip6mG5BXV8oMxDv9HF+I6Zb
         sOOI/un70KNUP6YvwRkQxkFXorGBdFmMG9IAUL8VRUKdGVQM872Gu/tzOMPUYBPupLB5
         jIWgdsUPjjPP7cuu7Zhsxy164bzwXfOK8NViEsebhd58MCyPSejjF2TRVaSjfvfWtRkt
         EVXDJxDWv1sQb0c+NPCacjwbt9ZwfijvG6oxmn6iY3+wispqJOz3eJVN/85cVt5wuGFQ
         ytaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJFfKWszST45FwCPIgFEaMsvBmLhk1zrqnNB1wvadDup4gav6XP+CtveJs/kT/L3S4i8Tg6n6ewp3tqpTj+4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtbe8M1UMJSUjPYE4e507RhIvW7mzxPKvu4badi9MQLomgJZXN
	n/aeTM6WwPlyWcEKeV08DXcvG1TmcljK+cDWTv1Q7uCZxdtzkSLqUkH8
X-Gm-Gg: ATEYQzw9fK3CSHDxftNuJ8237jFrpENRBN8yRf76/qtKh/08W36AdP9N6980KCQkLyd
	0D00S4fJaASggrn2anoQxX+FqyWH6QONIwy578XgjqMfm/YYULsL3k0m5bsF3UfH8u6tfVGjKHz
	OATeGoxQnVa0HPW6Dlw/h58QlMDPMoEZ8jcCSB2217WFnUlAxgPrHwdiSXEqMAsrU+4mRGczpSj
	md6c9xs9de4gz3+JDIC3bbjfVh7+Lhktruq5f3dfTXBFPyw9DPB1kn49OOw4DRykfT3k52AKDh8
	T5wGLihI2Se6pjeNigKMZTcS2gHuZlARF0D2V+SSb+tcNgH8FgS8stKuKPk/laF3t+gz4wPVM9T
	/JP0TU4qbaFjKD8/auz7DrTv7FdD/cMJu1EWy+1rEkv5cUUGRGWsgcocW0TjOe6VCOpAnnNRhcl
	MQf+GkYJb12Rmcd19IBeooZKnuLvqcxeQzq3XhRPw4KvBGVfKfs3KPsq8=
X-Received: by 2002:a17:902:d4c5:b0:2ad:dfb8:8ed3 with SMTP id d9443c01a7336-2b0826d7570mr47830505ad.8.1774064989651;
        Fri, 20 Mar 2026 20:49:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835161a0sm46218305ad.10.2026.03.20.20.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:49:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] dmaengine: idma64: use kzalloc_flex
Date: Fri, 20 Mar 2026 20:49:31 -0700
Message-ID: <20260321034931.9950-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
---
 v2: allocate with GFP_NOWAIT. Was mistakenly removed.
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
2.53.0

