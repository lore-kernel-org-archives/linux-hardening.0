Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A913451D9
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093036; cv=none; b=WdNLhZ0yxkK4biGFkwuc6VWQ07JsJfN39qyxjyrbGCCXYYgq3/gL9tEmmvtW9Ctxyw068d04EXNUCzyOZp0a2Fk6f8z7dRWaPxx9ijugPSVFqr+cYKaerBKXfgoUHnS6jTMlYFVWEHojYJlmg6qjqjsn/g74do+MlZ9JtR73ogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093036; c=relaxed/simple;
	bh=KJyXEet6xJj0/0csTgzMps3eqDK9IIlz5TUeb4D4J4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/dUEUbEAUJlrH7LEyefeezICEfSmnUKcYB05hGH/+UvQtrmrJ54TB8zfoPZiV94RmbH/ng4u4GDbDxEP26klJvS7B+7631Y8PXEiyT5Oy3BcyaPBbK95yFpwjy7E5+8zaFU3ajq6ZwBF8JhLQaiXGrIjrHkkxqY2ic9J9fXoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUjyMEC3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUjyMEC3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9516a653so50081415ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093035; x=1773697835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTY4i7aeXKfbHquJ+rcm7OzJCRSbjkbZD8dGXcOQFQ8=;
        b=iUjyMEC32z4kNFjtq7nZeu7aDX/wnMpJ3/TUj4/dxpFlcoBtaDxom4/UIy8dSU3zzk
         Aov3oGsGBL4kMUBqa99GjsOE7j0VqVYLZiYQGchEyI66t+6gmBP4utUj1me+p7oq5oQj
         yHaE5yEcmjr1zMEeJG1v20byDWxmMht4LUxVnDTVPVcBWNdBfPyNU3r3EU/71INJ+MCG
         KdYb5F/RgIGFrG8tdBXxdBkICS5OXF2xC8ZEAhb+2AqGXb61qhaTYLan4tnEznhFQE3Q
         oW7QXyWbodoM35IuRIEaqNpb1OMzbZwoidFX6Rpok9AjppJYa2B9VYOyaHE+s/bsvLgL
         R5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093035; x=1773697835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTY4i7aeXKfbHquJ+rcm7OzJCRSbjkbZD8dGXcOQFQ8=;
        b=gJLykzCX4mM5yXb/VbrLN+ufFfu8ep8WRYpHb19/aMZ31B45xEScClwGxn0zebUB+C
         efMJfNNQm+DUjUhpj/iJfTw2Frc1LRo9e7IVJy6W0e5iM6TD97BPPGyRbra+xCNj9gsT
         0y643pToIONKT7CJdW6z+il3y1FE5WwF3hoQceVvr/GrpSqJ+soK32CR+CAPUnVh0tcj
         oOjrsxNLYLRpN6TZg2EqNNZ62KBLGlait77laLV8GCe5jg0/gycF5KhKURxGFyynlpC8
         Gpq3eDA5s/UQUnlHKyuItqtKF6AFmyV6aAyFmv8LQ2dtzzPm/We9r3HD9xLDZFThzKI/
         Vosg==
X-Forwarded-Encrypted: i=1; AJvYcCVml1ti6t1FJZ31Re8NDZE85iNw6/oWVlmXlyeTNOCgdV15CTJY4s+Zv3vrUU+0QFWwzHTFp0IRmEX92y/RvDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXa+YIjwtl+QCeAHQnNjbaD/zOu/x2K2bYNiPoYa8QHt35cXq
	ZdSfgKRsS7nr6ofBvhZuPn7lx7sM5kKqc4ckj+C5QGyUOUzpOMtweEc5
X-Gm-Gg: ATEYQzxez7fLg1Kc17TU5xmHp/8iMEEY96kzYirtZFv7py3LRalkp4C0+SO7AkcrG2t
	Sbq31NGLxJhh0Id9TFBPK9H5FXn+TuPAFgTmns1gGC3i4UPe5GmUAih69Dd9Zftaf6NDSG/jx50
	FhzthuodgUMCQt/aVbtBD44tcOB2owVuHwx4Fb/XzRq7odhhIN+/FhKOJMXsY687LhSBXL5goUD
	dhgkUCRuvAdxkxLjz1Y5g8LyKOeiphA2Uto6gELq/chm/bldUPciXlsCKV8v/Jq6i6hdG7Dqq4z
	987B+Vv+s9EwBe77e6/4aEZbBwvg7JeLTW+WddRtkP4wMvUoU+uSIWvsaH6sxnF0L1z89UQqtpr
	G1VBq/xOeuoShDNRsY+nbG0J+mmTjpj5u+Q9dtBV2ufgd2tJWY7qhaZJjP3TAWqb8AqnfMaYO0P
	yAYujBVKsEszJ/0xpm5MdWctVa/zqLBZ7tAh/dd9HEKeXI8q5tf5IvHD4U6XwfZpPE
X-Received: by 2002:a17:902:cec6:b0:2ae:5345:89ef with SMTP id d9443c01a7336-2ae82432e95mr135453295ad.26.1773093034825;
        Mon, 09 Mar 2026 14:50:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad74asm171963095ad.78.2026.03.09.14.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:50:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] IB/hfi1: kzalloc to kzalloc_flex
Date: Mon,  9 Mar 2026 14:50:17 -0700
Message-ID: <20260309215017.4753-1-rosenp@gmail.com>
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
 v2: rebase
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 9 +--------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index a916fe0118b1..8b50a2ad792c 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -257,7 +257,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (tinfo->length == 0)
 		return -EINVAL;

-	tidbuf = kzalloc_obj(*tidbuf);
+	tidbuf = kzalloc_flex(*tidbuf, psets, uctxt->expected_count);
 	if (!tidbuf)
 		return -ENOMEM;

@@ -265,11 +265,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	tidbuf->vaddr = tinfo->vaddr;
 	tidbuf->length = tinfo->length;
 	tidbuf->npages = num_user_pages(tidbuf->vaddr, tidbuf->length);
-	tidbuf->psets = kzalloc_objs(*tidbuf->psets, uctxt->expected_count);
-	if (!tidbuf->psets) {
-		ret = -ENOMEM;
-		goto fail_release_mem;
-	}

 	if (fd->use_mn) {
 		ret = mmu_interval_notifier_insert(
@@ -447,7 +442,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (fd->use_mn)
 		mmu_interval_notifier_remove(&tidbuf->notifier);
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return 0;
@@ -470,7 +464,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
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

