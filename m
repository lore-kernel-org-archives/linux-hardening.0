Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327860;
	b=UF1S7fX5kCBiFqgATbnQUETwSgV/LNpV4fxhbn2lfG7Iq6Ppxv0ERDPYJhwPzOwwkJJ9
	 J3gz2P/qTW/cRxu8Lw0LYAhGav2UPXtbzRCeE/KoXuwVFhgo0rHA3TwGXwrTQ8g0wGRl1
	 tYsmZib6mOyln+G0UpbuwEspFA/hC1cs9Lywf7AA4/xLkB155xp7M3LXZTuIfMEsRNYcA
	 wz+Y+9CH+jX90WGWb7ZYEZMSRHs3nBEvZxL/AfkFMtcJ3YE7LxCOwdHh5H4YT/v1ZI6v7
	 6VmPeljHQCNFw+ybrZCI4rCb3eGZ7JH+MrKZLsftAP8mUooa01+5Cii7MV6RY9q0TFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327860;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=3ng7lS+4pM0pc/5OGT9t3PRXiSwwy5eC/KVEgR5cP5bO9mZH9CBZ50vZtlrhUn9ziU1P
	 ng6Dxi1pOK8z9EoDzePRFaUb6fjbtOShz/YVDpNHM5034ej4TCzTPOP8Rnd14HU1OVOW+
	 IWAp0U4UjzykihF3cW6clBo17OLbMwH4Gy/d0LXOpk9gUiLW/1e983eY4IVp5PaXcCNJ1
	 /3SaSrW3TrbBAzhFLsVIyVUhT80n62JTyDxZEtm/T8Yb2V8fuA7DlIPXvvAguOBkRQYOc
	 ZlZRItgDUhDc/+lf3BIQ9G3qRoIdPhmlJv86Kr6GByc0F8ytaxu6Xn1J4Hr41FR5bzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HAppfUhU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HSOq0GZE;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FDF606A339;
	Tue, 10 Nov 2026 16:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FDF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HAppfUhU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HSOq0GZE
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=HAppfUhUS8prBnU6ajzPS1/F8m1z2Gy0HHJlYbYImKn8mqHWzyjcvP9RL8TjMmY0twcpez
	c3Is/6W+BvxO23SpYNdeBFRLU5J4a+bQ2uQMjB0XQ3arkQPAnVo6XFpL2JBLWgmV2my27g
	p0rYdzxUI0spwGEfr46hM4NcluB7PoiDBf2u5HRFce4WGyyq0M3OjiIREzSbAC1rLkRNHX
	di9Rb2MCCxDm66Z251vJeeT1Pds1yoCof4K2Z5QSMZGHyWOgAN6uRodVqinxwA7zD8N/Zu
	B95TQb6rHgjDbOFNG9OKPbPQ3G/Io70/PhWG1VPPgQAQoSbZjjvN4B/RHNTrqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=HSOq0GZE4GI9G/wjQ9B8gCTXs9xreOkvSQG+tCKKSYksJpREZB5Pgtq8j02eZhKzAVb+/P
	SYEaYhN4DumUjfBA==
Date: Tue, 10 Nov 2026 17:24:02 +0100
Subject: [PATCH v7 01/11] soc: bcm2835: Use IS_REACHABLE for function
 declaration
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
Message-Id: <20261110-rpi-otp-driver-v7-1-2345d0ee65f0@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=1460;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=uxXK8avB9nb6Zmd3jDyY1bgqVIcNgF3TcaoqB76MexM=;
 b=w+ga/bAg6USiU/RP5A9EhY7FAdZdokLh9VUDiuX9+LU0jBEyEI3TLrOeuk5zN1ol0M6VBqZ8h
 lz+HktjWk1ZBpoNpdf+V1VIoOv/iuiJy5VH5FGAY70C5MUmY703TGL6
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The drivers that depend on the RASPBERRYPI_FIRMWARE use

	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)

This should ensure that the driver is not compiled in when
RASPBERRYPI_FIRMWARE is 'm' on COMPILE_TEST which leads to linker
errors.

The same can be achieved by using IS_REACHABLE in the
raspberrypi-firmware header. This evaluates to false when invoked from
built-in code. This way the Kconfig can be written as

	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST

Which is a more readable variant.

Suggested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 5a0cbb18d0b6c..33ac26f2f135a 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -201,7 +201,7 @@ struct rpi_firmware_clk_rate_request {
 		.id = cpu_to_le32(_id),		\
 	}
 
-#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
+#if IS_REACHABLE(CONFIG_RASPBERRYPI_FIRMWARE)
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
 int rpi_firmware_property_list(struct rpi_firmware *fw,

-- 
2.47.3

