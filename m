Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005848;
	b=fQicK59fz5BBTD1CwbycHxiyW99dLeStjHqoDJIt5PRrKfc6RTHsH5J6dhfwoUI2xHO6
	 NVbsCMeETS5pVus3neNcJ2zl/nvO87xj1K/9Z6kwxTWz3a7q8O+vSX4CLJX6L8rw0wQDM
	 Tm3kyH4ygKKe56UUlREmPM7G98Ugq2qgT7VptJn/DQ+05fNJFpDJzVzV73V3zidPymaDk
	 5El0QvP85NqXUZd8yTHwSfTYJleGKdMo1k1fk1DTp4oCGHFgUZCloeM8UuPUiZOnDzQ4Z
	 0OHHRwkVJi/xTOF9YY+qIUkJ/El2OegIW4KxGX+mGQ6SgGsKMvX5hP6/XpzaDA8WlRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005848;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f8VeBQSYr0IloNUhXlUTO6Uog7FX+iWd41lMuNaPMes=;
	b=OZ0K5LiIViYkyFeAT8P2m6sN5fXrHOZQEt2IfhxXOB9F8Z41FPAxWdmaOfO1oht17H2v
	 NUau/2CdOwu/3Ly7DNw2Eu6BSBXfIguE0JXrLwR7Iq84wcBT+jYYvNz47kON0wlV9O+Oc
	 zVJjUiffgjKfCH6n3o8q/SIEAbp5SLWEIPb0jckrjsp0uraX4sJaGVtGv0xOuMioRHnPA
	 xU6wd0M6HDphQqhtAMvc0+pdcsV5E+P6CQaxqK07EISZfb99GyH0MB6he6XiWHL9QX9hq
	 otQK7211+yQ1OVZUh0r4oNpMUDVBECZuCkaSOpfObsPZcTEbpp8yyzGe+fGXy17CuTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUnbwPO0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDD606A31C;
	Wed, 18 Nov 2026 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUnbwPO0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C401F000C7;
	Wed, 18 Nov 2026 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005848;
	bh=f8VeBQSYr0IloNUhXlUTO6Uog7FX+iWd41lMuNaPMes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aUnbwPO05yCnYwYurn4hJcKQ4JPElcBkAoXcbYjPL6Sq/DH22JAT4Nki+uq7Tmfy9
	 3BWs7i4VBTSxaebVL7XBvjt4tHU0LfdXSUoNJrJKM1wDJ/Mw/cCmFeCuyPH7wDNOFG
	 2o/1wnZDA3NH3Dq9VywYXSb4Id7DI8g1q5zde6xnJUhbHeT0jEekQR1vN9PB2YG+JR
	 pPhKBhW9RPGtjSDvGOFNSq1XAZqI6XDt0LUwz6QAhTuCAzfli0BayXJ9O52LKFTrTY
	 FilpJcEeNy6ESjpnRyxbp+Av94ZdYEJz/ZH0hETV3Ry2JEUrCq7BP7PsVzy7Q9OBDC
	 /mA19dJqrSqow==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:48 +0100
Subject: [PATCH RFC v2 04/16] v4l: event: Rework data structures for
 separating events and V4L2
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
Message-Id: <20261118-v4l2-sensor-detect-v2-4-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23569;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=sVimjc2CiQLJR48DGyQLNt6XR3AXuBipWnQzpoex8oU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2Kp021/hTYoaxm3kYms0Fz6rW8IehcqjujS
 HpK9v/VZf+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2digAKCRAZDR20Zk4Z
 NVNZB/sF0JLpDSQnHimQBWLpKTYvguTtDnKNgG/4fBH6U41ODYZdW+as8/Zqmqb/LZXVUwcJF0a
 obxm2aSMH4OGCCt2Zc+9HoFciyArcvXOkFZacXzdjKcP8ymw4YSfpf4yNbTzC/YOdf9lsrMkDSt
 NOs0i1nZPaQHIu9Hct58V6mUGql8qkyktLGencGazJlUO2vWO1IpFQeRi5zlbJwNHKPrQY2Jjws
 /rB1Q936F0oT8jFLn/bsFxMxqbs3zxnXaHSWoxVyQkCkzG929tpfkW5IevspZ1kaGOMLZOE4ylQ
 L9O69EOiYGhxy/MlvGdFipr7pF9OinXCO+kUdidwQiiYJHmp
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

