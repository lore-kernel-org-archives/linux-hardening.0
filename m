Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005876;
	b=xMl8q2rF1/BLOMKLuaUDVtC2WQtVbTb++krrKhA5cG4UPSS+EyzqZQksKydiM1gbq52N
	 WUmKBelJ5T/xBOYcvmxbPyjdlWo+XHwdnkBIiGoKFb5PNpqRXhoO2vI0P/okjSaThhhm/
	 mY56qlDKTe9TtF7y1IvfWZlyurWYGhLYTEvVXP/bsIQQ8sXrS/tMVYhqvmvJRTQox9PL0
	 a4Zz86k9m4LWhQwzRYftVYFcNaLmOKfup/HgcxIif42Jan3eV/MngsgsJGchBSVl1TqRc
	 G7AeTTvp/vp3lsqMb5Ynr98zlaeaDqag7b54pMrSFN1qjV0LJJhNh3ytDnmrdrLr6ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005876;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=E+TFB5ruIZVQXeeFZKL6zFfyFf8j+3Cog2ncFVsXWyg=;
	b=2pPtDFfbIOcqsyYNkDMNoGaVCfBEgs2deAWXRatK5UWBL/UdHcSgo3lqPcWAmQcakA3u
	 t4bSuSi9ztwCUnSsRDmNV+O+eF87XPyBtbs7KSA8ygs1BoD2BfjvC+dW2tqhEwCglBMsE
	 9E9C2Mqc8uSefQdbWcz77XSs/3X1ZYtCRf3m65ov9+KHLl7C4WYJ0FSNoLKvp0NEsPbEj
	 Tgs94yS43RpMZThuZJEMdLksiNykYVudHkWEIdRBP0xtnqWtNaNj//xCd8NHEP69XQyhF
	 gZ2wkO5MPDE458gqasaPa9SOYSqfOfmb4peqnf/j6vxK17aZqq1QsI80RNNr9/x9XZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3mvja+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC460A260F;
	Wed, 18 Nov 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3mvja+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30991F000CB;
	Wed, 18 Nov 2026 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005876;
	bh=E+TFB5ruIZVQXeeFZKL6zFfyFf8j+3Cog2ncFVsXWyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D3mvja+N90ppnyK3GdaXsj8/GlXwzGrdpEJRwSPqtgp8LsqO5ulE7t6+N6CmevMpE
	 S4xlfTokaK4UhnVP+cCtRot3jduTBW6g1VidZ/J+lnOoo/UdGyG/l/vTUEb0PwgCGG
	 JnZBWJNbZij1un4/3LD9dVCCLGH2HiObZ+eGELtHAPnD1qvagE4w6roxhh5Jdj16RM
	 KpKbvSO09GJHmNZdpOsIvl28b0LhHg5sBnujzjD8U2H+xxTnxF3xhFPNZTjzf+FX+n
	 pRDrNwpwpSC/1vPtuI+yMcnVt1r+SKkHjh9HB9l3ZXdZRJ9s/1k5OtLk0kYQ3i2ff3
	 enEYJMBzIX7yA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:44:00 +0100
Subject: [PATCH RFC v2 16/16] media: imx219: Implement .detect() sensor
 operation
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
Message-Id: <20261118-v4l2-sensor-detect-v2-16-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4413;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=TyP8n4mkpZbPBju5QqjjO/ut3VyNVLg80/ioaomM2/I=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2MW+A406U6qSft7hKPUWd/+EE6oVsQ2ZLpP
 OUTRs4dc7OJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2djAAKCRAZDR20Zk4Z
 Ne+DB/99/drsuDm6qvrIPblgUnFytjfuXwMz+IUi8uLQOwRkhESRCGXmIBOJLMH4J5mmdIGUqUM
 9KyRQrMWbQsJsbzhdQkCJnudpgSCHA4TJAIy/S3BCu1l6fv+mNto13iswTBQu73U8K+l4HUeHIV
 jnxgENCi1jsfaVOTuoK10sKSMMunFkqKJumyg/N+SYK2ivJFdMuJ1UB0PzdI/ij4scuVk54ui+c
 zEpuTwosDmr+3M9kYmwWaX9Wia9PTYain7J+g/9gRSD6941jyTGNDq8FiJRwolMlyS1/pmzPdOj
 Rap/Cq92jl/M5s2ysEAQxElNZjSTyZt81qm0P7J1994OPIYg
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

Now that the driver can probe() with a missing sensor, userspace should
be able to query the sensor connection state via the media device.

