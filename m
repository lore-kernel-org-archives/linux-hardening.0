Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088ED3F7AA6;
	Fri,  8 May 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251376; cv=none; b=c+EHefpWJEJYThP6H3nrQd9Z50HVl4fagq1W6ZnLLb3BIYIA0vCSpXmG0QN113SobBzfEK1TDUXb7mbB1SsPn0LbdU0UCNPTHGpMTxe3tnjsxB4iDvQ8M6miubm6wMCrqJNpOS9V4hVm4OEL+xr0LD/pOAu6eFvOZB9izN7cDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251376; c=relaxed/simple;
	bh=DABsoMXDk2P+S/P+yyf588Zuvkfjmm33Pz1/j6lJE/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHrjnahHMUpsnYT9zwyQe7IUpuCcAWKvKobUCU/hxzY67YYPI25SslXbcFqH7qpJmCNExNj/dRBHotMaFhZE1u2OF8DSnf2sWZxIh6SN+zO/XamKkjPNv5GG59k8SrhYDPX1O0lftFcWbFflui/vFQUo6GmBL/sERodLco6u7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHSB4s5a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=niIffQua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHSB4s5a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="niIffQua"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778251372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKIj7vjKy9Y9Vae3A4dMKPMfxiFmPnyG5vDmw/Z5sss=;
	b=CHSB4s5aYDs7S4QMCOXnymg7ULPR08n77kPrYl+rsyga2SQhoLt6+G8ang6TfCWAXlUURk
	4KIhUhrNMEYYg8ukdH7FLvMTto85iAereEMV9t3Nb6xs7DCGRHQyNdLwROHVtzzUrQr0EZ
	TOCKb8zVFOFqXP/DKHGCA0PVXaeGZZAxJnKKd8xwxjpooMXmKM6yIzVNesUskGeNZM9hcM
	j3CwN5pSVSIpGaEkrF+/ZHCUcO2Q8cJ+Hwdmbbs5qkahsullsXOlnBRMJxdsXz3nvMdiUI
	M/d6oU8roGTn2tQCrkv6Y5fcdBrkEQSIiwprt32tdbXdSTyjROssNrobnirHmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778251372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKIj7vjKy9Y9Vae3A4dMKPMfxiFmPnyG5vDmw/Z5sss=;
	b=niIffQua2d/AOucZGbFiN67+AiliRCE5LWjHdcmrq444/SZ7Cy1/SOd1CVHws80K/FwYRs
	BxY1nWHmhLtJgdDg==
Date: Fri, 08 May 2026 16:42:48 +0200
Subject: [PATCH v4 5/5] dt-bindings: raspberrypi,bcm2835-firmware: Drop
 unnecessary select
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-rpi-otp-driver-v4-5-cf8d725d8821@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778251369; l=1100;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=DABsoMXDk2P+S/P+yyf588Zuvkfjmm33Pz1/j6lJE/4=;
 b=gPPKOgDjiowGSTTjFyrQ567SKtkM82Nof41P9IAw2e6PGA7Hc+THk5vpI8G6BT21JUkoEUzRG
 1z16YPnGfaTCWUAVsYhlgIuHDvZLNqsttQ7yM9NZMsjWlOD8v/JzsHO
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The select schema is not necessary because the
raspberrypi,bcm2835-firmware compatible is already matched by the
compatible string values. The documentation says "Most bindings should
not need select", so remove it.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml           | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index a3a5243b9170..7cf9a6fa1e5b 100644
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

