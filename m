Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1221E098
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473261; cv=none; b=F9YSlawO4tEfsk23Lb235YBBc5MLdYJ523ZHATDfMnMbFI8jQcExl0DTfhiLC91vKsfUZgbmUMdqoLHgxsq7eGmW8i3EvvwNyCpz9sjKh6y7X7aGeWkqBYUJikVKB81wGaQbWUrAhoQwyFtTW11qxYW36V1JIo5GK+wRD9K4pGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473261; c=relaxed/simple;
	bh=hIPAJ8hojM8GgeoKrEwNAzY7zEI56ACG1AfbKYQ8ELk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTABFWBp4Ozg+gh4OH4cfCTxJEj0q/H45zhQVgwn/Ofy+bGWV+JJ7rSN7DVOoflc5xJ3kb4rqPtEOXquX5/3CkrFJ9gqqSUCvXKV2+6uorBZkVKQlrpOAADBRjWDD5e7nj7mzKPm23AsPX9/PZ9FZ87GZtXG24qrXkdZ9hNlcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc9fGyr7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc9fGyr7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba21d32776so25252685ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 10 May 2026 21:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473259; x=1779078059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTR7mTxLAlp1FX5tjnAs7/WkIvr6zEWiJrL5MefUt1E=;
        b=Bc9fGyr7a+kjE1klxpzNHLxW18hqTybMqUa2s6IW+Kg4/ZmCbNYfQP3ALizaBglQGS
         hMryXcLxmUMnSTzxcPCYH+Sg1bKZ/LPHHffpsI/HrNLzQPcc6b4xcxJV4ZvNDTRqLvv5
         nQhOHhmoTHWmmbUyel3bsHvhQlrmrirsqOScmHImcPBchwIiAn9yjLs7gOb3J9IuxO79
         wZogdbeJasjHZVVc5uPGunyVjc7RQrCGqVKNQ4o4aI93nikQzPDJstmaWJoANaAiKCOP
         WfQpr3wTc/FqHnGgnfb/syh3t/TuYSb+J/3mZoNXN3AWzAz8EJHez0dwvDF4TYJV3DIi
         odmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473259; x=1779078059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTR7mTxLAlp1FX5tjnAs7/WkIvr6zEWiJrL5MefUt1E=;
        b=N8ufPy7bEhChX8Slof0chRTF4JIXa5fknFEYq8vOZI1ZSoQMtvbxcKST8kciLTyaJR
         sI857adPjekKRcHD8fWUdcCYyV/By99VnkIqhwzw/hYyLShMxwpFLG+Ej8fZjxzVe2dx
         uzqY2uJDqnATQ1VJ55pKQi2KETpLLTICNPyEYU2bVj2Pe0MO3fWb9+dkRdv4o9Zvc3QV
         d/6RAhlJMY4EcEVDSOErqD9X54/I8WzYqcP5mEO7lBDub8newHJ6YtKN+HVchBoaVozS
         8nec5d1AKixORSKMbRPP5YHvbDa+q78viLFRYLUIl9Qwt636dwP8zFgV1zTd016C0XGb
         WuFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yMPXddvXfVV/jfPbfwQ+LKR6SVoZdWABosSP89cgK9KqKNIXcBipNsPwXn1dN6eSWHqx3b5/vuT/8xMErie8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZL1GLmpxISo6cQE01tbNV/4alJcGI1yCzh5Rf8Lrs/QF0c1L
	Lvq+ffdvINhm7c34VbK1ku234Mqt7tutBrgD3J4X9fGB3jUWA+XBojcG
