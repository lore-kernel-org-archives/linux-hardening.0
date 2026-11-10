Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328452;
	b=Q2HJeQiadW0SEHaBC0kAepvmYyBzUUwyIGslZlKL81xQCfs5rnRLiWu2EtAlX0EqzZ0J
	 +E1q5t4ixZiji8PXzpu0Me3GhjoZAR85Y3A/0nrfKrMi4mabSiXFvIBztMO4W1AP2Kx8Y
	 vgKZ8QlLGL80y1CfoacjJxOkTlY57asFAI+anvXrQAczkBWT1P14U8epSZpZja3TXcaqg
	 M85wRV9cThMlt1DUVrsNP2PNwtRYps4B8inQRrp4QH70YpWPSvG7qItD2zAcL7t4ZVfAT
	 7rWNOkszGkznloE30b22idbWowaVcF4CmNBgWfOsapP/zMcBVc8HrmoyARSDfJvyCQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328452;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=qXG0+Kk4/ugj18XvhqV21fQa6rtZ6RO537Bs4afzxoO20jRewDxESCUogF2nUhWVmwxI
	 jUFYvl8YtHA/La8jXWZzSh7UJS5FGVjtgWkP+b3sXZfcyxZDvt8tlEfYwqX5nqfHI/+42
	 GY/DNLFxP3l4gPNHvNmJMLPMdOThKGoGLnU80/U1tXCZmUcGWXW6ibjDaCDGq94s2Db9X
	 Exz5D4gwskQCkcp9v4z5YS4HwSappVka3WL2I/40x9wZcaeTZa2YfBXJpLQdIPoixRzHl
	 a9p7OFXomp8L7Dm6RNWo6V5fUpG8u6jBDIGWlWs+v5VoH50zGzEaUDMEF4h1Xs0JhoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ta6nf+j7;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=70O6f4JL;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31C60A2616;
	Tue, 10 Nov 2026 16:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB31C60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ta6nf+j7;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=70O6f4JL
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=ta6nf+j7Pk7YGrUj0E8g1PafYjWgYlup843DRym19ZNPaLPxAH9KJN7B1kow9bqMWr7CO9
	3My3b1qVuUQAFoJuOM9G22wzpN3XkFdSu+QxyJXfCUq8n9AjiRGVgUuSIYDfr4cNqs/ULL
	DRZ2Obgn3+JeIQnYoi261uZ5iqXgjGQzq0KMN0ESRJSM1xw43EO2Nati7ghUcy4d9BU0VL
	isTXvFlyLp1UIKX9O2OyCwToA0aet/L6lJ/u2HaaPXw7JvHdd3hxt/D/g0/+m3+WlVA1dG
	GnwjVA5YfYFBfpxLhmNm0EdgXTPSty92bVCrZ+2S1B/1MZRV3tE8VTn1twi4FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMSgz3CY/8/3JYVAcyQp/zth9ub02Ou+XtUUypEUVI=;
	b=70O6f4JLIdC5jN8uNfhQ8XF4uhO9ho0IVHeFZPsVvGTwDmMHZfkTQOsVo0ZUF+er6QKoYH
	d7RdPNLuEQ5FNzCw==
Date: Tue, 10 Nov 2026 17:34:01 +0100
Subject: [PATCH v8 02/12] soc: bcm2835: Use IS_REACHABLE for function
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
Message-Id: <20261110-rpi-otp-driver-v8-2-797e0577d414@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=1460;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=uxXK8avB9nb6Zmd3jDyY1bgqVIcNgF3TcaoqB76MexM=;
 b=eKk5HELHoY2U4YN8NqP54WhS2Unof1lVuRJBUwPgQdp4fc7r5I5mdh7InL/Jqh/v98oVe/112
 Q1gUHP1pTyhC9yK40tXAfJnsm87Hy35VBBGYMJtd8LMCq6ZyycMWx3z
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

