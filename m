Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78893ECBF3;
	Wed, 20 May 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287289; cv=none; b=b+exxzkMHy9pTzl8p78ehGs1ciclmNMDvqiz7n1Y4sIzUgJGw2rrmNIwKUBlRYqZY1xpLTWk3SCcPnZCO/ZIUYesbhZocRsQvxAJRSAXizzLiIhG2Gx+oO2T4J1e8nITm6QI4/N5FwfnNaf2FutT88ynEkkkTjUm05NXrUDRoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287289; c=relaxed/simple;
	bh=EBbnYhbRo0d+VU8z2ObRFO0eA0vleo9MiChog9LUENM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbnRYKflHJXxBXaAc7e/hVqunGPJ1D+d1DA+Trb4f4qrI2x3ZM+cwgkOaHOHN1I9/VtPEPola3h6+QnIOfeBlh5mB68kV3yBXlqeKIIIISF6/stRAGVAOvB5N8fTVZJvoNgoAOncFvYHMmgk1V0ueg8ymfgxHdPfkuZn6mxHVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VB5SP8HA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=93aGGazX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VB5SP8HA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="93aGGazX"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFalp3WAgAi9MOnT6TY3HIU2AWIehrVMXUG7sEmV9as=;
	b=VB5SP8HAKxJ/evHYz2oBI67bD4Q4B/8/aDknPDh+49ym5xX7SNNHixvJe7ajAITDtmfETf
	4bHKhXZshsTgz9Ns6IJ1981+EsBMZkfLjU+QYQghpx4/t1lUYgI9gS3oGTxbl1u2fWNgOZ
	5JdujQ+ACan9yrn4HJmmZ3315V0kmkD2LLHwTJWB5L8hU37iIIa1diKJla48vU+YPoc6ip
	TwwX9dbXbYd34n+VPOwkeaQSaJNBGYHR1l8WRcLoueXErJfiPoLCZSkUpBUPl4a7p4R/O6
	g1cni8GYE7/Mz/JR/GrqG0ejWb8G0kPZwjc5LcTagHVu7d13XqMpKve4gcL/gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFalp3WAgAi9MOnT6TY3HIU2AWIehrVMXUG7sEmV9as=;
	b=93aGGazXPspBydCnunlRZnMXyodGbB+A0V7J/LIqRoA9uDbf97loaRRX9gnizP6M5ZQf6R
	Eq7EIdK9eLlqx2BQ==
Date: Wed, 20 May 2026 16:27:59 +0200
Subject: [PATCH v5 7/8] dt-bindings: raspberrypi,bcm2835-firmware: Drop
 unnecessary select
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-7-b26e5908eeac@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=1155;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=EBbnYhbRo0d+VU8z2ObRFO0eA0vleo9MiChog9LUENM=;
 b=WAZcB6652Pc0oNVqoPMUj/u63sly+g4T3QqAjDQ7gY96y3i2SFqOAkUh8POAmm6VgLYtcP4uh
 OlOxSnxvXl5CEgPETwSxHnx69opdnkzn3IQ67hNX5Dy9NfMVhKaQJA0
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The select schema is not necessary because the
raspberrypi,bcm2835-firmware compatible is already matched by the
compatible string values. The documentation says "Most bindings should
not need select", so remove it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml           | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index a3a5243b91706..7cf9a6fa1e5be 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -10,15 +10,6 @@ maintainers:
   - Eric Anholt <eric@anholt.net>
   - Stefan Wahren <wahrenst@gmx.net>
 
-select:
-  properties:
-    compatible:
-      contains:
-        const: raspberrypi,bcm2835-firmware
-
-  required:
-    - compatible
-
 properties:
   compatible:
     oneOf:

-- 
2.47.3

