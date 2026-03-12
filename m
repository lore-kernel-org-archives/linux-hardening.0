Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A78381AF3
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291581; cv=none; b=Mfq5occOHI+08SkqRxIrCEpQv1uQMm46rlo+opiYja1C6uKTj2hyK8QSJL0m5TcmiaXAys5QzgvS7amMrCulhQXdmhXNkf/FJNK8FzXpRy0uEXd50X3M+4Lk/WgQO1J9Eg16AJOxLm3662OnQlJ1J+/eP6gW0v9oH58Oxc7+HvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291581; c=relaxed/simple;
	bh=70BeD1knxFPBhbOveZaJ78TQk69t5SY8pDh27xzK/l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+n7/OEjE+kpiCangLGBDRIdVOaqBqfX0w1x0nsXcewmEcrDnh3sYqj+eMRFUPMJ108Z35kGhhtmrIzxTpzubd7fod6pJL/URKGYre+uWNUbdNiR0SxGKQjGOoLTzqyypPzSXPRCyJmzfqUgQrzrL3U4sTrvb6s+PsBS2iwfn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+/HuwE1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+/HuwE1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9516a653so3056795ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 21:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773291579; x=1773896379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjiMf+HrHgumtDrytCb9PW5t02HTgkYKwwniQ8SZW0c=;
        b=j+/HuwE1M0YhY0t0xFVPNRINMa8yttMhjc7bxlbmfqCpLrUQB4H040lSzT/13alyRy
         6yvjNsv9LFzHDhPaS9M90ILR0gTZH0aHYkaX0fobzKcViqHHp4e7S4lzjAjVXJLMWxDw
         TantOQrphn0ADdBQps61nNMI4q89HnqPM82gIniyNxJ1x4a6545X0lHazNjsMeIa66iB
         7ZkLB29JXwWDe4CupLPnaT08KXZYtMltovVUiejLWKkaZAwuT6iXqrO4G7SCnOwxZvOn
         2VAp1bFlCGvZmfyVCBgx603IBOslw1sDbFgimSN8ThZSX5FgXHBEgS+P47IZ1YrIwaBN
         eaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291579; x=1773896379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjiMf+HrHgumtDrytCb9PW5t02HTgkYKwwniQ8SZW0c=;
        b=Mnkz2en3c6rsd5VZYStEYR8QCz4H6/Icbcib4kyNP7dopByneHSS1MEIompmhVLuB/
         InrFEMSR2SJOuf/EAT7K/2G8TCjGDOOs2ylLm7Hlq/IX4qxUR/ZsUM3I4kTMWhQLgLP0
         D6lP78QAtjZo/BpDigVzG4Mmu8v/zlKkNrGP3ZMmf4YMGqMivbddogDR3T0lsQ21AxqP
         Z5jF/g/qM3Ar3MS0/GG16KE3erfkl531mIq4EwiczJM9PQVCo4+Nzs2Wlj6pEKyGp7Ta
         wjLGj6IHJ5IMDWjRuusEEKy+U85LGMhYs4cL/cOjKID3RoRALUKoG1nDq/ekBynW4xYI
         RYnw==
X-Forwarded-Encrypted: i=1; AJvYcCXZvw7WUcNOGCipx+acI7him/Sn7N9QZJAGc7Plxl5KMZvYy2uk/5hkS4lkyMYo8lox3h27f/qPTnelkt/p1kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8cF6CqQdSW1lEl6WOw42P2Ignr08z+rGoarxbo5dHODGJhgR
	nzVGqJeXQAm8ZeLr5H/cWUy9Vy5dl6yEL3HY6q8iUG/+8p1mypxDHxWp
X-Gm-Gg: ATEYQzzEmPb4ntTVBhzqHc8jbi3HcKzMcb8N3F8LZqHJ+5M7p9p1UesRxnueBrM2CUy
	Baj3g+VVfyTvucwEnKneJBeCKAWJ834gsgZcQ11fwPAgYMw4IqkMBO2B5yvXoTdoit7wvyZhHnG
	FzJPjhhc0RVznDAoFEjE5ZtAzPEQsPnfWiKjWw2tLQyWHya49Z5nAgS+M8alR67puN79j2DioLK
	A7IOknJAEj/AMqHRoYWtX6m9XGYoI2GZWFiOaZ9dJUF2Puf1rIB5e6aii/GKJ50bsRxH4eZFRMD
	vUnWDhaazjQmpE3aEVf4gE8mQn4N9UDiYon1qpTnE6Bm7E1rWS4el6Z2h1oQjJxNddYet9M0L+0
	VlM0ffxczmrBhpN4koUVInwqe3/XlpS8tR/hGENstNtdp02eBy0eiuMAscJxADvooQaWiT7ecQ9
	j5e15My8DuHRf9L/0WTm8shlhT5BuyjVp8wcSOpuMGdN0qJ7OQwzvBCQ==
