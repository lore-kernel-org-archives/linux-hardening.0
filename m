Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005846;
	b=u2l6ZnzWpdQwIP2NR8wiYtw4gOIyoe4iCeEvKjQIlxnuABfXzWmTQbiOBhFPgNue3f+1
	 RykbEF8ab/BUYaSQ13Kz998zo7p6drDlzKUnlzhx1PG6T/xPwT1fZxxEVX2UDFnN3uUQ2
	 YUNSaY42in5+l/oxNOoiJGzgzh45sjcVWGY/v/i14PnrUsPddmuZhLCNEm7uMEwFQNNym
	 H2dzwS5uY0vJHNDamAEi3/GCb6n82jIXYQe8ngQSIeda8wF2T36mkplSYJGNIsaUncasy
	 cWi0ENZaFUWTE3F3ICAcfgVp6dTaIlgtXOOc37rqdW5S6zQ8MlXgSzvGe5tBYxqyHWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005846;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UNGNLoljv5+E+opJefsP2Z67GitrU42fMHXuRlu1xwI=;
	b=ZgbHpxRdzh3+n/Niqtu/Tqdm+Juvh8fYgq8oDnMx/+lU8pXCKWQ8XLCCvfksnUaeuhYO
	 SN1WEfrhVUmBWddRv5y5FdkTcS9sNRRW4Msh/MYgHdNqYGZVCYXdzTzYIN1ivQySSH4hy
	 mX4hs6kTf5BR6Bgclf2rKhjj22lrqyOESyO9P/Z7091p2krwVQJkKhTHA5RHKKQvhQNYz
	 W9iCCdbl/0GDY34AeMhGrMv++sZGkgjX+K7PtWEUVYdgSZHeBG4/U+K/Vks+Lr6YzrCec
	 wAPiJSBkTXr83iF/0HiP+SPKxU1NFSy+Wzu2WDZ0MO/+JLdeQ4Bp2lXMNRTVVFN93Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EySaHYZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA6606A331;
	Wed, 18 Nov 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EySaHYZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9201F000CA;
	Wed, 18 Nov 2026 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005846;
	bh=UNGNLoljv5+E+opJefsP2Z67GitrU42fMHXuRlu1xwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EySaHYZX7LtQ5yaP8gfSlV2hHZccu87teBPhRmlcCnvya+ZOO/aw8qzFCRTrjF7s3
	 CBCVFZyDYTWUfKeUU08qh55KfNSP4vKA6b4vYk8EJyRcU0ORWSZeeiULYJBhFTNeO/
	 i3f/jSz0BNyCYPrfP6fZV9qYdTsblada+sTKuAR+uoYwmfgAdqN6e2DcnOnrygpRBH
	 Eac4Y1Om8N/dsZyn9yM+VJaqTax0Rfvv/HBma83ZClTk+YCI3dkdcbV9u75Zgiw729
	 x6u7bVxXwP4OkcsA4o4ypaZQ5V68zf32f3PYFedT60DW5X3dUxQ20Bm5//fZXvLNcv
	 BgOS8HO70El/g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:47 +0100
Subject: [PATCH RFC v2 03/16] v4l: event: Separate event related
 information from struct v4l2_fh
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
Message-Id: <20261118-v4l2-sensor-detect-v2-3-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12244;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jynMK7UEGARZi57WXuzRcq5xmV6SA6JHEf2XWxUa4Ws=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2KgaE97UbV54f5MpwQSpqm8Va3ihyZpY6HZ
 iQV2XSNleGJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2digAKCRAZDR20Zk4Z
 NWnVB/0WxBfoNwn/1n8fTKMbkHFHbypPOo+Viu+NxNyhokmawTelBazuHo9rAzLyIk99d7NSBA/
 lba0Z8tc7HPPx37SQ0o3qxXI+wyf/HSKgZHJKEosIdWLv3gb8VgVqNXMlTWL8+g+tO62P0sZNWi
 myl8KQWxdStGvZzk4yz6AOUd4Z09pgMwTYsYsmUYpmT/7HRmcwjF6RuOo7jlV8L/hzVkvxvkuow
 1efrGg9P4I2Kgm57vVAxAxnvSRfibBZXsnGhgPH6QPkc6DB4X5T9DXsJY7JwKFhRYSW37W5FIC2
 8tGd1+BW2S6hemGWfPNlS1hPj/eFe39EDwJmFFq8ATDByHOb
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Generalise event related file handle information to struct media_event_fh.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/pci/ivtv/ivtv-fileops.c |  2 +-
 drivers/media/v4l2-core/v4l2-event.c  | 72 ++++++++++++++++++-----------------
 drivers/media/v4l2-core/v4l2-fh.c     | 12 +++---
 include/media/media-evbase.h          | 40 +++++++++++++++++++
 include/media/v4l2-fh.h               | 20 +++-------
 5 files changed, 90 insertions(+), 56 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-fileops.c b/drivers/media/pci/ivtv/ivtv-fileops.c
