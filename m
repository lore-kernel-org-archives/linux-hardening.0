Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416E178CF6;
	Fri, 22 Nov 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309909; cv=none; b=dLv27kOO4emKY/c/Z9YRbXI/ZyDAyhHGyclXadp3vGelT5owOY39nDsQln7VNNwquzF0n2fMsTnU3w6rkXKdzUQiPCOVIDh9w4fVf8bWtYL5M798PBZOKXwlBJQ8ihXpILlb2T+nXFqstyIVZIjwFd9HD3xvmScyOK0paV4ea60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309909; c=relaxed/simple;
	bh=uatQ26xoa9JnUe6BtMBCf1GYdPKJDKcQaN4eKYx4P1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3brPZ2fr2WCObECRZ8x48AXNgZukVeuaie+Czb7jKafUWRFfGu9liGSVlmLWQHt56lNu1LAngh/LeJlKMqbarZ2eavwY9q7NTSNfs9nEGMUzVfn6WQarSIx3Zpje3lNNztBu4+ZQ66V6PRwznVtZMVvQkL6gwMtghdbicUmRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PER1tzqh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PER1tzqh"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfa90e04c2so2830636a12.1;
        Fri, 22 Nov 2024 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309906; x=1732914706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+tcqNNysQkTc2dEl6EX4aObuUUjMDrPgVEtTOtJS3M=;
        b=PER1tzqhRwjECp5aMBNF8X3DPS8zAv1hDfyM84xGVwr7TGwxvOW3nRU0hFLObNA4QM
         YwDGkb1FccnLTWx8ngLkL8MhhFjnMu473jMAa7C3kacd/mR8mKfNrs+bvTRN0KVVzzME
         YMNP6yz8jgnZr1nEr+FW52jNFXIwq1dY6erfqMZq3irs68o8iVkKPKR3XmtppFYuRnTF
         oW8/1mW/u/wTHrborcgb/jH1n92KwbiJKyQduMyX8kBIqSeslxk1aFI0Sxx+yVS6Txdl
         zsROriXIYWQU5cpvkIAFxJ1rF39LZtSP/qJw1gkxGQUYKGrJl960ZMGOrbcVoqfYHlzS
         WFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309906; x=1732914706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+tcqNNysQkTc2dEl6EX4aObuUUjMDrPgVEtTOtJS3M=;
        b=szc5HYX36Lp4VtldfEugWJN7uluAKC4UhPhaUM4YHLk8R4M7JmuyKrzukW7okyXU1M
         X/VvXUVC3IXnyv87HiqT6wxhTpyYKfRroZqrRmcHUjEMCXQ2GkER952nUlWiWP4Tr5Nu
         L3qKwtyC78ZBPIVwr280kBdXiZdbvPjj2TnJuPfUWftIiVwq+WDEzbI17J8vvg5nlYoV
         m+ZDRWhRX0f6f8A/a6vW+KkUN517nH7b7AfyURxeq0SzzQ3CD5X4VK+Tmf3G+R0KR9xL
         WXSdzK8ufqcDSt/qpZz/z88tyX0osI0XRtzCw0SbyvEuSnOu0n4V1CDVoon5kNmLaQVy
         hbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtR/v2dH1rqZasv7GIC9me6k4noZgBRJ2tsorSeBkzC1sjqNmb6oKFRF2BfaolsBB9SUVNzmYCw5t3sP/0@vger.kernel.org, AJvYcCWIgme0BrHBzbwK1b93nYLwkTe4u0K8n5nBZIDaZdrfDKkzl7C+usBN2omp1CijPUHERY3hL+ZRp3k8OI/k4+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCQniwmcoLyOVGTdTKSDmR46ddKEhRgLiBVRGTHSR1mnz0vwd
	aqTRYnYy9dDxD9VaETKcwBcuP28gmkq0xwS0AMIn+TJuFCNI0Oyq
X-Gm-Gg: ASbGncs2E9CuAsn6UiMcUU/TCa6XfyCObHYMmriKw1LN7GN5j5/5ohz6fdkn1w45HgQ
	A9EOA3NLSUNehIK89TIEyTP5ZKppP/2IGKLGx846K2nshW+4rYzPyZenUaZnkY+RG6pBMBT+Ubv
	K526F+NM0GaX4xzX5uMWlEJ4M66idn1hdH0o0gsSucIF/5ep/DQNtXtdp6BhGoDFQUrtboX7L2O
	8OShCUxYWexBxJizSevFtuaP8g3sN0NKVXH0lk69+nKpMG6N1pMD6Zok1fLowDe4GGPnZmxLsiN
	zOg=
