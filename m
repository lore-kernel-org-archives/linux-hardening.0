Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1536C9FB
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190078; cv=none; b=Dt9BaZsfN4nfHgLrU9FDnbyM7je9WfbugLBQ456j5WDZKBDUbEVMV8clrxqBGdAbVmzEvm7wwszlt1esEhdYAQ0uOKenMs5I6oCiU998pRp8sms6P1mDZktVzrSiYDSNNHho7iFmpB+abBKYFp//5JZCM+/mGlgIbLK8RupKJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190078; c=relaxed/simple;
	bh=GWfHWHTWEkbHmL8A2Gp09obkBBjV5/TvZpLBOriax/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7altDOYGxAqhc4Tcu9dwP+UWZr6oQjAdeert+evqVU7NDTP28us9GCPJuGGsFVWXCv3hu9I3Y5Yvice08ABdnclWq/r4NxqSZqPtjpLpFp7yZxWizQ8zVEG31qyAvUJ2LTRG8Gbj1g5swbaWy1T4YgvQPBqT56HE5SaIGKOPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkOlvtzz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkOlvtzz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3597b474cbdso6045128a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773190075; x=1773794875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O664dCsdWRRkRc+ofehgmpux+USEDU3vAot0X1wBxCI=;
        b=MkOlvtzzcoTpwf+ItKIB/2Y058rm/pZhOR2QTeeIt69Xesn97FOj66T3+NYKFZITJ7
         XLo05pYknDTr/WWj2r6ceuJs9YS385+HUaM8+mruWgroVkRtwK0wzk8uw+hv3pK7akMp
         Z7IIO6PXHEggl5u2mqprFEk8dtAyegMqrw8pkAReIHupTB1+kQ/PFdfIq49iyBrDyiyv
         dYlvftUxyhS/B1te8Bjqf5WEJ7pJrD8NLYXARidapcx65Wca1pE/XMapbXQaWdRHVo/E
         Hofh4KGWQyTxQWn9liRC65fGFkhh5+SBlASCF3jcEHqlm+WT0EyKs3bWkFQWu4Sm9iCV
         CeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773190075; x=1773794875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O664dCsdWRRkRc+ofehgmpux+USEDU3vAot0X1wBxCI=;
        b=i/JUSggZdQtwj/cI0DBthrBCAR0rT4AWxhaC22P7jAu/2T+aqGUG8drvYo+5Limkat
         Z4uZ6P8cHS0dnxABzi0r5ztdcDN1ehaoF8wRG/sR/ThAHdyudNJSxiPol13MFEgoMDrB
         sSmb/5c/KlOgQsWpSCzlrEXqEnol2oqcnxE2MBTFYaB7j4TGMiCw6bisMt24ZYKzpbrW
         zQs2lMzAwGjxM8oNCVHTYE8uGR2AtBKxFG7w4BK++s7ARrUUQYUlWj/kX1uuNQ8PccK3
         SG/0C8TG2Nr799ipq/a8wMJNVtgYo0JAfGUQ3v20m24oxeXBrkYrnJR4GkgVevmuIHcH
         w6tw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVR2xcjeTz5YoWIH/oSESD+foMpjs7sXFis9XL5HjmAb4NHtoAQjM/fOsGpBr5CGZzGkt1NCMlUuFRWxittA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyikIX9s/3lSTkr8SHzBFvafqAyAVpRdN+AWJiWOm6R6UU8tCtO
	tQl+5TA47cYbUVCA/PRWa2S9mfcXeywo5wRrBVaS7MeFbzm1sFwPWSxP
X-Gm-Gg: ATEYQzwMkUElOTg42YeEmGm6i4tWn6EAS7tor3iutgN8kSYZNvrQ7QeoBTu+WP5Gp2k
	QPQ6P6awV8TquTIYM9xR8Xw27jbIrv0pMsU0mLQ3zJYsQyFOYZQ/gQqtubdL5xCw3/RAppBwM2P
	pH5zi9vRHul1dE8RHpYtv5JID2Lg5ITRMiuggdoAZgEm3qmfB/0TFhhJamZbGtzcIx+udQNG52A
	7lPpe17dVRb7rdYgeQgRvYbljM/ZbqnUuqyXIOFqlkajh04KGZTO8fE1XuVznIQiTUU9lNvvb+0
	RfEkOqtwYyaT/26hVQw0/fFM6O/JCBHsECdcABWeXYj71gtxN5O6ldXrWBP0cL3nP/oQFw7J/da
	RSbPopzAhbYs+cMgLZD35XluZo4wCJfDUC2lzXpDHljBGHCXEo78Zz8xCIO0s91ZzYGbCNFb3PY
	3T7W1PM9B7DUY2fpdEI25/0bie0S8u32pRP4z0jPk4S8bB14RfQskjFA==
