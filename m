Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737618;
	b=L+lomwzIIGYKRZBI4U2b3KU0BV8uKj6M1DStARn53jHxfUj8PKUmgJ51QCyGjJXWWUyT
	 YqDhB5IgTtRF3CG8VfS3As1w7zQj8fc3XE9S171apNrYZf8YHKB32u28ul/ib7W2aOmDb
	 9xmcOEEpdMQMUDAFz4DeLnIK7KED2htO26jM6ReP8XDS2dHb/CSHAr30k0fcxEanLWpr4
	 ibiNL7lBvfXxJnActgaBcW8o3bs2WLDbrFXggBEpPz49QE0spK1M/kUpO7uyH6ldxHJRW
	 OeKy9OgQlO8xmiVeXQM6yk1Njz59KsbzwyhzkIrEofp/31u9RtCTU86mt0OgOFFSXTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=n5culjdNiNJ57R2F4iUQDyrEkYUxfQtY9v1arbrySgw=;
	b=dAfkV4lV77MyZRa47NOswxP65iDfplsoLRfeeC90ZaHt2VJWezqUbXfZirmbVAGEzyEc
	 Iqioct+t4JZ9SDFJoF4kdTp/EBYeDXFcyyOPO/J8c3lj6puzCYjBWoLIOol/IlJiII/Pj
	 AAzNC+mH0DlCHUB32/b34rCSFXJ69JNq0tTW3VDKR2L4fWs5Ko8e/oGk9ChPFcFFgpN9J
	 gj7R6kbVxKgJpKeQSH7/CbYLpGGkLNIuM1mFgYBpqyR7410R2MRDeufWPE6+N2ZshZ6aI
	 +dCD+t5oXXSikYKxZ4rDJEUPQrd8Z8dWOgeyqM2cJS/E6Mzi3E2h+RWLSb2XB8Oj+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=luU+gKCO;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473260A261B
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C473260A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=luU+gKCO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so4043065e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792737603; x=1793342403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5culjdNiNJ57R2F4iUQDyrEkYUxfQtY9v1arbrySgw=;
        b=luU+gKCOcmmzplRMO6Kf+QeWoKXUqR4wLsSIh8GH+CjvSAlq1B5DEFij94uFdSHIDh
         HJ96bRXcS09OQ/OieFpRZGrKNo8yFm3FX5Lx3w5NO9YLw4bXMGEu6kMW+oNHPNA6gs0J
         OmGCkK4ZNchT6EKNNd+khC0hhhRzJyQSSaVDJAC6tVO9EcHSUw9ZbEVYJh08+dV6PR9l
         k4nQNbuoqJvwxU3xPLwzFJ3WbwvZdcl9c+waeVIdzAzZWXi9iqgdF4UvO+EugoC4zifw
         fzVJg8TqC1xsor2ouC8ugiIwbahOpQtX48DPYJBGXH6+3fcTuj48y23QMcm+EE9lhj44
         3B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737603; x=1793342403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5culjdNiNJ57R2F4iUQDyrEkYUxfQtY9v1arbrySgw=;
        b=oEzRTFnTd82GM9g19GUefTejIwS8DcJXNSbGROpCsLPD7f6tssvGdKDaFjvv6zExNy
         Ye3CSxPzrIuitSSONVQlVemOs6a5Ia2b7LrLxS5t8YCB4TzfaeqBhGzXsZy8IxJRF4le
         04uMtGfUDdppAoan7oQJTsxd/LsCItt5zXdD7vIeaaGNNaaOfLchjaVQhybXoZZIToha
         8FcMerPMug+dp1Mxxy9yCd5pK2o5pbsp7zbS5hyROitcmOvWxTcT34IxVHgE3StJSlRQ
         wT3dpqL9JqTWUQXKqET3I7B2fJFPRNrYxEtGFHSe+l+ie9Sj7PBuEh4VEiRuKLyueu1n
         d9uw==
X-Forwarded-Encrypted: i=1; AKwUvBwHIFRN9p1VpdELuQY42uO/5eNDyc64t/W7UCrEk2as0PpJmYng1eEmJJW4K/pX4bGFUUnD7BnETVP6y5u0gQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/nfw97YsQSA9If+kL8uHPcAtm2uC43qjNvQJ7RKtIbo6BRgcp
	KgeKPzh12ncLw7fA1UIEN5ZJ3tsgKuood4Ou41l9uECsVmjKapkDfmznB3+xgY4hfKg=
