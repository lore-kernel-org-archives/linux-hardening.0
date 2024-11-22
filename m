Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331C1DF98F;
	Fri, 22 Nov 2024 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309912; cv=none; b=MsIXSo3/eNNl0yx472ZwpT+bkPQcMeA+9TnqsIpSnlvbUiwGkwblpVr9okxJMQHi0AfLEqW31ft+BeuvXBLXaoSBH7iYGrGWsxgJYM1e27Te6EKYDTZiCe6pPcnWOEOkFwygWQKEFnDWtPecuKD2exT/67kjX9glmgnyhjFyxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309912; c=relaxed/simple;
	bh=oLND3jvHwK3cUWlcNguJReOoNM3JutAlqllWKH9Beew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENJxGllX51StU8CBxNhYkMJ2v/uGW/wZEatWbiKlRuDqBgd+LSkZ7K/PjHLgGK+5UvVHUKSD8+xca+ePMbEXZjQw8UlwFkrPFgNnp52pGnMi4cTvr0ay9Lt1hKEiofmo42ZV48H+8yJmrME7DCYbum23pABPBVHjoUG6XRkmuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf7/PHS8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf7/PHS8"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso30185891fa.1;
        Fri, 22 Nov 2024 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309908; x=1732914708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceOYRg+db2e1ipikZCFVwiN54lElh7G8dmSvY9RkE2I=;
        b=Vf7/PHS8EYAKqhujn+jevnD293ccv5fgNWMPeoLlzb73P/oudfnco3AQyU0JcZJuLC
         +MdQ+9VkZVGKRSlb5JYZr4ACBZUlPNHF7XQ+7aC9Zo1T+cKnGX0o8kB/tPsxcV7Wuvjt
         paiqJaoIQFH8u75VQNxk2IjNQSqASPxgzmJEvgwXDhR/iRWRQehscTMKqhUNnH4azFTk
         ba2EGNlWVdoMKPesqp4cmybiGtclfk2I0fhEEhPsOaLjxk+y7RcO4JHCINfK95S4He3e
         SdqI17OUOSHgw0/eeNauGE9h2ASzeQ4FNqqLQ0ncrWaRDa726uqgTVmO5ksJEzKEdv27
         kHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309908; x=1732914708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceOYRg+db2e1ipikZCFVwiN54lElh7G8dmSvY9RkE2I=;
        b=dYm4B6eoKPqUIPri0xqSdpVtdMk5wsv9k1CkaZIv86WFVT2ZJhZ7Fdh07TGI8NJhH2
         o6qpbumWxZXGzqbPKrwZeeY3xuyz27WX7zTnxwvwRIuT8l/b/Ldg/jef9JYhxuShKOeH
         lEpyIJ2dKICvnDkcIFJvMkunJc+afLtyLjrPkLGPYrpJ5y7Lj4blHygUC4KYoXrbb/tb
         /N5XZZ3U9ZlBZBOgSXfonekPDorlQVkuWTP14bzs+ioIhwCQrZ5xwGycOre8Fy8N82Cl
         fZ/F3ph0UogiCQluauJMVpjDP4rZi2A6PJCUQf0PMFuOnNBTSe1h7SYlNs7MwJy6YPmB
         3TQg==
X-Forwarded-Encrypted: i=1; AJvYcCWa09J+/5dPhE21HZkQFNdAwVTWdXraidxGQ2Z83B3vKLqmS0LuJKRkzSzTih152nq7Zluy6vKki7UCVPoy@vger.kernel.org, AJvYcCX5/r7vYFGU2x0aRQASOEFGN6MLQbTb3wNFjmaoBRXWUoc/xl5nUXKHSrwQOJP0xwZxMDi9NpWFBOeRtnbXTk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyev6PPNPUB92q4nwRKBL22t6kKvwlQpfEKQQvS4ZQ1KxXoZc5b
	WoHNXuU0S7jVjrxtcll9gOIlrFEGgze4/a3426QzUIjsb1ZeTIew
