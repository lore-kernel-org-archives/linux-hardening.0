Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4837BE8A
	for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893646; cv=none; b=HIptuB5JReEtL/0fejCRuwoRiHalu8o1lEAoxRvb6aNGPDZ7+LVB1jACA126au/iKoymoYwFZ5BfmJ9DfrZWfNwMyBNbjEpSsXT9+gHqccI3wHqCO9dUGWWPL4wzTXEdb/zxHevBIUMY86wSp2XTqvmrGd2MGGIlLlb07mXUs1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893646; c=relaxed/simple;
	bh=Gx3dxzU1ikPSsJPBUGCijZOLWZz13mRAOiy71j67q18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fflg0MATKzEr8gDyq9ZmeKA8fZXrYgFN/GRb5Pv2M9aSRw9TqqczOREy/3Oegntc7Dsfue2/D9mbl0IrXk+HmkLuZajGbBlllOxd0F7gx7vs6kjb/UQBWWhCT1TSH0IBBVtmZJ+8dbQ0mK0feiGNNBHTAxuxpwfTV2rx7XU6SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXXxbKdo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXXxbKdo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso22684785ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 12 Jul 2026 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783893644; x=1784498444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SvXQuEtFeagFiyEBtM6YkLZtwS+Bnd8V2JTSeJNcHAg=;
        b=YXXxbKdo0RqwQllr3uOKdgmBGyT2A201J+hNu244zf8Z1JihKGvA1YZ+UWzMpYTe8s
         gDetAsNQbrWRx/2i9K3Bf8Omxylz65GizhNJy3YlmkzMO53tGEm3HQqee1y7mKibnl9c
         T49JA+hWiu6EJw/HRk/iUvw3mNgXGy7h+U/ecdHKEb2p1F/ScEW+nlnc2SMXrIYVfrYM
         r4jKBaTaW8BMYetW77vGQAo1hs5HNd8lo7uYL3MjJoKvKBhX+4fd3aOnxYP98+9okNun
         h44QJZ5PmPDNqApP98qD62rXcYHRuZTcVJL376EQ5+6Khr+hSRmnYAXZNlGGEi039VXS
         ZfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893644; x=1784498444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SvXQuEtFeagFiyEBtM6YkLZtwS+Bnd8V2JTSeJNcHAg=;
        b=CK8xUYEirDmHX+wIev2lV7/5whWTf+FI/7PYWsOIClVwujixTuvZCIJyo8w8M0hQWg
         uI3I6YgA4XK9bYhYcWTOznNU2Pe1tT0mORczm3XJKZxu3wLnrVgQp6xOiHCWndOfqp/9
         3WJBygD53JzpBoISdiooi+nJRd4Vq/SnVCXdZ7jt2g9IxRqri2aiCon/LD6c4QFenoTx
         y8S0ivOfIP7w/WDaHuaX6xrd4KVirJrqsKYWfNaX6S9HSuPON6jf2WHEAc4wJr1CKM4W
         2K6PNvtiBFakdZaURnG9nM+Evsur1RWQ0YXiBP3cPabxLAp3StXSNvT7a7dMyCgBFpg0
         1dGw==
X-Forwarded-Encrypted: i=1; AHgh+Rpj5mCJTnDzPZ0wcwXToOIfN4xQESxE0qVRuGvjtxq22mWfyx9yGc+Cbg5FsCaLX9dKmXTX4KPCPogMSqpPuu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83xPeN3VmYOjlDoeUm+2bOe1cdwBeKRQOJXz1CUSyWhTZytFZ
	Xrp6328OxA6AdyukN7j+649GUvcxRhjM2zELTOEvQeRXddQvH0iXjt7p
X-Gm-Gg: AfdE7cnb5elNETt4UzEWIUVGPxDvFAc13sJVpHGoZLsdozk3Rl20SDt6ikERksND9s+
	4HD3jamBcXgxs8yqti0Y6Z8lpgq6Xb4xHxSTYGIJQa4av8kYehI0NlhwCEmhDUrSxKgV39wSH+S
	iEeDBjilZP3kGtIJAMJH/0fwOw4ulSGKp9QKu+shiiHBbnXQ37EHq+fCJwoZKicsd0ZOC8y3JSj
	0A+jUaz6+QRS8ewRK6Z+pqyM+TTamMuK03aHzuyaANcrWFL79ULb4O0rARI653do4kdXkfxddPx
	3NoUBAkIRxb8Qy0tTKD8qwdJoITaA/WQpyjwahZmVRm8NcoUnlT+c6ib54Y/Q03Dt9FnsZHFfui
	R/z1CDeiEY3341NI/QPjfQmU3CVANk7fIhT73qxzLUiAypUqnr4/rOMH3Kh8nXC7DgLZf2qD4Wc
	RquGQF1RXhMDLeCt+zXfgvAUyn3Jj42Rw52MYJvNCo9pdU+nBwgGkwQGF5PMW3HjBa96lBicr2g
	QmrUWwaIZlhavF/+artj5hXEtE3PUREWoO8rQxhRnIJ5IBC47T69NLRJIWhFbylfA==
