Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005856;
	b=Nr5Lb7LRvbUn9cooLRZ8e9shBU3sd65olPCPTKAmK9KOTk2vy9fMIDqh6Tu5q1Wt1LlJ
	 ifbiQx36errGeD3/3pHh0dLUtmbQFNJlYifgNLBMMOl7xmjBUHZ4YvS6oWLeF9SSdmL5N
	 d/21caQeecLAGsrAgcoJXNQcVZRoi06gSyfO+Asquixc7EjnSuajdhH/ar23FD0aqb6J9
	 3VekFuaFpC4TpuEAEWPuDIJyy2I4XrbWhDkGqodiQSdaF4PiDA3IQjJtsjHORkuJHD5HQ
	 aWFQi29NtTMd0mgHU6SQGFc9efp+mc7dvRwD5Amt0X5wCnfZtsrISza2TIb7qR4etFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005856;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DY05hwkfLcKckCQ+HSL4XaVG4JORuAqMF+yJ88Y9BpQ=;
	b=x2lx+MVHg61q5i7tR30zeFjECcP9KgdvdCeuYfA9V0vovCYDbyqZb9g/UZmS3S7zaVCJ
	 w4BXMgDdHgfD/2wbZuEcADOekL6FY09OHIgAidydh2sM11p6N85FsXlP/2ChiVBhwHV+c
	 /OpApc+19s0ccs7nMiucYVuuLPwDGLxfZgis5p3rZVwIelU7oCcyupvAViH/gsRIMt1iO
	 cW0OmYgsR2UvguRp9H0HPbOpZA5ZvrmVJOpZ8Xg9KZFHYLCn5HHNG4ElLXaLVRzq3ulf8
	 PYkrjB6R6beEXasblam8y1SkOtLZZ7+YEadVM9ub5/Z7A6j7noCr7C2qL+oFKq7mdXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPBgNA9K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6805606A32C;
	Wed, 18 Nov 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPBgNA9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC231F000C8;
	Wed, 18 Nov 2026 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005855;
	bh=DY05hwkfLcKckCQ+HSL4XaVG4JORuAqMF+yJ88Y9BpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DPBgNA9KAABQ22erkRT2ULLPZqYDan5UAdbpalumHVijpm4RDyvdBWrggTSvJc6l3
	 2UXHsLIWD7maTPq+i3+iiA3WRJZgCaY1iVscm4iqp+ThETMvhyKqubCJoZb00OIzkK
	 Lm8l18XWrFK+b8mZ64qa/Uo21AvWnzkapf5pkEwGrxDMhF17QX2x62xuLS7dAohigi
	 11uOrWxNQJsQQveF/1jBn2YtrLjDkzelGnNZNbhra9mvAsPobmMthx/jcqkezW2tRi
	 gkspnnka8RVhd87nyvlir7TtTR384GXPa1lh7qM4L3EGHHfstguhMKNAZsCIQI3xd9
	 p1bhSWQtb4S8Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:51 +0100
