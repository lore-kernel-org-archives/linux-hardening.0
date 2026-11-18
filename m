Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005872;
	b=F4KxcsbfQFrFaWEtc4t/Zqhyp2Pr6Zjj9YTrAX+eDY06aP0i3Vr0ckqZbqfa2bLXDtVV
	 4LQDj8jj7HE7fK0Lvsh8wCUtDuT7TD789S9281JpmpkzZWcnY5WueqXaEfa08eKjRLKQc
	 DYYYDZd/1rt5kEVIvy/2bdpR6jrjamAZaViHiJus3rOA85mPuOGdlPUAS7ZAF3dOQNtMX
	 quWm8D8dnacSzvHxTzbN8cLUlrlzDEFhNoAW3Z1IYGed46lKQEm0182IVizPSF5bINFiY
	 meD2VVnELI4/OL9Wgx3ZeVaMVh2TYB48i9UggiPStybAEDbmakftz+mzW402J20DwhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005872;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zq/i7+yl2MPIxRruYif9nubjiR5feqptCTPNSxOt5p0=;
	b=nlrPbgYkJgy7QfujtJ3IIZHVSKwIQ+XdIrTWdxOhi4OoF8Rzy/VFpcOTjyd7lg1RipR6
	 SIPtWE1QDFT30AjYjobGpJAL0kMbSfqenMZh76wouuK+2lBOYvBiZQ8YUr4XkiEimvbzf
	 XqJjdCFT2hpGlnMZhCzaSLXQJrb3rgMQVINzJPCmnS2MtjvUDMozfORt3cDVj+4nKCdBV
	 DoeeizEs/8OChb60qimj2cthwI0LCpWOyD4FEEIK03XSd9trb3g1yiUR3uZLecG3xKsM3
	 /atpcbyySS0ktzHUo51cYnr0g4EcTe7/qpKWxktTNF4hKdeidw0/pIGxWLFAD8ln1+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgYotqeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2445606A335;
	Wed, 18 Nov 2026 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgYotqeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104321F000C4;
	Wed, 18 Nov 2026 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005871;
	bh=zq/i7+yl2MPIxRruYif9nubjiR5feqptCTPNSxOt5p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fgYotqeDFAlDDAu/HLnqUynZY3oiEtvldhS7N5iFE0xgOhjTPnJGAQklvm5pO8dR0
	 CSS3BFoZqEzBsRZVqjCtLDOwP3wgKdSjnK5jAbYpb181Lp/e9b45ecXhPSBaSL7LzI
	 qf62WUz7hxOlnhCykqk/55iKJG9pSdZ9ncAWG4Q+2rW55bS3nH7kMoz3aNU5a9vgWZ
	 AMisvZZvLOUM/Bh51DcOwH2ryxz9rRt6nU6WUSns+UT2TgcgczzT5tPWAPlAFcFY4v
	 IckuytYtUPFFw3aPmElzKZmAKn5G/KieKdQuepgWDL9cB9fP8HLXoo9FFIoszZWrBX
	 vccLPaCsjmULw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:58 +0100
Subject: [PATCH RFC v2 14/16] media: mc: Add detect polling helpers for
 drivers
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
Message-Id: <20261118-v4l2-sensor-detect-v2-14-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7837;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=BF10ZY5pMgSWR41NphsQ2oXRmCnNrGo9djDtw79PU9w=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2MbfNCu44s47ln+P8YKTf5at+YaeCmEe4Oo
 K0fLad2B2uJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2djAAKCRAZDR20Zk4Z
 NeMDB/9C809Hy46vWrN8+lqEX8u9aPTdO/oK2JnDVxF6ofUPGyBpdI0Xu8QqZzqRuMx7FkwYyvG
 //v9ms8ZMraJNEnA7g5cxtP/Psz/VUJ+J4zYbOsIvduAHt2qvaex3qS+mcbMXV+qWV7HHs6o/w/
 5lEQFdoXAph0ciJfdgzcboHFJNBozjTz7C+Kyz+k5MKE+F349KL2GNX2rK6xZyed+5taXPlqnwO
 HD770hqXQ7dowyIrTLTuJX25pjUQw14pdZ8vNIbHT++gxjym0H86hAcQi6dreoPbClGUp0lh5zO
 Wx7jO693WOgqcSlE+xr5WypsmWz+WK6g9B8vfvRC6XHKrZkG
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

