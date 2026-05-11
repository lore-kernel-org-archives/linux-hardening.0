Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E17231842
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473194; cv=none; b=HzU7IC2qLiCC6WQrjZoz18FRyOZwlZ1f68F/PiAXlksuQ73nB6TkovRDZl2C7cxMdxq4Ilz4+gRCWzt8hM28ZLiimJn5wSYJ1fqgApLxasH3o8wlVyV3DlPBrshYvEzMMUqjd7pF9zsGfEzvm+SuT0CuJR+YKnN2fOhHlodFSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473194; c=relaxed/simple;
	bh=l9r0k9O845xmFH49LN0SvAE9g5m1PdtjkXkKvP0Tdwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rj5XOzgDdvHD1mNHkk5SPklcIvLavtDGSmuKX9VuvDEa5vJ78S4SaQFMQnIYZ3yAToqy01/lZPQqs3NFgBlY5fRGjYzPSPxZoZTg86UrFBDm+CGoxaHgono5QdzxldKCD/qOCEoEvzHlxnuFO2Mta1cnT2ZN/+N8li2J8+kFAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq6pa+pM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq6pa+pM"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso1588420a12.3
        for <linux-hardening@vger.kernel.org>; Sun, 10 May 2026 21:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473192; x=1779077992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuGDf9iNAynlSPvBXud+v9E3yiQ53OcQ/UBsB/xF9OA=;
        b=Bq6pa+pMaeQ6MDDQkvze95i95EGTsiP1FgnEWMej1kItue/bfaDEUpGc4+pgho/TJZ
         tIaoDcyXUiLccLncam/3JFKkZLduyqZP6Cd1EQidcHa8XV1I25VWOW+z5h8cLwVTVA3p
         5wqw9lwm4X6FcwOze0ybtdu+W4U7wuG9sheFdHxIpvask/0nzin7N6zrNZUjrbidTGel
         Auri7mvp87Vm7dDUA4y7jUi1lpdN4sg2P79hI2pU/AGspQh6oFKCHNa7kdTVLmz8lGaH
         0Vm2Js5d0ZVCDzSOBsEs+aLjM0X369HN1LZ3bj/Jq0TIS8m3CNAc+j9suMg7v+1Y+JdK
         GEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473192; x=1779077992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuGDf9iNAynlSPvBXud+v9E3yiQ53OcQ/UBsB/xF9OA=;
        b=Evah49QeX8RpdUIGxtGf2Xgyge+w7esJ8rV8T3LLRkBPXRYMrm0H8j/+3AnMbYyUqX
         78VgT1WKCsJbMki3cf0ADoYolAiV659lT+CPv6ZXPemwgsTN520GPIJV8gOZTMUJ63pR
         7g74CQms4lYpS0UKibE32hQ4LuLmHiqzrgNg4fWHV2v7xlwQppFealD3QEyP3UYIoF/R
         cD7kQ1O2V8byqnwVhPvEYfBvBqeH71ePVGP+BoCVM30xmi0XjPdfbuHiqd8ZK1+xZW9q
         3rkaNdPjlcV3fzpncnbEgZsqpJ5vXfZhNNhXtwe0/DByuD3PFd/IAbiprahltS9jNEDu
         MIVw==
X-Forwarded-Encrypted: i=1; AFNElJ9g8Yg4T4nVoBCirazjdunLvPQrEJb19BQ2svQ2KhURpRbYXrHJ4Xrs2Ap4yJ2vydelfXtD8WVi8gEQt6bGsYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLn+Ntus/cXGaMJsg3DVvGuZxIN0UuXAst47QBhMSwnr+9+q2
	/AS3w/8PMhESkeomVreSz9u6Bp0GuXp9xycgqRQKHNk3FfdZkBX7ck80
X-Gm-Gg: Acq92OFa6CnG8oIDk4MaZbgNXwBOZEwWF+APaa49Za4nUObDNXPUiLtlBK+lFrQ8xfq
	YbV+AESTCr6VIDf/GjnGwZgw/RLn8NQafTQqTpyVGyFnmrl1XmYmQsRL3EXq3PpLp05gv7qQ7kt
	D+L7si3mbQ1bVAlZNGB0oOrx5wZ48EKt5uewdoELEh9TZK1BrkUEPTfmTGBNw/QqG704wLLrCsM
	r+3Z9ovesBSJLma754TzbYm4n4Ps7Y0SbjvvDzVjvTol8MVmzUav4svpmm2FmU3Id4Fht3h1q8p
	IdE5HF7oB5C+UYiz7dbPC7586x3oYoOmuvskNLswP+8ZOPUGJZGMv4hPFDN/2D2bprrgLFcSMmO
	o47MBC21N/bCQZD5W7GR0DDc4OJJf+OkgqLDhLs5qAH1BiDa3E52P64g1fBo5OASTUxg9BzhL6G
	GOg/mMqp1We0zYtwUmbrrNEH6Al2Q7GSj1Qb1F5edvT5roAnj3nic15EWS+bDQYhG4RhoXgE0Jk
	pmg5T/b6YBGJqRbxb24F7HdT86WRdDL6f5tFTlj+OjpmA==
