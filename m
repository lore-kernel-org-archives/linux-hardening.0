Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AEAD4B
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773438352; cv=none; b=AHOLK0hzb1nmhqpv6nfDADL4qCOQVeIw8Pjb7CZGne92WU4H18TET1PXFGZb+6hIn7iCstO/UgKRZb8sSdn/LGvW18bW01d7I+O4zYkSanNBlIBLLwSWjR55kMHDcJr8MzsfNaQnrg9CRX9J5wcFYe2AjEm+qpw/TfBQqjw23/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773438352; c=relaxed/simple;
	bh=fUCa1Im5Nx6GDZdxGDBy42sj6zhaXr1u53PJlGFKT2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LP2XoF4XlKsR1vnofzsxKPePsfIk0DSrzZkNzvVLa/6m6vM5aiOLGdWlFnaZAtLIwsHuPhBPlV+aY9UnVP6DsHY51jf1Rw1BsAHYAw5bVz99+HAKM7r3Sc6mvo2dpKlPHfygEJq5iI9ZpM9i0WPZjcE6PMROHxVLRQ8WKv3bzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8QnlE8q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8QnlE8q"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b042da3f11so570795ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773438350; x=1774043150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qM0Rn19YlMsshQ//ye6aBEoZrk8JSgQPX0Fa7XAh7Q=;
        b=F8QnlE8qLRRe8Quu5as5TsxLJ6ik7cT9ynCjJmvG7K5AMzW0PkZ+X3H7sk6gEo+3VT
         F+BpNsMXgAcPve+39gewOynI7qZXOCrbrORtdXpIZU2lVj7jjOz7WmB3o0PkJyxmzWTU
         OESprBHlTA4VvofxCXAKLxBMHYh85Y9hay2Uvi4C47sk/wnngcNqzzACQ5aW6sJ5LhgR
         jI9BCXz3WpxH+v/lX3hvALqyqnPSNtQTf/uWaD7ZARHq1Whoxd5Z0RzaapsJpYGFImCf
         TKxffupaBe4dstmmdNgGyFp6o0lZNWlQCRPBFoQ/ozf2DmVJplpi1YXTJ16noJ9Wekns
         YrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773438350; x=1774043150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qM0Rn19YlMsshQ//ye6aBEoZrk8JSgQPX0Fa7XAh7Q=;
        b=CVzFLmTas+eALnCFJJHPeJ8GwicdDSg7xivId13ckHWJwcB2zJuLXfE94Md5cUxC5q
         cxGEuXFX7YixE1vKmiReo6dbmFiCHVnv/eH79//s+PTVdNg4Od/vVLtU5sMUCyC9MD9G
         j9FpRDjvNfn7g1HbkOpWbNnuuNiYKv5TMBSzsfUXp8GOuZbrj3nUF1TX7QbtR8SqGLOj
         E5Ct5ziY7uvAO3jHJ853DLwTqBwmWo0GKV5QJGekA6GF7JT1gMVMUAGkh2uQqmB6KHtb
         3tOBxELnLh/yk0CjzpuuyuzkiFTNExwk9qHZdxFtyB+sVKyaiMDP8qKfbRP+CA/6QgPG
         OGVw==
X-Forwarded-Encrypted: i=1; AJvYcCU2AMZpxxkhKznN0sOBYWYQzQ/bGFP2qAdJBilhkDvNRRwTBnunAKXVIHd6yBpEhvGq9mWuLdGqrXcScRzY8Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymoQN6XOPWIvzFF8JkTMVoMtXEOakDA4A897g0S7ufXvrJETbF
	w3OQN7bKs3dZLf4pKnFgb+GdTrbRSLUxUK7BHz6FVGXjSxZl/k4sMvpkh/TYiY+o
X-Gm-Gg: ATEYQzznwXXcGC/9LqxE2RDNEdYRpY6BnQQOGQbPaiq3s6qef4Jb6P/yVLovk5aSKeT
	MriK2W42E4661whNUBFqUKC6IZsnwRRVGbw1imxo9HW1KnbcndO48+pGAmDVQa72bONSmjeuVFT
	4IlxkfdO45OWR8h1boJVoBXIkCA6jFq0UufsPy+fbIfIJXRmM6GSMk/iKKuU18KE3kBy67mkWdY
	u/1ISNc0/enfhbQCRc/bYXGaf7dip7HVSyWwi1IayzrS3Rm74kXLdaXCtCsCz3miQ7jokKiPqbO
	X3GoCbFm2K8E5IDV62JfiaPFRDgwE9r/fGuQrZFYtsVTFC+b0P+rOzVGv2MByWKmofXi3NJB7Pu
	tMfsvV52KWCwvsu+vel7ohsLY7zHwnJ06+lyK5xIzJ9FSquwjfClQ/jtrMmDIBsM+ongAMERhGN
	EiCrtp28Y6IBjzS55zFl8sHkEq6cgqVi0Esm4teT2ob3yJEWhjR8Bd8pyMatWLK9RD