index e7fed9698758..5900dd97f0ed 100644
--- a/drivers/media/pci/ivtv/ivtv-fileops.c
+++ b/drivers/media/pci/ivtv/ivtv-fileops.c
@@ -742,7 +742,7 @@ __poll_t ivtv_v4l2_dec_poll(struct file *filp, poll_table *wait)
 
 	/* If there are subscribed events, then only use the new event
 	   API instead of the old video.h based API. */
-	if (!list_empty(&id->fh.subscribed)) {
+	if (!list_empty(&id->fh.ev_fh.subscribed)) {
 		poll_wait(filp, &id->fh.wait, wait);
 		/* Turn off the old-style vsync events */
 		clear_bit(IVTV_F_I_EV_VSYNC_ENABLED, &itv->i_flags);
diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index 9dd2aaa95a67..a21a44c64264 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -24,16 +24,17 @@ static unsigned int sev_pos(const struct v4l2_subscribed_event *sev, unsigned in
 	return idx >= sev->elems ? idx - sev->elems : idx;
 }
 
-static int __v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event)
+static int __v4l2_event_dequeue(struct media_evbase_fh *fh,
+				struct v4l2_event *event)
 {
 	struct v4l2_kevent *kev;
 	struct timespec64 ts;
 	unsigned long flags;
 
-	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
+	spin_lock_irqsave(fh->lock, flags);
 
 	if (list_empty(&fh->available)) {
-		spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+		spin_unlock_irqrestore(fh->lock, flags);
 		return -ENOENT;
 	}
 
@@ -51,7 +52,7 @@ static int __v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event)
 	kev->sev->first = sev_pos(kev->sev, 1);
 	kev->sev->in_use--;
 
-	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+	spin_unlock_irqrestore(fh->lock, flags);
 
 	return 0;
 }
@@ -62,7 +63,7 @@ int v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event,
 	int ret;
 
 	if (nonblocking)
-		return __v4l2_event_dequeue(fh, event);
+		return __v4l2_event_dequeue(&fh->ev_fh, event);
 
 	/* Release the vdev lock while waiting */
 	if (fh->vdev->lock)
@@ -70,11 +71,11 @@ int v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event,
 
 	do {
 		ret = wait_event_interruptible(fh->wait,
-					       fh->navailable != 0);
+					       fh->ev_fh.navailable != 0);
 		if (ret < 0)
 			break;
 
-		ret = __v4l2_event_dequeue(fh, event);
+		ret = __v4l2_event_dequeue(&fh->ev_fh, event);
 	} while (ret == -ENOENT);
 
 	if (fh->vdev->lock)
@@ -84,13 +85,13 @@ int v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event,
 }
 EXPORT_SYMBOL_GPL(v4l2_event_dequeue);
 
-/* Caller must hold fh->vdev->fh_lock! */
+/* Caller must hold fh->lock! */
 static struct v4l2_subscribed_event *v4l2_event_subscribed(
-		struct v4l2_fh *fh, u32 type, u32 id)
+	struct media_evbase_fh *fh, u32 type, u32 id)
 {
 	struct v4l2_subscribed_event *sev;
 
-	assert_spin_locked(&fh->vdev->fh_lock);
+	assert_spin_locked(fh->lock);
 
 	list_for_each_entry(sev, &fh->subscribed, list)
 		if (sev->type == type && sev->id == id)
@@ -99,7 +100,7 @@ static struct v4l2_subscribed_event *v4l2_event_subscribed(
 	return NULL;
 }
 
-static void __v4l2_event_queue_fh(struct v4l2_fh *fh,
+static void __v4l2_event_queue_fh(struct media_evbase_fh *fh,
 				  const struct v4l2_event *ev, u64 ts)
 {
 	struct v4l2_subscribed_event *sev;
@@ -147,7 +148,7 @@ static void __v4l2_event_queue_fh(struct v4l2_fh *fh,
 
 	fh->navailable++;
 
-	wake_up_all(&fh->wait);
+	wake_up_all(fh->wait);
 }
 
 void v4l2_event_queue(struct video_device *vdev, const struct v4l2_event *ev)
@@ -164,7 +165,7 @@ void v4l2_event_queue(struct video_device *vdev, const struct v4l2_event *ev)
 	spin_lock_irqsave(&vdev->fh_lock, flags);
 
 	list_for_each_entry(fh, &vdev->fh_list, list)
-		__v4l2_event_queue_fh(fh, ev, ts);
+		__v4l2_event_queue_fh(&fh->ev_fh, ev, ts);
 
 	spin_unlock_irqrestore(&vdev->fh_lock, flags);
 }
@@ -175,15 +176,15 @@ void v4l2_event_queue_fh(struct v4l2_fh *fh, const struct v4l2_event *ev)
 	unsigned long flags;
 	u64 ts = ktime_get_ns();
 
-	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
-	__v4l2_event_queue_fh(fh, ev, ts);
-	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+	spin_lock_irqsave(fh->ev_fh.lock, flags);
+	__v4l2_event_queue_fh(&fh->ev_fh, ev, ts);
+	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
 }
 EXPORT_SYMBOL_GPL(v4l2_event_queue_fh);
 
 int v4l2_event_pending(struct v4l2_fh *fh)
 {
-	return fh->navailable;
+	return fh->ev_fh.navailable;
 }
 EXPORT_SYMBOL_GPL(v4l2_event_pending);
 
@@ -209,13 +210,13 @@ static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
 	struct v4l2_fh *fh = sev->fh;
 	unsigned int i;
 
-	lockdep_assert_held(&fh->subscribe_lock);
+	lockdep_assert_held(&fh->ev_fh.subscribe_lock);
 	assert_spin_locked(&fh->vdev->fh_lock);
 
 	/* Remove any pending events for this subscription */
 	for (i = 0; i < sev->in_use; i++) {
 		list_del(&sev->events[sev_pos(sev, i)].list);
-		fh->navailable--;
+		fh->ev_fh.navailable--;
 	}
 	list_del(&sev->list);
 }
