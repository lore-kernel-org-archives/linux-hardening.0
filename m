Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC312371D15;
	Sun, 11 Oct 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739820; cv=none; b=QLaOHL1Sue2m3g3gJXU5LV1EzAR5yq/1JKtNRXto6q7vALwZS4Ef/yen94p17WM/WAGuxMLQVedxpIeXo2jI8mCmvSCfloLLkUWR2F1tvFm8QAprfR+tuhn0XsJT1RVlB74TLt+p2KU5mgBkYoVYnnnPGb9iyT3u8Djg3YEPNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739820; c=relaxed/simple;
	bh=nSUs4PQP3nCpiJAn8izbwW9MLM8SHOQMVXGYuWtKfV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEU++cwFhtMh4nms5/7ht3fcVDnXpoBqXvFVfrwrvgGpgMDKjtRtom0t8vJp1Ihb7V0kAqjVuDHEpHZb6GqSyVz7EfgTont0pgMIxdKy82ES1hVnIzaFGgC8K0j2l3YLrMnJ0ATdI0OEC20UNtRXFRz/ciLJzm1vPVXt9FEsyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=uegZ4O7l; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="uegZ4O7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1791739800; x=1791999000;
	bh=hUNoKAFRBWh5arHROPkFP+zL+l8s+p22iEhT2EbzFGk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uegZ4O7lElXf7XPqEPyOGwk4O/IHyvnaget0LC085I00TYdRFmF4lvBa/mABZYSdz
	 Af7YsJhjJvSGy9umVrEsjEw5ALehPFuwgGPWsy4CRWwCspu0R63Go5xn+TMvGJiUwk
	 zDBJ+7u3jOKtvHi+RtGkBkfcF1MMA2R/IrhrlcGXMd3PdeSQIo5b+tr/axp0rpuQV3
	 dorsfwfPwf9SCf/qAH3X3+9cxLAD+2UVGC1HIc1DgXwPMmXZHjMxRQBL05ZMyuKXhq
	 VA/aQSF/NgSn6YURjRbFY7bc3rUdSiLcmxoz58iO5Y8o/PRDg1X8X8JDkznghBSFcu
	 dvZ6Jes5uvEsg==
X-Pm-Submission-Id: 4j2nfX4H3qz1DF4w
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sun, 11 Oct 2026 19:29:29 +0200
Subject: [PATCH v5 2/3] platform: arm64: dell-xps-ec: new driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-dell-xps-9345-ec-v5-2-2ab1258b84c1@vinarskis.com>
References: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
In-Reply-To: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12381; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=nSUs4PQP3nCpiJAn8izbwW9MLM8SHOQMVXGYuWtKfV4=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFmnj/dGyV1/mKAsJTRfojeYecbP/Y+3CK558OPVNs11I
 ZniYgvlO0pZGMS4GGTFFFm6/3xN61o0dy3DdY1vMHNYmUCGMHBxCsBE5kUwMjQyz+Ip+CDn+WPd
 bcdN1Y/O2idJugtxTBBNaDN6sub3vZuMDGflCuwkFU5kv9rAePvoEZ7GrfWStlqfih9KiKw4+dD
 uLQsA
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

Introduce EC driver for Dell XPS 13 9345 (codename 'tributo') which may
partially of fully compatible with Snapdragon-based Dell Latitude,
Inspiron ('thena'). Primary function of this driver is unblock EC's
thermal management, specifically to provide it with necessary
information to control device fans, peripherals power.

The driver was developed primarily by analyzing ACPI DSDT's _DSM and
i2c dumps of communication between SoC and EC. Changes to Windows
driver's behavior include increasing temperature feed loop from ~50ms
to 100ms here.

While Xps's EC is rather complex and controls practically all device
peripherals including touch row's brightness and special keys such as
mic mute, these do not go over this particular i2c interface.

Not yet implemented features:
- On lid-close IRQ event is registered. Windows performs what to
  appears to be thermistor constants readout, though its not obvious
  what it used for.
- According to ACPI's _DSM there is a method to readout fans' RPM.
- Initial thermistor constants were sniffed from Windows, these can be
  likely fine tuned for better cooling performance.
- There is additional temperature reading that Windows sents to EC but
  more rare than others, likely SoC T_j / TZ98 or TZ4. This is the only
  thermal zone who's reading can exceed 115C without triggering thermal
  shutdown.
