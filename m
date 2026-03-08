Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA21E1DE9
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772940016; cv=none; b=jDs61mpHtK/e8qIXFR8YhcPOCz7FyijHPOoL9+z+BSBdoBG4d5dmU6vqwPr7gwfGjEzncaleKa+DIO/VoeCu7dHIFfjfEdYBq7RjGtHVYPLFmWpW3wmYne14rp6Q4UiVDxz0XLrPX+CAZpfY8vPlpQNOEvH3H5PDpkMWt9KeWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772940016; c=relaxed/simple;
	bh=KgJsvx1IcN9NsDZGqhbA1t3ZxHApBqizQDZHsQZW1d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmI0B0zcJSZZMu/brElm6gF6ZePksjQAXhRj/Jxd0UAUsn1B/AIFltEdLcC3SF41uZtQ2gqv4SKYs2oLDkp51zHlitQVLE8+ZIzkj992q8oYXJ5/7ZTRoikwgXHRolLR1nvgS6s8U7pSPuR3QzOV6zeZmiWuNnxR5FaQnfD7uSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEwKwETe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEwKwETe"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so6006267b3a.3
        for <linux-hardening@vger.kernel.org>; Sat, 07 Mar 2026 19:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772940015; x=1773544815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5S2gvLeO3HtB5KquXoTw6XAQVdla0vPImwUUawa4hM=;
        b=OEwKwETeL7874jmFVnJ+R3tskTk8MuhtMW2sPCD+l8lGOyFbUNdsPc7K4F3DsgqMes
         Bwj/JcYf1UKwThue8Md0eihoRj/wpJn9DqEbbRkFFNHW5h5sot65drmBf+EeZK7mGR0z
         bwMSCkRexd/7vnFukgf+v2C9nQ5H8BSMcyBk1xmKJPbdHwt0+Ig988b5KUf6UfBXoAtY
         QRCqHKlztBEQPseQHI0sW6XXkUkKMflji5hu7JqqR+aMwMzQub5UgnaC6DPIE6uK0MLE
         fJIYmhlbTnMcCGyTdyEaY85dlWhm0+RFtf4766eg4gYWUGcB4YlcFG/QvH/yzXnj8HE+
         7M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772940015; x=1773544815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5S2gvLeO3HtB5KquXoTw6XAQVdla0vPImwUUawa4hM=;
        b=MVoRiG31tZQY0Nz4xAvKfnzJLFzTPVJ40CSzx3m0wAyoIPowURc1ELyKpbYmRZ2KQ+
         B/4Yo1zzz7zIoMwBXVrq4vx0aiNZNR6j+CNf/tRV60sg9o1MUGYfWrpM+fHNovy9E87o
         UlaL/ntSYyEWvsHi3StMWs4E6khDV+KHhklb6EliBLK/68nz3a7nvRSvSHGqjBuj7Xml
         OPSrcMWY8aZNobsJe4U4o5p9bONGTTsGK4Ge7X8aZHABzPMOqMvdLzxr5YGnP3Rq88T6
         /sZ7i6wxir3pmWmgnBB2YNe8Ml5jDB4Pc+27aSrgkHvUpgzq5pw85jvoTVdzond3Qs4b
         5ztQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzJCL3dL6FhqJpcYjVHPpjxmfiN/KQtTMiuGdj7n5mPdISjCI5cgW6Y0nJk11eYgLgdno4hE0lIWid0BqUxn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EKPitk7vkBgz05zqlPH/fYsp7lIbwIaaLx2Yb3EW6rd5VTPa
	H2AYwpBpFGvCdwqlVaxILTjyIOFrQ/xXynyl8gOeBmAeCrlzQdRi3sAo
X-Gm-Gg: ATEYQzwAHSpCQY9Giq3tSpgs53UPAmDNkfKFrEZ7Gfx5+FZu0W2mgF5dh5jAMGLMn7T
	d4ygtb3t3duILYeg6YdONMJvo6KZJ9JWNzJd4Y0WgBrr4jwC2q+AdlhKKm3sCYrEt09zPOdbsSM
	WrqgHYcOlNFnpQKNXQaAtgAw3sPgC4rODULN8DdlH2ceYtUepFE3Wg1jlPByzvJbkEO10Ft2cKC
	sAb5SfEm1D064rjJCps1XC4ga3PN1DmULvDgmLr+lj7OpoJfHdlGkNTpHcbQt5SeUaLlQFo5CGB
	6uYXYJC/jwx1PEc4WsnfE2HMUN3Gw8WI11nbLL7LTnFantPuu4sLVQqhFS5NqC2QVMKADBiqBWt
	ORqDrGwfQQZxtzrfXTWFqjdaYagPwDOWaPdbt41Ce2tdsvPEqhkehWKEh3MOJQPlOh685uA0OFq
	s2wlQhX7rlzkkSLqVGHztEZeEhwMz1OJTTp1cENGVkcBjmEnxpvUzaiA==
X-Received: by 2002:a05:6a21:4846:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3986ea82cb2mr3394774637.19.1772940014806;
        Sat, 07 Mar 2026 19:20:14 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657a10sm5422904b3a.21.2026.03.07.19.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 19:20:14 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] IB/hfi1: kzalloc to kzalloc_flex
Date: Sat,  7 Mar 2026 19:19:56 -0800
Message-ID: <20260308031957.90900-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine kzalloc and kcalloc with a flexible array member. Avoids having
to free separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +---------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 5b01070ed66f..2597d311fb1f 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -257,7 +257,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (tinfo->length == 0)
 		return -EINVAL;
 
-	tidbuf = kzalloc(sizeof(*tidbuf), GFP_KERNEL);
+	tidbuf = kzalloc_flex(*tidbuf, psets, uctxt->expected_count);
 	if (!tidbuf)
 		return -ENOMEM;
 
@@ -265,12 +265,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	tidbuf->vaddr = tinfo->vaddr;
 	tidbuf->length = tinfo->length;
 	tidbuf->npages = num_user_pages(tidbuf->vaddr, tidbuf->length);
-	tidbuf->psets = kcalloc(uctxt->expected_count, sizeof(*tidbuf->psets),
-				GFP_KERNEL);
-	if (!tidbuf->psets) {
-		ret = -ENOMEM;
-		goto fail_release_mem;
-	}
 
 	if (fd->use_mn) {
 		ret = mmu_interval_notifier_insert(
@@ -448,7 +442,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (fd->use_mn)
 		mmu_interval_notifier_remove(&tidbuf->notifier);
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return 0;
@@ -471,7 +464,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		unpin_rcv_pages(fd, tidbuf, NULL, 0, pinned, false);
 fail_release_mem:
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 055726f7c139..b4a309a051f9 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -22,8 +22,8 @@ struct tid_user_buf {
 	unsigned long length;
 	unsigned int npages;
 	struct page **pages;
-	struct tid_pageset *psets;
 	unsigned int n_psets;
+	struct tid_pageset psets[];
 };
 
 struct tid_rb_node {
-- 
2.53.0

