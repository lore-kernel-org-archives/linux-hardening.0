Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B043DD847
	for <linux-hardening@vger.kernel.org>; Thu, 28 May 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968186; cv=none; b=Y9IMCfNd7j6Mh3a600HeuEveRSQ3j6Hj5z4Z+wYFgZ8V62kTSKHz3vyV8pn3E3Uw6a10ZhTyDfkrvP/XYD+Uh/CBCEkXjQQhoYMaVvnpyGyfJYTtgNnYJOI82fURnE/0GEQVRN6dwCnh0YIDMB0u3GzKzm1PQBnBIgbj7aqXPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968186; c=relaxed/simple;
	bh=YiVpGFmnk6c+4tCGKYqMcU8qmH5daodRYRGzWhkV0LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CalXNQgwMVzsGIi7KvjfnRMhN4pg49aVeC0DnwabaBPRRDycFOy479nUUoI5MDnrhdvV7V36p52msNifIKFJwJZnrpSrF54nJfh5FOWVTNbkP9L/5hR073+1u4sqIKQQcCIfYXvgGXcVaZRTb8atCc1OmJLl9PN/5+rWqmQvEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQFvEqVk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQFvEqVk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4905e190c71so51476175e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 28 May 2026 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779968181; x=1780572981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8X0F5bMpj7Hkv7PmV60JbdJxUXi1oD+oGZuG7k+zKY=;
        b=LQFvEqVkiU4BxT3z+BIF1rAzW0RamAdjFg5QhS+H+r2TMRHc7+WyZdDQr1T/pcW0ib
         dNwYDvhm7pnQfmLF8Xp7fB2rvUe0VcfoEnS7UzKJfw8DgvZtU39OuGHk5QO4dc68RyFD
         NvmnDGuCMnDY7MUqB7FgHPIYeYQgho1hxucuY/8GBm6pmmyb1U23/v4u62SeCII7O24V
         rWvZsVcGNtK6OeMUqGLG2n4Xwwoxt+Xq0uJir+L15lm1SGyuA5gk8k+bx6nzX+DMiVh7
         YpqmHdDOnGb4JVFZuztiq8P3HHTUpC/9ccebZEvPK3VxI9GFkAR34mKdQNI0Qdfl1mbi
         mzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968181; x=1780572981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+8X0F5bMpj7Hkv7PmV60JbdJxUXi1oD+oGZuG7k+zKY=;
        b=qb77jUaDwptQwflxAQ5wYvaKWSciV8fsoyTEB94fCFsc1GjvrlN1A6s4CTEIT6VZAN
         tMQcMwYiQVQlvtq0wWXak3/2j0Y7BxQj9TD/1whFEcBZIIauMJmcPW2papSsU+hqcQFJ
         28NorxSZufUsANF3DfR7P4xi2AFH6RQqUc3d3yaXRDqmHk/sUl4LcoFKpazAGzm+fwEe
         gfHViKBd9pTib6AOptXx1RibAEMmGRoo95WR194rNqrwuKWrWUEnAps1ICaD3nrL0XWe
         ZeOqbXHMhqn6bNA0dbpl4Ewd97myzIF0E7HGC67NR6EvhMhH/LnhUQbGDdm4Lo4MqP0m
         lcvg==
X-Forwarded-Encrypted: i=1; AFNElJ/JxrZ5/L/1v/YJ974hY/TaR0TMvjJAh23cwsE+FHzAw2+SmFIjNopb+YfWLEl/M6CA69puMaD7NJzdgjjNQ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9txEGBzHtaVhmXVEK9Arp0aKuvz4KBs9AoZUOZ2petWAdoZGM
	PniHM43m+kawKM+6l3yF5mEykofGQ/ZO8B1orpdH7Geq46DWZzohDwkA6NneKOkL19M=