X-Gm-Gg: AYBFou3fgX2Tljo4PltJzxOuMTK1vTG4BSOy7S/dURKNDDwpBNgN5MNwbpPb/KfIeeB
	2FU2rNpWl0t6DJW2ROJUEWI9VJvk+DcB2ZD0rxl6ZSf9uB5Ku6T7PxuuTJfMbY8NbT9BuHq42ii
	xQcU/tppzes3mlL8dJdWJTCcSXJ6VMsCbTX+fXQ443F/bZtDvDFt0/BGrqymkS35oNXrqx+ENBH
	ItaMsuTym2i9yfOsWyTf5uaMJnSt/oeVD6uuGZt9TYA38tzfZxGsFZ3NxPeDJdPszqCDiyGSKP0
	SAqotGNtKd5mCzDUwCyrVT76Ioi9z3Iq6yg+hFYitnhK2LRd0UbPlhSD5mf19eoQrFPsQy+D/2G
	MVmB2KZGtc8cez/cTWITdLoKQkT74vQ3EWRC/7ZbWSaiYLZv9nYX7jWC4zlWubsXgKU1ua5RpAW
	MsTP4baXmy0QBkxV4rI/B0UiTKA9V7jxmqcSiwiiw01Yzlwsd3XC9HyK8OJEtQ8FfQGj7mL/qaP
	zoa+1xGGt9sFAch1jogRbMY5iTXG59DKxvSB1HDZtfn55S2hQQ79t7Sc74Cso2RKZXmelU+0LkJ
	+6w0zp7oWtTZfu14hi54GWfktKFG06Wo2C7j/cdDcPhgUgR4e4otsFmq9I7qEwgBVVSuyPlweVU
	jyqA=
X-Received: by 2002:a05:600d:82e1:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4a211ce4c9amr18463385e9.14.1792737602834;
        Thu, 22 Oct 2026 23:40:02 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz. [46.135.49.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:40:01 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:33 +0200
Subject: [PATCH v3 08/16] accel/thames: Add support for submitting DMA
 operations
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-8-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2

The C7x has a DMA engine (DRU, Data Routing Unit) that can be used to
asynchronously copy data around, while compute happens.

The DRU does not go through the MMU, so its records hold physical
addresses. To preserve isolation among clients, a record names the
Context's own DSP addresses; the kernel bounds each side of the
transfer, checks it against the Context's mappings, translates the two
addresses to physical once and keeps the translated records in memory
no Context reaches. The next commit's job creation IOCTL is where the
records enter.

The kernel driver also verifies that a malicious or defective client
cannot read or write memory other than its own.

A Job's translated records form a table in a pool inside the IPC
memory, where no Context reaches them, carved by a bitmap in 128-byte
lines. A Job carries up to 512 transfers, and no group may hold more
transfers on one channel than the DRU's queue depth, which the firmware
reports. An L2 side is kept as an offset into its aperture and rebased
for the core that runs the Job when the table is written, since the
DRU walks physical addresses and each core's L2 has its own. At attach
the driver checks that the pool holds a 512-transfer table and that
the firmware's DRU capabilities include type 8, and rewrites the tables
of the Jobs it keeps when it attaches to a core again.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/thames/Makefile           |   3 +-
 drivers/accel/thames/thames_core.c      |  18 ++
 drivers/accel/thames/thames_device.h    |   8 +
 drivers/accel/thames/thames_drv.c       |  17 ++
 drivers/accel/thames/thames_transfers.c | 405 ++++++++++++++++++++++++++++++++
 drivers/accel/thames/thames_transfers.h |  52 ++++
 include/uapi/drm/thames_accel.h         |  61 +++++
 7 files changed, 563 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/thames/Makefile b/drivers/accel/thames/Makefile
index bb81fcd58927..143a829f24cf 100644
--- a/drivers/accel/thames/Makefile
+++ b/drivers/accel/thames/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_THAMES) := thames.o
 thames-y := \
 	thames_core.o \
 	thames_drv.o \
-	thames_gem.o
+	thames_gem.o \
+	thames_transfers.o
diff --git a/drivers/accel/thames/thames_core.c b/drivers/accel/thames/thames_core.c
index 1c983580b62a..dff76abd8951 100644
--- a/drivers/accel/thames/thames_core.c
+++ b/drivers/accel/thames/thames_core.c
@@ -25,6 +25,7 @@
 #include "thames_core.h"
 #include "thames_device.h"
 #include "thames_gem.h"
