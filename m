Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296666;
	b=v4vv1wBubPSe6a83qgNFfZjYKNmm0YHWUWLS4ikIOts39tPfyagWhJpSLNsKBH1pRxPe
	 XEGO1aSw/c74Z59RXpjiwQYCtcCNfG/Mg7HHUygm9A7BqCoasfJuPJsnwJyOI8yxW/OA2
	 vSGeFeR2LOCEzb+2D8+v6SfB6BtGVfE3e+iF4YZf5AjPLDmsak87gAaGEECFpZRVKI60E
	 jhYe5fX3np1cJzldKvDaE93S2OR7D7VRW06Y5RAYOZkDxrPaBSSd67p/8f2YNGT2KHI0l
	 NNt6WYK8cqyc+Mdh1I4xnj3YQHDNNFr9oSsBGY62/yTG7pXAgc1cOjfpHD4RiSeBIJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gNFIlffp+xCXHMSgggtE3viuHIzA+ozjxJnoIY1lKGM=;
	b=AKNnCqR3N6YFdnyvNVS9EWr7Mgh3ZNfyZFQN4SVPpZAyDgFNMhd4R+g29/d0uYdpZglB
	 T5xQZm4I2jRSvVcpcAe0B9fqbLKfazPT1/+E0we6kGxmJ0LB5DaakXnjvPMl5AXbQEcLa
	 6JFgcCUjrR5wVv3ztK4ovhALHdlePURcVnvBCNSFhmla/Ngo/oZhsBuNFHAz1oeDaOOAC
	 qBMfJfRXp2E401dR44AJdvlytkAxVgfTFUAZ6n6zbe65aPf4rsixcJPkTetg4Gx9MqABx
	 mmEc6SZzgqagJLhb4stmM8lbM+AtCysvg4V4pFXJvUwfN2ejcuDKt4tXsme95bGvD1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yXsmYaRa;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74960A2605
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 07:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA74960A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yXsmYaRa
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-51f2e9e6987so1035407b6e.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Nov 2026 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296665; x=1794901465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNFIlffp+xCXHMSgggtE3viuHIzA+ozjxJnoIY1lKGM=;
        b=yXsmYaRafpDpxn1uwY8YfEGhuAWKZpX8ouj7rInQOhEim8OXrGdGfLiUEHH2w0MGSY
         rsZKjE+xw6E8cqsS0v2YQASTH51Rke1yhPMGqy5X5EQ5UHiwePQSbB+4xP3lj0pwPM8T
         mzKnULYAEndmyjbhgNz40M8EQJPdDYjBegpCQ/GgOvhIuPk5sDtk13si1T+lGsGFq78d
         fc3O3LLtaGYtskuEx8Tovjcbpv9CiTy5Wg6wjQSW0TiRr5/O3rCcNnk314K3Sr0YE/TL
         xesAitEb4OWitblctjqXCsi95FogXxvWrDKlftU+l1/0ulK32LxQdaHG9frkoLEZWMn3
         bN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296665; x=1794901465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNFIlffp+xCXHMSgggtE3viuHIzA+ozjxJnoIY1lKGM=;
        b=m4rky4Nxj6pinusPJYaNMDQd1cO4RnkyYP7CyB3lJg1Hxw9xtIhRGSwbOMaW+mqfX7
         IIr5V0tZFNa6anqRTHCUbRGGcjYVGci4Zv77B7b/LgNGbj5IiyqtIYQ6MD4BG6x2qzpw
         zZmSA7xJsgGT6GuINsBeW5hMl+uHJqOkvYEY2/D0bUQ6I7WQxYC6LTARzsOHy79Vo8BB
         GJezKw4taxf5q7cUrGc6oc486N3JO6JmQ36oxsiW75QvRM2lTkbLYDXiOSHzoaGhxtqi
         1ap2LU+HkCcoB3XndjjGPkA1d5PMef7daNaJ6qcMx9Skty1KgSw9xPtJahl5CUWjx0na
         PUdQ==
