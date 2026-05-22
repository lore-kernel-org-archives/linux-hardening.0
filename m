Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC78477E4E;
	Fri, 22 May 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464422; cv=none; b=goQ4g8I21m3W1CWMxplqh7JMnPhrYukCbonfrgah5zJH2cg/bPZudVGlMsOgk9ZNpEm2bbGza9KtWfWLjz0VOI0NoLlZMAWdHTONoeE7hU+t50Xqcz+C7w2ufJAW8Antc088dbF5Mn2QdOvanMvUpGbTu9yPhGTeWJs0EAnOlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464422; c=relaxed/simple;
	bh=IfrsMSCpNJWQEqfe46rlehUOfwK8xizeSOL7BdUbETY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1NmYOVQIlCTou+joktq2ZgC1ArpB4k9O2E8/xBIgw4MfbFhl+uPy6L25mirsw8MBJ26ZHtvXNkvVRv6DFvxpG6cXCEF460BKwJEsbvebGLdL8BSkacY4zFF0f6TzuYFeycYuAie+mE2qIksjRDGo9YKLGnIbhtP1Mnow5/UFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbrDk0/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1HZycACm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbrDk0/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1HZycACm"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ObXh6kk4XunevPthCtxU9yhwucuotgK1jqwXTy/qtQ=;
	b=GbrDk0/+3zWfKH0IdzVUilm7KTRmyZqSyX+EsQl/5RdrVpCzHktcDRvUAuQIvJrHIYazaw
	2rAvk+Y9nbJjuxe/x27prvp41nBnPaV1wbYie98/I2/I5g03Ho7gqhb6iRV/fPI8SFcAin
	YoNv5nZjZt8yAqwbMWIcFgKQidSmBGkssvmKKNvWtQGwSKzEwRXIWpj4c7C7taFHgj9iDM
	IhmCDwVzfha5iJWcNOy6mMNKCorywHLlPyDI2KaK7NEIiioEHjxjwNwpaAbO7mET8bzvGK
	cqpKJUw0mmKWoU3uqndqsUp2grPXTIwadmOis+5D3Z2r/TaWYNPvWrwXWoSuFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779464410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ObXh6kk4XunevPthCtxU9yhwucuotgK1jqwXTy/qtQ=;
	b=1HZycACm1rjGF/hGUUACNmMyMiDQHiBg+Gq9f2Pmb6/kd1uh72J6I83UYCbNva7noWpjAz
	cxQvLedQ6cE82NCg==
Date: Fri, 22 May 2026 17:40:07 +0200
Subject: [PATCH v6 07/10] dt-bindings: raspberrypi,bcm2835-firmware: Drop
 unnecessary select
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-rpi-otp-driver-v6-7-b0eac97d1428@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779464406; l=1090;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=IfrsMSCpNJWQEqfe46rlehUOfwK8xizeSOL7BdUbETY=;
 b=n26q+46/ZqDMYFZey78jD9XG/wo3dvjxG+HkjrhGRGCgwgUxSzxhDBQBQJJKmPN5PWSi64pHe
 QeILNf39v3MDliJUcnLKRu9UO6v2sDxix9Xj857BxIyDah5qLzDy6OC
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
index a3a5243b91706..7cf9a6fa1e5be 100644
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

