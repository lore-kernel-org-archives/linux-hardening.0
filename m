Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823858;
	b=RwxX4uwPzSrGlYju+Lry38cySQcUDkCYT5OishJrsj4NLsr6g6YNBV6jcdDjSl2Bg/QA
	 8fu9zVZhy0W9mqOhJHwwpF1qazjAqS/D3BBWdkSem2t0iYeFTkwzadmbg99INP8esQCXA
	 Lj8MML/kJkq+nJPcDzwzr5M6oEsxRknNP3exZWftSWl474SA8btbrKr1lPiRcRnqbhrR/
	 nL+Sph/AoceKWYkwgp5KcRN7apKq5naWEyb5P/d0Zlu9DOeIN3ZcR6ERJE6OL9axC6DK9
	 8Ai5pQHizxmUpgQGJGb8VdutKZAWaWRDxjm9RFgZUvecy08sMlzsRgMpR0WlPKQjfyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823858;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=a6csq20rgr9r7gJp8hsI9hSHjZI6LgAyVP6ErZREN/YktklfMI5ixSL0/j8QdjtkN2eY
	 dh016QpeOJYg7Yj5fIAvXlMhJCBQ1kqF/GShCAj+m2MnkBGZxYNnIV/cNpaUQxbakYiMn
	 9vNT6FKZmJWSCPO4k6vDdiXUOltkeH7p6Xjp5GsRhT6jb/JbvrPFb3NzXKDe3eOztyi7f
	 43Nkn65eWLV8mTGaC7TimOv7R+3kQbSbf7N99ABTEp5cSAWZeC96iJpfwEdkCjGvRBsa5
	 bOo28FnBbGBgmKA7gIqVcqZ3JZBadfKwHb80CVSQFQNWtaKhbMzz6ij/5BwcKCNXnlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="n/Pxmh0d";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="PFNI/r+9";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607D606A897;
	Mon, 16 Nov 2026 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B607D606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=n/Pxmh0d;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PFNI/r+9
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=n/Pxmh0de3e/stdSFzN3Lw6sozt9kEn9uuS9oYkWJgi/4qS9raXkk3ignxJMdPtmZZz4k8
	sBqH9UbyN7TR3JbutSW4XFVPYCbx+pCAsKBvCA1wuh8rSnnq8cqm8jpcxFDD7XnMeGgJB/
	QBYYdPchA5/ClE1vzElQiWcW3yiZljZIx1SLH4Yu1OAsc2EVIRw5gI1ixSM7NqNROnDnIO
	q4sND9JMVf0B+bokh16WQEkhKq6hn4aBeAA3L543Q0Ftu/HkHY4FlRPA6NL+3z/HjzyKNX
	vL3PHSCXiYYRNkD9l4GRD2YqaccoB9Q03wGfsyWqmK37oy7AGoWoMwmnA3QMXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utibFfDFq4bVa7w80q4m2c30lWgg7YBiQK/do3c4QEM=;
	b=PFNI/r+9BNpBo4UxQPIqCqqoWUr35OHMmn4ERk9czCJ8aF1FIAGHPezHaGeJfEvyVpHuNH
	xgQMFhKFlsgii9BA==
Date: Mon, 16 Nov 2026 11:10:36 +0100
Subject: [PATCH v10 12/12] firmware: raspberrypi: use drvdata to register
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
Message-Id: <20261116-rpi-otp-driver-v10-12-15302dcfd5e1@linutronix.de>
References: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
In-Reply-To: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=1263;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=GviQG78udImKkh93JAYuiO3wqf5GT1E5ZSWcEvo9qAI=;
 b=YVdsLQOeN2iNYkNDOQrVXilaWHHEY99aFUFs41Cm4Uz2lgD95XFoLHXymbK13DFAmLZarA1bp
 sXrNp2bbrQvAxXDMcmjojHNJxLIFsdR9OycL4/gvoz+Xv2HOShujUhi
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

