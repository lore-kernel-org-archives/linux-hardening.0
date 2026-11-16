Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823854;
	b=038KHp859iMa6YYan7nSm3FGfKbtpHVOyFevuTi6ZaOjrGJB4DT0J28o+I5r3NpIcl6t
	 Pdrnu5KdJcjjC2rgsBn/WXiZ1O5GjfmFuirORystQvOBFYRwc2pLK7dBtxtoeefdj4+Kw
	 hi3kCQo5r9eT4cubl9z1eYyh3SNBm8PVP/TQDLfTeQd0j7IVRyCREsuGYs3vyyWawdlMu
	 UbfW9MOOkXP69yBUuw5gipFssknyHxTjFkIRt90Olq2yDNmi6Z9587B3STV26lALNnVKS
	 uynKwitWnRLO/qjlziOn6yhchsrSMhxt9RhKpciGt2zL/dyjrm7QOS2wOAjpHltzM3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823854;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=4B1FNOBV1mRJUlsu7Ta4bpAa3QHx3T5BkkNcqzuzVBFgd+7SbBFjt2+d/iMmOdcrCx2d
	 7IHRMA9QZgD1VM5hQOsjZ3/1xV1KrG/acaO7DLirbBMOTVsYNoFVfKMjUXZZ3M79aK9oD
	 hJs5Nvl8upJ3LeLxgijgxqYR05qE3tWQ+OhSPWpRjHV0UkCFxUlZjLlz76vDX/ENJDw2M
	 HSSgZBM8dgoHjfPxsd/HTFnjdr3e9sb3KHxKaEgRc3GadM8IVdmdHoTyUVG+Oy6nhvDcb
	 fnEnEBMkjQIC2//+sRKrdUCy+AARqdHmuCZ/7Sq+4SoqmfZaBQR6b/6e6Z+IO0erYHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TXC0Nlf3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EvrAMvIF;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65045606A890;
	Mon, 16 Nov 2026 10:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65045606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TXC0Nlf3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EvrAMvIF
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=TXC0Nlf3FQDVhx8kmSIKzX9dE+arQExtQ/feFyzjB4N+w2+t8E4sYtUPH2M5P31uaUzHEv
	UjjSZYNqJtwTVYqUw66Sgws5xNW+xrKWeZGFt51MnBiLMlvEt9gIzHZnFDtZrP2uPf6W4Q
	6MlHmx5DCLIGSJ417FXzONPpt4PAfMBJAg149Gjwm21aeqZ092lWVkV6rol6zZm3cAVy4w
	yp9EP1XOgjQoRYWsuEcZByb1WlYOfMbLZyiu38VLDToxGGsr4JeIbsPqttAMhQj8YAkGNE
	OqjwKZHFXdE/R2B3iZGR7xj+N9qrDRQJr6UU9nrekG+l1G+znbij/2f4tt32KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=EvrAMvIFa7KXGV4KslJW42MSd5zDU9/Kncjln/Jh8XewKC+PWD0VSMMolWquw1ruYtpr7n
	5YLRMLMjajhXrgCA==
Date: Mon, 16 Nov 2026 11:10:28 +0100
Subject: [PATCH v10 04/12] dt-bindings: raspberrypi,bcm2835-firmware: Add
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
Message-Id: <20261116-rpi-otp-driver-v10-4-15302dcfd5e1@linutronix.de>
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
 linux-hardening@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=1250;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=EPoKq3QiduWfDNRfSZpcKzyFT7JcryXbpPaWX1U5Tl4=;
 b=ew2RHUIlW5Iwk3AQgNkw3Iq7JO27ykTVuvkVVQYUB8f+CrgXKK1fDxGdmDY6Q8wGahcEYucJw
 lMqH6F1Qa9BAs0oNGr7+CR0TJjwL2oId/8yAnr2NikOVWpO/VQkM3+t
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

