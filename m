Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327860;
	b=Kqdd1Pdok/385EMMuUCkRLw7PxqV28HdnVeLglUNALK9RtoZBEGlKzb4nhEiWwuYLy8S
	 u9m15ox9fy7Y4bdKiSVjpVzCjfDgZp4IFowArGyRRkHEKwhpsTQ/pXx4m05FCFOGyXtNg
	 fs+NbnAf3MAg5qfkJFUAJPkUzQnEITrzg4jLG35Ka5ZlEblChxxbLSXdgTNrUb3gbMr6g
	 pP9BGrcM+3xQQCulBqiUT1wDTIlP4ctOox6BfZieWbGiksTLzGFzM4oCAhnOpISmxGE27
	 j7oDCvjZbDabiYyDm+xeypNU7COJi/cJIaF4RKDssIh57bbaHVtAgk0xNLOuKTntxLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327860;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=l+OOB0YTABXrfg9c8twubWC8drlAKGvz50bQ6k/uJe2dhi89UBjepI7jl4VfB8E0IHaM
	 SSne/+okrDaYQcpgqttrhasjk6IJrclj9fv7iiACP1SLEjoW6Z1t/4VBzh309qCEthRoz
	 hQZ+4IH4FMGCLuGfUWDdRiDya94+isMfqdZU3+54G9KZg2cXCavz52SAyq+5c0gVBofuK
	 6GGWTe7yqoJTJHm/FNwzLBZ9hWRlgPJyomW9Ka28ngNz70Edp2CEVx103yHnWRAykQZJy
	 8Pj1PhIHUFRj4TudUNBsgfvw3hADaZhiwAVAByK3O2kZ+2GYjwmYmKP4g0hY1aSQCgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PdRAJZ1h;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/kqvzNSE";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C660A2602;
	Tue, 10 Nov 2026 16:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 328C660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PdRAJZ1h;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/kqvzNSE
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=PdRAJZ1hBixN8269gEcO4EKKwyWVwTuJ87Y9Gff0e0/6Ij6fwuuGviaxyURp6dRap08IDI
	QuGmZwW83gwrputS3cKA0hAyHOTEx/+gfPUQpLGCvs4Ew0uszWcb1qc9ajRfzmgBSDJoON
	t97e8m3Qf6hp9tgB4JRq/u40y56/QgcS80YYHj5vWruTFSACQaVsRAX9lK0/6thgep10Fx
	6oVtQx7yvhM3rnETWh70OdP0FZUF9oqP2LeZFPZzaNuti1F+bTvGvASmUmXWuXijDqTSpA
	jIxYYGWks7DltE7laKZdpmQDMm9vjshTa1OEQdkg3bKY8T56QqExRMceAxJXLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnaiI9Makeyhmcykg0ul9RCJzRdbJabnK5sU0v9rIkw=;
	b=/kqvzNSE8J6+YVKxd3JiJrD0qjmhX2g5JXzHu5jHjntXghmEEL5O73xO4VDw0fHNJbxqOT
	QpRjjt4RetzGUeCA==
Date: Tue, 10 Nov 2026 17:24:04 +0100
Subject: [PATCH v7 03/11] dt-bindings: raspberrypi,bcm2835-firmware: Add
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
Message-Id: <20261110-rpi-otp-driver-v7-3-2345d0ee65f0@linutronix.de>
References: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=1250;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=EPoKq3QiduWfDNRfSZpcKzyFT7JcryXbpPaWX1U5Tl4=;
 b=B2znX0uD/N+QMqdciiEsg8lpVjvRkuzuliw28OzhJ1CaoW9CUJLWtFt3swLR+XzCXCxrISG/p
 3G0y6f20Z9aAWZL8A4DfumA1M3PHUTS7+CfbWz6FuBwoUR1jrDwDS9A
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

