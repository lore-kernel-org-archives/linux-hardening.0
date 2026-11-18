Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005867;
	b=YrTTSj2ELz5qnakqavu9osMtTOrmkNhdWd3H1Ftqxw2cn7/mBt2Ej0OtJo7kKNbIF3eG
	 o9XWnGtMr/lqIeoKP7l28lvZLhZHr3NFoXNltg69CK+5bNhQPROb8HEUxUD7PbQsl8GJg
	 flNhInpHLbFyvhrcUy6IC1BANWzjo5Rcr09B8PSnBl2m8cPZRpCEpZVbIBJMb4MduWmaJ
	 1Pc8sUAHqCGiAmzU8hkoDwJOF7lDFF0lX7Ape2WPRkhMgLj8nGpEKtGvWZtT4pVbtcpht
	 ipAVh8CBigSqG1qeZrsCQSnLeei6YAxQ8Z/sePf89/mm7Jz0BK5Zzl3sbHlhzxT9Sbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005867;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cqE2BNkT7Ny7UfvCvLZNY6kEK0BkuwhZlm3qdN8zil0=;
	b=LUd6t6wk97H4O1mTLvNNjkA+ze1o+UZdSL7ihyvO8V4c5QCyVoUx7N0KYZ5/xBzZooZC
	 EX/uImdpMjQRUDPYs3aJVAqZ4jcrHHksYLbkEMkoMaN+VmhrR7MZqFWXquZ3RjfRMSCK8
	 V0vxi8aQ5Nh+5DGZBYSIXN3SBM/Bw/IeosQHn6yYpTSibx5KqmcYBy2jTJivqjkvZKNY9
	 wGgCbluciAPFT8dWlncsF+TZFCtPA00JDK+GT/NQICMY44aPhI6g+iS77mh6g4xpB1XSZ
	 UiHz7qovSKenppaimNEbuSXWTUCIDj3Rbt1vRD+ZKOQt48MdZ3Dm2dDONgeTHN1yM+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv4I6nMv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B7606A32F;
	Wed, 18 Nov 2026 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv4I6nMv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730831F000C5;
	Wed, 18 Nov 2026 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005866;
	bh=cqE2BNkT7Ny7UfvCvLZNY6kEK0BkuwhZlm3qdN8zil0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zv4I6nMvWzn3wECqTmQwc3UEryXWxuEP2SzJLVTbFE3BzPIUDSwhFqvdenzHa3RKG
	 AByXdDToALbZP1N8luO+9f2SJmewDUJXvGdd3LfuqielmjptUXm3zZ48KvO7E6ed6q
	 5zzALso1wfr4siev4LyZqLtZIm9wVI8AvB6zNsj5bSxOAKNpVkVYdH5xjmNzOsGuhL
	 ekzBwxRG5lr79EKXfY4521mdxsf93Wo0x3oRL9OFlI2T9VkY3Zb/abHZN81D1qhEkH
	 lB7yveebh1u/rJnyGReeoKNUSkSZ9ldoWACr3zpFT96tv9qgcuMt05sP2trtr25exq
	 ZmXvWI+b0SkvQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:56 +0100
Subject: [PATCH RFC v2 12/16] media: mc: Add MEDIA_IOC_G_ENTITY_STATUS
 ioctl
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
Message-Id: <20261118-v4l2-sensor-detect-v2-12-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6740;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=KF2AgFtSkuFxQn7qcz47SIB4KQmxRiBm/YiSoWbaDAI=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2M/1Y7nXk6i3R4avJNNMMvRzIFsTuzftrUa
 UsAtH19KAmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2djAAKCRAZDR20Zk4Z
 NWBwB/435Z8CAUO72qmik8uDgOKU2YDKvF2b61pGgLg0ZNI8zF0yhkrODitwhvLjAXGkqtuV9q8
 0cXdrIO0qHUqjk3njPtethQwq/fE3KbnMtyQlHbvvd6YOV/FfRh1c6d2ZFEHYWA65cEwnWQExfl
 SWffOrjxHhMt26e9XmqWusXzLkqy2kP98jJ5StiMlCQ1aaWTg4k2bEZrHS7Hx85VnTlAhH1NvEj
 xQpPcUw196hxVNkkAr7C8lalHcv68T1vOEMvViwoVkwEJmGkkf4mE9Xlxn+FAMIOGN/PL93+08O
 m2P3SJStKcROBM0S3W/Q2q9+EgQPFUlZUH6VUEr4260ZtAlq
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

