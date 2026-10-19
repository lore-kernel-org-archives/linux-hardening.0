Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3A46AA9A;
	Mon, 19 Oct 2026 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388078; cv=none; b=E0x7Sz02tz81/fUz/7ewmRc0f3KZXzZrrLtcaH/8hJKqjfwciVnwIxBvaoDi3sg106pfIz3h0YyQv3mICDvmIJBxrAL4TjIVDRFBhNMQ11UWsPK803s7t9l3XP3UWEnR048i3qTkKeMO+6zfH+fyNXxozCdz7jcIsKpQIB1afAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388078; c=relaxed/simple;
	bh=ub4tN8CDOzTWXwitiSfIoHILwvi6zI1K3GTKHFvE3pQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I34Kw+kdG/aY1btRA1c4Z8YHTZlZSaY63f2psI8yVUP4gghABsZHQ2l6wO+5s04tyUYU2CV5c/EX493fxSFCmlFAOycLW1rGf2v4ebU9vwDBr54w4hNEbeqj+RdxfJs0UoZDCAy1P5Jfy8AYadZQ8JK0KBalHg2tvq7Pr3EZIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQXYs9G3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQXYs9G3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C911EC2BCF7;
	Mon, 19 Oct 2026 05:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792388077;
	bh=ub4tN8CDOzTWXwitiSfIoHILwvi6zI1K3GTKHFvE3pQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cQXYs9G3ki/E9FmiSaegeX83zjsCon32/m+v1xxRFPDJnCyNmpaywuqjgTGf2c6vZ
	 bVYoaaFEtD9HypgetEwIi8izQwEgDG2aAsvJk0EWNjwf982YsYWpBWjE6LrwaIIgMb
	 IDqM3aVmR7GXr0r39jRa/6HTteMsn0iQCAPbGUFAj86HBQWMZGNzdONqGL27UZZ5TW
	 5n49sP7SGFk6A7daoVZjT6iRHqkdYaZNQEZGrhT1fw5MVkAvpVScC2Yba1xXBgBxzA
	 YUqA5Dcbk5sCN7Vl1ePg8kqxlkqPdV2T1CFbxxN6IAuN2ry5+SIL+sQIyro/0HTMCZ
	 TPgS6VZyAv4OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC67CCF2DE;
	Mon, 19 Oct 2026 05:34:37 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Date: Mon, 19 Oct 2026 13:34:27 +0800
Subject: [PATCH 2/3] dt-bindings: i3c: Add Amlogic A9 I3C controller
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-a9_i3c-v1-2-329d819d621f@amlogic.com>
References: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
In-Reply-To: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev, 
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com, 
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792388075; l=2990;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=TBTUobdGBphIyuXd0LiPQLPuirtquJsAagN7tB4GVFk=;
 b=FQzwECiEVC4Sh2/3SId2SPXHjsgKXTeAMF04+38WwljJbpDkzhX1U7JvEvgVR9VWQQ333MhDA
 6vKe+i6wcuRBUtietraOkYp97rgRhfCQbs2bCrVJD775Mf4MMGddFOp
X-Developer-Key: i=junyi.zhao@amlogic.com; a=ed25519;
 pk=hiL5PjGIksGFiWvEx9J3MhQqU/ro6vNbj72NIw4bbvA=
X-Endpoint-Received: by B4 Relay for junyi.zhao@amlogic.com/20260924 with
 auth_id=1054
X-Original-From: Junyi Zhao <junyi.zhao@amlogic.com>
Reply-To: junyi.zhao@amlogic.com

From: Junyi Zhao <junyi.zhao@amlogic.com>

Add a devicetree binding schema for the A9 I3C controller.

The binding describes the controller instance and its bus-specific
properties required for driver probing.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
 .../devicetree/bindings/i3c/amlogic,i3c-a9.yaml    | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/amlogic,i3c-a9.yaml b/Documentation/devicetree/bindings/i3c/amlogic,i3c-a9.yaml
new file mode 100644
index 000000000..8e25122c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/amlogic,i3c-a9.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2026 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/amlogic,i3c-a9.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A9 I3C master controller
+
+maintainers:
+  - Junyi Zhao <junyi.zhao@amlogic.com>
+
+description:
+  The Amlogic A9 SoC family embeds an I3C master controller based on the
+  Silvaco I3C Dual-Role Master IP, with Amlogic specific glue logic.
+
+allOf:
+  - $ref: /schemas/i3c/i3c.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,i3c-a9
+      - amlogic,i3c-ao-a9
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+if:
+  properties:
+    compatible:
+      const: amlogic,i3c-a9
+then:
+  properties:
+    clocks:
+      items:
+        - description: APB peripheral clock
+        - description: I3C fast clock
+    clock-names:
+      items:
+        - const: pclk
+        - const: fast_clk
+else:
+  properties:
+    clocks:
+      maxItems: 1
+    clock-names:
+      items:
+        - const: fast_clk
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i3c@3a7000 {
+        compatible = "amlogic,i3c-a9";
+        reg = <0x3a7000 0x10000>;
+        interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+        clocks = <&clkc 15>,
+                 <&clkc 16>;
+        clock-names = "pclk", "fast_clk";
+        status = "disabled";
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i3c@22000 {
+        compatible = "amlogic,i3c-ao-a9";
+        reg = <0x22000 0x10000>;
+        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+        clocks = <&clkc 17>;
+        clock-names = "fast_clk";
+        status = "disabled";
+    };
+...

-- 
2.42.0


