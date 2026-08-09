Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE512DBF75
	for <linux-hardening@vger.kernel.org>; Sun,  9 Aug 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786282417; cv=none; b=KI2bOSEKbqDsXISYzSW0NZQGYeAa7/beDHntzP0odlkm3xPZaJ+NNOQPrWJotD2l606WFIuwjRgHdVyTko8oXIHznGTbeGeyxZheKisfHqmaKPOMlZ9USAZMG0y0tS2iirrJBj9ftrMpT2Ol/ntKlSvVX/Ls4dI2+K3OkOLWwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786282417; c=relaxed/simple;
	bh=ihASmg/zhs+2rCS1TmfVqL+gqrCYgPDjUH/OHX5mC6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxf2k54VWLnSa1SwF0lV+hi4s11hs6c+0nORr74uxFyRDinCnudqPfWqyMPMTvTe1RyiyKmiwZzCwFUJ5FWXz+3IJX7bg7Yu47JzsY5VJJYl9UAbYoF2qTYSZhIwzWHdIjqP5XXnz/e7heED/NRuPCma6b0L2C22iK5dv8AjmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=KnrgNbnL; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="KnrgNbnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail2; t=1786282402; x=1786541602;
	bh=Bokcbalp5Muyvq89E74sgeQsep+m8MxitxVLQu7sbrM=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KnrgNbnLJkEl65p3BSEY03Q7YLMJUX9n4OFckziZbA8SANYaiPAK5NWeEKaU5HTqH
	 TlBmLOq+lz1wCqvB+L/VAJ/2WUkyuzUZBxo9+1vv8dp/GzLNgEy0jl84WELd9ZrTxr
	 p2y+AijJDRCrsLEC+VPh5yU6tvxSm65g3p2nkLBtfme99J/eHLm5IubK1tKy0fQFLe
	 PpFyoVVebUqEaT6F/c74KdTmg9LwiyzKz2oJ0mBqJ9+9nT2FkOtOHUZV5UAZoiTEXf
	 1WaEL2BWgYeLjCMpEVww97yHyfMkMuRtpv75218PkAMaooSi3LsQS4cjjta5DKjqTx
	 MrDVZMn8CtW/Q==
X-Pm-Submission-Id: 4hHzNd0fPZz1DFFF
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sun, 09 Aug 2026 15:32:46 +0200
Subject: [PATCH v4 1/3] dt-bindings: platform: introduce EC for Dell XPS 13
 9345
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-dell-xps-9345-ec-v4-1-88306dbbc7aa@vinarskis.com>
References: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
In-Reply-To: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4564; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=ihASmg/zhs+2rCS1TmfVqL+gqrCYgPDjUH/OHX5mC6Q=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFkVjfOWTvOaqKlQpizMo7PBVni2aErCvfgj5vZJMkrcK
 /87cXJ3lLIwiHExyIopsnT/+ZrWtWjuWobrGt9g5rAygQxh4OIUgIlsOszIcP3I5zcV8bs+Ffza
 f+O42rJdMRnPnaR/CwTWXvqnc1vLW4rhJ2NDtzaDWWj4Bx6Xqzter9XlX3Hza0FgaGjcrBMPSgI
 DWAE=
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

Add bindings for Embedded Controller (EC) in Dell XPS 13 9345 (platform
codename 'tributo'). It may be partially or fully compatible with EC
found in Snapdragon-based Dell Latitude, Inspiron ('thena').

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 .../embedded-controller/dell,xps13-9345-ec.yaml    | 91 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml
new file mode 100644
index 000000000000..3485117b505c
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/dell,xps13-9345-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dell XPS 13 9345 Embedded Controller
+
+maintainers:
+  - Aleksandrs Vinarskis <alex@vinarskis.com>
+
+description:
+  The Dell XPS 13 9345 has an Embedded Controller (EC) which handles thermal
+  and power management. It is communicating with SoC over multiple i2c busses.
+  Among other things, it handles fan speed control, thermal shutdown, peripheral
+  power supply including trackpad, touch-row, display. For these functions, it
+  requires frequently updated thermal readings from onboard thermistors.
+
+properties:
+  compatible:
+    const: dell,xps13-9345-ec
+
+  reg:
+    const: 0x3b
+
+  interrupts:
+    maxItems: 1
+
+  io-channels:
+    description:
+      ADC channels connected to the 7 onboard thermistors on PMK8550.
+      EC requires frequent thermal readings of these channels to perform
+      automated fan speed control.
+    items:
+      - description: ADC channel for sys_therm0
+      - description: ADC channel for sys_therm1
+      - description: ADC channel for sys_therm2
+      - description: ADC channel for sys_therm3
+      - description: ADC channel for sys_therm4
+      - description: ADC channel for sys_therm5
+      - description: ADC channel for sys_therm6
+
+  io-channel-names:
+    items:
+      - const: sys_therm0
+      - const: sys_therm1
+      - const: sys_therm2
+      - const: sys_therm3
+      - const: sys_therm4
+      - const: sys_therm5
+      - const: sys_therm6
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <arm64/qcom/qcom-adc5-gen3.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@3b {
+            compatible = "dell,xps13-9345-ec";
+            reg = <0x3b>;
+            interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_LOW>;
+
+            io-channels = <&pmk8550_vadc ADC5_GEN3_AMUX3_GPIO_100K_PU(1)>,
+                          <&pmk8550_vadc ADC5_GEN3_AMUX4_GPIO_100K_PU(1)>,
+                          <&pmk8550_vadc ADC5_GEN3_AMUX1_THM_100K_PU(1)>,
+                          <&pmk8550_vadc ADC5_GEN3_AMUX2_THM_100K_PU(1)>,
+                          <&pmk8550_vadc ADC5_GEN3_AMUX3_THM_100K_PU(1)>,
+                          <&pmk8550_vadc ADC5_GEN3_AMUX4_THM_100K_PU(1)>,
+                          <&pmk8550_vadc ADC5_GEN3_AMUX5_THM_100K_PU(1)>;
+            io-channel-names = "sys_therm0",
+                               "sys_therm1",
+                               "sys_therm2",
+                               "sys_therm3",
+                               "sys_therm4",
+                               "sys_therm5",
+                               "sys_therm6";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6008f16ae2ca..9b238f14f0be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7348,6 +7348,11 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
 F:	drivers/platform/x86/dell/dell-wmi-sysman/
 
+DELL XPS EMBEDDED CONTROLLER DRIVER
+M:	Aleksandrs Vinarskis <alex@vinarskis.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml
+
 DELTA AHE-50DC FAN CONTROL MODULE DRIVER
 M:	Zev Weiss <zev@bewilderbeest.net>
 L:	linux-hwmon@vger.kernel.org

-- 
2.54.0

