Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381823;
	b=YYGDl0b55wTkY46TKYZbMNeVcv1HSuWgrcobwjUXhTI7RlRjiC1qUb+ykXGQnPxc9z0M
	 V8MrJbJhcK4XQh16l9QZAQ1LYlnprcVNyfCKXKGQzcPYQ4AwQmCBXHqVpy79ZzXX7uK1C
	 zuFJcs04RtnMeDe1HFc50qzGtpur5O7jKG2xsAE7qQtnOuOkJemyqu4lMplh7hWpDABrQ
	 Q4acP+AjNbsGeVk+R0bMN7/eBstjnb3AcDbKcyYHxYbXP6Z7KHcFwk+4AlvsQcpLszJlO
	 +cxd3/uBIy3OvcS8r9+5hY9MNbi5ZGd0+H42h83F0M7dIF8uIqyD2D0Z4GKqEJWDZFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381823;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=NFxyUcdgLPS5SxinzGuU1/gOUtY02ilbwMFqb1fZ79YBHWN5PK9qrbrSmD5ZRV3wp+PY
	 BSBpmtLInzg3HsVL3vlboe3aYHVfpaHLW6A9xP2iJlNZnhgNFAPP/ibVIBjscqga9z5/w
	 lsdPJEhrOC0YlTj97N4R5kzyptL3/6QhCU6bFlF2PDU15hW2RXh2/rSNkeH633gUGG4rV
	 Lwin2C9IMmihmnDiPyj1ASiB97HXV1SU70K2f826lOla8re33sO4awVUohWVmQASSLmhX
	 120HYr2xcjth+MnW/o3/g1ImQC0eY2Po/QzPwiWlzSuYHmfx5XeDhs6JOqOc34UHafw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ACoTvRkP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gVF9Q0bq;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612F60A2626;
	Wed, 11 Nov 2026 07:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E612F60A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ACoTvRkP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gVF9Q0bq
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=ACoTvRkPpfs7xIrP+D4ZLkQrLsfjldsKelN0diMl8+BrrwbTRYOaJJARb4oRQMOVZ6YBRB
	ZkqU+dvJ+787N9NFgaEOjuYcDHZoqGFzjSsz1j2ITrmBpOKJtkEL37p0XaBBURMXOdezVS
	2Uz7O2VFrAMKjm8uIOwYS1DznQhPPXrguK5ZcVFW29EIJReniXn0lABWowbqDiJmwkBTxW
	CoJlSJJKfcpz+vsHqdk73FWw4T8EFwq8bkP6iG+SLsSe3OpBKomt7EolDHms8Sz4IL9YiF
	mXEUMrGfgV9oEnxrIoSZYz1O7h7CpdVSyi6g5n4rsyDADFLNTWvJEeD2MJNxEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=gVF9Q0bqMAHtZCL5dRFb7SzgVPtqnSKmPn2L+jqdjR89verNORnANQyh1PXTCJKQbS5DBu
	5N9mLwuQFPmuYTCQ==
Date: Wed, 11 Nov 2026 08:23:30 +0100
Subject: [PATCH v9 08/12] dt-bindings: raspberrypi,bcm2835-firmware: Drop
 unnecessary select
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
Message-Id: <20261111-rpi-otp-driver-v9-8-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=1090;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=Racxfoc4BFZdJxwpm7i43GQXuCiRduffKpGtvxfjlFg=;
 b=MnSwqvJMraMg7g81/Y5EW5f8I+lpXaxjypKjVPzqx1wyWRylzGKT+gH+XCv/ip7p4csEuBFMR
 Wt/XN83z1KzDObI50PELd5KbZfH9lwhnKPYKXZkJ7XRkgPnOK4YPd4s
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The "select" in schema is not necessary anymore since dtschema drops
simple-mfd when constructing the select/filter query for schemas with
compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml           | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 9519157006b65..02b5b9b480756 100644
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

