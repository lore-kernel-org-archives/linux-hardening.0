Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7948097E
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491624; cv=none; b=EqPUrq/+/puOVSPuLuB0H9oRMUGfgKqWF3XUt1HdVfxlf0YSDfHQjmW2z+g812WeAJH4WTCuNrA0pGp11kGFkJdim18GVvLiK0+mUVgC3gde6a9o6poTy5s6eF4jtAEd76eAdo1EDs1LtBq6Khm+yjLKMise3jUHvIUZX4guYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491624; c=relaxed/simple;
	bh=2NgviHNZdxpicEM9rd/dWgHY01rnKmCVPlo7M+lrE2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9H9xYLEfJXVl3KcVTOpH5hbrHiGJabFVFQ/jsdY03x6P+/4D6EcMKanPHVh2qdK/asEE4d1bZ8ZN4ZGGMtUCzm2Wr/Rn6XLR2TKquBfrbYf1l7Xgh3VCl4NVu6/W2TrNUA9zLJAewG6Y5bnFaJkAlNu2LAydYxAlDoZpfc6mw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rt0XiKF/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rt0XiKF/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso27456845e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jun 2026 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780491619; x=1781096419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UJRcwfUx7m4tQO0H7dzGL7l03jX+wNFvSSTwQ2iw18=;
        b=Rt0XiKF/kE2Bzaw9uZMtgERZFKaVVkutUoZUlv2H2DzvyWIhpwxFu5kiQE253tLuK2
         uKRe4WXUCRlQ4x7DJS1/ov55YulxEz77HnMsjmSnOtlq54uz7yZhApop5Ae/xGyF3WFn
         w7OBOfLMd25jOrEm/48kv683bmcussw48mH5HwvUEyVPpMFN3WVUgQ170cFn7KoQaNAf
         UOA+PZw2+xMExxf1KAvR7W090Ic+M0o0Ao03t0czuAkzG5PmXwRgoJoO0oNhj3StiI7f
         oIHDXNk5f8aoW4lF8FyyJLibQq2GXnaS+tX+TCFPrxyNYzISAcKMD3SI+ZJXq0VcCqL1
         l4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491619; x=1781096419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UJRcwfUx7m4tQO0H7dzGL7l03jX+wNFvSSTwQ2iw18=;
        b=WTaFta8gifGjSoZpz2dAJzUlHFZYd2gWFA5K8ALEPD953h8RM7PAWNOGLy6VJJIkGC
         aWFNlBjKtCOI5kB9hppmiuFRsxu9prhMxY76GiwvVc1uqtbnq2/1BNqo0NSxaeM6bOt/
         DbiBwm6vlqjY4PV+nFa57rIZ4ZI/1IpXW1+GnrTUfqUpOZ6vhjLQQI8j35mhj+GhI/x1
         nnI98MtjlKtK/k8+YwCCsbp5ScT+sW9ZLwG3Q7z2LKL69gkfDEvkgbYFuv/JZT4bsz1b
         3f58Tcr+1Ks39Sq7C8TUPKegBpMJVhQadvMGaVuKYYELe1NVL8VHs/Xeq2Sjd5j2F0B5
         J4xA==
X-Forwarded-Encrypted: i=1; AFNElJ/yTfXOkBin9INfGNXQ4//z9GkDU4NdaObBDNPoWsfPfInfPHYsWAx5oh2cM7YfpOgWbzUweLAu3ARfk4teQ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/kCebZdvCQ0lEStyrFg7smBkjuX868JRYQ3AHvjKFkr+Xn+5
	QopkQ7yuBGs71FEev0dxZ2CQT++wtTFbipgsGmj8LFguf8X0QZI4BhIjxq/EW5XDy4U=
X-Gm-Gg: Acq92OFJlhQ/duqrELZgQ98JF8lLCgkPzLiEj4iNKam/aoSBZs2yjspsP07P5PL9uu/
	8p2jGdaajN5oZGT5z9hc5+/53wsWVH7Pbp/RZ7Dix2TWOUoRam+xBKgr+BE/f4HmDWUtIWYbNLk
	g8/k0hZDxz3kEKsvkStXTO29ZdfmISy9ZCpThdoNmzjBBHhq1t4gQBVECW/8U52OWgbeYw1J7U6
	VZfbqky9Kr7CWaAOS/vA6aF5ZhXZXtUHXQ8nRO5w9AhDR0uJguTSwRmkMJeQSqWjY2HYzJxiK6d
	LZZl+HI4fE6D9OBcFuk3zyJ3/Of9UHVtq+KkM/lBCxcXDSazBtYXz2kvdkctgxOo/LTXMVwtvRL
	oau8ZOtRqnw6E5EFbtZS16WsAG8EwJn0jvi1028wGPf4swVTyox6KUuI3NmrSn9/pyWIPXtpaxv
	4M/2+kPjsshgtsVH9vXHAWh14RhdAVQwXeNF+a3gNBdKLGNNMd5C1XXk3nnhAdq70yX5UM4CWR/
	xYQZ3EMzvZvqTI=
X-Received: by 2002:a05:600c:314d:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-490b5ead1b7mr52139485e9.8.1780491619214;
        Wed, 03 Jun 2026 06:00:19 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm149179045e9.14.2026.06.03.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:00:18 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Jun 2026 13:00:16 +0000
Subject: [PATCH v8 1/5] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780491617; l=3395;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=2NgviHNZdxpicEM9rd/dWgHY01rnKmCVPlo7M+lrE2E=;
 b=iPBfwCGJRkej/sxT+TtxA4HdlGWcPjWO694Z6qcPCKaUvKC1gLbqJWYHQRCMrbAH+I6HE7L1Q
 N4obNagGADtCS7KOAAHw3xE0kMuWt1vS+m5IVmg4jZfk1fneqUkTrV/
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
2.54.0.1013.g208068f2d8-goog

