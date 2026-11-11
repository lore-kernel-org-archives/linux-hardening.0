Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381824;
	b=W0Af1QtGE/ngk3tj6Nj8I8WhdrWt2wOG5GXJHFB7zclQIygpz0xtVFFcaOSrAh/6XSwK
	 8bQWhaYftpSjXxX5hgnjP2yeDgrmvfykkz2ZtLhcMQizMPQoS0WoAh12Gh6BE0GK3NYlA
	 eTqDnrLDn+fJ5igF0+11AC7BQKnzVKaElJDuln0nEKm/pk/GvIUBJ7er7o4DLTaHzJV8O
	 vjefSZ+xE6C1fkoMfRdxFF3VLg0tUOPxAKt0d/otXK20w0MXQK6SeFr8bLjaoUHuhUsak
	 qFBk6tBhqs9oPMQ7onyHpm1IMU1tMY+PAXZf858PeY6lKbXXsJL0mjvFf9pEEfg9ceQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381824;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=jWUE/xTecTi4srGAce2Tsz9Gd5DHYVhtaguNCdSpUqEE0QXr1e4rjW7hrXzKQXkFJAc3
	 4GIEIneJG2Nad0Sd2VZ1jiQZjPUWYN1LvCX/OxauVVXyUyoPyEJPkxY8KnOniD62nTJRS
	 AeM+6OSdF01e7bkpI704QSKrPhS+FY8Y7R/zrNfSw6y9dTLg3eRN8ZWZVhxLA7vaZNvcJ
	 yC2LofeVObTENOaBpsoK40GMygwgqsQBwOrs3504PTPX8JEZaAQOpJzHIFTn7PeWeBNGd
	 kjTN3SiOHVmnaF6FYwLFOuyxiAHcwi1PJtStZGBTg3ZXYZrMJifbAnM6IPF+els4+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=X8kVFgmm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U9TcsoZT;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8060A3806;
	Wed, 11 Nov 2026 07:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D8060A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=X8kVFgmm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=U9TcsoZT
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=X8kVFgmmZD+4dffUGAKCqwUyzehfK8ICA/vB2EQplLjfYkO4yECSDmIojALd503M0pR1/q
	yZUzWZxLNkubAtBwG1zIpzwuoiXQXaAt/hWIxHAh4th4ribthNpHhOxIjQTM2uQnI3vcwO
	nvNSQZ1kRiUdTkRXHs58xFDye5L60PTLSWRfv6uPKtGAImmFrfp2L3joX8EmQ0s9Kv2FBO
	wvrPcQQILEBblhSxqg1BE/aWKZmqeEcNbdrWsd6VvYNke5RBhYV/W8PmQQdkDyIKuMJ4Tq
	c1sP/Wne9oEefSXmKkCV6gnBxvos7P1aZMMeTS0FiczE19t4oyQTYUB/M3rQvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=U9TcsoZTXUcZxhnjk1EBu2HQGky3la3bS2XUVqgDVKfH21B9Wx4d/8XW+bG65UP2fRMWTd
	0q/EnIQ22aDu8vCw==
Date: Wed, 11 Nov 2026 08:23:34 +0100
Subject: [PATCH v9 12/12] firmware: raspberrypi: use drvdata to register
 rtc driver
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
Message-Id: <20261111-rpi-otp-driver-v9-12-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=1263;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=GviQG78udImKkh93JAYuiO3wqf5GT1E5ZSWcEvo9qAI=;
 b=29iJHbMR7suxaQdsmnF4MfhpgpofeSvjIU+AWQkMpzpLkhnaifkbKERgMFubAoBIZ1nPAvawp
 O2Q/duZ4dK6CLeY+p20biOF0kzVeAu9vSmPS4bTom6b3RykLMbK9Y/c
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

There are two bcm2712 steppings available that are not compatible.
Therefore we have "raspberrypi,5-model-b-d0" and
"raspberrypi,5-model-b". Some features of the Raspberry Pi are only
available on the 5th generation, e.g. the private OTP register and the
RTC clock.

Use the newly added fw->soc data to decide whether to register the rtc
driver.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/firmware/raspberrypi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 755f845754c1c..0cf893eb8b786 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -237,13 +237,14 @@ static void rpi_register_clk_driver(struct device *dev)
 
 static void rpi_register_rtc_driver(struct device *dev)
 {
+	struct rpi_firmware *fw = dev_get_drvdata(dev);
 	struct platform_device *pdev;
 
 	/*
 	 * Check if our model of Raspberry Pi board is from the 5th gen
 	 * as the RTC is only present on that model.
 	 */
-	if (!of_machine_is_compatible("brcm,bcm2712"))
+	if (fw->soc != RPI_FIRMWARE_SOC_BCM2712)
 		return;
 
 	pdev = platform_device_register_data(dev, "raspberrypi-rtc",

-- 
2.47.3

