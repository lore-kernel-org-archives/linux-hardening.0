Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972601;
	b=KLeKNesmaA41b36rwIbLBq8jqP2frOFh2azhyDlKWHojMSGVtrYRWpcLo7nWiUHX1oe7
	 IVvv1L2iq9CtwrdtgFBLlek9oLEVYwiC7YYondAeHQg9wl0+ZnemWBAJC2lh4K+nqMRe6
	 AJaSRproQzr7LejP66BC/2WKhTd23cEpmr/hKP23xGu5++3I8bMgBv9JCrYsfSv46DuT6
	 pSBDNFePtHOiucMX0xpWicTxcmnh/rqze3+WC5Fe2hqnenEhcpes2stzBZ3lfgmhPuP+D
	 yG7ShpcSIVAV/vPUEONCXyxx/l9eN7jneWo/YI5UxmT2jgYV1Fo7Eia4VdFVBJ9ajXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972601;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:gpg:gpg:gpg:gpg:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AIndq0QBvBOMT4aQTC7iTxVdxRNMAQYJH+2zTStxf7s=;
	b=1Eoj0+LMJHHjlojsyUqAwh2VvhhCq0mPLZSWuvcjq0zCl5XGrdPSoqD9VjnqiNBukohN
	 5v8i4REsq5lzs7Gics+dUuKq5d7/JPlY1a8s9FpHX4iTiCWbyBX5hgNVIA38CLhOLwh8k
	 wO+H4tbhZIaXU8aHXykAc2oECfL0jycY8IGPCq8sARL6IrknCGmVeYkEJwl8wpmdU069s
	 k/5/JkloJ303NQQh/WDRXazyLD3yKZ0qQzoENbatP18JtZw28t0EoajRl69Jz9t3lTCIo
	 dbfLwriQY5yDdznT9tXkoYg5FSFOVHL9YQzld7W5l1x7MjDDqDjUkQMIEt4LirwP2tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vinarskis.com;
	spf=pass smtp.mailfrom=vinarskis.com;
	dkim=pass header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=BOdBholy;
	arc=none smtp.remote-ip=79.135.106.111
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736B606A324;
	Sun, 25 Oct 2026 23:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9736B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=BOdBholy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1792972598; x=1793231798;
	bh=AIndq0QBvBOMT4aQTC7iTxVdxRNMAQYJH+2zTStxf7s=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BOdBholyd06SYb60P+E3Gd+QYiQWF2aplz/xf/iFtNw1yOlc8lBcFACq47V3nGvo8
	 FhAiwBIirFP8TkzjqUHWbq7LBwq45AGo80TpKOSmL0I0hXvCc4BHua86579SV6lKQp
	 Qd1+HcJfg4H7F7Dtmua0cOPaYPMu7BEssKV/70ITP5cPEPJFY6f2TtnlU3YxVlxYB7
	 P4Zy1thwXwIfOnp+gLmOmv4lBMjgbY/OzWMjPEXNPmsRgvEU+BRKH9qO0B/cDs3A23
	 H/ejNgsLzTmK/q6315Cg/lR+/4kFW6YFLDSHe635HFcijNWZskB/t2c4N6B1kE+jdH
	 iqewaBrCYz/8Q==
X-Pm-Submission-Id: 4jCYZB735xz1DFSk
gpg: Signature made Sun 25 Oct 2026 11:52:52 PM CET
gpg: using EDDSA key 8BFCF5668AA29DAD00D728F6EDAE71A20F500310
gpg: Good signature from "Aleksandrs Vinarskis <alex@vinarskis.com>"
 [ultimate]
gpg: aka "Aleksandrs Vinarskis <alex.vinarskis@gmail.com>" [ultimate]
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Mon, 26 Oct 2026 00:56:23 +0100
Subject: [PATCH v7 1/3] dt-bindings: platform: introduce EC for Dell XPS 13
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
Message-Id: <20261026-dell-xps-9345-ec-v7-1-828ce301b839@vinarskis.com>
References: <20261026-dell-xps-9345-ec-v7-0-828ce301b839@vinarskis.com>
In-Reply-To: <20261026-dell-xps-9345-ec-v7-0-828ce301b839@vinarskis.com>
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
 h=from:subject:message-id; bh=dLLWTs/IeTVPq6lqhexxwVftq/rPlXDy4Flf9DCOHHA=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDFn3putLd+4K9Py958J0s66dlo4Ptp3ivXpBLX/F4iIR9
 hlaPDPjO0pZGMS4GGTFFFm6/3xN61o0dy3DdY1vMHNYmUCGMHBxCsBEatcx/BVcMkHUcnUDV6Wp
 7vndK13Fo9b02xj/2uPsWq8o49zq48TwT6/l1NMD7NF+s11Xzk98N91M8mvUw9ZONsuq72U6h5Y
 oMgIA
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
index 000000000000..29cbb837a31b
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
+                          <&pmk8550_vadc 0x148>,
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

