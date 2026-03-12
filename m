Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269F3264CE
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274554; cv=none; b=hrxyaO9MeclvggySeDXMvk6/p5YzLVZGAZ+RfBNGLZGwl2nQesWh5k8jDt5H3Zot3iG2QRvKU9Kt7C3ck0OqILFQ9aASfMhoc5UI/Hiw43yuE8qoeo1axecUzGf9Gm9T0bULY8aQ28xjmpgt/0uOk1fPcMLAwBYMhvIgkNO7bWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274554; c=relaxed/simple;
	bh=aS21IJ8qFhMA4MNbuWKf3Rlhm6IDphI/HT8NaSo4I3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ByIrp0X8RICJ3mIzGhLC6nnt4c1THo44T8xSvOR+YXEMi32SaOiM1tOflT+3c+8qLLEnTXIef/SqZi8sJ2OEhotdaZwkKqzuPTGRS+0GEah8sy/lYwWJmay5ES0QMPnLonMj23F4N8D0zA21l7OL+X/MoO900HUyHvNr4SPrSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMgPmTj0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMgPmTj0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73d251b93bso204681a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 17:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773274552; x=1773879352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kLAJsER4lp2HD3vq6mJxj6QgJh+XYZbatqBm7oKRCo=;
        b=eMgPmTj0lo7CwlgdZYkQVS7AeqkF47nuhVw70WIUavJzE19SN8zUF8U/I47Dyw9ZGZ
         b02LoyBfPAO+LaHrOjD6ZZ/z1NjGBLMSNkm8570c2Iv3/1YOr89RHNp2CeD0PPpLCYG/
         idLN5FcyPDIg0lsrk0DGb7KEnsIi5/P3vCsA7Uz8PqKCVC60pmme3iGJ4MbSOT4XspVg
         6Mw7L1yvKPGv+NaO+s5OqZKA2XM9qH5TADTsOyvRuXyBT1LeYuf7hlIISzhLR9fm0REL
         17Ju/2eIdpmxXrGiZhaCT+M6zuJ4ROyoWbmqkg/OnHBkCRGM/Sh681CaRXtC7RvQkMrF
         2OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274552; x=1773879352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kLAJsER4lp2HD3vq6mJxj6QgJh+XYZbatqBm7oKRCo=;
        b=CQFedxM7/4eX/hsbTXowTEAtD+WIoc1/Ln6hauyMYhlAtrkDK5ayb47PESknZgXdVJ
         ECG44lKwhkmTUQw66GuL0OYV9LJPwf6JOI7GCOa6Tr1sGeVU793kMCEuFhzL6bybIZv3
         a8amxrE3Tu9BUBeMs2UlC51QMrkTgSPDdpAAwrqCY2baPP0GtQlWpKWhG2kno5eC29Z9
         /A5ivxUDAUwYUwnR0BG7Or3KrV6+Ueedbv03uutxmO7JApgd8ULYalwKXmGoR86YX/LH
         +ZKWDgJ5vbKaOrx1Izr0BshotI8pquv8eY7zh2aWMwAIhGGNLMdnB/PRb/Bl9uC52gRl
         LLEg==
X-Forwarded-Encrypted: i=1; AJvYcCWaV5F5MGGLCjvw4C4yLdyddwtI1/G+z7C16jZyiTIr5gMQQ00Oz2OTJk/TBlPXkNo7eRBYmjzIRAB4+nM+mCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCSNk9gvrxrYdl0CCFEO6FrFW+rk/OkzyJoF8bTPgxNBD0qSw
	nI3SXBdjrZzuNk6DomF1nbdIPgmmL73RVpE7TdV/3cwTjxHxmGKMkcBxMCqejtGi
X-Gm-Gg: ATEYQzyyuMvK/UpKpQXFmGjELXcgcrcZ2tDC7LJe2fTgWV94Ypom0OkvlvmSAGEMIum
	9UFfXjEXHJRkiYImp7K0Pdpv5f9c+xwy7GaGKyagY4QiF+K8TfEWCdsJ0wIHQriKHvBm2+Z6Hgc
	lpg9/+SNpnie9Pk0JeaRygkaGsCcvTbN0/c9mP4ZgnwO1pxzkzJhStZok3zFodrXOu/oVqQ1uuZ
	75QsY9jA/uyHLUOmaMB2CVYB62L3INJVtVK4+sQi11V+QHRUXnAyAjGcxxstdueZ2tyRPHyGDqY
	n3+nq4l8MrBRviKwTWvxsw0OgENIYyJdahMExkK/jC+N5cIVYhoaMpWHB/+Y73SfnsDwfJdt1dn
	wQqt+ucEcjOblTn61UpbfCrgQOFTpV9ZLXIsHD2yIFN+tTh8n9DYxLlFis4BRTOZ33KENnA5Rbd
	+zM0CaRBnXdYl6+AxTyUDbKhHqyV6yPNB/gMeEtr8ijH2yVfc4hXbwdA==
X-Received: by 2002:a05:6a21:6f89:b0:398:ab2c:a5bd with SMTP id adf61e73a8af0-398d7875fd1mr1213671637.21.1773274552521;
        Wed, 11 Mar 2026 17:15:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072449fesm891746b3a.13.2026.03.11.17.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:15:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i3c@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] i3c: master: use kzalloc_flex
Date: Wed, 11 Mar 2026 17:15:34 -0700
Message-ID: <20260312001534.24423-1-rosenp@gmail.com>
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
 drivers/i3c/master.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 9e6be49bebb2..b62cb3ee69c1 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2793,10 +2793,10 @@ struct i3c_generic_ibi_slot {
 struct i3c_generic_ibi_pool {
 	spinlock_t lock;
 	unsigned int num_slots;
-	struct i3c_generic_ibi_slot *slots;
 	void *payload_buf;
 	struct list_head free_slots;
 	struct list_head pending;
+	struct i3c_generic_ibi_slot slots[] __counted_by(num_slots);
 };
 
 /**
@@ -2824,7 +2824,6 @@ void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool)
 	WARN_ON(nslots != pool->num_slots);
 
 	kfree(pool->payload_buf);
-	kfree(pool->slots);
 	kfree(pool);
 }
 EXPORT_SYMBOL_GPL(i3c_generic_ibi_free_pool);
@@ -2847,20 +2846,16 @@ i3c_generic_ibi_alloc_pool(struct i3c_dev_desc *dev,
 	unsigned int i;
 	int ret;
 
-	pool = kzalloc_obj(*pool);
+	pool = kzalloc_flex(*pool, slots, req->num_slots);
 	if (!pool)
 		return ERR_PTR(-ENOMEM);
 
+	pool->num_slots = req->num_slots;
+
 	spin_lock_init(&pool->lock);
 	INIT_LIST_HEAD(&pool->free_slots);
 	INIT_LIST_HEAD(&pool->pending);
 
-	pool->slots = kzalloc_objs(*slot, req->num_slots);
-	if (!pool->slots) {
-		ret = -ENOMEM;
-		goto err_free_pool;
-	}
-
 	if (req->max_payload_len) {
 		pool->payload_buf = kcalloc(req->num_slots,
 					    req->max_payload_len, GFP_KERNEL);
@@ -2879,7 +2874,6 @@ i3c_generic_ibi_alloc_pool(struct i3c_dev_desc *dev,
 					  (i * req->max_payload_len);
 
 		list_add_tail(&slot->node, &pool->free_slots);
-		pool->num_slots++;
 	}
 
 	return pool;
-- 
2.53.0

