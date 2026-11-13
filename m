Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593720;
	b=IIIhEPvcbEm9BNhqd5G3ab51Pveybh+iUWTfNeGDi/k6EFKyzHZ6kqhChOtsmDNEVtQn
	 qzcWKz8xiAkppH19P3VR55rWH1Lq6e5J/Ta1N5IIe+a+L3EQLFsN3cNHhr5Yn8PVlBB58
	 WCxX6dnAjZtVbebwpM78m4Qk8WulNI4qR7R6m/MM84pTr9T0+V2XN8EIn06e05HZwzi+4
	 LhZkDotGdpr5I+ZYqznZnkAW27NbLWExxIQfiJVPNEODnKVH9Zb+YmKGIaFzwczz64VU9
	 YRLSbTgiAel6ij/DmRNiW+POnd+Ch8D7v1U+5z/C0HCjue98jBIezgum4vG7mfJ72XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5eNEgFzhWH7jpfC4qUFWzbhOJFFIlgHhC5d6+DyxPHs=;
	b=W+AFXbNoHEL2aNIRsblsmAP3nFLVNdiCV5hve/qJm3v+pIikr7lj1QKJmzG22kNwzgE8
	 obsnyXBWvYqosLgkDzEv0qW2HO7yHPsVnZkLnu6AkgJCHDOO4tJb3hNGuZL1UowG7idFg
	 YS5MfCrIEvYkLvNXLVkfPCJay4lXCBXv1qsBlbjlxzkNYwIEWH0rQ8cycXPFaopbs5gh6
	 T3+TGFhtYH7zJRXKwuch74iuCaukWjYB3ntSlMV1IgqZPP2pUz3ygjP2WfeRr6t4A/rB6
	 lc+hIiXqjeuiQPKj8nELNVtKiSdvi+ligveqB40CKwMKi7xRzBSD86+1vhedTKE0EyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFl2cgTj;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16A606A8A7
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 18:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB16A606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFl2cgTj
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8439fe796ebso1691713a34.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794593719; x=1795198519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5eNEgFzhWH7jpfC4qUFWzbhOJFFIlgHhC5d6+DyxPHs=;
        b=rFl2cgTjp1Znmohq5Dux4GpthbZ+f+aWBhL06fOTnx1mWNjMeG2mOw7jElN8+oIB8g
         gPuSVOxpvzEgNqECoqSHkRJSveuG0Sm2wCGmm4ko16/M+D5wcCSPxVk5ZBdRRMPanD/u
         371MzFDoSvWvQolyd1qJRyVBLfOhzVOAUl/pw8WgTIb5w1tjbuLBmKzzgx8EGAvUdqSi
         nGWhuRlMzsvV49f3L83YY1X8fhZCAFmitM1Dmq+O+3MFtJ9R/TRoZYpTmMi/9BE6/XWK
         MFDnVlHC3cLwlVemn4fex8uODZGSrtuk8QLAHi0F5AXaeDxe+42Y275wQYk1jMmjJFm6
         d7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794593719; x=1795198519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5eNEgFzhWH7jpfC4qUFWzbhOJFFIlgHhC5d6+DyxPHs=;
        b=RJwuvrOXA8TgOKGi3oczbLsG1kQ5qvFtvujIwz65BAghGDMl0tTe66UdSPPC/jN6Jo
         DLyBkfN7haANcpvrUJl7UeVBVmthwlImMDLLvovARq6EDc0zuIFeytulARjlmlsrdu97
         UBcK/RRq+6PWcP/YncILaWKP1e5fSnZp3pxwIGKow7+gOHB0RW308fzwlA8D2mltQx9q
         VfG/Zirvpq6tnnrklyc/4M7N+ZoBLCHWEzLgKi1J4byJ0ET9zSjoJnKMNwJbOxUMLjaF
         OwQOaHdxEpvyHJUWj0qwhC+pVbinDgH085TZH475+ZIMbwRD9rlQALYg1MAdn2/xyRZt
         PLaw==
X-Forwarded-Encrypted: i=1; AL+hErEt5+HF7WVJA8djDUQ+Pgc3syl5uMbaiaDyZvRdlTyfp0MXTrvhJdgEtYDmja6rAVPC+n772jsvW+zKrv1hjuE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RtItWrGGX4BSt+Lv7hekMnRaygFyPTWUe5lrALJk2+MAm9uVl
	RkfqfulRfFAa67X8vlFR6D8rbuuNtqUy6OZmjvY8d9IxzVDEw1i/OXIb
