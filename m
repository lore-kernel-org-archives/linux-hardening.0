Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B553033FC
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jun 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419656; cv=none; b=bQ3Yr++RenRMv0ihCdMv2Bgmz0wLvVZ7/EvHyYBq3DrXowN2mL2TQF4IPwY/rbjnB7EfwImDOVmAogpPRfQU2O1/zsaOccL+CLG2bZLg/L5X7/2zxNl2SXTTzcJmrSU/E/V2sQmqyV0YT912Ymmobh9RWm7iA3Tt31vBA8+upfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419656; c=relaxed/simple;
	bh=2NgviHNZdxpicEM9rd/dWgHY01rnKmCVPlo7M+lrE2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ktuJcsrYP2aL/auVbnZAhfIcEwmoReJGnAGaEeYNwJMsYzM+4chek6Gy8/+P3RsAqqEe5LlIrOB576y++x36UbgYoWMueFF1ffTNZl3WIPR/GNaLNLD9ovuL/GnTD0/FQd9si5wXD5RaWz5A9aQxUwo9Ah5dxs5cbbtFMTQmR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9xgj1dt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9xgj1dt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1639317f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780419652; x=1781024452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UJRcwfUx7m4tQO0H7dzGL7l03jX+wNFvSSTwQ2iw18=;
        b=E9xgj1dttyOCoRx4fLU171x2jZ8S7/Tededy9gNT3NAIWETMhll1rW/RAZ5NagJgjw
         zN7B4MDSCEpfWf99Q/hxVGIdhjPyIV0qIUFJWpdFxzkriCGADLdt3EVf8Y9ezDP8c9BY
         /0B+e5yBhOgYwnMhp4eq7ww9sC8KpljUCFFt2XQM6xKGHTE6D3vnRcnZ465uBWVh3XHk
         oq6a/WbgpfzVcNiGXt4q1zU6tjRTvwJqwGkUfmTYRRSB+sYmdYhvtznhEZrmUJY0BK+h
         k1/UnOTCOy4DeFGeDZi+MsxUzEl7aDx1o+s2kOwaZ/DJHEoHMz2TxoG2c0Ld7TJN+sEu
         CFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419652; x=1781024452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UJRcwfUx7m4tQO0H7dzGL7l03jX+wNFvSSTwQ2iw18=;
        b=iOLhu9OFtNBJc5Ib80CP4tUXX+3u8FuojiDbxamYw2QFt6LLL//dib86TWecSjIph2
         0uaZROlKHOa11yXLNRTuS1upc+nlAI6lJHjO6uZwLoNQrPdib3GbP4Qvp8d9gn+w0em1
         3dv0NVtjNII3j965t0KaZE62/xoLIhBwBSdcpc9TZkDwwVX2DYqkKgo4OWTTSJSckCmr
         caHRAfHMhYsG+rzrfLrr56gyeT4Gcm9IyyVMMGghtlgNgBeSIibfRlW/Ns5t9rfpmFdP
         X2lhz3B5SSAASJQTeHuz+K6Ya7QziKQ1Q/mVGHxDAKGkKx5KAymx9EXOMgLbp5diCD1k
         VmXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TSUYqHzTk3aBhuN6PWF3qerr9cBM6Cb044+uUj7aqziF4Nye6TKm7otsiQpPD40HknZwlx4plC+x/agKzViI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0Qzdu/n1ulybyv2rDZTswj2a69QB0ZyJ1AYG6eVyyrwphRD7
	eR0IC77tyOWPiNz69eHxYzj7SWJEwMrXXzwTG6P2KtHfiv3W+CYVH2HAW6N2fjk+K7k=
X-Gm-Gg: Acq92OE2Zd5oIX1Qu/4dlvPOvOcaG+rchlD7ZRYPj0Ud46fY9MZ4Xqw8EIz91R66FsB
	XFapFm/U1tjhuLPtcW2NixVOGIxEf6nBOQguq/GmSX+QB9ESOo583U3xC0S8/q75Y1qn3gC09nH
	qf5J0bb5f8TuXXd7ojUXoi3Tw8Gp1qJyyppNQ25icJgAV5tnOCdS+gPa9cyIOUH2aqAkC8Ss1n6
	WU8nspGXSyOcuDcTEYfU66PdzTexbaKdyZAkbEElUJshqZd6zR2vdY+/3mQMlu8a/WOn4z4tRSC
	zILF4HbTOxUIuoLWbe8tiDyEzdSO3mEJHsTzcONLdowQodSkL30uvGpuLPumhrdafmDbuMW8zaN
	PkYZJUrZ8TMwc6j5qx2FCYAkO7w6E/MK7KvGPeCBEQit6up4iE37fLwcV2EBzbKjvOz89th+IJg
	1hn8/M1ZtMlufghiR5K6u+eKHcNkOQsMhgpfTFi2ggBimBOayEh0j1Y4A1T+NisBC6vzvxJya/c
	CPqDGxsonrdD/o=
X-Received: by 2002:a5d:51c6:0:b0:45e:93b2:37bb with SMTP id ffacd0b85a97d-4601f4ea1a5mr208717f8f.6.1780419652096;
        Tue, 02 Jun 2026 10:00:52 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm541156f8f.36.2026.06.02.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:00:51 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 02 Jun 2026 17:00:47 +0000
Subject: [PATCH v7 1/5] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-acpm-tmu-v7-1-8047dd54b0e9@linaro.org>
References: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
In-Reply-To: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780419650; l=3395;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=2NgviHNZdxpicEM9rd/dWgHY01rnKmCVPlo7M+lrE2E=;
 b=fD6jATngc9u3E3ols1PmAttEJTrcCe8gC9fW9moXNR1OvAfins8hGD/WQRDyS6sJ0LSvCIReP
 IvQf1p31+B/DjI6lJVup2Qf5ydjcO0jdeRoqPTRob7Mhz/fSXkAa3wM
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

