Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327861;
	b=Z3gBS1ThgcCKjsw9/pmT1FX7HXrkajTIw2JFY8ZMETdR9Pi0q9bDmB/sRDClF70jZUvv
	 g/s5DGUTpJWz8/XJgY2qdWWhG1/MnBwjVkYeI9KmyvSeKDfHhRBugBfrtMGrmmONbu8Rh
	 WDrJviOxNsh32J0oRAHz4c4N9hhkge4/6QKD6V9NrWTxtTZK821OwaoKqxrXEppHHuQuZ
	 Jv6vEaD7ZDOKqLo/hk1/k4ZO6NnjSjd/OIzXPypLqPM8Knmp02O9G7Xonr00ZIEZax3p7
	 RiV1Xe99B2/pEZwrQ3S57HPbTFSHw+SOqNW79YFz63JYVADADjf8+2ZejQe41noJSlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327861;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=6U67ayOvjleXAgbTvcQ+FXkmXprCiQMTfCSE2HDVh2k=;
	b=4Z/j1mjltvy/xnOZeC2vLUo5OmjEgdHW+5/YayssT5kzgD3fifOkEu7ZIdi+5vQM5fGh
	 R5/b1K/MV+XX3ibyIsLwHBIPBpzh0dYo70CrkmoA2Vm1HpDVd/DDb23oCQC4Y+Jrr+241
	 6SirBqUmiDgyk+bvK7q4EfL2N+QJOKqylzuWe+NXvG/srqEzlL109ffoFLxS0IKPBYSsl
	 492TJcr/Ql548QxNew2MBMbNj5S+5mEooSkfiyYfJ5kNRfbxNYoQC8URRhI5mR5co6AGL
	 EzZRXaZO9z9NnROFL4RLOXiPKpAZAltcVyhdqcWliYva6nnxLIiejUL2KC/TX/HLFgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIXx+Yhe;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BHqYbGaX;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81381606A32A;
	Tue, 10 Nov 2026 16:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81381606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIXx+Yhe;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BHqYbGaX
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U67ayOvjleXAgbTvcQ+FXkmXprCiQMTfCSE2HDVh2k=;
	b=xIXx+YheCUfniv8GmjQzReeQGNV4VhHmHua1Py5/LzRMrHLdDTce04pEjGR9fUqbtV/cEK
	MNkKLApjrU+Dg+4m9WvMLbIRMowY1r88m7xcFwzSozUpqqeGrVXO4CF3AxEmm/kOLYOOJf
	WxqjXsTFiFEuE9jyqwPvKAHNHsC+Jz1jTXInux33a2FG4sGJLa80NO1sPcNRNAGpeuQhGn
	vqXDqirczNNdCEApGkE+tcfzgcKKzNego0Zg90gvv/RLB51qWZ/lOwMHl4P61VE/JdPTLA
	PeoR2+mJzZhXbjF0P/RTrszQ3bu3Rhla8/oTEa2PbO4sq3Uap1ueXxZWFHgL8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U67ayOvjleXAgbTvcQ+FXkmXprCiQMTfCSE2HDVh2k=;
	b=BHqYbGaXwEW5inXLK7/2ekcNigemgXLli/8oTVf/3I90WV4/sGJeDx7jIxZAHKpZOOZiHJ
	9jNv402EvFA3KaCQ==
Date: Tue, 10 Nov 2026 17:24:05 +0100
Subject: [PATCH v7 04/11] nvmem: Add the Raspberry Pi OTP driver
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
Message-Id: <20261110-rpi-otp-driver-v7-4-2345d0ee65f0@linutronix.de>
References: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=6900;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=FpGs9w11qScDcdUkfEdIzaOtvLOSHl6WzTB5wiY9tuU=;
 b=33t0UUohZesAyw5yKM3NS2NLSLFazs2XjT8sjZDyl8coo2z2Ehp4Poo6UD3l8PNhEK0IU2JeY
 AX5r5vOFiFRAwWN3V7KdW2Q0iPP40VPHmny2jjaF4AZCc0Pwegqn4xm
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Raspberry Pis have OTP registers which can be accessed through the
videocore firmware. Add a nvmem driver to support these OTP registers.

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/nvmem/Kconfig                      |  11 +++
 drivers/nvmem/Makefile                     |   1 +
 drivers/nvmem/raspberrypi-otp.c            | 131 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  10 +++
 4 files changed, 153 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d2f5bb236663f..11c557f2a088f 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -406,6 +406,17 @@ config NVMEM_QNAP_MCU_EEPROM
 	  information, like MAC addresses for ethernet devices that do not
 	  contain their own mac storage.
 
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
 config NVMEM_RAVE_SP_EEPROM
 	tristate "Rave SP EEPROM Support"
 	depends on RAVE_SP_CORE
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5e70bad9f0f9e..10ae38ec349a9 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -104,3 +104,4 @@ obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
 obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
 nvmem-qoriq-efuse-y			:= qoriq-efuse.o
+obj-$(CONFIG_NVMEM_RASPBERRYPI_OTP)	+= raspberrypi-otp.o
diff --git a/drivers/nvmem/raspberrypi-otp.c b/drivers/nvmem/raspberrypi-otp.c
new file mode 100644
index 0000000000000..2e2537ee6793b
--- /dev/null
+++ b/drivers/nvmem/raspberrypi-otp.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
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
+	{ /* sentinel */ }
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
index 33ac26f2f135a..96ddf886d579e 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -82,6 +82,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_POE_HAT_VAL =                        0x00030050,
 	RPI_FIRMWARE_NOTIFY_XHCI_RESET =                      0x00030058,
 	RPI_FIRMWARE_NOTIFY_DISPLAY_DONE =                    0x00030066,
+	RPI_FIRMWARE_GET_PRIVATE_OTP =                        0x00030081,
 	RPI_FIRMWARE_GET_RTC_REG =                            0x00030087,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
@@ -93,6 +94,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_SDHOST_CLOCK =                       0x00038042,
 	RPI_FIRMWARE_SET_GPIO_CONFIG =                        0x00038043,
 	RPI_FIRMWARE_SET_PERIPH_REG =                         0x00038045,
+	RPI_FIRMWARE_SET_PRIVATE_OTP =                        0x00038081,
 	RPI_FIRMWARE_SET_RTC_REG =                            0x00038087,
 
 	/* Dispmanx TAGS */
@@ -201,6 +203,14 @@ struct rpi_firmware_clk_rate_request {
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