X-Forwarded-Encrypted: i=1; AL+hErGkcakyVAD9nXhePDxJe/pDfB3fLhZjN1h4G10G+2tp8sOxqPvT+TsYpwSKSsQ2UwqxPm7V1zJnAC5t0Xfydms=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pfyOYMdlEMwaOesp4HMWGsE7864Mg7oU7Vron8gOxT4Jr2BuN
	XbBktHcOt1JLh3cHltI2M1VatyFvffm6PyPuZKCbinBGLPozwYivw8kiupFBJVMU
X-Gm-Gg: AYBFou1R5dNqFDCUNuHFbkRVLUcuMtL3lC13g27ZYs9uCn3rMvgttFpDrK2ED8xXtup
	qXiJXU7E8nVVrNtlxbJfqFJcX5LsXqXZxqEJ9rl9HHEo1vgwAujbY4JJG6r9t+6HPBHlsQn7S0X
	HXuE6N7ICjS8B6IgbVeGVeiguAqZSdQxuFXJHcUu/j47L2lN+jtdtzLBb7XOUW1gLz+K43ljWX7
	DeCY4nOoi2TM+3rH9D6LLIFtWTL3ywF6EJn4FTeRFzRfaP6/EFxespf/exGfXv6CDpSzA5NSQOL
	GpEeNX+Ez8fK+6Qu5G3n0Iq3IhlecrwYIg//Sy+RbQrVt5u5jD1U2gdNZJ2fEaTUeYLnOAUejNa
	ytRBwM77nUYJ+UG6wFpfTW9onow8/osfdc03Vq3LYeKkcceY+W8Pv//VLm2NR2Z7nZgipXHM6lQ
	hmf1hM2Ao6WYcvbg0mtnmLCMlO5EFOYyo40ztzBeopn4fvWL4sRbI/3VFFRmnkPAANr7A/Xfl7a
	c2tO0huILOoNDqD/+qqriN6JuOIWIFW7LOtmzTiCy1r9GlcDoHJhxmXjo94xTxsTPGIWDIxhcaF
	bgPvR3R6b27FEeZ4j3xgCN2xNxYQnlCn98zVU4JFmiXGNEPtBr6mVSR48SxdWaZl2Y3ibmliDFO
	Z14BQ4Yu7KnKoqToKMjniBeeHGMYuFB1KBfTDCSYRPUltGZra1Oq0gFK9zF9/1xjKeL13rPyNRC
	g9uX83SB/8/OL3AjbdTvH6E7gmGHQUCW6CwjVv3l9o10/LOdtpKXs=
X-Received: by 2002:a05:6808:14c4:b0:564:3fe1:2f9a with SMTP id 5614622812f47-568728d2850mr905382b6e.17.1794296664567;
        Mon, 09 Nov 2026 23:44:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504fdb5sm1522804b6e.3.2026.11.09.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:44:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 10 Nov 2026 00:44:07 -0700
Subject: [PATCH v2 04/58] mtd: retain virtual concatenations across
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
Message-Id: <20261110-submit-rawnand-retained-handle-lifetime-v1-v2-4-9137d08f05df@gmail.com>
References: <20261110-submit-rawnand-retained-handle-lifetime-v1-v2-0-9137d08f05df@gmail.com>
In-Reply-To: <20261110-submit-rawnand-retained-handle-lifetime-v1-v2-0-9137d08f05df@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Yuqiang Sun <izaiahsun@gmail.com>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bernhard Frauendienst <kernel@nospam.obeliks.de>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2

Virtual concatenation keeps unregistered partition objects outside the
normal partition list. They neither retain their backing masters nor get
removed by partition-registration failure cleanup. The teardown path also
compares a master against its hidden children, leaving stale pointers when
one of the physical devices disappears.

