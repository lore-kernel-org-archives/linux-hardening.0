Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D871A5B92
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891231; cv=none; b=lnJVBXeBjEy1Qx0lIWHvm1XJ8QLVbSHbO53YXcJrJc7kjStbuLSt+u7JtwpLBKI/Dt6PMIRMjn24t9eT3/v39248J1MFnLaD6BwqRW6y1lW+5TCGPE+KpAAwekw6+omyDMcfgVLy9aaGJJ+eX27T9QAhkn18Oj7OWFdhx13g+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891231; c=relaxed/simple;
	bh=Kyd5Vj5Wtgn7kWZUmlkSip+En4I9UUHkx0BnikIJZpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KP/6newPCI9R7ke80JQ7j/v6uMCyD7wbdRZemz4WoF+d7lAGjCUjnm8pGai4JsYtXGBLFmdNyIhJKXyHGLjgs8s/c3xHgVY68oYDkKFf4DxwR105j9lXu2yUHLxUadXOEol8PXWRVM9YkEkstkAWTEL5BPuDMA62qdS14WAuICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vIt14Cgu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIt14Cgu"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so9601178a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742891228; x=1743496028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dExfc0LrUCiaYdxVn5B5O2p+BcM4AL59uS0XF6ohUVg=;
        b=vIt14CguVwXaMo0BS+urTiCwPpHwgRWgrFQstHNlQ7cN6ZM5hBTN2kIZvPCUFV0o2Q
         VQYNmVPMoO8Jd4iIZUGtLSdFA8Sx1vZvN/ySLMzPMI9/hvgIJO1QNctCnlV1jg+A128D
         i13Fyx0Uyf39+91haPeRFZj2Mkwj8gnqR+MVWCiNRhwW4DoiItwqTDyIj1cEEKQRj4n2
         b4KaQ1MP28k2Ls1OsfuQa3TmFBU/H8TbfEEPufis+si/rq07EYIW1EzhjGAWMRvWpbDT
         f9jQljEDAMEWkykHLod0BEt5X5yESrl/TunuavR05Uy46vIjstcDVdH+lgH8LxwE4DcL
         KY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891228; x=1743496028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dExfc0LrUCiaYdxVn5B5O2p+BcM4AL59uS0XF6ohUVg=;
        b=Aeoz4FmyHtF+gWAMYRi4ZHduwPFMRoufhx2OoSaiUV77HEsH8VlhstxhGlcIF04SPY
         cC7m9/LNkSwVn80VYUwSCAvJi3h0K0wadPxrGLFxgSNpISOXcI2cCmTOsmsFhWwj3s+9
         OmqQGGExNCF+QneXsV0BgeYGlxEnLsoGhT+0+JF2WmYtoeQxOtX2qVSUiV7OrpBWS1p/
         hmVEXCEGDrNtBmTsNLpEMUKnpry1SoLlugxCMseH+dcp2Uah91V7v/6bvvAN++MrP4HD
         F2x9OJR+TnSMqaCnna57GILSgq0CmMyPKF8wcWWJHjjEhJXm+Jrtd0b8siE8pXtQ0ZJJ
         ZL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQbskZXuzjluPTL9pxGILUZ3yRHgl1JYgBRmm2thSv33GAytxDt7dPnTHNWzMpqhQpDhWgzFRBAR6te4UaTOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDHCYnMU+dw0EKWA0J/sLYYE7dBhBWAwpBIFQk6KDFqWbypX/
	i5R3FsgqjORki3xS2do8ujLeBz3Xlmln0vsqGHZV0UCsCwu+TmiBgmkrqlqbT8Q=
X-Gm-Gg: ASbGnctCYR72mwpwYDbOhk2/j0/T2isauvys/X1FSAa7vpDFMmbS48RZZrqTGusnCql
	ciAbIBCf1wlygqsVm1u2BMcR6/oCwP6ZrYMfQI2GgrWfnyLTIHDMAu0CVpF5QldX93IH+D3XUIr
	rj42/TQ/oko3ARZE+GYmTrvp3oQ8+ggKYZcdrCLBGhEGb5dzHBI9bVedLzVhJIhyFkNsgZzqNJ7
	9w/3wz0Ww2BH5SKl4rjRx2/BqwvRDPmQPATg4igrjeWanyRKArJoDqEIOrpYx0Ajzb0Hx5o0YLb
	siK3tmKgwlz7ZqFqMSko3vy/2Zx+4BvGIcV1j+3oigjBR3zH/P0c/kUKT6GCEDsqCGedB98Nt0E
	e6huc6NdSv4ce02lq6dfererwtKai1GPEaNXd9eo=
X-Google-Smtp-Source: AGHT+IETS1Hu/UkyFfdpYieJJqw0ebd5k4Id4I4sC+Mits7qzvZBXwhUg/V2cJOY/PNffhsh09xSpA==
X-Received: by 2002:a05:6402:510a:b0:5e0:4c25:1491 with SMTP id 4fb4d7f45d1cf-5eb99739ed4mr17627285a12.7.1742891227664;
        Tue, 25 Mar 2025 01:27:07 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm7377366a12.0.2025.03.25.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:27:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:27:04 +0000
Subject: [PATCH v6 3/6] dt-bindings: mfd: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v6-3-c0870ca662ba@linaro.org>
References: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
2.49.0.395.g12beb8f557-goog

