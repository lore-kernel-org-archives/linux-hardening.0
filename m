Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4822CBF1
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824537; cv=none; b=saE6raV0pRPZcHreaZvDSaVydv+0dif3zX7amoeZze/7u6ruY3wh8SyaYU7nw9LGjBx4FcFuu7eI3RvTxLJM6xXOcwIlFvK0TnC9KCHpjKKnoQDWNbeYPS43zzpmBV473MV2tsTiixTcyzOgb00i3pY2hvkSnU2YORxAyGHmSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824537; c=relaxed/simple;
	bh=NSnDjeYXDKXRwPd3DPQdyVTKpEJbKoAyXp1JmfIwRDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3pIhKQ8RzLUe2MfIRHJUUZEgyRFd4fcjfOquNHt2xPlTRVmqtGRKr/6O2mO1tf/VrZc9RYE/2k77fXkqKgCPPVHyD4dNPNqTKymA/dn0AMSQvA8N65vsK65wx65Aoo3AaTtokl9pDed95SN4YDULTp6oogdPwPmgQ6nsoiNSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptN03W3y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptN03W3y"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so1996056f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 04:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824534; x=1769429334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr92q3YtyZ3lvT3dDx4pM+2kIr4QEW9o4+xmemflEf0=;
        b=ptN03W3yTt0P+/40n+FtqdxtmBFSbSYUNj2hwkgCsCtZSTc0DlGp415OuXuv7kU3hP
         HnGPvloI6Pi3dWCmpOrW+kRTwZRsY80lTJ+wZJFlz2IT3NnzoLhar4FsgDPglI1hnyNp
         cokfhPqPAj84qtCOsG7t7eRv39avzMuJ68RVeqnLSruT/1o8wDrpONfBa3rMttELSQSB
         4SzQL15h4nv4Ko2boZoqOlct++m9qVLev4WERq+oS+534iHXivSc3oSeSue8LAEP3GlL
         bpAUc+oFv5X/8Z99O66xPUlGS1X49iRC/oEKWUMGvIVQyOQLb9Vmmt3NSCVuX4AVvgsb
         92XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824534; x=1769429334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rr92q3YtyZ3lvT3dDx4pM+2kIr4QEW9o4+xmemflEf0=;
        b=VmpbJ0X/RZF3DSV6ipzSMEivFXQ77b25D12V0CsF2tMXbNf5P8HfM/8q4GCEwefWRv
         xI3aGJFaS+qVcUlSAA6opel8pmuyzuVudyWyF3Z8qHVVlg3+jkX5LhX4JiOY3MKqbfRX
         ExZbUZzUMHRarCB1H0zOz3hK/YvvgKtU2YtPKd/ypzvn4+bdXZeCrV7ILfrpFZ579r3H
         m+AMnzrmPAtWP4KSYQdQmNFLUdhTokSLdhd0hKB0/MJpBeO8e1WnaG/fTkiEfY91xLMn
         VridyHVLJ8ZxhzD8XtNxofLoB+4SLHQu6EUxAAN7cs2pO2Bri/qd5dIlDEDII0pfF8fY
         MMKA==
X-Forwarded-Encrypted: i=1; AJvYcCWS+TzUtedNUYR3itfaDiTM9r8P0s/7tvi29V6uJEVSrNTCjp/KZSfXMT0DCuv94+rek/Vk7xeh1YPmWyTxgtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0Liq1GKpN1P9+pn+13XrWPF+4jAk9aMAanrBnES8ttOM0InO
	RK+qG/1aKvnDgu9+w9maVgJlhVLjsiXuSVReKouMVrA5A4DNb0kXW/CJFxGjuuozMUw=
X-Gm-Gg: AZuq6aKzd2wuzn5s4hW7fxtx+albDRUpWh7oCWQNMibWni14RGIY75e7faH3kfSjCl2
	2ge0AL8fLwxuNt+apWTfnL4XF5gl/tRJFC295UBhIfTvdVWz6cBrcgaJk7NXifX1jWNwGbcQctD
	pCP4tK/EHLOAh9SdWOXLmu7FEi9J+qBywqvZ8DpTUxnf0jJ5eC1LA5nTjJUCtYMR2lt1FMK+6An
	gSytp1OqdYJSzLjj9Yq5MzNne+8OzWbs7a9Eq4AW/geHRtqBy4UUXgVjHQ6JN7XSiVQawk0U3DN
	73CC9Pr6sanAmGNW8jMl1MUYJtBpDMI31y4UuIlPF9aSb8QuSCbYiBIJTF3Kp9IbwgfLoHOCvf7
	2wRqNXmAvI2GDCmz8gi++29uthVZN6MY6ZBG9XjmN5GLYxVJRabkqKLh+1CVBOcrjDPrpEhZ8e7
	SfucPiOsEqBFYhj3uP1uTrbTxmu8nEXAXiS1jg78JrHx9fU5v40vSxcQNnGQ61ldmo1x/s6w==
X-Received: by 2002:a05:6000:25c8:b0:430:f41f:bd42 with SMTP id ffacd0b85a97d-4356a0662e3mr13652973f8f.57.1768824533639;
        Mon, 19 Jan 2026 04:08:53 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:53 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 19 Jan 2026 12:08:47 +0000
Subject: [PATCH v2 1/7] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-acpm-tmu-v2-1-e02a834f04c6@linaro.org>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=3157;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=NSnDjeYXDKXRwPd3DPQdyVTKpEJbKoAyXp1JmfIwRDo=;
 b=dtDJDuEZ8DzLjZa7229oBMQmNZpRgOy1kXud/+4ry809hpk1wR2EYaj7pZfffGZmlWn/aR34X
 iStwRKVu+IWANL5Tdx/kQfLXBZ9N9QrNnyHAcG5rsHW5rDnJDO2waeq
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.

The GS101 TMU utilizes a hybrid control model shared between the
Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
firmware.

While the TMU is a standard memory-mapped IP block, on this platform
the AP's direct register access is restricted to the interrupt pending
(INTPEND) registers for event identification. High-level functional
tasks, such as sensor initialization, threshold programming, and
temperature reads, are delegated to the ACPM firmware.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b09e1ff5d89194b570810a042c75836ca2e53950
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Thermal Management Unit (TMU)
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description:
+  The Google GS101 TMU is a thermal sensor block that supports both direct
+  register-level access and firmware-mediated management via the ACPM
+  (Alive Clock and Power Manager) firmware.
+
+  On this platform, the hardware is managed in a hybrid fashion. The
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
2.52.0.457.g6b5491de43-goog

