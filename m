Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381823;
	b=JyOTxQOP68QekXTP/tSzl8m8N/slvpgPNOfExVr/5MARa7RVr3yAYkCxAKyYdiKvXtcl
	 LXtNSmL8q5uy4FZ+v/OZNkCOX0wqhk39u6Fm2wfr5u2FVsCZzD6ruQxgt00zsngX3ojAo
	 1ClIPyFTF0CZGK89YWwWo/K6w3XHDvB9DQF4YeNV8GChAe9EngDgAH+gbefuGjtLeYZpu
	 10mJKMXlPR7dgN5pppRiQOAQ2f5icgW8Cpp0o8bdzbHMHCPY1mzcX9waPeeLVqeA4MkXi
	 ByZ6x17J3fW2ST1wDRXPQI6VWEUvb3uBHVM7qVSY3vUM28/ASB75C24+M3HsIeVWzxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381823;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=ezFqtxLTIBFIG8G1txYl6cMQ0D5n/RwqQ2a2PuxKgEk=;
	b=XECSFsiDvgs95XaBbL/5XyxF8cVIr8EFpJ/TOO9lTIYtxqrBZfZFDU3buP8vt+TlqSJ8
	 6ljZTpSmzS4urgDMC/rQF79Bh3dUgQaEs398mCkvLyWh2bKc5GiOFUM1f6UwYD94R2Wm2
	 iOSeepCrsQHqM4N5jPfboHSM5Wtl2lNXI8Z3m67lZoqgXPMXIVqrJ/5/M/osW9DP2Ezd1
	 QgDKElBx82OyQhZsLBxcABtTPZooirj31vbGEDPrkyE/xJuZYO+Q9Ho6Rkg/4SK8wQjdX
	 fABbYaISeCw96V+mNvdNLhOC1JRV4w20IMppo7F307ephXeA8BjjPblWkZwhbcfU+/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gb8fha4o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ySd5eoWs;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727860A2627;
	Wed, 11 Nov 2026 07:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E727860A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gb8fha4o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ySd5eoWs
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezFqtxLTIBFIG8G1txYl6cMQ0D5n/RwqQ2a2PuxKgEk=;
	b=gb8fha4o+8s8MVD4RqBJtGo7wJayb/CoiBFyYxKyedlmj6KWy1Nu6fj4ZRg2xEju3lGTOI
	Wu8hrtbQwncjFcVYYMm7HzXm3DaKEUEiw2xOImvBAxkLt1vAt0o8ZC7x7thNJrtuwEY8gH
	ggxj32b0S5jmyg2deMGYXwNQ4yF8SJ5uvNpS5YnabqOgJVXQtRfEETSy1BsEISsV8wg0Xs
	dDn2vIqF+5LYifwA+XN87G/DR72BiNSrKVweaaHL9Ap2KwlBfUCcE4kzvrikEWFg/djfhp
	gIouv2cDylH9gDZdKW2EE8yBRb+Wo1Vy+3c/qnPyG2D4QOlYwP2gsy8yRftAIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezFqtxLTIBFIG8G1txYl6cMQ0D5n/RwqQ2a2PuxKgEk=;
	b=ySd5eoWsHZxADB8OVpJ9liIm6iK9f69vR/Mfgt0Yth/xK/9AdClADK3ZWYdo1qYOML4IiO
	/DFE2jR8cevvX3DA==
Date: Wed, 11 Nov 2026 08:23:28 +0100
Subject: [PATCH v9 06/12] firmware: raspberrypi: register nvmem driver
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-rpi-otp-driver-v9-6-0a7292a7a5b4@linutronix.de>
References: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
In-Reply-To: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=4414;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=YNBRPkvZhndKwpMu8ZxY1514Y/y9TgfpND27yu3L9nU=;
 b=XFnl7ovdUWJE6GV2Xw+JDREti65IFODyYjcwPh5earhDXMkPK7S/w7O8fPy3zzDqdYpFhFiqq
 1CQ8Htn+RKyDygTRcGlnLjZKUVerqsjHjsvO5WlGRol/O4ZuQ0OOz4y
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The Raspberry Pi firmware exposes two regions with otp registers. The
first region called "customer otp" is available on all Raspberry Pi
models. The second is only available on the Raspberry Pi 5 (bcm2712).

Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/firmware/raspberrypi.c             | 59 +++++++++++++++++++++++++++++-
 include/soc/bcm2835/raspberrypi-firmware.h |  5 +++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 443459c8c90fa..755f845754c1c 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -25,12 +25,15 @@
 static struct platform_device *rpi_hwmon;
 static struct platform_device *rpi_clk;
 static struct platform_device *rpi_rtc;
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
@@ -252,6 +255,47 @@ static void rpi_register_rtc_driver(struct device *dev)
 	rpi_rtc = pdev;
 }
 
+static const struct rpi_otp_driver_data rpi_otp_customer_data = {
+	.name = "rpi-otp-customer",
+	.read_tag = RPI_FIRMWARE_GET_CUSTOMER_OTP,
+	.write_tag = RPI_FIRMWARE_SET_CUSTOMER_OTP,
+	.size = 32,
+	.root_only = false,
+};
+
+static const struct rpi_otp_driver_data rpi_otp_private_data = {
+	.name = "rpi-otp-private",
+	.read_tag = RPI_FIRMWARE_GET_PRIVATE_OTP,
+	.write_tag = RPI_FIRMWARE_SET_PRIVATE_OTP,
+	.size = 32,
+	.root_only = true,
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
+		dev_err(dev, "Failed to register customer OTP device: %pe\n",
+			rpi_otp_customer);
+
+	if (fw->soc == RPI_FIRMWARE_SOC_BCM2712) {
+		rpi_otp_private = platform_device_register_data(dev, "raspberrypi-otp",
+								PLATFORM_DEVID_AUTO,
+								&rpi_otp_private_data,
+								sizeof(rpi_otp_private_data));
+
+		if (IS_ERR(rpi_otp_private))
+			dev_err(dev, "Failed to register private OTP device: %pe\n",
+				rpi_otp_private);
+	}
+}
+
 unsigned int rpi_firmware_clk_get_max_rate(struct rpi_firmware *fw, unsigned int id)
 {
 	struct rpi_firmware_clk_rate_request msg =
@@ -320,6 +364,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 
 	init_completion(&fw->c);
 	kref_init(&fw->consumers);
+	fw->soc = (uintptr_t)device_get_match_data(dev);
 
 	platform_set_drvdata(pdev, fw);
 
@@ -327,6 +372,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	rpi_register_hwmon_driver(dev, fw);
 	rpi_register_clk_driver(dev);
 	rpi_register_rtc_driver(dev);
+	rpi_register_otp_driver(dev);
 
 	return 0;
 }
@@ -351,12 +397,23 @@ static void rpi_firmware_remove(struct platform_device *pdev)
 	rpi_clk = NULL;
 	platform_device_unregister(rpi_rtc);
 	rpi_rtc = NULL;
+	platform_device_unregister(rpi_otp_customer);
+	rpi_otp_customer = NULL;
+	platform_device_unregister(rpi_otp_private);
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
index 96ddf886d579e..2fb1ef2a33141 100644
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

