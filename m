Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792974602;
	b=PA3UaJWN++A/sMKRD7ephpwj+JZG+P2mpr0NksxA28bzL6f8ZLNuk/iXxdhIV/5r9X63
	 H8T525UFXm6JED7Z31oAohmQaSsxW52AJGrZ+4r1M0MuFDRPlfu98cjoa9aN9S9HIqGKS
	 +PS9QfZR5kLZCJbIMUJvK/JT6g+YTYMk1tLlHiaXclhjOv8YJ/35/aWDGZpcMJO8Elk9u
	 bk8T4ACILRtNqCmHN2ggIVuXzof7cEZr1g+W8CN+W3YvzahUkaiOh0vPMkuD2xmNC4pYb
	 0WTyEU79N9LDOEXKXrhv9hnbqY0VqEh1qR51mi43KRydsaMiOtyMdMyTnEHkjNZbj1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792974602;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=grEo01kQo66WHaUjHFxx2avn8S9t3Pe9iGjv32r3wtc=;
	b=yzWovocJJX7a6/aTHbup10Cf7begh4lTSjFH1sRHeLIR300PUurfR/v/ugpSfHssu2gc
	 oZQYIvQ4Pa1OMfeNqC9KJ7LQeHksezkomojnVegH2xeyQU4EWVbg9UdXOVcBva/s+68BT
	 Dt/WHrDFDl+d0Mjcaxg41WLVH3eO4FZY67EI+fv+MaYe7TY2OYNhne8QShUURA5i9QdbS
	 sX2DOL1m2oh4Pmo7g53giA8TTaZ930/dhjbrK/iJnrv/h1gqAP6IeSHHM43qgJlbY1DeY
	 9e3jOZuUaKhK9Ozn3ZoER3yKu6qbwhYGMsdD9G7mALrrZ2gkqZ58M23We2MliNcrA/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vinarskis.com;
	spf=pass smtp.mailfrom=vinarskis.com;
	dkim=pass header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=e7lb6UIK;
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261F606A32A;
	Mon, 26 Oct 2026 00:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B261F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=e7lb6UIK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1792974597; x=1793233797;
	bh=grEo01kQo66WHaUjHFxx2avn8S9t3Pe9iGjv32r3wtc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=e7lb6UIKD9dLsflH3N6v4erb+AIFCS/8QFU0nPsv+YuKuUni0wKb0ZZH0wWhOcsyJ
	 ztH3X4X/wNLIz2RvifmKa1KRVTFEUyv7vGxQMfG7uHp8RFrCW19bOniGIaxYhaafqR
	 /STWZkF7FpdxddmY8/wL/mgHDwBEqfOanlExZ1YDaXp/8Bu7uDMVmPHsrv2egySzpu
	 VyW1wVInNgwNtd55kd7GfD6p0v2giCxLVsw/mxnq5tqRVnujxW1WKvcdvFNKjvFB6S
	 j1FVbb715FNIBjLEItSbqzh9NagHIg16FgZROzsfd3MPmu52XTmeJwAT6TzP+RhPRH
	 X8zoa1VYlth6Q==
X-Pm-Submission-Id: 4jCZJd63CTz1DFSj
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Mon, 26 Oct 2026 01:29:40 +0100
Subject: [PATCH v8 1/3] dt-bindings: platform: introduce EC for Dell XPS 13
 9345
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-dell-xps-9345-ec-v8-1-251c2cbfbc6c@vinarskis.com>
References: <20261026-dell-xps-9345-ec-v8-0-251c2cbfbc6c@vinarskis.com>
In-Reply-To: <20261026-dell-xps-9345-ec-v8-0-251c2cbfbc6c@vinarskis.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: Liviu Nicoara <lnicoara@thinkoid.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4342; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=mv5nMGhQJ4HJU+dLxlctLnk3H+irsCgi2Dl4/EuzfiE=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFn35jOIyOrd/Xv29Ke/O+7ZLjjB/pVx4rnX730Nf6+6u
 HrTk7yV/R2lLAxiXAyyYoos3X++pnUtmruW4brGN5g5rEwgQxi4OAVgImemMzLMWsix9nubTRTX
 rFO6jsxqyqcK8pvVHxreKmRcNmPB9oIiRoYexwsWk3/dMA0xfSH8oXL3rLL2+QHp+usPPDO7+P3
 zTxZOAA==
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

Add bindings for Embedded Controller (EC) in Dell XPS 13 9345 (platform
codename 'tributo'). It may be partially or fully compatible with EC
found in Snapdragon-based Dell Latitude, Inspiron ('thena').

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 .../embedded-controller/dell,xps13-9345-ec.yaml    | 90 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml
new file mode 100644
index 000000000000..33d59ad52f96
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/dell,xps13-9345-ec.yaml
@@ -0,0 +1,90 @@
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
+      - description: ADC channel for sys_therm1
+      - description: ADC channel for sys_therm2
+      - description: ADC channel for sys_therm3
+      - description: ADC channel for sys_therm4
+      - description: ADC channel for sys_therm5
+      - description: ADC channel for sys_therm6
+      - description: ADC channel for sys_therm7
+
+  io-channel-names:
+    items:
+      - const: sys_therm1
+      - const: sys_therm2
+      - const: sys_therm3
+      - const: sys_therm4
+      - const: sys_therm5
+      - const: sys_therm6
+      - const: sys_therm7
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@3b {
+            compatible = "dell,xps13-9345-ec";
+            reg = <0x3b>;
+            interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_LOW>;
+
+            io-channels = <&pmk8550_vadc 0x14a>,
+                          <&pmk8550_vadc 0x14b>,
+                          <&pmk8550_vadc 0x144>,
+                          <&pmk8550_vadc 0x145>,
+                          <&pmk8550_vadc 0x146>,
+                          <&pmk8550_vadc 0x147>,
+                          <&pmk8550_vadc 0x148>;
+            io-channel-names = "sys_therm1",
+                               "sys_therm2",
+                               "sys_therm3",
+                               "sys_therm4",
+                               "sys_therm5",
+                               "sys_therm6",
+                               "sys_therm7";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e0d90fe2220..f20bb171e5ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7537,6 +7537,11 @@ S:	Maintained
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