Userspace can get an entity's connection status using 'media-ctl -p'.
This calls MEDIA_IOC_G_TOPOLOGY which will also provide the entity
status.
However, that status is from the cache. When fault tolerance is enabled,
the status can be only be updated in 2 ways:
1. During driver probe
2. When a stream is started

Add MEDIA_IOC_G_ENTITY_STATUS which allows userspace to get the hardware
state at any given time.
This can be useful for diagnostics, for example.

Calling MEDIA_IOC_G_ENTITY_STATUS will also update the topology's cached
value.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 .../userspace-api/media/mediactl/media-funcs.rst   |  1 +
 .../media/mediactl/media-ioc-g-entity-status.rst   | 92 ++++++++++++++++++++++
 drivers/media/mc/mc-device.c                       | 23 ++++++
 include/uapi/linux/media.h                         |  7 ++
 4 files changed, 123 insertions(+)

diff --git a/Documentation/userspace-api/media/mediactl/media-funcs.rst b/Documentation/userspace-api/media/mediactl/media-funcs.rst
index a9ce38b7144f..54150179227c 100644
--- a/Documentation/userspace-api/media/mediactl/media-funcs.rst
+++ b/Documentation/userspace-api/media/mediactl/media-funcs.rst
@@ -21,6 +21,7 @@ Function Reference
     media-ioc-request-alloc
     media-ioc-subscribe-event
     media-ioc-dqevent
+    media-ioc-g-entity-status
     request-func-close
     request-func-ioctl
     request-func-poll
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-g-entity-status.rst b/Documentation/userspace-api/media/mediactl/media-ioc-g-entity-status.rst
new file mode 100644
index 000000000000..ee108428c0bb
--- /dev/null
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-g-entity-status.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+.. c:namespace:: MC
+
+.. _media_ioc_g_entity_status:
+
+*********************************
+ioctl MEDIA_IOC_G_ENTITY_STATUS
+*********************************
+
+Name
+====
+
+MEDIA_IOC_G_ENTITY_STATUS - Get the connection status of an entity
+
+Synopsis
+========
+
+.. c:macro:: MEDIA_IOC_G_ENTITY_STATUS
+
+``int ioctl(int fd, MEDIA_IOC_G_ENTITY_STATUS, struct media_entity_status *argp)``
+
+Arguments
+=========
+
+``fd``
+    File descriptor returned by :c:func:`open()`.
+
+``argp``
+    Pointer to struct :c:type:`media_entity_status`.
+
+Description
+===========
+
+To query the connection status of a given entity, applications set the
+``id`` field of a struct :c:type:`media_entity_status` and call the ioctl.
+The driver fills the rest of the structure or returns an
+EINVAL error code when the ``id`` is invalid.
+
+If the entity does not implement detection, the driver sets
+the ``status`` field to ``MEDIA_ENT_STATUS_CONNECTED``.
+
+If the entity supports detection, the driver reads the hardware state at call time
+and sets the ``status`` field accordingly.
+
+.. c:type:: media_entity_status
+
+.. tabularcolumns:: |p{1.5cm}|p{3.0cm}|p{12.0cm}|
+
+.. flat-table:: struct media_entity_status
+    :header-rows:  0
+    :stub-columns: 0
+    :widths: 1 2 8
+
+    *  -  __u32
+       -  ``id``
+       -  Entity ID, set by the application.
+
+    *  -  __u32
+       -  ``status``
+       -  Entity connection status, see :ref:`media-entity-status`.
+
+    *  -  __u32
+       -  ``reserved``\ [6]
+       -  Reserved for future extensions. Drivers and applications must set
+          the array to zero.
+
+.. tabularcolumns:: |p{5.5cm}|p{1.0cm}|p{10.0cm}|
+
+.. _media-entity-status:
+
+.. flat-table:: Entity Status
+    :header-rows:  0
+    :stub-columns: 0
+    :widths: 3 1 4
+
+    *  -  ``MEDIA_ENT_STATUS_CONNECTED``
+       -  0
+       -  The entity hardware is connected and reachable.
+
+    *  -  ``MEDIA_ENT_STATUS_DISCONNECTED``
+       -  1
+       -  The entity hardware is not connected or not reachable.
+
+Return Value
+============
+
+On success 0 is returned, on error -1 and the ``errno`` variable is set
+appropriately. The generic error codes are described at the
+:ref:`Generic Error Codes <gen-errors>` chapter.
+
+EINVAL
+    The ``id`` references a non-existing entity.
diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 9151a47887a7..6f5b2daa1177 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -501,6 +501,28 @@ struct media_ioctl_info {
 	long (*arg_to_user)(void __user *uarg, void *karg, unsigned int cmd);
 };
 