The V4L2 event framework will be functionality-wise useful for
implementing events for the media controller. Separate the V4L2 dependent
and V4L2 independent bits from data structures now.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c          |  36 ++++----
 drivers/media/v4l2-core/v4l2-ctrls-api.c  |  16 ++--
 drivers/media/v4l2-core/v4l2-ctrls-core.c |  20 +++--
 drivers/media/v4l2-core/v4l2-event.c      | 140 ++++++++++++++++++++++--------
 include/media/media-evbase.h              |  80 ++++++++++++++++-
 include/media/v4l2-event.h                | 100 +++++++++++++--------
 include/media/v4l2-fh.h                   |  12 +++
 7 files changed, 303 insertions(+), 101 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d2f722bc3459..f8931c6bc918 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2054,7 +2054,7 @@ static void uvc_ctrl_send_event(struct uvc_video_chain *chain,
 	struct uvc_control_mapping *mapping, s32 value, u32 changes)
 {
 	struct v4l2_fh *originator = handle ? &handle->vfh : NULL;
-	struct v4l2_subscribed_event *sev;
+	struct media_subscribed_evbase *mse;
 	struct v4l2_event ev;
 
 	if (list_empty(&mapping->ev_subs))
@@ -2062,11 +2062,15 @@ static void uvc_ctrl_send_event(struct uvc_video_chain *chain,
 
 	uvc_ctrl_fill_event(chain, &ev, ctrl, mapping, value, changes);
 
-	list_for_each_entry(sev, &mapping->ev_subs, node) {
-		if (sev->fh != originator ||
-		    (sev->flags & V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK) ||
+	list_for_each_entry(mse, &mapping->ev_subs, node) {
+		struct v4l2_subscribed_event *sev =
+			to_v4l2_subscribed_event(mse);
+
+		if (media_evbase_fh_to_v4l2(mse->fh) != originator ||
+		    (sev->evspec.flags & V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK) ||
 		    (changes & V4L2_EVENT_CTRL_CH_FLAGS))
-			v4l2_event_queue_fh(sev->fh, &ev);
+			v4l2_event_queue_fh(media_evbase_fh_to_v4l2(mse->fh),
+					    &ev);
 	}
 }
 
@@ -2295,7 +2299,8 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 
 static int uvc_ctrl_add_event(struct v4l2_subscribed_event *sev, unsigned elems)
 {
-	struct uvc_fh *handle = container_of(sev->fh, struct uvc_fh, vfh);
+	struct uvc_fh *handle = container_of(
+		media_evbase_fh_to_v4l2(sev->mse.fh), struct uvc_fh, vfh);
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
 	int ret;
@@ -2304,18 +2309,18 @@ static int uvc_ctrl_add_event(struct v4l2_subscribed_event *sev, unsigned elems)
 	if (ret < 0)
 		return -ERESTARTSYS;
 
-	if (__uvc_query_v4l2_class(handle->chain, sev->id, 0) >= 0) {
+	if (__uvc_query_v4l2_class(handle->chain, sev->evspec.id, 0) >= 0) {
 		ret = 0;
 		goto done;
 	}
 
-	ctrl = uvc_find_control(handle->chain, sev->id, &mapping);
+	ctrl = uvc_find_control(handle->chain, sev->evspec.id, &mapping);
 	if (ctrl == NULL) {
 		ret = -EINVAL;
 		goto done;
 	}
 
-	if (sev->flags & V4L2_EVENT_SUB_FL_SEND_INITIAL) {
+	if (sev->evspec.flags & V4L2_EVENT_SUB_FL_SEND_INITIAL) {
 		struct v4l2_event ev;
 		u32 changes = V4L2_EVENT_CTRL_CH_FLAGS;
 		s32 val = 0;
@@ -2337,11 +2342,11 @@ static int uvc_ctrl_add_event(struct v4l2_subscribed_event *sev, unsigned elems)
 		 * Mark the queue as active, allowing this initial event to be
 		 * accepted.
 		 */
-		sev->elems = elems;
-		v4l2_event_queue_fh(sev->fh, &ev);
+		sev->mse.elems = elems;
+		v4l2_event_queue_fh(media_evbase_fh_to_v4l2(sev->mse.fh), &ev);
 	}
 
-	list_add_tail(&sev->node, &mapping->ev_subs);
+	list_add_tail(&sev->mse.node, &mapping->ev_subs);
 
 done:
 	mutex_unlock(&handle->chain->ctrl_mutex);
@@ -2350,12 +2355,13 @@ static int uvc_ctrl_add_event(struct v4l2_subscribed_event *sev, unsigned elems)
 
 static void uvc_ctrl_del_event(struct v4l2_subscribed_event *sev)
 {
-	struct uvc_fh *handle = container_of(sev->fh, struct uvc_fh, vfh);
+	struct uvc_fh *handle = container_of(
+		media_evbase_fh_to_v4l2(sev->mse.fh), struct uvc_fh, vfh);
 
 	mutex_lock(&handle->chain->ctrl_mutex);
-	if (__uvc_query_v4l2_class(handle->chain, sev->id, 0) >= 0)
+	if (__uvc_query_v4l2_class(handle->chain, sev->evspec.id, 0) >= 0)
 		goto done;
-	list_del(&sev->node);
+	list_del(&sev->mse.node);
 done:
 	mutex_unlock(&handle->chain->ctrl_mutex);
 }
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-api.c b/drivers/media/v4l2-core/v4l2-ctrls-api.c
index 93d8d4012d0f..0da97e7011eb 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-api.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-api.c
@@ -1277,29 +1277,33 @@ EXPORT_SYMBOL(v4l2_ctrl_subdev_log_status);
 static int v4l2_ctrl_add_event(struct v4l2_subscribed_event *sev,
 			       unsigned int elems)
 {
-	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(sev->fh->ctrl_handler, sev->id);
+	struct v4l2_fh *fh = media_evbase_fh_to_v4l2(sev->mse.fh);
+	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(fh->ctrl_handler,
+						sev->evspec.id);
 
 	if (!ctrl)
 		return -EINVAL;
 
 	v4l2_ctrl_lock(ctrl);
-	list_add_tail(&sev->node, &ctrl->ev_subs);
+	list_add_tail(&sev->mse.node, &ctrl->ev_subs);
 	if (ctrl->type != V4L2_CTRL_TYPE_CTRL_CLASS &&
-	    (sev->flags & V4L2_EVENT_SUB_FL_SEND_INITIAL))
-		send_initial_event(sev->fh, ctrl);
+	    (sev->evspec.flags & V4L2_EVENT_SUB_FL_SEND_INITIAL))
+		send_initial_event(media_evbase_fh_to_v4l2(sev->mse.fh), ctrl);
 	v4l2_ctrl_unlock(ctrl);
 	return 0;
 }
 
 static void v4l2_ctrl_del_event(struct v4l2_subscribed_event *sev)
 {
-	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(sev->fh->ctrl_handler, sev->id);
+	struct v4l2_fh *fh = media_evbase_fh_to_v4l2(sev->mse.fh);
+	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(fh->ctrl_handler,
+						sev->evspec.id);
 
 	if (!ctrl)
 		return;
 
 	v4l2_ctrl_lock(ctrl);
-	list_del(&sev->node);
+	list_del(&sev->mse.node);
 	v4l2_ctrl_unlock(ctrl);
 }
 
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 6e751a043a21..433ebe2acf4a 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -56,16 +56,20 @@ void send_initial_event(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl)
 void send_event(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl, u32 changes)
 {
 	struct v4l2_event ev;
-	struct v4l2_subscribed_event *sev;
+	struct media_subscribed_evbase *mse;
 
 	if (list_empty(&ctrl->ev_subs))
 		return;
 	fill_event(&ev, ctrl, changes);
 
-	list_for_each_entry(sev, &ctrl->ev_subs, node)
-		if (sev->fh != fh ||
-		    (sev->flags & V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK))
-			v4l2_event_queue_fh(sev->fh, &ev);
+	list_for_each_entry(mse, &ctrl->ev_subs, node) {
+		struct v4l2_subscribed_event *sev =
+			to_v4l2_subscribed_event(mse);
+
+		if (mse->fh != &fh->ev_fh ||
+		    (sev->evspec.flags & V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK))
+			v4l2_event_queue_fh(media_evbase_fh_to_v4l2(mse->fh), &ev);
+	}
 }
 
 bool v4l2_ctrl_type_op_equal(const struct v4l2_ctrl *ctrl,
@@ -1821,7 +1825,7 @@ int v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 {
 	struct v4l2_ctrl_ref *ref, *next_ref;
 	struct v4l2_ctrl *ctrl, *next_ctrl;
-	struct v4l2_subscribed_event *sev, *next_sev;
+	struct media_subscribed_evbase *mse, *next_mse;
 
 	if (!hdl)
 		return 0;
@@ -1842,8 +1846,8 @@ int v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	/* Free all controls owned by the handler */
 	list_for_each_entry_safe(ctrl, next_ctrl, &hdl->ctrls, node) {
 		list_del(&ctrl->node);
-		list_for_each_entry_safe(sev, next_sev, &ctrl->ev_subs, node)
-			list_del(&sev->node);
+		list_for_each_entry_safe(mse, next_mse, &ctrl->ev_subs, node)
+			list_del(&mse->node);
 		kvfree(ctrl->p_array);
 		kvfree(ctrl);
 	}
diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index a21a44c64264..c8371a4fa90b 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -18,12 +18,70 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 
-static unsigned int sev_pos(const struct v4l2_subscribed_event *sev, unsigned int idx)
+static inline size_t media_evbase_pos(const struct media_subscribed_evbase *mse,
+				      unsigned int idx)
 {
-	idx += sev->first;
-	return idx >= sev->elems ? idx - sev->elems : idx;
+	idx += mse->first;
+	return idx >= mse->elems ? idx - mse->elems : idx;
 }
 
+static inline struct media_evbase *
+media_evbase_ptr(const struct media_subscribed_evbase *mse, unsigned int idx)
+{
+	return (void *)(mse + 1) +
+		media_evbase_pos(mse, idx) * mse->ev_size;
+}
+
+static int v4l2_evop_add(struct media_subscribed_evbase *mse, unsigned int elems)
+{
+	struct v4l2_subscribed_event *sev = to_v4l2_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->add)
+		return sev->ops->add(sev, elems);
+
+	return 0;
+}
+
+static void v4l2_evop_del(struct media_subscribed_evbase *mse)
+{
+	struct v4l2_subscribed_event *sev = to_v4l2_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->del)
+		sev->ops->del(sev);
+}
+
+static bool v4l2_evop_replace(struct media_subscribed_evbase *mse,
+			      struct media_evbase *old,
+			      const void *new)
+{
+	struct v4l2_subscribed_event *sev = to_v4l2_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->replace) {
+		sev->ops->replace(&to_v4l2_kevent(old)->event, new);
+		return true;
+	}
+
+	return false;
+}
+
+static void v4l2_evop_merge(struct media_subscribed_evbase *mse,
+			    const struct media_evbase *old,
+			    struct media_evbase *new)
+{
+	struct v4l2_subscribed_event *sev = to_v4l2_subscribed_event(mse);
+
+	if (sev->ops && sev->ops->merge)
+		sev->ops->merge(&to_v4l2_kevent_const(old)->event,
+				&to_v4l2_kevent(new)->event);
+}
+
+static const struct media_subscribed_evbase_ops v4l2_event_ops = {
+	.add            = v4l2_evop_add,
+	.del            = v4l2_evop_del,
+	.replace        = v4l2_evop_replace,
+	.merge          = v4l2_evop_merge,
+};
+
 static int __v4l2_event_dequeue(struct media_evbase_fh *fh,
 				struct v4l2_event *event)
 {
@@ -40,8 +98,9 @@ static int __v4l2_event_dequeue(struct media_evbase_fh *fh,
 
 	WARN_ON(fh->navailable == 0);
 
-	kev = list_first_entry(&fh->available, struct v4l2_kevent, list);
-	list_del(&kev->list);
+	kev = to_v4l2_kevent(list_first_entry(&fh->available,
+					      struct media_evbase, list));
+	list_del(&kev->mev.list);
 	fh->navailable--;
 
 	kev->event.pending = fh->navailable;
@@ -49,8 +108,8 @@ static int __v4l2_event_dequeue(struct media_evbase_fh *fh,
 	ts = ns_to_timespec64(kev->ts);
 	event->timestamp.tv_sec = ts.tv_sec;
 	event->timestamp.tv_nsec = ts.tv_nsec;
-	kev->sev->first = sev_pos(kev->sev, 1);
-	kev->sev->in_use--;
+	kev->mev.mse->first = media_evbase_pos(kev->mev.mse, 1);
+	kev->mev.mse->in_use--;
 
 	spin_unlock_irqrestore(fh->lock, flags);
 
@@ -89,13 +148,17 @@ EXPORT_SYMBOL_GPL(v4l2_event_dequeue);
 static struct v4l2_subscribed_event *v4l2_event_subscribed(
 	struct media_evbase_fh *fh, u32 type, u32 id)
 {
-	struct v4l2_subscribed_event *sev;
+	struct media_subscribed_evbase *mse;
 
 	assert_spin_locked(fh->lock);
 
-	list_for_each_entry(sev, &fh->subscribed, list)
-		if (sev->type == type && sev->id == id)
+	list_for_each_entry(mse, &fh->subscribed, list) {
+		struct v4l2_subscribed_event *sev =
+			to_v4l2_subscribed_event(mse);
+
+		if (sev->evspec.type == type && sev->evspec.id == id)
 			return sev;
+	}
 
 	return NULL;
 }
@@ -116,35 +179,35 @@ static void __v4l2_event_queue_fh(struct media_evbase_fh *fh,
 	fh->sequence++;
 
 	/* Do we have any free events? */
-	if (sev->in_use == sev->elems) {
+	if (sev->mse.in_use == sev->mse.elems) {
 		/* no, remove the oldest one */
-		kev = sev->events + sev_pos(sev, 0);
-		list_del(&kev->list);
-		sev->in_use--;
-		sev->first = sev_pos(sev, 1);
+		kev = to_v4l2_kevent(media_evbase_ptr(&sev->mse, 0));
+		list_del(&kev->mev.list);
+		sev->mse.in_use--;
+		sev->mse.first = media_evbase_pos(&sev->mse, 1);
 		fh->navailable--;
-		if (sev->elems == 1) {
+		if (sev->mse.elems == 1) {
 			if (sev->ops && sev->ops->replace) {
 				sev->ops->replace(&kev->event, ev);
 				copy_payload = false;
 			}
 		} else if (sev->ops && sev->ops->merge) {
 			struct v4l2_kevent *second_oldest =
-				sev->events + sev_pos(sev, 0);
+				to_v4l2_kevent(media_evbase_ptr(&sev->mse, 0));
 			sev->ops->merge(&kev->event, &second_oldest->event);
 		}
 	}
 
 	/* Take one and fill it. */
-	kev = sev->events + sev_pos(sev, sev->in_use);
+	kev = to_v4l2_kevent(media_evbase_ptr(&sev->mse, sev->mse.in_use));
 	kev->event.type = ev->type;
 	if (copy_payload)
 		kev->event.u = ev->u;
 	kev->event.id = ev->id;
 	kev->ts = ts;
 	kev->event.sequence = fh->sequence;
-	sev->in_use++;
-	list_add_tail(&kev->list, &fh->available);
+	sev->mse.in_use++;
+	list_add_tail(&kev->mev.list, &fh->available);
 
 	fh->navailable++;
 
@@ -207,18 +270,19 @@ EXPORT_SYMBOL_GPL(v4l2_event_wake_all);
 
 static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
 {
-	struct v4l2_fh *fh = sev->fh;
+	struct media_evbase_fh *ev_fh = sev->mse.fh;
+	struct v4l2_fh *fh = container_of(ev_fh, struct v4l2_fh, ev_fh);
 	unsigned int i;
 
 	lockdep_assert_held(&fh->ev_fh.subscribe_lock);
 	assert_spin_locked(&fh->vdev->fh_lock);
 
 	/* Remove any pending events for this subscription */
-	for (i = 0; i < sev->in_use; i++) {
-		list_del(&sev->events[sev_pos(sev, i)].list);
+	for (i = 0; i < sev->mse.in_use; i++) {
+		list_del(&media_evbase_ptr(&sev->mse, i)->list);
 		fh->ev_fh.navailable--;
 	}
-	list_del(&sev->list);
+	list_del(&sev->mse.list);
 }
 
 int v4l2_event_subscribe(struct v4l2_fh *fh,
@@ -236,16 +300,18 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	if (elems < 1)
 		elems = 1;
 
-	sev = kvzalloc_flex(*sev, events, elems);
+	sev = kvzalloc(sizeof(*sev) + array_size(sizeof(struct v4l2_kevent),
+						 elems), GFP_KERNEL);
 	if (!sev)
 		return -ENOMEM;
-	sev->elems = elems;
+	sev->mse.elems = elems;
+	sev->mse.ev_size = sizeof(struct v4l2_kevent);
 	for (i = 0; i < elems; i++)
-		sev->events[i].sev = sev;
-	sev->type = sub->type;
-	sev->id = sub->id;
-	sev->flags = sub->flags;
-	sev->fh = fh;
+		media_evbase_ptr(&sev->mse, i)->mse = &sev->mse;
+	sev->evspec.type = sub->type;
+	sev->evspec.id = sub->id;
+	sev->evspec.flags = sub->flags;
+	sev->mse.fh = &fh->ev_fh;
 	sev->ops = ops;
 
 	mutex_lock(&fh->ev_fh.subscribe_lock);
@@ -253,7 +319,7 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	spin_lock_irqsave(fh->ev_fh.lock, flags);
 	found_ev = v4l2_event_subscribed(&fh->ev_fh, sub->type, sub->id);
 	if (!found_ev)
-		list_add(&sev->list, &fh->ev_fh.subscribed);
+		list_add(&sev->mse.list, &fh->ev_fh.subscribed);
 	spin_unlock_irqrestore(fh->ev_fh.lock, flags);
 
 	if (found_ev) {
@@ -286,10 +352,12 @@ void v4l2_event_unsubscribe_all(struct v4l2_fh *fh)
 
 		spin_lock_irqsave(fh->ev_fh.lock, flags);
 		if (!list_empty(&fh->ev_fh.subscribed)) {
-			sev = list_first_entry(&fh->ev_fh.subscribed,
-					struct v4l2_subscribed_event, list);
-			sub.type = sev->type;
-			sub.id = sev->id;
+			sev = to_v4l2_subscribed_event(
+				list_first_entry(&fh->ev_fh.subscribed,
+						 struct media_subscribed_evbase,
+						 list));
+			sub.type = sev->evspec.type;
+			sub.id = sev->evspec.id;
 		}
 		spin_unlock_irqrestore(fh->ev_fh.lock, flags);
 		if (sev)
diff --git a/include/media/media-evbase.h b/include/media/media-evbase.h
index 011ca990fcc4..bfb36a946386 100644
--- a/include/media/media-evbase.h
+++ b/include/media/media-evbase.h
@@ -8,10 +8,25 @@
 #ifndef MEDIA_EVBASE_H
 #define MEDIA_EVBASE_H
 
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 
-struct list_head;
+struct media_evbase;
+struct media_subscribed_evbase;
+
+/**
+ * struct media_evbase - Internal kernel event struct.
+ * @list:	List node for the media_evbase_fh->available list.
+ * @mse:	Pointer to parent media_subscribed_evbase.
+ *
+ * The sub-system specific event payload must trail this event struct.
+ */
+struct media_evbase {
+	struct list_head	list;
+	struct media_subscribed_evbase *mse;
+};
 
 /*
  * struct media_evbase_fh - File handles for media subsystem events
@@ -37,4 +52,67 @@ struct media_evbase_fh {
 	u32			sequence;
 };
 
+/*
+ * struct media_subscribed_evbase_ops - Subscribed event operations.
+ *
+ * @add:	Called when a new listener is added.
+ * @del:	Called when a listener stops listening.
+ * @replace:	Callback that can replace event 'old' with event 'new'.
+ *		Returns true if the payload of 'new' was consumed, false if
+ *		the caller still needs to copy it.
+ * @merge:	Callback that can merge event 'old' into event 'new'.
+ */
+struct media_subscribed_evbase_ops {
+	int  (*add)(struct media_subscribed_evbase *mse, unsigned int elems);
+	void (*del)(struct media_subscribed_evbase *mse);
+	bool (*replace)(struct media_subscribed_evbase *mse,
+			struct media_evbase *old, const void *new);
+	void (*merge)(struct media_subscribed_evbase *mse,
+		      const struct media_evbase *old, struct media_evbase *new);
+};
+
+/**
+ * struct media_subscribed_evbase - Internal struct representing a subscribed
+ *		event.
+ *
+ * @list:	List node for the v4l2_fh->subscribed list.
+ * @fh:		Filehandle that subscribed to this event.
+ * @node:	List node that hooks into the object's event list
+ *		(if there is one).
+ * @ops:	sub-system specific operations
+ * @elems:	The number of elements in the events array.
+ * @first:	The index of the events containing the oldest available event.
+ * @in_use:	The number of queued events.
+ * @ev_size:	Size of the payload of a single event in the kernel
+ * @evspec:	The event subscription specifier. Sub-system specific.
+ *		Unique for a given subscription.
+ *
+ * The array of sub-system specific in-kernel event array is immediately
+ * followed by struct. The struct shall contain struct media_evbase as its first
+ * member, followed by sub-system specific fields. The size of a single entry in
+ * the array is specified by the ev_size field.
+ *
+ * The sub-system specific struct MUST contain this struct as its last field.
+ */
+struct media_subscribed_evbase {
+	struct list_head	list;
+	struct media_evbase_fh	*fh;
+	struct list_head	node;
+	const struct media_subscribed_evbase_ops *ops;
+	unsigned int		elems;
+	unsigned int		first;
+	unsigned int		in_use;
+	size_t			ev_size;
+	const void		*evspec;
+};
+
+/**
+ * struct media_evbase_subscription - Subscription of an event for a file handle
+ *
+ * A subscription of a given media event. Currently empty. The data is in the
+ * sub-system specific struct which this is a member of.
+ */
+struct media_evbase_subscription {
+};
+
 #endif /* MEDIA_EVBASE_H */
diff --git a/include/media/v4l2-event.h b/include/media/v4l2-event.h
index 3a0e2588361c..14c95a60700f 100644
--- a/include/media/v4l2-event.h
+++ b/include/media/v4l2-event.h
@@ -16,23 +16,24 @@
 #include <linux/videodev2.h>
 #include <linux/wait.h>
 
-struct v4l2_fh;
+#include <media/v4l2-fh.h>
+#include <media/media-evbase.h>
+
 struct v4l2_subdev;
 struct v4l2_subscribed_event;
 struct video_device;
 
 /**
- * struct v4l2_kevent - Internal kernel event struct.
- * @list:	List node for the v4l2_fh->available list.
- * @sev:	Pointer to parent v4l2_subscribed_event.
- * @event:	The event itself.
- * @ts:		The timestamp of the event.
+ * struct v4l2_event_spec - Event subscription parameters
+ *
+ * @type:	V4L2 event type, V4L2_EVENT_*.
+ * @id:		V4L2 event id.
+ * @flags:	V4L2 event flags, V4L2_EVENT_SUB_FL_*.
  */
-struct v4l2_kevent {
-	struct list_head	list;
-	struct v4l2_subscribed_event *sev;
-	struct v4l2_event	event;
-	u64			ts;
+struct v4l2_event_spec {
+	u32 type;
+	u32 id;
+	u32 flags;
 };
 
 /**
@@ -51,34 +52,63 @@ struct v4l2_subscribed_event_ops {
 };
 
 /**
- * struct v4l2_subscribed_event - Internal struct representing a subscribed
- *		event.
+ * struct v4l2_subscribed_event - Describes a single subscribed V4L2 event.
  *
- * @list:	List node for the v4l2_fh->subscribed list.
- * @type:	Event type.
- * @id:	Associated object ID (e.g. control ID). 0 if there isn't any.
- * @flags:	Copy of v4l2_event_subscription->flags.
- * @fh:	Filehandle that subscribed to this event.
- * @node:	List node that hooks into the object's event list
- *		(if there is one).
- * @ops:	v4l2_subscribed_event_ops
- * @elems:	The number of elements in the events array.
- * @first:	The index of the events containing the oldest available event.
- * @in_use:	The number of queued events.
- * @events:	An array of @elems events.
+ * @evspec:	Parameters of the subscribed event.
+ * @ops:	Operations for the subscribed event.
+ * @mse:	Common media event descriptor.
  */
 struct v4l2_subscribed_event {
-	struct list_head	list;
-	u32			type;
-	u32			id;
-	u32			flags;
-	struct v4l2_fh		*fh;
-	struct list_head	node;
+	struct v4l2_event_spec evspec;
 	const struct v4l2_subscribed_event_ops *ops;
-	unsigned int		elems;
-	unsigned int		first;
-	unsigned int		in_use;
-	struct v4l2_kevent	events[] __counted_by(elems);
+	struct media_subscribed_evbase mse;
+};
+
+/**
+ * struct v4l2_kevent - Internal kernel event struct.
+ * @mev:	generic media subsystem kernel event
+ * @event:	The V4L2 event itself.
+ * @ts:		The timestamp of the event.
+ */
+struct v4l2_kevent {
+	struct media_evbase mev;
+	struct v4l2_event event;
+	u64 ts;
+};
+
+/**
+ * to_v4l2_kevent - Convert a generic media kevent into a v4l2_kevent
+ *
+ * @mev: The generic media event
+ */
+static inline struct v4l2_kevent *to_v4l2_kevent(struct media_evbase *mev)
+{
+	return container_of(mev, struct v4l2_kevent, mev);
+}
+
+/**
+ * to_v4l2_kevent - Convert a const generic media_evbase into a v4l2_kevent
+ *
+ * @mev: The generic media event
+ *
+ * This is just like @to_v4l2_event, but const.
+ */
+static inline const struct v4l2_kevent *
+to_v4l2_kevent_const(const struct media_evbase *mev)
+{
+	return container_of(mev, const struct v4l2_kevent, mev);
+}
+
+/**
+ * to_v4l2_subscribed_event - Convert a generic media_subscribed_evbase into
+ *			      a v4l2_subscribed_event.
+ *
+ * @mse: The generic media event
+ */
+static inline struct v4l2_subscribed_event *
+to_v4l2_subscribed_event(struct media_subscribed_evbase *mse)
+{
+	return container_of(mse, struct v4l2_subscribed_event, mse);
 };
 
 /**
diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
index cd5bb7972699..c72083643c13 100644
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -168,4 +168,16 @@ static inline int v4l2_fh_is_singular_file(struct file *filp)
 	return v4l2_fh_is_singular(filp->private_data);
 }
 
+/**
+ * media_evbase_fh_to_v4l2 - Return the struct v4l2_fh pointer from the
+ *			    media event fh
+ *
+ * @fh: pointer to &struct media_evbase_fh
+ */
+static inline struct v4l2_fh *
+media_evbase_fh_to_v4l2(struct media_evbase_fh *fh)
+{
+	return container_of(fh, struct v4l2_fh, ev_fh);
+}
+
 #endif /* V4L2_EVENT_H */

-- 
2.56.0

