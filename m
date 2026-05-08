Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F23E5EFA;
	Fri,  8 May 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251374; cv=none; b=ICBnIva1GqQXOjivuvb5DzCmwhlfY+RNDzeDKbZicUQU9q3srlRPNPxbMbMvucdV42lK1uShuflY+N7qUcv5EPMUxLz2nH+xHj+FYS1ib0L2qaZab+ShLaKEY2nuTlu8VUATXSD+S610mRnm+YYckXtjLKV+yvIv1h23eZuwLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251374; c=relaxed/simple;
	bh=rr5QjJVjuZvNPD8Qs2aGQvMUMttlLqqHNodH4QGCTqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwPQFEn761Mn9Z5ZJG8rAKnUDZ7DgCmT3iy+gd+h38dC78i340Kun+vDMVyiIazRyH1qsK5PHhEGzOmBv1KB0ZVBY0bYStuUjzWw8EQQsZal5zdDUtBCjHEcVXGFKLXISnCWiEpTFWFNTC9LM0cTQV1vy8VIe/gpgoregpAmLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDc937Ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5CSG5NZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDc937Ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5CSG5NZ"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778251371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwcLabDXoFYL8fo3t2f3I5h6exflydXeBx0CmYLbbns=;
	b=vDc937KoKJZf2pfpbODxuALmEdnSqr6NR+KqyDmZwJrhsz9Wn6FmS44UIUwG6sljkrG8LN
	9XAvK6HMR4gSQRwjxKWvKYvVITQAoS170lYxEjeAOCZjUQsA+W+VWgZASkNnDtP0bhwrJV
	MO1m1GnjHUJnWmeYZyDelK5grokuGvHg5yPwWXzPsCaUiMMhaR62JxPRqLIevvVGE3Y+Gw
	k1CjUZOfL8xdqaNH3lMktvP9ICwRfaXitXg0fM0ZT2SNqvfiMf5AerlmwldRr8eJa62Mz4
	QS7gUURdgnOoBPnQqQgqmgMqNcoIcErTcwEb9uT9YGjCh+nRnqM/YeDXpSJgMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778251371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwcLabDXoFYL8fo3t2f3I5h6exflydXeBx0CmYLbbns=;
	b=C5CSG5NZFqubHOig/1SUD+p//lV4ixq8ujI3GSFLte8C0EvPBlN/AUc/LMGM0Q1zBZSWWp
	B4C9UGIg77fBe+DA==
Date: Fri, 08 May 2026 16:42:46 +0200
Subject: [PATCH v4 3/5] firmware: raspberrypi: register nvmem driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-rpi-otp-driver-v4-3-cf8d725d8821@linutronix.de>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
In-Reply-To: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778251369; l=4244;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=rr5QjJVjuZvNPD8Qs2aGQvMUMttlLqqHNodH4QGCTqA=;
 b=1rlwc6Yg4qity1EJiiyqSYkFCHC7jSvCQKnyiqibhtbU58U5UIKDyyen/1lcMD3YbvMZ9sczp
 5OTTP5BiYcyCww/wPaFxsFH20qT4TLMMcTCI40Aw7nBOuEOh8sQq7kS
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The Raspberry Pi firmware exposes two regions with otp registers. The
first region called "customer otp" is available on all Raspberry Pi
models. The second is only available on the Raspberry Pi 5 (bcm2712).

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/firmware/raspberrypi.c             | 59 +++++++++++++++++++++++++++++-
 include/soc/bcm2835/raspberrypi-firmware.h |  5 +++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 0aa322e9a2e7..b363ec7bc5b4 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -24,12 +24,15 @@
 
 static struct platform_device *rpi_hwmon;
 static struct platform_device *rpi_clk;
+static struct platform_device *rpi_otp_customer;
+static struct platform_device *rpi_otp_private;
 
 struct rpi_firmware {
 	struct mbox_client cl;
 	struct mbox_chan *chan; /* The property channel. */
 	struct completion c;
 	u32 enabled;
+	enum rpi_firmware_soc soc;
 
 	struct kref consumers;
 };