X-Gm-Gg: Acq92OHKCPbfEcAqMzQPaxA44q0ACzJlBzxBqioVEDOh0cnEoV4S8HNiYNlU1+3P3km
	Axk9dw6OwZv/uhD0kPAuyxoLGd2y34APJ+pW30gZH2JrgU2xpRcB5JViHRamoRZXfmWhiGz7aqy
	IPMy2PwHLZN411Nek5GmOKNjlgCINPITmrJHfjYPXff+MwAwLRwlgQBjIfpR87+2Di53T1NRmL0
	nDcpDI3QfSZuMeXkX30m6BHUeZQtfNmLuUxUCjdY2W+ZJj1kU0W9uPpE2/f2IRhjvWUQY94jTPx
	iaOMM8uexlWXG6/cAr96WOxQPHE1E3Ls+RP/Hw/ZROIPFX8GuS5ANduPowQAIWjWRPf3pc9bbL8
	f8nfCJ8cAlrCSzq4dc+kVJF4jpg/VhXah2yQhgwc56lBfE6+TQpvUTkAxBpZmFuSuzdUlbvl/M8
	xEgXECqR/AWNU6Cn7jOD/01z7kyW450KX0R63Udaay9Vn76KM/2KylWg+d7QC8rZmblx0h8n9Zw
	w8lYiSRywb5c92hYBVmB1vPh4u5Exo8LcUjuh1sFYkOwA==
X-Received: by 2002:a17:903:3d49:b0:2ba:7699:4137 with SMTP id d9443c01a7336-2ba792ae937mr166753505ad.28.1778473259513;
        Sun, 10 May 2026 21:20:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27055sm87752185ad.6.2026.05.10.21.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:20:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] virt: nitro_enclaves: Use flexible array for memory pages
Date: Sun, 10 May 2026 21:20:41 -0700
Message-ID: <20260511042041.378366-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the per-region page pointers in the memory region allocation
instead of allocating them separately.

Keep the allocated page-pointer capacity separate from the number of
pinned pages so __counted_by() describes the flexible array bounds while
nr_pages continues to track pages that need to be released.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 15 ++-------------
 drivers/virt/nitro_enclaves/ne_misc_dev.h |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index c91300a73f50..c0045b2cf7f3 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -927,19 +927,11 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	if (rc < 0)
 		return rc;
 
-	ne_mem_region = kzalloc_obj(*ne_mem_region);
+	max_nr_pages = mem_region.memory_size / NE_MIN_MEM_REGION_SIZE;
+	ne_mem_region = kzalloc_flex(*ne_mem_region, pages, max_nr_pages);
 	if (!ne_mem_region)
 		return -ENOMEM;
 
-	max_nr_pages = mem_region.memory_size / NE_MIN_MEM_REGION_SIZE;
-
-	ne_mem_region->pages = kzalloc_objs(*ne_mem_region->pages, max_nr_pages);
-	if (!ne_mem_region->pages) {
-		rc = -ENOMEM;
-
-		goto free_mem_region;
-	}
-
 	phys_contig_mem_regions.regions = kzalloc_objs(*phys_contig_mem_regions.regions,
 						       max_nr_pages);
 	if (!phys_contig_mem_regions.regions) {
@@ -1049,7 +1041,6 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		put_page(ne_mem_region->pages[i]);
 free_mem_region:
 	kfree(phys_contig_mem_regions.regions);
-	kfree(ne_mem_region->pages);
 	kfree(ne_mem_region);
 
 	return rc;
@@ -1398,8 +1389,6 @@ static void ne_enclave_remove_all_mem_region_entries(struct ne_enclave *ne_encla
 		for (i = 0; i < ne_mem_region->nr_pages; i++)
 			put_page(ne_mem_region->pages[i]);
 
-		kfree(ne_mem_region->pages);
-
 		kfree(ne_mem_region);
 	}
 }
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index 2a4d2224baba..f419e04007f8 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -28,8 +28,8 @@ struct ne_mem_region {
 	struct list_head	mem_region_list_entry;
 	u64			memory_size;
 	unsigned long		nr_pages;
-	struct page		**pages;
 	u64			userspace_addr;
+	struct page		*pages[];
 };
 
 /**
-- 
2.54.0

