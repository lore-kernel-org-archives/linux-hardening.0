Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5993ED10F;
	Wed, 20 May 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287291; cv=none; b=U2iG2qvj6/9lloFjRnCProdcW4jFBiC59OLlsrYNnAYxTeC0MANa2HVxgoscWsJtw4MpfQW9GJDIegZXIfi40mBAsYQVJjYlEaYl48QPOK5FvZVHMluosYwCDxLu5s/v8co3lUdwR5Fs8uJ+u/S/XfdDeC/HXis28/ynUCcn70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287291; c=relaxed/simple;
	bh=dbam25rkEbN6V1TXAKuie6Ogixkx8DZyxneAOo0kOp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/aD7ifJsR+HMACh2EtfqyZQkJYqWuLSLH7g472T/A27io+4u08V4nKuNJcoSFeisz29s6IZWe4yEz6LWpLui9t5T/y6TO4yymm6uer0AP3IP+hO3KNAiYXAlT9U7y2w3k9n/8I6idFWHv83aDrIBKfO5d5EDPNZtuncj29F+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWr+SSIf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+VZkkti; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWr+SSIf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+VZkkti"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfKfhvP2du3rzKmOjT1cyHP3hfhMUxY9/nQXytvqksg=;
	b=MWr+SSIfl/GFmT/lyU/BzH2ad/u65ERrep5CT3oMVi6HwjWJKZs4XNzxj4JH75HkpTb6xs
	xSlrAkTqzh23twmFC5NGENIUut62qfYavrlLXRgm1p5Gh8//QFEYt05YeR5cIrQ5+Jmuaq
	bA9x1KkfFGAFLgJ0hpl3xgZrNsd9vtF/n7AsWfALn4U8jbXfs6Qys/qP+2vAPdEhyU4zRZ
	JOGH/H7bNDQwnJPmLqhQ0S5WptG1BNwTyHwam6bEYlAFpT6aVJOfbQzTq4gpSRcMWkjsUp
	h9VpOx2VPlxQ5xyCJeRgKWlU7dZ8ltt7hXBRrMUh+7JbXzoqjt94+qFqpFvzwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfKfhvP2du3rzKmOjT1cyHP3hfhMUxY9/nQXytvqksg=;
	b=w+VZkktiOKTRQjuN5XIhcQOoyQ3PrV0gSyaOq1hUm8ttDeACSBUC8YwtqYtCkr6V3YjrI2
	UqA2LTUvnICiS2AQ==
Date: Wed, 20 May 2026 16:27:58 +0200
Subject: [PATCH v5 6/8] arm64: dts: broadcom: bcm2712: add
 raspberrypi,bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-6-b26e5908eeac@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
In-Reply-To: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=1201;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=dbam25rkEbN6V1TXAKuie6Ogixkx8DZyxneAOo0kOp4=;
 b=wPR9/E5m55Q974JVz5+kmMCFpyfF14YKJSH08maRZ27KgCVFliDimNROL8st52w1b4IsJ3nig
 SuIEpiJ6heoD1OIEWL1NRxqdlRD324f/mQUcp1U2wrLEt6srKqFvNOT
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