@@ -231,6 +234,45 @@ static void rpi_register_clk_driver(struct device *dev)
 						-1, NULL, 0);
 }
 
+static const struct rpi_otp_driver_data rpi_otp_customer_data = {
+	.name = "rpi-otp-customer",
+	.read_tag = RPI_FIRMWARE_GET_CUSTOMER_OTP,
+	.write_tag = RPI_FIRMWARE_SET_CUSTOMER_OTP,
+	.size = 32,
+};
+
+static const struct rpi_otp_driver_data rpi_otp_private_data = {
+	.name = "rpi-otp-private",
+	.read_tag = RPI_FIRMWARE_GET_PRIVATE_OTP,
+	.write_tag = RPI_FIRMWARE_SET_PRIVATE_OTP,
+	.size = 32,
+};
+
+static void rpi_register_otp_driver(struct device *dev)
+{
+	struct rpi_firmware *fw = dev_get_drvdata(dev);
+
+	rpi_otp_customer = platform_device_register_data(dev, "raspberrypi-otp",
+							 PLATFORM_DEVID_AUTO,
+							 &rpi_otp_customer_data,
+							 sizeof(rpi_otp_customer_data));
+
+	if (IS_ERR(rpi_otp_customer))
+		dev_err(dev, "Failed to register customer OTP device: %ld\n",
+			PTR_ERR(rpi_otp_customer));
+
+	if (fw->soc == RPI_FIRMWARE_SOC_BCM2712) {
+		rpi_otp_private = platform_device_register_data(dev, "raspberrypi-otp",
+								PLATFORM_DEVID_AUTO,
+								&rpi_otp_private_data,
+								sizeof(rpi_otp_private_data));
+
+		if (IS_ERR(rpi_otp_private))
+			dev_err(dev, "Failed to register private OTP device: %ld\n",
+				PTR_ERR(rpi_otp_private));
+	}
+}
+
 unsigned int rpi_firmware_clk_get_max_rate(struct rpi_firmware *fw, unsigned int id)
 {
 	struct rpi_firmware_clk_rate_request msg =
@@ -299,12 +341,14 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 
 	init_completion(&fw->c);
 	kref_init(&fw->consumers);
+	fw->soc = (uintptr_t)device_get_match_data(dev);
 
 	platform_set_drvdata(pdev, fw);
 
 	rpi_firmware_print_firmware_revision(fw);
 	rpi_register_hwmon_driver(dev, fw);
 	rpi_register_clk_driver(dev);
+	rpi_register_otp_driver(dev);
 
 	return 0;
 }
@@ -327,12 +371,25 @@ static void rpi_firmware_remove(struct platform_device *pdev)
 	rpi_hwmon = NULL;
 	platform_device_unregister(rpi_clk);
 	rpi_clk = NULL;
+	platform_device_unregister(rpi_otp_customer);
+	rpi_otp_customer = NULL;
+	if (rpi_otp_private)
+		platform_device_unregister(rpi_otp_private);
+
+	rpi_otp_private = NULL;
 
 	rpi_firmware_put(fw);
 }
 
 static const struct of_device_id rpi_firmware_of_match[] = {
-	{ .compatible = "raspberrypi,bcm2835-firmware", },
+	{
+		.compatible = "raspberrypi,bcm2835-firmware",
+		.data = (void *)RPI_FIRMWARE_SOC_BCM2835,
+	},
+	{
+		.compatible = "raspberrypi,bcm2712-firmware",
+		.data = (void *)RPI_FIRMWARE_SOC_BCM2712,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rpi_firmware_of_match);
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index ae73c9cd19ba..17595a96e90b 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -9,6 +9,11 @@
 #include <linux/types.h>
 #include <linux/of_device.h>
 
+enum rpi_firmware_soc {
+	RPI_FIRMWARE_SOC_BCM2835,
+	RPI_FIRMWARE_SOC_BCM2712,
+};
+
 struct rpi_firmware;
 
 enum rpi_firmware_property_status {

-- 
2.47.3

