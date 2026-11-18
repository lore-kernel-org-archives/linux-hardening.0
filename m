Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005851;
	b=qpM67Mdd9hkA4sd1xIrlt35cDXUdu9WlP9kwERYFHUQBhZM7IY+Nq4HGVFC+b5BZI16T
	 VUnEzYkEVJ1X2qgmolIgmGQrJTvRD4Z8gFJ5wh+kE/2Ct59J2axLNMbEeI1pncmgicIWm
	 9RKIDW5T6aucdgtjT1RRgW1Zc7UsVekpPP4DRtrCmw3tBfztsKxLbee8GKiXsBV4kCDD3
	 CzNlZLa1/7PoV2LSEQGYHrUQK+ieZn/ThreqkEpaHVqIVpA8hYkuiYqnNSoAaZrLlR4cW
	 hLxgWz15B9aZrNqiiOSRAOY/EyGkP7QDwXZf4C12SCL2YRNqw6k9vwoppNGnkPB2Nhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005851;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tjiTkfRPzwq5VkCM+QB8g/eRrK0KFefRpHfa0nCoXZ8=;
	b=C4SqdOkBYJQ0CJQXMUhL21D8v+Wr6nDj71uLtrL9jPKsXuC56nCulMaIUQkqBJZsJm5E
	 F1fZid9RaheggBLDuT5GeepND2Y18j5qZtE2+oE/6qvlLt10O42C9G6BCP+lC3CovYH1G
	 cNVVsaQOjeX7b2IhcTl4THE3nmzXQA7XL8AYYxoqIzRZqoiQ5ti+XLaLMwclMFZ08tvWZ
	 Z7aoDup40jq6Th5W4WrG6MFM7nshzdts2IBJHwfzCLKi7uWMmJWlO9khqS+zqy1EpxNZS
	 V1KgmVSxrlDQ/hM1Z4kzsZG/EukX86jIwS/wkfET/wKmTxlRxdqYKrs60OznnlLKpFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C07UBzk3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249A60A2602;
	Wed, 18 Nov 2026 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C07UBzk3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3698E1F000C4;
	Wed, 18 Nov 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005850;
	bh=tjiTkfRPzwq5VkCM+QB8g/eRrK0KFefRpHfa0nCoXZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C07UBzk3uk36EUurzderb+13MppiuESKxqDwsEDfSQMLvNlXncwCcqbZQP9hJKu1c
	 2wRX92phoyws+9IqM5HBxTUVdAu8BCrfRtQxz5N6HGtLRDKgBLHkDC8fO3AQeoYZvn
	 AtGb7KofqppnBRPS5aFfSpKAdYwidLTU7wFZ6c/eCJzt6o4h/Hz/wkiRlcbULQL0ki
	 7qA0HbtGdKVvuPTSk24tSObnkuYp2v1HkkAGbPoGoROur8U12atzALqlhdZhP1Yp2w
	 +gj3ntKkdx0DKED8u6+OOr8QZmv/UF50MxuJDUuUTOYAjTpuMA6fOuAmLUP3UzNM3z
	 x2xjNYww4Ttog==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:49 +0100
Subject: [PATCH RFC v2 05/16] v4l: event: Split the event framework into
 generic and V4L2 bits
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
Message-Id: <20261118-v4l2-sensor-detect-v2-5-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=24903;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=xo+lJkG/7CT0NBxknIYH56V9uk6Rfqbr9FOAxMAqRU8=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2Lg1ClsLPdiFl16iTATL6DHlxThCFCW3DMX
 M/tuakwJCaJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2diwAKCRAZDR20Zk4Z
 NfuxCACeqGjjEfpZhY1QXyYR6LbxXZ1jxEGufwApZFAIEVV2hz+rJGh1ZAbx7NEt8dRkipt90Mc
 wooywpZdYQTON1Tl5d356K5FJlRYVgzuVKRlDzcAjLRDkI7/pPq6HUyhsCY09KJniN7Y1caEqBb
 P+0OJf62KJJLWn/sYuTOy06ngjoJbbEby43fuDHINvWn6Q0GvwW6ZOLU0lI92smfzlNBOPgi+7b
 P2MMMgvwbFJ//feJWBHq9u1MkC/I0yX4q9xaaeGhSJy9GLIQLZ9VluEaQVix7sJpn7UEjGWH1do
 u3El7ba89In5HYhCRSKB+CYZzBrCt+psZPHqJOsCXakPgr2L
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Split the functionality of the V4L2 event framework into generic and V4L2
specific parts. This enables using the same infrastructure for
implementing events for the Media controller API.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/Kconfig                |   2 +
 drivers/media/mc/Kconfig             |   3 +
 drivers/media/mc/Makefile            |   1 +
 drivers/media/mc/mc-evbase.c         | 260 ++++++++++++++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-event.c | 264 ++++++++++-------------------------
 include/media/media-evbase.h         |  82 +++++++++++
 include/media/v4l2-event.h           |   6 +-
 7 files changed, 425 insertions(+), 193 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 6abc9302cd84..70e090757492 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -162,6 +162,7 @@ config VIDEO_DEV
 	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || MEDIA_PLATFORM_SUPPORT || MEDIA_TEST_SUPPORT
 	depends on (I2C || I2C=n)
 	select RATIONAL
