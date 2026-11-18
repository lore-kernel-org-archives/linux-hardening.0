Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005841;
	b=CuAiHz5vnS4ORPF25zorM8NVoUF6G26PGZtGW9RnSCq9K1+gVD1O/a4q0hBbncqxdsaO
	 ZBkm0qYR1ZQurwf7Pw00Kagbwvb6FXCtF69mmNmRzIiCYAeLVybOHW9ONFx18OBPVHSe0
	 puvNzWbjgvgXa41vftEFD7ufRmNai9CycKAh80bD1uFOYlcOEowe3tg1rHPSGNkpjy7BW
	 rQ4H3I2gcP/DJrX9VAXLWUgYh+CqlV8wXC8FOTjUhu4M6PUIUtbpCIH9h1Dd7VoJ4X3RX
	 By61f+dfdBrUuWfGbYKy8DSuKfkrIlqiYnlT+pY8fjTAtHmv6SyIa8a4M2AM8L3s+Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005841;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jVmywPTlLalYtFqX8UNWu0H5DNrRCww8Dz1LEqCwhnI=;
	b=5ECT1ZxPcfn9fL0S4Pm9KqE7iUNru2vEJYk+9Nid4DbYegIJDwjnbzym8BxaG+uAZisV
	 buDiJZ//SyaklhzWHVXDlTVjZrlPKE+FZN695qIQ/7lPCcdaEkpKicSBdKfgkc7aEAM0O
	 hKRcw8aRGIGpn2fagtReOgl7XKXqpE8fjrAC+JH41lO6H8OCxoReL7vndf4qOirij6dEp
	 uG+VttKhGteCOxHoaDKrTe1Dw1C97JlR849eN8IGbb4Bn7MuYDWMBFOawTs8V5aZgQNpI
	 h/mIouzemZ8d9yiREYYwuX5E8TltzTGR+LlL+hMwHwsjur8rDKbsyi5HLHvqKLETyMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsdGozSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90269606A32C;
	Wed, 18 Nov 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsdGozSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E01F000C4;
	Wed, 18 Nov 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005841;
	bh=jVmywPTlLalYtFqX8UNWu0H5DNrRCww8Dz1LEqCwhnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FsdGozSWtFRpQNl0Rb1ZC2XJspccrJx9Wt3DzBJXtpGCDzGecT/0tLQFY0xScpK7b
	 UyjvR2InsSNEeCi3/wYMaEHUPljRYXKb744yt0kd/UTuJQCn+z5wUXbveJj3E4Dof4
	 A+vMO0ZGtSJb3pakunWYIVuzNjWmGAKyOm08ytjvu1mIY/TPY8/EBDUSWa3/gbuxZI
	 L6cPkF6a40O9K7Cl4c5W0inULLzYSi2zuyc6lW7cDdG4TNg7ZMXtzkTLfsQhlAbVED
	 T/wiEqpZntIKk/0MvAJkv5aczm2ZI4iNB0AU2OsQ6OwuMWYRNdxozdJzC7ZpDqJe2s
	 iS39KfjXQrtWw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:45 +0100
Subject: [PATCH RFC v2 01/16] media: mc: Add struct media_device_fh pointer
 to media device IOCTL op
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
Message-Id: <20261118-v4l2-sensor-detect-v2-1-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4496;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=oHh1cGp6YNYatJRRuwHPU2TcFJBTb/PdENGCK+NTUtE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2Kig1oGP07iqAZXlyt0nHgkkjBkj1q3yJ5v
 idSvU+l3w+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2digAKCRAZDR20Zk4Z
 NSvgCADQOm+Je7USr/cjMxkz7E499t5bbEqXMUGjPuc7YHwl9kGE4DIALVaAI9k54cZUez0EdHc
 jSNsuJKqk2APn9Sfgp7XGL86WB9K7m8WODrziJ0P9Z5tdlSqeV8YGaPIbDJLIJw06r1Je6A661B
 qiD/sPFrjIGhIIks+iWRFx/Xn4hdf+Ulbv6Ujl7xMUufVSwQidmetNhTZEyyZVtyereAhsS6DCE
 sfx1xpnMUW9S4xRPu5LJJqdEqlo3rym1Ng2T2Q2G64xM/jGz+yFNmkLteJDmE3cdR/ZWsGzgdzm
 7d5RBxXvgoqu3trKPUO54fpJEYiy1nl9i5giQKGSzL9DHDJt
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Sakari Ailus <sakari.ailus@linux.intel.com>