X-Gm-Gg: ASbGncs58sSdQQAmSxlmraSD1thruK+IUf6/uY18kSknNu74pHnSbG11kXXMuRwPVU2
	+up8JOBrLkg1IkU5pqy27y7N4Nr65x3s0AW1nh/7Yil26mtVcwopAxwuZJgUSN8jy9UiePegTZ9
	I/23juGVmSkhJEOf/pwrwLoJQ0TRg6Tx7c11a+74MHGDF2Kn3yeywebwB1Emb2J1chhkx0NE5r2
	UA046krf+JV5GECFdcuN5IH7mQUCqI6kz84qlWEuVPR4BTJ1jpeK5N1xKfXBd2JTucP6/JjmqcB
	8II=
X-Google-Smtp-Source: AGHT+IHflXg42uO4arPQnjfIO/UofICtO5/JXuDET1ub2S+twpsY6z11Bye48LygEoeC+l1hYpSXag==
X-Received: by 2002:a2e:9811:0:b0:2ff:a89b:4348 with SMTP id 38308e7fff4ca-2ffa89b4584mr20119431fa.1.1732309908285;
        Fri, 22 Nov 2024 13:11:48 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a3d77sm1276636a12.7.2024.11.22.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:11:47 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/3] dmapool: Move pool metadata into non-DMA memory
Date: Fri, 22 Nov 2024 22:11:43 +0100
Message-Id: <20241122211144.4186080-3-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122211144.4186080-1-bjohannesmeyer@gmail.com>
References: <20241122211144.4186080-1-bjohannesmeyer@gmail.com>
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

**Performance Impact**

Unfortunately, performance results from the `DMAPOOL_TEST` test show this
negatively affects performance. Before the patch:
```
dmapool test: size:16   align:16   blocks:8192 time:11860
dmapool test: size:64   align:64   blocks:8192 time:11951
dmapool test: size:256  align:256  blocks:8192 time:12287
dmapool test: size:1024 align:1024 blocks:2048 time:3134
dmapool test: size:4096 align:4096 blocks:1024 time:1686
dmapool test: size:68   align:32   blocks:8192 time:12050
```

After the patch:
```
dmapool test: size:16   align:16   blocks:8192 time:34432
dmapool test: size:64   align:64   blocks:8192 time:62262
dmapool test: size:256  align:256  blocks:8192 time:238137
dmapool test: size:1024 align:1024 blocks:2048 time:61386
dmapool test: size:4096 align:4096 blocks:1024 time:75342
dmapool test: size:68   align:32   blocks:8192 time:88243
```

While the performance impact is significant, this patch provides protection
against malicious devices tampering with DMA pool metadata. A subsequent
patch in this series introduces an optimization to mitigate the runtime
overhead.

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 mm/dmapool.c | 62 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4..3790ca4a631d 100644
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
@@ -238,8 +262,6 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 
 	if (size == 0 || size > INT_MAX)
 		return NULL;
-	if (size < sizeof(struct dma_block))
-		size = sizeof(struct dma_block);
 
 	size = ALIGN(size, align);
 	allocation = max_t(size_t, size, PAGE_SIZE);
@@ -301,6 +323,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 {
 	unsigned int next_boundary = pool->boundary, offset = 0;
 	struct dma_block *block, *first = NULL, *last = NULL;
+	size_t i = 0;
 
 	pool_init_page(pool, page);
 	while (offset + pool->size <= pool->allocation) {
@@ -310,7 +333,8 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 			continue;
 		}
 
-		block = page->vaddr + offset;
+		block = &page->blocks[i];
+		block->vaddr = page->vaddr + offset;
 		block->dma = page->dma + offset;
 		block->next_block = NULL;
 
@@ -322,6 +346,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 
 		offset += pool->size;
 		pool->nr_blocks++;
+		i++;
 	}
 
 	last->next_block = pool->next_block;
@@ -339,9 +364,18 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
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
@@ -383,6 +417,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 		if (!busy)
 			dma_free_coherent(pool->dev, pool->allocation,
 					  page->vaddr, page->dma);
+		kfree(page->blocks);
 		list_del(&page->page_list);
 		kfree(page);
 	}
@@ -432,9 +467,9 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	*handle = block->dma;
 	pool_check_block(pool, block, mem_flags);
 	if (want_init_on_alloc(mem_flags))
-		memset(block, 0, pool->size);
+		memset(block->vaddr, 0, pool->size);
 
-	return block;
+	return block->vaddr;
 }
 EXPORT_SYMBOL(dma_pool_alloc);
 
@@ -449,9 +484,16 @@ EXPORT_SYMBOL(dma_pool_alloc);
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