X-Received: by 2002:a05:6a21:4cca:b0:3b4:8a40:85ed with SMTP id adf61e73a8af0-3c11077686bmr6798012637.7.1783893644125;
        Sun, 12 Jul 2026 15:00:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm14856305eec.13.2026.07.12.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 2/2] dmaengine: idma64: use sg_nents_for_dma to respect hardware descriptor length limit
Date: Sun, 12 Jul 2026 15:00:39 -0700
Message-ID: <20260712220039.924958-3-rosenp@gmail.com>
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

The iDMA 64-bit hardware has a 17-bit block transfer size field in the
CTL_HI register (IDMA64C_CTLH_BLOCK_TS_MASK = 0x1ffff). When a
scatterlist entry exceeds this limit, the driver would silently
truncate the length, transferring fewer bytes than intended.

Use sg_nents_for_dma() to compute the number of hardware descriptors
needed after splitting large SG entries into chunks that fit within
the hardware limit. Split the loop to iterate over each chunk.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/idma64.c | 44 ++++++++++++++++++++++++++++++--------------
 drivers/dma/idma64.h |  3 ++-
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index d914f50ec309..6954ec2cdeae 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -287,27 +287,43 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 	struct idma64_chan *idma64c = to_idma64_chan(chan);
 	struct idma64_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i;
+	unsigned int i, nents;
+	int ndesc;
 
-	desc = kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
+	ndesc = sg_nents_for_dma(sgl, sg_len, IDMA64C_CTLH_BLOCK_TS_MASK);
+	if (ndesc <= 0)
+		return NULL;
+
+	desc = kzalloc_flex(*desc, hw, ndesc, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->ndesc = sg_len;
+	desc->ndesc = ndesc;
 
+	nents = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct idma64_hw_desc *hw = &desc->hw[i];
-
-		/* Allocate DMA capable memory for hardware descriptor */
-		hw->lli = dma_pool_alloc(idma64c->pool, GFP_NOWAIT, &hw->llp);
-		if (!hw->lli) {
-			desc->ndesc = i;
-			idma64_desc_free(idma64c, desc);
-			return NULL;
+		dma_addr_t addr = sg_dma_address(sg);
+		unsigned int len = sg_dma_len(sg);
+
+		while (len) {
+			struct idma64_hw_desc *hwdesc = &desc->hw[nents++];
+			unsigned int chunk = min(len, IDMA64C_CTLH_BLOCK_TS_MASK);
+
+			hwdesc->lli = dma_pool_alloc(idma64c->pool, GFP_NOWAIT,
+						     &hwdesc->llp);
+			if (!hwdesc->lli) {
+				/* nents was already incremented by ++ above */
+				desc->ndesc = nents - 1;
+				idma64_desc_free(idma64c, desc);
+				return NULL;
+			}
+
+			hwdesc->phys = addr;
+			hwdesc->len = chunk;
+
+			addr += chunk;
+			len -= chunk;
 		}
-
-		hw->phys = sg_dma_address(sg);
-		hw->len = sg_dma_len(sg);
 	}
 
 	desc->direction = direction;
diff --git a/drivers/dma/idma64.h b/drivers/dma/idma64.h
index 1a67dbb24db5..297a91594b31 100644
--- a/drivers/dma/idma64.h
+++ b/drivers/dma/idma64.h
@@ -8,6 +8,7 @@
 #ifndef __DMA_IDMA64_H__
 #define __DMA_IDMA64_H__
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
@@ -51,7 +52,7 @@
 #define IDMA64C_CTLL_LLP_S_EN		(1 << 28)	/* src block chain */
 
 /* Bitfields in CTL_HI */
-#define IDMA64C_CTLH_BLOCK_TS_MASK	((1 << 17) - 1)
+#define IDMA64C_CTLH_BLOCK_TS_MASK	GENMASK_U32(16, 0)
 #define IDMA64C_CTLH_BLOCK_TS(x)	((x) & IDMA64C_CTLH_BLOCK_TS_MASK)
 #define IDMA64C_CTLH_DONE		(1 << 17)
 
-- 
2.55.0

