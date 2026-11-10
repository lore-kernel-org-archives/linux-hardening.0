Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328453;
	b=3+i6gU0qnCkLmd3/bcUMZm6tZTDrO5NkW3JRucItpwrfDDwYnoHc7oM3Ur2/GcSwfZeE
	 wYKGQrlnzBeDsp+Z0cnIOk0zmp2UmcDQOJTrYBfu1l6orMyoGsrTr8wJk6aNcUQPMDPo4
	 0UxpWvNYZh/nuoCHSsTluj5p5c4kv5syL9CCn78Ei4m5GAj0nA8GMBAhB/CsdCxwLH+Xf
	 GcvQBlmWgf8V6gYHJFVb29Qx1QD1IljComXrld8J6XxygAkHtWi3Kfq2AeDx251kW5Tkj
	 be+oRXSi3ij4iELAFzREAzzbyXQXSASqh9FO11LP4fqxxIpFqZtTqdttG6yqy5QUd0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328453;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=igzDPplnMC7KV9RCd93dUzFhN2FRqjkZn027ETMH9zUJut9dApYwdxbN/9LQKnnJDyVC
	 KgKGZ/c/aNlhN6T+gEdMSwMXav98mzsej9xdxtzn/lAZi3p/mA2jbxfGB25QJ8tat1Jpb
	 cuIaGiVuTV6UekJFQow8eXFwjflHoZQutfrgIVSD3ctfojft1m3JGcBavozAJxsxVN4Ix
	 MUMI+sG71jEAnNE2r0IvwOwYSeO9AUJBdf+CtU2ou44knjhNhMZIQFYa/N2ZjBunuzMbb
	 eFcL6EM6adrAbfm0JYERm7n4+pF/IKygVDVOcXE6HO6cXQDOzkdM4SoUsqENJa4SCWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=m0nY++XB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=B1oFZRRC;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1B60A2627;
	Tue, 10 Nov 2026 16:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D1B60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=m0nY++XB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=B1oFZRRC
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=m0nY++XB4AtNDkWqn9DffXfz+DRI0rg25Ntuhmn9MDp5jWB20Hg5EZINoOKDg0o1/RYW3/
	lIdeW08ZjGT16ZJH0C+ugqGFEGaOnZJsUkVLqbNPM1XiSSQcYgjkmyIFBj0HFxfT34ZzJq
	kOSUnU6o4R+Uc1PX4FFdKNsBQsytlShKXgO73Ze24Fo0mEuTMGQNCnZGVKRrL6f70yrBA1
	7m1df5l19AXam6WCQuyq9/QhsluIX3SO7vO9xVua9Gq8d+ySmzdicSt/SpmG3q7mowQUDY
	UY4vISZj2QRtuIehCaerBdxqo5kTsYDgvm80IX9ONnndq9B5wKk/AsnO3xgQww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=B1oFZRRCQe9h4DI6kt4seuMX/v1lCleu7CjhcJ6DNXI0c5NpUYBZNAA+Bn+F+9J1k9aKQQ
	k8R6cZ+ySxKZ8bBQ==
Date: Tue, 10 Nov 2026 17:34:03 +0100
Subject: [PATCH v8 04/12] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
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
Message-Id: <20261110-rpi-otp-driver-v8-4-797e0577d414@linutronix.de>
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
 linux-hardening@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=1250;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=EPoKq3QiduWfDNRfSZpcKzyFT7JcryXbpPaWX1U5Tl4=;
 b=70PdLuVNZYk88B+PbUNH2DVqyvxZW7RSg7x48DxD/tcZthuPRK8sW6MPIKFZqfoLKrLcmS0eB
 QgjxrFrUwAKC8o1d0qwLiwHymN7UnvEs6P6+t8hNCYsQJ8w9Vdqkptg
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
index dc71fd57834e8..9519157006b65 100644
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

