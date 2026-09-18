Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE53CC7DB
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750374; cv=none; b=G/ruQYURIYgSXu537qW+i8ZHevOsEoZ07M3Kf6cUKlTz/zmUpy4EtZqbnTESxDsvVvPOW8myRBBGTgHW5tFe4E3dVUbljcLj574/VBp53VPT0dXotCBDFwACYWVpn2hH/p2Tu9QVIqEpzb2kJvUUq4BR8HeYnF07Di6pmYAeREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750374; c=relaxed/simple;
	bh=QIb3/8jhfeL45bNJQcRZnEB0rmAEFremYpY1OyHjPAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1at3+b5V55gSQ+bwBTLhHw4SaffI/ldMmj0tWlvowY9Gr4V4b3y5fXHeILrQshDH7zDiGEqZrOga92JzMJU+F9AjIn267YFPZfxmaCYgRghCXYKVFwZxw9uePE3I3yKYMQHaAnpbt61/6VKV/mumvgam03CzIrWnHVnCA5gJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=isg7M16W; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="isg7M16W"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd7so82136285a.2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789750361; x=1790355161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYKMeLZs9/LbC7ro7TTSjk8sEK++X3mMETojD1ueTmI=;
        b=isg7M16WIdOKMncMvdQP1ZSzm9e6in7oUsMV4Se1jH4PFCfr/nO9FqG5/4vKec5/TQ
         lL+ND/7CxP1dCgkhLBJQzqJVFCcsXQEfz+Vi665smZl1RvXiGIQ8jLs2ybECeQhwnaTB
         eS9/iCOq6vFz74xNwYjp9T5165aXo4M++UYCjRn2sWFjtgybnxQmekTTEDvYzQYWVL41
         0ilDVzBKVzhNDXpvyauleaoeUzO3ZvX1a1TpU7BnSbo4r8eouzetaqQP1S03nRKayMqW
         Zb6rAWwphKbDi6SHHDheNdKXfhQW7LI2NMxyGBxiI90JtYGy06SOflQd5ilt/++/wT2K
         ae6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750361; x=1790355161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dYKMeLZs9/LbC7ro7TTSjk8sEK++X3mMETojD1ueTmI=;
        b=XEUUBvbtNVRzOMhLBBs6CfP3foAWf5oewTyldisaeYAztV3JsqIf3WsFKCSTTn/X8C
         lQR9AvDhLyDpX+q8x4IaXyVUE6CV5Mzcwg1hL3263qdD8VKwKpi+roMDikURfkj8Rp38
         /wcFHO5CbYmPw/uqfzX+Fa9YfcSsqW0dkrE6QKiRIQ05yZ+I9eiCnLY0ou00dhM0uHGL
         O11A8YVPWWzJ4onZdX2Nni4HU/2F3JBR6KgkK711bWMI69rap4P3CzDNJQJ/FyKsBuOP
         FD0rFjIf4rvL2XbAeWJu0T4DGh3VlHNtaWGUUPZP+bpDwzy+BmuFI2UWstwzVm6kqjkz
         NfbA==
X-Forwarded-Encrypted: i=1; AKwUvBz+l/7JJfmMqro2YERqT7t8skvbowWCkuYEpk1NuviV1P7iPvVJRmPYL/NrKWlUvAaWXGsrkQREmtjSf5DDz7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nNnjuiiaFHByJtfb4/Vu1FbC9UwVrd9fnQokO/EflnBnOPncOB
	xmzbnQ3P+3OnFnHYU3ktqOpVkK+SfyuNtCqbb8Ua2cxpctAK8DWhuQg45IAS9Mi86TM=
X-Gm-Gg: AYBFou2N25cbYz7h3iRs6rOjeL5Z4W6xv1eZPOvB/Cut7b5x/dOPMtOja5Wu0ztSYWy
	5J3unc53BXYI9yWkmM4pJYR8wcqh9MtvZGN0LTThDLkb6nT1nvgUjrgOPZ/gIx1azipiqFZf2A/
	woTrofre1NzuE/APk4L7VS0s5mUaawzPJb+km7wqpFin3SfH+5VNkzUyRve2g77E74tnU0BmyY9
	YCC61IvCyuS12c8jhx7ImrIRISOIHe2IfgrMWiWWyG33d3cgp7w9yBSlqGmKHeNSroY7dRx+ZTz
	EP7l5MlzkgngHz8DISPrwn9tKAh9lRFBZcU+UoGrazM80INfzKj6QQTgz4131AZVvS19gf9X2jX
	6c00tvB78vGP557/yxRQpnFpCCzSgzone1/ZAbTpMAk5abDQCDW1iI2DDzjQbEt2+mr2f5WuRUW
	ZqngswhAi/Ii4q3DgFTKNmSQG1bg5BVHCZC4PhEIot/kEVmbTnjtY1pVehHq5H7rAuzIBN8c5+E
	quS
