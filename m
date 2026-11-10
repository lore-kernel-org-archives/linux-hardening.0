Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327863;
	b=kqf5wz/GAS/ngMelaCIU22gX7Egx/ADZ08Wz+gDY+MzFSiT77bpIP/WgmFBSBmN1s+U6
	 W/vl8LNmsBaBkq5sXWVImMvCRGUZVHcolX4qcsNomFME12Rrj7eyA8jenMYkRFu4X70Aw
	 tnXhkopM3CR0Qc2d7UeFMgnTDkLl9hEJRr/ySg1sQScT55MDR+dXMsGMyXxOU0KmGSmPv
	 Dla5Ju283trZBCjcnrWk1BRWS5yJgedbyT3H6M9IYsp3AEt+w1gA7K+jz6zglhqaaFOka
	 z5VRUdKXhhNGy/pwyDZKKOm+N9JTFNkW6BVq9Ep4h96YOzxVHfb0qBPpEQQLN8aZGhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327863;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=yGqQm+4YGAcL0TN/hqGywRzxg1r01TqvpnoteUEIbjKGQgxgakpRq/IeqsHzWkH/jyt5
	 GfVYtKiAiL/Kfs07k/z/ltvZ2+bwvCRrp30isq8u8s8tabbbglufiCFYl0JJ+kpklN8d/
	 tQy3Vr58IHDrWlMqwfXtxCIWkukwWGSY6zYFDZpFAOrBUHl+zyO4tL3n4Tl3A1JACirgq
	 RjJVrCNAgekSASIt/BMR0s5iocoP7SsCGBM16douMJNQTOlj+E0Llvz1B5RmDLJmSHhZH
	 vZj/jMGulgIZ654w2VdbUD4DIc65sNeWtkFYThX3VC3lzMhp/Sd53Q40uuhSNrXibqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GqM9DJSF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NjyFM1i2;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B360A3809;
	Tue, 10 Nov 2026 16:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926B360A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GqM9DJSF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NjyFM1i2
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=GqM9DJSFVl+ZoZFqnw+dkl0tThH/3AKJYMv4RQ4O8tZglMGEi3aYowkJhejVRH8qyYVJBc
	rJrzP28t79/8pxA1lwxIDibiIP6nIUBexOcm6T/Ls96s4CM/hG3vtneND7aZVoo/Zu1/9t
	RTlxjQ2q9jMDoNE6LSX903nFuhFYjFN1KIrha3QPGeNrP3Fx+xLuzgj1sAVKp/6it8Uut5
	0Zjyq9XOvSoHvF4jFfIQLqUF7T7iBG1atgO7VoJqX4LoD8kvEoKaQ0bP17UuibVKqL37DT
	HTtBvJ4Bce2cqMrPejljx1jsr8ZVI7TC2HL1xzAIDiv9hHpttgn5ynZSQnBDiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=NjyFM1i2tJS6CsEWtKuvl7/86vdQGqhGnMQ8Ox5Vv4jCLINtkX9ixDrNh0hG5NK6w+Qess
	jmT2YDPaWdVP9oDg==
Date: Tue, 10 Nov 2026 17:24:08 +0100
Subject: [PATCH v7 07/11] dt-bindings: raspberrypi,bcm2835-firmware: Drop
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
Message-Id: <20261110-rpi-otp-driver-v7-7-2345d0ee65f0@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=1090;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=Racxfoc4BFZdJxwpm7i43GQXuCiRduffKpGtvxfjlFg=;
 b=ijU/2P97KgBOLA9w+pE5519vPJbJzb8Qn1TKF+/9dTTmYNCBFRRHfsOxn1ASykZtKQP8EFXa3
 qkvC2PbgXMHA/3yJ2Sz3i0t/MYB5yyyX3DtEiwyqk6IxnR6SLqCQ80m
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