X-Received: by 2002:a17:902:d490:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2aecac738a7mr45936395ad.43.1773438349935;
        Fri, 13 Mar 2026 14:45:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c388sm39983395ad.11.2026.03.13.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:45:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] firmware: stratix10-svc: kmalloc_array + kzalloc to flex
Date: Fri, 13 Mar 2026 14:45:31 -0700
Message-ID: <20260313214531.4829-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations. Simplifies memory
management.

Add __counted_by for extra runtime analysis. Also move counting variable
assignment up as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/firmware/stratix10-svc.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e9e35d67ef96..e28adbc25eb4 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -243,7 +243,6 @@ struct stratix10_async_ctrl {
 /**
  * struct stratix10_svc_controller - service controller
  * @dev: device
- * @chans: array of service channels
  * @num_chans: number of channels in 'chans' array
  * @num_active_client: number of active service client
  * @node: list management
@@ -253,13 +252,13 @@ struct stratix10_async_ctrl {
  * @svc: manages the list of client svc drivers
  * @sdm_lock: only allows a single command single response to SDM
  * @actrl: async control structure
+ * @chans: array of service channels
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
  */
 struct stratix10_svc_controller {
 	struct device *dev;
-	struct stratix10_svc_chan *chans;
 	int num_chans;
 	int num_active_client;
 	struct list_head node;
@@ -269,6 +268,7 @@ struct stratix10_svc_controller {
 	struct stratix10_svc *svc;
 	struct mutex sdm_lock;
 	struct stratix10_async_ctrl actrl;
+	struct stratix10_svc_chan chans[] __counted_by(num_chans);
 };
 
 /**
@@ -1901,7 +1901,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct stratix10_svc_controller *controller;
-	struct stratix10_svc_chan *chans;
 	struct gen_pool *genpool;
 	struct stratix10_svc_sh_memory *sh_memory;
 	struct stratix10_svc *svc = NULL;
@@ -1929,23 +1928,16 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
-	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
+	controller = devm_kzalloc(dev, struct_size(controller, chans, SVC_NUM_CHANNEL),
+				GFP_KERNEL);
 	if (!controller) {
 		ret = -ENOMEM;
 		goto err_destroy_pool;
 	}
 
-	chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
-				   sizeof(*chans), GFP_KERNEL | __GFP_ZERO);
-	if (!chans) {
-		ret = -ENOMEM;
-		goto err_destroy_pool;
-	}
-
-	controller->dev = dev;
 	controller->num_chans = SVC_NUM_CHANNEL;
+	controller->dev = dev;
 	controller->num_active_client = 0;
-	controller->chans = chans;
 	controller->genpool = genpool;
 	controller->invoke_fn = invoke_fn;
 	INIT_LIST_HEAD(&controller->node);
@@ -1962,16 +1954,16 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	mutex_init(&controller->sdm_lock);
 
 	for (i = 0; i < SVC_NUM_CHANNEL; i++) {
-		chans[i].scl = NULL;
-		chans[i].ctrl = controller;
-		chans[i].name = (char *)chan_names[i];
-		spin_lock_init(&chans[i].lock);
-		ret = kfifo_alloc(&chans[i].svc_fifo, fifo_size, GFP_KERNEL);
+		controller->chans[i].scl = NULL;
+		controller->chans[i].ctrl = controller;
+		controller->chans[i].name = (char *)chan_names[i];
+		spin_lock_init(&controller->chans[i].lock);
+		ret = kfifo_alloc(&controller->chans[i].svc_fifo, fifo_size, GFP_KERNEL);
 		if (ret) {
 			dev_err(dev, "failed to allocate FIFO %d\n", i);
 			goto err_free_fifos;
 		}
-		spin_lock_init(&chans[i].svc_fifo_lock);
+		spin_lock_init(&controller->chans[i].svc_fifo_lock);
 	}
 
 	list_add_tail(&controller->node, &svc_ctrl);
@@ -2015,7 +2007,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		list_del(&controller->node);
 	/* free only the FIFOs that were successfully allocated */
 	while (i--)
-		kfifo_free(&chans[i].svc_fifo);
+		kfifo_free(&controller->chans[i].svc_fifo);
 	stratix10_svc_async_exit(controller);
 err_destroy_pool:
 	gen_pool_destroy(genpool);
-- 
2.53.0

