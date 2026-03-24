Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAB394497
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322585; cv=none; b=f+kFwgiAM9hrqH3dEN9D0JaSf0ISDtm1WRRRjGGPnyYA36mXf97kDfd/uRQbHdvs0vLJLrgFSPN25rQPk/OnmwVbPu2UIqPlNlfyFnwdKU2MHYsqb8VZBnMgjKKOEBgRjVHrwCSbShZ1QUtaCQAXupWfITsKJAA4yLrqa2YUD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322585; c=relaxed/simple;
	bh=TxbddlDvwj0H0a5cRauMLce46ArVR1XYLpaJvIoiL3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0sqNeeneP0H5Dh8j7EY7pYsWYIIkqp6afw7fPXYPn3yidlrcMu8WV/TnGc3DDj6MlYy/bBNzPA0llssSlmSRD6TiXmBkpuQVmSkQVGC9ogYa5Kd2NSflz5Xgy1fqBnmrIrhzwNpGmMTZMkekBOnDXzIPJ9u/GYeY95SDUb8TvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDmk03qa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDmk03qa"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1861232a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774322581; x=1774927381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUpcZJ/GX5bIeN9b+qRlxwn1Qz4eci6IXB2Cnwx3YIg=;
        b=tDmk03qa5hoimTRhj6UjNZC4fKzXv3mc00JEMrxtg9+WZX5d3bAmeDcYNuNriNYuFa
         rbS29T3J9Qwt6wRyxZZEl8kNEzI+Yg5/Spuy4K6a4O9zQ8Ms+FETWagNnYv1BfwUJNF4
         uB6tmpG285N1FU/KtavFpQvdtkuAArB2LLZLBdAxkfxIY6W+m7GXWKun8Iae8SJ9zPqh
         UGWQiYoJ0vsfSMTqvnuIiu70XawFY/bqUMFqSYAuUfUHJiVIxdVcG9sG8jPcT1pALXjp
         dXi34PfFV29ml0K9dZ6AzRq/YRmEP+ZjI+5FiVGqfdpucVOeJ611yYU4nnXrHKNOjVzf
         4W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774322581; x=1774927381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUpcZJ/GX5bIeN9b+qRlxwn1Qz4eci6IXB2Cnwx3YIg=;
        b=VuL7hN/anFfsfTSx0PW+fs46HHln9HTUIYmpxSLI8yEu1/LPWadSdgNFeN/dgRpe64
         E3HXIDr0e4SIr/1X81jq57Vsv9Q8OAFl3gExY85FuqSWwzrG9xpbj+WzRHGFicqnJhde
         6u5IWL1xhvj0o196xXfNMRxauSCvBmjm5jJHIr4qiyjfFarhXiqmUJOl1nTCUhSgZS4S
         RMU+4wHsGKD7vIgenjUpcrIOue2tzdjM1fqlVDRdZf+BdmRGKqKY0Ns19efSvRlCM+9v
         lm/bSGMLb5uTs/d+W1gYNc4E9yf6xAlS6nKGvBULxJJ1Pnqz8OTL4VN2FLOotKRF9LIK
         BDJw==
X-Forwarded-Encrypted: i=1; AJvYcCUfaWmilW0NCMvCxG9XWa5KXy1Y9m+f+McUK/X9hsabo5SXwtFfXDLitsX0ZzPAN/4DRqk9d4wq9801b9ZGCqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFomn+dUMpOjlmLZCOg2rJILdvEyEzskQ/Pfj2SfiAinB2Rlb
	WfzETYDwkjvAi8uLmosuNgFwayBjN4qXxy96OY3ekKV3FPDWndll9oQn
