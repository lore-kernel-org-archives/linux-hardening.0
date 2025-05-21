Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2419CC36
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836626; cv=none; b=LhDRPh1Lq7TCBa3dOZEgwlb5iyD7W7y9g2FLjNVOgVrKWYHQdgVGH+11ZLeKinqT+W1APfQO0AD0OtPFLSCE2QmLLOzpSvQsngNDvhWg7VlBxAJdv84rxemWNjHR0osP9yyW4TZk7M48R1SzkMWEhXQQCIbmCMVCR+ZaPXfVy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836626; c=relaxed/simple;
	bh=JJa/9IwPJecX/xNlhRP+TBQ06Cx+ZcSiINzaYtzoSNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7Ep3O22ffLtKQNe34U9mrQgSoSYfMiuH2E/CSC3WPugR7FGehPU1fQdDbgtTvs6l1SDR6SCJN8XCp+AwZD3uxRS9si1GoadmUX0tInXVYGRc/27aazsAOvZbeeeCOPpaScO2FZYge4e8k5PHn9uJZQW+GYU3/IK1KX1yY0LNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GT/SAugZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GT/SAugZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad574992fcaso608201566b.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747836623; x=1748441423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axrizH4VwOODtm6rlbHWFXbGvGcBXbHyDloVMVUxuZA=;
        b=GT/SAugZYTXikLWi4SsHKHZ395rKLtQsh7bHhZOX+4tpzv2DwfQW7s9x+8aQCIDoaG
         gxwIqXRuOmc242Ck1mrL9lLbgeuyzwSfJj224odW/72NwhXOtRFyIT2QdQ2ya0xsdMAU
         Mp7YCsLofyAmZG2GgExx6wqJBMdfR49LXkBkS6c2CENWKOBm3WWwHloMSymKp/BOlazF
         1zN20zy5pLw7f33TyI84V7atwZ9Hnp9Mwy8AB1lclOaoKD08f9NnkiTu6MvrOsfJkd5n
         z67TtMNsvAt3x8F0rnEGZV5CCuUNc9X6RAZ0o8gHRnUq8pmVqRq7EgiAibXLrRXsV9hm
         wamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836623; x=1748441423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axrizH4VwOODtm6rlbHWFXbGvGcBXbHyDloVMVUxuZA=;
        b=XZ6EjbBtexUtulWmjIzuKVoxbtdk2g2FsYaRGYBqZZfKjbCOGD1K21um0HNUaj8H/5
         yZvn2+q9vVldVjZ3KpYpKrR0PaJMSiezKvXRwUC8G79pa2kSiXv+DEuDjQ+s9gNAy2AL
         J7TxZEDBbgCu1cAHGwUrhmGy4KBo+afhMsgtqJjidug2HKhpphL1Yb2KORPHecD6aYLy
         Qplxnw1dcwetIhxdQh+yGDM/WiUX/UWC8BZ8ktZAhwmaM/pHaNbilVJMgS+JZ7sRzucK
         2dfsev4OV32nqHSBHoYWy65pPP4RrdTDRvTmvzUL1fafiC+4vEGTsiMf98xtQnAOzkIv
         aE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpq1u70TR6jQnlC/9pOCy+BcKBReOAnfej3Zlt/5ff3gH6ObphO0VtyIUzTCXJTnEcTjhKlP9f8P8MnEd4/No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54RQipSC7AwUo4znuco/Lr51XQpEBBysGUN7V65t35DQS+GHE
	KRyOJu+J7gprr88U7alZoKuPhRIZLkb6eYw2PPBI7rRVGDgtC8eVyvr7EfeuJ+RFuag=
X-Gm-Gg: ASbGnct+JjeOSsfIOP3yEwRD7NS01rhVMEdCgtm2QOoPR6TrpfdITROe7loPMjWhE4m
	r28Ahm4zIuBj+2fw2Q7s2AszG04I2QfipTJDdP5aduY5U3VxH291Ocn3OQO0TvQNaZhyrYJEItV
	cpQ6dOe9w04raLRUEkTgGqUu2ACnkRlK5Vj1660iTNufNQ3Mxj2pUlFlL0Q+hrf3TUzCBLzPzUh
	1W4hXwJxdjHvMF9igxGYlbnHv8HHK/zADveRbHfJsawdj5r1xPq0u4aWnlmnfGMhyfkOjtkTt7F
	oiiRWcBff2YiC92pTAvKzAZmXwsqjDDjXEMcynSiWvfq6nt2opGXoUxRAYOLabheZJVDA72lFkV
	Gnlnp
X-Google-Smtp-Source: AGHT+IH3mjW85lP5lOF5G/GhwZ6sMJSToBEkgbvpm+r4oUg10WnOp4gbvX5AAF37R+msjZhvebr+eQ==
X-Received: by 2002:a17:907:3fa8:b0:ad5:60f7:b2ab with SMTP id a640c23a62f3a-ad560f7b749mr1377568066b.36.1747836622552;
        Wed, 21 May 2025 07:10:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm914552866b.69.2025.05.21.07.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:10:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 09/12] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
Date: Wed, 21 May 2025 17:09:40 +0300
Message-ID: <20250521140943.3830195-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas USB PHY hardware block receives an input signal from the system
controller. This signal must be controlled during power-on, power-off, and
system suspend/resume sequences as follows:
- during power-on/resume, it must be de-asserted before enabling clocks and
  modules
- during power-off/suspend, it must be asserted after disabling clocks and
  modules

Add the renesas,sysc-signals device tree property, which allows the
reset-rzg2l-usbphy-ctrl driver to parse, map, and control the system
controller signal at the appropriate time. Along with it add a new
compatible for the RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none; this patch is new

 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      | 38 ++++++++++++++++---
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index b0b20af15313..75134330f797 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -15,12 +15,15 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
-          - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
-          - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
-      - const: renesas,rzg2l-usbphy-ctrl
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
+              - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
+          - const: renesas,rzg2l-usbphy-ctrl
+
+      - const: renesas,r9a08g045-usbphy-ctrl # RZ/G3S
 
   reg:
     maxItems: 1
@@ -48,6 +51,16 @@ properties:
     $ref: /schemas/regulator/regulator.yaml#
     unevaluatedProperties: false
 
+  renesas,sysc-signals:
+    description: System controller phandle, specifying the register
+      offset and bitmask associated with a specific system controller signal
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: system controller phandle
+          - description: register offset associated with a signal
+          - description: register bitmask associated with a signal
+
 required:
   - compatible
   - reg
@@ -57,6 +70,19 @@ required:
   - '#reset-cells'
   - regulator-vbus
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-usbphy-ctrl
+    then:
+      required:
+        - renesas,sysc-signals
+    else:
+      properties:
+        renesas,sysc-signals: false
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