X-Received: by 2002:a05:620a:8399:b0:93b:d8bc:a864 with SMTP id af79cd13be357-93bdc8df17fmr414369385a.65.1789750361027;
        Fri, 18 Sep 2026 09:52:41 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0f0762dsm183582785a.39.2026.09.18.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:52:40 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	p.zabel@pengutronix.de
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: clock: introduce toshiba,tc9564-clock.yaml
Date: Fri, 18 Sep 2026 11:52:31 -0500
Message-ID: <20260918165234.687224-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918165234.687224-1-elder@riscstar.com>
References: <20260918165234.687224-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the binding for the clock controller functionality present in
the Toshiba TC9564 SoC.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/clock/toshiba,tc9564-clock.yaml  | 64 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 include/dt-bindings/clock/toshiba,tc9564.h    | 54 ++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
 create mode 100644 include/dt-bindings/clock/toshiba,tc9564.h

diff --git a/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
new file mode 100644
index 0000000000000..cc7019bd240e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/toshiba,tc9564-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9564 Clock and Reset Controller
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+  - Daniel Thompson <daniel@riscstar.com>
+
+description: |
+  The Toshiba TC9564 is an SoC accessed by a host system through the
+  upstream PCIe port on the PCIe switch it implements.  The switch
+  includes an embedded PCIe endpoint that provides access to various
+  SoC peripherals (including a clock/reset controller) via its BARs.
+
+  The SoC is represented using a devicetree PCI endpoint bus, so the
+  clock controller is bound to its driver using a platform driver
+  compatible string.  All of the clocks are simple gate clocks.
+
+  A total of 21 clocks are implemented, though two of these are not
+  controllable.  Access to the clock controller relies on PCIe being
+  functional, so the PCIe clock is assumed to be always on.  Similarly,
+  the PCIe controller relies on I2C, so the I2C clock is also assumed
+  to be always on.
+
+  In addition, 13 resets are implemented.  Similar to clocks, the PCIe
+  and I2C resets are assumed to be deasserted and cannot be controlled.
+
+  Clock and reset ids are defined in <dt-bindings/clock/toshiba,tc9564.h>.
+
+properties:
+  compatible:
+    const: toshiba,tc9564-clock
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/toshiba,tc9564.h>
+
+    clock@1004 {
+        compatible = "toshiba,tc9564-clock";
+        reg = <0x1004 0x20>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b2d3257b8f892..66d0e7e65adcb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27670,6 +27670,13 @@ F:	Documentation/devicetree/bindings/media/i2c/toshiba,tc358743.txt
 F:	drivers/media/i2c/tc358743*
 F:	include/media/i2c/tc358743.h
 
+TOSHIBA TC9564 CLOCK DRIVER
+M:	Alex Elder <elder@kernel.org>
+M:	Daniel Thompson <danielt@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
+F:	include/dt-bindings/clock/toshiba,tc9564.h
+
 TOSHIBA TC9564 PCI DRIVER
 M:	Alex Elder <elder@kernel.org>
 M:	Daniel Thompson <danielt@kernel.org>
diff --git a/include/dt-bindings/clock/toshiba,tc9564.h b/include/dt-bindings/clock/toshiba,tc9564.h
new file mode 100644
index 0000000000000..75732fddd3025
--- /dev/null
+++ b/include/dt-bindings/clock/toshiba,tc9564.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+#ifndef __ClOCK_TOSHIBA_TC9564_H__
+#define __ClOCK_TOSHIBA_TC9564_H__
+
+/* Clock IDs */
+
+#define CLOCK_MCU		0
+#define CLOCK_INTC		1
+/* #define CLOCK_PCIE		2 */
+/* #define CLOCK_I2C		3 */
+#define CLOCK_SRAM		4
+#define CLOCK_UART		5
+#define CLOCK_MSIGEN		6
+#define CLOCK_PLL		7
+#define CLOCK_SGMII		8
+#define CLOCK_REFCLKO		9
+
+#define CLOCK_MAC0_TX		10
+#define CLOCK_MAC0_RX		11
+#define CLOCK_MAC0_125M		12
+#define CLOCK_MAC0_312_5M	13
+#define CLOCK_MAC0_ALL		14
+
+#define CLOCK_MAC1_TX		15
+#define CLOCK_MAC1_RX		16
+#define CLOCK_MAC1_RMII		17
+#define CLOCK_MAC1_125M		18
+#define CLOCK_MAC1_312_5M	19
+#define CLOCK_MAC1_ALL		20
+
+/* Reset IDs */
+
+#define RESET_MCU		0
+#define RESET_MCU1		1
+#define RESET_MSIGEN		2
+#define RESET_INTC		3
+#define RESET_UART		4
+/* #define RESET_I2C		5 */
+/* #define RESET_PCIE		6 */
+
+#define RESET_MAC0_MAC		7
+#define RESET_MAC0_PMA		8
+#define RESET_MAC0_XPCS		9
+
+#define RESET_MAC1_MAC		10
+#define RESET_MAC1_PMA		11
+#define RESET_MAC1_XPCS		12
+
+#endif /* __ClOCK_TOSHIBA_TC9564_H__*/
-- 
2.53.0

