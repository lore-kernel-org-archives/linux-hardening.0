Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B944DB73;
	Fri, 22 May 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464416; cv=none; b=g30x3acDb2lMb3bc2DZt7C5Mx67kSbOSXc/X4YCH9SiKqre/O5c7DKyU9neTuuo1heecITtiXDIN+NWtd19dcNXy+0w5CRtbieNaXlkPUJs4v7fWJxkflK/eSXOUxb0//OBenThyZn568ncqLDL++pPFUHxVDnriMjiFUb4IlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464416; c=relaxed/simple;
	bh=qD30315sFDKvQ1zxeTxTP4/+d92pYx/4B3/nMfkSHxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPOjxf78LEGX6nXNr8CqDBiOC2dG02pm/P65lg1m+h8ovLCiFbZwYAqzW/JFT7hQk3Rta+kdEgQt9aagf8Mqocf7ZnKkG43/AKPBzBhKxh2W0o821ejDe+LW1JaHh0INxIw5ZOoiD5aYc4DV8HMCNywnurdTCHaHg9cRfSNPqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3KHMcbP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izsKWg4L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3KHMcbP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izsKWg4L"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e571YxZZj8gyO1yRbMno9e5ALDgboYntuW/WsLJaO3E=;
	b=L3KHMcbPUskhBGOWh2gaa8GcGuh9MJC2yVWT3+AMIyei9r0ouNHbfDtK59o/3RYzrnbOB1
	JGQbdQfSOe+/yqfRjQluIi5y+9N+fwzp444RKZeu/idOs0aFprmA3LwlIyqxDwsRzzLv8F
	1hQpRlycKKxB5SIc+BedkgqIi1J4hR72Z/XDF5vqEtxmgqwMRJuse/lxpdZy+pBtT6qhZE
	aElU3yljCudT2s3wxVtMpcuyL9Mto9WZJKvyttq28s6rk+Xqn9CHYVFw+jke9njlrjTPX8
	y1heWjwlc3Vy0Bc34CjhWozwLcfgXJOZBOCVPSUyWcsNtftt/13sEpgkmzsJAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e571YxZZj8gyO1yRbMno9e5ALDgboYntuW/WsLJaO3E=;
	b=izsKWg4LVCP4kDh5I5r9pM+zlCZOwAQfpCoTtMVoj4oGbfPbWAQGlQPPp5A0jjgan6WcDf
	uyCTgrXKyU00TTCQ==
Date: Fri, 22 May 2026 17:40:03 +0200
Subject: [PATCH v6 03/10] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-rpi-otp-driver-v6-3-b0eac97d1428@linutronix.de>
References: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
In-Reply-To: <20260522-rpi-otp-driver-v6-0-b0eac97d1428@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=1250;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=qD30315sFDKvQ1zxeTxTP4/+d92pYx/4B3/nMfkSHxk=;
 b=q/QVJSLY9Sm34v48tDRySt9gYiLoBmdLykB6cLhVZQtjLPjYUFeFJeiB6tPHnqKmY2iiAP6EW
 xtMh1bty8OsCFL7442lh571bGMJgMw9sQbgGD8ZoPRYRKpuy96Yvs6v
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
index 983ea80eaec97..a3a5243b91706 100644
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

