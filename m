Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A31413797
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352949; cv=none; b=Ig7oHX5iiJsW5fdY8fHRBMc2x8sDhLZ5TDRJbgLHlrRmJgmv4PGx2hZgoeQyX9bbq2Frerr3Bqmzp3vEfFskQUQyyxoncI426fT+y1PjhLj/PBlOZv2Zpet4sRMif/RIkK/BGBQl/F/2C6LQDASUnh1QUPemi8UL2rC8NegbriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352949; c=relaxed/simple;
	bh=K8MjNPHK/Six5jGtbOBsb4gMRakL6wrB7w26TFRmzdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n99/7MeyUrxKG5qg+qFXCYrYDBxTaEENDCQfQh8HOx71JMoJ4A8D5QBpgkW6LJSDTogwThXIIsgdGyCBK5di+d4bR81qwCSAI56x/Q3d7CwF7FFc9wYpGYIko/ulWkO3l0syalPkfb0anMO16t4gn+ohp7btMZtSRB+nPknhrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca; spf=pass smtp.mailfrom=r-sc.ca; dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b=VSSKfVGw; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b="VSSKfVGw"
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j78HJ0ytxz8sWS;
	Sun, 18 Oct 2026 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792352605;
	bh=KcnivXCK7CWYGc7lhwsBehDk5jq3wiWO16xNYcqNakU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSSKfVGwjXCMDQ+TSHqAEiSwshk3Cn6ASTwfSmqg+8GUF9jJ8HoTnAk2Q4Y9FvQOZ
	 ECpqksf/XbsQDwIcQd4d2ynL7e2rSebYNJVOybnUwgG6r2eTmKY9SNuq5sAQUzGfYK
	 IGClqSEAJ5p4vI4hDiQOI16FNkvEA2gWH/WAEsoIr2TWCXKRvhHnkUUR3j0MBTHlZl
	 IBTQeBtlX2daEqM29i5r+nvrlYfy8QMCBOcPFtjwRRvfACrXvpXbDuIezu7K4TQYnC
	 /LO/AJNSjrVJbFCLsvdJ74PNxjZP3ZNJwPUAgOwKd1MN9gWX5O/S+Dr4wuxWgxQ3oK
	 P0sx2L9v912hA==
From: Ross Cawston <ross@r-sc.ca>
To: andi.shyti@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: [PATCH 2/2] i2c: add driver for GPIO buses sharing one SCL line
Date: Sun, 18 Oct 2026 12:43:15 -0700
Message-ID: <20261018194315.945-3-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261018194315.945-1-ross@r-sc.ca>
References: <20261018194315.945-1-ross@r-sc.ca>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: ross@r-sc.ca

Some boards bit-bang several I2C buses on GPIOs with one common SCL
line and one SDA line per bus. The MokerLink POE-10G07110GSM, an
RTL9303 PoE switch, clocks its fan controller, its two PoE controllers
and its SFP+ cage this way. i2c-gpio cannot be used, as each instance
would request the shared SCL GPIO.

Request SCL once and register one i2c-algo-bit adapter per SDA child
node. A mutex taken in pre_xfer and released in post_xfer serializes
the transfers across the buses, so only one bus clocks SCL at a time
and the idle SDA lines see clock pulses only without a START.

Signed-off-by: Ross Cawston <ross@r-sc.ca>
---
 MAINTAINERS                              |   7 +
 drivers/i2c/busses/Kconfig               |  12 ++
 drivers/i2c/busses/Makefile              |   1 +
 drivers/i2c/busses/i2c-gpio-shared-scl.c | 229 +++++++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-gpio-shared-scl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 782389bd5cd..9ac40ad4399 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12250,6 +12250,13 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-nvidia-gpu.rst
 F:	drivers/i2c/busses/i2c-nvidia-gpu.c
 
+I2C GPIO BUSES SHARING SCL DRIVER
+M:	Ross Cawston <ross@r-sc.ca>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-gpio-shared-scl.yaml
+F:	drivers/i2c/busses/i2c-gpio-shared-scl.c
+
 I2C MUXES
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311..caeed4385d1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -691,6 +691,18 @@ config I2C_GPIO
 	  This is a very simple bitbanging I2C driver utilizing the
 	  arch-neutral GPIO API to control the SCL and SDA lines.
 
