Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005862;
	b=4gAB7xQnzJvlvL4T/ZildfORa8c01YglNJfNODTvZ+gg2ZzlVRkLX7QtYSunyRdJdm4i
	 3bikJSyzAXoytN9bUrVXtMsuF8O1Y1Nva/+0vz3GKu8xvFRHQ0cbhHAtvbVBhJTAqCVuB
	 nXGvoLT5x6VkmXxguqxy8KImTQ+s4WskI+353L8iPJXN2H4cQWwe+6CUqfrwGuLH2byHr
	 v/Ic5EC3otKuOBWErZczqIFzn8o44opwlGrXbYHuFAD0WyJONcZ7d9Ps4mmBYgdwWx3dz
	 LLvPUKnLvVnWmq1D0uIx3H6j0M7QzEIxGxfrir4RlEc2RTsjpUYYSWdLNfREtSvp9/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005862;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+6FVVfLaLS/hv3N8ozRjQvloBEXDQ0wQOQRvzOzy0Fs=;
	b=Sgtlp1+gm9nXhGyXHjOyfhOGEVIojK7TVBS/bQsrXHys7GUoyIn6HbXed7FDQOz2xgWD
	 3PXzZsjsrAypWCER/+sA9U+FX0mEzElbz7MCkWWX5Qr3vWr8tCXqrDZ03se91rGjgnUwe
	 xFEf3A+E4J8gczXsA+C5OALv/7XoOLLD/fe7XY263VG5QQgGGfNmvzvZ1epnBMqPg09Kg
	 urGGLdNYnOWvWyrnOpY9ozAA5XGOITpqlSY9i3GgtOgAZ7aO2VcPHkp6NU6LVc3ViEEWt
	 rtrvY2iHx67MzLab1kyxjGCEmyWervR4SGogAfaAK7WImEJQd3yyf/xNjNrJUkSNeiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3yoNtrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2B606A33B;
	Wed, 18 Nov 2026 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3yoNtrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DE1F000C5;
	Wed, 18 Nov 2026 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005862;
	bh=+6FVVfLaLS/hv3N8ozRjQvloBEXDQ0wQOQRvzOzy0Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h3yoNtrtRbFltflX20fd9my23X2kNfuYCz3/YAWH2T3oinbKL/+7siUP+cDNYWUfJ
	 Z4ykkwWaZd53sXvlWOF4IJxC61LAQAfXj3Cjuy/CV0K5jYUKt/d80uDO+mPkEwJlbC
	 0+g3v5nq+/+ZtFxr7vhJBcb9OM0+IHEQJdPtqI1M+2Q31h6RMWg2/TseWE+Sut9tGj
	 CJeJeif74kyDPgc/IoOEc+G3z9C3rX/GioPB2RExu3Tslkya3jRHUQB349PR714135
	 GLd8nEqtrEeEV4+MwfNOrXYJPBpn8A+p7TQyVG0nqexLggNgw/tIegPV6d/8Tzu6D+
	 bD/iye0JtBJwA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:54 +0100
Subject: [PATCH RFC v2 10/16] media: media.h: Add entity connection status
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
Message-Id: <20261118-v4l2-sensor-detect-v2-10-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5025;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=K8lJraMRKIl3wB0cnp6/Awfr4ldH/V+0EIfKdxrR/CA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2LPThPyuwIpky0wS2SiEkZIXLJ4Ye9wu/dY
 aEwZ+j5IDmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2diwAKCRAZDR20Zk4Z
 Neu0CADPP5NtAIB8N2SL/IYwBnl681aQ6oRpNXhY+VLIGgmPNIpBOGy606D8NzdemJxlTNquYXs
 AfXN80af3JGIw34YIHxowMstVQqiNLSxSsz4idOq+feR11LrVfuXqQpIQrMhefeL4FVgBxyXRXt
 c+vWcw0ZRwq7Q93YZUhtBBduQ045ZmIL1mb14zGwz8zMGHfhfIRgPDT72ZAco2n3B9LhvDOPNIv
 EnggNoNLVcIx++q5r5U1TyCGALMq+iqlHn65SYLPiyUcJxPw9YLhmWS5z6elm+O++IBX7+vdcj8
 Zag3Ggia8nxRPvE67MQrAtF/Bft7Eu8tPPb3MXdrJTVfcvzl
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

Some elements in the media graph (such as camera sensors) can be
physically disconnected/reconnected. Drivers may still probe in that
case to have a complete media graph.

Add a new entity field, named status, which reflects the connection
status of that particular entity.

This field is retrieved by userspace via the MEDIA_IOC_G_TOPOLOGY and
can be updated from drivers via media_entity_set_status().