- Given similarities between 'tributo' and 'thena' platforms, including
  EC i2c address, driver can be potentially extended to support both.

Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 MAINTAINERS                          |   1 +
 drivers/platform/arm64/Kconfig       |  12 ++
 drivers/platform/arm64/Makefile      |   1 +
 drivers/platform/arm64/dell-xps-ec.c | 308 +++++++++++++++++++++++++++++++++++
 4 files changed, 322 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aa035cc1c5b..29149a1b6ec9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7469,6 +7469,7 @@ DELL XPS EMBEDDED CONTROLLER DRIVER
 M:	Aleksandrs Vinarskis <alex@vinarskis.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml
+F:	drivers/platform/arm64/dell-xps-ec.c
 
 DELTA AHE-50DC FAN CONTROL MODULE DRIVER
 M:	Zev Weiss <zev@bewilderbeest.net>
diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
index e32e01b2a9bd..29416f8d7232 100644
--- a/drivers/platform/arm64/Kconfig
+++ b/drivers/platform/arm64/Kconfig
@@ -33,6 +33,18 @@ config EC_ACER_ASPIRE1
 	  laptop where this information is not properly exposed via the
 	  standard ACPI devices.
 
+config EC_DELL_XPS
+	tristate "Dell XPS 9345 Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on I2C
+	depends on IIO
+	help
+	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
+	  Dell XPS 13 9345, which handles thermal management and fan speed
+	  control.
+
+	  Say M or Y here to include this support.
+
 config EC_HUAWEI_GAOKUN
 	tristate "Huawei Matebook E Go Embedded Controller driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
index 7681be4a46e9..669dc9e79afb 100644
--- a/drivers/platform/arm64/Makefile
+++ b/drivers/platform/arm64/Makefile
@@ -6,6 +6,7 @@
 #
 
 obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
+obj-$(CONFIG_EC_DELL_XPS)	+= dell-xps-ec.o
 obj-$(CONFIG_EC_HUAWEI_GAOKUN)	+= huawei-gaokun-ec.o
 obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
 obj-$(CONFIG_EC_LENOVO_THINKPAD_T14S) += lenovo-thinkpad-t14s.o
