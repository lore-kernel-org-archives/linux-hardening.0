Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73712F585
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707870; cv=none; b=tOBOFowgR4UYvwVYJUrykV79TicXQ8FTcedHDk/LewlxCog0esoxuyPPVU7nAJNzd3zH0HvI4Suz8PyVRn4VdyXAvaUljYRo/jV+Soc1SAc14u1zuLgvQ16G478TE1qJSX8RK7U3zTTauYU+B0w0Bprm8r4bZ5t7v8Q91cpH4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707870; c=relaxed/simple;
	bh=NBUx/E1eiB5B4UIv31tdu/QKTosgVuyh/723Ruw5qWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezjfqypO1riNhOpzH+03laa+CjvwMTiHzOparbn0JJWHuFpb92TWyNEndUAxXf1cokG1CKD3fmdAhS6HTcr7GKPo0HWdik3q6rIcjvyZ/Y6ZWKpq0jThA1podtyBwRUsL4mONzHbEC1gPmWIV3Xy0tObxFncUANOC+E3YhRLL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDHtL+Rf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDHtL+Rf"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73f107789cso760788a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707869; x=1774312669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YvdzXjDD8G0Iw759gOEg4e+kzUc/b7ysSStVnoVNAU=;
        b=XDHtL+RfLbPFsCozxR/f1EJ1p73BE/XW2SNZQsVgoLXWjKQ1j2C9EOlzxKHVHBDrKT
         ExYcq+Hgf6ieLECazVgyK8UUw/temaUE3l5RUZrFEC8jlqusD7cmXomztX6KQfntXmjE
         6idcRy2l9OsoZJrFtD6HuP5f0ldtlqQutQ8KVFsuPicVwu/iEUGLwSdAIHwxJ1q/rzef
         HcGMUBvxW57Z5b81PhXlHX5Dz5abtplXf3P4azPyp4zza1siwjj8sllJuJi6gj/wdPkr
         hhJKscZ/SXpC9XglsaIbYuZ6WyjBO/4p1kLesd05KvcosUyAbBVKib11w0U7ACtUODpz
         M69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707869; x=1774312669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YvdzXjDD8G0Iw759gOEg4e+kzUc/b7ysSStVnoVNAU=;
        b=MEX8h6r2s75l/y56jUL0R855C9OOliBckiPgCqBpWp3BGAMpGqrh2fw9Ks85acL2vs
         82TJ8uWAu3RJwAo1BhOnZnVtxOiUBcAtzR75T6u8Gq1aQKVxlyhiRjmYSDi56z+tzEPf
         n7eZuHmnl3Exq6yvsWwpU3OBMkpo/HpDD/3EYQuGzK+Tn1/tPsD3TRoWWAQd+vwz8okC
         4sEZlcNMAcK2191K/KXd9qncbLWBzr4Gka9/v4F8QbiNb7I/igR37tqtd2D/FUkxRhE1
         tiwtz1KNbem1sn/Md5WrGrqipSyN/2DUH7T1sQlnF2x9QzdNDYf1BGr7Z35j8J6spFbu
         RMug==
X-Forwarded-Encrypted: i=1; AJvYcCWS6Y0JgBTNSA6uVjIMgyQw8lKqh7JKyBmAniAm7IWpsWySnishtsWTlyFj/YC1ee56Ooc1fWWrzPOgrlPz0os=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFd/XtlB+4PLDktmTDAktYTdI9wNy8Oj6JRPu6+hDKVo72aPON
	WN1AJd0oYOWP6HTdX6Pa5qs2j1nzQtMX5I6cYPzjMrWZ1RsIF+hv6u40
X-Gm-Gg: ATEYQzxTZYoTU8sYZ+11nAZcylUtr5UM1DZdFxMafj9rDqpYIfYLt3YoMoxjsDqPgtC
	YaMSP2YYw2qRkIc7vygf/41tR5w/VnSTaqm0Fs13rTWNwo17RRkp/FtFNifQ+yjl1i9DUGZnvRU
	FwOyGOesT/1lEBcDYfX7PioPjxITxlP/1Eq+tpAyO0BPrcV3jG8PAJ+omfuN1dbkWVB6+Owukt3
	/GXMKRvrALdCHtyM7llgHNRH0xWraqhoQfN2sKVkcyTJGTp7mu22e4+qlR+xs2SKUQICzBUZxGM
	4FS5ube1MJ38nJtfbjGXPQeQUT+Hzc7NFOsk9hwP/foq/fSJtDbVoSpacH1hevTQ60FJgMLC1FI
	06OwJXFWm9fr/LoPRMFv7Ucm+9YL8G42kQd9/4Qy/F4R/hnIOvd8ySs7CtTuu9CZYIBJGNp4VFX
	CFAGw2TluOqyh80XjMA1GAh3AxxQpKjP6k++xsSipeCDLOIB0IfTJeXGI=
X-Received: by 2002:a17:902:e841:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2aecaaf604amr162102125ad.36.1773707869018;
        Mon, 16 Mar 2026 17:37:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ede79sm155391855ad.53.2026.03.16.17.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:37:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: idma64: use kzalloc_flex
Date: Mon, 16 Mar 2026 17:37:30 -0700
Message-ID: <20260317003730.72379-1-rosenp@gmail.com>
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
 drivers/dma/idma64.c | 30 ++++--------------------------
 drivers/dma/idma64.h |  4 ++--
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 5fcd1befc92d..cf0399251ea9 100644
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
+	desc = kzalloc_flex(*desc, hw, sg_len);
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