When a status is not initialized, it's set to zero (STATUS_CONNECTED).
This matches older media graphs were all entities are always connected.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/mc/mc-device.c |  1 +
 drivers/media/mc/mc-entity.c | 29 +++++++++++++++++++++++++++++
 include/media/media-entity.h | 20 ++++++++++++++++++++
 include/uapi/linux/media.h   |  6 +++++-
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 82f5676afbc0..71cdf079c8a8 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -307,6 +307,7 @@ static long media_device_get_topology(struct media_device *mdev,
 		kentity.id = entity->graph_obj.id;
 		kentity.function = entity->function;
 		kentity.flags = entity->flags;
+		kentity.status = entity->status;
 		strscpy(kentity.name, entity->name,
 			sizeof(kentity.name));
 
diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 7938f785e2e3..c152d3a61d51 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -1530,6 +1530,35 @@ struct media_pipeline *media_entity_pipeline(struct media_entity *entity)
 }
 EXPORT_SYMBOL_GPL(media_entity_pipeline);
 
+void __media_entity_set_status(struct media_entity *entity, u32 status)
+{
+	struct media_device *mdev = entity->graph_obj.mdev;
+
+	/* Do nothing if the entity is not registered. */
+	if (mdev == NULL)
+		return;
+
+	lockdep_assert_held(&mdev->graph_mutex);
+
+	if (entity->status != status)
+		entity->status = status;
+}
+EXPORT_SYMBOL_GPL(__media_entity_set_status);
+
+void media_entity_set_status(struct media_entity *entity, u32 status)
+{
+	struct media_device *mdev = entity->graph_obj.mdev;
+
+	/* Do nothing if the entity is not registered. */
+	if (mdev == NULL)
+		return;
+
+	mutex_lock(&mdev->graph_mutex);
+	__media_entity_set_status(entity, status);
+	mutex_unlock(&mdev->graph_mutex);
+}
+EXPORT_SYMBOL_GPL(media_entity_set_status);
+
 struct media_pipeline *media_pad_pipeline(struct media_pad *pad)
 {
 	return pad->pipe;
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index fa393e840669..1ec62793fc76 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -325,6 +325,10 @@ enum media_entity_type {
  * @flags:	Entity flags, as defined in
  *		:ref:`include/uapi/linux/media.h <media_header>`
  *		(seek for ``MEDIA_ENT_FL_*``)
+ * @status:	Entity connection status, as defined in
+ *		:ref:`include/uapi/linux/media.h <media_header>`
+ *		(seek for ``MEDIA_ENT_STATUS_*``).
+ *		Access with media_entity_set_status()
  * @num_pads:	Number of sink and source pads.
  * @num_links:	Total number of links, forward and back, enabled and disabled.
  * @num_backlinks: Number of backlinks
@@ -352,6 +356,7 @@ struct media_entity {
 	enum media_entity_type obj_type;
 	u32 function;
 	unsigned long flags;
+	u32 status;
 
 	u16 num_pads;
 	u16 num_links;
@@ -1022,6 +1027,21 @@ static inline bool media_entity_is_streaming(const struct media_entity *entity)
 	return false;
 }
 
+void __media_entity_set_status(struct media_entity *entity, u32 status);
+
+/**
+ * media_entity_set_status - Set the connection status of an entity
+ * @entity: The entity
+ * @status: The new status (%MEDIA_ENT_STATUS_CONNECTED or
+ *	                    %MEDIA_ENT_STATUS_DISCONNECTED)
+ *
+ * Update the entity's connection status.
+ *
+ * The entity must be registered with a media device. To set the initial
+ * status before registration, assign entity->status directly.
+ */
+void media_entity_set_status(struct media_entity *entity, u32 status);
+
 /**
  * media_entity_pipeline - Get the media pipeline an entity is part of
  * @entity: The entity
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index b5275acad87f..ab1dea809879 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -302,12 +302,16 @@ struct media_links_enum {
 #define MEDIA_V2_ENTITY_HAS_FLAGS(media_version) \
 	((media_version) >= ((4U << 16) | (19U << 8) | 0U))
 
+#define MEDIA_ENT_STATUS_CONNECTED		0
+#define MEDIA_ENT_STATUS_DISCONNECTED		1
+
 struct media_v2_entity {
 	__u32 id;
 	char name[64];
 	__u32 function;		/* Main function of the entity */
 	__u32 flags;
-	__u32 reserved[5];
+	__u32 status;
+	__u32 reserved[4];
 } __attribute__ ((packed));
 
 /* Should match the specific fields at media_intf_devnode */

-- 
2.56.0