If a stream is ongoing and an entity gets disconnected from the media
graph, userspace will hang on DQBUF without any additional information.

When fault tolerance is enabled, the media controller can notify
userspace of such happening by periodically polling all entities that
support the .detect() operation.

If an entity's status change, userspace gets notified via the
MEDIA_EVENT_ENTITY_STATUS_CHANGE event.

Add media_detect_poll_enable/disable so that drivers can opt-in into
polling for .detect().

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/mc/mc-device.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 include/media/media-device.h |  4 +++
 include/media/media-entity.h | 32 ++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 6f5b2daa1177..76b099aa23cd 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/usb.h>
 #include <linux/version.h>
+#include <linux/workqueue.h>
 
 #include <media/media-device.h>
 #include <media/media-devnode.h>
@@ -700,6 +701,9 @@ static void __media_device_unregister_entity(struct media_entity *entity)
 
 	ida_free(&mdev->entity_internal_idx, entity->internal_idx);
 
+	if (!list_empty(&entity->detect_list))
+		list_del_init(&entity->detect_list);
+
 	/* Remove all interface links pointing to this entity */
 	list_for_each_entry(intf, &mdev->interfaces, graph_obj.list) {
 		list_for_each_entry_safe(link, tmp, &intf->links, list) {
@@ -738,6 +742,7 @@ int __must_check media_device_register_entity(struct media_device *mdev,
 	WARN_ON(entity->graph_obj.mdev != NULL);
 	entity->graph_obj.mdev = mdev;
 	INIT_LIST_HEAD(&entity->links);
+	INIT_LIST_HEAD(&entity->detect_list);
 	entity->num_links = 0;
 	entity->num_backlinks = 0;
 
@@ -820,6 +825,76 @@ static int media_device_requests(struct seq_file *file, void *priv)
 }
 #endif
 
+#define MEDIA_DETECT_POLL_INTERVAL_MS	10000
+
+static void media_detect_work_fn(struct work_struct *work)
+{
+	struct media_device *mdev = container_of(to_delayed_work(work),
+						 struct media_device,
+						 detect_work);
+	struct media_entity *entity;
+	int ret;
+
+	if (!mutex_trylock(&mdev->graph_mutex)) {
+		schedule_delayed_work(&mdev->detect_work,
+				      msecs_to_jiffies(MEDIA_DETECT_POLL_INTERVAL_MS));
+		return;
+	}
+
+	list_for_each_entry(entity, &mdev->detect_entities, detect_list) {
+		ret = media_entity_call(entity, detect);
+		if (ret >= 0)
+			__media_entity_set_status(entity, ret);
+	}
+
+	if (!list_empty(&mdev->detect_entities))
+		schedule_delayed_work(&mdev->detect_work,
+				      msecs_to_jiffies(MEDIA_DETECT_POLL_INTERVAL_MS));
+
+	mutex_unlock(&mdev->graph_mutex);
+}
+
+void media_detect_poll_enable(struct media_entity *entity)
+{
+	struct media_device *mdev = entity->graph_obj.mdev;
+
+	if (!media_fault_tolerance_enabled())
+		return;
+
+	mutex_lock(&mdev->graph_mutex);
+
+	if (!list_empty(&entity->detect_list))
+		goto out;
+
+	list_add_tail(&entity->detect_list, &mdev->detect_entities);
+	schedule_delayed_work(&mdev->detect_work,
+			      msecs_to_jiffies(MEDIA_DETECT_POLL_INTERVAL_MS));
+out:
+	mutex_unlock(&mdev->graph_mutex);
+}
+EXPORT_SYMBOL_GPL(media_detect_poll_enable);
+
+void media_detect_poll_disable(struct media_entity *entity)
+{
+	struct media_device *mdev = entity->graph_obj.mdev;
+
+	if (!media_fault_tolerance_enabled())
+		return;
+
+	mutex_lock(&mdev->graph_mutex);
+
+	if (list_empty(&entity->detect_list))
+		goto out;
+
+	list_del_init(&entity->detect_list);
+
+	if (list_empty(&mdev->detect_entities))
+		cancel_delayed_work(&mdev->detect_work);
+out:
+	mutex_unlock(&mdev->graph_mutex);
+}
+EXPORT_SYMBOL_GPL(media_detect_poll_disable);
+
 void media_device_init(struct media_device *mdev)
 {
 	INIT_LIST_HEAD(&mdev->entities);
@@ -828,6 +903,8 @@ void media_device_init(struct media_device *mdev)
 	INIT_LIST_HEAD(&mdev->links);
 	INIT_LIST_HEAD(&mdev->entity_notify);
 	INIT_LIST_HEAD(&mdev->fh_list);
+	INIT_LIST_HEAD(&mdev->detect_entities);
+	INIT_DELAYED_WORK(&mdev->detect_work, media_detect_work_fn);
 
 	mutex_init(&mdev->req_queue_mutex);
 	mutex_init(&mdev->graph_mutex);
@@ -849,6 +926,7 @@ EXPORT_SYMBOL_GPL(media_device_init);
 
 void media_device_cleanup(struct media_device *mdev)
 {
+	cancel_delayed_work_sync(&mdev->detect_work);
 	ida_destroy(&mdev->entity_internal_idx);
 	mdev->entity_internal_idx_max = 0;
 	media_graph_walk_cleanup(&mdev->pm_count_walk);
@@ -945,6 +1023,8 @@ void media_device_unregister(struct media_device *mdev)
 	if (mdev == NULL)
 		return;
 
+	cancel_delayed_work_sync(&mdev->detect_work);
+
 	mutex_lock(&mdev->graph_mutex);
 
 	/* Check if mdev was ever registered at all */
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 9a0f38914354..d1db783db4ac 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 #include <media/media-devnode.h>
 #include <media/media-entity.h>
@@ -199,6 +200,9 @@ struct media_device {
 
 	struct list_head fh_list;
 	spinlock_t fh_list_lock;
+
+	struct list_head detect_entities;
+	struct delayed_work detect_work;
 };
 
 /* We don't need to include usb.h here */
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index b0e1fc627d17..dea3a742a21a 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -343,6 +343,9 @@ enum media_entity_type {
  *		re-used if entities are unregistered or registered again.
  * @pads:	Pads array with the size defined by @num_pads.
  * @links:	List of data links.
+ * @detect_list: Entry in &media_device.detect_entities for poll-based
+ *		detection. Managed by media_detect_poll_enable() /
+ *		media_detect_poll_disable().
  * @ops:	Entity operations.
  * @use_count:	Use count for the entity.
  * @info:	Union with devnode information.  Kept just for backward
@@ -372,6 +375,7 @@ struct media_entity {
 
 	struct media_pad *pads;
 	struct list_head links;
+	struct list_head detect_list;
 
 	const struct media_entity_operations *ops;
 
@@ -1067,6 +1071,34 @@ void media_entity_set_status(struct media_entity *entity, u32 status);
  */
 int media_entity_detect_or_fail(struct media_entity *entity);
 
+/**
+ * media_detect_poll_enable - Enable periodic .detect() polling for an entity
+ * @entity: The entity to poll
+ *
+ * Add @entity to the media device's detect poll list and schedule the
+ * detect worker if not already running. The worker periodically calls
+ * the entity's &media_entity_operations.detect() operation and updates
+ * the entity status on change.
+ *
+ * Intended to be called from the driver's enable_streams() callback,
+ * so that detection polling only runs while the entity is powered and
+ * streaming.
+ *
+ * The entity must implement the .detect() operation.
+ */
+void media_detect_poll_enable(struct media_entity *entity);
+
+/**
+ * media_detect_poll_disable - Disable periodic .detect() polling for an entity
+ * @entity: The entity to stop polling
+ *
+ * Remove @entity from the media device's detect poll list. If no more
+ * entities are being polled, the detect worker is cancelled.
+ *
+ * Intended to be called from the driver's disable_streams() callback.
+ */
+void media_detect_poll_disable(struct media_entity *entity);
+
 /**
  * media_entity_pipeline - Get the media pipeline an entity is part of
  * @entity: The entity

-- 
2.56.0

