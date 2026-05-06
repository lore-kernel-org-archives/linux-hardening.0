Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0144A711;
	Wed,  6 May 2026 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070514; cv=none; b=jUwgIahd8EB5jXrCs2jGHeS4kC5rtInYNO31K4xzZUb3wbUPeFbojchaDJagiNo811nwNnXAL6Q0lCAqCmWt0JkGvWvSJ9QIbhnwvuYPCMECn4lKDixxOrVwzuAuMrmRPKIlvYEY+v53u5Q5TBCbjjxRzXqMxjS3VbrtprS4XKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070514; c=relaxed/simple;
	bh=gyTIyYto7tzKXHDd6kMNK0OhSiLeThERn6mhwt9FF3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqaQffn3q/I1rgZ6w5zAB134jlvAewgvq5CJRJbiziCVnB9CVvl6QpHyyu6oG+VS50LTv+SZ7tSlfD/+uf/l8DzHXfz9mv08VPzIL0nK3axEJiw5f1yKRz7p0RQcsDOI1Ik3sVB4MF9iKYs4rq5LTt96E9bmRvgSGV2fiMwXLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oMipbHDu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=01sC0nxb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oMipbHDu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="01sC0nxb"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778070512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81MPp/cPmY31f4oil6TsY2E5xHh8dQK79p3Ch11N/PI=;
	b=oMipbHDuz7jHZ7kQlqsyTvIDCJv8dbs+leMtbnO16IqA16Ws4OQvZsEsAzXeSzxhBlo32G
	CkmHA9WEGvogE3hGl/Hr1nOIV+XX8kZ+bRWIVhYgFlZfjWW70yBZFcRrxEO9ET7FqSo9pr
	lrp4Qxhz/n9AMWdefFUGP6JsP3keuj29u44c/xQZp0cSiTdiz1vq0fpQOY1PPakyArKdYZ
	Y86cL9NE943ciwUhr+fFA0PqunFyaIJH+b2eJExryYqmwGHvNtmf70CLlpj1lNT2sqsO2f
	v1YcyIQbn47ynmog9bp0jL0sonEbEly9VWR/2ngIl/M0LxpWU5Da4Iq4S9+Tlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778070512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81MPp/cPmY31f4oil6TsY2E5xHh8dQK79p3Ch11N/PI=;
	b=01sC0nxbEWUe6WhuAm66nnDKOwfrWP4AHKaMcBhFojTMC5PbWyW3lEv4tH1bwOFI0wwcI8
	6rkau1EvNd9Df+Dw==
Date: Wed, 06 May 2026 14:28:18 +0200
Subject: [PATCH v3 4/4] arm64: dts: broadcom: bcm2712: add
 raspberrypi,bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-rpi-otp-driver-v3-4-294602663695@linutronix.de>
References: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
In-Reply-To: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778070510; l=1152;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=gyTIyYto7tzKXHDd6kMNK0OhSiLeThERn6mhwt9FF3w=;
 b=Gzlfl1GuLTZcLn96DVY3bF9xAHrAq8qFXqN+MIjMGwDgn0+hI2axTKfQnXJVDD8+HVDKR0kkI
 bHiurxQX9sCB/4dQd8B02vaCimYJbr9CrG1yw/dRnDRG73xAfiB0h7y
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The Raspberry Pi 5 (BCM2712) firmware exposes additional features such
as the additional OTP register region called 'private OTP'.

Add the raspberrypi,bcm2712-firmware compatible to allow drivers to
distinguish this hardware variant while keeping
raspberrypi,bcm2835-firmware as a fallback for backward compatibility
with existing drivers.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
index b7a6bc34ae1a..4aa8ec7601b8 100644
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

