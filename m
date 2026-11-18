Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005869;
	b=LS2ZySy4o668saRiyUQ5KjG98mPT/wx6tK4slqr7P6HHCPjqfsq3eSW50vsNn9ByfKLP
	 lMPKUk2+B+T1+rmDN6nrnFP+hsuctzSA2joZWnpqpxCZ5NcSwdQ6zQvuHXCA3+m11TkGz
	 8NwBiwemWXwGxnUhHPow9ajdmIHTnQVUJmF+O8MfO8OKsne0Z9k4uhmgciDiQYeVUUKXH
	 IKuYnhJDkN5K9pA0ihlzSqLxp7BCEKHRnyJ7NBx0ZvMDM0zaiI8CukDCx9aIdJe6ABehJ
	 YdwhsJoyxJNSxS4s1HWxMZoJjCzz0h+mMSOFCKzc3sg+irD2TMoSg8HUe16hP7+A7Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005869;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MTEXLwhDcaKZPv6F99Re1w5rP02dqPk/cok6r6WQaXY=;
	b=3p8rmsdVM/YB+Wc7PAvZgm4tx6jhc09qoR38XMAOvC8Sfu9CSz5Ez4JvVweCsN6P+rEt
	 OwuYbrIYMEIab3zu5VtGMjuU8wDd/NQCZc67hUciS1pW+szGBuB8XmUOWFF1zE6nMh2hf
	 NJeUROSCtEmDaVSuK0nwhI8coI5j1KZ1gIXOVZtQllKegN2FObSN0nD7N+t64CZN+HULb
	 1g2YERucn1gxmtImwvHSf9Z9bENujf/nN6lrm/uGVLZwqrs3CT+XTdOz32lCL+rG9wvHB
	 ZUcHCDWNSpOWobGCrnepqoZyql/H2Xi8F9Ssu+64Tw5mOsvYQ/2SV3ICxysDmRhgWdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3q4hXU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D1606A325;
	Wed, 18 Nov 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3q4hXU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8FA1F000CF;
	Wed, 18 Nov 2026 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005869;
	bh=MTEXLwhDcaKZPv6F99Re1w5rP02dqPk/cok6r6WQaXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g3q4hXU2++EsPefTFxya2SIkKxk3H1uXp0P6E0AVz35TIwvzEl6aOJqgOZTLfrywT
	 C+N8U4MkJKlBEvmS7CeMYpX9S8xGYttamMFP/8uqi1owQJeblQaZFrP1FFQIHv6S48
	 guSMy/R/qkD2u/C8K8lSls5gRDgTfsNvhu0RwDD3ZHIduSZ/Wnk2L8S2EH7mpVVRlB
	 uTisMikcVkaQxEYZggCKK0g8i1F91ETwKCnXWB30wwtfciJ17SgRYgprWcC00YPMbk
	 Je7OHnkQJ3W+V6emucfNM1ypUvrtGFvi95QGkYmz2jbhidvawZ3088Ev68zkznp8lq
	 tKzy2JCG6pUUQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:57 +0100
Subject: [PATCH RFC v2 13/16] media: mc: Add
 MEDIA_EVENT_ENTITY_STATUS_CHANGE event
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
Message-Id: <20261118-v4l2-sensor-detect-v2-13-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=DjVyBQWTJwprWSkL8zlrn6TeiodI6ycVgWEqBsX+PTI=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2MlMKX8NqvG8biXpkL+2PWoI3GOreaj6Zlc
 lpJvJ8W5BOJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2djAAKCRAZDR20Zk4Z
 NX94B/9/TO76zqCOdUegfXl3/WaPQW77+oTqI0dMhXh8gsWiNErFML67dlSW7nK5VVsOg+oFmXu
 lKhtNDMdkQDBmhjIkK+Twqm2Mc3XZoqq25y1r1jidSAscauxOg3hpo140RlA0c/G1MrnhPzSDMo
 OWxqYqd14aDJ0pel9CQnDFWa2nAdzcrYCmc/Lim84Z/439o4TYQnc1+w8vitg0ji9EdGj/b5/O9
 62u7ABg/ZqsIRq9LDjqBKnj33J7sYX72fdBRCOAYXtGfLA6x58UjSy5Lf4tMvKnFAIYfM52t7GU
 CbslbOSZCWWDoI9RSPEyaBv63emTC6EN6+akHRRVv3rRq2Bj
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

