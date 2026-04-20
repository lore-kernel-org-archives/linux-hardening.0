Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D43A7589
	for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706811; cv=none; b=gsmHcLmJW/JtygdiuGCgfaOQAP1i9o7y8BJpOizUITyqTosabsW1RUWh8HGM8BKKlu3K9pIpp6fHpQfRuidx5PwNqCSXMauuH/zxPe1AHQc1OGkAjdAcgyUIwQ9jE2pz8FfVB2cz3tWVYhqBgZ8CeeIEfZ03aZNZPrUf4Qz1IOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706811; c=relaxed/simple;
	bh=OdFNZphZZrwzkL602uRB/9fZndrRswg6kWPWUQ83lLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYKw58PftIBk/sbrPTbGiem+4wuVehcPt08jjmWvemm4fKlZCYYvyRKHAl+V29mzOLZ66/oHdFLrab3SrSWy2uVj31gZ1LktBvvUGEigcHcEU2XXZFHTFPlsIhvOjrJ8APmcWoFThs0BKRE6T/ZDwQzZXFGfak0KT+FlTP25tOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrHDxo2i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrHDxo2i"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso33603825e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706806; x=1777311606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGpK86HdMgvrqoy2bj1skBfpkVmo7qxsIa2pqonJJOg=;
        b=rrHDxo2ibJheWrNlXOa8K13O9NAB8XL2VWxMTCrNbL62sxlPga/v2DAtbxCmp98V0+
         5A6NYV4qPA4MPfwWBaBXRMBK9LLyF5iVBpj+0Q5hMOtXFI/xXNBmO264FASSCgBHDJwQ
         +lAy+5pDB5z2pmvASGUaO2RaiONXMaZ1zNut5XROVCpySMZOvosLreVRx/I7MwXBbTAK
         BbIHNSi9DkLxZ5NtWCME8VIbbKuoRMnUfoBNAGVpNeYGkr8dgCU0DjCCikRKvtGT5v7y
         NA8gLbeBdN51K9Ge7ZlaA8F/zxQ63Y2L6P5TlH2oXJWwzgtf1nJHGdFiD0Oe7bvYbhoZ
         Wnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706806; x=1777311606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGpK86HdMgvrqoy2bj1skBfpkVmo7qxsIa2pqonJJOg=;
        b=bvC9AGTTh1SegEL8V+VGFJkkwRrDenbRFaPtA5gPhw50x1t8e5ldQcuCc4854tOMLQ
         tUbvzpPiIL3uD0Zxk1S1zqKNu+PNIxeGK7+T0Yi/Ke31KlFMZff2p1YnXOPxQOEC9U67
         KV2xwwIvZ/9irqL235SIfioCoUyKv3yTXEXDK6qgN24N4kZ3veKh13YQmhWPolwcCuGz
         un1N1jfyIJ7dSSvepK1ZuXWiPiI6xCZUw0P/BWMp7kCPVDeDezFlmkzCdLRanwZ580ET
         6V99JqRumt3dlaZgDfF2ONdgE++LyqAt2Emo8Tg+yy+HJjX3ViIfN/7vzIZ2xGPSXT58
         LMww==
X-Forwarded-Encrypted: i=1; AFNElJ/4+l5AF6FhHy0j9cR+nsuYtg0BnEoKBKKmGChlykKPLHZQfMmq3iMDleNR7Yi8LGGeFcKkHenlJZt7NQMEbBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5GEauGqu9RAdiLWIuawu452HzteczNZx38UGHK0LFz4yMJ9nq
	2ySet2orraZ6uQAUIwbBU860hpOKqoLx4uDHps/Oa48UOayyujNQUR9KghW1jqUBcD4=
X-Gm-Gg: AeBDieuvoYEFLvOfAjjuCp96Vbu6QcPUGXMnjqeGnuhROBThzSW6kQBmTGB2YdAT76k
	rYRM092l8uKHG3DMcC5cFjbDtJuyzpJX3y6Qx/4mwNz2I1o4oA1zNaQvQNf02R3xKhryZKCCfHA
	F5PMMChJ0x+MqhWxUvYf9qwLDqut8q9JITEWcIvyepTx415wEOScFA1OfbSye2SpNLtg2zP+nfZ
	hKgkCNzyS2jukVIVZKB3KZnIfHNpJTferYfIQE2xk9j64lChqKg0aC2g0NpcR77VRLkqdIOceXx
	veD0glrVvt3fb6L99yW3/L0SlWQahOWHE4VT7VLRW+1yYRFuDF1I5x5Fz5IvxVPlzcFzM5jrRyi
	iHGENUTTOxEzBiInMRCmG21qnMtHaFkMOZ8EQFY+/OlfxeFqMxgUfVIrzXlL8NIraYwxuBotsOC
	fM+SYebqE69N0Fh6f8HbLSIw5E5ma5mrG9Q3Z1DxZI3znyOmgNCz01ajRlwknzJWBf296VdE9fI
	CBT7MPFARt5fNzjxA==
X-Received: by 2002:a05:600c:8909:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-4891b10dd45mr72554725e9.0.1776706806302;
        Mon, 20 Apr 2026 10:40:06 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:06 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:47 +0000
Subject: [PATCH v3 01/10] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-1-3dc8e93f0b26@linaro.org>
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=3375;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=OdFNZphZZrwzkL602uRB/9fZndrRswg6kWPWUQ83lLA=;
 b=uZ84z6z+wMUZD2LCmSNxpX7ypI6Ejebtkx9zuWyST/FHfavxQRwvKlK/M3o6Jibkuo6d1IFzP
 x5ezYFuf3VqDvSctkQKRqUQGVi6aa9K5voFayeO/0pDlk6S9qRr9GXu
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
2.54.0.rc1.555.g9c883467ad-goog

