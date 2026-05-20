Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4653E9C31;
	Wed, 20 May 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287284; cv=none; b=F1/gbvUV9ZUVZsBt83WAl/rUzkNpPYzXXAVILSEYFKi42mi3ToTUABAlr1IO/XNByBmMpAq58y8qwAT3G36o/A7sp7Ucozq785T7Bf4tI/zsUHuup8wQ53npiPjRub8c7AWtyuwcHEoRJJ/flvrj5gFki9218s3GC2OkwTup4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287284; c=relaxed/simple;
	bh=44vsq62BXmxm5DD/Mf45AeUdUhlngPNqkasmsMcLuAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/3GJ5t4+jzVz0X0NpVXKw53pObLNqpDDlNs8C2NVoZdfC0CQQ+YuF+1QCoagH8+SsVz42HTB+yTANjd6c7qY3MJoA/ncEsVXnsKJ4juTxxVqzvUPK3U0UTldleydMEMgahH6nlIw5oRkkNQq95dnZIJTX1kud1ubuOA4cd5CCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smNHlfK8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AomRJzVb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smNHlfK8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AomRJzVb"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1YNHb3LOG+O3mj3dxg0peIN/0mukMKiCJXG9hO5Z9g=;
	b=smNHlfK80kalgenYuYXyvDa6qlc/QFmboKRlFCwVeJ8UIaR9HsoYbGH4MV613gyHG7oBVL
	xM6v0iBR8+FV/SQmvMjY+0Aw9ACNQLGNTlTtLsevcINzM9tQukXwbnjVWIaVLK9HdFHuSk
	qgDBtD1kPEi6h/psDOX2fdGwEosHWVLEOsUUMfAey7Nl7FJl4g0jwlX2XzT5TzLkRGp4Pp
	YReok2WRZP275NpgO+5hjWLI3KaWv+WLXuS42BHVMsOxlrKF8ybeJVtiZOz9flB2QxmDWj
	PSNV5YUTCM720FuRZznTq+nKzAxWvu1xZZ80ipJiX1hrRenO2VYGD4w66+ZA6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1YNHb3LOG+O3mj3dxg0peIN/0mukMKiCJXG9hO5Z9g=;
	b=AomRJzVboxRhCO6c9bS3jZTfeW+diHLJrYuhb1xJHhm+wvmaN7yqIuLNz0NILAZORyMERd
	IqSnVaBivP/83AAQ==
Date: Wed, 20 May 2026 16:27:56 +0200
Subject: [PATCH v5 4/8] nvmem: Add the Raspberry Pi OTP driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-4-b26e5908eeac@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
In-Reply-To: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=6300;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=44vsq62BXmxm5DD/Mf45AeUdUhlngPNqkasmsMcLuAY=;
 b=cSY4n0owFSg+WnJ0SNZYWEtjzB9du6p8BHXCvhH22lwxJvj3WrvUsuE3nxN1j0yu1VuVNKwQB
 OQRdgr49HReBpIRlxcbUStyGv0B/7FIqHAM0EvkbBZoNlid8mUfef/d
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Raspberry Pis have OTP registers which can be accessed through the
videocore firmware. Add a nvmem driver to support these OTP registers.

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/nvmem/Kconfig                      |  11 +++
 drivers/nvmem/Makefile                     |   1 +
 drivers/nvmem/raspberrypi-otp.c            | 130 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  10 +++
 4 files changed, 152 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 74ddbd0f79b0e..a1922b48d0c2e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -483,4 +483,15 @@ config NVMEM_QORIQ_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_qoriq_efuse.
 
+config NVMEM_RASPBERRYPI_OTP
+	tristate "Raspberry Pi OTP support"
+	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
+	help
+	  This driver provides access to the Raspberry Pi OTP memory via the
+	  nvmem subsystem. The driver supports the customer OTP as well as the
+	  device specific private key OTP (BCM2712 only).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called raspberrypi-otp.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 7252b8ec88d46..8ca2095e068f3 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -95,3 +95,4 @@ obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
 obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
 nvmem-qoriq-efuse-y			:= qoriq-efuse.o