+static long media_device_get_entity_status(struct media_device *mdev,
+					   struct file *file, void *arg)
+{
+	struct media_entity_status *estatus = arg;
+	struct media_entity *entity;
+	int ret;
+
+	entity = find_entity(mdev, estatus->id);
+	if (!entity)
+		return -EINVAL;
+
+	ret = media_entity_call(entity, detect);
+	if (ret >= 0)
+		__media_entity_set_status(entity, ret);
+
+	memset(estatus->reserved, 0, sizeof(estatus->reserved));
+	estatus->id = media_entity_id(entity);
+	estatus->status = entity->status;
+
+	return 0;
+}
+
 static const struct media_ioctl_info ioctl_info[] = {
 	MEDIA_IOC(DEVICE_INFO, media_device_get_info, MEDIA_IOC_FL_GRAPH_MUTEX),
 	MEDIA_IOC(ENUM_ENTITIES, media_device_enum_entities, MEDIA_IOC_FL_GRAPH_MUTEX),
@@ -511,6 +533,7 @@ static const struct media_ioctl_info ioctl_info[] = {
 	MEDIA_IOC(DQEVENT, media_device_event_dequeue, 0),
 	MEDIA_IOC(SUBSCRIBE_EVENT, media_device_event_subscribe, 0),
 	MEDIA_IOC(UNSUBSCRIBE_EVENT, media_device_event_unsubscribe, 0),
+	MEDIA_IOC(G_ENTITY_STATUS, media_device_get_entity_status, MEDIA_IOC_FL_GRAPH_MUTEX),
 };
 
 static long media_device_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index ab1dea809879..9f9ced3fb0e0 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -377,6 +377,12 @@ struct media_v2_topology {
 	__u64 ptr_links;
 } __attribute__ ((packed));
 
+struct media_entity_status {
+	__u32 id;
+	__u32 status;
+	__u32 reserved[6];
+} __attribute__ ((packed));
+
 #define MEDIA_EVENT_ALL			0
 #define MEDIA_EVENT_ENTITY_REGISTRATION	1
 
@@ -416,6 +422,7 @@ struct media_event_subscription {
 #define MEDIA_IOC_SUBSCRIBE_EVENT _IOWR ('|', 0x06, struct media_event_subscription)
 #define MEDIA_IOC_UNSUBSCRIBE_EVENT _IOWR ('|', 0x07, struct media_event_subscription)
 #define MEDIA_IOC_DQEVENT	_IOWR('|', 0x08, struct media_event)
+#define MEDIA_IOC_G_ENTITY_STATUS _IOWR('|', 0x09, struct media_entity_status)
 
 /*
  * These ioctls are called on the request file descriptor as returned

-- 
2.56.0