Give staged components explicit ownership of their backing objects and
retain each published concatenation's component set until its final MTD
release. Register the object returned by mtd_concat_create() directly,
instead of copying its embedded device. An old handle then continues to
refer to its original components after a replacement master is probed.

Serialize the staging list and publication across physical controllers.
Store components in DT order and publish only after every contributing
master finishes partition registration. Detach affected joins while holding
the staging lock, then unregister them without it. Use a separate partition
lock class for virtual masters so a physical partition can remove its joins
without nesting locks from the same class.

Unwind hidden components along with ordinary partitions on registration
failure. Keep the other masters' staged components available for a later
probe, and advance the partition offset past a hidden component before
processing an appended partition.

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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtd_virt_concat.c | 513 +++++++++++++++++++++---------------------
 drivers/mtd/mtdcore.c         |   9 +-
 drivers/mtd/mtdcore.h         |   3 +
 drivers/mtd/mtdpart.c         |  14 +-
 include/linux/mtd/concat.h    |  18 +-
 5 files changed, 283 insertions(+), 274 deletions(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index da4277ced4d6..1c797a4afb9b 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -7,346 +7,339 @@
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
+	struct mtd_info *master = mtd_get_master(mtd);
+	struct mtd_info *parent = mtd->parent;
+
+	of_node_put(mtd_get_of_node(mtd));
+	release_mtd_partition(mtd);
+	if (parent != master)
+		put_device(&parent->dev);
+	mtd_put_lifetime(master);
+}
+
+static void mtd_virt_concat_part_put(struct mtd_info *mtd)
+{
+	kref_put(&mtd->refcnt, mtd_virt_concat_part_release);
+}
+
+static void mtd_virt_concat_release(struct mtd_info *mtd)
 {
+	struct mtd_concat *concat = container_of(mtd, struct mtd_concat, mtd);
 	int i;
 
 	for (i = 0; i < concat->num_subdev; i++)
-		put_mtd_device(concat->subdev[i]);
+		mtd_virt_concat_part_put(concat->subdev[i]);
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
-		}
+	list_for_each_entry_safe(device, next, devices, node) {
+		list_del(&device->node);
+		mtd_device_unregister(device->mtd);
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
-			if (item->nodes[idx] == mtd->dev.of_node) {
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
-			if (child->dev.of_node != mtd->dev.of_node) {
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
+	unsigned int i, j;
 
-	for (i = 0; i < (count - 1); i++) {
-		if (mtd_is_part_concat(of_parse_phandle(parts, CONCAT_PROP, i)))
-			return 0;
-	}
-
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
+	for (i = 1; i < count; i++) {
+		struct device_node *part = of_parse_phandle(node, CONCAT_PROP, i - 1);
 
-	for (i = 1; i < count; i++)
-		item->nodes[i] = of_parse_phandle(parts, CONCAT_PROP, (i - 1));
-
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
 	struct mtd_virt_concat_node *item;
-	struct mtd_concat *concat;
-	int idx;
-
-	list_for_each_entry(item, &concat_node_list, head) {
-		concat = item->concat;
-		for (idx = 0; idx < item->count; idx++) {
-			if (item->nodes[idx] == mtd->dev.of_node) {
-				concat->subdev[concat->num_subdev++] = mtd;
-				return true;
-			}
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
+			mtd_get_lifetime(mtd_get_master(mtd));
+			if (mtd->parent != mtd_get_master(mtd))
+				get_device(&mtd->parent->dev);
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
+	mtd->dev.parent = parts[0]->dev.parent;
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
-			concat->mtd.dev.parent = concat->subdev[0]->dev.parent;
-			concat->mtd.dev = concat->subdev[0]->dev;
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
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 1c31e2a5fbe0..63feb4c9b8b0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -111,13 +111,13 @@ static void mtd_master_release(struct kref *ref)
 		module_put(owner);
 }
 
-static void mtd_get_lifetime(struct mtd_info *master)
+void mtd_get_lifetime(struct mtd_info *master)
 {
 	if (master->master.release)
 		kref_get(&master->master.life_refcnt);
 }
 
-static void mtd_put_lifetime(struct mtd_info *master)
+void mtd_put_lifetime(struct mtd_info *master)
 {
 	if (master->master.release)
 		kref_put(&master->master.life_refcnt, mtd_master_release);
@@ -1016,7 +1016,7 @@ int del_mtd_device(struct mtd_info *mtd)
  * Set a few defaults based on the parent devices, if not provided by the
  * driver
  */
-static void mtd_set_dev_defaults(struct mtd_info *mtd)
+void mtd_set_dev_defaults(struct mtd_info *mtd)
 {
 	if (mtd->dev.parent) {
 		if (!mtd->owner && mtd->dev.parent->driver)
@@ -1289,7 +1289,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		goto out;
 
 	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
-		ret = mtd_virt_concat_create_join();
+		ret = mtd_virt_concat_create_join(mtd);
 		if (ret < 0)
 			goto out;
 	}
@@ -1310,6 +1310,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 
 out:
 	if (ret) {
+		del_mtd_partitions(mtd);
 		nvmem_unregister(mtd->otp_user_nvmem);
 		nvmem_unregister(mtd->otp_factory_nvmem);
 	}
diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b014861a06a6..232cceeb5742 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -10,6 +10,9 @@ extern struct backing_dev_info *mtd_bdi;
 struct mtd_info *__mtd_next_device(int i);
 int __must_check add_mtd_device(struct mtd_info *mtd);
 int del_mtd_device(struct mtd_info *mtd);
+void mtd_set_dev_defaults(struct mtd_info *mtd);
+void mtd_get_lifetime(struct mtd_info *master);
+void mtd_put_lifetime(struct mtd_info *master);
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
 int del_mtd_partitions(struct mtd_info *);
 void release_mtd_partition(struct mtd_info *mtd);
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index c316cfe92c7e..bcbe8772d464 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -323,6 +323,9 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 	struct mtd_info *child, *next;
 	int err;
 
+	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT))
+		mtd_virt_concat_destroy(mtd);
+
 	list_for_each_entry_safe(child, next, &mtd->partitions, part.node) {
 		err = __mtd_del_partition(child);
 		if (err)
@@ -374,6 +377,8 @@ int del_mtd_partitions(struct mtd_info *mtd)
 	pr_info("Deleting MTD partitions on \"%s\":\n", mtd->name);
 
 	mutex_lock(&master->master.partitions_lock);
+	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT))
+		mtd_virt_concat_destroy(mtd);
 	ret = __del_mtd_partitions(mtd);
 	mutex_unlock(&master->master.partitions_lock);
 
@@ -426,8 +431,15 @@ int add_mtd_partitions(struct mtd_info *parent,
 		}
 
 		if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
-			if (mtd_virt_concat_add(child))
+			ret = mtd_virt_concat_add(child);
+			if (ret < 0) {
+				free_partition(child);
+				goto err_del_partitions;
+			}
+			if (ret) {
+				cur_offset = child->part.offset + child->part.size;
 				continue;
+			}
 		}
 
 		mutex_lock(&master->master.partitions_lock);
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index f8d4d6ac1fc1..0ba048688b15 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -43,23 +43,23 @@ int mtd_virt_concat_node_create(void);
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
@@ -68,9 +68,9 @@ int mtd_virt_concat_create_join(void);
  *
  * Returns 0 on succes, or a negative error code.
  *
- * If the mtd_info object is part of a concatenated device, all other MTD devices
- * within that concat are registered individually. The concatenated device is then
- * removed, along with its concatenation component.
+ * Unregister concatenations containing this device or its partitions and
+ * release its staged components. Components of other masters remain staged
+ * for a later rebind. Acquired handles retain their original component set.
  *
  */
 int mtd_virt_concat_destroy(struct mtd_info *mtd);

-- 
2.53.0

