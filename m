Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E67437118
	for <linux-hardening@vger.kernel.org>; Mon,  3 Aug 2026 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790234; cv=none; b=UgxkLKqJ6eeOAaP7w81ap/ZwfvHYO7kY12z88jlG/X0+tpvjE8BTT9rxWItuUIB/LCVx/6hMceLwzro/Cte5I1FehFjXWaFL2tDO0QkFtLUXuEeGnSWyUw9rrpuEzJENnUD5zW+KOaJ4oGTsqHRHAdAX44lnoD+mFidNpPn1MUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790234; c=relaxed/simple;
	bh=bOdUwZOm3el4ZTYOz7a8pzdsGE5dfIEAW/tE8GDGbGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag41VyokMvI8NTFWLPFOXWIT1qxKvW+xecdet/whe6MGYslmk4dLyxz0keZUHNulIcHrxHbnDsFmae8/jDS6yE8lBDQNOr2cczkE68Y0vuKiM09k02Bz3J57Q/OJVHsJZx+i/t9KsSuH5CfksONgg7S86LT8njvm3S2SacXwqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H26LeBb4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H26LeBb4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceb096e675so45737455ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 03 Aug 2026 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790221; x=1786395021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPNeOdiz6uWEqmYyRrHHYQLDd/67o6llgv5ZaCAb9Bk=;
        b=H26LeBb4DOsYCGZFn+YADYc4qGgmOKuZNMZMy48DzhSe+69w6d0aNQ1oxIde14pKYQ
         QPkYek93pQxiQhXZ4Vif8MXIjFqCS5w4hi9Ee/whd7n8F6kSR9kFU5UmFg7Tz8PYxWv8
         xF/yQmV5HRzxbhW/9B85LEMgZJGXRdp+cvwLFwBNSxyQiq8/Y9/eY46Sq+txwsF8JgY+
         zg3YU6kyur0CTBWUSHrW6bZC1PvX+K9rO075FCuwazTVaJvGpS9a488ikndaBS971okv
         hwNhLfwo2ywT7L4RcVDxZbCzyta34jVMdzZjiBWfg0SGy39l6RfZ5jtsZRh+/tU4X/wR
         F/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790221; x=1786395021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPNeOdiz6uWEqmYyRrHHYQLDd/67o6llgv5ZaCAb9Bk=;
        b=hpIz8TEc/jkgcBghIUv0a2JkasKXtfTV1QNp3iDmd3dSqbUBRn10eBtLx0E4woUase
         1soIwptKkTfGxwrC/IjmYNX8WPE5hi0nCP1QN+Igqd67ImgU3RNLLkmmhQ9PUsgDd5b4
         1iFH5tFwlrhyQXED8GdboUiGO4hVo+DbDmNe8FdbwqHXnxUtd2Yr5nUJ+uMZ6GKWttQT
         YxL9xVrGFNuUrcT0eG5X0EQJvBI3NYl2SlMZ/uslzZNMv7OoJxGovX+kQ6PLY1vUXv0M
         wYdZflSVWvjdYzQ/4c2pPUZnx65+ondZl3FEF3ggDoOt0sIKs+i4RmtluBQmNGU6o/ji
         rR5w==
X-Forwarded-Encrypted: i=1; AHgh+Roy3nidqFR8aF2X4q/trvV7fhEfzaCb+3wP4PE6DnW4BnkpTZRTGH+2NTfDMs+weRsA+GN5avDOBs3KQxLygm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vaMXBRUzxzWG7klNdnkLnxnS5kP8ed+OZb0dnJMPGtyNpiGg
	8k8uaqvIcuISrojKUEyh16D+C1pE8gH3aFI2W0dJWCmpDENLBsm5F4M4
X-Gm-Gg: AR+sD10+ejgE/8oh5SzTxN5Fi6O+9DAVQMEhLsHnYGOlKh9/Pm1qlPas+ebAokogOhS
	/sYtwS9/EUCrYZXXy7Ve/G45sxovkzbQyd5tBCIPzj49bLejD7oHG66szjRyS6KBV1Ugpo3Tpnr
	i7NxQZgopP5K7Z4MI/BbEQPx5M9nfN16t0s9B5JoRAYgViW33AZ0mqiSOcSl/x/I2z9TBtRPIMn
	f15AFlJY4d2leeaMDlxMR/x6CbcnCTb6pAclGIxDcRnXHlTxreXK6woLZc1Ngp5/cuWvaQHZXt/
	ARmBD5KO1Aduj1poGPQl9fKE8a3GjgTXjOwhIvskMvtn/f0el7AP/YxtdKPND6LXMZLfyb5S6w5
	yJ/aw9VUbklaLJTmQ96Dv7pZB/V4Qn47+udNTGjE59G+RSVmNT/uk39XiYYJRWVRpS94gNkyfpq
	vse2MWlaNW6lBr0ylW2N05r0op9XA5xewv07kIkUy3pm366DCbRqPbd+pK6VFa5ne94NI=
