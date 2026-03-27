Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942B346FAB
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580476; cv=none; b=eCXwskSDV0sy+5KqcZn2RbUES5qdAXlmw3JnkeYKYwLOjNI6fqzPQ2FfCIA7fURxnyhPfgWJzL1+FnsYZw5axMThmuiJLEah46grjPwcE8g3Hg9EnHdVOE+TGDbJvk9A4sIt4PgW8MDoAiHQ4O/oUb85rE7ulo+4tjKhLdGjOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580476; c=relaxed/simple;
	bh=7DMNlTY2jlvefaXB7B3i5KgnD7WNmdQteQy2H9okiIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NepFuy4wiioMDQwaQDO4lEa9CevTLbPIyJg2kOMSoDFWZ1Kykz2ecOMdfpNsFXRu6rmvcjQVlDZ98t2IdKa+V7TvQhj4/MHKeqj7NkBDK21XphorDu/gRheiyG+BpjuEDQe9nssofAQk4Ggs6lemaoouYWJmM7+vF2hQhZnpnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imD886q+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imD886q+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2addb31945aso13150955ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580475; x=1775185275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7z3iVejW0eNJULH3BGqY9g0Ns0Iw/ol1WcBG/Retfc=;
        b=imD886q+1s5JTCjrcJpGHKEZSiWtilgh9E+NGwJr1y0JnreRRuZhQIoCawOyv5W0dX
         EPVWrxPoJTruA7voAJms3txBxBZRCI/kdakYtzwc3W0bjFbWZkvO/ODxIQQtS1OzwOVe
         wcOAYI9siQj661vs62i6++owhGkMLdGYy4EYUZ0sCyg/SRCcIvtmLrG8KdBK06Tcyfqm
         DZ8PZ74fpIuD9akYi4zvWFf4Cc/tsfygZurC/f9rcEdGgWSgOrfSwi0D4gXotM5HytPd
         GE/NI0wLBCDX2FGPBBI/NWPMBTl4354KLG2NpTew6ngdPJstwSEgZ13IOgZrY4eGqEJ+
         lxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580475; x=1775185275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7z3iVejW0eNJULH3BGqY9g0Ns0Iw/ol1WcBG/Retfc=;
        b=oZrVQ/Uud30ByzKn1siMncC4ZoRqhS40RrOBcOS8ODHR6c9PgkGDpvt/gtQ8P2YIBO
         mBe0B91qNXW1tKuuTq+w6w49cigarNOZPF2Ys4y0Gbf7gnnvgXzZFfmsbxaJ0WL2lCls
         EfYO+xeKLLPUcXlncl9UsSOnA26RvXkf45asKBNTNPVMLQeWPR/eDw+a6H1l04ID6pJG
         KrLPB4cI9qGe4U6alCwsne/YyJ1yirMtGZXv8pCYZNkLu0cORNObignp1+zKuhAetWB4
         TYIIrgY2vKiq9DY73FBA5n3/vVPEiCBlliPx2afdrmyXQOkSSg1jgPonFby2EzIkhBPE
         +rPw==
X-Forwarded-Encrypted: i=1; AJvYcCU9+rsxl+PK+h+0LTb2Q+0c62LB00+UG2aH37Pc2tmtwcRHoUtoUi42iamzpuIaG+rUpacsXxt4aaf2fG7Jxck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JIekjQl+AmtcRhdhKmJoZi1Tnnp2+bfCKQB2vjWfQdEoTHtb
	WhR4uhTNwDcfIqziKLFamGUW7TVua0qXMREWQIBHfsypgqvAWEqj/jW91l7SDZPq
X-Gm-Gg: ATEYQzxQnN7+XUs5+J/mfJmadlNrW6xf4hdYRuEF5qu97m44nNhFbeAkmuTr7pAOFvh
	s5YzZ1izAiRq944bnt4qnhQ/VOq7GWF/qojfKdpH7haBq+YY1eeWs2lbGgYQxfhXlx7hMsMq5ZX
	pikq5imrVAs4gCNYupzVUNsihiVyo3ce3DmXDuGL46/f3FxUUMM9OR09TKzMeqh3fAr4cXQdN9G
	xwSPrelKB0lbUD0y1u2d5JIO7+qit96qfPv9qQXXcU3laRKcyRZPQHex560cD8ENOSkdHV/Lq6P
	5SrmdQ5s3/wLGIDZm+V8H9maFhOuf+BqzdCEmwQAvbVmUZsp0TJRWMPuMr41rYKo34DBdBSI0vB
	XS+4wfeenxegaAT+9Py5JBY3wH695XbOMveGyprkmXSNfUPEZcpQ1p8MvL7GsEsFABhAYxUlgQN
	VvP00L4sAKmOSH/AUH24xG+qt0lBk4/RTCUK79qsV61wAW5k08VUYI+zg=
X-Received: by 2002:a17:902:d4c5:b0:2b0:c451:ae8a with SMTP id d9443c01a7336-2b0cdc239ecmr9754325ad.13.1774580474707;
        Thu, 26 Mar 2026 20:01:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm9331985ad.25.2026.03.26.20.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:01:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] RDMA/siw: use kzalloc_flex
Date: Thu, 26 Mar 2026 20:00:56 -0700
Message-ID: <20260327030056.8321-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/sw/siw/siw.h     |  2 +-
 drivers/infiniband/sw/siw/siw_mem.c | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..2b327a899a1c 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -119,9 +119,9 @@ struct siw_page_chunk {
 
 struct siw_umem {
 	struct ib_umem *base_mem;
-	struct siw_page_chunk *page_chunk;
 	int num_pages;
 	u64 fp_addr; /* First page base address */
+	struct siw_page_chunk page_chunk[] __counted_by(num_pages);
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 98c802b3ed72..08047fcf0df1 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -50,7 +50,6 @@ void siw_umem_release(struct siw_umem *umem)
 		kfree(umem->page_chunk[i].plist);
 		num_pages -= PAGES_PER_CHUNK;
 	}
-	kfree(umem->page_chunk);
 	kfree(umem);
 }
 
@@ -347,16 +346,12 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
 	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
 
-	umem = kzalloc_obj(*umem);
+	umem = kzalloc_flex(*umem, page_chunk, num_chunks);
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
 
-	umem->page_chunk =
-		kzalloc_objs(struct siw_page_chunk, num_chunks);
-	if (!umem->page_chunk) {
-		rv = -ENOMEM;
-		goto err_out;
-	}
+	umem->num_pages = num_pages;
+
 	base_mem = ib_umem_get(base_dev, start, len, rights);
 	if (IS_ERR(base_mem)) {
 		rv = PTR_ERR(base_mem);
@@ -385,7 +380,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 		umem->page_chunk[i].plist = plist;
 		while (nents--) {
 			*plist = sg_page_iter_page(&sg_iter);
-			umem->num_pages++;
 			num_pages--;
 			plist++;
 			if (!__sg_page_iter_next(&sg_iter))
-- 
2.53.0