X-Received: by 2002:a17:90b:3dcd:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-35a019e88camr707120a91.33.1773190074956;
        Tue, 10 Mar 2026 17:47:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cde37ffesm373842a12.0.2026.03.10.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:47:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b43-dev@lists.infradead.org (open list:B43 WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] wifi: b43: kzalloc + kcalloc to kzalloc_flex
Date: Tue, 10 Mar 2026 17:47:36 -0700
Message-ID: <20260311004736.32730-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation and allows using __counted_by for extra runtime
analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/broadcom/b43/dma.c | 18 ++++++++----------
 drivers/net/wireless/broadcom/b43/dma.h |  4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 3a8df7a18042..05da6987a845 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -837,18 +837,19 @@ struct b43_dmaring *b43_setup_dmaring(struct b43_wldev *dev,
 	struct b43_dmaring *ring;
 	int i, err;
 	dma_addr_t dma_test;
+	size_t nr_slots;
 
-	ring = kzalloc_obj(*ring);
+	if (for_tx)
+		nr_slots = B43_TXRING_SLOTS;
+	else
+		nr_slots = B43_RXRING_SLOTS;
+
+	ring = kzalloc_flex(*ring, meta, nr_slots);
 	if (!ring)
 		goto out;
 
-	ring->nr_slots = B43_RXRING_SLOTS;
-	if (for_tx)
-		ring->nr_slots = B43_TXRING_SLOTS;
+	ring->nr_slots = nr_slots;
 
-	ring->meta = kzalloc_objs(struct b43_dmadesc_meta, ring->nr_slots);
-	if (!ring->meta)
-		goto err_kfree_ring;
 	for (i = 0; i < ring->nr_slots; i++)
 		ring->meta->skb = B43_DMA_PTR_POISON;
 
@@ -943,8 +944,6 @@ struct b43_dmaring *b43_setup_dmaring(struct b43_wldev *dev,
       err_kfree_txhdr_cache:
 	kfree(ring->txhdr_cache);
       err_kfree_meta:
-	kfree(ring->meta);
-      err_kfree_ring:
 	kfree(ring);
 	ring = NULL;
 	goto out;
@@ -1004,7 +1003,6 @@ static void b43_destroy_dmaring(struct b43_dmaring *ring,
 	free_ringmemory(ring);
 
 	kfree(ring->txhdr_cache);
-	kfree(ring->meta);
 	kfree(ring);
 }
 
diff --git a/drivers/net/wireless/broadcom/b43/dma.h b/drivers/net/wireless/broadcom/b43/dma.h
index c2a357219d4b..f9f65bbe2d76 100644
--- a/drivers/net/wireless/broadcom/b43/dma.h
+++ b/drivers/net/wireless/broadcom/b43/dma.h
@@ -228,8 +228,6 @@ struct b43_dmaring {
 	const struct b43_dma_ops *ops;
 	/* Kernel virtual base address of the ring memory. */
 	void *descbase;
-	/* Meta data about all descriptors. */
-	struct b43_dmadesc_meta *meta;
 	/* Cache of TX headers for each TX frame.
 	 * This is to avoid an allocation on each TX.
 	 * This is NULL for an RX ring.
@@ -273,6 +271,8 @@ struct b43_dmaring {
 	/* Statistics: Total number of TX plus all retries. */
 	u64 nr_total_packet_tries;
 #endif /* CONFIG_B43_DEBUG */
+	/* Meta data about all descriptors. */
+	struct b43_dmadesc_meta meta[] __counted_by(nr_slots);
 };
 
 static inline u32 b43_dma_read(struct b43_dmaring *ring, u16 offset)
-- 
2.53.0

