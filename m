Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328456;
	b=uxoME7dq3T/1FI8mSQHzljsF6YyTElHwPqwLOXk8Bkn99KFlAxIVyU01KHn4LEdbpDWx
	 Wa0jyJ2tA7AWlCUe3/4qKwzH/Yzx7mvrxfRjvv6SLoeZMgG+2UzvWgpqM6OUt3bYd5S6J
	 gL+686z/IktvhJ9SBK1eRDlXDV4rHmNIE04v6YGlmSOVdgE+oO+cwG20XvwFAeKD/DWoL
	 9NtQjHVew2pb8MTy3y1AkoXpShl8/NDpV1bv7tOoBSUJiBuq66CzEzi0u6w8M4qgvMSNY
	 jmf0yA+0FywV6JSL78bc7RdRFAxmaDGBQdC0fYnWCmMUe3/ymlk2Q0b/LaC8B1XXCvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328456;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=cTy3pBQOpLgQiSQ6jKfV+H36EPrTS/5K6lNFRRiAdJqG2Kaqt6OabE5IChO09r/Ow5Fa
	 vyPg0yrPJcWFsfHt68mm2MFKwHAuCIvM+Ct+K+3poc7B+6UmYLR7mpuEyE5MzM3r4rl2D
	 HyRSuhjswnhJfMZ6tBJblzUpQy9mJAuzSM5bZHZ77NDoNTdUOCyIJ6GFyPRBNi2XNUfIR
	 Q1AefD8WCq0Kv7TIzxuVQnPeEfRFaeBorbZdHTz6+Hcc3eQS56nbfYNlJnhlpLAc9NwxJ
	 eIjBdSRBF1Q1Gfkz0RMGqYOX07SCXuuXuZaZ4kBKCRxuPvCzy7vD/7wjynfB6U+2Hgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RAx11iiA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gv1CWJcZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322360A381E;
	Tue, 10 Nov 2026 16:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7322360A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RAx11iiA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gv1CWJcZ
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=RAx11iiA0+a1P9MyqwPNV880oiFV2a1Pe2nhBQW5XGea12Xk333g7M7016O9S6bd9V3vzj
	jnwFQ4eiFyVxONUNWv++T8jgbQSPaTPAwm4STIDXco7Lc5vwXF3kMRRoZwi1sBACYXQK7M
	z6wMQQXXjmJkLBX7+znjsMarJrOjH6vFGTpGK1uVPMRnfeC83MDpHMKUe/+zfrMZZ4fIxC
	vzhmhEN8DflUvkYj3LWpj/YLhlBgfwFs7UfE9fBICUfpc7GKkrUC0l51iGMLOb2tCaFHfe
	Vv1kwOuFMr7O9ZvwfJrQJgssHDy/v7qp9DSW4ePbCNFZ4CKvSpRPlm6v7S8LJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=gv1CWJcZpZOjx9oaQprwy+njIJkY+o022q9UUAI3qvdBo+VqBPgErNb6Fqo2HNNCvALSFP
	1qmCZqY79YWiqMDw==
Date: Tue, 10 Nov 2026 17:34:07 +0100
Subject: [PATCH v8 08/12] dt-bindings: raspberrypi,bcm2835-firmware: Drop
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
Message-Id: <20261110-rpi-otp-driver-v8-8-797e0577d414@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=1090;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=Racxfoc4BFZdJxwpm7i43GQXuCiRduffKpGtvxfjlFg=;
 b=EEA6kwLzqz3fYYTX5GQKrI/5c0oYBdGPb5utiwxI0JIIa7fI41mXrCz6lgVdouFyYPT51SHQK
 O9ujhrFlZTKAMUPt+cpzA69pAFOGZj7A838EuQBuHl04E1x/37DtLbX
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

