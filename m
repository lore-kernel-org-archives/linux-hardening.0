Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005844;
	b=Rp2hho49YMdFPqEbSd6X8nLXzzFEqIV+ww7Okc5PUVdQpU0z51W6xQtJmHRVWSCg75Ia
	 xORWFejb8f+8yIf8G+QKKUn9xa2zuz+jeby3z5RyfueGJw7aQpLecXbs0ktTNSzN12hSq
	 3prDegS9+Rw0mbMrIa/rQmOdj0Gr9JQ7hrmNr0BdOwfZsSjC7qJ/PIYQRN6UTDs6W/HAL
	 3tyPUK7aelTUPB/cvARud6LvuV2d9Mo2s5Ggp82A+ZFdxjuv5KxjRgj4NQY7KR1BxUUoz
	 6FtFBzscbAyoVReLqPJkbrSlXtpaWH+0NF01KXTXqnvy9ZgJTl4NncLXVoojWiYOn5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005844;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1jp+LFxkFUNb3kZYr6492Er1uNZ9P/OcpCwscAq3WYw=;
	b=MdLHdQnPgep232QB6sJVMljLDp6OiCcEAZFSpPMsdv7zgVu0BtgRkuPr0+AIsO73vghZ
	 moGFlXFNCaT/3bb53fbp3fpfOP25pGQoFq1SUMYNarzBWXAuIIJYHVFcjKEom14JnQyPF
	 G38QaSijxEwGjRgEtp1tTP5GT1fkhYyQoEnFC2o2y22vZP7Wuqi/eeBRdppeBOxyCmZJ/
	 P6Io4IHXZpGWWAVu4jS8cU4GlRjCxaDC++61vRmcYANJGSmlqEVnU//f4AbVPCP2iu07n
	 OOYPfxXcGcTFHsmi9WjhVDDDVXI0trlUfqhSXdrg+0lZBACvDw29rbAqler4Wo4eiDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc9sCOCM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FA606A32F;
	Wed, 18 Nov 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc9sCOCM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C931F000C4;
	Wed, 18 Nov 2026 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005843;
	bh=1jp+LFxkFUNb3kZYr6492Er1uNZ9P/OcpCwscAq3WYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fc9sCOCMBewz7KRlepQrHf8ORXOmLTO9XQr4CFLjfzhgUkKfUAtWdj8sH7PcFbZ4M
	 lgLx+MewmLBFnQPtfWNUbdZ89rrUq8fD2e7/oTkKfyOLNrzwND7UzYkniWW1vhLEWR
	 AchX2RyezaTgsBzA+mnKYxq1+psEfWrbQDjdNdJzw4V7zhQXl16q947hXeTBhqHjlk
	 wpkF53R/zW/eMoHnvTatFtAh8ZJXL27/vUvCeq3/X7PF470UCAy3gKTHFpPSHY5bAy
	 LkbNbsd2OWUNIlgWJXOVNzFOZz/gcaGB1xoiFektZo78r3nDeaWoPA0Lmx39e97Kw6
	 oJeXjngJTgqwQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:46 +0100
Subject: [PATCH RFC v2 02/16] media: mc: Add per-file-handle data support
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
Message-Id: <20261118-v4l2-sensor-detect-v2-2-1bb1a445b556@kernel.org>
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
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4469;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=Bz7fxtwOOIRRee5KSI62LVoVXlbx02TfJVY8R7KdYlQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2KZrMEPoanM6umdCpofknCsTp8DO3SxgrdA
 8qy0wAojtmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2digAKCRAZDR20Zk4Z
 NaAOB/9t7VlIIXjVcXB99mNI6rI5x6fOiRpw1E0dbPjBX3pk2sPueCCi5+yHHyh0c6OqQvaqZ7w
 WjXKZ+gAhGly9wk0rYvcy6Cq/NAPAO9XexQQfUwEIKcYYZkCa6H2VDG2A4ZxzFmi4OhZ2FO6lvW
 l5D/uL3iKib6+ml6NA34LzXBVNPBEKQAbHfGKTcGZjouxi6EnfGNlv2IIeVa60ng+JT865+FxeP
 16R93nq4Sm0XlNbdR2ktbRaxasbSRCKYY/3CGHX7J3vYk/kxcc8SwuWAZoEmK8ZiiqXS2CiHoN0
 d+hNBNmOHCZKwRWmQMes0e40pPTf12pjdvx65s2/5CZmwX+K
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The media devnode core associates devnodes with files by storing the
devnode pointer in the file structure private_data field. In order to
allow tracking of per-file-handle data introduce a new media devnode
file handle structure that stores the devnode pointer, and store a
pointer to that structure in the file private_data field.

