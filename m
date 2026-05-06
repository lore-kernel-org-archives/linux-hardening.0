Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6343E490;
	Wed,  6 May 2026 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070513; cv=none; b=hLsgiVZokFxZDpfZwyh1LrLzsJFrELA6IXr/3lWxul5AbsPnVa+UQZRT1NHoj35SpUFg0y25dozSF+9Pk/YN7O8wXLwzewvFNEYoGXp9wx+r8yhf8lMQyep85lhvJS6BGPo1GbUUD+38N8viKTHDBvmC4EDiskVB1ByoJ9cBG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070513; c=relaxed/simple;
	bh=i28b5kPae1O6TJgN0WQ3X6zS29yFb9fnQDyZIJdT6z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhh2DgBkKsgt2eswnDNwdL6uhCJcIOrqrW+EtU1tCSQNOxqbKDy3zTbAshj1haaGqNsjPNVlYr2Czhx1uZHdRQiqFokYr4cQo3fN4q7uYFsnC79yDopxrvhXrZCU+HvV78D9h0WEPNgri6Qh4eD4cDci7Jv0pUHQ4mDPyA4pJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vg0lSLnD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xB8F7sC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vg0lSLnD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xB8F7sC"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778070511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7wPFQrFfOibwr4CB74CBepe/VCcRdrCCdHhqX/hkBQ=;
	b=Vg0lSLnDalfX899ful3UlIF1C9VwGRlOfqYjWmjJ0X/RSva3FVRKHZkK9N/jbaVjDPDgMH
	wtg2PD2xW+rdpW9lrLCFf2/P1R9RIgufwci5bZuBg/juUjf2m0SqRZiz8el7JfmeiMCmoU
	RB/km84VF6GYshyNlQ5LCewvZycF1EERQVgdXVEpKSUYQ5BzH+g+9sNkao//GWO7Nz3Tbo
	NzOhqmE+3OlZRcH0dml7OXnhUM38b+virM8Ztb3yXlg5c9uODskMRH8HTqCm3z6F24/MeV
	M9xVdDINQiK73iJuoVN/wz/y2j7d4+ZgoCl9P+WVHTB0rFkug8CnzqYDQxSJqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778070511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7wPFQrFfOibwr4CB74CBepe/VCcRdrCCdHhqX/hkBQ=;
	b=0xB8F7sC2iozuFJgRE7iV0an35nm5ZaESmF8JQwTUL+log07n0lDIJzAPKacSLsFYJCnKJ
	ifJ0LrF7txwPeTDA==
Date: Wed, 06 May 2026 14:28:15 +0200
Subject: [PATCH v3 1/4] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-rpi-otp-driver-v3-1-294602663695@linutronix.de>
References: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
In-Reply-To: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778070510; l=1154;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=i28b5kPae1O6TJgN0WQ3X6zS29yFb9fnQDyZIJdT6z4=;
 b=QQTunFcNSxejov3aYv+Hx9pRqK4bevXNHD2tSPUg9fCuSRmy/vw0JHrcmbGH0mzxOyp1K5aM+
 AHFrDtCVOi+CuJFcxhVnYqlbMpX5dpgrURqOpol6IcRX900JRQS0nG3
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

Add a compatible string for the bcm2712 firmware.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml      | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 983ea80eaec9..fbcfa2bc168a 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -21,9 +21,16 @@ select:
 
 properties:
   compatible:
-    items:
-      - const: raspberrypi,bcm2835-firmware
-      - const: simple-mfd
+    oneOf:
+      - items:
+          - enum:
+              - raspberrypi,bcm2712-firmware
+              - raspberrypi,bcm2835-firmware
+          - const: simple-mfd
+      - items:
+          - const: raspberrypi,bcm2712-firmware
+          - const: raspberrypi,bcm2835-firmware
+          - const: simple-mfd
 
   mboxes:
     maxItems: 1

-- 
2.47.3