+obj-$(CONFIG_NVMEM_RASPBERRYPI_OTP)	+= raspberrypi-otp.o
diff --git a/drivers/nvmem/raspberrypi-otp.c b/drivers/nvmem/raspberrypi-otp.c
new file mode 100644
index 0000000000000..3c24548267219
--- /dev/null
+++ b/drivers/nvmem/raspberrypi-otp.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+struct rpi_otp_priv {
+	struct rpi_firmware *fw;
+	u32 read_tag;
+	u32 write_tag;
+};
+
+struct rpi_otp_header {
+	__le32 start;
+	__le32 count;
+	__le32 data[] __counted_by_le(count);
+};
+
+static int rpi_otp_read(void *context, unsigned int offset, void *buf, size_t bytes)
+{
+	struct rpi_otp_priv *priv = context;
+	struct rpi_otp_header *fwbuf;
+	u32 count;
+	int ret;
+
+	count = bytes / 4;
+
+	fwbuf = kzalloc(struct_size(fwbuf, data, count), GFP_KERNEL);
+	if (!fwbuf)
+		return -ENOMEM;
+
+	fwbuf->start = cpu_to_le32(offset / 4);
+	fwbuf->count = cpu_to_le32(count);
+
+	ret = rpi_firmware_property(priv->fw, priv->read_tag, fwbuf,
+				    sizeof(struct rpi_otp_header) + bytes);
+	if (ret)
+		goto out;
+
+	memcpy(buf, fwbuf->data, bytes);
+
+out:
+	kfree(fwbuf);
+	return ret;
+}
+
+static int rpi_otp_write(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct rpi_otp_priv *priv = context;
+	struct rpi_otp_header *fwbuf;
+	u32 count;
+	int ret;
+
+	count = bytes / 4;
+
+	fwbuf = kzalloc(struct_size(fwbuf, data, count), GFP_KERNEL);
+	if (!fwbuf)
+		return -ENOMEM;
+
+	fwbuf->start = cpu_to_le32(offset / 4);
+	fwbuf->count = cpu_to_le32(count);
+	memcpy(fwbuf->data, val, bytes);
+
+	ret = rpi_firmware_property(priv->fw, priv->write_tag, fwbuf,
+				    sizeof(struct rpi_otp_header) + bytes);
+
+	kfree(fwbuf);
+	return ret;
+}
+
+static int rpi_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+	struct rpi_otp_priv *priv;
+	const struct rpi_otp_driver_data *data;
+	struct nvmem_config config = {
+		.read_only = false,
+		.word_size = 4,
+		.stride = 4,
+		.reg_read = rpi_otp_read,
+		.reg_write = rpi_otp_write,
+		.id = NVMEM_DEVID_NONE,
+	};
+
+	data = dev_get_platdata(dev);
+	if (!data)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->fw = dev_get_drvdata(dev->parent);
+	priv->read_tag = data->read_tag;
+	priv->write_tag = data->write_tag;
+	config.dev = dev;
+	config.priv = priv;
+	config.name = data->name;
+	config.size = data->size;
+	config.root_only = data->root_only;
+
+	nvmem = devm_nvmem_register(dev, &config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(dev, PTR_ERR(nvmem), "error registering nvmem config\n");
+
+	return 0;
+}
+
+static const struct platform_device_id raspberrypi_otp_id[] = {
+	{ "raspberrypi-otp" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, raspberrypi_otp_id);
+
+static struct platform_driver raspberrypi_otp_driver = {
+	.probe	= rpi_otp_probe,
+	.driver = {
+		.name	= "raspberrypi-otp",
+	},
+	.id_table = raspberrypi_otp_id,
+};
+module_platform_driver(raspberrypi_otp_driver);
+
+MODULE_AUTHOR("Gregor Herburger <gregor.herburger@linutronix.de>");
+MODULE_DESCRIPTION("Raspberry Pi OTP driver");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index eb33838e0cd10..1e5e5f7e378d0 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -92,6 +92,8 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_POE_HAT_VAL =                        0x00030050,
 	RPI_FIRMWARE_NOTIFY_XHCI_RESET =                      0x00030058,
 	RPI_FIRMWARE_NOTIFY_DISPLAY_DONE =                    0x00030066,
+	RPI_FIRMWARE_GET_PRIVATE_OTP =                        0x00030081,
+	RPI_FIRMWARE_SET_PRIVATE_OTP =                        0x00038081,
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
@@ -174,6 +176,14 @@ struct rpi_firmware_clk_rate_request {
 		.id = cpu_to_le32(_id),		\
 	}
 
+struct rpi_otp_driver_data {
+	const char *name;
+	u32 read_tag;
+	u32 write_tag;
+	int size;
+	bool root_only;
+};
+
 #if IS_REACHABLE(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);

-- 
2.47.3