X-Gm-Gg: AYBFou2s7Lmfxslm9ilo2TNKR5e5NtxoviMghq6fB9gK+ah5j5WWE2XaE8cw9xm74Gv
	bHKo8Sq0rJf4/Oq/HAYiczWBaDs7rPUQTPaLDR3M/uWw6VDrxaBiC9FW7dRvtvSnKEvUXnzuh70
	WuVWjARWq/hlt8dkfeaT8oFoQcmTJ4xgB6RB5rqdU540+h5XucSMVgocE7TDmmg0vjArNJIpftm
	rFZFjItIYhyF0TXQRZwpgbqZMMgQYSTpneOsaQpxlUl5d3Z9fhjFvTfQU0KSytETqw6BamP6P/3
	UgKjhm5mIcffh1fbPbJ4dT83XBCqPx+Lu5dXea6vdOW6ZHxo72hAfMhc3Qjzj0IMKWp98E0Baix
	s+7Yw0dC0L7SSnIAgoK7YuMZ+oYjcihmK7TC0zkAgitXYRr7UNTdwGtD1OD0Olw5Zc0KQlMhA1r
	xS1+urgOJXWCFLODMfWji3wlr1KVvQnBIv70XxaYUnFrvgoL055d2eJtnSzj2G1d7j1JPQdjQlR
	zbUM1AsOoZpJLaHntXaJsazdn1pintSPvixsfej+RtdwuAOGOVaIV+t0+tJAovf++VRHMqYP1K9
	fPfAwJSg6yUH+TV99YqLu2bmtNjtTW/iWOp7ssRiJMJwC1sphVEMZIk57uVs/gAvT1hzZbbp7RW
	xrhg2aqcYzWDieyB6O7lAw2OkfFehVHwZXH8SHb2Anw7rRuM9J6wWANsvyl/WwR/sGUsG8Qwr6Y
	jY1wIsDNT4cJcdBCoiYfWOrEKXEfCNWBSPIVPE6Pdzy7w8V1oFzUe1D9VvXrQn+k60y1zj8b4YW
	A==
X-Received: by 2002:a05:6820:418b:b0:716:c34d:c2aa with SMTP id 006d021491bc7-71ab509ed1amr2229390eaf.37.1794593718573;
        Fri, 13 Nov 2026 10:15:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628817d979sm3253414a34.22.2026.11.13.10.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:15:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 11:14:20 -0700
Subject: [PATCH v4 04/58] mtd: retain virtual concatenations across
 component removal
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
Message-Id: <20261113-submit-rawnand-retained-handle-lifetime-v1-v4-4-556b1d7c6221@gmail.com>
References: <20261113-submit-rawnand-retained-handle-lifetime-v1-v4-0-556b1d7c6221@gmail.com>
In-Reply-To: <20261113-submit-rawnand-retained-handle-lifetime-v1-v4-0-556b1d7c6221@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Yuqiang Sun <izaiahsun@gmail.com>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bernhard Frauendienst <kernel@nospam.obeliks.de>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2

Virtual concatenation keeps hidden partition objects outside the normal
partition list. They neither retain their backing masters nor get removed
by registration-failure cleanup. Teardown also compares a master against
its hidden children, leaving stale pointers when a component disappears.

Give staged components ownership of managed backing objects and register
the allocation returned by mtd_concat_create() directly. Serialize staging
and publication across controllers, keeping components in DT order and
publishing only after every contributing master finishes registration.

Disconnect and drain the concatenation before releasing any component.
Gate all forwarding operations, including OOB-layout callbacks, with SRCU.
Use its NMI-safe reader flavor because panic writes use the same object.
Drain while the staging lock still serializes concurrent removals, so a
second unmanaged master cannot free its state before admitted I/O finishes.
Then unregister outside the staging lock and release component references.
An old handle retains disconnected virtual metadata, not a replacement's
components or hardware callbacks.

Resolve the first component's OOB layout through its master: partitions
inherit this layout instead of storing their own callbacks.

Unwind hidden components with ordinary partitions on registration failure,
preserving other masters' staged components for a later probe. Advance the
partition offset past hidden components, and use a separate partition-lock
class for virtual masters to allow removal through a physical partition.

Fixes: 43db6366fc2d ("mtd: Add driver for concatenating devices")
Cc: Yuqiang Sun <izaiahsun@gmail.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Bernhard Frauendienst <kernel@nospam.obeliks.de>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/r/20261103143953.69642-1-izaiahsun@gmail.com/
Link: https://lore.kernel.org/r/sashiko-outbox-195551@kernel.org/
Link: https://lore.kernel.org/r/sashiko-outbox-210241@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/Kconfig           |   1 +
 drivers/mtd/mtd_virt_concat.c | 526 +++++++++++++++++++++---------------------
 drivers/mtd/mtdconcat.c       | 103 ++++++++-
 drivers/mtd/mtdcore.c         |   3 +-
 drivers/mtd/mtdpart.c         |  14 +-
 include/linux/mtd/concat.h    |  22 +-
 6 files changed, 399 insertions(+), 270 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index d13a065874ba..97f10fda30a4 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -4,6 +4,7 @@ config MTD_DEVICE
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
 	select MTD_DEVICE
+	select SRCU
 	imply NVMEM
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 0d501e1565c0..2738e7417e2d 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -7,346 +7,356 @@
  */
 
 #include <linux/device.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include "mtdcore.h"
-#include <linux/mtd/partitions.h>
+#include <linux/mtd/concat.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/slab.h>
-#include <linux/mtd/concat.h>
+
+#include "mtdcore.h"
 
 #define CONCAT_PROP "part-concat-next"