X-Google-Smtp-Source: AGHT+IGEeoVa+pVRYbHHLYkUM3zI+FvCZ/MKAJa4ua0+3IKCCAjUzBlQr/GgpjHTIBVkdjwu7BjCMw==
X-Received: by 2002:a50:ef18:0:b0:5d0:224b:d585 with SMTP id 4fb4d7f45d1cf-5d0224bd6b7mr2968510a12.31.1732309905574;
        Fri, 22 Nov 2024 13:11:45 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a3d77sm1276636a12.7.2024.11.22.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:11:45 -0800 (PST)
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
Subject: [PATCH v3 3/3] dmapool: Use xarray for vaddr-to-block lookup
Date: Fri, 22 Nov 2024 22:11:41 +0100
Message-Id: <20241122211144.4186080-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the performance of `dma_pool_free()` by implementing an xarray to
map a `vaddr` to its corresponding `block`. This eliminates the need to
iterate through the entire `page_list` for vaddr-to-block translation,
thereby improving performance.

Performance results from the `DMAPOOL_TEST` test show the improvement.
Before the patch:
```
dmapool test: size:16   align:16   blocks:8192 time:34432
dmapool test: size:64   align:64   blocks:8192 time:62262
dmapool test: size:256  align:256  blocks:8192 time:238137
dmapool test: size:1024 align:1024 blocks:2048 time:61386
dmapool test: size:4096 align:4096 blocks:1024 time:75342
dmapool test: size:68   align:32   blocks:8192 time:88243
```

After the patch:
```
dmapool test: size:16   align:16   blocks:8192 time:37954
dmapool test: size:64   align:64   blocks:8192 time:40036
dmapool test: size:256  align:256  blocks:8192 time:41942
dmapool test: size:1024 align:1024 blocks:2048 time:10964
dmapool test: size:4096 align:4096 blocks:1024 time:6101
dmapool test: size:68   align:32   blocks:8192 time:41307
```

This change reduces the runtime overhead, particularly for larger block
sizes.

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 mm/dmapool.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f2b96be25412..1cc2cc87ab93 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -35,6 +35,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/xarray.h>
 
 #ifdef CONFIG_SLUB_DEBUG_ON
 #define DMAPOOL_DEBUG 1
@@ -59,6 +60,7 @@ struct dma_pool {		/* the pool */
 	unsigned int boundary;
 	char name[32];
 	struct list_head pools;
+	struct xarray block_map;
 };
 
 struct dma_page {		/* cacheable header for 'allocation' bytes */
@@ -96,23 +98,7 @@ static DEVICE_ATTR_RO(pools);
 
 static struct dma_block *pool_find_block(struct dma_pool *pool, void *vaddr)
 {
-	struct dma_page *page;
-	size_t offset, index;
-
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (vaddr < page->vaddr)
-			continue;
-		offset = vaddr - page->vaddr;
-		if (offset >= pool->allocation)
-			continue;
-
-		index = offset / pool->size;
-		if (index >= page->blocks_per_page)
-			return NULL;
-
-		return &page->blocks[index];
-	}
-	return NULL;
+	return xa_load(&pool->block_map, (unsigned long)vaddr);
 }
 
 #ifdef DMAPOOL_DEBUG
@@ -273,6 +259,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	retval->boundary = boundary;
 	retval->allocation = allocation;
 	INIT_LIST_HEAD(&retval->pools);
+	xa_init(&retval->block_map);
 
 	/*
 	 * pools_lock ensures that the ->dma_pools list does not get corrupted.
@@ -324,6 +311,12 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 		block->dma = page->dma + offset;
 		block->next_block = NULL;
 
+		if (xa_err(xa_store(&pool->block_map, (unsigned long)block->vaddr,
+				    block, GFP_KERNEL))) {
+			pr_err("dma_pool: Failed to store block in xarray\n");
+			return;
+		}
+
 		if (last)
 			last->next_block = block;
 		else
@@ -385,6 +378,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 	if (unlikely(!pool))
 		return;
 
+	xa_destroy(&pool->block_map);
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
 	list_del(&pool->pools);
-- 
2.34.1

