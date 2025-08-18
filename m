Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE48288CA3;
	Mon, 18 Aug 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517923; cv=none; b=JkzCzFMs3uWFUtqsYxY3Tjy4oM5eYV52oPZBMSteVSPAEn//mW0SEFJekTnB0Ui2cgnUWwaxmiyvigd8tXIoLs3HkTzziY1+jPZwVuzxImjR0RNarD2XXBcym1cw9SdHcKEfX8YdOPemqoEStXpIYlUwBPxqPo5ZXowiJfZzyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517923; c=relaxed/simple;
	bh=UdrsGhVMwqo5cE3+96QM8wAbjr6GF1F6npOZOYlDM6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KdM8lpsc7Hc9GaWz3GAQVbanlVwATJdhKLBKpIG31dMLJOMvXxsqi4Ih9jBe++xyyBxdoI45pncneYmmJ8Y1LwOJvfiCDwqWVbuPWcIEwwqO7c9hc+zaWY+Pp8s7g5Z6tWc8L/JLwEDq5kUt3eI4fuSWbtIyu1oCZldx0P6uYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BHDYwOBi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BHDYwOBi"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IAi6nl023181;
	Mon, 18 Aug 2025 07:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lbrPz
	qvVw+AhfHe0zcNw07xz+B0T3X5w3fk6Qz7465I=; b=BHDYwOBirftECZntT/s1q
	f6rnA7EUZtsLXvHw+C6UpgPSTvuRllNhwb1s3r4UaT/vXzk3TykRBod1aL94JQen
	sbZEzYfZHujEmVujHOba7bjunG5oYYVr+1xcoO+3wYKSTlklsAlOgw1zLYHPVd/h
	PsFo7l2uZceyUXbB9TS/JYwSWJiE4aWpPZF/daOK8rrGBV4S0YiPpyIq2SDd6SKj
	7QEu1cXU/9pgYOe47pkCRE+x1hPt1rARogNNCohxZ60qDWOHB1d0aQr3/e+o/TQb
	KKqLSgP+V35Hj28PFRh04IeIGpr2FLqK/prgl+ehncqhuXxzFoTleGwfbwtXWjeA
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48k8afdtg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 07:51:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57IBpasg036341
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 07:51:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 07:51:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 07:51:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 07:51:34 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.53])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IBpIJT022575;
	Mon, 18 Aug 2025 07:51:28 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 18 Aug 2025 13:51:13 +0200
Subject: [PATCH v7 1/2] dt-bindings: i3c: Add adi-i3c-master
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250818-adi-i3c-master-v7-1-f7207902669d@analog.com>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
In-Reply-To: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook
	<kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gastmaier@gmail.com>,
        <linux-hardening@vger.kernel.org>,
        Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755517878; l=3381;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=UdrsGhVMwqo5cE3+96QM8wAbjr6GF1F6npOZOYlDM6Q=;
 b=fJRuu/5V8WB2EauWIffsKvS5gFX7UKVuGsk3HK6u5HSvoLx4uhPxK1tsN9PBzkB4Er176ziwY
 azJbNO9gIAQCAawZesWn4Q6D7ABz7vjF0OJgE87DPz9BKK7pz+QyUzr
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDA0NiBTYWx0ZWRfXwXeu2vXtvpvP
 ksNRfJRdzSX4hSxctMNrq0qnMN9y2S0prQ+1EJpwqBKIamE0iPc2REnyJ1OWzrUuEiMjmbUgjyc
 9Gg4xwSbzlo5eoLPN4NTaHk6jP3ekZQKLl7tFMf28d0zDRsjF43AYrP+ouksHrgozyifIf5qJBk
 FVT5slSUEVXcCRgKNH9A4scPhJNGy15oFRsnq8KedwYsk2xbxUPvyN9aZySdbpUeXiJyOreAzPh
 6uLKKOb2ZJKcIGfnbMgTRD6qOeliFzjCFkiLGtAJvyjqUpsWG8OKipVQZuQb3SqlTDTzxUiZTIh
 6UcZihgOs0D3k7+vuxw75jfymi2DnOBhojfeA+3foKX+0ngu4j6ZH/b3yXDIdFoLfXHBa4Lp5R/
 46EpMCq0
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=68a313c9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=wI1k2SEZAAAA:8
 a=gAnH3GRIAAAA:8 a=Br2UW1UjAAAA:8 a=cxqr8dddGolBAesk1vsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: d5g9qbpUxXvILPLKjmYEPr4aqXSd_Zfo
X-Proofpoint-ORIG-GUID: d5g9qbpUxXvILPLKjmYEPr4aqXSd_Zfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508170046

Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
core that implements the MIPI I3C Basic controller specification.
The IP Core is versioned following Semantic Versioning 2.0.0 and
ADI's open-source HDL guidelines for devicetree bindings and drivers.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 72 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fda240f9ee0c73bcbea97f775d6e081fe0c089d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/adi,i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices I3C Controller
+
+description: |
+  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
+  implementing a subset of the I3C-basic specification. The IP core is tested
+  on arm, microblaze, and arm64 architectures.
+
+  https://analogdevicesinc.github.io/hdl/library/i3c_controller
+
+maintainers:
+  - Jorge Marques <jorge.marques@analog.com>
+
+properties:
+  compatible:
+    const: adi,i3c-master-v1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: The AXI interconnect clock, drives the register map.
+      - description: |
+          The secondary clock, drives the internal logic asynchronously to the
+          register map. The presence of this entry states that the IP Core was
+          synthesized with a second clock input, and the absence of this entry
+          indicates a topology where a single clock input drives all the
+          internal logic.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: i3c
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+allOf:
+  - $ref: i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i3c@44a00000 {
+        compatible = "adi,i3c-master-v1";
+        reg = <0x44a00000 0x1000>;
+        interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 15>, <&clkc 15>;
+        clock-names = "axi", "i3c";
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        /* I3C and I2C devices */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 35ed8498ab1e9b92b4bce5db9bb64004d80e4b1a..faa50535b514037ddf97309874ec64aac2013cb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11452,6 +11452,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
 F:	drivers/i3c/master/ast2600-i3c-master.c
 
+I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
+M:	Jorge Marques <jorge.marques@analog.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
+
 I3C DRIVER FOR CADENCE I3C MASTER IP
 M:	Przemysław Gaj <pgaj@cadence.com>
 S:	Maintained

-- 
2.49.0