-#define CONCAT_POSTFIX "concat"
-#define MIN_DEV_PER_CONCAT 1
 
-static LIST_HEAD(concat_node_list);
+struct mtd_virt_concat_part {
+	struct device_node *node;
+	struct mtd_info *mtd;
+	bool ready;
+};
+
+struct mtd_virt_concat_device {
+	struct list_head node;
+	struct mtd_info *mtd;
+};
 
-/**
- * struct mtd_virt_concat_node - components of a concatenation
- * @head: List handle
- * @count: Number of nodes
- * @nodes: Pointer to the nodes (partitions) to concatenate
- * @concat: Concatenation container
- */
 struct mtd_virt_concat_node {
-	struct list_head head;
+	struct list_head node;
+	struct mtd_virt_concat_device *device;
 	unsigned int count;
-	struct mtd_concat *concat;
-	struct device_node *nodes[] __counted_by(count);
+	struct mtd_virt_concat_part parts[] __counted_by(count);
 };
 
-/**
- * mtd_is_part_concat - Check if the device is already part
- *                       of a concatenated device
- * @dev:        pointer to 'device_node'
- *
- * Return: true if the device is already part of a concatenation,
- *         false otherwise.
- */
-static bool mtd_is_part_concat(struct device_node *dev)
+static LIST_HEAD(concat_node_list);
+static DEFINE_MUTEX(concat_lock);
+static struct lock_class_key concat_partitions_lock_key;
+
+static bool mtd_is_part_concat(struct device_node *node)
 {
 	struct mtd_virt_concat_node *item;
-	int idx;
+	unsigned int i;
 
-	list_for_each_entry(item, &concat_node_list, head) {
-		for (idx = 0; idx < item->count; idx++) {
-			if (item->nodes[idx] == dev)
+	list_for_each_entry(item, &concat_node_list, node)
+		for (i = 0; i < item->count; i++)
+			if (item->parts[i].node == node)
 				return true;
-		}
-	}
 	return false;
 }
 
-static void mtd_virt_concat_put_mtd_devices(struct mtd_concat *concat)
+/* Hidden partitions have no registered device to own their storage. */
+static void mtd_virt_concat_part_release(struct kref *ref)
+{
+	struct mtd_info *mtd = container_of(ref, struct mtd_info, refcnt);
+	struct mtd_info *master = mtd->ref_master;
+	struct mtd_info *parent = mtd->parent;
+
+	of_node_put(mtd_get_of_node(mtd));
+	release_mtd_partition(mtd);
+	if (master) {
+		if (parent != master)
+			mtd_put_data(parent);
+		mtd_put_lifetime(master);
+	}
+}
+
+static void mtd_virt_concat_part_put(struct mtd_info *mtd)
 {
+	kref_put(&mtd->refcnt, mtd_virt_concat_part_release);
+}
+
+static void mtd_virt_concat_release(struct mtd_info *mtd)
+{
+	struct mtd_concat *concat = container_of(mtd, struct mtd_concat, mtd);
 	int i;
 
 	for (i = 0; i < concat->num_subdev; i++)
-		put_mtd_device(concat->subdev[i]);
+		if (concat->subdev[i])
+			mtd_virt_concat_part_put(concat->subdev[i]);
+	kfree(mtd->priv);
+	kfree(mtd->name);
+	mtd_concat_destroy(mtd);
 }
 