diff --git a/drivers/platform/arm64/dell-xps-ec.c b/drivers/platform/arm64/dell-xps-ec.c
new file mode 100644
index 000000000000..cf2dd41b1aa6
--- /dev/null
+++ b/drivers/platform/arm64/dell-xps-ec.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Aleksandrs Vinarskis <alex@vinarskis.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+#include <linux/workqueue.h>
+
+#define DELL_XPS_EC_SUSPEND_CMD		0xb9
+#define DELL_XPS_EC_SUSPEND_MSG_LEN	64
+
+#define DELL_XPS_EC_TEMP_CMD0		0xfb
+#define DELL_XPS_EC_TEMP_CMD1		0x20
+#define DELL_XPS_EC_TEMP_CMD3		0x02
+#define DELL_XPS_EC_TEMP_MSG_LEN	6
+#define DELL_XPS_EC_TEMP_POLL_JIFFIES	msecs_to_jiffies(100)
+
+/*
+ * Mapping between IIO channel name (as per schematics) and EC command byte.
+ */
+struct dell_xps_ec_therm {
+	const char *name;
+	u8 cmd;
+};
+
+struct dell_xps_ec_data {
+	const struct dell_xps_ec_therm *therms;
+	unsigned int num_therms;
+	const u8 *profile;
+	size_t profile_len;
+};
+
+/*
+ * Format:
+ * - header/unknown (2 bytes)
+ * - per-thermistor entries (3 bytes): thermistor_id, param1, param2
+ */
+static const u8 dell_xps13_9345_thermistor_profile[] = {
+	0xff, 0x54,
+	0x01, 0x00, 0x2b,	/* sys_therm0 */
+	0x02, 0x44, 0x2a,	/* sys_therm1 */
+	0x03, 0x44, 0x2b,	/* sys_therm2 */
+	0x04, 0x44, 0x28,	/* sys_therm3 */
+	0x05, 0x55, 0x2a,	/* sys_therm4 */
+	0x06, 0x44, 0x26,	/* sys_therm5 */
+	0x07, 0x44, 0x2b,	/* sys_therm6 */
+};
+
+static const struct dell_xps_ec_therm dell_xps13_9345_therms[] = {
+	/* TODO: 0x01 is sent only occasionally, likely TZ98 or TZ4. */
+	{ "sys_therm0", 0x02 },
+	{ "sys_therm1", 0x03 },
+	{ "sys_therm2", 0x04 },
+	{ "sys_therm3", 0x05 },
+	{ "sys_therm4", 0x06 },
+	{ "sys_therm5", 0x07 },
+	{ "sys_therm6", 0x08 },
+};
+
+static const struct dell_xps_ec_data dell_xps13_9345_data = {
+	.therms = dell_xps13_9345_therms,
+	.num_therms = ARRAY_SIZE(dell_xps13_9345_therms),
+	.profile = dell_xps13_9345_thermistor_profile,
+	.profile_len = sizeof(dell_xps13_9345_thermistor_profile),
+};
+
+struct dell_xps_ec {
+	struct device *dev;
+	struct i2c_client *client;
+	const struct dell_xps_ec_data *data;
+	struct delayed_work temp_work;
+	unsigned int num_therms;
+	struct iio_channel *therm_channels[] __counted_by(num_therms);
+};
+
+static int dell_xps_ec_suspend_cmd(struct dell_xps_ec *ec, bool suspend)
+{
+	u8 buf[DELL_XPS_EC_SUSPEND_MSG_LEN] = {};
+	int ret;
+
+	buf[0] = DELL_XPS_EC_SUSPEND_CMD;
+	buf[1] = suspend ? 0x01 : 0x00;
+	/* bytes 2..63 remain zero */
+
+	ret = i2c_master_send(ec->client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int dell_xps_ec_send_temp(struct dell_xps_ec *ec, u8 cmd_byte,
+				 int milli_celsius)
+{
+	u8 buf[DELL_XPS_EC_TEMP_MSG_LEN];
+	u16 deci_celsius;
+	int ret;
+
+	deci_celsius = milli_celsius / MILLIDEGREE_PER_DECIDEGREE;
+
+	buf[0] = DELL_XPS_EC_TEMP_CMD0;
+	buf[1] = DELL_XPS_EC_TEMP_CMD1;
+	buf[2] = cmd_byte;
+	buf[3] = DELL_XPS_EC_TEMP_CMD3;
+	put_unaligned_le16(deci_celsius, &buf[4]);
+
+	ret = i2c_master_send(ec->client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void dell_xps_ec_temp_work_fn(struct work_struct *work)
+{
+	struct dell_xps_ec *ec = container_of(work, struct dell_xps_ec,
+					      temp_work.work);
+	const struct dell_xps_ec_therm *therms = ec->data->therms;
+	int val, ret;
+	unsigned int i;
+
+	for (i = 0; i < ec->num_therms; i++) {
+		if (!ec->therm_channels[i])
+			continue;
+
+		ret = iio_read_channel_processed(ec->therm_channels[i], &val);
+		if (ret < 0) {
+			dev_err_ratelimited(ec->dev,
+					    "Failed to read thermistor %s: %d\n",
+					    therms[i].name, ret);
+			continue;
+		}
+
+		ret = dell_xps_ec_send_temp(ec, therms[i].cmd, val);
+		if (ret < 0) {
+			dev_err_ratelimited(ec->dev,
+					    "Failed to send temp for %s: %d\n",
+					    therms[i].name, ret);
+		}
+	}
+
+	schedule_delayed_work(&ec->temp_work, DELL_XPS_EC_TEMP_POLL_JIFFIES);
+}
+
+static irqreturn_t dell_xps_ec_irq_handler(int irq, void *data)
+{
+	struct dell_xps_ec *ec = data;
+
+	/*
+	 * TODO: IRQ is fired on lid-close. Follow Windows example to read out
+	 *       the thermistor thresholds and potentially fan speeds.
+	 */
+	dev_dbg(ec->dev, "IRQ triggered (irq=%d)\n", irq);
+
+	return IRQ_HANDLED;
+}
+
+static int dell_xps_ec_probe(struct i2c_client *client)
+{
+	const struct dell_xps_ec_data *data;
+	struct device *dev = &client->dev;
+	struct dell_xps_ec *ec;
+	unsigned int i;
+	int ret;
+
+	data = i2c_get_match_data(client);
+	if (!data)
+		return dev_err_probe(dev, -ENODEV, "No match data\n");
+
+	ec = devm_kzalloc(dev, struct_size(ec, therm_channels, data->num_therms),
+			  GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	ec->dev = dev;
+	ec->client = client;
+	ec->data = data;
+	ec->num_therms = data->num_therms;
+	i2c_set_clientdata(client, ec);
+
+	/* Set default thermistor profile */
+	ret = i2c_master_send(client, data->profile, data->profile_len);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to set thermistor profile\n");
+
+	/* Get IIO channels for thermistors */
+	for (i = 0; i < ec->num_therms; i++) {
+		ec->therm_channels[i] =
+			devm_iio_channel_get(dev, data->therms[i].name);
+		if (IS_ERR(ec->therm_channels[i])) {
+			ret = PTR_ERR(ec->therm_channels[i]);
+			ec->therm_channels[i] = NULL;
+			if (ret == -EPROBE_DEFER)
+				return ret;
+			dev_warn(dev, "Thermistor %s not available: %d\n",
+				 data->therms[i].name, ret);
+		}
+	}
+
+	/* Start periodic temperature reporting */
+	ret = devm_delayed_work_autocancel(dev, &ec->temp_work,
+					   dell_xps_ec_temp_work_fn);
+	if (ret)
+		return ret;
+	schedule_delayed_work(&ec->temp_work, DELL_XPS_EC_TEMP_POLL_JIFFIES);
+	dev_dbg(dev, "Started periodic temperature reporting to EC every %d ms\n",
+		jiffies_to_msecs(DELL_XPS_EC_TEMP_POLL_JIFFIES));
+
+	/* Request IRQ for EC events */
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					dell_xps_ec_irq_handler,
+					IRQF_ONESHOT, dev_name(dev), ec);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	return 0;
+}
+
+/*
+ * Notify EC of suspend
+ *
+ * This will:
+ * - Cut power to display/trackpad/keyboard/touchrow, wake-up source still works.
+ */
+static int dell_xps_ec_suspend(struct device *dev)
+{
+	struct dell_xps_ec *ec = dev_get_drvdata(dev);
+
+	int ret;
+
+	cancel_delayed_work_sync(&ec->temp_work);
+
+	ret = dell_xps_ec_suspend_cmd(ec, true);
+	if (ret) {
+		schedule_delayed_work(&ec->temp_work,
+				      DELL_XPS_EC_TEMP_POLL_JIFFIES);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Notify EC of resume
+ *
+ * This will undo the suspend actions. Without the resume signal, device would
+ * wake up but be forced back into suspend by EC within seconds.
+ */
+static int dell_xps_ec_resume(struct device *dev)
+{
+	struct dell_xps_ec *ec = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dell_xps_ec_suspend_cmd(ec, false);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&ec->temp_work, DELL_XPS_EC_TEMP_POLL_JIFFIES);
+
+	return 0;
+}
+
+static const struct of_device_id dell_xps_ec_of_match[] = {
+	{ .compatible = "dell,xps13-9345-ec", .data = &dell_xps13_9345_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dell_xps_ec_of_match);
+
+static const struct i2c_device_id dell_xps_ec_i2c_id[] = {
+	{ "dell-xps-ec", (kernel_ulong_t)&dell_xps13_9345_data },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, dell_xps_ec_i2c_id);
+
+static const struct dev_pm_ops dell_xps_ec_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(dell_xps_ec_suspend, dell_xps_ec_resume)
+};
+
+static struct i2c_driver dell_xps_ec_driver = {
+	.driver = {
+		.name = "dell-xps-ec",
+		.of_match_table = dell_xps_ec_of_match,
+		.pm = &dell_xps_ec_pm_ops,
+	},
+	.probe = dell_xps_ec_probe,
+	.id_table = dell_xps_ec_i2c_id,
+};
+module_i2c_driver(dell_xps_ec_driver);
+
+MODULE_AUTHOR("Aleksandrs Vinarskis <alex@vinarskis.com>");
+MODULE_DESCRIPTION("Dell XPS 13 9345 Embedded Controller");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");

-- 
2.54.0

