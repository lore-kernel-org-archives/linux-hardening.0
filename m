Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25DC267AF2
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840173; cv=none; b=dLiGw100f0V256HhHUcB+GMe6QbnegbLOLJzhV5lWVlV9i9XCgG5yReXY4XxikvVb0e23sznY/eKuJe1CXhfQ0Q0yOTKcCcS9elfm9lMOz7p+V+m9xLzLmDPpoT/HzV3Q6+bM4PIXiHcStJ6UoEDu38+ycnY11sTedRIdoWK1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840173; c=relaxed/simple;
	bh=czCaHwjdEKe3NKt0rJIH+1zUCm2b7l284FqXlB+S5Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg5udvTK5qiWBxkUEeKgOxD/HmTRcDXNqpkw++X0dgQ7ecfb6ubSuYUe/AKdSPxM7GlniRn0Z96C3G33azZ0JtTm09ETzU3+ipboc8OtIu45a/bz2YRiCXY+jdZqS7dbWc55ALmUyKorqdklW+1TkNS9ikzlZNkuGuK5IQ9/Lkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ot1E999+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ot1E999+"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac339f53df9so894605066b.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745840169; x=1746444969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VxOVJp6hEBHMDCosFs6ZILrioIDtRgANEDqPaH5GyA=;
        b=ot1E999+n4zAfsnQhrEexGU6YI6Ag7M+zN6Y05AXOIbClgut8fGFMmjly6tHZWZLe4
         cotflAjRhvOMEjzGezg8VP0loOue2T+fw+zJBHc8llq+4Y3Yd1uks/UAt6VHI4vcxqkI
         jRDT4La8wfvXEX2+RBPW8su29PcVisNlSKcDbMPQhWqvknuY7fc2FxPDFNQXYH9XD+5v
         QDapUbV56oSZlZj61DsXwPuQOUwJ9sZ8EzhMeCsb7+KavosPNy0Q56AB2JBOjOK5iPCh
         OyxNwncNxT6LqB4P7LOrikQ6ZJdWtYn3i/qTbwBM7y+EBlQH/SgzNDTwYIpb49qX2XHX
         RrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840169; x=1746444969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VxOVJp6hEBHMDCosFs6ZILrioIDtRgANEDqPaH5GyA=;
        b=Xsh7xIJd5wSmybPePz1KuuHwEC5FpjWQ0jlkxQMBlevvr1aZEMqzkb4JVMzv01mkHw
         I1Q5yV3b32ye4hLawY8KMQDfl0GkWn+Rnxc+j+siSOl04KCQDf10BTJ0mGeXrfHVAIR9
         Q7/wlGHeOOKfzWVfD6P1k/anfvg8C8lk/JAbuKF/A9X8oTcdkeNZkrCp3kgRi07hkj4X
         f/zoS1ZZw7JsFPBBO3QrnC+U0QnxdWmX/D8ddSJMIvbaQwtaYpu8Dezbhwdb8aWof85V
         Di3PuG4QoNgU7XbKa794Z82IBd2tYA0VRhH0T9VPajN5I7R+6JCBpYrMC2qvfjKTtNkM
         /kWw==
X-Forwarded-Encrypted: i=1; AJvYcCW1SzreF/lXHy2g8ZLYeaJQDhylHVj+BXeZyf/7lKOqc4YH0Rt8bC0GzSYJ3JqhWQMgbwP7PwjV7HCM6ePipMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22mcWbesJo+7UlRn2VCcWb2YoMy0Z+vIJxiPLdfOVMvZdo7vl
	9naYaMMuVKnF5prw4XlBXwX+auWcvfgZA38cu7uG0KN2s8H0ngvmd+GHPg4Q92d9UzuPtWQLnO3
	B1UA=
X-Gm-Gg: ASbGncum9AARY3ZRPTub3K9frG+hrVtRXhxDkYBqMqLRFate9VPsGDPxzQYDQbGHH8/
	iy0jnBwrCFSTinqDB9TJzoMK/AoZFbX6wxubydvCTQiYaqXglh73MkOS0jh2vqqG7beDjowiyhb
	Rq1EXQQc4RG8tRCdTJ+VLK4R2s+NbtmNMmVDqOLWqvCpHdv9uJzH2dQJdmjuyP3LNmOWRnEHth2
	VS0cng1e+W8UxSIq4mA3uP8Aiq1QJwRJLtzES2oPQM+X4QuLInW5NCtzYYtDQv7K+KgpATOUPyG
	dxQPKJks1Isf0AdGIh/+SG7hOI9TfAYG/6+4PDjGJWbVL8K0JLTosTejDz1Wmq+FXQhjkDXt24b
	cox8JQA47odIoNmF2LohqF4nK
X-Google-Smtp-Source: AGHT+IF2Mpec2Ou5p/cywTqDhvwcf0ewlmn9clUMEbkPcU/0VUXa88a61N24Naca0NbKAtf/tGsywQ==
X-Received: by 2002:a17:907:9617:b0:aca:d4f0:2b9f with SMTP id a640c23a62f3a-ace848c0531mr707750066b.10.1745840168997;
        Mon, 28 Apr 2025 04:36:08 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1580sm619937766b.175.2025.04.28.04.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:36:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 28 Apr 2025 12:36:06 +0100
Subject: [PATCH v7 3/6] dt-bindings: mfd: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-max77759-mfd-v7-3-edfe40c16fe8@linaro.org>
References: <20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org>
In-Reply-To: <20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes the top-level device.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
* drop gpio-controller and gpio-cells, GPIO is provided by the child
  (Rob)

v2:
* rename expected nvmem subdev nodename to 'nvmem-0'
  I'd have preferred just 'nvmem', but that matches nvmem-consumer.yaml
  and fails validation.

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..525de9ab3c2b7b431e48497330640857540625b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 PMIC for USB Type-C applications
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This is a part of device tree bindings for the MAX77759 companion Power
+  Management IC for USB Type-C applications.
+
+  The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors, USB
+  Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
+
+properties:
+  compatible:
+    const: maxim,max77759
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  reg:
+    maxItems: 1
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max77759-gpio.yaml
+
+  nvmem-0:
+    $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77759";
+            reg = <0x66>;
+            interrupts-extended = <&gpa8 3 IRQ_TYPE_LEVEL_LOW>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            gpio {
+                compatible = "maxim,max77759-gpio";
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            nvmem-0 {
+                compatible = "maxim,max77759-nvmem";
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    reboot-mode@0 {
+                        reg = <0x0 0x4>;
+                    };
+
+                    boot-reason@4 {
+                        reg = <0x4 0x4>;
+                    };
+
+                    shutdown-user-flag@8 {
+                        reg = <0x8 0x1>;
+                    };
+
+                    rsoc@10 {
+                        reg = <0xa 0x2>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.49.0.850.g28803427d3-goog