Implement the .detect() sensor operation so that userspace can do that
using the MEDIA_IOC_G_ENTITY_STATUS ioctl.

Also call media_detect_poll_enable() when streaming successfully started
and poll_disable() when disabling streaming to make sure that the media
device reports the status to userspace while streaming.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/i2c/imx219.c | 47 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 02d065fb88d0..5d4432a97eee 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -28,6 +28,7 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mediabus.h>
+#include <media/v4l2-subdev.h>
 
 /* Chip ID */
 #define IMX219_REG_CHIP_ID		CCI_REG16(0x0000)
@@ -742,6 +743,10 @@ static int imx219_enable_streams(struct v4l2_subdev *sd,
 	if (ret < 0)
 		return ret;
 
+	ret = media_entity_detect_or_fail(&sd->entity);
+	if (ret)
+		goto err_rpm_put;
+
 	/* Send all registers that are common to all modes */
 	ret = cci_multi_reg_write(imx219->regmap, imx219_common_regs,
 				  ARRAY_SIZE(imx219_common_regs), NULL);
@@ -780,6 +785,8 @@ static int imx219_enable_streams(struct v4l2_subdev *sd,
 	__v4l2_ctrl_grab(imx219->vflip, true);
 	__v4l2_ctrl_grab(imx219->hflip, true);
 
+	media_detect_poll_enable(&sd->entity);
+
 	return 0;
 
 err_rpm_put:
@@ -795,6 +802,8 @@ static int imx219_disable_streams(struct v4l2_subdev *sd,
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
 	int ret;
 
+	media_detect_poll_disable(&sd->entity);
+
 	/* set stream off register */
 	ret = cci_write(imx219->regmap, IMX219_REG_MODE_SELECT,
 			IMX219_MODE_STANDBY, NULL);
@@ -1006,6 +1015,33 @@ static int imx219_init_state(struct v4l2_subdev *sd,
 	return imx219_set_pad_format(sd, NULL, state, &fmt);
 }
 
+static int imx219_read_chip_id(struct imx219 *imx219, u64 *chip_id)
+{
+	return cci_read(imx219->regmap, IMX219_REG_CHIP_ID, chip_id, NULL);
+}
+
+static int imx219_detect(struct media_entity *entity)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
+	struct i2c_client *client = v4l2_get_subdevdata(sd);
+	struct imx219 *imx219 = to_imx219(sd);
+	u64 chip_id;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&client->dev);
+	if (ret < 0)
+		return ret;
+
+	if (imx219_read_chip_id(imx219, &chip_id))
+		ret = MEDIA_ENT_STATUS_DISCONNECTED;
+	else
+		ret = MEDIA_ENT_STATUS_CONNECTED;
+
+	pm_runtime_put_autosuspend(&client->dev);
+
+	return ret;
+}
+
 static const struct v4l2_subdev_video_ops imx219_video_ops = {
 	.s_stream = v4l2_subdev_s_stream_helper,
 };
@@ -1029,6 +1065,10 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
 	.init_state = imx219_init_state,
 };
 
+static const struct media_entity_operations imx219_entity_ops = {
+	.detect = imx219_detect,
+};
+
 /* -----------------------------------------------------------------------------
  * Power management
  */
@@ -1099,11 +1139,6 @@ static int imx219_get_regulators(struct imx219 *imx219)
 				       imx219->supplies);
 }
 
-static int imx219_read_chip_id(struct imx219 *imx219, u64 *chip_id)
-{
-	return cci_read(imx219->regmap, IMX219_REG_CHIP_ID, chip_id, NULL);
-}
-
 static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 {
 	struct fwnode_handle *endpoint;
@@ -1237,6 +1272,7 @@ static int imx219_probe(struct i2c_client *client)
 			goto error_power_off;
 		}
 		dev_dbg(&client->dev, "failed to read chip id %x\n", IMX219_CHIP_ID);
+		imx219->sd.entity.status = MEDIA_ENT_STATUS_DISCONNECTED;
 	} else if (val != IMX219_CHIP_ID) {
 		ret = dev_err_probe(&client->dev, -EIO,
 				    "chip id mismatch: %x!=%llx\n",
@@ -1271,6 +1307,7 @@ static int imx219_probe(struct i2c_client *client)
 	/* Initialize subdev */
 	imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	imx219->sd.entity.ops = &imx219_entity_ops;
 
 	/* Initialize source pad */
 	imx219->pad.flags = MEDIA_PAD_FL_SOURCE;

-- 
2.56.0