+config I2C_GPIO_SHARED_SCL
+	tristate "GPIO-based bitbanging I2C buses sharing one SCL line"
+	depends on GPIOLIB || COMPILE_TEST
+	select I2C_ALGOBIT
+	help
+	  Several bitbanged I2C buses with one common SCL GPIO and one SDA
+	  GPIO per bus, as found on some Realtek RTL930x switches. Each
+	  SDA line becomes its own I2C adapter; transfers are serialized.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-gpio-shared-scl.
+
 config I2C_GPIO_FAULT_INJECTOR
 	bool "GPIO-based fault injector"
 	depends on I2C_GPIO
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 3755c54b3d8..c3b98e8abc4 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_EMEV2)		+= i2c-emev2.o
 obj-$(CONFIG_I2C_EXYNOS5)	+= i2c-exynos5.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
+obj-$(CONFIG_I2C_GPIO_SHARED_SCL)	+= i2c-gpio-shared-scl.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
 obj-$(CONFIG_I2C_HISI)		+= i2c-hisi.o
 obj-$(CONFIG_I2C_HIX5HD2)	+= i2c-hix5hd2.o
diff --git a/drivers/i2c/busses/i2c-gpio-shared-scl.c b/drivers/i2c/busses/i2c-gpio-shared-scl.c
new file mode 100644
index 00000000000..6f7ee898392
--- /dev/null
+++ b/drivers/i2c/busses/i2c-gpio-shared-scl.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Bit-banged I2C buses that share one SCL line
+ *
+ * Some boards wire several I2C buses to GPIOs with one common SCL line and
+ * a separate SDA line per bus. The vendor firmware bit-bangs them in turn.
+ * i2c-gpio cannot describe this, because every bus would request the same
+ * SCL GPIO. This driver requests SCL once and registers one adapter per SDA
+ * line. Transfers on the adapters are serialized, so only one bus drives
+ * SCL at a time; devices on the other buses see SCL toggle while their SDA
+ * stays high, which is never a START condition, and ignore it.
+ *
+ * Copyright (C) 2026 Ross Cawston <ross@r-sc.ca>
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+struct i2c_gpio_shared_scl;
+
+struct i2c_gpio_shared_scl_bus {
+	struct i2c_gpio_shared_scl *parent;
+	struct gpio_desc *sda;
+	struct i2c_algo_bit_data bit_data;
+	struct i2c_adapter adap;
+	bool registered;
+};
+
+struct i2c_gpio_shared_scl {
+	struct device *dev;
+	struct gpio_desc *scl;
+	struct mutex lock;	/* one transfer on the shared SCL at a time */
+	unsigned int num_buses;
+	struct i2c_gpio_shared_scl_bus buses[] __counted_by(num_buses);
+};
+
+static void i2c_gpio_shared_scl_setsda(void *data, int state)
+{
+	struct i2c_gpio_shared_scl_bus *bus = data;
+
+	gpiod_set_value_cansleep(bus->sda, state);
+}
+
+static int i2c_gpio_shared_scl_getsda(void *data)
+{
+	struct i2c_gpio_shared_scl_bus *bus = data;
+
+	return gpiod_get_value_cansleep(bus->sda);
+}
+
+static void i2c_gpio_shared_scl_setscl(void *data, int state)
+{
+	struct i2c_gpio_shared_scl_bus *bus = data;
+
+	gpiod_set_value_cansleep(bus->parent->scl, state);
+}
+
+static int i2c_gpio_shared_scl_getscl(void *data)
+{
+	struct i2c_gpio_shared_scl_bus *bus = data;
+
+	return gpiod_get_value_cansleep(bus->parent->scl);
+}
+
+static int i2c_gpio_shared_scl_pre_xfer(struct i2c_adapter *adap)
+{
+	struct i2c_gpio_shared_scl_bus *bus = i2c_get_adapdata(adap);
+
+	mutex_lock(&bus->parent->lock);
+
+	return 0;
+}
+
+static void i2c_gpio_shared_scl_post_xfer(struct i2c_adapter *adap)
+{
+	struct i2c_gpio_shared_scl_bus *bus = i2c_get_adapdata(adap);
+
+	mutex_unlock(&bus->parent->lock);
+}
+
+static void i2c_gpio_shared_scl_del_buses(struct i2c_gpio_shared_scl *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < priv->num_buses; i++)
+		if (priv->buses[i].registered)
+			i2c_del_adapter(&priv->buses[i].adap);
+}
+
+static int i2c_gpio_shared_scl_add_bus(struct i2c_gpio_shared_scl *priv,
+				       struct i2c_gpio_shared_scl_bus *bus,
+				       struct fwnode_handle *child,
+				       u32 udelay, u32 timeout_ms)
+{
+	struct device *dev = priv->dev;
+	struct i2c_algo_bit_data *bit_data = &bus->bit_data;
+	struct i2c_adapter *adap = &bus->adap;
+	u32 reg;
+	int ret;
+
+	ret = fwnode_property_read_u32(child, "reg", &reg);
+	if (ret)
+		return dev_err_probe(dev, ret, "%pfwP: missing reg\n", child);
+
+	bus->parent = priv;
+	bus->sda = devm_fwnode_gpiod_get(dev, child, "sda",
+					 GPIOD_OUT_HIGH_OPEN_DRAIN,
+					 fwnode_get_name(child));
+	if (IS_ERR(bus->sda))
+		return dev_err_probe(dev, PTR_ERR(bus->sda),
+				     "%pfwP: cannot get SDA GPIO\n", child);
+
+	bit_data->data = bus;
+	bit_data->setsda = i2c_gpio_shared_scl_setsda;
+	bit_data->getsda = i2c_gpio_shared_scl_getsda;
+	bit_data->setscl = i2c_gpio_shared_scl_setscl;
+	bit_data->getscl = i2c_gpio_shared_scl_getscl;
+	bit_data->pre_xfer = i2c_gpio_shared_scl_pre_xfer;
+	bit_data->post_xfer = i2c_gpio_shared_scl_post_xfer;
+	bit_data->udelay = udelay;
+	bit_data->timeout = msecs_to_jiffies(timeout_ms);
+
+	adap->owner = THIS_MODULE;
+	adap->algo_data = bit_data;
+	adap->dev.parent = dev;
+	device_set_node(&adap->dev, child);
+	snprintf(adap->name, sizeof(adap->name), "%s SDA%u", dev_name(dev), reg);
+	i2c_set_adapdata(adap, bus);
+
+	ret = i2c_bit_add_bus(adap);
+	if (ret)
+		return dev_err_probe(dev, ret, "%pfwP: cannot add bus\n", child);
+
+	bus->registered = true;
+
+	return 0;
+}
+
+static int i2c_gpio_shared_scl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i2c_gpio_shared_scl *priv;
+	u32 udelay = 5, timeout_ms = 100;
+	unsigned int num_buses, i = 0;
+	int ret;
+
+	num_buses = device_get_child_node_count(dev);
+	if (!num_buses)
+		return dev_err_probe(dev, -EINVAL, "no buses\n");
+
+	priv = devm_kzalloc(dev, struct_size(priv, buses, num_buses), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->num_buses = num_buses;
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
+
+	/* Same properties as i2c-gpio */
+	device_property_read_u32(dev, "i2c-gpio,delay-us", &udelay);
+	device_property_read_u32(dev, "i2c-gpio,timeout-ms", &timeout_ms);
+
+	priv->scl = devm_gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (IS_ERR(priv->scl))
+		return dev_err_probe(dev, PTR_ERR(priv->scl), "cannot get SCL GPIO\n");
+
+	platform_set_drvdata(pdev, priv);
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = i2c_gpio_shared_scl_add_bus(priv, &priv->buses[i++], child,
+						  udelay, timeout_ms);
+		if (ret) {
+			i2c_gpio_shared_scl_del_buses(priv);
+			return ret;
+		}
+	}
+
+	dev_info(dev, "%u buses on shared SCL, %u us half period\n", num_buses, udelay);
+
+	return 0;
+}
+
+static void i2c_gpio_shared_scl_remove(struct platform_device *pdev)
+{
+	i2c_gpio_shared_scl_del_buses(platform_get_drvdata(pdev));
+}
+
+static const struct of_device_id i2c_gpio_shared_scl_of_match[] = {
+	{ .compatible = "i2c-gpio-shared-scl" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, i2c_gpio_shared_scl_of_match);
+
+static struct platform_driver i2c_gpio_shared_scl_driver = {
+	.driver = {
+		.name = "i2c-gpio-shared-scl",
+		.of_match_table = i2c_gpio_shared_scl_of_match,
+	},
+	.probe = i2c_gpio_shared_scl_probe,
+	.remove = i2c_gpio_shared_scl_remove,
+};
+
+/* Registered early, like i2c-gpio, so the buses exist before their clients */
+static int __init i2c_gpio_shared_scl_init(void)
+{
+	return platform_driver_register(&i2c_gpio_shared_scl_driver);
+}
+subsys_initcall(i2c_gpio_shared_scl_init);
+
+static void __exit i2c_gpio_shared_scl_exit(void)
+{
+	platform_driver_unregister(&i2c_gpio_shared_scl_driver);
+}
+module_exit(i2c_gpio_shared_scl_exit);
+
+MODULE_DESCRIPTION("Bit-banged I2C buses sharing one SCL line");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

