Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005857;
	b=1CQMCbIOJz8ql5n8/2U1bDT0q2T17fvB+u01VXC8cal3fbXsBK2X5hdVifYN2ePCl8PL
	 Z721QTvu2WDfJKtX74JYVQ3NWnDWO0Zjt4bSWU5HVbOSYkK8IH7LG4cVYwnkUCSivDch1
	 dWyMUxecM+cHobk1aNrco2D8JKhn1hjT0JXv5ViP+lAy6WsWogWpXzgs8SJJ+Hr0IUsFQ
	 XvwyhWoLGFmNV8xgzmn3Kjy/6zN6/mlByflbVVwvMljTeuvD5pwUWDfoW07Bp4R09MiUc
	 i8SOqiHVPvfARDeHu0ZdVRFW1r+j2cCyWvTQm2wWWVMXjjBESZtuoAsSguZBpN3CCWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005857;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=G6cu1Z82N/KT8p79LEvLWumkU68eKo4xwx6zpd/gmmE=;
	b=l4qZwUkLGJ5FkQQ8Zv6RbJzvBFlfMfbKNm3JIcc6EVa4SSoZIGTsjyOdlWZ2AxDD4ymR
	 YSj9zxplQKM+I6i8J4l6SQm4ygNl9EvX1D1sESFY3hhQTUnx82OIyxaGvJcRIEHBsJaar
	 GPxIU9aRZSBUIsk5XkXyVLTQPFJOMOpINGsj4OWM4xDfVgfBg5qWQKbPOg8aH705IzSV7
	 24NCqndXl7HMwDVnCco9iKnYr234f+X0o13s44mp8dcRDN204k284hUezVcbsT3XXuOvW
	 bwUzuHs6FO+MdlEGYAzI9iQyavt0F7Ekginns8KC953iL7Cg/NTi9domKBx+qEQgAdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByKjxoI3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71D60A2612;
	Wed, 18 Nov 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByKjxoI3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FB71F000C5;
	Wed, 18 Nov 2026 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005857;
	bh=G6cu1Z82N/KT8p79LEvLWumkU68eKo4xwx6zpd/gmmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ByKjxoI34jU+4UcernfSQGDTB/gmwUZS9TfWxme8ng12lXC+pKDrKlCHJOO5VyFbu
	 eeCz7cJaW4dyHwZihxIDagIcfn7IxKofQH4yd5TC2US22b/gJzkyCuRIqYgvmap1qK
	 XHarC6mNkDalZMjTyW46Dki76xxVgudSbwVR0GsG0G1y8mg3e5D3kfpZauGCtwGTDp
	 hVFjT5St0CyAdlNRT1dh8m6pxPSQ1S2gZ7XidUPzqWGc/mlVX7oYfgI6yOa9IIrCbR
	 abPiNPF+VaJPRVLL/yVYYwT2dBdPJCJ+eaRVyVBoKltOiqYC0xFQOJ4c/AxaeUbMFC
	 A4RMNIs0CnnxA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:52 +0100
Subject: [PATCH RFC v2 08/16] media: mc: Add
 MEDIA_EVENT_ENTITY_REGISTRATION
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
Message-Id: <20261118-v4l2-sensor-detect-v2-8-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=/ow5W/ic0RXTNQHgmu6clXvJzQJun3gx9pBqQxHuVrU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2LjxPorZZnTniyz9PgzgcAxs9Z0cY1XFV9C
 2vgeUg16S6JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2diwAKCRAZDR20Zk4Z
 NZENCACU/l0gv8wlOAVXuJfVE9lu7CtZ6rBYNb014K7rqGT3Tg6as2TB6iosMgFdV6Z6w4NDbRo
 gKwmpiDMm7olZwa/wkdTfqjZrzKaLCL1tKz5kUJcreBikcv7OKydcOyQyTxEVe0XDInmGxVpqJX
 0cx2/bmzg832M8nudy++OK+kqhckPGDJLTFUM6b4SlkjB2cTY83pEXq9aozSATc3by8i+BiKLBj
 TRyeOHl/gp5bT8fMPEQZr6lKXvhlG1FyGSeLmZq9/vkjS23M7dVyEMZTKQrZ26gREo9piHrS1wC
 GEYIYs36KZ8jAtxhN6/LadGiHuTw3kGqyL8Y5GWy7XaKxDgC
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

Add a media event to tell a new media entity has been registered.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/mc/mc-device.c | 5 +++++
 include/uapi/linux/media.h   | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 98d323c89b41..82f5676afbc0 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -746,6 +746,11 @@ int __must_check media_device_register_entity(struct media_device *mdev,
 	}
 	mutex_unlock(&mdev->graph_mutex);
 
+	media_event_queue(mdev, &(struct media_event){
+		.type = MEDIA_EVENT_ENTITY_REGISTRATION,
+		.u.entity_reg.entity_id = entity->graph_obj.id,
+	});
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(media_device_register_entity);
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 24b6b3f75592..b5275acad87f 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -373,11 +373,18 @@ struct media_v2_topology {
 	__u64 ptr_links;
 } __attribute__ ((packed));
 
-#define MEDIA_EVENT_ALL		0
+#define MEDIA_EVENT_ALL			0
+#define MEDIA_EVENT_ENTITY_REGISTRATION	1
+
+struct media_event_entity_reg {
+	__u32 entity_id;
+	__u32 pending;
+} __attribute__ ((packed));
 
 struct media_event {
 	__u32 type;
 	union {
+		struct media_event_entity_reg entity_reg;
 		__u8 data[64];
 	} u;
 	__u32 reserved[8];

-- 
2.56.0

