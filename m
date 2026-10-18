Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1F40961C
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352948; cv=none; b=BtH6Vbaunlc5+/28dpiMgf54UsgkzX4maucPqc+FJthNiut85aX7Uo88XpCJdo+sbcUJWTxNPDEovKrY9fpv2IwBoxCnUj5mShX/58MUQk9E1jdhMhZDsoyS5bZrDkJ4Cqg9dOQOHqVgWFKllO1NO9/awp+A0SEkSwZ3zWgqCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352948; c=relaxed/simple;
	bh=CKe93UEn1J778NBh+/q6RqsScF1o+jQ6sfhoQ/KqQNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC9TLf+n9uW6tKfRHOla7Jhml2TmZxNDyCfCLPfs5aCBqRU6T37ahLAoUtj9lvrYHRNTAkIIBO1MUBlzwek/JGV25P5Ca44dvUzXCsWAC6+usjPOef3qD2TnY1J+sHWd3TB8qjePkRp6WN2z978NNSGnn0RFjhFaVIhL2qM8SIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca; spf=pass smtp.mailfrom=r-sc.ca; dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b=GSPPf/LP; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b="GSPPf/LP"
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j78HG1TF5z8sWR;
	Sun, 18 Oct 2026 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792352603;
	bh=hZEEpVtfxh8yfK6Vf5kFb5/bx5r3dxfFUFoRV+Yz4QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSPPf/LP3xi/R3aqv6w0AOpyUno8H1B1qcxU4Nd2RNlXbAG5IrQ1YReql9d5ZPn/U
	 lOhltmAjhDjI8uGswof/ZbttC1EczBa6zl7brJshtD4dYRt84c8zqV/jg5izvYTmLD
	 nwqpyavk7ggXZgRmoxI8jZ2PlDvOpMaiT1J4tn1ERdctf6dVasRRak4ahXc5kvxGar
	 trk8mrDrKG27exCJR8neV/oQeE/spllU+E6vz7tp6dIwuvz8J2LzrrrqYEf2JD80rz
	 YSkRUOAfaXlrUyQ7MzHZcVGo1V0gO6rLWFQ+qoO9MjamYOnaL1gieIuquOdXzp7zAn
	 z6YEEoL/mpv5A==
From: Ross Cawston <ross@r-sc.ca>
To: andi.shyti@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: [PATCH 1/2] dt-bindings: i2c: add GPIO buses sharing one SCL line
Date: Sun, 18 Oct 2026 12:43:14 -0700
Message-ID: <20261018194315.945-2-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261018194315.945-1-ross@r-sc.ca>
References: <20261018194315.945-1-ross@r-sc.ca>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: ross@r-sc.ca

Add a binding for several bit-banged I2C buses that share one SCL GPIO
and have one SDA GPIO each, as on some Realtek RTL930x switches. Each
child node is a bus with its own SDA line; the parent holds the shared
SCL line and the i2c-gpio style timing properties.

Signed-off-by: Ross Cawston <ross@r-sc.ca>
---
 .../bindings/i2c/i2c-gpio-shared-scl.yaml     | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio-shared-scl.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio-shared-scl.yaml b/Documentation/devicetree/bindings/i2c/i2c-gpio-shared-scl.yaml
new file mode 100644
index 00000000000..e725120973a
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio-shared-scl.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-gpio-shared-scl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bit-banged I2C buses sharing one SCL line
+
+maintainers:
+  - Ross Cawston <ross@r-sc.ca>
+
+description: |
+  Several I2C buses bit-banged on GPIOs, with one SCL line common to all of
+  them and one SDA line per bus. Each child node is a separate I2C bus.
+  Transfers are serialized, so only one bus clocks SCL at a time.
+
+properties:
+  compatible:
+    const: i2c-gpio-shared-scl
+
+  scl-gpios:
+    description: The shared SCL line, usually open drain.
+    maxItems: 1
+
+  i2c-gpio,delay-us:
+    description: Half the clock period in microseconds, as for i2c-gpio.
+    default: 5
+
+  i2c-gpio,timeout-ms:
+    description: Clock stretching timeout in milliseconds, as for i2c-gpio.
+    default: 100
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^i2c@[0-9a-f]+$":
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: Index of the bus, for naming only.
+        maxItems: 1
+
+      sda-gpios:
+        description: The SDA line of this bus, usually open drain.
+        maxItems: 1
+
+    required:
+      - reg
+      - sda-gpios
+
+required:
+  - compatible
+  - scl-gpios
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c-gpio-shared {
+        compatible = "i2c-gpio-shared-scl";
+        scl-gpios = <&gpio0 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        i2c-gpio,delay-us = <5>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c@0 {
+            reg = <0>;
+            sda-gpios = <&gpio0 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            fan-controller@2e {
+                compatible = "adi,adt7476";
+                reg = <0x2e>;
+            };
+        };
+
+        i2c@1 {
+            reg = <1>;
+            sda-gpios = <&gpio0 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
-- 
2.55.0.windows.5