X-Received: by 2002:a05:6a21:1fc4:b0:3c3:c185:f334 with SMTP id adf61e73a8af0-3c92a95073cmr13560180637.66.1785790221259;
        Mon, 03 Aug 2026 13:50:21 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:20 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 1/6] dt-bindings: leds: Add IS32FL3207 controller
Date: Mon,  3 Aug 2026 13:50:06 -0700
Message-ID: <20260803205011.1249-2-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803205011.1249-1-ahmadexp@gmail.com>
References: <20260803205011.1249-1-ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IS32FL3207 is an 18-channel constant-current LED controller
with per-output PWM and current scaling.

Describe I2C addressing, power and shutdown controls, RISET, and
individual or multicolor output groupings. Require board current limits
for each output.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 .../bindings/leds/issi,is32fl3207.yaml        | 208 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml

diff --git a/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml b/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
new file mode 100644
index 000000000..ffb305e9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/issi,is32fl3207.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lumissil IS32FL3207 18-channel LED controller
+
+maintainers:
+  - Ahmad Byagowi <ahmadexp@gmail.com>
+
+description: |
+  The IS32FL3207 is an I2C LED controller with 18 individually controlled
+  constant-current outputs. Each output has 8-bit current scaling. PWM
+  brightness control uses the controller's default 8-bit, 62 kHz mode.
+  Outputs may be exposed as individual LEDs or grouped as multicolor LEDs.
+
+  The data sheet is available at:
+    https://www.lumissil.com/assets/pdf/core/IS32FL3207_DS.pdf
+
+properties:
+  compatible:
+    const: issi,is32fl3207
+
+  reg:
+    enum: [0x34, 0x35, 0x36, 0x37]
+
+  vcc-supply:
+    description: Regulator providing power to the VCC pin.
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to SDB, asserted to enable the controller.
+
+  issi,riset-ohms:
+    minimum: 2000
+    maximum: 76500000
+    description: |
+      Resistance in ohms of the external RISET resistor. The resistor sets the
+      maximum output current according to IOUT(MAX) = 76.5 / RISET amperes.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-9a-f]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 17
+        description: LED output number.
+
+      led-max-microamp:
+        minimum: 1
+        maximum: 38250
+
+      color:
+        not:
+          enum: [8, 9]
+
+      max-brightness:
+        minimum: 1
+        maximum: 255
+
+      default-state:
+        description:
+          The controller is reset during initialization, so an existing state
+          cannot be preserved.
+        enum: ["on", "off"]
+
+      default-brightness:
+        maximum: 255
+
+    required:
+      - reg
+      - led-max-microamp
+
+  "^multi-led@[0-9a-f]+$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 17
+        description: Lowest-numbered LED output used by the group.
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      max-brightness:
+        minimum: 1
+        maximum: 255
+
+      default-state:
+        description:
+          The controller is reset during initialization, so an existing state
+          cannot be preserved.
+        enum: ["on", "off"]
+
+      default-brightness:
+        maximum: 255
+
+    patternProperties:
+      "^led@[0-9a-f]+$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 17
+            description: LED output number.
+
+          led-max-microamp:
+            minimum: 1
+            maximum: 38250
+
+          color:
+            not:
+              enum: [8, 9]
+
+          max-brightness: false
+
+          default-state: false
+
+          default-brightness: false
+
+          retain-state-shutdown: false
+
+        required:
+          - reg
+          - color
+          - led-max-microamp
+
+    required:
+      - reg
+      - "#address-cells"
+      - "#size-cells"
+
+required:
+  - compatible
+  - reg
+  - issi,riset-ohms
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@34 {
+            compatible = "issi,is32fl3207";
+            reg = <0x34>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vcc-supply = <&led_3v3>;
+            enable-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+            issi,riset-ohms = <4700>;
+
+            multi-led@0 {
+                reg = <0>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <8100>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <8100>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <8100>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 932ea1db0..744296f1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13828,6 +13828,12 @@ S:	Maintained
 F:	Documentation/filesystems/isofs.rst
 F:	fs/isofs/
 
+ISSI IS32FL3207 LED DRIVER
+M:	Ahmad Byagowi <ahmadexp@gmail.com>
+L:	linux-leds@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
+
 IT87 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.50.1 (Apple Git-155)

