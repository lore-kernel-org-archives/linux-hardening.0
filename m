Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2C197A88;
	Tue, 19 Nov 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049736; cv=none; b=O4vl1c7Ohi3X2HbDpjDQ+J4lGY6gDfc3CbpxXjHWiTIuTEYZMobMuvWFkGnGUD9t2KptHNXOxBkSH/lTFPxH5yEQ6Et+IPchdkCglVgljgD1kDegl161JHH5HL5B4gGs+SssZd89+r/6sBH/dwOKd32NyTGeppgg4JCsIpttV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049736; c=relaxed/simple;
	bh=KiK/QxjCScThNx5cAuBX+ysTQNkSJkYb3eGc+eyIriQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjTMYlSS4wTnCfYTcLMgnlui+otCs+K55IAJKHBRcOiH5o0J20sYAxTBxBjkjCxHObFWYCxxn6cuSJogyAyGsA0Wffc584X7Vgov6ax9NQqjfpEOgpEhBYj5yNESzFikKAMQsXMIA94y/4PfJYlpOYG3GoFqJdPCZ+it6ORiovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcv8fOLB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcv8fOLB"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa4d257eb68so42149166b.0;
        Tue, 19 Nov 2024 12:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732049733; x=1732654533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXlybJu5m3KLhPLVoAXdtmN1aY6QneX+MU5tFhnG5vs=;
        b=Lcv8fOLBJ9Vy9QKcyOIG05JY9Z+yrTS6SKnbfCQGaXWjBm2XNFmafjqI/CtUl9MbY+
         kFyqR9P0W89o3QS48PHZVA+EUabUQqejGpAQkSCaqV7U8ZAOMMod2vf/OXDxhNLsZEsg
         6eKBJso1T+60uXo97bCM6vjZ9j8SjY0l/22+U+WKWthiH85D9iXySSFkZAO5XWJWcptc
         h8wJJIZEJEDk0LG0qt596AxxOn0kpXltwI1FVxZA/Xst1o6vuEsC3m61yIXxwUB48GjW
         mE83tIj9qCJDDn+6VEoD1M85eyPLVRat5eFo6X4NyprCM9Po3sjCPfnujvG5Mt+pxPu/
         vBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049733; x=1732654533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXlybJu5m3KLhPLVoAXdtmN1aY6QneX+MU5tFhnG5vs=;
        b=fyBxQ8eYpVebY5piEOpHyVdq7dFh0CzdJM0QR11LXOKJXZWzrYjIEAMUFWOjTwY38F
         6n5xB+w4aH7Yf79nQ4X+LkEIlT96D0gvbcE6838ZwMtB2vcy+tWJFbJ4pVrQttRryM7I
         I/sB14vvaBNeBlkvfktVoXojJYY9Duf/xfpA02j+dxvhgveDD2+NIAIdKHlKvbI/+rgk
         SjGveODtak84CtrOdJWrllREl4vg77M2LjVw6aNCsEgwDwEQERt1YSFVwi3Dr58UzAak
         BzV3a4T0dSldYJEXXQzjhSZpdd/LmacomC9Em7PopikRPRL4VOSeSskPGQF62n0/JWde
         bCRg==
X-Forwarded-Encrypted: i=1; AJvYcCWM9DU80mGk9/JtGbLB8kvFmTSEPCLxfWHP/+/vwPbyZbFVWPqsdrQo3oLYt1rbqT6x3vyMsMH0Fvndoc2wAhY=@vger.kernel.org, AJvYcCX0rt2FVtKlGef8KGM6+Idl8UJntcmbbnPq/PdK49FDvNQQMZdQhmPm2XVDGi3DIzEiN+swpD8/eFbu8snP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55bBMqBArwKWwoP2hsgPw7AzH+zmCif5cdq+jYFdXm1cvdvlc
	VNoJiD72hctnlMaXGFwhOj5dOWUi4YuCPtMMXxVSCwssaJiVQ6W3
X-Google-Smtp-Source: AGHT+IHvuiQ11gAkoKS3rCe97S3KuLMKzouT0A0cJvTiDOGIAHHuTbB508x/HbxPHwETNFjvQVZ23g==
X-Received: by 2002:a17:907:a07:b0:a9e:df83:ba57 with SMTP id a640c23a62f3a-aa4c7ed4e08mr480546166b.22.1732049733039;
        Tue, 19 Nov 2024 12:55:33 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffc00sm694709266b.101.2024.11.19.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:55:32 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [RFC v2 1/2] dmapool: Move pool metadata into non-DMA memory
Date: Tue, 19 Nov 2024 21:55:28 +0100
Message-Id: <20241119205529.3871048-2-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a `struct dma_block` object resides in DMA memory, a malicious
peripheral device can corrupt its metadata --- specifically, its
`next_block` pointer, which links blocks in a DMA pool. By corrupting these
pointers, an attacker can manipulate `dma_pool_alloc()` into returning
attacker-controllable pointers, which can lead to kernel memory corruption
from a driver that calls it.

To prevent this, move the `struct dma_block` metadata into non-DMA memory,
ensuring that devices cannot tamper with the internal pointers of the DMA
pool allocator. Specifically:

- Add a `vaddr` field to `struct dma_block` to point to the actual
  DMA-accessible block.
