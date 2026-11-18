Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005853;
	b=xkn84OoRJTThghTtcthBLAQdNErMfEQZxaxG8vKla2KRzmfhU23X7YXNJQ6pWylVGjKY
	 pi23L5XuFaQaOBlwacg3FNhnJ53iY9tL0nVq6ycaBZE2P8q8F4iTkKjyYbSD+O+bLRdWb
	 qJJOmhlrd1K0DcmlBm02390bNMKstIo3LGMenNC42dRNBlhbhY5ZsNkDmG4ywlH7Xa3hx
	 lZKPwDHu+d5cedHzAHtajy/s8yZXJmyYj6Vy20KAzZoV8jMU5M3Ls+cirabMGHi4wLq6i
	 Hao0bYFJQmEv04LK4GnCHdTQIyM7vHvVwj+uDhQ45mu1PXXS2iVQD9kkuPZyupFANRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005853;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=D3o0EuRXIdQnK3LLdhyAHrL4ChLMnaQWvqz7xNe+GdE=;
	b=lTRmsLZ7UNm5TNqNDqc8cv83Ss2jTTieWy3STIPoYLmJKmXRaFPmL9FAHVxEx3+6Gc0g
	 VQr1kwQCr2bekqZsZag8Q5gowttiKik0Yp0KSHR5nzcjclXDaupCmks6EHc7Pax9/k01w
	 S6BYXmsg/L7xvjZ2u6TG7nbdPoQInJHULeetyiLOlrUeB3HBRcO7bvXSkgb29baOsRdL5
	 ZrFDphpaLkgywOZzfZGvwScVxzDE9qNdTqxvSF4PAkW8xWBDwK5wi/PT7gPQXYpHFAhFF
	 U8n4DpLW5swoCedB1XhjqfSopZjrb3lzAYZxKBSMQpjgFctTkn4RZiCaeHaiaQVSDsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOYcedZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23960A2608;
	Wed, 18 Nov 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOYcedZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63BD1F000C5;
	Wed, 18 Nov 2026 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005853;
	bh=D3o0EuRXIdQnK3LLdhyAHrL4ChLMnaQWvqz7xNe+GdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OOYcedZQMmJRh+JOiUDUUHUEecDD7/7Jo7+QJzJtLsjSX4S9wDAVcPXCJys7dM8z5
	 OfzLTjwci4YwyoDUPyFM/lMCYaDFTJ9cC9waH26arhqP+omBOh1AbK9lIav3kPPDwB
	 hRE3z3LQDnQxZEp2EDun4T2vfAdPTw6qQdNNtLZ+XX7uBZdsxHz7HF/EiXIaUChcol
	 H25gbzUlrTn8tWql6P1pykRzKgHBrzvbXV6JXOcuFw19K7RlRIR3m/KHhr77m6mdAD
	 G6kEXnXKdCgvlzGNdS6umXfCJaf6vfr1fsd1IU+OMGYPHaNQ+6slyMSgW8UYk3gfHK
	 dxOapq8hOHnKg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:50 +0100
Subject: [PATCH RFC v2 06/16] media: mc: Maintain a list of open file
 handles in a media device
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
Message-Id: <20261118-v4l2-sensor-detect-v2-6-1bb1a445b556@kernel.org>
References: <20261118-v4l2-sensor-detect-v2-0-1bb1a445b556@kernel.org>
In-Reply-To: <20261118-v4l2-sensor-detect-v2-0-1bb1a445b556@kernel.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andy Walls <awalls@md.metrocast.net>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nicolas Dufresne <nicolas.dufres@collabora.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5545;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=8aVhvo96LkSyDDH5whLqXiYmArPAx/MWFMUrU/cHnS4=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2LRuRZmSmBNUr1M+PAeO21nUzWxIFlKclpZ
 ae9/iecme+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2diwAKCRAZDR20Zk4Z
 NQkJB/40c/oqvK98LG95C5V7A2HbauY3Mtj1YGN9hGfBl4lpb+0cmW/88HhqWWzm7g0Rt4+Vec1
 1zwyiNCWMwiLnQ4pbQAN0PMmTDpetXuWYOVU/uboV0o2bbZaiMrQJTnhr3tZ6eQ86VSAOIEwjPR
 Jiv9Rhjik6oKp1R9KWpEiWYN50IJSr22eVERwcaKraNfXCkoUmupPfF9L9otzC1SqdFKeYttcKg
 Cgbn+PYEd7kmgl1xfn7XB7D0/nFPMHaxIUEhI/BLrB5fU0ohbG/0GM/54j67Hy8U4WLyLZ6LYjD
 6zh6oV6hf2QPpbCCMiLdcN7SJxaxllqAMDqo6qriw9S6THIq
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

The list of file handles is needed to deliver media events in the future.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/mc/mc-device.c | 35 +++++++++++++++++++++++++----------
 include/media/media-device.h |  7 +++++++
 include/media/media-fh.h     | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 8d0c35a11944..b64322efd99e 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -22,6 +22,7 @@
 #include <media/media-device.h>
 #include <media/media-devnode.h>
 #include <media/media-entity.h>
+#include <media/media-fh.h>
 #include <media/media-request.h>
 
 #ifdef CONFIG_MEDIA_CONTROLLER
