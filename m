Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694931D31B6;
	Tue, 19 Nov 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049738; cv=none; b=FKhnNtBtE6/gLjq+8DNKGdrx9YNWBsj2ou4Y8K75zc7p/bkptzmbXoxM2Ag0MMwRhXw5dcH9d6Plt0Ez2n8qstZIypHOYSwV2It3iujBGnCCa9e/Bkj8PAjmOIIUQh+ACgl8m/IoQ8cb33iW9HeAyiuyH/mFGIQPj64UkInQvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049738; c=relaxed/simple;
	bh=NyxDE1HpO53lA9v5ZI7fUWEjH9OfXxnTiRdiQDicHss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zf0mXyP2oXgmTomq9EpoIaAUm50ieFV2pNuY0G/KjDucCcuqmMZMXgTSHvscWomp5Rl+/7dJLPHBWHXzztd03ZKqQEGq51lxPtRkHfR8wPGAybMjpgvJjVr2pYad4rTZ5ToiwjoE2W5UqsKqOudEIzEYCSXMpf+2ZET1HKayQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRtHHb7c; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRtHHb7c"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec267b879so790131866b.2;
        Tue, 19 Nov 2024 12:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732049734; x=1732654534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbuVcaxj8JodWMRgXnQSRz0XnZKwpGSc0YmAvvgqPOo=;
        b=iRtHHb7cuemKSXupOjS215bZpDOXPnwKl3ymuAiQyCcjzLeOO2qWhYxqozap8Gzsok
         0FOQ8uf2u6LVswAHGaKiUWWMt9YcdZOZtiugSOJa3doUUUrtZcuu3DRlGjwmO6TIXK3V
         pq9h5Qy5Zc1qWKpz/o/8H6Dmg84Ca4OCm3mi4ai5g6S/mCH3yLO1rLnRxe0ZS4DUl76p
         4sE2mDVrdTX1KyIWHrpeehi4R6PYuXiguObfhUxJCGY5mtYCRsbCZOQupt/DcCt9Y/Ne
         Bj2WvPR6dIxBnMh26oGwvmd9DaRdeHNqBDZ4/umwFSLWR9hKStSoLwdp/ZhMNmbkYrPq
         /lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049734; x=1732654534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbuVcaxj8JodWMRgXnQSRz0XnZKwpGSc0YmAvvgqPOo=;
        b=uWyL53sDa8X17E+roD+iKm+6TR/oJ/ZK1JwVQO3+Ig85YMINXGLbN8c7YPJdhsS57p
         RC7Xyrc7NBO1nCMAQfHOkylNHC9ATv3ORPecdGSOikqqd6zZckHuoMzDasktYLs6T6zZ
         YDz00u35uOdWutPJ6ffXylr/7Yy4FNYFzpl0VMfbGSfh+sh2WBJWwBiwsQ0cJSO+6JVI
         oHJ10KBbS+ivAcpTa03G5bd4BrqB9k0oWmIddgYx+tYf/3Kijw6lvkB2vfHEkr6i6y9D
         BKluxxio3t1SkIgo9jNLbSF7NE88hgSL8RqsR7q1dpOgpErxwWxv6EKW7WfzSGtDMcCj
         3rHw==
X-Forwarded-Encrypted: i=1; AJvYcCWz64rgNXN7zVwG2DzhBuU7oELAoGc2KQOvr2Z+V2sfKHbfixvhlwrkJcFRw39agvVnlTnMvM5LaTkWQVZoqdg=@vger.kernel.org, AJvYcCXlffyNEPvo4ZLL1yX9WjxX7DjmM1u9r1cjM6iwtOHwWooNXGC9EGxMNr1JIwZEhaF3GZItOYsVWRUy9CUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwJ85QqP5Ktt0uNGYVo614ReM9DhYwT+Oe3N4OHuVA6EsckoR
	J3lTPFdMcOBD5JI5S4OsklYPQwDAUJTkX9ekmXKg5sfXa0mF+J7i
X-Google-Smtp-Source: AGHT+IHgTN9tdFjMSKVLOD9Fb39fDLgUkoJ3LRgFT1/To2hszKOZjZVwYj26pYowqN58Ud0woVF63Q==
X-Received: by 2002:a17:907:9726:b0:a9e:b281:a55d with SMTP id a640c23a62f3a-aa4dd7518dbmr29120966b.56.1732049734460;
        Tue, 19 Nov 2024 12:55:34 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffc00sm694709266b.101.2024.11.19.12.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:55:34 -0800 (PST)
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
Subject: [RFC v2 2/2] dmapool: Use pool_find_block() in pool_block_err()
Date: Tue, 19 Nov 2024 21:55:29 +0100
Message-Id: <20241119205529.3871048-3-bjohannesmeyer@gmail.com>
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

In the previous patch, the `pool_find_block()` function was added to
translate a virtual address into the corresponding `struct dma_block`. The
existing `pool_find_page()` function performs a similar role by translating
a DMA address into the `struct dma_page` containing it.

To reduce redundant code and improve consistency, remove the
`pool_find_page()` function and update `pool_block_err()` to use
`pool_find_block()` instead. Doing so eliminates duplicate functionality
and consolidates the block lookup process.

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 mm/dmapool.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 25005a9fc201..267fe13347bd 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -141,39 +141,25 @@ static void pool_check_block(struct dma_pool *pool, struct dma_block *block,
 		memset(block->vaddr, POOL_POISON_ALLOCATED, pool->size);
 }
 
-static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t dma)
-{
-	struct dma_page *page;
-
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (dma < page->dma)
-			continue;
-		if ((dma - page->dma) < pool->allocation)
-			return page;
-	}
-	return NULL;
-}
-
 static bool pool_block_err(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 {
-	struct dma_block *block = pool->next_block;
-	struct dma_page *page;
+	struct dma_block *block = pool_find_block(pool, vaddr);
 
-	page = pool_find_page(pool, dma);
-	if (!page) {
-		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
-			__func__, pool->name, vaddr, &dma);
+	if (!block) {
+		dev_err(pool->dev, "%s %s, invalid block %p\n",
+			__func__, pool->name, vaddr);
 		return true;
 	}
 
-	while (block) {
-		if (block->vaddr != vaddr) {
-			block = block->next_block;
-			continue;
+	struct dma_block *iter = pool->next_block;
+
+	while (iter) {
+		if (iter == block) {
+			dev_err(pool->dev, "%s %s, dma %pad already free\n",
+				__func__, pool->name, &dma);
+			return true;
 		}
-		dev_err(pool->dev, "%s %s, dma %pad already free\n",
-			__func__, pool->name, &dma);
-		return true;
+		iter = iter->next_block;
 	}
 
 	memset(vaddr, POOL_POISON_FREED, pool->size);
-- 
2.34.1

