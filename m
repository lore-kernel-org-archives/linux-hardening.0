Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9137C0F2
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639467; cv=none; b=d2KIwjxzDENrqSZIk+k9Qv3KE6f90sX+Ru4DE13F9DmVIVD/O8aZ+n/5NJrTLKOGJAYLhfUpReq2jJldBljE/tlcaJ1fJG2kvuem/oA33e5G78j//+xHf6Uco3ARssv7VBYoiVetn9jrWFz08o+ptsHr+If11ItwneVpyAtA6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639467; c=relaxed/simple;
	bh=L23tTLiBe2b7sgdSRGfvZfLh7KNUbOvlds6WSVyPQYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+E58jF50k0lkhvTppOKYE5NzXFY214xWRQAfWixO5maiFYynEaHmq6igI0nR7TwuWM7BXoVH7l2jBJdHC1iYRCuBaF4R7VvJGyggzbgMf4SAqJe8a2L/17OT92QpfYRyLhuzQkgNUZHW08zg1RLfRSNyozigoWpDqAJnhyLZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZz3y3zG; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZz3y3zG"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1326493eec.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639466; x=1775244266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHdbMRwuqWnRYgbmqY+SsmGUlT6k9iE5mPMFEtpe0wE=;
        b=DZz3y3zGvoc+cRtoD1znqO8c/RsrwGuf9IkrGONYB/Jn9AlUPNDnGqHzJXno17r519
         xiQmZPn2cpxpr3Vdk9S4a/ssLRLIHoGhqxiFffUHyU+lJyRqEv5eNsg8SZtIhEfRSO/u
         L+JrYPXjIUiQZ1uXOX2RfcjYs7FHAvaY9rsewD1TbscScdyDIMhWcrfOg48r4c5GKaVr
         J1m523EFBoogvAYgO85mRwAKlqkSgKUOy+80ai2ehO4jNDDOeYVxRcGK9DLJqDpFmmNf
         GcS+W3BCVKbk7J6/sChcdlLkmrHdg9VWbrw9BDUcDmkA/0PFDFoFDaek1r83EIGjNNyS
         z5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639466; x=1775244266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHdbMRwuqWnRYgbmqY+SsmGUlT6k9iE5mPMFEtpe0wE=;
        b=tE+V0GjyRQAaaRrFrs1anxgcd9egjak1qitozXgZRPV6vOS7D5g+XXB8qO1lXCuo3W
         bxmaO3FW3meLbLty4FyLpdAg+kRZdtO5xqHVbCLgg7Js48o1FW+Jx59EhIYzb1/0uGmn
         sNkXHLlXhbraHTWVvtjJ0/iILhSklT9uh+cXA2qwwluFIHPO97by7UHcSza7rBZNB1x2
         BMplvy2fNGxFL2XiV1SvJPbCtIi5SxJRTDUg8Sci5+ZBqw5I7pJ4dSCA/NEAFX7WtB21
         w3OiIPDYyrEzfbjvTArSOTk0IDBlaV09hng3zt4ZdG76kajpkGslzABQKzZQzJ6TfDZ3
         yYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7pXTfHV3S6qQ9qOiIGOjgSAhsVlvjyXZ20rdTnFuUwsDtkjxHhESVheKTzui8V5smSEhjLhlnVjNcKN7D0wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySX8SUYdR40uLl6cLkQ2v8zC39Ht09aLgU6zfJFlMob7t5u7UI
	d0wUiqKRbfDr3YTtL/CDU0jzsE7N2drlBvknMn4icnGKIvcRQD0WG7gs
X-Gm-Gg: ATEYQzzNjbGlrodBFFcAzLtKW6KjEcVO/tRZFj0ZBBMYu57OMWVhyewb+YAppih2laS
	baHP0XwO7JaLTXdsgEleoaytp/Efsegb/LXG6bLnsfJ0EtkrYTXXm9onHG+j2v59MpfcpxuxSeW
	SybGB2SIDnJao2sepo4h8QW96rBhsV44qUwnyN9UwuX1WOQwVD1tuRoTeEeAh7A3fsNGMcasaQ3
	3c7I3TWIFMW9t+SEMIUpbYabx5AYWI+cZ5y3/omH9f7LVVipZkKnbC/6B+fduUwcgLr1CF4gjyA
	dea2P6lOo8We+uPhwsuHH8g3qK+6DSZ/kkwDR0iktrwzzAeRyD7s1IX4hII+iOgFFrQpQ8gX7z1
	3OY0RBSLMxpcRm7l4xKzj1HJJKzNqG4CZSIBhXORhhtuB/4cQbqIbItqaoeyxr6IO815ZiL1Q13
	7cAjEh70QJal9LJmPVMaGkmK20rdUotasZmeuWvtqJekH6Lx566qkCYtNf/S5EVAbe5A==
X-Received: by 2002:a05:7301:6781:b0:2c0:f814:5885 with SMTP id 5a478bee46e88-2c185dfe365mr2188934eec.18.1774639465478;
        Fri, 27 Mar 2026 12:24:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c79722e0sm187279eec.31.2026.03.27.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-atm-general@lists.sourceforge.net
Cc: Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org (open list:ATM),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] atm: nicstar: simplify allocation
Date: Fri, 27 Mar 2026 12:24:07 -0700
Message-ID: <20260327192407.365369-1-rosenp@gmail.com>
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
 v3: reduce to 80 columns
 v2: use kzalloc_flex
 drivers/atm/nicstar.c | 18 ++++++------------
 drivers/atm/nicstar.h |  5 +++--
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 24e51343df15..c0bed85daf96 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -867,23 +867,18 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
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
+	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma,
+				      GFP_KERNEL);
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
@@ -928,7 +923,6 @@ static void free_scq(ns_dev *card, scq_info *scq, struct atm_vcc *vcc)
 				}
 			}
 	}
-	kfree(scq->skb);
 	dma_free_coherent(&card->pcidev->dev,
 			  2 * (scq->num_entries == VBR_SCQ_NUM_ENTRIES ?
 			       VBR_SCQSIZE : CBR_SCQSIZE),
diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
index 1b7f1dfc1735..76635d46016e 100644
--- a/drivers/atm/nicstar.h
+++ b/drivers/atm/nicstar.h
@@ -667,14 +667,15 @@ typedef struct scq_info {
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
+	struct sk_buff *skb[] __counted_by(num_entries);
+	/* Pointer to an array of pointers
+	   to the sk_buffs used for tx */
 } scq_info;

 typedef struct rsq_info {
--
2.53.0