X-Gm-Gg: Acq92OHfzBR99IymNSy/vINWrS0DHkDt+hh1wOS94gkup4RHCLbTOnZBYa1Pr1XYWcW
	fF48sqnAbnTAdOBAhlznsm880Eb1U9jQEsIz4sveAjVdI0bamG8SR67pdZGXzQjIhMVD5eJSIxl
	uTfGgu2N2DjqXHadyRYc+TUSl1iyl4wDrWkRfon2wNRjgD3qbWANNRqpvFahnrz9ll6lZAKEXuM
	k4IESUkp40wzlzZrrmDJGAkmIBBhWYdA5OKa9rleZznxuztkFgqJ0diRjxY1L6zinpGbG+YeNtG
	px/dBuE+01L9FBvuuHIIPLgh1HYP0Op1H2o5/om6nKwO7/2Iyf4E94ccCiGozr0gb5DPLrrmxX+
	mu3wInVU0WNfplXJVKD5tM1bXbmiwMiyTGR83eAS840DqbBw6Y8kwHLaLozYS+U3D/yWAC1KrAU
	u395UEqdVm6diiNyiAqqX6t3kVkGzeePqR3fCQBmQNRzUfoSPa2ImCdjwFOK0GfTTFM2/DAFXuj
	ghpcoLIGFupRIUHAg==
X-Received: by 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4905cb3eb81mr310813075e9.2.1779968181393;
        Thu, 28 May 2026 04:36:21 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a902bfsm60385715e9.12.2026.05.28.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:36:21 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 28 May 2026 11:36:14 +0000
Subject: [PATCH v6 1/5] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-acpm-tmu-v6-1-b4d7ce57594b@linaro.org>
References: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
In-Reply-To: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779968180; l=3394;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=YiVpGFmnk6c+4tCGKYqMcU8qmH5daodRYRGzWhkV0LI=;
 b=KtZZyG3wFMX+r73Y0exw3WifuUFyiDSfnquCr3zbzt8yf/d1DHw1KK3E58IWx64pXNkgFEDQX
 NMbQp4qP6EUCyGu1lg/K1lswYaAFwiDzq2ttHrLzeJ2KBMkuaBie3CW
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.

The GS101 TMU utilizes a hybrid control model shared between the
Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
firmware. This hybrid ACPM TMU architecture is also present on other
Samsung Exynos SoCs (e.g., AutoV920, Exynos850).

While the TMU is a standard memory-mapped IP block, on this platform
the AP's direct register access is restricted to the interrupt pending
(INTPEND) registers for event identification. High-level functional
tasks, such as sensor initialization, threshold programming, and
temperature reads, are delegated to the ACPM firmware.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 000000000000..75560ebca48d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos ACPM Thermal Management Unit (TMU)
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description:
+  The Samsung Exynos ACPM TMU is a thermal sensor block found on Exynos
+  based platforms (such as Google GS101 and Exynos850). It supports
+  both direct register-level access and firmware-mediated management
+  via the ACPM (Alive Clock and Power Manager) firmware.
+
+  On these platforms, the hardware is managed in a hybrid fashion. The
+  Application Processor (AP) maintains direct memory-mapped access
+  exclusively to the interrupt pending registers to identify thermal
+  events. All other functional aspects - including sensor
+  initialization, threshold configuration, and temperature acquisition
+  - are handled by the ACPM firmware. The AP coordinates these
+  operations through the ACPM IPC protocol.
+
+properties:
+  compatible:
+    const: google,gs101-tmu-top
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB peripheral clock (PCLK) for TMU register access.
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  samsung,acpm-ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the ACPM IPC node.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - "#thermal-sensor-cells"
+  - samsung,acpm-ipc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/google,gs101.h>
+
+    thermal-sensor@100a0000 {
+        compatible = "google,gs101-tmu-top";
+        reg = <0x100a0000 0x800>;
+        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
+        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
+        #thermal-sensor-cells = <1>;
+        samsung,acpm-ipc = <&acpm_ipc>;
+    };

-- 
2.54.0.794.g4f17f83d09-goog

