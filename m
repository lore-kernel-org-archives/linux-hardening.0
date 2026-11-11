Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381824;
	b=aXhen+ngtlMaXYKHUV/H4kZDakWX52TjDks+OBoTyv7/JsngaPftFCLZsUkBiuevRE/L
	 zqXYH6JE/r5viuDPrDBQrq4r5FEe8RwYathz8MG5QV8fMiol+ElOTcx9OijyYutOk6fD7
	 9V8IYIzhkm6oAsWR8tVdZ13rieGcRluVPuzX77v4G4T3Y0k4lnfrC+2uh7Pc5KEE+SHSc
	 orXvyR8WXrFdEPIdojV47ScXggwIlNPKnTMkm0EvjOBaeLmwPEzoYCFW3CT/HJHqII1P7
	 M6yxcjBtmwwRyaZg67HEsOUaoNVVuMnay19cbJBjejLV2TXFrxFYAJSZbYDHLOCnx0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381824;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=0PcNzrAm+ZHWxKmhopZRMwa8hvJoI4qZ7QndHfl8spQ=;
	b=SdVBtRI0gcd7PXJe1G5ma1EUt3Sy9LAA6iVdkUIzHmKAHfq5eEy4FdgiwYmVzuRziLVt
	 E0PggIw9ka5W7BmzmdXpsgmSizdPOTsFocbIwTo90iHOMPQWTc9jEjXrpOPFsfX0iFrZq
	 +lTweF+3o/zSRcoLwCxW7mPOxKfnJND/vqp0E/8m3q7aDNbzTicrqj53UboVHlsRCB/4o
	 ZmQtV8M7mK+FEW82b7JKe+ZdIf00gX91JDFV2QRbOMTCDscqeSUK6zw1zEVBkOwAes6xf
	 cz8Gn+/zrgWT+sMYO1wOgP+FJdFRF/3GlS5DIL44LPk4BywUIxauo2q9rs4cPBxTo5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sxyyn9M3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GEyLXiIP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146A606A33C;
	Wed, 11 Nov 2026 07:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1146A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sxyyn9M3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GEyLXiIP
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PcNzrAm+ZHWxKmhopZRMwa8hvJoI4qZ7QndHfl8spQ=;
	b=sxyyn9M3/G+uTPw6gzfIDshh9yNtCoGnsyEX/kDqYc+RNgchQAO2ASOAwFCnDeu9DhI7dy
	e2y2b8rjgHbtLsRD9eYq4/sL3Uuj5TyUGavUgNHr+8oWBaRhBOr7stg1SGDpnAUpHrTSNp
	adWN1JjKu59Ir8hzQEroTHQP5/cgLSST7PVOG15/conpz7lsHf54tLDeWC4DtJYnJ7MBYW
	Oa0ArEaVpO2Y5t04sbLvx/HmdrTdJ3Fomnfym0IterwRYMt2wCfDQHfPSkm/mrMccQBwRa
	6azFWNZUb2X14J/Ob5q7gJmobl2YONU+mVpHw1ypSdYCQbSxIK0PBPYQrcleVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PcNzrAm+ZHWxKmhopZRMwa8hvJoI4qZ7QndHfl8spQ=;
	b=GEyLXiIPUwnl5CmrleSbYklmehY1PnTfra7R6umGroAYRj7mnu91/mrc/Hjef33H6OFF6Y
	3M1W1CTTnJHxvbAA==
Date: Wed, 11 Nov 2026 08:23:29 +0100
Subject: [PATCH v9 07/12] arm64: dts: broadcom: bcm2712: add
 raspberrypi,bcm2712-firmware compatible
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
Message-Id: <20261111-rpi-otp-driver-v9-7-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=1201;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=QzShj9jr69aONGxWIoiSXIgjOLO6bK2pyRL4MJ0roYc=;
 b=GdHKm1vX8tHDaT2LmADomFgdjCtLwyK05Nb1/ZsyM8PqQGONlxhMzvNRH0fhIYHCWDlrEQP8r
 ZfQ58Qh6uhBA2ESog/a0R+NMbiN03PCq6TdC44N73QZp1f/zQYJOUOK
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The Raspberry Pi 5 (BCM2712) firmware exposes additional features such
as the additional OTP register region called 'private OTP'.

Add the raspberrypi,bcm2712-firmware compatible to allow drivers to
distinguish this hardware variant while keeping
raspberrypi,bcm2835-firmware as a fallback for backward compatibility
with existing drivers.

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
index e5030da60f9e7..4d578e15190a2 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
@@ -47,7 +47,9 @@ power_button: power-button {
 
 	firmware {
 		firmware: rpi-firmware {
-			compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
+			compatible = "raspberrypi,bcm2712-firmware",
+				     "raspberrypi,bcm2835-firmware",
+				     "simple-mfd";
 
 			mboxes = <&mailbox>;
 

-- 
2.47.3

