Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D7303CA3;
	Wed, 27 Aug 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297564; cv=none; b=kgn14/oC0HdBDLTOmxfQdOoNQcacA1i/xFfOYMzlvHmnsfgBBs0I4hNNz9VSw3lRqpoYTSN5wK7FSdTyKSwbDy/JZx1djNfna2q/hfqYK5w047YVKgsq1nkmdG7W+IM5iMJFfPHhOSsuvrBqJa3b8wBhWXRkRaRyBmhIBZv1Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297564; c=relaxed/simple;
	bh=juN5SXBzGk5T122jBXFeEPh7Fo9Ytv7XvYPMM6KID7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HhS63m8KOYbhWh9up9Xf61UQS6Oe5r3qsv0lUl5C/tyxhCTsaEoGkNWRdcn54aW2n2aoV+pWD5COSq/mL8+cypuds0+qwy1TkMhe7zACd865NbdueEVDw/by1jHjxfgNGU8KyH132gN9Cfh7h39QgsgtSHhNI8qtzBpfKhNqAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UPxEJssL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UPxEJssL"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RA7m11018369;
	Wed, 27 Aug 2025 08:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=i0K3t
	mCU53Oueja8xrVMEWpQFkcIm/Fv3Oe9qspgYck=; b=UPxEJssL6lUmp29kSzzU6
	uOdS/LH2UQflH526sI6zJXzIXGbvq0iRve0RP4tp/aJHLAfl60wqQalOAZI6DGM4
	6VJiyV3a7z1KbuhOjCuzXJMq37XY8B+pFd3zgLpz3AIs3KsVyl4vd/wBYV5AF4Ie
	1Kg8YNe9WYFpyVDmBmA0tPhrEHTSAcxCM5loQqj+aBi0MRNT0QfoRIdM7uLtqP5R
	PTrkJl4OwvvhnW1pwTPXUp3jFo9GqcONWoAoAThHNmuI3BTYJdAi8mIJq+EQkZTi
	Tgg3g3uTpJDB1TKDzu4oSUu14FWDFKn6wVoOqVNZOHKLojWctiKV6JT3UlAvbd6i
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmafw4br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 08:25:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57RCPaPP052975
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Aug 2025 08:25:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 27 Aug
 2025 08:25:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 27 Aug 2025 08:25:36 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.69] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57RCPHoh002921;
	Wed, 27 Aug 2025 08:25:32 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 27 Aug 2025 14:25:17 +0200
Subject: [PATCH v8 1/2] dt-bindings: i3c: Add adi-i3c-master
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250827-adi-i3c-master-v8-1-0a7c78e58bd4@analog.com>
References: <20250827-adi-i3c-master-v8-0-0a7c78e58bd4@analog.com>
In-Reply-To: <20250827-adi-i3c-master-v8-0-0a7c78e58bd4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756297517; l=3377;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=juN5SXBzGk5T122jBXFeEPh7Fo9Ytv7XvYPMM6KID7Q=;
 b=vPJ9YtU6fxX5Pc8p2v8fjRviTMq8nQnv1W9S+Pwhswo61axRLhZ82zEfNE6SxIQWggkpRwvsY
 nrNtgHhTtLtCVH+MxAgvom/D95LLDDPqBZC/ZV2dH0wPco42l3n8Z+v
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX2R0Djnj54WPK
 4x0h3/MJTF6N6Hg9wL1NkyugTeg4Fyz8XgZUzApzZK7MvLca2rXRWZWiGMJ1zn8uTYftdKo4QH0
 I48yyMJ1eZbr/3iogGWeKN3GAwXCb5d+FFdPuYf+fRGcj6rO0f71D9L3uq7EL6lN+8qKQy+SwpZ
 rrIGxVzh+lGONCCtdSrc19H9MWIrwxJ7LQalQnd5bMnLuRq80IZCRkh3AOLyblmOno5ObnqrumU
 U4bjmzCddUPQH1UVnoe2RCRL8C+5QQgEjz/zlKWKWKfWmfP8IDOKV11AXTszB3y0fn959+U+NMN
 ZNdr3AlexmfJLJ50xchg0CWFxeAQx/9qj/Nq5v755fHOxVhStFiB4YP/784XlC9XneX5UpyCIxq
 4YCoiuFC
X-Proofpoint-ORIG-GUID: vjEFf5yehsyYOUZeaO4Vy_eWLKhfoTNf
X-Proofpoint-GUID: vjEFf5yehsyYOUZeaO4Vy_eWLKhfoTNf
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68aef941 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=wI1k2SEZAAAA:8
 a=gAnH3GRIAAAA:8 a=Br2UW1UjAAAA:8 a=cxqr8dddGolBAesk1vsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

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

