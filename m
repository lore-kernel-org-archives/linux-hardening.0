Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005874;
	b=RzAqEB8rnJvxNwCiKqbPvQBGHs4ml892HWg4LYtP2QVOF58TkNBLXak34yGtFZ0lm2vB
	 OTgak/gn0tX7AmfZ3s3ZwHhneLuX1BiJmfPLSoFegPzgPhYbw4GMexiAfq8uUmVT96wwW
	 HXlLI3DsZF8CLzl6DV5HHhMEJCGresx7hzKhzzF5rfoc2a49RKtXWLtEfPHzI1COoE7f7
	 R/9JyBwnUswoxrgAIr1AOGHCE/PfBphSASD7uGeb7HBLwFMAhK3v/mJ6icd/5UHYNPcQc
	 w63wbFLFA0wNNbaJjU0K0HR9C1GbtA+FTwL5AHEishbCLuC9r7gRLVmc4FyUbcFwuRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005874;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+b/bporVQPERPDqhEJifGRe5RVJXvpB/5W9DRGOoLqU=;
	b=XWxybwIZ2ZoJH/cx4FMeldtgOy9fTVYobX4Dc8WJ64qMFAQarRRJK1n4I8ER7ulbJuAB
	 sJaeRhwqdgXEJ1lRD9/nloUp5yJVEY+N64Ca0Hn4hJloprcRx+hDN/iWkWjZpa4lio9i4
	 NCGNIyl1GYObbN3fli8DOjjBXFlT4ynisM8Q7QJtzf0BnyHvPZBGW+ASK7e/u8ZjAde0a
	 rpxxfBgfcrNd0Er5zpRqCPIYSEDa0l/RcjYbqyEWMDxWqw0YdZROEBzykIIfFR2HYMc5Z
	 EBBgtr9PDqIlnPvLywqcNaFePX4W5UdSzyeOva1VSHA/xYU/dIbUI7DxQkyT9t9wTjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3tnCQc7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6F60A2608;
	Wed, 18 Nov 2026 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3tnCQc7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA241F000C7;
	Wed, 18 Nov 2026 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005873;
	bh=+b/bporVQPERPDqhEJifGRe5RVJXvpB/5W9DRGOoLqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X3tnCQc7aBbBrOc78+4TIxr5D8PkEdnPSlgMlp/xh1GUUFy680wR8zUAHEz3ONAlF
	 IbhoLsMdsgO4HU7AN0gjVcTD0K4jh6D8eS3BP/Rt1kG/3H8/65TaAqoFBIt+XFCpZT
	 bA+3dSLkpWNYpAQ+FnNdYm8W7IuZkEMfVc82GgeYDtMfPjlk+3tBtb9T6QFZEiXuQv
	 tdT0IoJeL1dyHmkUFlol5NZaBoARpIdKjeV7TYE2001niWmZlmJ94EErSRNfULQbqk
	 mGbVtfYGSdFrpIM6zfulKtNNGN9IdP06LIomiEJSkgR7Z4cA3o1ffr5eT7JoNZtbxf
	 24Uk93/rxuz/w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Nov 2026 13:43:59 +0100
Subject: [PATCH RFC v2 15/16] media: imx219: Allow driver probe with
 missing sensor
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
Message-Id: <20261118-v4l2-sensor-detect-v2-15-1bb1a445b556@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4297;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=VflYp+cMHa/Buc2sISbW+WgltI5f9Bvp5e7CfX2o6Uc=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Z2MYCrd8p4GkkrDokxabrdoluqCFzAsyTnIo
 Jm+lbiOGpOJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2djAAKCRAZDR20Zk4Z
 NRWSCACDCs2Meaxyo3N3rJ8EksAVeLUDoE3JWDfMbG/o/BLMHnTZSPybaoHwUl7IYa3ExSVcKMv
 UP9Lbb5wzaeTpQQiz3z1H8btj15uPClgHQv1Fp0oLcn/v+j0YZkSinc7uK7V5KYuS2zDxEKrjT+
 gRyqIt+kfUmO2eUm9bz0HMyitv/eHXU85LtnmlXZ4jGUxCulzH7Mc7oZl+kFY0Il2dG4rWai//Q
 MOSb2SwJ/UFqJXRffrORX11VX7U+gMwkRfmOZcF09i2XdREO9hh5hb8Ffgp3yu16VhdCCTLebgw
 RF1Qbfh9zb2KJGIwRaCxApgGqD+hxBXhBil9Hru+QdSfm0nl
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28

