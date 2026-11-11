Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381822;
	b=SA7FwC+GGMnqCr54WfkClDZg312XHkdG4zGc/NjFm9xWFOLK5vksCpbTV0PtJknKp9P9
	 nLwnZwFI01WDVRGrEJFYLTrhqTrZD7toDvvwnEXSvlqvnE5U1uf08iHr8JuSMsziGFrvQ
	 qbvGElozMbUqj+aS8YoSTpAxttqOW/bmnoPiKzkXRmXYJGqzkmWfOM5ysQcJ4bV+wfikn
	 dXYpysEA+QQUyk1JGiXv4G3K6HEQxcP8bUvJZGSnQ614759ViNl73GKzQ7TEJAKNwq2Iy
	 x7Q2yWC42Yif1wfUSowl4PSulDgFe6UT4fdt4A41TUiXa90ClRha28txAXjOljNZLCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381822;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=iEpP3CognlI+wajhdY+ZVk4us5V7g05bmY5GziTKEtxXq4tzhGncbu+dRlkTK73BSj5N
	 1R7AXjL4PA0SIIaIE9MlUGE/DNRfwh+d2E754YF0jW8N5moPT8yvQvNIHX6PSJW2J+uEf
	 jbHQKQAGS+vzaX837j2AXg6EmBXwnV43oLp5g+mXKBFED9m3kHAcSG65PfSKc+vwhbsuZ
	 MDKzM1SMmWffCajtD4Fff4njmPsDGLe8yBBhXpTA6jM+4vTVPHj70XvKh7ZGHJ8jpYnyP
	 4Ay3WCA5TL+TXvm2uZlgmIB7iAGK1PxjwkM/+WaulwsYfwGEPa7Mpr563xNmjt6RJnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kuLfAJkP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ePjsRSkF;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23479606A332;
	Wed, 11 Nov 2026 07:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23479606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kuLfAJkP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ePjsRSkF
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=kuLfAJkP0gsNtn3Z6A988FxHafmPB+TViVsGbc3lr5avA5bUreW+SahBqiUKrxtx/VNJxv
	GbiQwvg36B9KFyWhc9FWgNUMJjcWe+tdXdqZtvE9Jscfl8pPhQrrr2hTMEcTdOO+2xdBa3
	lsz7jy3STxgdKBnUjqZOkHKmYGkyw6Pd092OWBFGp0IOHsulff+E/fo0cSTvQbGyzxrYC2
	m/h9sQkEyTSgt6lYP/NdZ+eer+G3wQeZvru2rZYsq5HbcUvfqdFOM+V+xyVaqcgbAhlVIj
	sWIWuBYSU+SCtIrzcKVXQjPoBFoy5l0/zRG4reiA5h+td42H1dW2Bw1BPLOBjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=ePjsRSkF/LE+MhBArVJMoEdOoZhQXlvfnHFREo0Zx+RXxdPnGtsdcuNQP5LJ8baZzu30Ep
	1ZFUKcQZ0Lryn3BA==
Date: Wed, 11 Nov 2026 08:23:26 +0100
Subject: [PATCH v9 04/12] dt-bindings: raspberrypi,bcm2835-firmware: Add
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
Message-Id: <20261111-rpi-otp-driver-v9-4-0a7292a7a5b4@linutronix.de>
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
 linux-hardening@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=1250;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=EPoKq3QiduWfDNRfSZpcKzyFT7JcryXbpPaWX1U5Tl4=;
 b=DrByEdhV8zbr0hsjGh1FHda8VbLUW2g8up/IDit7EAzND9CFTGNiQrC0HUlqf0wm7ibhS6yCt
 1bASqxihnqRBlLZynEnIbDIOWoZHFAwpzwVYlAPWANDBf45oO/j5c1n
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