-void mtd_virt_concat_destroy_joins(void)
+static void mtd_virt_concat_unregister(struct list_head *devices)
 {
-	struct mtd_virt_concat_node *item, *tmp;
-	struct mtd_info *mtd;
+	struct mtd_virt_concat_device *device, *next;
 
-	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
-		mtd = &item->concat->mtd;
-		if (item->concat) {
-			mtd_device_unregister(mtd);
-			kfree(mtd->name);
-			mtd_virt_concat_put_mtd_devices(item->concat);
-			mtd_concat_destroy(mtd);
+	list_for_each_entry_safe(device, next, devices, node) {
+		struct mtd_concat *concat = container_of(device->mtd, struct mtd_concat, mtd);
+		int i;
+
+		list_del(&device->node);
+		mtd_device_unregister(device->mtd);
+		for (i = 0; i < concat->num_subdev; i++) {
+			mtd_virt_concat_part_put(concat->subdev[i]);
+			concat->subdev[i] = NULL;
 		}
+		mtd_put_master(device->mtd);
 	}
 }
 
-/**
- * mtd_virt_concat_destroy - Destroy the concat that includes the mtd object
- * @mtd:        pointer to 'mtd_info'
- *
- * Return: 0 on success, -error otherwise.
- */
+static bool mtd_virt_concat_contains(struct mtd_info *part, struct mtd_info *mtd)
+{
+	for (; part; part = part->parent)
+		if (part == mtd)
+			return true;
+	return false;
+}
+
 int mtd_virt_concat_destroy(struct mtd_info *mtd)
 {
-	struct mtd_info *child, *master = mtd_get_master(mtd);
-	struct mtd_virt_concat_node *item, *tmp;
-	struct mtd_concat *concat;
-	int idx, ret = 0;
-	bool is_mtd_found;
-
-	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
-		is_mtd_found = false;
-
-		/* Find the concat item that hold the mtd device */
-		for (idx = 0; idx < item->count; idx++) {
-			if (item->nodes[idx] == mtd_get_of_node(mtd)) {
-				is_mtd_found = true;
-				break;
-			}
-		}
-		if (!is_mtd_found)
-			continue;
-		concat = item->concat;
-
-		/*
-		 * Since this concatenated device is being removed, retrieve
-		 * all MTD devices that are part of it and register them
-		 * individually.
-		 */
-		for (idx = 0; idx < concat->num_subdev; idx++) {
-			child = concat->subdev[idx];
-			if (mtd_get_of_node(child) != mtd_get_of_node(mtd)) {
-				ret = add_mtd_device(child);
-				if (ret)
-					goto out;
+	struct mtd_virt_concat_node *item;
+	LIST_HEAD(devices);
+	unsigned int i;
+
+	/* A virtual master cannot itself be a DT concatenation component. */
+	if (mtd_get_master(mtd)->master.release == mtd_virt_concat_release)
+		return 0;
+
+	mutex_lock(&concat_lock);
+	list_for_each_entry(item, &concat_node_list, node) {
+		for (i = 0; i < item->count; i++) {
+			struct mtd_virt_concat_part *part = &item->parts[i];
+
+			if (!mtd_virt_concat_contains(part->mtd, mtd))
+				continue;
+			if (item->device) {
+				mtd_concat_disconnect(item->device->mtd);
+				list_add_tail(&item->device->node, &devices);
+				item->device = NULL;
 			}
+			mtd_virt_concat_part_put(part->mtd);
+			part->mtd = NULL;
+			part->ready = false;
 		}
-		/* Destroy the concat */
-		if (concat->mtd.name) {
-			del_mtd_device(&concat->mtd);
-			kfree(concat->mtd.name);
-			mtd_virt_concat_put_mtd_devices(item->concat);
-			mtd_concat_destroy(&concat->mtd);
-		}
-
-		for (idx = 0; idx < item->count; idx++)
-			of_node_put(item->nodes[idx]);
-
-		kfree(item);
 	}
+	mutex_unlock(&concat_lock);
+
+	/* Unregistration takes the virtual master's partition lock. */
+	mtd_virt_concat_unregister(&devices);
 	return 0;
-out:
-	mutex_lock(&master->master.partitions_lock);
-	list_del(&child->part.node);
-	mutex_unlock(&master->master.partitions_lock);
-	kfree(mtd->name);
-	kfree(mtd);
+}
 
-	return ret;
+static void mtd_virt_concat_free_item(struct mtd_virt_concat_node *item)
+{
+	unsigned int i;
+
+	for (i = 0; i < item->count; i++)
+		of_node_put(item->parts[i].node);
+	kfree(item);
 }
 
-/**
- * mtd_virt_concat_create_item - Create a concat item
- * @parts:        pointer to 'device_node'
- * @count:        number of mtd devices that make up
- *                the concatenated device.
- *
- * Return: 0 on success, -error otherwise.
- */
-static int mtd_virt_concat_create_item(struct device_node *parts,
-				       unsigned int count)
+static int mtd_virt_concat_create_item(struct device_node *node, unsigned int count)
 {
 	struct mtd_virt_concat_node *item;
-	struct mtd_concat *concat;
-	int i;
-
-	for (i = 0; i < (count - 1); i++) {
-		if (mtd_is_part_concat(of_parse_phandle(parts, CONCAT_PROP, i)))
-			return 0;
-	}
+	unsigned int i, j;
 
-	item = kzalloc_flex(*item, nodes, count, GFP_KERNEL);
+	item = kzalloc_flex(*item, parts, count, GFP_KERNEL);
 	if (!item)
 		return -ENOMEM;
-
 	item->count = count;
+	item->parts[0].node = of_node_get(node);
 
-	/*
-	 * The partition in which "part-concat-next" property
-	 * is defined is the first device in the list of concat
-	 * devices.
-	 */
-	item->nodes[0] = parts;
-
-	for (i = 1; i < count; i++)
-		item->nodes[i] = of_parse_phandle(parts, CONCAT_PROP, (i - 1));
+	for (i = 1; i < count; i++) {
+		struct device_node *part = of_parse_phandle(node, CONCAT_PROP, i - 1);
 
-	concat = kzalloc_flex(*concat, subdev, count, GFP_KERNEL);
-	if (!concat) {
-		kfree(item);
-		return -ENOMEM;
+		item->parts[i].node = part;
+		if (!part || mtd_is_part_concat(part))
+			goto out;
+		for (j = 0; j < i; j++)
+			if (item->parts[j].node == part)
+				goto out;
 	}
-
-	item->concat = concat;
-
-	list_add_tail(&item->head, &concat_node_list);
-
+	list_add_tail(&item->node, &concat_node_list);
 	return 0;
+out:
+	mtd_virt_concat_free_item(item);
+	return -EINVAL;
 }
 
-void mtd_virt_concat_destroy_items(void)
+void mtd_virt_concat_destroy_joins(void)
 {
-	struct mtd_virt_concat_node *item, *temp;
-	int i;
+	struct mtd_virt_concat_node *item;
+	LIST_HEAD(devices);
+	unsigned int i;
+
+	mutex_lock(&concat_lock);
+	list_for_each_entry(item, &concat_node_list, node) {
+		if (item->device) {
+			mtd_concat_disconnect(item->device->mtd);
+			list_add_tail(&item->device->node, &devices);
+			item->device = NULL;
+		}
+		for (i = 0; i < item->count; i++) {
+			if (item->parts[i].mtd)
+				mtd_virt_concat_part_put(item->parts[i].mtd);
+			item->parts[i].mtd = NULL;
+			item->parts[i].ready = false;
+		}
+	}
+	mutex_unlock(&concat_lock);
+	mtd_virt_concat_unregister(&devices);
+}
 
-	list_for_each_entry_safe(item, temp, &concat_node_list, head) {
-		for (i = 0; i < item->count; i++)
-			of_node_put(item->nodes[i]);
+void mtd_virt_concat_destroy_items(void)
+{
+	struct mtd_virt_concat_node *item, *next;
 
-		kfree(item);
+	guard(mutex)(&concat_lock);
+	list_for_each_entry_safe(item, next, &concat_node_list, node) {
+		list_del(&item->node);
+		mtd_virt_concat_free_item(item);
 	}
 }
 
-/**
- * mtd_virt_concat_add - Add a mtd device to the concat list
- * @mtd:        pointer to 'mtd_info'
- *
- * Return: true on success, false otherwise.
- */
-bool mtd_virt_concat_add(struct mtd_info *mtd)
+int mtd_virt_concat_add(struct mtd_info *mtd)
 {
+	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_virt_concat_node *item;
-	struct mtd_concat *concat;
-	int idx;
-
-	list_for_each_entry(item, &concat_node_list, head) {
-		concat = item->concat;
-		for (idx = 0; idx < item->count; idx++) {
-			if (item->nodes[idx] == mtd_get_of_node(mtd)) {
-				concat->subdev[concat->num_subdev++] = mtd;
-				return true;
+	unsigned int i;
+
+	guard(mutex)(&concat_lock);
+	list_for_each_entry(item, &concat_node_list, node) {
+		for (i = 0; i < item->count; i++) {
+			struct mtd_virt_concat_part *part = &item->parts[i];
+
+			if (part->node != mtd_get_of_node(mtd))
+				continue;
+			if (part->mtd)
+				return -EBUSY;
+			kref_init(&mtd->refcnt);
+			/* The master need not have a registered device. */
+			if (master->master.release) {
+				mtd_get_lifetime(master);
+				mtd->ref_master = master;
+				if (mtd->parent != master)
+					mtd_get_data(mtd->parent);
 			}
+			of_node_get(mtd_get_of_node(mtd));
+			part->mtd = mtd;
+			return 1;
 		}
 	}
-	return false;
+	return 0;
 }
 
-/**
- * mtd_virt_concat_node_create - List all the concatenations found in DT
- *
- * Return: 0 on success, -error otherwise.
- */
 int mtd_virt_concat_node_create(void)
 {
-	struct device_node *parts = NULL;
-	int ret = 0, count = 0;
+	struct device_node *node;
+	int ret, count;
 
-	/* List all the concatenations found in DT */
-	do {
-		parts = of_find_node_with_property(parts, CONCAT_PROP);
-		if (!of_device_is_available(parts))
+	guard(mutex)(&concat_lock);
+	for_each_node_with_property(node, CONCAT_PROP) {
+		if (!of_device_is_available(node) || mtd_is_part_concat(node))
 			continue;
-
-		if (mtd_is_part_concat(parts))
-			continue;
-
-		count = of_count_phandle_with_args(parts, CONCAT_PROP, NULL);
-		if (count < MIN_DEV_PER_CONCAT)
+		count = of_count_phandle_with_args(node, CONCAT_PROP, NULL);
+		if (count < 1)
 			continue;
-
-		/*
-		 * The partition in which "part-concat-next" property is defined
-		 * is also part of the concat device, so increament count by 1.
-		 */
-		count++;
-
-		ret = mtd_virt_concat_create_item(parts, count);
+		ret = mtd_virt_concat_create_item(node, count + 1);
 		if (ret) {
-			of_node_put(parts);
-			goto destroy_items;
+			of_node_put(node);
+			return ret;
 		}
-	} while (parts);
+	}
+	return 0;
+}
 
+static int mtd_virt_concat_register(struct mtd_virt_concat_node *item)
+{
+	struct mtd_virt_concat_device *device;
+	struct mtd_info **parts, *mtd;
+	size_t name_size = sizeof("concat");
+	unsigned int i;
+	char *name, *p;
+	int ret;
+
+	parts = kmalloc_array(item->count, sizeof(*parts), GFP_KERNEL);
+	if (!parts)
+		return -ENOMEM;
+	for (i = 0; i < item->count; i++) {
+		parts[i] = item->parts[i].mtd;
+		name_size += strlen(parts[i]->name) + 1;
+	}
+	name = kmalloc(name_size, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out_parts;
+	}
+	p = name;
+	for (i = 0; i < item->count; i++)
+		p += sprintf(p, "%s-", parts[i]->name);
+	strscpy(p, "concat", name_size - (p - name));
+	device = kzalloc_obj(*device);
+	if (!device) {
+		ret = -ENOMEM;
+		goto out_name;
+	}
+	mtd = mtd_concat_create(parts, item->count, name);
+	if (!mtd) {
+		ret = -ENXIO;
+		goto out_device;
+	}
+	for (i = 0; i < item->count; i++)
+		kref_get(&parts[i]->refcnt);
+	mtd->parent_dev = parts[0]->parent_dev;
+	mtd_set_of_node(mtd, mtd_get_of_node(parts[0]));
+	mtd->owner = THIS_MODULE;
+	mtd->priv = device;
+	mtd_set_dev_defaults(mtd);
+	lockdep_set_class(&mtd->master.partitions_lock, &concat_partitions_lock_key);
+	mtd_set_release(mtd, mtd_virt_concat_release);
+	device->mtd = mtd;
+	ret = add_mtd_device(mtd);
+	if (ret)
+		mtd_put_master(mtd);
+	else
+		item->device = device;
+	kfree(parts);
 	return ret;
 
-destroy_items:
-	mtd_virt_concat_destroy_items();
-
+out_device:
+	kfree(device);
+out_name:
+	kfree(name);
+out_parts:
+	kfree(parts);
 	return ret;
 }
 
-/**
- * mtd_virt_concat_create_join - Create and register the concatenated
- *                                 MTD device.
- *
- * Return: 0 on success, -error otherwise.
- */
-int mtd_virt_concat_create_join(void)
+int mtd_virt_concat_create_join(struct mtd_info *master)
 {
 	struct mtd_virt_concat_node *item;
-	struct mtd_concat *concat;
-	struct mtd_info *mtd;
-	ssize_t name_sz;
-	int ret, idx;
-	char *name;
-
-	list_for_each_entry(item, &concat_node_list, head) {
-		concat = item->concat;
-		/*
-		 * Check if item->count != concat->num_subdev, it indicates
-		 * that the MTD information for all devices included in the
-		 * concatenation are not handy, concat MTD device can't be
-		 * created hence switch to next concat device.
-		 */
-		if (item->count != concat->num_subdev) {
-			continue;
-		} else {
-			/* Calculate the legth of the name of the virtual device */
-			for (idx = 0, name_sz = 0; idx < concat->num_subdev; idx++)
-				name_sz += (strlen(concat->subdev[idx]->name) + 1);
-			name_sz += strlen(CONCAT_POSTFIX);
-			name = kmalloc(name_sz + 1, GFP_KERNEL);
-			if (!name) {
-				mtd_virt_concat_put_mtd_devices(concat);
-				return -ENOMEM;
-			}
+	unsigned int i;
+	int ret;
 
-			ret = 0;
-			for (idx = 0; idx < concat->num_subdev; idx++) {
-				ret += sprintf((name + ret), "%s-",
-					       concat->subdev[idx]->name);
-			}
-			sprintf((name + ret), CONCAT_POSTFIX);
-
-			if (concat->mtd.name) {
-				ret = memcmp(concat->mtd.name, name, name_sz);
-				if (ret == 0) {
-					kfree(name);
-					continue;
-				}
-			}
-			mtd = mtd_concat_create(concat->subdev, concat->num_subdev, name);
-			if (!mtd) {
-				kfree(name);
-				return -ENXIO;
+	guard(mutex)(&concat_lock);
+	list_for_each_entry(item, &concat_node_list, node) {
+		bool ready = true, includes_master = false;
+
+		for (i = 0; i < item->count; i++) {
+			struct mtd_virt_concat_part *part = &item->parts[i];
+
+			if (part->mtd && mtd_get_master(part->mtd) == master) {
+				part->ready = true;
+				includes_master = true;
 			}
-			concat->mtd = *mtd;
-			/* Arbitrary set the first device as parent */
-			concat->mtd.parent_dev = concat->subdev[0]->parent_dev;
-			mtd_set_of_node(&concat->mtd, mtd_get_of_node(concat->subdev[0]));
-
-			/* Add the mtd device */
-			ret = add_mtd_device(&concat->mtd);
-			if (ret)
-				goto destroy_concat;
+			ready &= part->ready;
 		}
+		if (!ready || !includes_master || item->device)
+			continue;
+		ret = mtd_virt_concat_register(item);
+		if (ret)
+			return ret;
 	}
-
 	return 0;
-
-destroy_concat:
-	mtd_concat_destroy(mtd);
-
-	return ret;
 }
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index c97167d51fe2..0ac248c61fb1 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -46,6 +46,10 @@ concat_read(struct mtd_info *mtd, loff_t from, size_t len,
 	int ret = 0, err;
 	int i;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		size_t size, retsize;
@@ -97,6 +101,11 @@ concat_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct mtd_concat *concat = CONCAT(mtd);
 	int err = -EINVAL;
 	int i;
+
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		size_t size, retsize;
@@ -139,6 +148,10 @@ concat_write(struct mtd_info *mtd, loff_t to, size_t len,
 	int err = -EINVAL;
 	int i;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		size_t size, retsize;
@@ -180,6 +193,10 @@ concat_writev(struct mtd_info *mtd, const struct kvec *vecs,
 	int i;
 	int err = -EINVAL;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	/* Calculate total length of data */
 	for (i = 0; i < count; i++)
 		total_len += vecs[i].iov_len;
@@ -251,6 +268,10 @@ concat_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 	struct mtd_oob_ops devops = *ops;
 	int i, err, ret = 0;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	ops->retlen = ops->oobretlen = 0;
 
 	for (i = 0; i < concat->num_subdev; i++) {
@@ -308,6 +329,10 @@ concat_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops)
 	struct mtd_oob_ops devops = *ops;
 	int i, err;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	if (!(mtd->flags & MTD_WRITEABLE))
 		return -EROFS;
 
@@ -356,6 +381,10 @@ static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
 	uint64_t length, offset = 0;
 	struct erase_info *erase;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	/*
 	 * Check for proper erase block alignment of the to-be-erased area.
 	 * It is easier to do this based on the super device's erase
@@ -472,6 +501,10 @@ static int concat_xxlock(struct mtd_info *mtd, loff_t ofs, uint64_t len,
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i, err = -EINVAL;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		uint64_t size;
@@ -519,6 +552,10 @@ static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i, err = -EINVAL;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 
@@ -541,6 +578,10 @@ static void concat_sync(struct mtd_info *mtd)
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		mtd_sync(subdev);
@@ -552,6 +593,10 @@ static int concat_suspend(struct mtd_info *mtd)
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i, rc = 0;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return 0;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		if ((rc = mtd_suspend(subdev)) < 0)
@@ -565,6 +610,10 @@ static void concat_resume(struct mtd_info *mtd)
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 		mtd_resume(subdev);
@@ -576,6 +625,10 @@ static int concat_block_isbad(struct mtd_info *mtd, loff_t ofs)
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i, res = 0;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	if (!mtd_can_have_bb(concat->subdev[0]))
 		return res;
 
@@ -599,6 +652,10 @@ static int concat_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	struct mtd_concat *concat = CONCAT(mtd);
 	int i, err = -EINVAL;
 
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+
 	for (i = 0; i < concat->num_subdev; i++) {
 		struct mtd_info *subdev = concat->subdev[i];
 
@@ -616,6 +673,33 @@ static int concat_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	return err;
 }
 
+static int concat_ooblayout_ecc(struct mtd_info *mtd, int section,
+			      struct mtd_oob_region *region)
+{
+	struct mtd_concat *concat = CONCAT(mtd);
+
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+	return mtd_ooblayout_ecc(concat->subdev[0], section, region);
+}
+
+static int concat_ooblayout_free(struct mtd_info *mtd, int section,
+			       struct mtd_oob_region *region)
+{
+	struct mtd_concat *concat = CONCAT(mtd);
+
+	guard(srcu_fast)(&concat->srcu);
+	if (READ_ONCE(concat->disconnected))
+		return -ENODEV;
+	return mtd_ooblayout_free(concat->subdev[0], section, region);
+}
+
+static const struct mtd_ooblayout_ops concat_ooblayout_ops = {
+	.ecc = concat_ooblayout_ecc,
+	.free = concat_ooblayout_free,
+};
+
 /*
  * This function constructs a virtual MTD device by concatenating
  * num_devs MTD devices. A pointer to the new device object is
@@ -738,7 +822,8 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 
 	}
 
-	mtd_set_ooblayout(&concat->mtd, subdev[0]->ooblayout);
+	if (mtd_get_master(subdev[0])->ooblayout)
+		mtd_set_ooblayout(&concat->mtd, &concat_ooblayout_ops);
 
 	concat->num_subdev = num_devs;
 	concat->mtd.name = name;
@@ -877,13 +962,29 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 		erase_region_p->numblocks = tmp64;
 	}
 
+	if (init_srcu_struct_fast(&concat->srcu)) {
+		kfree(concat->mtd.eraseregions);
+		kfree(concat);
+		return NULL;
+	}
 	return &concat->mtd;
 }
 
+void mtd_concat_disconnect(struct mtd_info *mtd)
+{
+	struct mtd_concat *concat = CONCAT(mtd);
+
+	WRITE_ONCE(concat->disconnected, true);
+	synchronize_srcu(&concat->srcu);
+}
+EXPORT_SYMBOL_GPL(mtd_concat_disconnect);
+
 /* Cleans the context obtained from mtd_concat_create() */
 void mtd_concat_destroy(struct mtd_info *mtd)
 {
 	struct mtd_concat *concat = CONCAT(mtd);
+
+	cleanup_srcu_struct(&concat->srcu);
 	if (concat->mtd.numeraseregions)
 		kfree(concat->mtd.eraseregions);
 	kfree(concat);
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index dd404d36156e..5c6097051adf 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1209,7 +1209,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		goto out;
 
 	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
-		ret = mtd_virt_concat_create_join();
+		ret = mtd_virt_concat_create_join(mtd);
 		if (ret < 0)
 			goto out;
 	}
@@ -1230,6 +1230,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 
 out:
 	if (ret) {
+		del_mtd_partitions(mtd);
 		nvmem_unregister(mtd->otp_user_nvmem);
 		nvmem_unregister(mtd->otp_factory_nvmem);
 	}
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 58d134347691..45957ff991ba 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -93,6 +93,7 @@ static struct mtd_info *allocate_partition(struct mtd_info *parent,
 	child->parent = parent;
 	child->part.offset = part->offset;
 	INIT_LIST_HEAD(&child->partitions);
+	INIT_LIST_HEAD(&child->part.node);
 
 	if (child->part.offset == MTDPART_OFS_APPEND)
 		child->part.offset = cur_offset;
@@ -324,6 +325,9 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 	struct mtd_info *child, *next;
 	int err;
 
+	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT))
+		mtd_virt_concat_destroy(mtd);
+
 	list_for_each_entry_safe(child, next, &mtd->partitions, part.node) {
 		err = __mtd_del_partition(child);
 		if (err)
@@ -375,6 +379,8 @@ int del_mtd_partitions(struct mtd_info *mtd)
 	pr_info("Deleting MTD partitions on \"%s\":\n", mtd->name);
 
 	mutex_lock(&master->master.partitions_lock);
+	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT))
+		mtd_virt_concat_destroy(mtd);
 	ret = __del_mtd_partitions(mtd);
 	mutex_unlock(&master->master.partitions_lock);
 
@@ -434,7 +440,13 @@ int add_mtd_partitions(struct mtd_info *parent,
 		}
 
 		if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
-			if (mtd_virt_concat_add(child)) {
+			ret = mtd_virt_concat_add(child);
+			if (ret < 0) {
+				free_partition(child);
+				goto err_unlock;
+			}
+			if (ret) {
+				cur_offset = child->part.offset + child->part.size;
 				mutex_unlock(&master->master.partitions_lock);
 				continue;
 			}
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index f8d4d6ac1fc1..af30d338fee4 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -8,6 +8,7 @@
 #ifndef MTD_CONCAT_H
 #define MTD_CONCAT_H
 
+#include <linux/srcu.h>
 
 /*
  * Our storage structure:
@@ -17,6 +18,8 @@
  */
 struct mtd_concat {
 	struct mtd_info mtd;
+	struct srcu_struct srcu;
+	bool disconnected;
 	int num_subdev;
 	struct mtd_info *subdev[];
 };
@@ -27,6 +30,7 @@ struct mtd_info *mtd_concat_create(
     const char *name);          /* name for the new device   */
 
 void mtd_concat_destroy(struct mtd_info *mtd);
+void mtd_concat_disconnect(struct mtd_info *mtd);
 
 /**
  * mtd_virt_concat_node_create - Create a component for concatenation
@@ -43,23 +47,23 @@ int mtd_virt_concat_node_create(void);
  * mtd_virt_concat_add - add mtd_info object to the list of subdevices for concatenation
  * @mtd: pointer to new MTD device info structure
  *
- * Returns true if the mtd_info object is added successfully else returns false.
+ * Returns 1 if added, 0 if not a component, or a negative error code.
  *
  * The mtd_info object is added to the list of subdevices for concatenation.
- * It returns true if a match is found, and false if all subdevices have
- * already been added or if the mtd_info object does not match any of the
- * intended MTD devices.
+ * A duplicate component is rejected; the caller retains ownership on error
+ * or when the partition does not match a concatenation.
  */
-bool mtd_virt_concat_add(struct mtd_info *mtd);
+int mtd_virt_concat_add(struct mtd_info *mtd);
 
 /**
  * mtd_virt_concat_create_join - Create and register the concatenated MTD device
+ * @master: master whose partition registration has completed
  *
  * Returns 0 on succes, or a negative error code.
  *
  * Creates and registers the concatenated MTD device
  */
-int mtd_virt_concat_create_join(void);
+int mtd_virt_concat_create_join(struct mtd_info *master);
 
 /**
  * mtd_virt_concat_destroy - Remove the concat that includes a specific mtd device
@@ -68,9 +72,9 @@ int mtd_virt_concat_create_join(void);
  *
  * Returns 0 on succes, or a negative error code.
  *
- * If the mtd_info object is part of a concatenated device, all other MTD devices
- * within that concat are registered individually. The concatenated device is then
- * removed, along with its concatenation component.
+ * Unregister concatenations containing this device or its partitions and
+ * release its staged components. Components of other masters remain staged
+ * for a later rebind. Acquired handles retain disconnected concat metadata.
  *
  */
 int mtd_virt_concat_destroy(struct mtd_info *mtd);

-- 
2.53.0