Users of the media devnode code (the only existing user being
media_device) are responsible for managing their own subclass of the
media_devnode_fh structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/mc/mc-device.c  | 21 +++++++++++++++++++++
 drivers/media/mc/mc-devnode.c | 19 ++++++++++---------
 include/media/media-devnode.h | 18 +++++++++++++++++-
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 32e5c9f02ed4..8d0c35a11944 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -36,6 +36,15 @@
 #define MEDIA_ENT_T_DEVNODE_UNKNOWN		(MEDIA_ENT_F_OLD_BASE | \
 						 MEDIA_ENT_SUBTYPE_MASK)
 
+struct media_device_fh {
+	struct media_devnode_fh fh;
+};
+
+static inline struct media_device_fh *media_device_fh(struct file *filp)
+{
+	return container_of(filp->private_data, struct media_device_fh, fh);
+}
+
 /* -----------------------------------------------------------------------------
  * Userspace API
  */
@@ -47,11 +56,23 @@ static inline void __user *media_get_uptr(__u64 arg)
 
 static int media_device_open(struct file *filp)
 {
+	struct media_device_fh *fh;
+
+	fh = kzalloc_obj(*fh);
+	if (!fh)
+		return -ENOMEM;
+
+	filp->private_data = &fh->fh;
+
 	return 0;
 }
 
 static int media_device_close(struct file *filp)
 {
+	struct media_device_fh *fh = media_device_fh(filp);
+
+	kfree(fh);
+
 	return 0;
 }
 
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 51260a7d6921..bc06cbf0445a 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -140,6 +140,7 @@ static long media_compat_ioctl(struct file *filp, unsigned int cmd,
 static int media_open(struct inode *inode, struct file *filp)
 {
 	struct media_devnode *devnode;
+	struct media_devnode_fh *fh;
 	int ret;
 
 	/* Check if the media device is available. This needs to be done with
@@ -162,15 +163,16 @@ static int media_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = devnode;
 
-	if (devnode->fops->open) {
-		ret = devnode->fops->open(filp);
-		if (ret) {
-			put_device(&devnode->dev);
-			filp->private_data = NULL;
-			return ret;
-		}
+	ret = devnode->fops->open(filp);
+	if (ret) {
+		put_device(&devnode->dev);
+		filp->private_data = NULL;
+		return ret;
 	}
 
+	fh = filp->private_data;
+	fh->devnode = devnode;
+
 	return 0;
 }
 
@@ -179,8 +181,7 @@ static int media_release(struct inode *inode, struct file *filp)
 {
 	struct media_devnode *devnode = media_devnode_data(filp);
 
-	if (devnode->fops->release)
-		devnode->fops->release(filp);
+	devnode->fops->release(filp);
 
 	filp->private_data = NULL;
 
diff --git a/include/media/media-devnode.h b/include/media/media-devnode.h
index dbcabeffcb57..0912368ea049 100644
--- a/include/media/media-devnode.h
+++ b/include/media/media-devnode.h
@@ -59,6 +59,20 @@ struct media_file_operations {
 	int (*release) (struct file *);
 };
 
+/**
+ * struct media_devnode_fh - Media device node file handle
+ * @devnode:	pointer to the media device node
+ *
+ * This structure serves as a base for per-file-handle data storage. Media
+ * device node users embed media_devnode_fh in their custom file handle data
+ * structures and store the media_devnode_fh in the file private_data in order
+ * to let the media device node core locate the media_devnode corresponding to a
+ * file handle.
+ */
+struct media_devnode_fh {
+	struct media_devnode *devnode;
+};
+
 /**
  * struct media_devnode - Media device node
  * @media_dev:	pointer to struct &media_device
@@ -150,7 +164,9 @@ void media_devnode_unregister(struct media_devnode *devnode);
  */
 static inline struct media_devnode *media_devnode_data(struct file *filp)
 {
-	return filp->private_data;
+	struct media_devnode_fh *fh = filp->private_data;
+
+	return fh->devnode;
 }
 
 /**

-- 
2.56.0