X-Received: by 2002:a17:902:ea11:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2aeb991a868mr25734465ad.42.1773291579268;
        Wed, 11 Mar 2026 21:59:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae255a05sm55804755ad.36.2026.03.11.21.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:59:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: mhi@lists.linux.dev
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:MHI BUS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] bus: mhi: use kzalloc_flex
Date: Wed, 11 Mar 2026 21:59:21 -0700
Message-ID: <20260312045921.7663-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change kzalloc + kcalloc to just kzalloc with a flexible array member.

Add __counted_by for extra runtime analysis when requested.

Move counting assignment immediately after allocation as required by
__counted_by.

Move mhi_buf definition as a complete definition is needed for flex
arrays. It's not a pointer anymore.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/bus/mhi/host/boot.c | 20 +++-----------------
 include/linux/mhi.h         | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index f16a1e67a667..e1d77cecd75e 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -333,15 +333,10 @@ static int mhi_alloc_bhi_buffer(struct mhi_controller *mhi_cntrl,
 	struct image_info *img_info;
 	struct mhi_buf *mhi_buf;
 
-	img_info = kzalloc_obj(*img_info);
+	img_info = kzalloc_flex(*img_info, mhi_buf, 1);
 	if (!img_info)
 		return -ENOMEM;
 
-	/* Allocate memory for entry */
-	img_info->mhi_buf = kzalloc_obj(*img_info->mhi_buf);
-	if (!img_info->mhi_buf)
-		goto error_alloc_mhi_buf;
-
 	/* Allocate and populate vector table */
 	mhi_buf = img_info->mhi_buf;
 
@@ -358,8 +353,6 @@ static int mhi_alloc_bhi_buffer(struct mhi_controller *mhi_cntrl,
 	return 0;
 
 error_alloc_segment:
-	kfree(mhi_buf);
-error_alloc_mhi_buf:
 	kfree(img_info);
 
 	return -ENOMEM;
@@ -375,14 +368,11 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 	struct image_info *img_info;
 	struct mhi_buf *mhi_buf;
 
-	img_info = kzalloc_obj(*img_info);
+	img_info = kzalloc_flex(*img_info, mhi_buf, segments);
 	if (!img_info)
 		return -ENOMEM;
 
-	/* Allocate memory for entries */
-	img_info->mhi_buf = kzalloc_objs(*img_info->mhi_buf, segments);
-	if (!img_info->mhi_buf)
-		goto error_alloc_mhi_buf;
+	img_info->entries = segments;
 
 	/* Allocate and populate vector table */
 	mhi_buf = img_info->mhi_buf;
@@ -402,7 +392,6 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 	}
 
 	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
-	img_info->entries = segments;
 	*image_info = img_info;
 
 	return 0;
@@ -411,9 +400,6 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
 		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
 				  mhi_buf->buf, mhi_buf->dma_addr);
-	kfree(img_info->mhi_buf);
-
-error_alloc_mhi_buf:
 	kfree(img_info);
 
 	return -ENOMEM;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 88ccb3e14f48..fb3ba639f4f8 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -85,17 +85,33 @@ enum mhi_ch_type {
 	MHI_CH_TYPE_INBOUND_COALESCED = 3,
 };
 
+/**
+ * struct mhi_buf - MHI Buffer description
+ * @buf: Virtual address of the buffer
+ * @name: Buffer label. For offload channel, configurations name must be:
+ *        ECA - Event context array data
+ *        CCA - Channel context array data
+ * @dma_addr: IOMMU address of the buffer
+ * @len: # of bytes
+ */
+struct mhi_buf {
+	void *buf;
+	const char *name;
+	dma_addr_t dma_addr;
+	size_t len;
+};
+
 /**
  * struct image_info - Firmware and RDDM table
  * @mhi_buf: Buffer for firmware and RDDM table
  * @entries: # of entries in table
  */
 struct image_info {
-	struct mhi_buf *mhi_buf;
 	/* private: from internal.h */
 	struct bhi_vec_entry *bhi_vec;
 	/* public: */
 	u32 entries;
+	struct mhi_buf mhi_buf[] __counted_by(entries);
 };
 
 /**
@@ -488,22 +504,6 @@ struct mhi_result {
 	int transaction_status;
 };
 
-/**
- * struct mhi_buf - MHI Buffer description
- * @buf: Virtual address of the buffer
- * @name: Buffer label. For offload channel, configurations name must be:
- *        ECA - Event context array data
- *        CCA - Channel context array data
- * @dma_addr: IOMMU address of the buffer
- * @len: # of bytes
- */
-struct mhi_buf {
-	void *buf;
-	const char *name;
-	dma_addr_t dma_addr;
-	size_t len;
-};
-
 /**
  * struct mhi_driver - Structure representing a MHI client driver
  * @probe: CB function for client driver probe function
-- 
2.53.0

