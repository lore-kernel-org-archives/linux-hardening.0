Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CE3DD505;
	Tue,  5 May 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965918; cv=none; b=LwqkgON+rhNPrf7WprmyO4yWSqd4vx9+AQzbk5XXhw4C7YOg7VGgVcGps/9Y0f+rViKdGSotgcIymp+3Gf1bCDRHU+lEB7ldau1kdiXaUgAXXvlAfdNWrAioHOTRwekeJThIo8jPpBud1wr6FOaF7xpDi6jbTKj+4gB8B9dt2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965918; c=relaxed/simple;
	bh=J8uzf0UxBnakhr29755Qqmk8YumZt3G68S6svRZD3q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBk03onMFspocs/hLJbAiAMxG6wEtpTzHJiC37AbZA2/4Dgd3dClPM81Tm9PoYh5/fi1AzqhyhfgGxi+Fu0H3Se7hyZdive5+ePXeo0rpifMj4VRB4CQAt4DfSHMffBw5mj+nMvV1LugpMBVS0xd1L7quy4WNDbd3Xq1g0orYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSDE4QF7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SykxpLQ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSDE4QF7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SykxpLQ7"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777965916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6AcipymrztotqziX7C3pSX0j0j5jMczP0kYAPjLO05o=;
	b=zSDE4QF7sfIkPaBRDfkGp8V87GlkHgZCZEZpncKPWiXlyVJPc5iklFJxyoC16BgEbt/kkX
	2/S43Lno3CWobTMm3YJwKXW0do/UTnI4sI+dRCvaDRe3K82RF7EIjMQmhrdPOUaDXbOedG
	UFB50O+qx+OL83+cJI2dUvkRo/LuXY5cEN8I0MhiGKbZVaWiOwsgeU9RdmbzPuTzpYnSbO
	PC55BDqgVFBuKki8owbX/M7adA7mAyj7BJq5hwOTp09mwT2/Jg4S8CGQ9CCOyL2XLGL4e1
	7ZyaoJsVxcEzikkoeiq9Iiqa36tFqLiWvkVz8pK5J4vRJaNwFN2sI0CP26B6Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777965916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6AcipymrztotqziX7C3pSX0j0j5jMczP0kYAPjLO05o=;
	b=SykxpLQ7b67XIrm/zjHnicmSoWLEZpc+pH2lErTk3DlUN8HiW2GK2rFgka4rlSv8UFle6m
	mxef/cehlM3+caAA==
Date: Tue, 05 May 2026 09:25:12 +0200
Subject: [PATCH v2 4/4] arm64: dts: broadcom: bcm2712: add bcm2712-firmware
 compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rpi-otp-driver-v2-4-e9176ec72837@linutronix.de>
References: <20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de>
In-Reply-To: <20260505-rpi-otp-driver-v2-0-e9176ec72837@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777965913; l=858;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=J8uzf0UxBnakhr29755Qqmk8YumZt3G68S6svRZD3q0=;
 b=OaBrTyYswxhcwx6rx7uAFSQ3p80HfRcgtEUXXpD9an/IpdfKr+T5LotzbdIHIz2qHTmbVAFjY
 5qGpMDkMCn0Bh0Q0lFezPrJ+ubSvh+FiQ+sKayJpFI87xPSOh5d4kZ7
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The Raspberry Pi 5 firmware exposes additional features. Update the
compatible to reflect these differences.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
index b7a6bc34ae1a..7283078fd441 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
@@ -46,7 +46,7 @@ power_button: power-button {
 
 	firmware {
 		firmware: rpi-firmware {
-			compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
+			compatible = "raspberrypi,bcm2712-firmware", "simple-mfd";
 
 			mboxes = <&mailbox>;
 

-- 
2.47.3