When media fault tolerance is enabled, probe() should complete even when
a sensor is disconnected.

Currently, the driver reads the CHIP_ID over i2c in the probe().
When we can't read CHIP_ID, the probe errors out, which result in the
v4l2-subdev not being created.

Extract imx219_read_chip_id() from imx219_identify_module() so that
probe can distinguish an unreachable sensor (I2C read failure) from a
wrong sensor (CHIP_ID mismatch).

When the sensor is unreachable, skip the LP-11 state initialization and
continue probe so the v4l2-subdev and media entity are created.

Note that a CHIP_ID mismatch remains a fatal error.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/media/i2c/imx219.c | 74 ++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 1580562093e8..02d065fb88d0 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1099,25 +1099,9 @@ static int imx219_get_regulators(struct imx219 *imx219)
 				       imx219->supplies);
 }
 
-/* Verify chip ID */
-static int imx219_identify_module(struct imx219 *imx219)
+static int imx219_read_chip_id(struct imx219 *imx219, u64 *chip_id)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
-	int ret;
-	u64 val;
-
-	ret = cci_read(imx219->regmap, IMX219_REG_CHIP_ID, &val, NULL);
-	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "failed to read chip id %x\n",
-				     IMX219_CHIP_ID);
-
-	if (val != IMX219_CHIP_ID)
-		return dev_err_probe(&client->dev, -EIO,
-				     "chip id mismatch: %x!=%llx\n",
-				     IMX219_CHIP_ID, val);
-
-	return 0;
+	return cci_read(imx219->regmap, IMX219_REG_CHIP_ID, chip_id, NULL);
 }
 
 static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
@@ -1194,6 +1178,7 @@ static int imx219_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct imx219 *imx219;
 	int ret;
+	u64 val;
 
 	imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
 	if (!imx219)
@@ -1235,36 +1220,49 @@ static int imx219_probe(struct i2c_client *client)
 				     "failed to get reset gpio\n");
 
 	/*
-	 * The sensor must be powered for imx219_identify_module()
+	 * The sensor must be powered for imx219_read_chip_id()
 	 * to be able to read the CHIP_ID register
 	 */
 	ret = imx219_power_on(dev);
 	if (ret)
 		return ret;
 
-	ret = imx219_identify_module(imx219);
-	if (ret)
-		goto error_power_off;
-
-	/*
-	 * Sensor doesn't enter LP-11 state upon power up until and unless
-	 * streaming is started, so upon power up switch the modes to:
-	 * streaming -> standby
-	 */
-	ret = cci_write(imx219->regmap, IMX219_REG_MODE_SELECT,
-			IMX219_MODE_STREAMING, NULL);
-	if (ret < 0)
+	/* Verify chip ID */
+	ret = imx219_read_chip_id(imx219, &val);
+	if (ret) {
+		if (!media_fault_tolerance_enabled()) {
+			dev_err_probe(&client->dev, ret,
+				      "failed to read chip id %x\n",
+				      IMX219_CHIP_ID);
+			goto error_power_off;
+		}
+		dev_dbg(&client->dev, "failed to read chip id %x\n", IMX219_CHIP_ID);
+	} else if (val != IMX219_CHIP_ID) {
+		ret = dev_err_probe(&client->dev, -EIO,
+				    "chip id mismatch: %x!=%llx\n",
+				    IMX219_CHIP_ID, val);
 		goto error_power_off;
+	} else {
+		/*
+		 * Sensor doesn't enter LP-11 state upon power up until and unless
+		 * streaming is started, so upon power up switch the modes to:
+		 * streaming -> standby
+		 */
+		ret = cci_write(imx219->regmap, IMX219_REG_MODE_SELECT,
+				IMX219_MODE_STREAMING, NULL);
+		if (ret < 0)
+			goto error_power_off;
 
-	usleep_range(100, 110);
+		usleep_range(100, 110);
 
-	/* put sensor back to standby mode */
-	ret = cci_write(imx219->regmap, IMX219_REG_MODE_SELECT,
-			IMX219_MODE_STANDBY, NULL);
-	if (ret < 0)
-		goto error_power_off;
+		/* put sensor back to standby mode */
+		ret = cci_write(imx219->regmap, IMX219_REG_MODE_SELECT,
+				IMX219_MODE_STANDBY, NULL);
+		if (ret < 0)
+			goto error_power_off;
 
-	usleep_range(100, 110);
+		usleep_range(100, 110);
+	}
 
 	ret = imx219_init_controls(imx219);
 	if (ret)

-- 
2.56.0

