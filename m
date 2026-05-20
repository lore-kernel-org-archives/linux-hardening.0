Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD453EAC65;
	Wed, 20 May 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287285; cv=none; b=qevqd1cBqjPL4O8zW1WUeWOkQ9EtYbCX+K4kB4rPpY4hw1YcpVeKhOfCWYkhU9UAib+waHJyQKVPnu3OCuRg9rO+qHaOdKlM3fWS+zjO0XGV0Cs/gcz/iwv9leM+I2QNUIb6BVRp/lzhmK0eKadmy60P5kBVOUOUkEIRdJQiDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287285; c=relaxed/simple;
	bh=qD30315sFDKvQ1zxeTxTP4/+d92pYx/4B3/nMfkSHxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoFCsRn3e9h0HAa9Feciz5qRBLLmJsR36vCqrZoQ35xghgZbA06t4q9WQ5vWvGk3/7uQxiJonff0up9LNYLDoQ4OP1dEIHzLnViArCpCjDxDouASxf2bnO/88Wfy8pJLxapmEE6RU4o5S5vcpleOT3ct/gfWz7sQ/KSOXw7rWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNTElRVC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Acyq32Sx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNTElRVC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Acyq32Sx"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e571YxZZj8gyO1yRbMno9e5ALDgboYntuW/WsLJaO3E=;
	b=oNTElRVCn3Zo5y9+5yf4vVdXM7p28ceyqblaAkoqqRKRWeifhf0OOI8fcUug2OIi4Sx9HO
	UeT6L45PEwkisezXk5zIvC2mfOu35S6qPc0ZPfN44TI5US6enPFOwlQSQYDK8y9qrWxp91
	f9zq3T9me1/tgXEPktZFXONFZ04Y3uRVfHwyK0wzeB5QOmLe7INbukE8WKqRDH5FXY/5vF
	oaVsw9cu8puhqZ00PVmdWZBPadAUdllZN/AOJjDbKDsG2PWrbsCvxIO1k9pbn/WMnK5Avc
	T00Pa/f7g91VNwnWc7Nyln35U4hqFUwWVurAuyYZhGONH/9Duxwf9H+3b3JMpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e571YxZZj8gyO1yRbMno9e5ALDgboYntuW/WsLJaO3E=;
	b=Acyq32SxloBcxK4bsKM+fb4Ko1aUu3gA2mDrufqE2XQ5/e6941jIafOWJDaMXbkf27zdkz
	Sn/XIttrLCIVdJDA==
Date: Wed, 20 May 2026 16:27:55 +0200
Subject: [PATCH v5 3/8] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-3-b26e5908eeac@linutronix.de>
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
 linux-hardening@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=1250;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=qD30315sFDKvQ1zxeTxTP4/+d92pYx/4B3/nMfkSHxk=;
 b=pP3sMH+GfIvQZo2Z/qoVDeXOtg9aLy3uuiGqYKTpnSEZoapRWg2ersIzCur+Aiiw2MzW0iqYj
 Pj/G4Vir2NeCCDbFP25O4ry8cPggf3pk07gQXf32gLyOj3oqcEfEhEL
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Add a compatible string for the bcm2712 firmware. The bcm2712-firmware
is compatible with the bcm2835-firmware so allow the bcm2835-firmware as
fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 983ea80eaec97..a3a5243b91706 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -21,9 +21,14 @@ select:
 
 properties:
   compatible:
-    items:
-      - const: raspberrypi,bcm2835-firmware
-      - const: simple-mfd
+    oneOf:
+      - items:
+          - const: raspberrypi,bcm2835-firmware
+          - const: simple-mfd
+      - items:
+          - const: raspberrypi,bcm2712-firmware
+          - const: raspberrypi,bcm2835-firmware
+          - const: simple-mfd
 
   mboxes:
     maxItems: 1

-- 
2.47.3

