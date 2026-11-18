Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005865;
	b=PjqkP99xE4ORkSm5g6AGz1EQamKjxGqmir0z+1qocuaZJ3W3AzD0XWGRiKQXu7a0vSiS
	 8Ui94LjughFgQSY2OWqqrgFUiVOkeXYP2O2vHJPeejkc/lcLP25rXSE8kUS6DlIGpXvsu
	 mpAfqyFqmUXTAeJp+qGhWY90Q4bdnClwKGf4mE6LtWfRf6OfRPYs27NuzRwJ0dyDHyhKO
	 y7E0zXkE9L9DZS8htED9zGoU+3DY5DW56IiyahtjuUUTzbwyqNRu02N2FQsoAUCoz3QzN
	 trd4nlNdIVpl/6Q+cO1ppMT30VuMXRaeo+CnsoHut0A9+VkP4EUHxRp1GnwS5qoo1GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005865;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HEo2F4rQrY5vyKqj97pjba/EVSA2WxWYX/zbXM7siS0=;
	b=y7jNLsgavFlUbraRynuxX4PWESGsB9yyUDmYbzZ+X4kTcGJzWXl1p9CfdGNUXXYsOLnh
	 d6+elN/w0G/brCm1nvIWJMAqA975Vi7snTWIonaIJm6pUz6XhqtV3Eq238Grf1yKn5wAh
	 Oqzm4MVOg/y2GCPYwge+oaXpt7JKuiiq9EimZtwStGqCcw5XhudMA74Ei70JRvRBAop1B
	 UGihq+0IOGSUxz6EX7aITxFE20NYA3/zv48q8yUQzVfqkgqLOgmTwuyqNL2wO7HJt3rRJ
	 KaVAJnhO/H0nLe+x0kOz8A2CAZTMT3L4ZcMyG33zUvIbBU/avMa8UMd790T73Q37jtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y792a5Ex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD1606A32C;
	Wed, 18 Nov 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y792a5Ex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EC41F000C4;
	Wed, 18 Nov 2026 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005864;
	bh=HEo2F4rQrY5vyKqj97pjba/EVSA2WxWYX/zbXM7siS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y792a5ExuYJ69sIOWNbt/vuelw94n7zzG/dVdUNHB8S8xpAUR1m4cCUmbQ/sqeZeJ
	 E9GBLDwLlN9FyUO+u2uzvW3XQNPbWGTOOQj9UE6sZhdfd8MGtNTxWALtW17kVraiCV
	 /+B13e7sSFFstdQtrFGpPRHE3q/RdH/2iLdFuLO5WH/0Sj/z1fIc5lSWOVl7Qte1FW
	 ktNmSfnPGgCfKUIxqrh4YtHXnHXdbj4djdqhCPLJeKUmd24JUP0IWm/UmqPqxa4PP6
	 //e4v8eSohNSjrgsoTH52r0PfgwfHn8CZ/OH52mWOY1DziW/XoRLquP1EnTRmcA9P5
	 N1q/WTGG8KmaA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:55 +0100
Subject: [PATCH RFC v2 11/16] media: mc: Add .detect() to
 media_entity_operations
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
Message-Id: <20261118-v4l2-sensor-detect-v2-11-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5593;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=xwKbn8gMkHOe6IjrJpgwlptayNA14+/ESA7JRGHNCZU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2MxwHwBLWyyy31uegpQwwUnSv5bN4iQGjFf
 4XrKQxIbwWJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2djAAKCRAZDR20Zk4Z
 NabPCACZuOez5kfsqWyEhYxNESXY+QZbYDwodhTN+UCVmTlwGMQx1BSF+nC5R0U9M7hSWwnEFXu
 1pS+cQIN+8TMXvS/z1fc/kDNsxlXf+BydHyrzJ0j2FL1edyYLAcCpVkIjlixGPfMvGKnOd7tRfw
 sLCNzZ4cvJl/1uogveaPY3xWK0jQOmW7H81C+sHR7NGef4bwmwdIi9JE1Cjo68M8GXURaOVPZ4o
 NZ+dztoaf6Ww7QnW6EWzOjy00zkqjtZVur7l3FvMltMKcDG+ZSD5JDrO9+gcwPN9pID0kqC4cNt
 RgFHGZ9HmGlmnX5qL2JoakfmzmhZwkARCYy20RutdBcdEehy
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

When mc.fault_tolerance = true, media drivers can probe without the
underlying hardware being physically connected.
In that case, The media controller core needs to be able to retrieve
the driver state in order to update the topology.

Add a new, optional, media_entity_operation named .detect().

To support fault tolerance, drivers must be modified and do the
following when media_fault_tolerance_enabled() = true:

* Probe must succeed even when the underlying hardware is not present
* Probe must set initial entity connections status if disconnected
* The .detect() operation must be implemented
* .enable_streams() must query hardware for presence and must fail when
  it's not detected. Can be done using the media_entity_detect_or_fail()
  helper.

Note: this is based on the .detect() helpers from DRM connectors.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/mc/mc-device.c | 11 +++++++++++
 drivers/media/mc/mc-entity.c | 22 ++++++++++++++++++++++
 include/media/media-device.h | 10 ++++++++++
 include/media/media-entity.h | 24 ++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 71cdf079c8a8..9151a47887a7 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -14,6 +14,7 @@
 #include <linux/idr.h>
 #include <linux/ioctl.h>
 #include <linux/media.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -27,6 +28,16 @@
 #include <media/media-fh.h>
 #include <media/media-request.h>
 
+static bool fault_tolerance;
+module_param(fault_tolerance, bool, 0444);
+MODULE_PARM_DESC(fault_tolerance, "Enable fault-tolerant support");
+
+bool media_fault_tolerance_enabled(void)
+{
+	return fault_tolerance;
+}
+EXPORT_SYMBOL_GPL(media_fault_tolerance_enabled);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 
 /*
diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index c152d3a61d51..2b5fc5d1b0a4 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -1559,6 +1559,28 @@ void media_entity_set_status(struct media_entity *entity, u32 status)
 }
 EXPORT_SYMBOL_GPL(media_entity_set_status);
 
+int media_entity_detect_or_fail(struct media_entity *entity)
+{
+	int ret;
+
+	if (!media_fault_tolerance_enabled())
+		return 0;
+
+	ret = media_entity_call(entity, detect);
+	if (ret == -ENOIOCTLCMD)
+		return 0;
+	if (ret < 0)
+		return ret;
+
+	media_entity_set_status(entity, ret);
+
+	if (ret == MEDIA_ENT_STATUS_DISCONNECTED)
+		return -ENOLINK;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(media_entity_detect_or_fail);
+
 struct media_pipeline *media_pad_pipeline(struct media_pad *pad)
 {
 	return pad->pipe;
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 3ef277309d59..9a0f38914354 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -204,6 +204,16 @@ struct media_device {
 /* We don't need to include usb.h here */
 struct usb_device;
 
+/**
+ * media_fault_tolerance_enabled - Check if media fault tolerance is enabled
+ *
+ * Returns true when the mc.fault_tolerance module parameter is set.
+ * Drivers should call this to decide whether to enable fault-tolerant
+ * behavior (e.g. probing without the underlying hardware being
+ * physically connected).
+ */
+bool media_fault_tolerance_enabled(void);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 
 /* Supported link_notify @notification values. */
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 1ec62793fc76..4d66f9823c9d 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -269,6 +269,12 @@ struct media_pad {
  *			media_entity_has_pad_interdep().
  *			Optional: If the operation isn't implemented all pads
  *			will be considered as interdependent.
+ * @detect:		Query whether the entity's hardware is physically
+ *			connected and reachable. Must not modify entity state.
+ *			Returns a %MEDIA_ENT_STATUS_* value on success, or
+ *			a negative error code on failure.
+ *			Optional: If the operation isn't implemented the
+ *			entity will be considered as connected
  *
  * .. note::
  *
@@ -284,6 +290,7 @@ struct media_entity_operations {
 	int (*link_validate)(struct media_link *link);
 	bool (*has_pad_interdep)(struct media_entity *entity, unsigned int pad0,
 				 unsigned int pad1);
+	int (*detect)(struct media_entity *entity);
 };
 
 /**
@@ -1042,6 +1049,23 @@ void __media_entity_set_status(struct media_entity *entity, u32 status);
  */
 void media_entity_set_status(struct media_entity *entity, u32 status);
 
+/**
+ * media_entity_detect_or_fail - Detect entity hardware and fail if disconnected
+ * @entity: The entity
+ *
+ * Call the entity's &media_entity_operations.detect() operation to probe
+ * the hardware. If the entity is disconnected, the entity status is updated
+ * and a %MEDIA_EVENT_ENTITY_STATUS_CHANGE event is queued.
+ *
+ * Intended to be called by drivers at the beginning of their
+ * &v4l2_subdev_pad_ops.enable_streams() callback
+ *
+ * Return: 0 if the entity is connected or does not implement .detect(),
+ * -ENOLINK if the entity is disconnected, or a negative error code on
+ * failure.
+ */
+int media_entity_detect_or_fail(struct media_entity *entity);
+
 /**
  * media_entity_pipeline - Get the media pipeline an entity is part of
  * @entity: The entity

-- 
2.56.0

