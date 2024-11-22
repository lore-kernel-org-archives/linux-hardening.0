Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F42185936;
	Fri, 22 Nov 2024 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309910; cv=none; b=ksjC5FXT8T7pmI6GGnAYNP4uoElkzVzkxoOvhqwT8XAFJ/hn+nEA1MhrGjX44LUQz1j34Z9ARLwyl/IrjnrdKt+b/qat/p2i/5dMaWo5eEFLceySGEmqKyg4pcTu1y3erTS1F9wEnkFrtJyuXOlr8X7bhE8RBCk6Wf/on7JCA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309910; c=relaxed/simple;
	bh=/QWk8Y0rnqv9K62giJa8DNzIs0t3l7bX5HbMJmPLR9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhUHxJWV6fvca5wIp/RK5omWsoi7wJi/psXD6pxaVhktvWbThHw2zlbbEjQncq3LagRFEKttofLHJQxdHmmZquXOuU4EViHaAIRl25JRDrIDNkFyuxxbfAQaXjUaTW8EszSaMXqjGcCEXO+SOcxV1gcKLKBCFvTX5uCywb0t7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px6EHPvq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px6EHPvq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfadf851e2so3241483a12.2;
        Fri, 22 Nov 2024 13:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309907; x=1732914707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujlMhj3nrkjMEnTUfH0KLv8YxE/6CvGqSF8Yncy0GFs=;
        b=Px6EHPvq4CpOxOMh+GMtQNq6XuZnSUi8NV5QOIeVWOH98rE3ZwbqRi59zm3sXkcKXm
         /Vm5jyBPA8WHUl89cNF6YaZpLOkxplTX5RPiSosg5K8IAFpZ05srBa/hnC+7DGRJlcUo
         Ny2YTrKSBi8tdaWLOcrbkA8+bFfnjfkcfr7d3/OCARLCDqcFXAp9AUr+LoZr0L2Iyp/8
         40zg/NcaOsCzwqO9GaUqheA+gDLNvBDDD1kzvr2jmbZPHBEespbNKQi5kRaPNOeM4eQX
         VDc6B7/BTIbIZYKGCz8UF/y+JDjE57E6gcnTLGETktK2g4plPNX7ICUFk6/S29zKzljA
         opHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309907; x=1732914707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujlMhj3nrkjMEnTUfH0KLv8YxE/6CvGqSF8Yncy0GFs=;
        b=l6chJeR1u1zryN4LCVPRSnFQHMT4YyXJoScan9EFFuoxdtzlaTAIAMyxMq1Q6ODF/1
         AXBmP/29E4lO6fF445Ys5FIpEvL8GhZ4VH9SmC0H7Ilh8/Bcb3L/zEkP4TiaP35gIktj
         7MiaBtU9Jik2uDnoPSnXwqnILMHZ+MFoXOml4csQLE0mYGaRUscSsZiiTiiGFgliZRNs
         xei3cXhan1hdGcPGIA8lbYsZAkW/IMVf/OlDLuZEjQFpx7tMrjTcqwLw4ySd0k6a0Ryw
         i4d/v1onL9MuaXgbmU290mwgPwVW9FteZdJn12uL6sh87qxMTz234NC0BKRqKZItjvD/
         7guA==
X-Forwarded-Encrypted: i=1; AJvYcCUTTMjC3MaBL1UMVeoAGi8q89nO3L50zXLXvDn5f1PMUnnnfjCsQCM7V/qi/pmi91e74OSn01pbiOf6DpUmJfU=@vger.kernel.org, AJvYcCW+woLpDgin9qmw4VFJGIYUFdT5PYa/K8Wm9twCeTiGurT+48vu0MrrRetb/D536wRsarEn/HUidCmr+3Nh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZriFzm8+Bv/mCwnO1AVH7SErifIMyDw+3TebI8+I++s4p0LU5
	OaccmiDGgGcGobiBLRYwVSrsJEi8btwQU9Y0AzksIx0dTbKXdv0i
X-Gm-Gg: ASbGncsBN/2nOQrCsgseigXvwS4urnxHngm4gsd8OIsFI/Nfzg8IlmWXxN/9RDaLEI1
	8vzgwzaqG7xYIJLGVguaXgT20+YuBbWn4oYqM2gxELojNE5DkIVF2MCGjkHy8QK5ZJupVgpNSQy
	clmGmWQXTpm8NPji/32XvkgWX1tLSHEQj+CWuDYc6AEuCX0xZgSGUExlP20lal2jCp/8CbVFG5/
	GTAWvMtBFLO23YoOoI0HP0K4JU0WQ7sYhyY/n14f8XN4CgO2vf2kTKCqvn133vklNLj9VXnBDEJ
	klo=
X-Google-Smtp-Source: AGHT+IGxEcNdIJkavgQwkyu+9SNy7MVzcGeBojSJ6weJDwmHgDhnLOEF6/aIOKsiwU/UbCHwfH9hVw==
X-Received: by 2002:a05:6402:5187:b0:5cf:d8ea:42d0 with SMTP id 4fb4d7f45d1cf-5d020601597mr3425670a12.12.1732309906975;
        Fri, 22 Nov 2024 13:11:46 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a3d77sm1276636a12.7.2024.11.22.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:11:46 -0800 (PST)
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
Subject: [PATCH v3 2/3] dmapool: Use pool_find_block() in pool_block_err()
Date: Fri, 22 Nov 2024 22:11:42 +0100
Message-Id: <20241122211144.4186080-2-bjohannesmeyer@gmail.com>
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
index 3790ca4a631d..f2b96be25412 100644
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