@@ -247,13 +248,13 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	sev->fh = fh;
 	sev->ops = ops;
 
-	mutex_lock(&fh->subscribe_lock);
+	mutex_lock(&fh->ev_fh.subscribe_lock);
 
-	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
-	found_ev = v4l2_event_subscribed(fh, sub->type, sub->id);
+	spin_lock_irqsave(fh->ev_fh.lock, flags);
+	found_ev = v4l2_event_subscribed(&fh->ev_fh, sub->type, sub->id);
 	if (!found_ev)
-		list_add(&sev->list, &fh->subscribed);
-	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+		list_add(&sev->list, &fh->ev_fh.subscribed);
+	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
 
 	if (found_ev) {
 		/* Already listening */
@@ -268,7 +269,7 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 		}
 	}
 
-	mutex_unlock(&fh->subscribe_lock);
+	mutex_unlock(&fh->ev_fh.subscribe_lock);
 
 	return ret;
 }
@@ -283,14 +284,14 @@ void v4l2_event_unsubscribe_all(struct v4l2_fh *fh)
 	do {
 		sev = NULL;
 
-		spin_lock_irqsave(&fh->vdev->fh_lock, flags);
-		if (!list_empty(&fh->subscribed)) {
-			sev = list_first_entry(&fh->subscribed,
+		spin_lock_irqsave(fh->ev_fh.lock, flags);
+		if (!list_empty(&fh->ev_fh.subscribed)) {
+			sev = list_first_entry(&fh->ev_fh.subscribed,
 					struct v4l2_subscribed_event, list);
 			sub.type = sev->type;
 			sub.id = sev->id;
 		}
-		spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+		spin_unlock_irqrestore(fh->ev_fh.lock, flags);
 		if (sev)
 			v4l2_event_unsubscribe(fh, &sub);
 	} while (sev);
@@ -308,20 +309,20 @@ int v4l2_event_unsubscribe(struct v4l2_fh *fh,
 		return 0;
 	}
 
-	mutex_lock(&fh->subscribe_lock);
+	mutex_lock(&fh->ev_fh.subscribe_lock);
 
-	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
+	spin_lock_irqsave(fh->ev_fh.lock, flags);
 
-	sev = v4l2_event_subscribed(fh, sub->type, sub->id);
+	sev = v4l2_event_subscribed(&fh->ev_fh, sub->type, sub->id);
 	if (sev != NULL)
 		__v4l2_event_unsubscribe(sev);
 
-	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
 
 	if (sev && sev->ops && sev->ops->del)
 		sev->ops->del(sev);
 
-	mutex_unlock(&fh->subscribe_lock);
+	mutex_unlock(&fh->ev_fh.subscribe_lock);
 
 	kvfree(sev);
 
@@ -329,7 +330,8 @@ int v4l2_event_unsubscribe(struct v4l2_fh *fh,
 }
 EXPORT_SYMBOL_GPL(v4l2_event_unsubscribe);
 
-int v4l2_event_subdev_unsubscribe(struct v4l2_subdev *sd, struct v4l2_fh *fh,
+int v4l2_event_subdev_unsubscribe(struct v4l2_subdev *sd,
+				  struct v4l2_fh *fh,
 				  struct v4l2_event_subscription *sub)
 {
 	return v4l2_event_unsubscribe(fh, sub);
diff --git a/drivers/media/v4l2-core/v4l2-fh.c b/drivers/media/v4l2-core/v4l2-fh.c
index b184bed8aca9..c28653f03c32 100644
--- a/drivers/media/v4l2-core/v4l2-fh.c
+++ b/drivers/media/v4l2-core/v4l2-fh.c
@@ -34,10 +34,12 @@ void v4l2_fh_init(struct v4l2_fh *fh, struct video_device *vdev)
 	set_bit(_IOC_NR(VIDIOC_S_PRIORITY), vdev->valid_ioctls);
 	fh->prio = V4L2_PRIORITY_UNSET;
 	init_waitqueue_head(&fh->wait);
-	INIT_LIST_HEAD(&fh->available);
-	INIT_LIST_HEAD(&fh->subscribed);
-	fh->sequence = -1;
-	mutex_init(&fh->subscribe_lock);
+	fh->ev_fh.lock = &vdev->fh_lock;
+	fh->ev_fh.wait = &fh->wait;
+	INIT_LIST_HEAD(&fh->ev_fh.available);
+	INIT_LIST_HEAD(&fh->ev_fh.subscribed);
+	fh->ev_fh.sequence = -1;
+	mutex_init(&fh->ev_fh.subscribe_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_init);
 
@@ -86,7 +88,7 @@ void v4l2_fh_exit(struct v4l2_fh *fh)
 		return;
 	v4l_disable_media_source(fh->vdev);
 	v4l2_event_unsubscribe_all(fh);
-	mutex_destroy(&fh->subscribe_lock);
+	mutex_destroy(&fh->ev_fh.subscribe_lock);
 	fh->vdev = NULL;
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_exit);
diff --git a/include/media/media-evbase.h b/include/media/media-evbase.h
new file mode 100644
index 000000000000..011ca990fcc4
--- /dev/null
+++ b/include/media/media-evbase.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * media-evbase.h
+ *
+ * Copyright (C) 2018--2019 Intel Corporation
+ */
+
+#ifndef MEDIA_EVBASE_H
+#define MEDIA_EVBASE_H
+
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+struct list_head;
+
+/*
+ * struct media_evbase_fh - File handles for media subsystem events
+ *
+ * @lock: serialise access to fields and lists (apart from wait)
+ * @subscribe_lock: serialise changes to the subscribed list; guarantee that
+ *		    the add and del event callbacks are orderly called
+ * @wait: waiting list for the events
+ * @subscribed: list of subscribed events
+ * @available: list of events waiting to be dequeued
+ * @navailable: number of available events at @available list
+ * @sequence: event sequence number
+ *
+ */
+struct media_evbase_fh {
+	spinlock_t		*lock;
+	struct mutex		subscribe_lock;
+	wait_queue_head_t	*wait;
+
+	struct list_head	subscribed;
+	struct list_head	available;
+	unsigned int		navailable;
+	u32			sequence;
+};
+
+#endif /* MEDIA_EVBASE_H */
diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
index aad4b3689d7e..cd5bb7972699 100644
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -18,6 +18,8 @@
 #include <linux/list.h>
 #include <linux/videodev2.h>
 
+#include <media/media-evbase.h>
+
 struct video_device;
 struct v4l2_ctrl_handler;
 
@@ -28,32 +30,20 @@ struct v4l2_ctrl_handler;
  * @vdev: pointer to &struct video_device
  * @ctrl_handler: pointer to &struct v4l2_ctrl_handler
  * @prio: priority of the file handler, as defined by &enum v4l2_priority
- *
- * @wait: event' s wait queue
- * @subscribe_lock: serialise changes to the subscribed list; guarantee that
- *		    the add and del event callbacks are orderly called
- * @subscribed: list of subscribed events
- * @available: list of events waiting to be dequeued
- * @navailable: number of available events at @available list
- * @sequence: event sequence number
+ * @wait: file handle's wait queue
  *
  * @m2m_ctx: pointer to &struct v4l2_m2m_ctx
+ * @ev_fh: file handle specific data for events
  */
 struct v4l2_fh {
 	struct list_head	list;
 	struct video_device	*vdev;
 	struct v4l2_ctrl_handler *ctrl_handler;
 	enum v4l2_priority	prio;
-
-	/* Events */
 	wait_queue_head_t	wait;
-	struct mutex		subscribe_lock;
-	struct list_head	subscribed;
-	struct list_head	available;
-	unsigned int		navailable;
-	u32			sequence;
 
 	struct v4l2_m2m_ctx	*m2m_ctx;
+	struct media_evbase_fh	ev_fh;
 };
 
 /**

-- 
2.56.0

