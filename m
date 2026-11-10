Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328458;
	b=WgTvJmmHWoDoP8/DSAT+vZKC1CAdIy2Pb5cWJspLBt/yHZsZYQvhl/UXKwkHcXBnER+8
	 2ng8C/vsAc189eiEqIyfIlswROQSlJeLBymTLQUTYR/3UbtIZ3d+QaPn04NUApRuB1NOj
	 NFtyIyq+bfe2ndujhQkbnVwWBpeJp9KsIPbNe8mwg3N4lAlhiMUk1ec+0kYFrCXpRYXjZ
	 q7/ecE2j7tHm/0+/oF07/ltkvTnxE6kzqC+BCu01lRYsd7QAvQCAclaJb9I9uwobpUaHP
	 cBtalKOg45kDOZyxEFoYZ3/1O++JGwda5q2/C2waU+hpuXm+SicUhF3KlG4kcCDBSwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328458;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=JSHtFu6tuGma5li5xHjrsA8/qpv3s84JwLUVCOg/ZTkmCVnIAgfq9ySsMc1WTwyxnfSE
	 vECMWSu/bxKJl5IzQ2LV2voOuqW1WSS/2i2qNKVDVOJAFPqn4I26alC9rFMhTBFIjSvHb
	 k+Q270tpaVEEEgVpBnFxcGWPu2uD1Pnojb2XRFf/y/q3LGSYANIYlqtBQ1wHWhjdYwWUt
	 FZm2EmmtUSKxy9FYKI2IYZ/jKyKAxYBbwmVyW6KWHmpXdoYx2yw5pi0+UItEMHZwKtw/M
	 43oCKg6vcsIIa8OPZi05zeIYaI2unD5N/n0W3rv3FLyMQQ7ShwJj0yt04NSOmqzBu5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1iBl3oIB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=h2FkN3i3;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871460A6F57;
	Tue, 10 Nov 2026 16:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9871460A6F57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1iBl3oIB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=h2FkN3i3
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=1iBl3oIBebO2xP/W7fAturiU2IKNz3RcgkeLfUlPyV2UabBgnFsf4pxS7GmGXD9yniZjxH
	1jWLjXMyRKZH8Iy8kijihnueHAYOl9Y5hrKs9kmyWFAS8sE4urBCwKmEY2jnO5baXYxyom
	i60KgxWuRZ2GwXHR6+undBdDJejmy4ZXbWNFgocnlX6wVyniOG32qroVIYqCYP3If3h8Zz
	F5QddStcU1iK7vpieNZCIgkh9OBnGOF65rlPBOALpy5uDE5R6tf0kOs+lBglT7WaEqPbRK
	mK3iCvpRdhvvvZNOUUUytFlUHecApeGpabTipAaf4Z0QSDZ6r253qah3wQb+rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=h2FkN3i3pUkdfQgjDFMx9LyuKnApG2uypRUqNiLBRrSIpfdlpr3AY77U7azYqDhqIVljBC
	J7h1cDhj1gYtzbAQ==
Date: Tue, 10 Nov 2026 17:34:11 +0100
Subject: [PATCH v8 12/12] firmware: raspberrypi: use drvdata to register
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
Message-Id: <20261110-rpi-otp-driver-v8-12-797e0577d414@linutronix.de>
References: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=1263;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=GviQG78udImKkh93JAYuiO3wqf5GT1E5ZSWcEvo9qAI=;
 b=F9cRIXUnkrG0EopmOUfYjNlH1Nh7iPM9RQOdhWLfXOYcGG/r4P3TqmZh83UfcuugsPCeNvBMn
 imlNJELH9IwAS0JvPrEbsUNP0k5VWW+Ir0KQ0NVkFkANFWEW4OIn15u
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

