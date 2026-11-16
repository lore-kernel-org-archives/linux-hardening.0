Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823856;
	b=h5L7scvr8T7dSbwM2vSp2EhNhstFrP6yJ1Q1BMJsRdr6/4HLGTexSOp74ebJiDVXXc85
	 hFn0nnR2wunqIx3epkKCtqPNFwphdRuye3dFm32X2+WlmLYb/KW0aZpgrsNS91r1Pf25D
	 1zeYIy6WFNYCZyBYrQyHWKv505TUMTR1QdYsWMis0lG7p3sN+/wLaB3dcJ+uA72Sjv3DC
	 Afk7dd85lCbAhr4fTSX060Cy2pg880CENk8aR2+JJ0OzI0OHvSwuXrEsOE4qpHBhU7Dn5
	 5kGegz2OSHlhKPnjT3UqaXG0C44aTv053fXj0s9XBDlHTQIpMIRCBpH48PvrPR9Lyyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823856;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=YNJ/qgBVIkUyN8DA/NuHGF6dNpBSn/EpLfq94kSm4DD10PNrpm3FJvvJGbHIRi5jmG1K
	 TMkM15Ijl9iuDX04/NRcqQRVuEGWt2ynwSjiHabJLnTbkCtTB8yG7RXLTMSXi28GGzDFv
	 NTEC2mRirkJfdW9zOeHWLUYA34+oU2PFJui0tQsl9qMG9xA4Fg8n/zN7pLsGMjGdgudWC
	 o+qO/YTRlgicvVRGcKs3kLrYXGkfNAOnrQEqqHNMAMEdaPPeUtQfAuyRhaiKW2z5pvlCG
	 fYA6fANAQmpaYCTtezcBWQCeOxK6RMIwsfal+63wpCUjr8EPL0u9p/4lqCx6mM0EOGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KcGX3Ttq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/QfehBZi";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4A60A260B;
	Mon, 16 Nov 2026 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16D4A60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KcGX3Ttq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/QfehBZi
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=KcGX3Ttqn1PMGmHomyrYOW6xyw3emu6eH0PHHHvWZy6xg4obmfFVdABXpvtoaH+SDs1Wvq
	dQSkkvW9f8mPdazCaeR6z2Qcii/w1PSmKFPTwq7HL70XwXUkA8KiI6MEa1ExWC9tDB3PO/
	hYPnHcgLSqQvQJ3yyVLcrY1B3COhxpgiY08ly5+lz7IZJCsrSmXd4GDTncsssr570oRKTW
	WHGjEnFxGYz+P5xqAbje5mrG42D45czCnIf+AZjIpWmmpCzdthAhiCj5cR4XVVSGujEe4+
	Rw8+BfA9d/ejatQMqh54OSY5Y8ZZTBGhIh777TCTE3DKvcR9TnlYfhlJ5JZLCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJKemrzXK1q+mQp0AASaxKgzFL0wc+OvZ98MS05tDK0=;
	b=/QfehBZiAMoGw1CaPyBi60J2s4mStGkt8oz86udjdfLsDn85RJWuUL4mlXF8TMxOoI6r/y
	1WaDMmRsOopxfEBQ==
Date: Mon, 16 Nov 2026 11:10:32 +0100
Subject: [PATCH v10 08/12] dt-bindings: raspberrypi,bcm2835-firmware: Drop
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
Message-Id: <20261116-rpi-otp-driver-v10-8-15302dcfd5e1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=1090;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=Racxfoc4BFZdJxwpm7i43GQXuCiRduffKpGtvxfjlFg=;
 b=eMteXzJSznnxFMiPWPfsnCdRtdquUoP1THvPGzCtSclwXOVrPfv/NN5yDY6hkzgZgK6NcDnXi
 Q9JnwQs0GH6Bdp0ZbINZfaYlF/4AKVMM21femY3/9ZDK9r9awpo35le
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

