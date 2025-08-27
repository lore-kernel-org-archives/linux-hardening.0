Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B596353366;
	Wed, 27 Aug 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302749; cv=none; b=eWmJrrcKlXLjcRngTW6YtQcFZNLVDS0mEZN/kkUCqdqDs6u8sWJnV/KANxZ+4XTFyrGd/oLoGemg1VOwzlM1mcCzNzdialC31KiiF7liMCBDAzX8nUwoJhwL51nc84B+ADJ4kFUKWETeMxMzTtAj46YzAomlQCMEN6hMOq5tQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302749; c=relaxed/simple;
	bh=Dujc9e62zVFeI4FhqxBAWrZDgKDoIMeNFu4rfRoQRMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hdN7yfCArw5+4T1J7pWnYixaH2e2jrpOIRnkXleEpXzaHNsklb1h1l876C6ywPWb/F95IvQt5sv+jyALLZG65s3G6/+7o9TdGLT+Laj05SvF3H1kcFKYEG6WiGgMaXrphaC+r/r7i+9gk/g05CItSonaWIquhCkrafobkKAhAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qe+MKsQu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qe+MKsQu"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RDE5oE029675;
	Wed, 27 Aug 2025 09:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TLxEk
	krlNSdM2GD+Qgsu39aEeaFNmy2H3B/gtkYE/18=; b=qe+MKsQuqhxsYnOHqTk0q
	qGuvf2u4ItGAZpTXd69jSdZ2FX46i4FNvg0uDW4vRfQ2SIj4R2d4uiPfYD8way9A
	3ilxBREK21yBFh+2edeQ1nO2nMKFLCus27HQlnC96MCV77DZmW0iQ5bYwN9hSJoG
	RCBZUXM3zlG3R8xrJUaLnIU6KrRabJGL0zu/LW6Qmyv1j0v0fdrf3oOT6kQ8OJvN
	Em0Ww4DoxLvr8jFonFbGnrAT9bqTceqBcaQ646DGHn01syD2ubH1QP3UqTMe1Dvo
	xfwYQIAiYdb1UXSrDMDdDwfWBIcdzKLv5YykK5bwXp5c/RjxtlUnezURrNvnWPMU
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48sq8gkggr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 09:52:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57RDqFkH058165
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Aug 2025 09:52:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 27 Aug
 2025 09:52:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 27 Aug 2025 09:52:15 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57RDpw2R006762;
	Wed, 27 Aug 2025 09:52:09 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 27 Aug 2025 15:51:58 +0200
Subject: [PATCH v9 1/2] dt-bindings: i3c: Add adi-i3c-master
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250827-adi-i3c-master-v9-1-04413925abe1@analog.com>
References: <20250827-adi-i3c-master-v9-0-04413925abe1@analog.com>
In-Reply-To: <20250827-adi-i3c-master-v9-0-04413925abe1@analog.com>
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
        Jorge Marques <jorge.marques@analog.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756302718; l=3433;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=Dujc9e62zVFeI4FhqxBAWrZDgKDoIMeNFu4rfRoQRMM=;
 b=RmzP0nmW1rKml3drHvwuuGbYYS/TnYTFf0eydNSPP8Vl2F67v6J93c80ajpQlH7X7VJV84XBG
 gC5/zoGBZzEDo8txj1l9tzPXZ5oNr28VTY6gGeUgWPVLWk7U5pvdXbd
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOEwSRhE c=1 sm=1 tr=0 ts=68af0d90 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=wI1k2SEZAAAA:8
 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=Br2UW1UjAAAA:8 a=cxqr8dddGolBAesk1vsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=6HWbV-4b7c7AdzY24d_u:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: eK8ab3mHSeP0TlanF9kWF50icL4c3PYH
X-Proofpoint-GUID: eK8ab3mHSeP0TlanF9kWF50icL4c3PYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDIxMiBTYWx0ZWRfX9zgAVSkjyiye
 9r/WD89/OjuM7uvXr/T+Nm2pg8IZivNdxbDLy2nivzFzlE1wvMI++BDufzCO8/7TnZksH+mGleA
 fio7Ji79EPm9H7Qo4+u5KtY9gld7f4Pse1D7FkrU3egUu1D+xO1qeKUHEOYmuWHt9tgV4QORBlA
 p/Nu3re8nrYSTRzeaB+oPZ2Fqm2CssVZiarWanjp9uPFdl8b4MRL/CsEfGhdIMyUxJ7ltzHOnCS
 xVotrp2FAtBmr7D91+hzlDWZDp2lacbKalBpJF6Wad2x8IEfFCR3STeFIEonSPOKF0RdT8DwbLQ
 9S17mbuptW+V0cNKbIlyMt5E92DqP7VFsliRBwTSG8dw2415oKTjzSqNx0b6igFwq/9hrLobM1A
 M2MlRI1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260212

Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
core that implements the MIPI I3C Basic controller specification.
The IP Core is versioned following Semantic Versioning 2.0.0 and
ADI's open-source HDL guidelines for devicetree bindings and drivers.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 72 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2498672d2654888525120c44f4fb74d505535891
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
+description:
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
+      - description:
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