- Maintain an array of `struct dma_block` objects in `struct dma_page` to
  track the metadata of each block within an allocated page.

This change secures the DMA pool allocator by keeping its metadata in
kernel memory, inaccessible to peripheral devices, thereby preventing
potential attacks that could corrupt kernel memory through DMA operations.

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 mm/dmapool.c | 60 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a151a21e571b..25005a9fc201 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -43,6 +43,7 @@
 struct dma_block {
 	struct dma_block *next_block;
 	dma_addr_t dma;
+	void *vaddr;
 };
 
 struct dma_pool {		/* the pool */
@@ -64,6 +65,8 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
 	struct list_head page_list;
 	void *vaddr;
 	dma_addr_t dma;
+	struct dma_block *blocks;
+	size_t blocks_per_page;
 };
 
 static DEFINE_MUTEX(pools_lock);
@@ -91,14 +94,35 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 
 static DEVICE_ATTR_RO(pools);
 
+static struct dma_block *pool_find_block(struct dma_pool *pool, void *vaddr)
+{
+	struct dma_page *page;
+	size_t offset, index;
+
+	list_for_each_entry(page, &pool->page_list, page_list) {
+		if (vaddr < page->vaddr)
+			continue;
+		offset = vaddr - page->vaddr;
+		if (offset >= pool->allocation)
+			continue;
+
+		index = offset / pool->size;
+		if (index >= page->blocks_per_page)
+			return NULL;
+
+		return &page->blocks[index];
+	}
+	return NULL;
+}
+
 #ifdef DMAPOOL_DEBUG
 static void pool_check_block(struct dma_pool *pool, struct dma_block *block,
 			     gfp_t mem_flags)
 {
-	u8 *data = (void *)block;
+	u8 *data = (void *)block->vaddr;
 	int i;
 
-	for (i = sizeof(struct dma_block); i < pool->size; i++) {
+	for (i = 0; i < pool->size; i++) {
 		if (data[i] == POOL_POISON_FREED)
 			continue;
 		dev_err(pool->dev, "%s %s, %p (corrupted)\n", __func__,
@@ -114,7 +138,7 @@ static void pool_check_block(struct dma_pool *pool, struct dma_block *block,
 	}
 
 	if (!want_init_on_alloc(mem_flags))
-		memset(block, POOL_POISON_ALLOCATED, pool->size);
+		memset(block->vaddr, POOL_POISON_ALLOCATED, pool->size);
 }
 
 static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t dma)
@@ -143,7 +167,7 @@ static bool pool_block_err(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	}
 
 	while (block) {
-		if (block != vaddr) {
+		if (block->vaddr != vaddr) {
 			block = block->next_block;
 			continue;
 		}
@@ -301,6 +325,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 {
 	unsigned int next_boundary = pool->boundary, offset = 0;
 	struct dma_block *block, *first = NULL, *last = NULL;
+	size_t i = 0;
 
 	pool_init_page(pool, page);
 	while (offset + pool->size <= pool->allocation) {
@@ -310,7 +335,8 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 			continue;
 		}
 
-		block = page->vaddr + offset;
+		block = &page->blocks[i];
+		block->vaddr = page->vaddr + offset;
 		block->dma = page->dma + offset;
 		block->next_block = NULL;
 
@@ -322,6 +348,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 
 		offset += pool->size;
 		pool->nr_blocks++;
+		i++;
 	}
 
 	last->next_block = pool->next_block;
@@ -339,9 +366,18 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
 	if (!page)
 		return NULL;
 
+	page->blocks_per_page = pool->allocation / pool->size;
+	page->blocks = kmalloc_array(page->blocks_per_page,
+				     sizeof(struct dma_block), GFP_KERNEL);
+	if (!page->blocks) {
+		kfree(page);
+		return NULL;
+	}
+
 	page->vaddr = dma_alloc_coherent(pool->dev, pool->allocation,
 					 &page->dma, mem_flags);
 	if (!page->vaddr) {
+		kfree(page->blocks);
 		kfree(page);
 		return NULL;
 	}
@@ -383,6 +419,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 		if (!busy)
 			dma_free_coherent(pool->dev, pool->allocation,
 					  page->vaddr, page->dma);
+		kfree(page->blocks);
 		list_del(&page->page_list);
 		kfree(page);
 	}
@@ -432,9 +469,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	*handle = block->dma;
 	pool_check_block(pool, block, mem_flags);
 	if (want_init_on_alloc(mem_flags))
-		memset(block, 0, pool->size);
+		memset(block->vaddr, 0, pool->size);
 
-	return block;
+	return block->vaddr;
 }
 EXPORT_SYMBOL(dma_pool_alloc);
 
@@ -449,9 +486,16 @@ EXPORT_SYMBOL(dma_pool_alloc);
  */
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 {
-	struct dma_block *block = vaddr;
+	struct dma_block *block;
 	unsigned long flags;
 
+	block = pool_find_block(pool, vaddr);
+	if (!block) {
+		dev_err(pool->dev, "%s %s, invalid vaddr %p\n",
+			__func__, pool->name, vaddr);
+		return;
+	}
+
 	spin_lock_irqsave(&pool->lock, flags);
 	if (!pool_block_err(pool, vaddr, dma)) {
 		pool_block_push(pool, block, dma);
-- 
2.34.1

