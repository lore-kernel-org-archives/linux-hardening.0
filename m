Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07D34EF0C;
	Sun, 11 Oct 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739803; cv=none; b=Hn23Z6p8Tnl6dK6dlOCIAbf9BsKcwrmet+oExsm0jjkcyrkK+iWLzw6Z7Ns+HFH4HHjzgDBJegfGo1/0o/fRBkJpuJ0qp5dES0wZUpj541Ej03utH53glelFVoVx5aGSPvWNSGMMUz3lfJCILEF5WX0iMvylv7zXjUe15ZCybZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739803; c=relaxed/simple;
	bh=ip6YK30AyGnoVEqkQGkufJxt3BIpnmO9Rlu8xdx1PAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIbU9RHoQ5pd5KbeS9W9A3PLe/5FmZWYgGKWERK8uDCz1OK+K78N4SL8MZQO017GjdFGttBMDDhD3X92xV+fZJIOfszTzLXb4IJvjwGwzwGM64QP1hFPL50xJ6TBNxb2cali4Vmp7ouNbtnKalofqHDodpbn4++nvtq4ZYdt4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=tdLQDQEB; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="tdLQDQEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1791739798; x=1791998998;
	bh=9cUtiNpw0w3qfgB1GP1HhsDq2TLFEBW2lfjHlYEyc0g=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tdLQDQEBDY3kCQKIMEJJpbyiX3UiX0d6HvmpCgMz2P4tsokTs/mXqIUWYHQOKEmE6
	 /ECDZOF1Q5UeQ9R1oFp8zVnv9HbkBLiBe05O984Wc+AnartfxqTrz8Xbfnl2uPTJtI
	 6Et5LwN3UVb9KhHKAnY1RWlWfE7yn5jakW4wZWJsEa7ew+Z8ydVP2KPsqi7OvtRiU5
	 OTYLSvw3qFRUZITa8gP51e1WOV1N6odHRNwpjdGbAr1M4u5R01fQRzYRzF7t3gH9SE
	 RbZiKLSfq9YHayJ33XJPUVSjHVzmSpkNcHl8a2kN/kHOQ9CHhooZcLXNQu35QSib/z
	 ucwr2Qkx9uGVA==
X-Pm-Submission-Id: 4j2nfV0PR8z1DF4p
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Sun, 11 Oct 2026 19:29:28 +0200
Subject: [PATCH v5 1/3] dt-bindings: platform: introduce EC for Dell XPS 13
 9345
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-dell-xps-9345-ec-v5-1-2ab1258b84c1@vinarskis.com>
References: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
In-Reply-To: <20261011-dell-xps-9345-ec-v5-0-2ab1258b84c1@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
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
 h=from:subject:message-id; bh=ip6YK30AyGnoVEqkQGkufJxt3BIpnmO9Rlu8xdx1PAs=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFmnj/d+zNx8s6fi8K5+jVXa6jLT0yWEzcwjcrrfeOoV/
 DRi2PWmo5SFQYyLQVZMkaX7z9e0rkVz1zJc1/gGM4eVCWQIAxenAExkoj4jw/8FHztbTu1ylBc6
 Ve/7UnAqn2qIUr/6jvsrSpk/Po6KW8DIcGayTbjgiSdpu6I3pe/ozwgz9hUvF6y1TEo6W8P3OD+
 YCwA=
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
index 252b6d7ee163..1aa035cc1c5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7465,6 +7465,11 @@ S:	Maintained
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

