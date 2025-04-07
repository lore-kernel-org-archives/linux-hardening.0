Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15F2163B8
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046939; cv=none; b=CbHhJnT2fYtEyBX7S+S5ypI7QWgGQ86l3upLZVJjUJJCSdsrZqvnQKjOVDfsJ/m0J+yEbFAbIz4GYDxiWjsAYs1YiqlHD8J0cc6ZwGi74bJrMVV4KZHJVRZiMPZcbBixNIyNKLqICQ0fH06soGobGfkORDxCw4dxlrR5kojddfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046939; c=relaxed/simple;
	bh=z13lUI9VJGolj41JA2aJQ3X8gdn3+LkRBtT+tiX/tqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luD5pjfN+fvCIrl95ZGe/43BHivNSxpbYJ54eB7XsTxX0iUpVTaY3NE8C3BMJh5CAGUI+nw2/7OrIf8C6ZZEAKD5uB2vwB47mY3VnNDfDhew/9wuoS2v3MBh2SeYYSZJWBJFEcxP0UZyTQDGaFXmYYyRD8MgxER8NaACWhjAFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rm5dEhAn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rm5dEhAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYBd4+A9/sbkJNnoRIiVA1lW5qMA4TWhZWzzyc/OvvY=;
	b=Rm5dEhAn8lq21eXCOTdJRELP9XUdFlR2gGkjgSMwG+yHJ/K8xu/NQVp2JGj6CVGioMthtB
	jZ53wtqymuPqEEhx4JNLMXLgzv+F9o3MeQuGUpGbGFFVR+6MrT6Ndtqu5//BxAFKOBxkvM
	+ZJQv/E4y5GXOQ/1wbt3/nshV4wUi74=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-NUDQe-GzPeyMmCu1UOS9Bg-1; Mon,
 07 Apr 2025 13:28:52 -0400
X-MC-Unique: NUDQe-GzPeyMmCu1UOS9Bg-1
X-Mimecast-MFC-AGG-ID: NUDQe-GzPeyMmCu1UOS9Bg_1744046930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED17A1809CA5;
	Mon,  7 Apr 2025 17:28:49 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35016180B488;
	Mon,  7 Apr 2025 17:28:43 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 01/28] mfd: Add Microchip ZL3073x support
Date: Mon,  7 Apr 2025 19:28:28 +0200
Message-ID: <20250407172836.1009461-2-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This adds base MFD driver for Microchip Azurite ZL3073x chip family.
These chips provide DPLL and PHC (PTP) functionality and they can
be connected over I2C or SPI bus.

The MFD driver provide basic communication and synchronization
over the bus and common functionality that are used by the DPLL
driver (later in this series) and by the PTP driver (will be
added later).

The chip family is characterized by following properties:
* 2 separate DPLL units (channels)
* 5 synthesizers
* 10 input pins (references)
* 10 outputs
* 20 output pins (output pin pair shares one output)
* Each reference and output can act in differential or single-ended
  mode (reference or output in differential mode consumes 2 pins)
* Each output is connected to one of the synthesizers
* Each synthesizer is driven by one of the DPLL unit

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 MAINTAINERS                 |  8 +++++
 drivers/mfd/Kconfig         | 30 ++++++++++++++++
 drivers/mfd/Makefile        |  5 +++
 drivers/mfd/zl3073x-core.c  | 70 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c   | 70 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-spi.c   | 71 +++++++++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x.h       | 13 +++++++
 include/linux/mfd/zl3073x.h | 15 ++++++++
 8 files changed, 282 insertions(+)
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c5c2e2c12787..c69a69d862310 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15994,6 +15994,14 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/
 
+MICROCHIP ZL3073X DRIVER
+M:	Ivan Vecera <ivecera@redhat.com>
+M:	Prathosh Satish <Prathosh.Satish@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/mfd/zl3073x*
+F:	include/linux/mfd/zl3073x.h
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	UNGLinuxDriver@microchip.com
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b9363100394..30b36e3ee8f7f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2422,5 +2422,35 @@ config MFD_UPBOARD_FPGA
 	  To compile this driver as a module, choose M here: the module will be
 	  called upboard-fpga.
 