+#include "thames_transfers.h"
 
 #define THAMES_RESTART_TIMEOUT_MS	5000
 
@@ -132,6 +133,22 @@ static int thames_core_read_caps(struct thames_core *core, struct thames_handsha
 		return -EINVAL;
 	}
 
+	if (THAMES_TRANSFER_TABLE_SIZE(THAMES_JOB_MAX_TRANSFERS, THAMES_JOB_MAX_TRANSFERS) >
+	    caps->transfer_table_pool_size) {
+		dev_err(core->dev,
+			"Firmware transfer table pool of 0x%x bytes is smaller than a %u-transfer table\n",
+			caps->transfer_table_pool_size, THAMES_JOB_MAX_TRANSFERS);
+		return -EINVAL;
+	}
+
+	if (caps->dru_capabilities &&
+	    (caps->dru_capabilities & THAMES_TRANSFER_TYPES) != THAMES_TRANSFER_TYPES) {
+		dev_err(core->dev,
+			"Firmware DRU capabilities 0x%llx lack the transfer types 0x%lx the driver accepts\n",
+			caps->dru_capabilities, THAMES_TRANSFER_TYPES);
+		return -EINVAL;
+	}
+
 	dru_kernel_offset = (u64)dru_kernel_channel_first * caps->dru_channel_stride;
 	dru_kernel_size = (u64)caps->dru_channel_count * caps->dru_channel_stride;
 	if (caps->dru_channel_count > THAMES_MAX_DRU_CHANNELS ||
@@ -618,6 +635,7 @@ int thames_core_resume(struct thames_core *core)
 	core->ring_tail = head;
 
 	thames_context_rewrite_entries(core);
+	thames_transfers_rewrite(core);
 	goto restart;
 
 offline:
diff --git a/drivers/accel/thames/thames_device.h b/drivers/accel/thames/thames_device.h
index a1a54d974359..e183c78e2acf 100644
--- a/drivers/accel/thames/thames_device.h
+++ b/drivers/accel/thames/thames_device.h
@@ -55,6 +55,14 @@ struct thames_device {
 	u32 asid_next;
 	struct mutex asid_lock;
 
+	/*
+	 * One map for every core: a transfer table sits at the same offset in
+	 * each core's pool.
+	 */
+	unsigned long *transfer_table_pool_map;
+	struct mutex transfer_table_pool_lock;
+
+	struct list_head transfer_tables;
 	struct list_head contexts;
 	struct mutex contexts_lock;
 
diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/thames_drv.c
index a17e7a90f7c1..030c60963a0a 100644
--- a/drivers/accel/thames/thames_drv.c
+++ b/drivers/accel/thames/thames_drv.c
@@ -23,6 +23,7 @@
 #include "thames_core.h"
 #include "thames_drv.h"
 #include "thames_gem.h"
+#include "thames_transfers.h"
 
 static struct platform_device *drm_dev;
 static struct thames_device *tdev;
@@ -152,6 +153,7 @@ static int thames_query_caps(struct drm_device *dev, struct drm_thames_dev_query
 		.l2_size = reported->l2_size,
 		.dru_channel_count = reported->dru_channel_count,
 		.dru_queue_depth = reported->dru_queue_depth,
+		.max_transfers = THAMES_JOB_MAX_TRANSFERS,
 		.l2_main_dsp_va = thames_window_va(tdev, THAMES_WINDOW_L2SRAM),
 		.l2_aux.dsp_va = thames_window_va(tdev, THAMES_WINDOW_L2AUX),
 		.l2_aux.size = reported->window_sizes[THAMES_WINDOW_L2AUX],
@@ -161,6 +163,7 @@ static int thames_query_caps(struct drm_device *dev, struct drm_thames_dev_query
 		.user_region.dsp_va = THAMES_USER_REGION_BASE,
 		.user_region.size = THAMES_USER_REGION_SIZE,
 		.hardware_id = reported->hardware_id,
+		.transfer_types = THAMES_TRANSFER_TYPES,
 		.dru_capabilities = reported->dru_capabilities,
 	};
 
@@ -269,6 +272,10 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
 	if (err)
 		return ERR_PTR(err);
 
+	err = drmm_mutex_init(&tdev->ddev, &tdev->transfer_table_pool_lock);
+	if (err)
+		return ERR_PTR(err);
+
 	err = drmm_mutex_init(&tdev->ddev, &tdev->asid_lock);
 	if (err)
 		return ERR_PTR(err);
@@ -281,6 +288,7 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
 	if (err)
 		return ERR_PTR(err);
 
+	INIT_LIST_HEAD(&tdev->transfer_tables);
 	INIT_LIST_HEAD(&tdev->contexts);
 
 	tdev->asid_next = 1;
@@ -349,6 +357,15 @@ static int thames_platform_probe(struct platform_device *pdev)
 		goto err_fini_dev;
 	}
 
+	tdev->transfer_table_pool_map =
+		devm_bitmap_zalloc(&pdev->dev,
+				   tdev->caps.transfer_table_pool_size / THAMES_ABI_LINE_SIZE,
+				   GFP_KERNEL);
+	if (!tdev->transfer_table_pool_map) {
+		err = -ENOMEM;
+		goto err_fini_cores;
+	}
+
 	err = drm_dev_register(&tdev->ddev, 0);
 	if (err)
 		goto err_fini_cores;
diff --git a/drivers/accel/thames/thames_transfers.c b/drivers/accel/thames/thames_transfers.c
new file mode 100644
index 000000000000..aad4542d5cb9
--- /dev/null
+++ b/drivers/accel/thames/thames_transfers.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bits.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+
+#include "thames_core.h"
+#include "thames_device.h"
+#include "thames_drv.h"
+#include "thames_gem.h"
+#include "thames_transfers.h"
+
+/* SPRUIL1D 10.4.3.3. */
+#define TR_FLAGS		0
+#define TR_ICNT01		1
+#define TR_ADDR_LO		2
+#define TR_ADDR_HI		3
+#define TR_DIM1			4
+#define TR_ICNT23		5
+#define TR_DIM2			6
+#define TR_DIM3			7
+#define TR_FMTFLAGS		8
+#define TR_DDIM1		9
+#define TR_DADDR_LO		10
+#define TR_DADDR_HI		11
+#define TR_DDIM2		12
+#define TR_DDIM3		13
+#define TR_DICNT01		14
+#define TR_DICNT23		15
+
+#define TR_FLAGS_TYPE		GENMASK(3, 0)
+#define TR_FLAGS_STATIC		BIT(4)
+#define TR_FLAGS_TRIGGER0	GENMASK(9, 8)
+#define TR_FLAGS_TRIGGER1	GENMASK(13, 12)
+#define TR_FLAGS_TRIGGER1_TYPE	GENMASK(15, 14)
+#define TR_FLAGS_CFG		GENMASK(31, 24)
+#define TR_FLAGS_SUPR_EVT	BIT(26)
+
+#define TR_TRIGGER_NONE		0
+#define TR_TRIGGER_GLOBAL0	1
+
+#define THAMES_TRANSFER_VA_LIMIT	BIT_ULL(48)
+
+/*
+ * Only global trigger 0 of the record's own channel: any other trigger lets a
+ * record wait on another channel's event; indirect addressing would fetch
+ * addresses never checked.
+ */
+static bool thames_transfer_flags_ok(u32 flags)
+{
+	if (!(THAMES_TRANSFER_TYPES & BIT(FIELD_GET(TR_FLAGS_TYPE, flags))))
+		return false;
+
+	if (flags & TR_FLAGS_STATIC)
+		return false;
+
+	if (FIELD_GET(TR_FLAGS_TRIGGER0, flags) != TR_TRIGGER_NONE &&
+	    FIELD_GET(TR_FLAGS_TRIGGER0, flags) != TR_TRIGGER_GLOBAL0)
+		return false;
+
+	if (flags & (TR_FLAGS_TRIGGER1 | TR_FLAGS_TRIGGER1_TYPE))
+		return false;
+
+	return !(flags & TR_FLAGS_CFG & ~TR_FLAGS_SUPR_EVT);
+}
+
+/* SPRUIL1D 10.4.3.3; the footprint includes the strides' gaps. */
+static int thames_transfer_span(u64 base, const u32 icnt[4], const s32 dim[4],
+				u64 *start, u64 *end, u64 *bytes)
+{
+	s64 lo = 0, hi = icnt[0];
+	int i;
+
+	*bytes = 1;
+	for (i = 0; i < 4; i++) {
+		if (!icnt[i])
+			return -EINVAL;
+		*bytes *= icnt[i];
+	}
+
+	for (i = 1; i < 4; i++) {
+		s64 reach = (s64)(icnt[i] - 1) * dim[i];
+
+		if (reach < 0)
+			lo += reach;
+		else
+			hi += reach;
+	}
+
+	if (base >= THAMES_TRANSFER_VA_LIMIT || (s64)base + lo < 0)
+		return -EFAULT;
+
+	*start = base + lo;
+	*end = base + hi;
+	return 0;
+}
+
+static void thames_transfer_hold_bo(struct thames_transfer_table *table,
+				    struct thames_gem_object *bo)
+{
+	struct drm_gem_object *obj = &bo->base.base;
+	u32 i;
+
+	for (i = 0; i < table->bo_count; i++) {
+		if (table->bos[i] == obj) {
+			drm_gem_object_put(obj);
+			return;
+		}
+	}
+
+	table->bos[table->bo_count++] = obj;
+}
+
+/*
+ * An L2 side is kept as an offset into its aperture and rebased per core when
+ * the transfer table is written: the DRU walks physical addresses.
+ */
+static int thames_transfer_side(struct thames_file_priv *file_priv, u64 start, u64 end, bool dest,
+				struct thames_transfer_table *table, u8 *side, u64 *addr)
+{
+	static const enum thames_window l2[] = { THAMES_WINDOW_L2SRAM, THAMES_WINDOW_L2AUX };
+	struct thames_device *tdev = file_priv->tdev;
+	struct thames_gem_object *bo;
+	unsigned int w;
+	u64 offset;
+
+	for (w = 0; w < ARRAY_SIZE(l2); w++) {
+		u64 va = thames_window_va(tdev, l2[w]);
+
+		if (start >= va && end <= va + tdev->caps.window_sizes[l2[w]]) {
+			*side = l2[w];
+			*addr = start - va;
+			return 0;
+		}
+	}
+
+	bo = thames_context_find_bo(file_priv, start, end, &offset);
+	if (!bo)
+		return -EFAULT;
+
+	thames_transfer_hold_bo(table, bo);
+
+	if (dest && (bo->flags & (DRM_THAMES_BO_READ_ONLY | DRM_THAMES_BO_EXECUTABLE)))
+		return -EFAULT;
+
+	/*
+	 * No IOMMU: a contiguous buffer's DMA address is its physical address.
+	 */
+	if (!(bo->flags & DRM_THAMES_BO_CONTIGUOUS))
+		return -EFAULT;
+
+	*side = THAMES_TRANSFER_SIDE_DDR;
+	*addr = bo->base.dma_addr + offset;
+	return 0;
+}
+
+static int thames_transfer_translate(struct thames_file_priv *file_priv,
+				     const struct drm_thames_transfer *t,
+				     struct thames_transfer_table *table,
+				     struct thames_transfer *out)
+{
+	const u32 *w = t->words;
+	u32 icnt[4], dicnt[4];
+	s32 dim[4] = { 0 }, ddim[4] = { 0 };
+	u64 src, dst, start, end, bytes, dbytes, addr;
+	int ret;
+
+	if (!thames_transfer_flags_ok(w[TR_FLAGS]) || w[TR_FMTFLAGS])
+		return -EINVAL;
+
+	icnt[0] = w[TR_ICNT01] & 0xffff;
+	icnt[1] = w[TR_ICNT01] >> 16;
+	icnt[2] = w[TR_ICNT23] & 0xffff;
+	icnt[3] = w[TR_ICNT23] >> 16;
+	dim[1] = w[TR_DIM1];
+	dim[2] = w[TR_DIM2];
+	dim[3] = w[TR_DIM3];
+	src = (u64)w[TR_ADDR_HI] << 32 | w[TR_ADDR_LO];
+
+	dicnt[0] = w[TR_DICNT01] & 0xffff;
+	dicnt[1] = w[TR_DICNT01] >> 16;
+	dicnt[2] = w[TR_DICNT23] & 0xffff;
+	dicnt[3] = w[TR_DICNT23] >> 16;
+	ddim[1] = w[TR_DDIM1];
+	ddim[2] = w[TR_DDIM2];
+	ddim[3] = w[TR_DDIM3];
+	dst = (u64)w[TR_DADDR_HI] << 32 | w[TR_DADDR_LO];
+
+	memcpy(out->record.words, w, sizeof(out->record.words));
+	out->channel = t->channel;
+
+	ret = thames_transfer_span(src, icnt, dim, &start, &end, &bytes);
+	if (ret)
+		return ret;
+	ret = thames_transfer_side(file_priv, start, end, false, table, &out->side[0], &addr);
+	if (ret)
+		return ret;
+	addr += src - start;
+	out->record.words[TR_ADDR_LO] = lower_32_bits(addr);
+	out->record.words[TR_ADDR_HI] = upper_32_bits(addr);
+
+	ret = thames_transfer_span(dst, dicnt, ddim, &start, &end, &dbytes);
+	if (ret)
+		return ret;
+	if (dbytes != bytes)
+		return -EINVAL;
+	ret = thames_transfer_side(file_priv, start, end, true, table, &out->side[1], &addr);
+	if (ret)
+		return ret;
+	addr += dst - start;
+	out->record.words[TR_DADDR_LO] = lower_32_bits(addr);
+	out->record.words[TR_DADDR_HI] = upper_32_bits(addr);
+
+	return 0;
+}
+
+static int thames_transfers_alloc_table(struct thames_device *tdev,
+					struct thames_transfer_table *table)
+{
+	const unsigned long lines = tdev->caps.transfer_table_pool_size / THAMES_ABI_LINE_SIZE;
+	unsigned long start, nr = table->size / THAMES_ABI_LINE_SIZE;
+
+	guard(mutex)(&tdev->transfer_table_pool_lock);
+
+	start = bitmap_find_next_zero_area(tdev->transfer_table_pool_map, lines, 0, nr, 0);
+	if (start + nr > lines)
+		return -ENOSPC;
+
+	bitmap_set(tdev->transfer_table_pool_map, start, nr);
+	table->offset = start * THAMES_ABI_LINE_SIZE;
+	list_add_tail(&table->node, &tdev->transfer_tables);
+	return 0;
+}
+
+void thames_transfers_free(struct thames_device *tdev, struct thames_transfer_table *table)
+{
+	u32 i;
+
+	for (i = 0; i < table->bo_count; i++)
+		drm_gem_object_put(table->bos[i]);
+	kvfree(table->bos);
+	table->bos = NULL;
+	table->bo_count = 0;
+
+	if (!table->size)
+		return;
+
+	scoped_guard(mutex, &tdev->transfer_table_pool_lock) {
+		bitmap_clear(tdev->transfer_table_pool_map, table->offset / THAMES_ABI_LINE_SIZE,
+			     table->size / THAMES_ABI_LINE_SIZE);
+		list_del(&table->node);
+	}
+
+	kvfree(table->records);
+	kvfree(table->group_counts);
+	table->records = NULL;
+	table->group_counts = NULL;
+	table->size = 0;
+}
+
+/*
+ * Written before the Job's handle reaches userspace and never changed while the
+ * Job lives.
+ */
+static void thames_transfers_write_table(struct thames_core *core,
+					 const struct thames_transfer_table *table)
+{
+	static const unsigned int addr_word[2] = { TR_ADDR_LO, TR_DADDR_LO };
+	const struct thames_transfer *records = table->records;
+	const u16 *group_counts = table->group_counts;
+	void *base = core->ipc->transfer_table_pool + table->offset;
+	struct thames_dru_record *out = base;
+	u8 *channels = base + THAMES_TRANSFER_TABLE_CHANNELS_OFFSET(table->count);
+	u32 i, s;
+
+	for (i = 0; i < table->count; i++) {
+		struct thames_dru_record record = records[i].record;
+
+		for (s = 0; s < 2; s++) {
+			u32 *lo = &record.words[addr_word[s]];
+			u64 addr;
+
+			if (records[i].side[s] == THAMES_TRANSFER_SIDE_DDR)
+				continue;
+
+			addr = ((u64)lo[1] << 32 | lo[0]) +
+			       thames_core_window(core, records[i].side[s])->start;
+			lo[0] = lower_32_bits(addr);
+			lo[1] = upper_32_bits(addr);
+		}
+
+		memcpy(&out[i], &record, sizeof(record));
+		channels[i] = records[i].channel;
+	}
+
+	memcpy(base + THAMES_TRANSFER_TABLE_GROUPS_OFFSET(table->count), group_counts,
+	       table->group_count * sizeof(u16));
+}
+
+/* Same offsets, so the Ring entries of the Jobs still queued stay valid. */
+void thames_transfers_rewrite(struct thames_core *core)
+{
+	struct thames_device *tdev = core->tdev;
+	struct thames_transfer_table *table;
+
+	guard(mutex)(&tdev->transfer_table_pool_lock);
+
+	list_for_each_entry(table, &tdev->transfer_tables, node)
+		thames_transfers_write_table(core, table);
+}
+
+int thames_transfers_build(struct drm_file *file, const struct drm_thames_obj_array *transfers,
+			   struct thames_transfer_table *table)
+{
+	struct thames_file_priv *file_priv = file->driver_priv;
+	struct thames_device *tdev = file_priv->tdev;
+	const struct thames_caps *caps = &tdev->caps;
+	u16 per_channel[THAMES_MAX_DRU_CHANNELS] = { 0 };
+	u16 *group_counts = NULL;
+	u16 *group = NULL;
+	struct drm_thames_transfer *in;
+	struct thames_transfer *out;
+	u32 i;
+	int ret;
+
+	memset(table, 0, sizeof(*table));
+
+	if (!transfers->count)
+		return 0;
+
+	if (transfers->count > THAMES_JOB_MAX_TRANSFERS)
+		return -EINVAL;
+
+	in = thames_get_uobj_array(transfers, offsetofend(struct drm_thames_transfer, words),
+				   sizeof(*in));
+	if (IS_ERR(in))
+		return PTR_ERR(in);
+
+	out = kvcalloc(transfers->count, sizeof(*out), GFP_KERNEL);
+	group_counts = kvcalloc(transfers->count, sizeof(u16), GFP_KERNEL);
+	table->bos = kvcalloc(2 * transfers->count, sizeof(*table->bos), GFP_KERNEL);
+	if (!out || !group_counts || !table->bos) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	for (i = 0; i < transfers->count; i++) {
+		if (in[i].flags & DRM_THAMES_TRANSFER_GROUP) {
+			if (!group) {
+				ret = -EINVAL;
+				goto err_free;
+			}
+			memset(per_channel, 0, sizeof(per_channel));
+			group = NULL;
+		}
+
+		if ((in[i].flags & ~DRM_THAMES_TRANSFER_GROUP) ||
+		    in[i].channel >= caps->dru_channel_count ||
+		    ++per_channel[in[i].channel] > caps->dru_queue_depth) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+
+		ret = thames_transfer_translate(file_priv, &in[i], table, &out[i]);
+		if (ret)
+			goto err_free;
+
+		if (!group)
+			group = &group_counts[table->group_count++];
+		(*group)++;
+	}
+
+	table->count = transfers->count;
+	table->size = THAMES_TRANSFER_TABLE_SIZE(table->count, table->group_count);
+
+	ret = thames_transfers_alloc_table(tdev, table);
+	if (ret) {
+		table->size = 0;
+		goto err_free;
+	}
+
+	table->records = out;
+	table->group_counts = group_counts;
+
+	for (i = 0; i < tdev->num_cores; i++)
+		thames_transfers_write_table(&tdev->cores[i], table);
+
+	kvfree(in);
+	return 0;
+
+err_free:
+	thames_transfers_free(tdev, table);
+	memset(table, 0, sizeof(*table));
+	kvfree(group_counts);
+	kvfree(out);
+	kvfree(in);
+	return ret;
+}
diff --git a/drivers/accel/thames/thames_transfers.h b/drivers/accel/thames/thames_transfers.h
new file mode 100644
index 000000000000..67963cbcb621
--- /dev/null
+++ b/drivers/accel/thames/thames_transfers.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2026 Texas Instruments Incorporated - https://www.ti.com/ */
+
+#ifndef __THAMES_TRANSFERS_H__
+#define __THAMES_TRANSFERS_H__
+
+#include <linux/bits.h>
+
+#include <drm/drm_gem.h>
+#include <drm/thames_accel.h>
+
+#include "thames_abi.h"
+
+struct drm_file;
+struct thames_core;
+struct thames_device;
+
+#define THAMES_TRANSFER_SIDE_DDR	0xff
+
+/*
+ * SPRUIL1D 10.4.3.3: type 8, the 4D block move, the one type whose footprint
+ * the transfer checks bound.
+ */
+#define THAMES_TRANSFER_TYPES		BIT(8)
+#define THAMES_JOB_MAX_TRANSFERS	512
+
+struct thames_transfer {
+	u8 channel;
+	u8 side[2];
+	struct thames_dru_record record;
+};
+
+struct thames_transfer_table {
+	u32 offset;
+	u32 size;
+	u32 count;
+	u32 group_count;
+	struct drm_gem_object **bos;
+	u32 bo_count;
+	struct thames_transfer *records;
+	u16 *group_counts;
+	struct list_head node;
+};
+
+int thames_transfers_build(struct drm_file *file, const struct drm_thames_obj_array *transfers,
+			   struct thames_transfer_table *table);
+
+void thames_transfers_free(struct thames_device *tdev, struct thames_transfer_table *table);
+
+void thames_transfers_rewrite(struct thames_core *core);
+
+#endif
diff --git a/include/uapi/drm/thames_accel.h b/include/uapi/drm/thames_accel.h
index ea556b48f1d7..5671cffaf8f9 100644
--- a/include/uapi/drm/thames_accel.h
+++ b/include/uapi/drm/thames_accel.h
@@ -348,6 +348,67 @@ struct drm_thames_dev_query {
 	__u64 pointer;
 };
 
+/*
+ * Starts a new transfer group.  The transfers are cut into groups, in array
+ * order: the first group starts at the first transfer, each later group at a
+ * transfer carrying this flag.  The firmware submits the first group before it
+ * enters the Kernel, and each later group, whole, when the Kernel asks for it
+ * with system call 2.  No group may hold more transfers on one channel than
+ * &drm_thames_caps.dru_queue_depth.  Never on the first transfer.  A Job
+ * without the flag is one group.
+ */
+#define DRM_THAMES_TRANSFER_GROUP	(1 << 0)
+
+/**
+ * struct drm_thames_transfer - One DRU transfer of a Job
+ *
+ * @words is a K3 DMA transfer record as the DRU takes it (SPRUIL1D 10.4.3.3,
+ * Table 10-63 for type 15), with its source and destination address fields
+ * holding a dsp_va of the Context.  The kernel reads the type from the flags
+ * word, computes the byte footprint of each side from the counts, strides and
+ * addressing mode of every type and flag it knows how to bound, checks the
+ * source against readable mappings and the destination against writable ones,
+ * and refuses any type, flag or mode it cannot bound; the indirect-address
+ * flags are always refused, since they would let a record fetch addresses the
+ * kernel never checked.  The kernel translates the two addresses to physical
+ * once, at Job creation, and keeps the translated records where no Context
+ * reaches them; the firmware submits the first group before it enters the
+ * Kernel and each later group when the Kernel asks for it (see
+ * DRM_THAMES_TRANSFER_GROUP), and waits for the channels to drain after the
+ * Kernel returns, before the Job's fence signals.  This kernel and firmware
+ * accept type 8, the 4D block move.  The kernel refuses a trigger other than
+ * global trigger 0 (the one the firmware raises by software), a nonzero format
+ * word, a zero count and a side whose byte count differs from the other's.  The
+ * record's own flags say which loop level a software trigger advances; a record
+ * with no trigger runs to completion once submitted.
+ * A Kernel triggers and polls its channels through the page at
+ * &drm_thames_caps.dru_realtime_dsp_va, mapped user read-write in every
+ * Context, which reaches the channels of the core the Job runs on.
+ *
+ * A side addresses either a span of one buffer bound in the Context, found by
+ * its dsp_va among all the Context's buffers, the buffer created
+ * DRM_THAMES_BO_CONTIGUOUS (the DRU walks physical addresses linearly, and only
+ * such a buffer is one physical run), the destination in a buffer not created
+ * DRM_THAMES_BO_READ_ONLY or DRM_THAMES_BO_EXECUTABLE; or the L2 main or
+ * auxiliary aperture, at &drm_thames_caps.l2_main_dsp_va and l2_aux, which the
+ * kernel translates to the physical aperture of the core the Job runs on.  The
+ * Job holds a reference on each buffer a transfer resolves to until it is
+ * destroyed and its last submission has completed.
+ */
+struct drm_thames_transfer {
+	/**
+	 * @channel: The DRU channel this transfer queues on, below
+	 * &drm_thames_caps.dru_channel_count.
+	 */
+	__u32 channel;
+
+	/** @flags: DRM_THAMES_TRANSFER_* bits; others MBZ. */
+	__u32 flags;
+
+	/** @words: The transfer record, sixteen 32-bit words, flags first. */
+	__u32 words[16];
+};
+
 /**
  * DRM_IOCTL_THAMES() - Build a thames IOCTL number
  * @__access: Access type. Must be R, W or RW.

-- 
2.54.0

