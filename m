Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2AC39DBF9
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774503358; cv=none; b=h3UePSmz0NaN4EveCQ3fCld/Mkxs2dgE1mt5BEnbnQywXveeZrCogoiuikGlaIOdJvtXLWn+97q88Gl/YRTo2OJUi/KqGFmq9Dl38IS4Lt2bRPKJQq20045EHtfNlJQhNgwhbiAJrCgQ+tphLjqIjmNdJn+tXKcd37o4zQ+Aob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774503358; c=relaxed/simple;
	bh=Qr8ZdoV03XC8Y/zIkKOZ6eJPlAgDEERg45y8qVbjw7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOMJDUBPsJyhkHc8YFqbKHLCHQg2sw+Ye6sD2zlzgV2Fq3g0AwRUVMYUJEtKPZ4Y5FOTeA54Xvzfuk8vPMH8OgEKcBduomkCnnGqrVxvZuMUhAm7IfwsHcNiuQm21kJ0LltGh/c3wdZAavneXn4xmpSq+PsK2Cw4jpTuapI0ViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRbrYDQX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRbrYDQX"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c742d4df00cso701289a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774503357; x=1775108157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jGE1cCQwPm570qppMAHgNNyYwfNt8xMLKnlmo6j/5s=;
        b=sRbrYDQX6tXzYaRV/NjaQv/8TMEUDIG1QFHZw/LzYw9meNiX4+s5ni+I+RgHYyiigy
         WbNrpydM8hsgHkgCp6Zeiv6+bsuiiFN9sWKWlRnXCKNTtNLNPsydabe+Ql/3rypwK16y
         AWhcKXR/bPj1tRm5fxmLAHNaygAd/wuljWa2lh/NS9jvrnbyv+u9MpvV4+2tm9IPX0DH
         6wMKXIvPgTx2io13JoMsidL6DOvyZH1yqxz7AWv5EVYwpT5Vgce4H1SD3ThbBIUx8eTA
         wFYgXRyrtM3h2ao0DmAy9RUjGjOd1c8FfsXCDgBhGVPJDdBdS4zWtjQcUQjOy5P1Gw99
         jYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774503357; x=1775108157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jGE1cCQwPm570qppMAHgNNyYwfNt8xMLKnlmo6j/5s=;
        b=behFy93CnkgIimVNjiHuMo8hlRlk2ChNKMsQ85xpEa17/4aWkH8lA6cjJUW2LHMdUK
         656aEa4EpqW03KO0bKShUoOiak2gzWpxk9gJSnKIvHhwZ9dZjYqRpT4HoEMC4fPSHsPY
         8MpPS5+iLwgecNO10AcUA58n+wTeA6bIGc8x4iAYsOWgj+BoLwHU5LlatlTN8olKwHQu
         gaTch6uvD38QFicLV/nxVm9lfMEDLcFaYf4d7Eybh2aGPGs02ooBA3XXmsK3KbDht0K8
         Ym4wxWzTagAqF9tySvcHlQRCG2vhf99tuF9YUXaX381X3APvPOSNVEYjnIZBGRcG3yfe
         7OoA==
X-Forwarded-Encrypted: i=1; AJvYcCX22kj1QLQPjJ5+++JpuCMuP2fKWWuoBKvvST5eyXPq2obyFdZIyKs6ewXfXpNeJJ7H4SlfRrTHI9ecasy+BUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5XGfXc1H1D469v/1fcdxvEsB+Aq71d3IrBxf0evKCzxJkSeg
	tJJxMZG36lR5Nla5eiFF2NF8Z8IwoLOyi2SnTQl93xaUsyx4eadV125I
X-Gm-Gg: ATEYQzyCwlMyZ12kN6N102R8fBUnLHhHr8vZJByrX4eqOQeLlUZcKr+3IDACftYWaUU
	QNLXqgswYclTIETB3HbUKNGXSOK8bh+egHHp4sFrtjjqgpRUPsyOjvpr5xpiGsbdGXHO3OS3R3a
	brWAz1ASCiMUFN7GIPXFe+Th4Ahtu9lEqHCP42XpSLvJNlnfCWuamuL4lOXqj9wv43t8rjBT+/Z
	AmnduuClP/RyDk/JMKBUSg8P2jQkIQwfrWIsWYVzKHrLaDrtduw2CLwbYIlVZrwB5eYqVd3ia5S
	ykp/6LUMZ6MJT2Lu1ycun9FH9F3rOqRH5TMjzJh9EfFbLDvZ6Wac1UpXrlWyne20zx9yUeMZG2Y
	EGPohqdPrnDxS98PC4hQOeB/SlvP6QRWhisKrJD47719nW6COwl2F9LptmBjxxQf32rBhCSgSt3
	xwBkfW4DimApCY9T66BzwKK7ONR/xcpRopu32xGQ8/G4zgtopqKXmloSQ=
X-Received: by 2002:a05:6a21:3383:b0:39b:e3aa:df2d with SMTP id adf61e73a8af0-39c734cc786mr376742637.7.1774503356576;
        Wed, 25 Mar 2026 22:35:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c767382bcecsm1080464a12.13.2026.03.25.22.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:35:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-atm-general@lists.sourceforge.net
Cc: Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org (open list:ATM),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] atm: nicstar: simplify allocation
Date: Wed, 25 Mar 2026 22:35:39 -0700
Message-ID: <20260326053539.336831-1-rosenp@gmail.com>
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
 v2: use kzalloc_flex
 drivers/atm/nicstar.c | 17 +++++------------
 drivers/atm/nicstar.h |  4 ++--
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 24e51343df15..b01c6cfdcc87 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
 	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
 		return NULL;

-	scq = kmalloc_obj(*scq);
+	scq = kzalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
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