+	select MEDIA_EVENT
 	select VIDEOBUF2_V4L2 if VIDEOBUF2_CORE
 	help
 	  Enables the V4L2 API, used by cameras, analog TV, video grabbers,
@@ -170,6 +171,7 @@ config VIDEO_DEV
 config MEDIA_CONTROLLER
 	bool "Media Controller API"
 	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_DIGITAL_TV_SUPPORT || MEDIA_PLATFORM_SUPPORT
+	select MEDIA_EVENT
 	help
 	  Enable the media controller API used to query media devices internal
 	  topology and configure it dynamically.
diff --git a/drivers/media/mc/Kconfig b/drivers/media/mc/Kconfig
index c82b07d2ef36..9593d7c5b64d 100644
--- a/drivers/media/mc/Kconfig
+++ b/drivers/media/mc/Kconfig
@@ -11,3 +11,6 @@ config MEDIA_CONTROLLER_DVB
 	  Enable the media controller API support for DVB.
 
 	  This is currently experimental.
+
+config MEDIA_EVENT
+	tristate
diff --git a/drivers/media/mc/Makefile b/drivers/media/mc/Makefile
index 2b7af42ba59c..d501327436a5 100644
--- a/drivers/media/mc/Makefile
+++ b/drivers/media/mc/Makefile
@@ -8,3 +8,4 @@ ifneq ($(CONFIG_USB),)
 endif
 
 obj-$(CONFIG_MEDIA_SUPPORT) += mc.o