@@ -35,16 +36,6 @@
 #define MEDIA_ENT_SUBTYPE_MASK			0x0000ffff
 #define MEDIA_ENT_T_DEVNODE_UNKNOWN		(MEDIA_ENT_F_OLD_BASE | \
 						 MEDIA_ENT_SUBTYPE_MASK)
-
-struct media_device_fh {
-	struct media_devnode_fh fh;
-};
-
-static inline struct media_device_fh *media_device_fh(struct file *filp)
-{
-	return container_of(filp->private_data, struct media_device_fh, fh);
-}
-
 /* -----------------------------------------------------------------------------
  * Userspace API
  */
@@ -56,7 +47,10 @@ static inline void __user *media_get_uptr(__u64 arg)
 
 static int media_device_open(struct file *filp)
 {
+	struct media_devnode *devnode = filp->private_data;
+	struct media_device *mdev = devnode->media_dev;
 	struct media_device_fh *fh;
+	unsigned long flags;
 
 	fh = kzalloc_obj(*fh);
 	if (!fh)
@@ -64,12 +58,25 @@ static int media_device_open(struct file *filp)
 
 	filp->private_data = &fh->fh;
 
+	spin_lock_irqsave(&mdev->fh_list_lock, flags);
+	list_add(&fh->mdev_list, &mdev->fh_list);
+	spin_unlock_irqrestore(&mdev->fh_list_lock, flags);
+
 	return 0;
 }
 
 static int media_device_close(struct file *filp)
 {
+	struct media_devnode *devnode = media_devnode_data(filp);
+	struct media_device *mdev = devnode->media_dev;
 	struct media_device_fh *fh = media_device_fh(filp);
+	unsigned long flags;
+
+	if (mdev) {
+		spin_lock_irqsave(&mdev->fh_list_lock, flags);
+		list_del(&fh->mdev_list);
+		spin_unlock_irqrestore(&mdev->fh_list_lock, flags);
+	}
 
 	kfree(fh);
 
@@ -732,12 +739,14 @@ void media_device_init(struct media_device *mdev)
 	INIT_LIST_HEAD(&mdev->pads);
 	INIT_LIST_HEAD(&mdev->links);
 	INIT_LIST_HEAD(&mdev->entity_notify);
+	INIT_LIST_HEAD(&mdev->fh_list);
 
 	mutex_init(&mdev->req_queue_mutex);
 	mutex_init(&mdev->graph_mutex);
 	ida_init(&mdev->entity_internal_idx);
 
 	atomic_set(&mdev->request_id, 0);
+	spin_lock_init(&mdev->fh_list_lock);
 
 	if (!*mdev->bus_info)
 		media_set_bus_info(mdev->bus_info, sizeof(mdev->bus_info),
@@ -843,6 +852,7 @@ void media_device_unregister(struct media_device *mdev)
 	struct media_entity *next;
 	struct media_interface *intf, *tmp_intf;
 	struct media_entity_notify *notify, *nextp;
+	unsigned long flags;
 
 	if (mdev == NULL)
 		return;
@@ -883,6 +893,11 @@ void media_device_unregister(struct media_device *mdev)
 	dev_dbg(mdev->dev, "Media device unregistered\n");
 
 	debugfs_remove_recursive(mdev->media_dir);
+
+	spin_lock_irqsave(&mdev->fh_list_lock, flags);
+	list_del_init(&mdev->fh_list);
+	spin_unlock_irqrestore(&mdev->fh_list_lock, flags);
+
 	device_remove_file(&mdev->devnode->dev, &dev_attr_model);
 	media_devnode_unregister(mdev->devnode);
 	/* devnode free is handled in media_devnode_*() */
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 749c327e3c58..2e737fec1afc 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -112,6 +112,10 @@ struct media_device_ops {
  * @media_dir:	DebugFS media directory
  * @request_id: Used to generate unique request IDs
  *
+ * @fh_list:	List of file handles in the media device
+ *		(struct media_device_fh.mdev_list).
+ * @fh_list_lock: Serialise access to fh_list list.
+ *
  * This structure represents an abstract high-level media device. It allows easy
  * access to entities and provides basic media device-level support. The
  * structure can be allocated directly or embedded in a larger structure.
@@ -189,6 +193,9 @@ struct media_device {
 	/* debugfs */
 	struct dentry *media_dir;
 	atomic_t request_id;
+
+	struct list_head fh_list;
+	spinlock_t fh_list_lock;
 };
 
 /* We don't need to include usb.h here */
diff --git a/include/media/media-fh.h b/include/media/media-fh.h
new file mode 100644
index 000000000000..14ae4daaaddd
--- /dev/null
+++ b/include/media/media-fh.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Media device file handle
+ *
+ * Copyright (C) 2019 Intel Corporation
+ */
+
+#ifndef MEDIA_FH_H
+#define MEDIA_FH_H
+
+#include <linux/list.h>
+#include <linux/file.h>
+
+#include <media/media-devnode.h>
+
+/**
+ * struct media_device_fh - File handle specific information on MC
+ *
+ * @fh: The media device file handle
+ * @mdev_list: This file handle in media device's list of file handles
+ */
+struct media_device_fh {
+	struct media_devnode_fh fh;
+	struct list_head mdev_list;
+};
+
+static inline struct media_device_fh *media_device_fh(struct file *filp)
+{
+	return container_of(filp->private_data, struct media_device_fh, fh);
+}
+
+#endif /* MEDIA_FH_H */

-- 
2.56.0