+config MFD_ZL3073X_CORE
+	tristate
+	select MFD_CORE
+
+config MFD_ZL3073X_I2C
+	tristate "Microchip Azurite DPLL/PTP/SyncE with I2C"
+	depends on I2C
+	select MFD_ZL3073X_CORE
+	select REGMAP_I2C
+	help
+	  Support for Microchip Azurite DPLL/PTP/SyncE chip family. This option
+	  supports I2C as the control interface.
+
+	  This driver provides common support for accessing the device.
+	  Additional drivers must be enabled in order to use the functionality
+	  of the device.
+
+config MFD_ZL3073X_SPI
+	tristate "Microchip Azurite DPLL/PTP/SyncE with SPI"
+	depends on SPI
+	select MFD_ZL3073X_CORE
+	select REGMAP_SPI
+	help
+	  Support for Microchip Azurite DPLL/PTP/SyncE chip family. This option
+	  supports SPI as the control interface.
+
+	  This driver provides common support for accessing the device.
+	  Additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 948cbdf42a18b..76e2babc1538f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -290,3 +290,8 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
 
 obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
+
+zl3073x-y			:= zl3073x-core.o
+obj-$(CONFIG_MFD_ZL3073X_CORE)	+= zl3073x.o
+obj-$(CONFIG_MFD_ZL3073X_I2C)	+= zl3073x-i2c.o
+obj-$(CONFIG_MFD_ZL3073X_SPI)	+= zl3073x-spi.o
diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
new file mode 100644
index 0000000000000..67a9d5a0e2d8c
--- /dev/null
+++ b/drivers/mfd/zl3073x-core.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include "zl3073x.h"
+
+/*
+ * Regmap ranges
+ */
+#define ZL3073x_PAGE_SIZE	128
+#define ZL3073x_NUM_PAGES	16
+#define ZL3073x_PAGE_SEL	0x7F
+
+static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
+	{
+		.range_min	= 0,
+		.range_max	= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
+		.selector_reg	= ZL3073x_PAGE_SEL,
+		.selector_mask	= GENMASK(3, 0),
+		.selector_shift	= 0,
+		.window_start	= 0,
+		.window_len	= ZL3073x_PAGE_SIZE,
+	},
+};
+
+/*
+ * Regmap config
+ */
+const struct regmap_config zl3073x_regmap_config = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
+	.ranges			= zl3073x_regmap_ranges,
+	.num_ranges		= ARRAY_SIZE(zl3073x_regmap_ranges),
+};
+
+/**
+ * zl3073x_get_regmap_config - return pointer to regmap config
+ *
+ * Returns pointer to regmap config
+ */
+const struct regmap_config *zl3073x_get_regmap_config(void)
+{
+	return &zl3073x_regmap_config;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
+
+struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
+{
+	struct zl3073x_dev *zldev;
+
+	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
+
+int zl3073x_dev_init(struct zl3073x_dev *zldev)
+{
+	devm_mutex_init(zldev->dev, &zldev->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
+
+void zl3073x_dev_exit(struct zl3073x_dev *zldev)
+{
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_dev_exit, "ZL3073X");
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x-i2c.c b/drivers/mfd/zl3073x-i2c.c
new file mode 100644
index 0000000000000..8c8b2ba176766
--- /dev/null
+++ b/drivers/mfd/zl3073x-i2c.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "zl3073x.h"
+
+static const struct i2c_device_id zl3073x_i2c_id[] = {
+	{ "zl3073x-i2c", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i2c, zl3073x_i2c_id);
+
+static const struct of_device_id zl3073x_i2c_of_match[] = {
+	{ .compatible = "microchip,zl3073x-i2c" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zl3073x_i2c_of_match);
+
+static int zl3073x_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	const struct i2c_device_id *id;
+	struct zl3073x_dev *zldev;
+	int rc = 0;
+
+	zldev = zl3073x_dev_alloc(dev);
+	if (!zldev)
+		return -ENOMEM;
+
+	id = i2c_client_get_device_id(client);
+	zldev->dev = dev;
+
+	zldev->regmap = devm_regmap_init_i2c(client,
+					     zl3073x_get_regmap_config());
+	if (IS_ERR(zldev->regmap)) {
+		rc = PTR_ERR(zldev->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", rc);
+		return rc;
+	}
+
+	i2c_set_clientdata(client, zldev);
+
+	return zl3073x_dev_init(zldev);
+}
+
+static void zl3073x_i2c_remove(struct i2c_client *client)
+{
+	struct zl3073x_dev *zldev;
+
+	zldev = i2c_get_clientdata(client);
+	zl3073x_dev_exit(zldev);
+}
+
+static struct i2c_driver zl3073x_i2c_driver = {
+	.driver = {
+		.name = "zl3073x-i2c",
+		.of_match_table = of_match_ptr(zl3073x_i2c_of_match),
+	},
+	.probe = zl3073x_i2c_probe,
+	.remove = zl3073x_i2c_remove,
+	.id_table = zl3073x_i2c_id,
+};
+
+module_i2c_driver(zl3073x_i2c_driver);
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x I2C driver");
+MODULE_IMPORT_NS("ZL3073X");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x-spi.c b/drivers/mfd/zl3073x-spi.c
new file mode 100644
index 0000000000000..a6b9a366a7585
--- /dev/null
+++ b/drivers/mfd/zl3073x-spi.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include "zl3073x.h"
+
+static const struct spi_device_id zl3073x_spi_id[] = {
+	{ "zl3073x-spi", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
+
+static const struct of_device_id zl3073x_spi_of_match[] = {
+	{ .compatible = "microchip,zl3073x-spi" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);
+
+static int zl3073x_spi_probe(struct spi_device *spidev)
+{
+	struct device *dev = &spidev->dev;
+	const struct spi_device_id *id;
+	struct zl3073x_dev *zldev;
+	int rc;
+
+	zldev = zl3073x_dev_alloc(dev);
+	if (!zldev)
+		return -ENOMEM;
+
+	id = spi_get_device_id(spidev);
+	zldev->dev = dev;
+
+	zldev->regmap = devm_regmap_init_spi(spidev,
+					     zl3073x_get_regmap_config());
+	if (IS_ERR(zldev->regmap)) {
+		rc = PTR_ERR(zldev->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", rc);
+		return rc;
+	}
+
+	spi_set_drvdata(spidev, zldev);
+
+	return zl3073x_dev_init(zldev);
+}
+
+static void zl3073x_spi_remove(struct spi_device *spidev)
+{
+	struct zl3073x_dev *zldev;
+
+	zldev = spi_get_drvdata(spidev);
+	zl3073x_dev_exit(zldev);
+}
+
+static struct spi_driver zl3073x_spi_driver = {
+	.driver = {
+		.name = "zl3073x-spi",
+		.of_match_table = of_match_ptr(zl3073x_spi_of_match),
+	},
+	.probe = zl3073x_spi_probe,
+	.remove = zl3073x_spi_remove,
+	.id_table = zl3073x_spi_id,
+};
+
+module_spi_driver(zl3073x_spi_driver);
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x SPI driver");
+MODULE_IMPORT_NS("ZL3073X");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x.h b/drivers/mfd/zl3073x.h
new file mode 100644
index 0000000000000..582cb40d681d3
--- /dev/null
+++ b/drivers/mfd/zl3073x.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ZL3073X_CORE_H
+#define __ZL3073X_CORE_H
+
+#include <linux/mfd/zl3073x.h>
+
+struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev);
+int zl3073x_dev_init(struct zl3073x_dev *zldev);
+void zl3073x_dev_exit(struct zl3073x_dev *zldev);
+const struct regmap_config *zl3073x_get_regmap_config(void);
+
+#endif /* __ZL3073X_CORE_H */
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
new file mode 100644
index 0000000000000..7b80c3059b5f3
--- /dev/null
+++ b/include/linux/mfd/zl3073x.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_MFD_ZL3073X_H
+#define __LINUX_MFD_ZL3073X_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+struct zl3073x_dev {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct mutex		lock;
+};
+
+#endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1