+obj-$(CONFIG_MEDIA_EVENT) += mc-evbase.o
diff --git a/drivers/media/mc/mc-evbase.c b/drivers/media/mc/mc-evbase.c
new file mode 100644
index 000000000000..7e20f7eac9f8
--- /dev/null
+++ b/drivers/media/mc/mc-evbase.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Media event base
+ *
+ * Copyright (C) 2018--2019 Intel Corporation
+ * Copyright (C) 2009--2010 Nokia Corporation.
+ *
+ * Based on V4L2 events in drivers/media/v4l2-core/v4l2-events.c .
+ */
+
+#include <linux/errno.h>
+#include <linux/lockdep.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <media/media-evbase.h>
+
+/* Caller must hold &fh->lock! */
+struct media_subscribed_evbase *
+media_evbase_is_subscribed(struct media_evbase_fh *fh, const void *evspec)
+{
+	struct media_subscribed_evbase *mse;
+
+	assert_spin_locked(fh->lock);
+
+	list_for_each_entry(mse, &fh->subscribed, list)
+		if (mse->ops->is_subscribed(mse, evspec))
+			return mse;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(media_evbase_is_subscribed);
+
+struct media_subscribed_evbase *
+media_evbase_is_queueable(struct media_evbase_fh *fh, const void *ev)
+{
+	struct media_subscribed_evbase *mse;
+
+	assert_spin_locked(fh->lock);
+
+	list_for_each_entry(mse, &fh->subscribed, list)
+		if (mse->ops->is_queueable(mse, ev))
+			return mse;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(media_evbase_is_queueable);
+
+/* Caller must hold &fh->lock and &fh->subscribe_lock! */
+static void __media_evbase_unsubscribe(struct media_subscribed_evbase *mse)
+{
+	struct media_evbase_fh *fh = mse->fh;
+	unsigned int i;
+
+	lockdep_assert_held(&fh->subscribe_lock);
+	assert_spin_locked(fh->lock);
+
+	/* Remove any pending events for this subscription */
+	for (i = 0; i < mse->in_use; i++) {
+		list_del(&media_evbase_ptr(mse, i)->list);
+		fh->navailable--;
+	}
+	list_del(&mse->list);
+}
+
+static void media_evbase_unsubscribe_one(struct media_subscribed_evbase *mse)
+{
+	struct media_evbase_fh *fh = mse->fh;
+	unsigned long flags;
+
+	lockdep_assert_held(&fh->subscribe_lock);
+
+	spin_lock_irqsave(fh->lock, flags);
+	__media_evbase_unsubscribe(mse);
+	spin_unlock_irqrestore(fh->lock, flags);
+
+	mse->ops->del(mse);
+}
+
+struct media_evbase *__media_evbase_dequeue(struct media_evbase_fh *fh)
+{
+	struct media_evbase *kev;
+
+	assert_spin_locked(fh->lock);
+
+	if (list_empty(&fh->available))
+		return NULL;
+
+	WARN_ON(fh->navailable == 0);
+
+	kev = list_first_entry(&fh->available, struct media_evbase, list);
+	list_del(&kev->list);
+	fh->navailable--;
+
+	kev->mse->first = media_evbase_pos(kev->mse, 1);
+	kev->mse->in_use--;
+
+	return kev;
+}
+EXPORT_SYMBOL_GPL(__media_evbase_dequeue);
+
+void __media_evbase_queue_fh(struct media_evbase_fh *fh, const void *ev, u64 ts)
+{
+	struct media_subscribed_evbase *mse;
+	struct media_evbase *kev;
+	bool copy_payload = true;
+
+	/* Are we subscribed? */
+	mse = media_evbase_is_queueable(fh, ev);
+	if (mse == NULL)
+		return;
+
+	/* Increase event sequence number on fh. */
+	fh->sequence++;
+
+	/* Do we have any free events? */
+	if (mse->in_use == mse->elems) {
+		/* no, remove the oldest one */
+		kev = media_evbase_ptr(mse, 0);
+		list_del(&kev->list);
+		mse->in_use--;
+		mse->first = media_evbase_pos(mse, 1);
+		fh->navailable--;
+		if (mse->elems == 1) {
+			if (mse->ops->replace(mse, kev, ev))
+				copy_payload = false;
+		} else {
+			mse->ops->merge(mse, kev, media_evbase_ptr(mse, 0));
+		}
+	}
+
+	/* Take one and fill it. */
+	kev = media_evbase_ptr(mse, mse->in_use);
+	mse->ops->queue(kev, ev, ts, fh->sequence, copy_payload);
+	mse->in_use++;
+	list_add_tail(&kev->list, &fh->available);
+
+	fh->navailable++;
+
+	wake_up_all(fh->wait);
+}
+EXPORT_SYMBOL_GPL(__media_evbase_queue_fh);
+
+void media_evbase_queue_fh(struct media_evbase_fh *fh, const void *ev, u64 ts)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(fh->lock, flags);
+	__media_evbase_queue_fh(fh, ev, ts);
+	spin_unlock_irqrestore(fh->lock, flags);
+}
+EXPORT_SYMBOL_GPL(media_evbase_queue_fh);
+
+int media_evbase_subscribe(struct media_evbase_fh *fh,
+			  struct media_subscribed_evbase *mse,
+			  unsigned int elems)
+{
+	struct media_subscribed_evbase *found_mse;
+	unsigned long flags;
+	int ret = 0;
+
+	/* Require all callbacks in order to avoid checks elsewhere */
+	if (WARN_ON(!mse->ops->add || !mse->ops->del || !mse->ops->replace ||
+		    !mse->ops->merge || !mse->ops->queue ||
+		    !mse->ops->is_subscribed || !mse->ops->is_queueable ||
+		    !mse->ops->release))
+		return -EINVAL;
+
+	if (elems < 1)
+		return -EINVAL;
+
+	mse->elems = elems;
+
+	mutex_lock(&fh->subscribe_lock);
+
+	spin_lock_irqsave(fh->lock, flags);
+	found_mse = media_evbase_is_subscribed(fh, mse->evspec);
+	if (!found_mse)
+		list_add(&mse->list, &fh->subscribed);
+	spin_unlock_irqrestore(fh->lock, flags);
+
+	if (found_mse) {
+		/* Already listening */
+		mse->ops->release(mse);
+	} else if (mse->ops && mse->ops->add) {
+		unsigned int i;
+
+		for (i = 0; i < elems; i++)
+			media_evbase_ptr(mse, i)->mse = mse;
+
+		ret = mse->ops->add(mse, elems);
+		if (ret) {
+			spin_lock_irqsave(fh->lock, flags);
+			__media_evbase_unsubscribe(mse);
+			spin_unlock_irqrestore(fh->lock, flags);
+			mse->ops->release(mse);
+		}
+	}
+
+	mutex_unlock(&fh->subscribe_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(media_evbase_subscribe);
+
+void media_evbase_unsubscribe_all(struct media_evbase_fh *fh)
+{
+	struct media_subscribed_evbase *mse;
+
+	mutex_lock(&fh->subscribe_lock);
+
+	do {
+		unsigned long flags;
+
+		mse = NULL;
+
+		spin_lock_irqsave(fh->lock, flags);
+
+		if (!list_empty(&fh->subscribed))
+			mse = list_first_entry(&fh->subscribed,
+					       struct media_subscribed_evbase,
+					       list);
+
+		spin_unlock_irqrestore(fh->lock, flags);
+
+		if (mse) {
+			media_evbase_unsubscribe_one(mse);
+			mse->ops->release(mse);
+		}
+	} while (mse);
+
+	mutex_unlock(&fh->subscribe_lock);
+}
+EXPORT_SYMBOL_GPL(media_evbase_unsubscribe_all);
+
+void media_evbase_unsubscribe(struct media_evbase_fh *fh, const void *evspec)
+{
+	struct media_subscribed_evbase *mse;
+	unsigned long flags;
+
+	mutex_lock(&fh->subscribe_lock);
+
+	spin_lock_irqsave(fh->lock, flags);
+	mse = media_evbase_is_subscribed(fh, evspec);
+	spin_unlock_irqrestore(fh->lock, flags);
+
+	if (mse)
+		media_evbase_unsubscribe_one(mse);
+
+	mutex_unlock(&fh->subscribe_lock);
+
+	if (mse)
+		mse->ops->release(mse);
+}
+EXPORT_SYMBOL_GPL(media_evbase_unsubscribe);
+
+MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
+MODULE_DESCRIPTION("Media controller event base framework");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index c8371a4fa90b..3e784e44e6e7 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -4,6 +4,7 @@
  *
  * V4L2 events.
  *
+ * Copyright (C) 2019 Intel Corporation
  * Copyright (C) 2009--2010 Nokia Corporation.
  *
  * Contact: Sakari Ailus <sakari.ailus@iki.fi>
@@ -18,20 +19,6 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 
-static inline size_t media_evbase_pos(const struct media_subscribed_evbase *mse,
-				      unsigned int idx)
-{
-	idx += mse->first;
-	return idx >= mse->elems ? idx - mse->elems : idx;
-}
-
-static inline struct media_evbase *
-media_evbase_ptr(const struct media_subscribed_evbase *mse, unsigned int idx)
-{
-	return (void *)(mse + 1) +
-		media_evbase_pos(mse, idx) * mse->ev_size;
-}
-
 static int v4l2_evop_add(struct media_subscribed_evbase *mse, unsigned int elems)
 {
 	struct v4l2_subscribed_event *sev = to_v4l2_subscribed_event(mse);
@@ -75,41 +62,83 @@ static void v4l2_evop_merge(struct media_subscribed_evbase *mse,
 				&to_v4l2_kevent(new)->event);
 }
 
+static void v4l2_evop_queue(struct media_evbase *kev, const void *__ev,
+			    u64 ts, u32 sequence, bool copy_payload)
+{
+	struct v4l2_event *old = &to_v4l2_kevent(kev)->event;
+	const struct v4l2_event *new = __ev;
+	struct timespec64 ts64;
+
+	old->type = new->type;
+	if (copy_payload)
+		old->u = new->u;
+	old->id = new->id;
+	ts64 = ns_to_timespec64(ts);
+	old->timestamp.tv_sec = ts64.tv_sec;
+	old->timestamp.tv_nsec = ts64.tv_nsec;
+	old->sequence = sequence;
+	to_v4l2_kevent(kev)->ts = ts;
+}
+
+static bool v4l2_evop_is_subscribed(struct media_subscribed_evbase *mse,
+				    const void *__evspec)
+{
+	const struct v4l2_event_spec *evspec = __evspec;
+	struct v4l2_subscribed_event *sev = to_v4l2_subscribed_event(mse);
+
+	return sev->evspec.type == evspec->type &&
+		sev->evspec.id == evspec->id;
+}
+
+static bool v4l2_evup_is_queueable(struct media_subscribed_evbase *mse,
+				   const void *__ev)
+{
+	const struct v4l2_event *ev = __ev;
+	struct v4l2_subscribed_event *sev =
+		container_of(mse, struct v4l2_subscribed_event, mse);
+
+	return sev->evspec.type == ev->type && sev->evspec.id == ev->id;
+}
+
+static void v4l2_evop_release(struct media_subscribed_evbase *mse)
+{
+	kvfree(to_v4l2_subscribed_event(mse));
+}
+
 static const struct media_subscribed_evbase_ops v4l2_event_ops = {
 	.add            = v4l2_evop_add,
 	.del            = v4l2_evop_del,
 	.replace        = v4l2_evop_replace,
 	.merge          = v4l2_evop_merge,
+	.queue          = v4l2_evop_queue,
+	.is_subscribed  = v4l2_evop_is_subscribed,
+	.is_queueable   = v4l2_evup_is_queueable,
+	.release        = v4l2_evop_release,
 };
 
 static int __v4l2_event_dequeue(struct media_evbase_fh *fh,
 				struct v4l2_event *event)
 {
+	struct media_evbase *mev;
 	struct v4l2_kevent *kev;
 	struct timespec64 ts;
 	unsigned long flags;
 
 	spin_lock_irqsave(fh->lock, flags);
 
-	if (list_empty(&fh->available)) {
+	mev = __media_evbase_dequeue(fh);
+	if (!mev) {
 		spin_unlock_irqrestore(fh->lock, flags);
 		return -ENOENT;
 	}
 
-	WARN_ON(fh->navailable == 0);
-
-	kev = to_v4l2_kevent(list_first_entry(&fh->available,
-					      struct media_evbase, list));
-	list_del(&kev->mev.list);
-	fh->navailable--;
+	kev = container_of(mev, struct v4l2_kevent, mev);
 
-	kev->event.pending = fh->navailable;
 	*event = kev->event;
 	ts = ns_to_timespec64(kev->ts);
 	event->timestamp.tv_sec = ts.tv_sec;
 	event->timestamp.tv_nsec = ts.tv_nsec;
-	kev->mev.mse->first = media_evbase_pos(kev->mev.mse, 1);
-	kev->mev.mse->in_use--;
+	event->pending = fh->navailable;
 
 	spin_unlock_irqrestore(fh->lock, flags);
 
@@ -144,76 +173,6 @@ int v4l2_event_dequeue(struct v4l2_fh *fh, struct v4l2_event *event,
 }
 EXPORT_SYMBOL_GPL(v4l2_event_dequeue);
 
-/* Caller must hold fh->lock! */
-static struct v4l2_subscribed_event *v4l2_event_subscribed(
-	struct media_evbase_fh *fh, u32 type, u32 id)
-{
-	struct media_subscribed_evbase *mse;
-
-	assert_spin_locked(fh->lock);
-
-	list_for_each_entry(mse, &fh->subscribed, list) {
-		struct v4l2_subscribed_event *sev =
-			to_v4l2_subscribed_event(mse);
-
-		if (sev->evspec.type == type && sev->evspec.id == id)
-			return sev;
-	}
-
-	return NULL;
-}
-
-static void __v4l2_event_queue_fh(struct media_evbase_fh *fh,
-				  const struct v4l2_event *ev, u64 ts)
-{
-	struct v4l2_subscribed_event *sev;
-	struct v4l2_kevent *kev;
-	bool copy_payload = true;
-
-	/* Are we subscribed? */
-	sev = v4l2_event_subscribed(fh, ev->type, ev->id);
-	if (sev == NULL)
-		return;
-
-	/* Increase event sequence number on fh. */
-	fh->sequence++;
-
-	/* Do we have any free events? */
-	if (sev->mse.in_use == sev->mse.elems) {
-		/* no, remove the oldest one */
-		kev = to_v4l2_kevent(media_evbase_ptr(&sev->mse, 0));
-		list_del(&kev->mev.list);
-		sev->mse.in_use--;
-		sev->mse.first = media_evbase_pos(&sev->mse, 1);
-		fh->navailable--;
-		if (sev->mse.elems == 1) {
-			if (sev->ops && sev->ops->replace) {
-				sev->ops->replace(&kev->event, ev);
-				copy_payload = false;
-			}
-		} else if (sev->ops && sev->ops->merge) {
-			struct v4l2_kevent *second_oldest =
-				to_v4l2_kevent(media_evbase_ptr(&sev->mse, 0));
-			sev->ops->merge(&kev->event, &second_oldest->event);
-		}
-	}
-
-	/* Take one and fill it. */
-	kev = to_v4l2_kevent(media_evbase_ptr(&sev->mse, sev->mse.in_use));
-	kev->event.type = ev->type;
-	if (copy_payload)
-		kev->event.u = ev->u;
-	kev->event.id = ev->id;
-	kev->ts = ts;
-	kev->event.sequence = fh->sequence;
-	sev->mse.in_use++;
-	list_add_tail(&kev->mev.list, &fh->available);
-
-	fh->navailable++;
-
-	wake_up_all(fh->wait);
-}
-
 void v4l2_event_queue(struct video_device *vdev, const struct v4l2_event *ev)
 {
 	struct v4l2_fh *fh;
@@ -228,26 +187,15 @@ void v4l2_event_queue(struct video_device *vdev, const struct v4l2_event *ev)
 	spin_lock_irqsave(&vdev->fh_lock, flags);
 
 	list_for_each_entry(fh, &vdev->fh_list, list)
-		__v4l2_event_queue_fh(&fh->ev_fh, ev, ts);
+		__media_evbase_queue_fh(&fh->ev_fh, ev, ts);
 
 	spin_unlock_irqrestore(&vdev->fh_lock, flags);
 }
 EXPORT_SYMBOL_GPL(v4l2_event_queue);
 
-void v4l2_event_queue_fh(struct v4l2_fh *fh, const struct v4l2_event *ev)
-{
-	unsigned long flags;
-	u64 ts = ktime_get_ns();
-
-	spin_lock_irqsave(fh->ev_fh.lock, flags);
-	__v4l2_event_queue_fh(&fh->ev_fh, ev, ts);
-	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
-}
-EXPORT_SYMBOL_GPL(v4l2_event_queue_fh);
-
 int v4l2_event_pending(struct v4l2_fh *fh)
 {
-	return fh->ev_fh.navailable;
+	return media_evbase_pending(&fh->ev_fh);
 }
 EXPORT_SYMBOL_GPL(v4l2_event_pending);
 
@@ -268,37 +216,17 @@ void v4l2_event_wake_all(struct video_device *vdev)
 }
 EXPORT_SYMBOL_GPL(v4l2_event_wake_all);
 
-static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
-{
-	struct media_evbase_fh *ev_fh = sev->mse.fh;
-	struct v4l2_fh *fh = container_of(ev_fh, struct v4l2_fh, ev_fh);
-	unsigned int i;
-
-	lockdep_assert_held(&fh->ev_fh.subscribe_lock);
-	assert_spin_locked(&fh->vdev->fh_lock);
-
-	/* Remove any pending events for this subscription */
-	for (i = 0; i < sev->mse.in_use; i++) {
-		list_del(&media_evbase_ptr(&sev->mse, i)->list);
-		fh->ev_fh.navailable--;
-	}
-	list_del(&sev->mse.list);
-}
-
 int v4l2_event_subscribe(struct v4l2_fh *fh,
 			 const struct v4l2_event_subscription *sub, unsigned int elems,
 			 const struct v4l2_subscribed_event_ops *ops)
 {
-	struct v4l2_subscribed_event *sev, *found_ev;
-	unsigned long flags;
-	unsigned int i;
-	int ret = 0;
+	struct media_subscribed_evbase *mse;
+	struct v4l2_subscribed_event *sev;
 
 	if (sub->type == V4L2_EVENT_ALL)
 		return -EINVAL;
 
-	if (elems < 1)
-		elems = 1;
+	elems = max(elems, 1U);
 
 	sev = kvzalloc(sizeof(*sev) + array_size(sizeof(struct v4l2_kevent),
 						 elems), GFP_KERNEL);
@@ -306,93 +234,45 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 		return -ENOMEM;
 	sev->mse.elems = elems;
 	sev->mse.ev_size = sizeof(struct v4l2_kevent);
-	for (i = 0; i < elems; i++)
+	for (unsigned int i = 0; i < elems; i++)
 		media_evbase_ptr(&sev->mse, i)->mse = &sev->mse;
 	sev->evspec.type = sub->type;
 	sev->evspec.id = sub->id;
 	sev->evspec.flags = sub->flags;
-	sev->mse.fh = &fh->ev_fh;
+
 	sev->ops = ops;
 
-	mutex_lock(&fh->ev_fh.subscribe_lock);
-
-	spin_lock_irqsave(fh->ev_fh.lock, flags);
-	found_ev = v4l2_event_subscribed(&fh->ev_fh, sub->type, sub->id);
-	if (!found_ev)
-		list_add(&sev->mse.list, &fh->ev_fh.subscribed);
-	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
-
-	if (found_ev) {
-		/* Already listening */
-		kvfree(sev);
-	} else if (sev->ops && sev->ops->add) {
-		ret = sev->ops->add(sev, elems);
-		if (ret) {
-			spin_lock_irqsave(&fh->vdev->fh_lock, flags);
-			__v4l2_event_unsubscribe(sev);
-			spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
-			kvfree(sev);
-		}
-	}
+	mse = &sev->mse;
 
-	mutex_unlock(&fh->ev_fh.subscribe_lock);
+	mse->ops = &v4l2_event_ops;
+	mse->fh = &fh->ev_fh;
+	mse->evspec = &sev->evspec;
 
-	return ret;
+	return media_evbase_subscribe(&fh->ev_fh, mse, elems);
 }
 EXPORT_SYMBOL_GPL(v4l2_event_subscribe);
 
 void v4l2_event_unsubscribe_all(struct v4l2_fh *fh)
 {
-	struct v4l2_event_subscription sub;
-	struct v4l2_subscribed_event *sev;
-	unsigned long flags;
-
-	do {
-		sev = NULL;
-
-		spin_lock_irqsave(fh->ev_fh.lock, flags);
-		if (!list_empty(&fh->ev_fh.subscribed)) {
-			sev = to_v4l2_subscribed_event(
-				list_first_entry(&fh->ev_fh.subscribed,
-						 struct media_subscribed_evbase,
-						 list));
-			sub.type = sev->evspec.type;
-			sub.id = sev->evspec.id;
-		}
-		spin_unlock_irqrestore(fh->ev_fh.lock, flags);
-		if (sev)
-			v4l2_event_unsubscribe(fh, &sub);
-	} while (sev);
+	media_evbase_unsubscribe_all(&fh->ev_fh);
 }
 EXPORT_SYMBOL_GPL(v4l2_event_unsubscribe_all);
 
 int v4l2_event_unsubscribe(struct v4l2_fh *fh,
 			   const struct v4l2_event_subscription *sub)
 {
-	struct v4l2_subscribed_event *sev;
-	unsigned long flags;
+	struct v4l2_event_spec evspec = {
+		.type = sub->type,
+		.id = sub->id,
+		.flags = sub->flags,
+	};
 
 	if (sub->type == V4L2_EVENT_ALL) {
 		v4l2_event_unsubscribe_all(fh);
 		return 0;
 	}
 
-	mutex_lock(&fh->ev_fh.subscribe_lock);
-
-	spin_lock_irqsave(fh->ev_fh.lock, flags);
-
-	sev = v4l2_event_subscribed(&fh->ev_fh, sub->type, sub->id);
-	if (sev != NULL)
-		__v4l2_event_unsubscribe(sev);
-
-	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
-
-	if (sev && sev->ops && sev->ops->del)
-		sev->ops->del(sev);
-
-	mutex_unlock(&fh->ev_fh.subscribe_lock);
-
-	kvfree(sev);
+	media_evbase_unsubscribe(&fh->ev_fh, &evspec);
 
 	return 0;
 }
diff --git a/include/media/media-evbase.h b/include/media/media-evbase.h
index bfb36a946386..06993f9d2f6a 100644
--- a/include/media/media-evbase.h
+++ b/include/media/media-evbase.h
@@ -61,6 +61,10 @@ struct media_evbase_fh {
  *		Returns true if the payload of 'new' was consumed, false if
  *		the caller still needs to copy it.
  * @merge:	Callback that can merge event 'old' into event 'new'.
+ * @queue:	Copy a user-provided event to the event queue.
+ * @is_subscribed: Tell whether a specified subscription already exists.
+ * @is_queueable: Tell whether a given event matches a subscription.
+ * @release:	Called to release a media event subscription.
  */
 struct media_subscribed_evbase_ops {
 	int  (*add)(struct media_subscribed_evbase *mse, unsigned int elems);
@@ -69,6 +73,13 @@ struct media_subscribed_evbase_ops {
 			struct media_evbase *old, const void *new);
 	void (*merge)(struct media_subscribed_evbase *mse,
 		      const struct media_evbase *old, struct media_evbase *new);
+	void (*queue)(struct media_evbase *kev, const void *__ev, u64 ts,
+		      u32 sequence, bool copy_payload);
+	bool (*is_subscribed)(struct media_subscribed_evbase *mse,
+			      const void *evspec);
+	bool (*is_queueable)(struct media_subscribed_evbase *mse,
+			     const void *ev);
+	void (*release)(struct media_subscribed_evbase *mse);
 };
 
 /**
@@ -115,4 +126,75 @@ struct media_subscribed_evbase {
 struct media_evbase_subscription {
 };
 
+/**
+ * media_evbase_pos - Tell the position of the event structure in the event array
+ *
+ * @mse: The media event subscription
+ * @idx: Position in the event array from the first used event (mse->first)
+ */
+static inline size_t media_evbase_pos(const struct media_subscribed_evbase *mse,
+				     unsigned int idx)
+{
+	idx += mse->first;
+	return idx >= mse->elems ? idx - mse->elems : idx;
+}
+
+/**
+ * media_evbase_ptr - Tell the pointer to the next event structure in the event
+ *		     array
+ *
+ * @mse: The media event subscription
+ * @idx: Position in the event array from the first used event (mse->first)
+ */
+static inline struct media_evbase *
+media_evbase_ptr(const struct media_subscribed_evbase *mse, unsigned int idx)
+{
+	return (void *)(mse + 1) +
+		media_evbase_pos(mse, idx) * mse->ev_size;
+}
+
+/* Caller must hold fh->lock! */
+struct media_subscribed_evbase *
+media_evbase_is_subscribed(struct media_evbase_fh *fh, const void *evspec);
+
+struct media_evbase *__media_evbase_dequeue(struct media_evbase_fh *fh);
+
+void media_evbase_unsubscribe(struct media_evbase_fh *fh, const void *evspec);
+
+void media_evbase_unsubscribe_all(struct media_evbase_fh *fh);
+
+/**
+ * __media_evbase_queue_fh - Queue events to the media event file descriptor
+ *
+ * @fh: pointer to &struct media_evbase_fh
+ * @ev: pointer to &struct v4l2_event
+ *
+ * Queue an event to the media event file descriptor. The caller is responsible
+ * for acquiring fh->lock before calling this function.
+ */
+void __media_evbase_queue_fh(struct media_evbase_fh *fh, const void *ev, u64 ts);
+
+/**
+ * __media_evbase_queue_fh - Queue events to the media event file descriptor
+ *
+ * @fh: pointer to &struct media_evbase_fh
+ * @ev: pointer to &struct v4l2_event
+ *
+ * Queue an event to the media event file descriptor. This function acquires and
+ * releases fh->lock.
+ */
+void media_evbase_queue_fh(struct media_evbase_fh *fh, const void *ev, u64 ts);
+
+static inline int media_evbase_pending(struct media_evbase_fh *fh)
+{
+	return fh->navailable;
+}
+
+int media_evbase_subscribe(struct media_evbase_fh *fh,
+			  struct media_subscribed_evbase *mse,
+			  unsigned int elems);
+
+struct media_subscribed_evbase *
+media_evbase_is_queueable(struct media_evbase_fh *fh, const void *ev);
+
 #endif /* MEDIA_EVBASE_H */
diff --git a/include/media/v4l2-event.h b/include/media/v4l2-event.h
index 14c95a60700f..7f3e1373ef8e 100644
--- a/include/media/v4l2-event.h
+++ b/include/media/v4l2-event.h
@@ -148,7 +148,11 @@ void v4l2_event_queue(struct video_device *vdev, const struct v4l2_event *ev);
  *    The driver's only responsibility is to fill in the type and the data
  *    fields. The other fields will be filled in by V4L2.
  */
-void v4l2_event_queue_fh(struct v4l2_fh *fh, const struct v4l2_event *ev);
+static inline void v4l2_event_queue_fh(struct v4l2_fh *fh,
+				       const struct v4l2_event *ev)
+{
+	media_evbase_queue_fh(&fh->ev_fh, ev, ktime_get_ns());
+}
 
 /**
  * v4l2_event_wake_all - Wake all filehandles.

-- 
2.56.0

