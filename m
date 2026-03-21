Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2729B764
	for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774065156; cv=none; b=P8z3QsBoE9HE+BFy8XxX4cVf7IMTO7ujtxS0rsLQHnvMWl+yLY0PYTdzy/MYehcXoUVLl8X3Y6PgQMjTeAMIXGHS47Z+R8nd77Nd+n1VBj285+Ca344wPF7wBMAmAxPp0F6nuB5U0jTYzZKNtq06lGXS9nI1gbRP61pTOHpfSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774065156; c=relaxed/simple;
	bh=+WUaYnyz29v3mRwazoJ/Ikq6XTg5VutX8hbCpJmgTVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baScHCJGpQeX4Te/CHRRH5uxrdxoIhRjvjxCfOT9GFsqCIMyjmvqazfIWSnYuahbHS/r31xtjFqJHj+n7LSSqZlPpe/fOGpdYE7uvXOLbE54brKR4D9Hidp+gzE/uNBCQ8hId9JCC9PUN7D35FUPNika0YHU6HAX+eXx+zfQK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3hkGdRn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3hkGdRn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso1696179a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774065155; x=1774669955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcJnW6kg+/NIdI6Vl3b6KcDbliX1oc7SiSAekESdtOc=;
        b=K3hkGdRnJIz1U1SLueHKesg9b+IYY7A/chI9q2bh4he9vAOcOPRxNk6keznA9S4edh
         4YAiMTaUHkqbiS7M4SJvOk8fThsaVFH2erA8+DAli6vUBJT9ug5+ZgSpAyb7Z+35wLIr
         DvSDRqOrV8nsVB2TH5BKaGHSNKcZ8y6V7PoGYCSqgzYrrZbcqW9Y0GDwM482r7lwBqcu
         14fhx0ovebAFVRxqWJ6eqyJ9+hBtxFPbHlU1OE59AfBodU0Ly2J7QOzP3lRIF3TkCXnC
         xmsIA754IHmKtguavv5lYrWdPaG6+08UZclH96/MGzB+awoCEhyh1337PS+0LZuH6zPG
         g5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774065155; x=1774669955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcJnW6kg+/NIdI6Vl3b6KcDbliX1oc7SiSAekESdtOc=;
        b=guXUZiccJZWi8ANu2CWnvieZ805vyfNdANvwp5ZsZL42e5kkrgAbW1WuahNC2Aj47T
         rHAprhZcqtX/qlRVN/5XIMMOJK57ivzWUS6Uh1N0jZkwC64F+xDJYxiuEN7NXVxbWcqF
         32G3YdxEgSi0nA5LpwCK8dd3Ghhy60Y1F2MBgyGotOgOAq0KHAmeBD0OxFy7i3oE3e8D
         cgsMrcwZyID+UHwfoMWy13hU9P7sTA6vYq4ehQHhWdC7R4r0fThNpUU35VBgxhjvvRoe
         7YBia4tz23HV2Ubob5G1W7HsVOjObr2xKCObhT7BtJPwaEH3/rm6Jy3NSF3MhOHKywMe
         YEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxVbuKs1eynQlXP02dzmu2/G2n4lYooCp+MExumLlkaNAhERHBv3q+gjXZtbPlpTGBC+K79qTt+uTg/JfdnQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFFlzSmUR1Ui/sviojEov8aXKh35Hcp99eb3p2ymOXglYNGG4
	CVvVM1/EZCFf3JpNNcHCFuLjDRsBLZ+1SzPpn8XGO/WL+BnUYxBhbby+
X-Gm-Gg: ATEYQzx0MjeebaPFyTauYfsHMdOmfFKNNiwENkUefGUi7hLj9G/CLO3fs45tzN03Vwg
	hF3dCGY0uggrw5oIDP92L8/OuXbTLe31poGSC/hKL1bpymTVg5VdspI6uEaxZH4p3SLMOBM9NLT
	bF/Mv1nWnmVLuWXXeN6bAcJk2qvgQ/CdEYPwdp1WidUwRqAbxT50DEUeC+admrPXjUNSvOi2MHA
	EG4qkBRdE+7etS+GPIlVw0cPO7ZBq05mGEjkWA/6DU5RgjyEa+scRoX6QYMKSM5vcsrwEihCQ5O
	haWcdalx7qaRinZLNF3eL8QGGI6DnSLElYh76QQuMmwiEXnT126Ur2sE2p51CiRB+WBoH+kJLv0
	zJvfJ9ZgRV3ZE6K/ZfjFTLF0BsC8OfDL0JgQ906nv5UqZDMRkNHRzvWSkaM7a7vcnVkdKCsG5CM
	HNMGRKqiD1ghX98JOq/wNM4GiU5SihjAGMLC2Y7mVzKDmYrZxh4AqlR8l0HR+F3owraw==