In order to use the struct media_device_fh pointer in IOCTL callbacks, add
it to the callback, between the Media device and the IOCTL argument.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/mc/mc-device.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index f8ea7cfe10b2..32e5c9f02ed4 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -55,7 +55,8 @@ static int media_device_close(struct file *filp)
 	return 0;
 }
 
-static long media_device_get_info(struct media_device *dev, void *arg)
+static long media_device_get_info(struct media_device *dev,
+				  struct file *file, void *arg)
 {
 	struct media_device_info *info = arg;
 
@@ -95,7 +96,8 @@ static struct media_entity *find_entity(struct media_device *mdev, u32 id)
 	return NULL;
 }
 
-static long media_device_enum_entities(struct media_device *mdev, void *arg)
+static long media_device_enum_entities(struct media_device *mdev,
+				       struct file *file, void *arg)
 {
 	struct media_entity_desc *entd = arg;
 	struct media_entity *ent;
@@ -148,7 +150,8 @@ static void media_device_kpad_to_upad(const struct media_pad *kpad,
 	upad->flags = kpad->flags;
 }
 
-static long media_device_enum_links(struct media_device *mdev, void *arg)
+static long media_device_enum_links(struct media_device *mdev,
+				    struct file *file, void *arg)
 {
 	struct media_links_enum *links = arg;
 	struct media_entity *entity;
@@ -197,7 +200,8 @@ static long media_device_enum_links(struct media_device *mdev, void *arg)
 	return 0;
 }
 
-static long media_device_setup_link(struct media_device *mdev, void *arg)
+static long media_device_setup_link(struct media_device *mdev,
+				    struct file *file, void *arg)
 {
 	struct media_link_desc *linkd = arg;
 	struct media_link *link = NULL;
@@ -227,7 +231,8 @@ static long media_device_setup_link(struct media_device *mdev, void *arg)
 	return __media_entity_setup_link(link, linkd->flags);
 }
 
-static long media_device_get_topology(struct media_device *mdev, void *arg)
+static long media_device_get_topology(struct media_device *mdev,
+				      struct file *file, void *arg)
 {
 	struct media_v2_topology *topo = arg;
 	struct media_entity *entity;
@@ -370,7 +375,8 @@ static long media_device_get_topology(struct media_device *mdev, void *arg)
 	return ret;
 }
 
-static long media_device_request_alloc(struct media_device *mdev, void *arg)
+static long media_device_request_alloc(struct media_device *mdev,
+				       struct file *file, void *arg)
 {
 	int *alloc_fd = arg;
 
@@ -417,7 +423,8 @@ static long copy_arg_to_user(void __user *uarg, void *karg, unsigned int cmd)
 struct media_ioctl_info {
 	unsigned int cmd;
 	unsigned short flags;
-	long (*fn)(struct media_device *dev, void *arg);
+	long (*fn)(struct media_device *dev, struct file *file,
+		   void *arg);
 	long (*arg_from_user)(void *karg, void __user *uarg, unsigned int cmd);
 	long (*arg_to_user)(void __user *uarg, void *karg, unsigned int cmd);
 };
@@ -462,7 +469,7 @@ static long media_device_ioctl(struct file *filp, unsigned int cmd,
 	if (info->flags & MEDIA_IOC_FL_GRAPH_MUTEX)
 		mutex_lock(&dev->graph_mutex);
 
-	ret = info->fn(dev, karg);
+	ret = info->fn(dev, filp, karg);
 
 	if (info->flags & MEDIA_IOC_FL_GRAPH_MUTEX)
 		mutex_unlock(&dev->graph_mutex);
@@ -487,6 +494,7 @@ struct media_links_enum32 {
 };
 
 static long media_device_enum_links32(struct media_device *mdev,
+				      struct file *file,
 				      struct media_links_enum32 __user *ulinks)
 {
 	struct media_links_enum links;
@@ -503,7 +511,7 @@ static long media_device_enum_links32(struct media_device *mdev,
 	links.pads = compat_ptr(pads_ptr);
 	links.links = compat_ptr(links_ptr);
 
-	ret = media_device_enum_links(mdev, &links);
+	ret = media_device_enum_links(mdev, file, &links);
 	if (ret)
 		return ret;
 
@@ -525,8 +533,8 @@ static long media_device_compat_ioctl(struct file *filp, unsigned int cmd,
 	switch (cmd) {
 	case MEDIA_IOC_ENUM_LINKS32:
 		mutex_lock(&dev->graph_mutex);
-		ret = media_device_enum_links32(dev,
-				(struct media_links_enum32 __user *)arg);
+		ret = media_device_enum_links32(dev, filp,
+						(struct media_links_enum32 __user *)arg);
 		mutex_unlock(&dev->graph_mutex);
 		break;
 

-- 
2.56.0