Add a media event that notifies userspace when an entity's connection
state changes. This allows userspace to react when a sensor gets
disconnected. For example, by aborting an ongoing stream.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 .../userspace-api/media/mediactl/media-ioc-dqevent.rst         |  5 +++++
 drivers/media/mc/mc-entity.c                                   | 10 +++++++++-
 include/media/media-entity.h                                   |  3 ++-
 include/uapi/linux/media.h                                     |  7 +++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst b/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst
index f7a2cd2675f5..2ae72523afc7 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-dqevent.rst
@@ -112,6 +112,11 @@ subscribe the events.
 	known to be still missing. This number may be less than the total
 	number of all missing entities. However if this number is zero, then
 	all entities have been registered to the media device.
+    * - ``MEDIA_EVENT_ENTITY_STATUS_CHANGE``
+      - 2
+      - Triggered when a media entity connection status changes. The entity
+        id is in ``entity_id`` and the status is encoded in ``status``.
+        See :ref:`MEDIA_IOC_G_ENTITY_STATUS` for details about entity status.
 
 Return Value
 ============
diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 2b5fc5d1b0a4..4c6a1c40d698 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <media/media-entity.h>
 #include <media/media-device.h>
+#include <media/media-event.h>
 
 static inline const char *intf_type(struct media_interface *intf)
 {
@@ -1540,8 +1541,15 @@ void __media_entity_set_status(struct media_entity *entity, u32 status)
 
 	lockdep_assert_held(&mdev->graph_mutex);
 
-	if (entity->status != status)
+	if (entity->status != status) {
 		entity->status = status;
+
+		media_event_queue(mdev, &(struct media_event){
+			.type = MEDIA_EVENT_ENTITY_STATUS_CHANGE,
+			.u.entity_status.entity_id = entity->graph_obj.id,
+			.u.entity_status.status = status,
+		});
+	}
 }
 EXPORT_SYMBOL_GPL(__media_entity_set_status);
 
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 4d66f9823c9d..b0e1fc627d17 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -1042,7 +1042,8 @@ void __media_entity_set_status(struct media_entity *entity, u32 status);
  * @status: The new status (%MEDIA_ENT_STATUS_CONNECTED or
  *	                    %MEDIA_ENT_STATUS_DISCONNECTED)
  *
- * Update the entity's connection status.
+ * Update the entity's connection status. If the status has changed, a
+ * %MEDIA_EVENT_ENTITY_STATUS_CHANGE event is queued to the media device.
  *
  * The entity must be registered with a media device. To set the initial
  * status before registration, assign entity->status directly.
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 9f9ced3fb0e0..4ccffe7434c9 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -385,16 +385,23 @@ struct media_entity_status {
 
 #define MEDIA_EVENT_ALL			0
 #define MEDIA_EVENT_ENTITY_REGISTRATION	1
+#define MEDIA_EVENT_ENTITY_STATUS_CHANGE	2
 
 struct media_event_entity_reg {
 	__u32 entity_id;
 	__u32 pending;
 } __attribute__ ((packed));
 
+struct media_event_entity_status {
+	__u32 entity_id;
+	__u32 status;
+} __attribute__ ((packed));
+
 struct media_event {
 	__u32 type;
 	union {
 		struct media_event_entity_reg entity_reg;
+		struct media_event_entity_status entity_status;
 		__u8 data[64];
 	} u;
 	__u32 reserved[8];

-- 
2.56.0

