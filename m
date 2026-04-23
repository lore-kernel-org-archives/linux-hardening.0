Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E183537D0
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957784; cv=none; b=qeSs63JTPlggdphotYpAKb6+BbYfcIW4vze0E8+YGt3JFRQuVB+4djBFVAK+kEnukVWbycVf+TtuS01fBIYRKu1tCt20GyGmszg9+kWfS6soTYe1nV5YfW8TCtwzGQBffg+Z8EVwNEgH3PKfeNYLi3X+dyVAKYXu2MaHvUrRcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957784; c=relaxed/simple;
	bh=DUqmD7ypzAi56hF5Rjwm27fjn6fmPFxHtwOu1/9raE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6Ihrz1OiaW6G0Tpcjn2bLRVNKsuKnpV4RPHhE7xVKDUM3oarkazcmDX2C6Vn0z+YT/ml3gLg/u0AUQ6HPSQMIeuxiVjQszset6Do9yziGE1iLURr4mj9LyeoSF2+Lu1WP4K9zUyZNbG1O21Aaa06ZOvcl18nJ3y6Npuj91SCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ck2aqFEG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ck2aqFEG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso41341625e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957780; x=1777562580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQd9HkoufNSOLhuozcm6yh3/OjVqgZubRjD9rpq9iNY=;
        b=Ck2aqFEGjVZhmCjDJY2NfhhpSfB/Kad+p2K0ejR+OP3X1dVJAao7KU5Z1lAMTKh8Ps
         e1pH1JPXkDFW+FF9+iU5QZBq0NVj7JtZntRnFzjADXqeUD6WqCZ9cdARV0NSzW6AvMd8
         Vu4xyV6zgLmP13LO2pVi3WMifyTXqNy5zvRyd/ewo18x03HXlBcKtca7ChXuNuxf9n9x
         8pir36OTpPEpt+aZJkWvfg5gwkzmtYa9eS1UrXKVraywIgjA1/B9iU1M3KU4+F98Qo0K
         iNiqHktU+efYNDOQprVkRYzEliTZiiRCHYA9A5ll9hkrlfzwlT/on3hQlG1VDY1mLHn/
         PRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957780; x=1777562580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQd9HkoufNSOLhuozcm6yh3/OjVqgZubRjD9rpq9iNY=;
        b=lgBuLxgVw0ipDWtGQ9jI3WOHDxLK6kU7o0VneztaK7o6Y7D6EEwPVKeo/DBqqR2tr4
         83ceirWkBzCX90KprRVVl5omagqvmJ34t8Rlg2dgp+xrhQ8KmzxnrzRSFWjRzlheS/wT
         ratY1U3g9kYBr3l4JoIStAT8enCI7+bTgGFSQ24jzxWMTSbHraVMtTNEC0hDhoAH3ZvV
         z7WZFRp9VjVBYhSiLbKxnyEugp/fnc8oLU3W0Vr1j1XxS3m1CIyGRjHIqcUQtLLlNDLU
         I5whvFpllquShdG3EVm0SDQVKK8Z9/PFj0lEUxSCyarWV1fLoVSxfox66Jo7XHkODSxu
         n6jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qgT4cRQU5xyzvtAA5gEjxrsJQd8+6tTnbvRkDKbjp35rd55HgXrgUJcElZs7nwI34cJx0njc/BpUrmKN0PCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxutdT5ZQ+XMnk5q9nrVaujMYoH5poPphQxjlJW52BLOi/uq9K
	NDqLTdz43xuLeVBspibJZRBShWXgAS78OyuF0JYg1oyiSY1mpecqK1P+WVICYjKzUVw=
X-Gm-Gg: AeBDietCtwSrxh08lyAki2H/+tqNImwqvV1nJafBV9hkId/RsJ2bF/+SFjXp/xCn41o
	LcIppGI+l9SkhnbuXMI4g1gRRWtVee4ajEls9bnmY6a/Jyw+a8e375GDgibKeOSjXB6u324tymw
	XUz1h3za3ZsO+no4oUu8TS9P5RLM63qVCUSBjpKrGeEWeFg1AMS1hkMrrFdL7n4/r+FFuTuitE6
	K3UukIyZCxcbSkCrkcIVjZjPFh6OVbabBnWK8M9Wy80WoU4R2O86aPxH4d99remRvQxQGNHi7Nh
	/zZKNVD0jt/nrJMZ/knDCgTy0b4ZyChncm/MMf4R+RRwHpQ3NA7AfMgTAQmbK5zlwi5nEDELahi
	JqmSGbtudiyGSCTPtn/n5dZZg4iPga93c3rbuuIuIUCR4cJ9u74eiDwd3n83ltNCyva/SxdDPR2
	fjKTLt9xhaQpi0/hsv3pQ8WDLUXAo5zXYd2eQsUwZ7Hriq5/FeO4dt5Yr9zcVzcIdwsexoDxjTo
	ulF2L5u7o2WmNpBVA==
X-Received: by 2002:a05:600c:4f8c:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48a58ae9faemr164398395e9.16.1776957779732;
        Thu, 23 Apr 2026 08:22:59 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:22:59 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:49 +0000
Subject: [PATCH v4 01/11] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-1-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=3371;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=DUqmD7ypzAi56hF5Rjwm27fjn6fmPFxHtwOu1/9raE8=;
 b=UhqzoM8PdUosgQawfVF9WiuGetFtR1EtE1aMLLS4ZQ4GarNM/s0p3imCIaP1Jdt1/LJEbxtQW
 MfMJ8SzgeYkAtmV3J0vYms9+qiOl5uPDZyy2+Zqhf2Qyfd8zS2aTut+
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
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 000000000000..d0eb2393d581
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,68 @@
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
2.54.0.545.g6539524ca2-goog