Subject: [PATCH RFC v2 07/16] media: mc: Add MEDIA_IOC_DQEVENT
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
Message-Id: <20261118-v4l2-sensor-detect-v2-7-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19624;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jH/Lvt7jHSsYNBQBXJehNrFEfYnEGTzGK6Zj8kfN7Y0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2Lg9243TaRE1Bn31ARJCGIOYtViEJ0NRM4U
 J0lQww3RySJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2diwAKCRAZDR20Zk4Z
 Na10CACwMCVdZYAyWvGa3PACbMnQ3/MZP36grHPKTARVpp4iYwqeEq4iDAk7Ywe3rbZhNYVHRyb
 Vq1PEkp1ja6kz1+kFSDbTso7E/Alcaq3ay0ApZIA/2NKW0fS8cQLkyl1+bgGYk7+8tx84UrcQCV
 GzCmVBArUPttOYbpslX91akHWYuMMo1+r8ocGJpSX7pne+Nxskg2/lOrWrBID9iF2ITrbLWsbKi
 0iAQ5cteFF/fYXvjOeoQWnhIWA6hKFMLkRaAq9IEt8dxKlzMk3vdnX9CrDdgo+i+7fhaI+HKRBm
 YHXwKN52YeEXjX13Qtm3lXOx+fZm32Q0ipd7nbVFjLI2M4fx
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Events on a media device tell about completion of requests. Blocking and
non-blocking operation is supported.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/Kconfig        |   1 +
 drivers/media/mc/Makefile    |   2 +-
 drivers/media/mc/mc-device.c |  48 +++++++++
 drivers/media/mc/mc-event.c  | 244 +++++++++++++++++++++++++++++++++++++++++++
 include/media/media-device.h |   3 +
 include/media/media-event.h  | 181 ++++++++++++++++++++++++++++++++
 include/media/media-fh.h     |   5 +
 include/uapi/linux/media.h   |  24 +++++
 8 files changed, 507 insertions(+), 1 deletion(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 70e090757492..5ffcd5565bd1 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -12,6 +12,7 @@ source "drivers/media/cec/Kconfig"
 menuconfig MEDIA_SUPPORT
 	tristate "Multimedia support"
 	depends on HAS_IOMEM
+	select MEDIA_EVENT
 	help
 	  If you want to use media devices, including Webcams, Video grabber
 	  devices and/or TV devices, V4L2 codecs, etc, enable this option
diff --git a/drivers/media/mc/Makefile b/drivers/media/mc/Makefile
index d501327436a5..1e6540161e0c 100644
--- a/drivers/media/mc/Makefile
+++ b/drivers/media/mc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 mc-objs	:= mc-device.o mc-devnode.o mc-entity.o \
-	   mc-request.o
+	   mc-request.o mc-event.o
 
 ifneq ($(CONFIG_USB),)
 	mc-objs += mc-dev-allocator.o
diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index b64322efd99e..98d323c89b41 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -8,6 +8,7 @@
  *	     Sakari Ailus <sakari.ailus@iki.fi>
  */
 
+#include <linux/atomic.h>
 #include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/idr.h>
@@ -22,6 +23,7 @@
 #include <media/media-device.h>
 #include <media/media-devnode.h>
 #include <media/media-entity.h>
+#include <media/media-event.h>
 #include <media/media-fh.h>
 #include <media/media-request.h>
 
@@ -57,6 +59,14 @@ static int media_device_open(struct file *filp)
 		return -ENOMEM;
 
 	filp->private_data = &fh->fh;
+	init_waitqueue_head(&fh->wait);
+
+	fh->ev_fh.lock = &mdev->fh_list_lock;
+	fh->ev_fh.wait = &fh->wait;
+	INIT_LIST_HEAD(&fh->ev_fh.available);
+	INIT_LIST_HEAD(&fh->ev_fh.subscribed);
+	fh->ev_fh.sequence = -1;
+	mutex_init(&fh->ev_fh.subscribe_lock);
 
 	spin_lock_irqsave(&mdev->fh_list_lock, flags);
 	list_add(&fh->mdev_list, &mdev->fh_list);
@@ -78,6 +88,9 @@ static int media_device_close(struct file *filp)
 		spin_unlock_irqrestore(&mdev->fh_list_lock, flags);
 	}
 
+	media_event_unsubscribe_all(fh);
+	mutex_destroy(&fh->ev_fh.subscribe_lock);
+
 	kfree(fh);
 
 	return 0;
@@ -414,6 +427,25 @@ static long media_device_request_alloc(struct media_device *mdev,
 	return media_request_alloc(mdev, alloc_fd);
 }
 
