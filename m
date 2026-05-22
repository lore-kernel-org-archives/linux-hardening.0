Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDA477990;
	Fri, 22 May 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464422; cv=none; b=o8cw28X2QSuAt3wQUQHSwr2y8/eflZV+YtO660kWIxWnPoFki3UdVoKEL3lWzMgkxQuYtbZZaGB+zET0di5bQ5UcukTFzELvxK2C2pjF6MfdpwJccXtXd+G8BNIO9oU2OZX9DeYiwyScehqBb58Fo8OvZyP2zi2cui3jqg1puBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464422; c=relaxed/simple;
	bh=dbam25rkEbN6V1TXAKuie6Ogixkx8DZyxneAOo0kOp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvtE8btgRsXKLJccXFQ/dZO7MT3c7tVlIJI/37de7czD9U/NsvCd9QPGxv5z3kkN9yjjJxNV8HSXH+oC/kox653R4HZw55O6yTcsPDK87RGWUhegoFJfD2Qg34FqTcNBYTBX4iKvNUANq95rieB6m9zmLxQvoyojQlvMqubwv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxXz09F7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fYN3Madh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxXz09F7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYN3Madh"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfKfhvP2du3rzKmOjT1cyHP3hfhMUxY9/nQXytvqksg=;
	b=PxXz09F7qoDZWM8go/X2DhIqNwsSaJnic53ikfdN1+3R1bFwkU45pUAHGHziYsm/cu8y9R
	+FLWQTYW+LcVsHEY4a5dL59nDboNT05ercwdIs129hi7sI8qxwpchXswicKGQkvfnKFGN5
	9O8WS0N5WcPfzpG+kraWMtidrSa14rrS7pCCrVqGmgb6/3zXjWms82/MHmtEwLUpH2q/z4
	EcOKwcHE32Q+y/c+L3nwPOyYgVcL2MkU8IY9Wr1Xa+T6lLLWeep13peyOPcJl/JjqspDis
	hIVDaDBQRyeAosP791fJGOkBR7rPBdzw79f6/6h6R1UnxI7sAm9qHUV04ZpG/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfKfhvP2du3rzKmOjT1cyHP3hfhMUxY9/nQXytvqksg=;
	b=fYN3MadhBZ0CfTScck+WjLZ08plOLj/rZ9Ki9yG7fWRXi96ngcTh8LDyVd/XY3wWspVwNw
	cERVoje3zj74SgDg==
Date: Fri, 22 May 2026 17:40:06 +0200
Subject: [PATCH v6 06/10] arm64: dts: broadcom: bcm2712: add
 raspberrypi,bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-rpi-otp-driver-v6-6-b0eac97d1428@linutronix.de>
References: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
In-Reply-To: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=1201;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=dbam25rkEbN6V1TXAKuie6Ogixkx8DZyxneAOo0kOp4=;
 b=5pPf1O9USa6M5UoDXP0qSrdputP8iNWGX81P62kddkh7ONmmg8NtP85QRW4JIs5y8K0wquHig
 VUhQAE9ItstCmYpCvy7NXYSOIAN+RCNtnw7sohGXWhJlBZHLGV/0mXz
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
index b7a6bc34ae1ab..4aa8ec7601b84 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
@@ -46,7 +46,9 @@ power_button: power-button {
 
 	firmware {
 		firmware: rpi-firmware {
-			compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
+			compatible = "raspberrypi,bcm2712-firmware",
+				     "raspberrypi,bcm2835-firmware",
+				     "simple-mfd";
 
 			mboxes = <&mailbox>;
 

-- 
2.47.3

