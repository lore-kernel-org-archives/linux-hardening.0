Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430B358381;
	Fri,  8 May 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251373; cv=none; b=BCcJYI+XLAJN2yOh69AARw0VehWrzZjPz4A8Ro5ttfgCmzZQuJgvw23Ad8K6E1sO9dQvzNLZ3GQhkyYX3z22Tf+xkkOb/9UfcDgiLskxODl5I4y0RKwZUn7TxO1xvEVeIfpqLOLVcY6wywNqIlaZtDY6BUPRnLczjAqdFwI1XDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251373; c=relaxed/simple;
	bh=+kkWUzDTio/ByhdKzh2wtj7KRg3wTOQXzmfdrn64Jf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkuvH2CZAGSqfDPIhVVcEoY5oiDHQaowOVoNOA71oczTZSdrq+thkz1XQHfK0XvO+c5JvYdwHhUu6SLqVFH8A73qgII5TDkvtXRF5FIXjgSuXPDzFZXwgm+zxiVdNMhKmXv6FUcd0hBCHZJwbqYZT2u6mLHBK2CdzHzcnOv3oGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hq7fIZZp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4JTklaJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hq7fIZZp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4JTklaJ"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778251370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQFNt+9a4A5dfeMowDT9WSpy81hGD3mNS+Yhz4JhQsc=;
	b=Hq7fIZZpmdqb/0DbT5BBcTSNGjtFgSTBhapTssZ7MaUZC35grTfpkmLjNWc8S2wr2j2ZLu
	b3ud3HyomsKJ8pO6VoPikbRrxntV8P2jfYaYk7v0jnr1GW76Ay3S3Hlht0lXaUCzHFaHgT
	PVyCU3aZncDC+GbKKi+7wASTgcdBNB9Gd98ZaqnzEYhiFA8+ZWqMy0GqJC8F7Ob2Dz88Wm
	Kigs3xtw5LzNqCa9OfTLcRxN8Na9RAHC2t5saL3jLUG13/IvemAVFsFNlFuPslQZyl9ext
	5vj6l4rIl4hHCoxp/3knf9Fvq1MJtWz8Cmr0nu18asRuzn3xTzLRDmnd6Rg+XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778251370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQFNt+9a4A5dfeMowDT9WSpy81hGD3mNS+Yhz4JhQsc=;
	b=T4JTklaJWumJ4Zp9TUC52vo/VxxPnfwanI+f+aw79NywQc0k6ARI/r5eU/En80tqA2zxL7
	GFOarnerbeMtcYDQ==
Date: Fri, 08 May 2026 16:42:44 +0200
Subject: [PATCH v4 1/5] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-rpi-otp-driver-v4-1-cf8d725d8821@linutronix.de>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
In-Reply-To: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778251369; l=1195;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=+kkWUzDTio/ByhdKzh2wtj7KRg3wTOQXzmfdrn64Jf8=;
 b=Wd7sEwtQi7ou5NUNCMPp2Z0xVIUb98/tB4VL5L+NVc3h29Sho7Ys9p6ou3E5srJeBtKO6KK8V
 ME/ebRQiq7BAytj+Ac4LWlRVnZgqnaSHBbIEqfZVgtFxScXCyO4G/E6
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Add a compatible string for the bcm2712 firmware. The bcm2712-firmware
is compatible with the bcm2835-firmware so allow the bcm2835-firmware as
fallback.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 983ea80eaec9..a3a5243b9170 100644
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