+static long media_device_event_dequeue(struct media_device *mdev,
+				       struct file *file, void *arg)
+{
+	return media_event_dequeue(media_device_fh(file), arg,
+				   file->f_flags & O_NONBLOCK);
+}
+
+static long media_device_event_subscribe(struct media_device *mdev,
+					 struct file *file, void *arg)
+{
+	return media_event_subscribe(media_device_fh(file), arg, 0, NULL);
+}
+
+static long media_device_event_unsubscribe(struct media_device *mdev,
+					   struct file *file, void *arg)
+{
+	return media_event_unsubscribe(media_device_fh(file), arg);
+}
+
 static long copy_arg_from_user(void *karg, void __user *uarg, unsigned int cmd)
 {
 	if ((_IOC_DIR(cmd) & _IOC_WRITE) &&
@@ -464,6 +496,9 @@ static const struct media_ioctl_info ioctl_info[] = {
 	MEDIA_IOC(SETUP_LINK, media_device_setup_link, MEDIA_IOC_FL_GRAPH_MUTEX),
 	MEDIA_IOC(G_TOPOLOGY, media_device_get_topology, MEDIA_IOC_FL_GRAPH_MUTEX),
 	MEDIA_IOC(REQUEST_ALLOC, media_device_request_alloc, 0),
+	MEDIA_IOC(DQEVENT, media_device_event_dequeue, 0),
+	MEDIA_IOC(SUBSCRIBE_EVENT, media_device_event_subscribe, 0),
+	MEDIA_IOC(UNSUBSCRIBE_EVENT, media_device_event_unsubscribe, 0),
 };
 
 static long media_device_ioctl(struct file *filp, unsigned int cmd,
@@ -574,9 +609,22 @@ static long media_device_compat_ioctl(struct file *filp, unsigned int cmd,
 }
 #endif /* CONFIG_COMPAT */
 
+static __poll_t media_device_poll(struct file *filp,
+				  struct poll_table_struct *wait)
+{
+	struct media_device_fh *fh = media_device_fh(filp);
+
+	poll_wait(filp, &fh->wait, wait);
+	if (media_event_pending(fh))
+		return EPOLLPRI;
+
+	return 0;
+}
+
 static const struct media_file_operations media_device_fops = {
 	.owner = THIS_MODULE,
 	.open = media_device_open,
+	.poll = media_device_poll,
 	.ioctl = media_device_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = media_device_compat_ioctl,
diff --git a/drivers/media/mc/mc-event.c b/drivers/media/mc/mc-event.c
new file mode 100644
index 000000000000..2369e40e522f
--- /dev/null
+++ b/drivers/media/mc/mc-event.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Media events
+ *
+ * Copyright (C) 2019, 2026 Intel Corporation
+ * Copyright (C) 2009--2010 Nokia Corporation.
+ *
+ * Based on V4L2 events in drivers/media/v4l2-core/v4l2-events.c .
+ */
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+
+#include <media/media-device.h>
+#include <media/media-event.h>
+#include <media/media-fh.h>
+
+static int media_evop_add(struct media_subscribed_evbase *mse, unsigned int elems)
+{
+	struct media_subscribed_event *sev = to_media_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->add)
+		return sev->ops->add(sev, elems);
+
+	return 0;
+}
+
+static void media_evop_del(struct media_subscribed_evbase *mse)
+{
+	struct media_subscribed_event *sev = to_media_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->del)
+		sev->ops->del(sev);
+}
+
+static bool media_evop_replace(struct media_subscribed_evbase *mse,
+			       struct media_evbase *old,
+			       const void *new)
+{
+	struct media_subscribed_event *sev = to_media_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->replace) {
+		sev->ops->replace(&to_media_kevent(old)->event, new);
+		return true;
+	}
+
+	return false;
+}
+
+static void media_evop_merge(struct media_subscribed_evbase *mse,
+			     const struct media_evbase *old,
+			     struct media_evbase *new)
+{
+	struct media_subscribed_event *sev = to_media_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->merge)
+		sev->ops->merge(&to_media_kevent_const(old)->event,
+				&to_media_kevent(new)->event);
+}
+
+static void media_evop_queue(struct media_evbase *kev, const void *__ev,
+			     u64 ts, u32 sequence, bool copy_payload)
+{
+	struct media_event *old = &to_media_kevent(kev)->event;
+	const struct media_event *new = __ev;
+
+	old->type = new->type;
+	if (copy_payload)
+		old->u = new->u;
+	old->id = new->id;
+	old->timestamp = ts;
+	old->sequence = sequence;
+}
+
+static bool media_evop_is_subscribed(struct media_subscribed_evbase *mse,
+				     const void *__evspec)
+{
+	const struct media_event_spec *evspec = __evspec;
+	struct media_subscribed_event *sev =
+		container_of(mse, struct media_subscribed_event, mse);
+
+	return sev->evspec.type == evspec->type &&
+		sev->evspec.id == evspec->id;
+}
+
+static bool media_evop_is_queueable(struct media_subscribed_evbase *mse,
+				    const void *__ev)
+{
+	const struct media_event *ev = __ev;
+	struct media_subscribed_event *sev =
+		container_of(mse, struct media_subscribed_event, mse);
+
+	return sev->evspec.type == ev->type && sev->evspec.id == ev->id;
+}
+
+static void media_evop_release(struct media_subscribed_evbase *mse)
+{
+	kvfree(to_media_subscribed_event(mse));
+}
+
+static const struct media_subscribed_evbase_ops media_event_ops = {
+	.add            = media_evop_add,
+	.del            = media_evop_del,
+	.replace        = media_evop_replace,
+	.merge          = media_evop_merge,
+	.queue          = media_evop_queue,
+	.is_subscribed  = media_evop_is_subscribed,
+	.is_queueable   = media_evop_is_queueable,
+	.release        = media_evop_release,
+};
+
+static int __media_event_dequeue(struct media_evbase_fh *fh,
+				 struct media_event *event)
+{
+	struct media_evbase *mev;
+	struct media_kevent *kev;
+	unsigned long flags;
+
+	spin_lock_irqsave(fh->lock, flags);
+
+	mev = __media_evbase_dequeue(fh);
+	if (!mev) {
+		spin_unlock_irqrestore(fh->lock, flags);
+		return -ENOENT;
+	}
+
+	kev = container_of(mev, struct media_kevent, mev);
+
+	*event = kev->event;
+	event->pending = fh->navailable;
+
+	spin_unlock_irqrestore(fh->lock, flags);
+
+	return 0;
+}
+
+long media_event_dequeue(struct media_device_fh *fh, struct media_event *event,
+			 int nonblocking)
+{
+	int ret;
+
+	if (nonblocking)
+		return __media_event_dequeue(&fh->ev_fh, event);
+
+	do {
+		ret = wait_event_interruptible(fh->wait,
+					       fh->ev_fh.navailable != 0);
+		if (ret < 0)
+			break;
+
+		ret = __media_event_dequeue(&fh->ev_fh, event);
+	} while (ret == -ENOENT);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(media_event_dequeue);
+
+void media_event_queue(struct media_device *mdev, const struct media_event *ev)
+{
+	struct media_device_fh *fh;
+	unsigned long flags;
+	u64 ts;
+
+	if (mdev == NULL)
+		return;
+
+	ts = ktime_get_ns();
+
+	spin_lock_irqsave(&mdev->fh_list_lock, flags);
+
+	list_for_each_entry(fh, &mdev->fh_list, mdev_list)
+		__media_evbase_queue_fh(&fh->ev_fh, ev, ts);
+
+	spin_unlock_irqrestore(&mdev->fh_list_lock, flags);
+}
+EXPORT_SYMBOL_GPL(media_event_queue);
+
+int media_event_pending(struct media_device_fh *fh)
+{
+	return media_evbase_pending(&fh->ev_fh);
+}
+EXPORT_SYMBOL_GPL(media_event_pending);
+
+long media_event_subscribe(struct media_device_fh *fh,
+			   const struct media_event_subscription *sub,
+			   unsigned int elems,
+			   const struct media_subscribed_event_ops *ops)
+{
+	struct media_subscribed_evbase *mse;
+	struct media_subscribed_event *sev;
+
+	if (sub->type == MEDIA_EVENT_ALL)
+		return -EINVAL;
+
+	elems = max(elems, 1U);
+
+	sev = kvzalloc(sizeof(*sev) + array_size(sizeof(struct media_kevent),
+						 elems), GFP_KERNEL);
+	if (!sev)
+		return -ENOMEM;
+
+	sev->evspec.type = sub->type;
+	sev->evspec.id = sub->id;
+	sev->evspec.flags = sub->flags;
+	sev->ops = ops;
+
+	mse = &sev->mse;
+
+	mse->ev_size = sizeof(struct media_kevent);
+	mse->ops = &media_event_ops;
+	mse->fh = &fh->ev_fh;
+	mse->evspec = &sev->evspec;
+
+	return media_evbase_subscribe(&fh->ev_fh, mse, elems);
+}
+EXPORT_SYMBOL_GPL(media_event_subscribe);
+
+void media_event_unsubscribe_all(struct media_device_fh *fh)
+{
+	media_evbase_unsubscribe_all(&fh->ev_fh);
+}
+EXPORT_SYMBOL_GPL(media_event_unsubscribe_all);
+
+long media_event_unsubscribe(struct media_device_fh *fh,
+			    const struct media_event_subscription *sub)
+{
+	struct media_event_spec evspec = {
+		.type = sub->type,
+		.id = sub->id,
+		.flags = sub->flags,
+	};
+
+	if (sub->type == MEDIA_EVENT_ALL) {
+		media_event_unsubscribe_all(fh);
+		return 0;
+	}
+
+	media_evbase_unsubscribe(&fh->ev_fh, &evspec);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(media_event_unsubscribe);
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 2e737fec1afc..3ef277309d59 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -19,10 +19,13 @@
 
 #include <media/media-devnode.h>
 #include <media/media-entity.h>
+#include <media/media-evbase.h>
 
 struct ida;
 struct media_device;
 
+#include <uapi/linux/media.h>
+
 /**
  * struct media_entity_notify - Media Entity Notify
  *
diff --git a/include/media/media-event.h b/include/media/media-event.h
new file mode 100644
index 000000000000..57265d117cf5
--- /dev/null
+++ b/include/media/media-event.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * media-event.h
+ *
+ * Media controller events.
+ *
+ * Copyright (C) 2019, 2026 Intel Corporation
+ * Copyright (C) 2009--2010 Nokia Corporation.
+ *
+ * Based on V4L2 events.
+ */
+
+#ifndef MEDIA_EVENT_H
+#define MEDIA_EVENT_H
+
+#include <linux/types.h>
+#include <linux/media.h>
+
+#include <media/media-evbase.h>
+
+struct media_device;
+struct media_device_fh;
+struct media_subscribed_event;
+
+/**
+ * struct media_event_spec - Event subscription parameters
+ *
+ * @type:	Media event type, MEDIA_EVENT_*.
+ * @id:		Media event id.
+ * @flags:	Media event flags.
+ */
+struct media_event_spec {
+	u32 type;
+	u32 id;
+	u32 flags;
+};
+
+/**
+ * struct media_subscribed_event_ops - Subscribed event operations.
+ *
+ * @add:	Optional callback, called when a new listener is added
+ * @del:	Optional callback, called when a listener stops listening
+ * @replace:	Optional callback that can replace event 'old' with event 'new'.
+ * @merge:	Optional callback that can merge event 'old' into event 'new'.
+ */
+struct media_subscribed_event_ops {
+	int  (*add)(struct media_subscribed_event *sev, unsigned int elems);
+	void (*del)(struct media_subscribed_event *sev);
+	void (*replace)(struct media_event *old, const struct media_event *new);
+	void (*merge)(const struct media_event *old, struct media_event *new);
+};
+
+/**
+ * struct media_subscribed_event - Describes a single subscribed media event.
+ *
+ * @evspec:	Parameters of the subscribed event.
+ * @ops:	Operations for the subscribed event.
+ * @mse:	Common media event descriptor.
+ */
+struct media_subscribed_event {
+	struct media_event_spec evspec;
+	const struct media_subscribed_event_ops *ops;
+	struct media_subscribed_evbase mse;
+};
+
+/**
+ * struct media_kevent - Internal kernel event struct.
+ *
+ * @mev:	Generic media subsystem kernel event.
+ * @event:	The media event itself.
+ */
+struct media_kevent {
+	struct media_evbase mev;
+	struct media_event event;
+};
+
+/**
+ * to_media_kevent - Convert a generic media_evbase into a media_kevent
+ *
+ * @mev: The generic media event
+ */
+static inline struct media_kevent *to_media_kevent(struct media_evbase *mev)
+{
+	return container_of(mev, struct media_kevent, mev);
+}
+
+/**
+ * to_media_kevent_const - Convert a const generic media_evbase into a
+ *			   media_kevent
+ *
+ * @mev: The generic media event
+ *
+ * This is just like @to_media_kevent, but const.
+ */
+static inline const struct media_kevent *
+to_media_kevent_const(const struct media_evbase *mev)
+{
+	return container_of(mev, const struct media_kevent, mev);
+}
+
+/**
+ * to_media_subscribed_event - Convert a generic media_subscribed_evbase into
+ *			       a media_subscribed_event.
+ *
+ * @mse: The generic media subscribed event base
+ */
+static inline struct media_subscribed_event *
+to_media_subscribed_event(struct media_subscribed_evbase *mse)
+{
+	return container_of(mse, struct media_subscribed_event, mse);
+}
+
+/**
+ * media_event_dequeue - Dequeue events from a media device.
+ *
+ * @fh: pointer to struct media_device_fh
+ * @event: pointer to struct media_event
+ * @nonblocking: if zero, wait for an event to arrive
+ */
+long media_event_dequeue(struct media_device_fh *fh,
+			 struct media_event *event, int nonblocking);
+
+/**
+ * media_event_queue - Queue events to a media device.
+ *
+ * @mdev: pointer to &struct media_device
+ * @ev: pointer to &struct media_event
+ *
+ * The event will be queued for all &struct media_device_fh file handlers.
+ *
+ * .. note::
+ *    The driver's only responsibility is to fill in the type and the data
+ *    fields. The other fields will be filled in by the framework.
+ */
+void media_event_queue(struct media_device *mdev,
+		       const struct media_event *ev);
+
+/**
+ * media_event_pending - Check if an event is available
+ *
+ * @fh: pointer to &struct media_device_fh
+ *
+ * Returns the number of pending events.
+ */
+int media_event_pending(struct media_device_fh *fh);
+
+/**
+ * media_event_subscribe - Subscribes to a media event.
+ *
+ * @fh: pointer to &struct media_device_fh
+ * @sub: pointer to &struct media_event_subscription
+ * @elems: size of the events queue
+ * @ops: pointer to &media_subscribed_event_ops
+ *
+ * .. note::
+ *
+ *    if @elems is zero, the framework will fill in a default value,
+ *    which is currently 1 element.
+ */
+long media_event_subscribe(struct media_device_fh *fh,
+			   const struct media_event_subscription *sub,
+			   unsigned int elems,
+			   const struct media_subscribed_event_ops *ops);
+
+/**
+ * media_event_unsubscribe - Unsubscribe from a media event.
+ *
+ * @fh: pointer to &struct media_device_fh
+ * @sub: pointer to &struct media_event_subscription
+ */
+long media_event_unsubscribe(struct media_device_fh *fh,
+			     const struct media_event_subscription *sub);
+
+/**
+ * media_event_unsubscribe_all - Unsubscribe from all media events.
+ *
+ * @fh: pointer to &struct media_device_fh
+ */
+void media_event_unsubscribe_all(struct media_device_fh *fh);
+
+#endif /* MEDIA_EVENT_H */
diff --git a/include/media/media-fh.h b/include/media/media-fh.h
index 14ae4daaaddd..ca8bf6154096 100644
--- a/include/media/media-fh.h
+++ b/include/media/media-fh.h
@@ -12,16 +12,21 @@
 #include <linux/file.h>
 
 #include <media/media-devnode.h>
+#include <media/media-evbase.h>
 
 /**
  * struct media_device_fh - File handle specific information on MC
  *
  * @fh: The media device file handle
  * @mdev_list: This file handle in media device's list of file handles
+ * @ev_fh: File handle specific media event information
+ * @wait: File handle's wait queue
  */
 struct media_device_fh {
 	struct media_devnode_fh fh;
 	struct list_head mdev_list;
+	struct media_evbase_fh ev_fh;
+	struct wait_queue_head wait;
 };
 
 static inline struct media_device_fh *media_device_fh(struct file *filp)
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 2da6ae4da003..24b6b3f75592 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -373,6 +373,27 @@ struct media_v2_topology {
 	__u64 ptr_links;
 } __attribute__ ((packed));
 
+#define MEDIA_EVENT_ALL		0
+
+struct media_event {
+	__u32 type;
+	union {
+		__u8 data[64];
+	} u;
+	__u32 reserved[8];
+	__u32 pending;
+	__u32 sequence;
+	__u64 timestamp;
+	__u32 id;
+} __attribute__((packed));
+
+struct media_event_subscription {
+	__u32 type;
+	__u32 id;
+	__u32 flags;
+	__u32 reserved[5];
+} __attribute__((packed));
+
 /* ioctls */
 
 #define MEDIA_IOC_DEVICE_INFO	_IOWR('|', 0x00, struct media_device_info)
@@ -381,6 +402,9 @@ struct media_v2_topology {
 #define MEDIA_IOC_SETUP_LINK	_IOWR('|', 0x03, struct media_link_desc)
 #define MEDIA_IOC_G_TOPOLOGY	_IOWR('|', 0x04, struct media_v2_topology)
 #define MEDIA_IOC_REQUEST_ALLOC	_IOR ('|', 0x05, int)
+#define MEDIA_IOC_SUBSCRIBE_EVENT _IOWR ('|', 0x06, struct media_event_subscription)
+#define MEDIA_IOC_UNSUBSCRIBE_EVENT _IOWR ('|', 0x07, struct media_event_subscription)
+#define MEDIA_IOC_DQEVENT	_IOWR('|', 0x08, struct media_event)
 
 /*
  * These ioctls are called on the request file descriptor as returned

-- 
2.56.0