X-Received: by 2002:a17:90b:3c48:b0:359:855f:ff96 with SMTP id 98e67ed59e1d1-35bd2cb73f1mr3873362a91.17.1774065154813;
        Fri, 20 Mar 2026 20:52:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb4bf5sm3363083a91.4.2026.03.20.20.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:52:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] firmware: stratix10-svc: kmalloc_array + kzalloc to flex
Date: Fri, 20 Mar 2026 20:52:17 -0700
Message-ID: <20260321035217.10180-1-rosenp@gmail.com>
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
 v2: move stratix10_svc_chan to provide a full definition as needed by
 flexible array members.
 drivers/firmware/stratix10-svc.c | 82 ++++++++++++++------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e9e35d67ef96..5a76cf3fc83a 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -240,10 +240,34 @@ struct stratix10_async_ctrl {
 	DECLARE_HASHTABLE(trx_list, ASYNC_TRX_HASH_BITS);
 };

+/**
+ * struct stratix10_svc_chan - service communication channel
+ * @ctrl: pointer to service controller which is the provider of this channel
+ * @scl: pointer to service client which owns the channel
+ * @name: service client name associated with the channel
+ * @task: pointer to the thread task which handles SMC or HVC call
+ * @svc_fifo: a queue for storing service message data (separate fifo for every channel)
+ * @svc_fifo_lock: protect access to service message data queue (locking pending fifo)
+ * @lock: protect access to the channel
+ * @async_chan: reference to asynchronous channel object for this channel
+ *
+ * This struct is used by service client to communicate with service layer.
+ * Each service client has its own channel created by service controller.
+ */
+struct stratix10_svc_chan {
+	struct stratix10_svc_controller *ctrl;
+	struct stratix10_svc_client *scl;
+	char *name;
+	struct task_struct *task;
+	struct kfifo svc_fifo;
+	spinlock_t svc_fifo_lock;
+	spinlock_t lock;
+	struct stratix10_async_chan *async_chan;
+};
+
 /**
  * struct stratix10_svc_controller - service controller
  * @dev: device
- * @chans: array of service channels
  * @num_chans: number of channels in 'chans' array
  * @num_active_client: number of active service client
  * @node: list management
@@ -253,13 +277,13 @@ struct stratix10_async_ctrl {
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
@@ -269,31 +293,7 @@ struct stratix10_svc_controller {
 	struct stratix10_svc *svc;
 	struct mutex sdm_lock;
 	struct stratix10_async_ctrl actrl;
-};
-
-/**
- * struct stratix10_svc_chan - service communication channel
- * @ctrl: pointer to service controller which is the provider of this channel
- * @scl: pointer to service client which owns the channel
- * @name: service client name associated with the channel
- * @task: pointer to the thread task which handles SMC or HVC call
- * @svc_fifo: a queue for storing service message data (separate fifo for every channel)
- * @svc_fifo_lock: protect access to service message data queue (locking pending fifo)
- * @lock: protect access to the channel
- * @async_chan: reference to asynchronous channel object for this channel
- *
- * This struct is used by service client to communicate with service layer.
- * Each service client has its own channel created by service controller.
- */
-struct stratix10_svc_chan {
-	struct stratix10_svc_controller *ctrl;
-	struct stratix10_svc_client *scl;
-	char *name;
-	struct task_struct *task;
-	struct kfifo svc_fifo;
-	spinlock_t svc_fifo_lock;
-	spinlock_t lock;
-	struct stratix10_async_chan *async_chan;
+	struct stratix10_svc_chan chans[] __counted_by(num_chans);
 };

 static LIST_HEAD(svc_ctrl);
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