X-Received: by 2002:a05:6a00:2e90:b0:831:7f71:c810 with SMTP id d2e1a72fcca58-83a5d96fa9dmr22809905b3a.35.1778473192058;
        Sun, 10 May 2026 21:19:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659498f1sm23736106b3a.17.2026.05.10.21.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:19:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b43-dev@lists.infradead.org (open list:B43LEGACY WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH wireless-next] wifi: b43legacy: Use flexible array for DMA metadata
Date: Sun, 10 May 2026 21:19:34 -0700
Message-ID: <20260511041934.378209-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the per-descriptor metadata in the DMA ring allocation instead of
allocating it separately.

This ties the metadata lifetime directly to the ring, removes a separate
allocation failure path, and keeps the descriptor count available for
__counted_by() bounds checking.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/broadcom/b43legacy/dma.c | 24 ++++++++-----------
 drivers/net/wireless/broadcom/b43legacy/dma.h |  4 ++--
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index a9557356c9ab..6c3d847242bb 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -610,25 +610,25 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 	int nr_slots;
 	dma_addr_t dma_test;
 
-	ring = kzalloc_obj(*ring);
+	if (for_tx)
+		nr_slots = B43legacy_TXRING_SLOTS;
+	else
+		nr_slots = B43legacy_RXRING_SLOTS;
+
+	ring = kzalloc_flex(*ring, meta, nr_slots);
 	if (!ring)
 		goto out;
+
+	ring->nr_slots = nr_slots;
 	ring->type = type;
 	ring->dev = dev;
 
-	nr_slots = B43legacy_RXRING_SLOTS;
-	if (for_tx)
-		nr_slots = B43legacy_TXRING_SLOTS;
-
-	ring->meta = kzalloc_objs(struct b43legacy_dmadesc_meta, nr_slots);
-	if (!ring->meta)
-		goto err_kfree_ring;
 	if (for_tx) {
 		ring->txhdr_cache = kcalloc(nr_slots,
 					sizeof(struct b43legacy_txhdr_fw3),
 					GFP_KERNEL);
 		if (!ring->txhdr_cache)
-			goto err_kfree_meta;
+			goto err_kfree_ring;
 
 		/* test for ability to dma to txhdr_cache */
 		dma_test = dma_map_single(dev->dev->dma_dev, ring->txhdr_cache,
@@ -643,7 +643,7 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 					sizeof(struct b43legacy_txhdr_fw3),
 					GFP_KERNEL | GFP_DMA);
 			if (!ring->txhdr_cache)
-				goto err_kfree_meta;
+				goto err_kfree_txhdr_cache;
 
 			dma_test = dma_map_single(dev->dev->dma_dev,
 					ring->txhdr_cache,
@@ -660,7 +660,6 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 				 DMA_TO_DEVICE);
 	}
 
-	ring->nr_slots = nr_slots;
 	ring->mmio_base = b43legacy_dmacontroller_base(type, controller_index);
 	ring->index = controller_index;
 	if (for_tx) {
@@ -694,8 +693,6 @@ struct b43legacy_dmaring *b43legacy_setup_dmaring(struct b43legacy_wldev *dev,
 	free_ringmemory(ring);
 err_kfree_txhdr_cache:
 	kfree(ring->txhdr_cache);
-err_kfree_meta:
-	kfree(ring->meta);
 err_kfree_ring:
 	kfree(ring);
 	ring = NULL;
@@ -720,7 +717,6 @@ static void b43legacy_destroy_dmaring(struct b43legacy_dmaring *ring)
 	free_ringmemory(ring);
 
 	kfree(ring->txhdr_cache);
-	kfree(ring->meta);
 	kfree(ring);
 }
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.h b/drivers/net/wireless/broadcom/b43legacy/dma.h
index b5c1a51db2a4..edd06225b64f 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.h
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.h
@@ -122,8 +122,6 @@ enum b43legacy_dmatype {
 struct b43legacy_dmaring {
 	/* Kernel virtual base address of the ring memory. */
 	void *descbase;
-	/* Meta data about all descriptors. */
-	struct b43legacy_dmadesc_meta *meta;
 	/* Cache of TX headers for each slot.
 	 * This is to avoid an allocation on each TX.
 	 * This is NULL for an RX ring.
@@ -161,6 +159,8 @@ struct b43legacy_dmaring {
 	/* Last time we injected a ring overflow. */
 	unsigned long last_injected_overflow;
 #endif /* CONFIG_B43LEGACY_DEBUG*/
+	/* Meta data about all descriptors. */
+	struct b43legacy_dmadesc_meta meta[] __counted_by(nr_slots);
 };
 
 
-- 
2.54.0

