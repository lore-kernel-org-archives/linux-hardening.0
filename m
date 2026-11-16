Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823856;
	b=Fk03OBuQfSSdxvz0Po4L7YQhTAkTgyrXKSFG1LGRHlpu/ycA1YKMDz89al2i1+VKc4Wf
	 9ggHNnP5XTnm5RMxzS5YyG67Kp7NhRYaXiP/+W7E620F9L9uK2EDT/bvzbvZIArV9MLsb
	 0baU3J1kObl5up9OcZTJvMeE8on7YSFQP5M4cwQzG9im6a0WZR9pMNaWJPv1IdgGmxCHi
	 mkEWW4swRlR3/UeCtDCTpGGf+8Ldr/ja/JtMkEp4fVWRjCVZ1WnztPQesRAUgW/wkurKk
	 JpZRPcNQTkgIrV3QxmfpVHCOwYgf7TDl4BjVqF6kxsHr9/HW8loif5deYrCNqxI8sLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823856;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=0PcNzrAm+ZHWxKmhopZRMwa8hvJoI4qZ7QndHfl8spQ=;
	b=TL6wpqyvaMNN0cUNhN6GYhB0+wx0Hkp8dVoXidVAQwluL4dC8Ng8zQeoxDInmPp/sitG
	 +ipV5cy+DoaubrulJYK0VEPOeuZk/UUEkUe0fpfIxgEXMuxriA44BfXN4JkLao2lZNrms
	 XWz7GneW7+EEq3rXTxsDcW6Hbc3OyceochxGyVJGI9P4eEkBlopbVODzZ/itCMHcgsqAk
	 jw6CvJLm8BUWNGYxACnnvyv5xeX/1+/TTMDniAxvIRlv8Xz8qoLGIGlWTnccR543FYzcZ
	 uuRUVxjgtrA0nB+Cu3Ud7DDebgW94YqpWDJWMzJIfqFU6AIvXcCL/lMr9Tn2W7fyuiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZPiad3g3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mfiIiWpl;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3A606A8BA;
	Mon, 16 Nov 2026 10:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC3A606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZPiad3g3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=mfiIiWpl
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PcNzrAm+ZHWxKmhopZRMwa8hvJoI4qZ7QndHfl8spQ=;
	b=ZPiad3g3CmGmA81I7+QKSeywx3EZ6HKd6G9MXcBCkL7tDUTrHU6XiHAT4zjdbNtGPmV7hx
	ZqoU/TvC7saMLC+tD0kdpwxH8wxUCvWm04BbyBnpHpm9tOyCw3T1QMzWRLpvlesadW/KYv
	f68M3ZxJAd6TrenbzQRVd3f/CCc2szKk2T2DdrSRYPgfZhw5KuaOHgr4nWUOHfWT0r48Xg
	8WbUyYIT3isAcbCi4cgzI7T52/YfgR61AsyxLCbW8+j0ZfNAqsCORy7GrKAeaJxF4LE5Fx
	0CtgjQvR5TggOMYzS2kW1DRjievJUc7h5vhs5Hkg7tn5P9KcoekvCiA+yug/DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PcNzrAm+ZHWxKmhopZRMwa8hvJoI4qZ7QndHfl8spQ=;
	b=mfiIiWplWB6zoUPvfYqYo+K3Pxnhf1QHaw1XPSkgfve4sQ+nGCTUjxtgUu9ubNHOw7kf7X
	PN23sD/H4cz7CAAg==
Date: Mon, 16 Nov 2026 11:10:31 +0100
Subject: [PATCH v10 07/12] arm64: dts: broadcom: bcm2712: add
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
Message-Id: <20261116-rpi-otp-driver-v10-7-15302dcfd5e1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=1201;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=QzShj9jr69aONGxWIoiSXIgjOLO6bK2pyRL4MJ0roYc=;
 b=byk563fIBAvyCOVhaWPyqwqPcdFvz0k/dhwFz9x0yE/lF+dMeCpKUXcuFoWSe4tbQFyhKPr/A
 jWpXErwdBhxAkX0iLQpEalH1yAzLiCyc8ZhSD9JzlNyJFelKKTRRODY
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