X-Gm-Gg: ATEYQzw693iBYy245HttJIarQ1p/4Lo9wSqUw56+sYXxwos99IEal5ip0p1uko6qjwN
	DoZFZ4EEzpsVldzKECBhBQNY4ZuZvsY6H52va6J198Len3t3IYzEekpRrA+rua1Zz8KOiyrH0w4
	Gcsc6Ta1y60lqPqODSjS/0j1IKQVhquQFhEzPKjSdldZv0Ssi1et5W5SoEk/6aVEKABzTLbceqb
	dmfePFQwEtu8CU6NcNjx8DR9RqAqhh3R+e1C+pop51pkSwupydyJz/du7G5Z3w1NSLXl1FFbB1b
	VU4b1umLzrSa1AswwCXYHkJn1+ul+UwqewJyRngFKzlChVMNr8OlJJ4xzr7n/BRLIql2mvl2Uyp
	TEti071LmpuLYCtojww0U0OJKzeeFJWoOQDQt9ofQvWEeZQKph6Udwip3qmwTpOwFDYu+PnamGv
	icB4O6mzd2sCP8JBW8YuTh+25Ct+hkKZ6muHH0HphicmDXjVEiAPykZbc=
X-Received: by 2002:a17:903:32c8:b0:2b0:501e:d751 with SMTP id d9443c01a7336-2b0a4e1ac96mr16623755ad.20.1774322581514;
        Mon, 23 Mar 2026 20:23:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835298acsm131223335ad.22.2026.03.23.20.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 20:23:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-atm-general@lists.sourceforge.net (moderated list:ATM),
	netdev@vger.kernel.org (open list:ATM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] atm: nicstar: simplify allocation
Date: Mon, 23 Mar 2026 20:22:43 -0700
Message-ID: <20260324032243.26387-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member with kzalloc_flex to combine allocations
into one.

Add __counted_by for extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/atm/nicstar.c | 17 +++++------------
 drivers/atm/nicstar.h |  4 ++--
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 24e51343df15..2f6a3637aeab 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
 	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
 		return NULL;
 
-	scq = kmalloc_obj(*scq);
+	scq = kmalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
 	if (!scq)
 		return NULL;
-        scq->org = dma_alloc_coherent(&card->pcidev->dev,
-				      2 * size,  &scq->dma, GFP_KERNEL);
+
+	scq->num_entries = size / NS_SCQE_SIZE;
+
+	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma, GFP_KERNEL);
 	if (!scq->org) {
 		kfree(scq);
 		return NULL;
 	}
-	scq->skb = kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
-	if (!scq->skb) {
-		dma_free_coherent(&card->pcidev->dev,
-				  2 * size, scq->org, scq->dma);
-		kfree(scq);
-		return NULL;
-	}
-	scq->num_entries = size / NS_SCQE_SIZE;
 	scq->base = PTR_ALIGN(scq->org, size);
 	scq->next = scq->base;
 	scq->last = scq->base + (scq->num_entries - 1);
@@ -928,7 +922,6 @@ static void free_scq(ns_dev *card, scq_info *scq, struct atm_vcc *vcc)
 				}
 			}
 	}
-	kfree(scq->skb);
 	dma_free_coherent(&card->pcidev->dev,
 			  2 * (scq->num_entries == VBR_SCQ_NUM_ENTRIES ?
 			       VBR_SCQSIZE : CBR_SCQSIZE),
diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
index 1b7f1dfc1735..ba45be53d40e 100644
--- a/drivers/atm/nicstar.h
+++ b/drivers/atm/nicstar.h
@@ -667,14 +667,14 @@ typedef struct scq_info {
 	ns_scqe *next;
 	volatile ns_scqe *tail;	/* Not related to the nicstar register */
 	unsigned num_entries;
-	struct sk_buff **skb;	/* Pointer to an array of pointers
-				   to the sk_buffs used for tx */
 	u32 scd;		/* SRAM address of the corresponding
 				   SCD */
 	int tbd_count;		/* Only meaningful on variable rate */
 	wait_queue_head_t scqfull_waitq;
 	volatile char full;	/* SCQ full indicator */
 	spinlock_t lock;	/* SCQ spinlock */
+	struct sk_buff *skb[] __counted_by(num_entries);	/* Pointer to an array of pointers
+								   to the sk_buffs used for tx */
 } scq_info;
 
 typedef struct rsq_info {
-- 
2.53.0

