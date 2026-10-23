Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768190;
	b=NfJGJcTmApruqOmTpNVkDaxI81c0XGFYrb77MkZ41WlKzrEI76DeU/UaC8zg9u7wC0HU
	 8zVlGvLwtlW1p8v5yDnvbfmApTmEQC+hSy1Ra5HEA5V/4ay68RddPDAD+6cqmXyNW0aul
	 psdSeUPahRHZdBlFgNoyGVh5wCHY/X/APGF7LzS/AUgUIqxMjHE4EvMLuDAFwqyeSGLTs
	 XmhhMKpXRifDVAw4SEel0gbSmwO6T5D7CyJGpvlWZfaIIL5kGiNQX7oAlHwMDjQjxUO7M
	 ZThfK/1CNCQrODbHDVm4dxkNAHjiLpDdxEfB3S6CnDgegXhTgeU3zP6fmdpbokUy0MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
	b=OTLC3Uq/Grmji0/TfTuGsEDNSvicPAgNSLA7gDZwaKXoUFKVOa3eJ+imN36QZglBMW7g
	 I6LsidcKRMcfdaK3HyqRc9bKminURnRc5mvmujSkDKMqQUwfikg07oi7kDsWaKOgnS5nx
	 4ibEhPhLSefPF0BLBPxzvNWm+/7lAZtIz79O4mLeZZOLV+f5yP2cog0GpMC3Ga20Jxhj6
	 rWQCeD5134KkEXeGJOEzVvUp94fTmDPWww+A45igwacO748PQYwRYDnaQec7e21bcMU8N
	 go8IxOrwWAPB3JDE3HJGHAYhiUUHd5QIfLi0+55pD+Gx1LdOcICwbLmWXhFtiImiAkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NZGBaYEI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e6YrW8XB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8F606A323
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F8F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NZGBaYEI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e6YrW8XB
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE7MBb3482016
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=; b=NZGBaYEIXE0N1yD1
	D2c0Z9sI5DPzXOPxazuibbY3cewSAgRt3Z2XcH8HuLNR9IWzayhD3kYeY1PMNk7x
	rn7G0PMp+Jk2FIUpHSZIx1V2GdfleFpEoRisY7M3Jess6mFtjzA+OVC60ulJ1qMK
	T2mHfIZZNu+Vt+TB80uaW4FZ90aLZZwryB11ZIqUx658pbmKjWSYMrB51pImh9CH
	FiP6ZTqorHJHE4rsVHJX7iDJxhADRvnQB6m7A3bZAlnMu8LPZe0pwmiZJcCUgA9J
	E+OB6rv93zZ0dMyEhTJirgiN4+FOXK2yEmyFV/VIyNnQspqAwArp4VlG71p/MKqw
	//t9Kg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0mrpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f559420f3so99920585a.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768178; x=1793372978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=e6YrW8XBLzztTWtNFawQUtE6I5GotyiaTGqKVZUACA2LZrmCBy/pfKBQVsnGSD/7cA
         pIbXVukXwXML/myQ/h1a09nzYgW+rYgtfkphk/9gYn5fiAB58e2f6DRHTrsDWgXmqg+U
         ikWQ0OZmBdjJw50p1NDz5Su6ITCaRs8ttSuddYwHvQLE2HggCPV1P5T+pcKdJzquSzNE
         N0B+HdLwwrcJ253+Jt/jxZzAyJ33jkmOjNc2t7mVdQVbpmIry5K7OLjZS2CYJIkhmAKa
         0HetEB/rWuHym2B8u6yRtCFBzfKsbad9XtyPnFHYf1gz99EzdIxRiWHxa8qFvKmamjhI
         ITBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768178; x=1793372978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=g//Bpl+gtykPAwgx/jDYGjb/XfkqU5M8m2zbHn1oZusPc7cHQvfQkRl4kD8VoW4l3h
         k+VqQWymOL0mO397DpfBCe0qusnzmIF8RJJIaH4R/nj0O8vSpjDTFTdVJ187DPfFC/Hd
         QgQNjRTRDz8S/t5wA3O6Z9L9FmkVBRHpA1rydJxyUbprMpRM4G9/yrVuPalo+VUb7n+z
         zwg4mJjc3srbO9aqOcMv4I+yXoBrIpMQ6AYZyW3zYymDT4Zkpt98G43c0e1m9OvkQePi
         jrgOBRFdGiLCXvnMeS/MunHlcYDOiLc122/kldSGpw/nuvwRUAt2NpHhIw61vfM9mX09
         zgvA==
X-Forwarded-Encrypted: i=1; AKwUvBysVPFRAWzIuMNhhjhN3tDeTn8cHEa81E0sfhQCpGbQkJ0SJlDvE7VBy2vYig0KYxdmi1N4Wvtlfzu0HfpEkNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK//sS53hv3qqITn04gdQd1/rbzueMBxUjyzx4rVl8u0B0bDQxX
	agSBdrcp8nPxo5G/Hdv8K541fe97ppKePA7h7oCDqslnJie7ZErOq1r7UZ96VOtptHtrU4G4ClW
	woYggWvUZ92GWT7/+q9G9/AwXbvtwJ1G2qVgbWtbG6l8WSfsUyRLi7qZ7Zpi2zpJbjFa2gLU=
X-Gm-Gg: AYBFou1MqFkP9aWnt4ENuLq7MWkkGCbUWpWS4TjCwSodFNU0z1gLi7jGQBiUF1MYMF5
	Ci7n1A0rvR9+8qYb9LSJbfRJufPpRHF1fgMKRUxYtnYRyNk4PUOeab4OuxecoLKPolwkQh0uIjI
	q8YzzR3igcIjBXA10Yw//Bb3Gw38uQzIyD+UMcefDjKJ2UnmViXUi9K64/29yguiTc/XIDY8GE/
	eyi2pPPmmjqdyXbxMOqqMWlpkdQglHg+S77DAt/T+I1fUQYEXmISBWVGaVhMuvkooj/2NE+qhAN
	tqp5dBdDf5P/7Ae889UdfsgZ1up4r5Wa5yz3BLG79HNkMzS1TilQ0q+tncy0Rt5NVimvUA+2OEy
	mnMnwTpGVx7nMHX3VeuiEkXDaTakPQanHx7NwHR8IgvYRocttRl2wQDmWgMzaZ1FnlFRnIfOtXP
	LdUAXio+2AzdVZh0MC1nO5Ba5d8o1JhAoaqtzaqylspEuVrMTQ48I=
X-Received: by 2002:a05:620a:4712:b0:93f:34c9:9259 with SMTP id af79cd13be357-93f6f9a2222mr463351985a.50.1792768178233;
        Fri, 23 Oct 2026 08:09:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4712:b0:93f:34c9:9259 with SMTP id af79cd13be357-93f6f9a2222mr463341585a.50.1792768177528;
        Fri, 23 Oct 2026 08:09:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4040d3sm323962f8f.27.2026.10.23.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:09:13 +0200
Subject: [PATCH v11 2/9] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
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
Message-Id: <20261023-camss-isp-ope-v11-2-0c2937195298@oss.qualcomm.com>
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
In-Reply-To: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: GB4RVg1WYllM58IwS9aAHwocpvEMKF2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX7CUHyQXt2G5z
 sZzP7b8il18zFxXsBkPBzSskdAkWs7YE6TXrBHwffK5mcIx0dvbzDk3xzDzxVUrlQzoKAqtmYPI
 0xierWP8uifM9IQi/lBXMytycLZ4xCzywHktagYJx/h6SLo+ggoRn7ZLtIUexzx8Y4ZPtfxNzDD
 nLGpgi8uv0Vy/EoSnTMxrECnZ9E2jeaCxWG8pGhAFtFnwWZ5vLK7h7kXljxOaFQzteFlBqAod4j
 ZGbIvvik5O0BcYsgaa+eHYagPWoCWW0TvV5dERVRRvQZTrA19I0TD24VCBb4T+vJJK/DJGXbJ/8
 9m5N88a2P9IVTFaiSm+FMhw21T3sCtlOSOcldk5F6wBgKHplJBmFufCaKUOS5kwhRbyTMsGBA0j
 LD069Q5osrOUEd40U5oHLCmQhg977SJdDvmRMnJVfrahu9iEjd8oQVeOnS52NQCcKIrv0XFZrXj
 GsxSKSUWT0rqlwCjkAA==
X-Proofpoint-GUID: GB4RVg1WYllM58IwS9aAHwocpvEMKF2n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXwWo5FMkKsVe1
 AfzX/TMcsYdJUAiL6wcJnNf92siJ89f2ufO5NubUdoXykiXD5p5XTJf4NBAfBiHfsc3oI9XInYv
 4WvpudEMrJnK54O4BmiVM4imltWLEEA=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb78b3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059

Add Devicetree binding documentation for the Qualcomm Camera Subsystem
Offline Processing Engine (OPE) found on platforms such as Agatti.
The OPE is a memory-to-memory image processing block which operates
on frames read from and written back to system memory.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../bindings/media/qcom,qcm2290-camss-ope.yaml     | 151 +++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f9c31bc88e94b028c241060bbd8e56e0bdc49af5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,qcm2290-camss-ope.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Subsystem Offline Processing Engine
+
+maintainers:
+  - Loic Poulain <loic.poulain@oss.qualcomm.com>
+
+description:
+  The Qualcomm Camera Subsystem (CAMSS) Offline Processing Engine (OPE)
+  is a memory-to-memory image processing block. It supports a range of
+  pixel-processing operations such as scaling, cropping, gain adjustments,
+  white-balancing, and various format conversions. The OPE does not
+  interface directly with image sensors, instead, it processes frames
+  sourced from and written back to system memory.
+
+properties:
+  compatible:
+    const: qcom,qcm2290-camss-ope
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    items:
+      - const: cdm
+      - const: top
+      - const: qos
+      - const: pipeline
+      - const: bus_read
+      - const: bus_write
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: axi
+      - const: core
+      - const: iface
+      - const: nrt
+      - const: top
+
+  interrupts:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: config
+      - const: data
+
+  iommus:
+    items:
+      - description: OPE CDM (Configuration DMA) port.
+      - description: OPE read (fetch engine) port.
+      - description: OPE write (write engine) port.
+
+  operating-points-v2: true
+
+  opp-table:
+    type: object
+
+  power-domains:
+    items:
+      - description: GDSC CAMSS Block, Global Distributed Switch Controller.
+      - description: CX power domain.
+
+  power-domain-names:
+    items:
+      - const: camss
+      - const: cx
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interconnects
+  - interconnect-names
+  - iommus
+  - power-domains
+  - power-domain-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+    #include <dt-bindings/interconnect/qcom,qcm2290.h>
+    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    camss_ope: isp@5c42000 {
+        compatible = "qcom,qcm2290-camss-ope";
+
+        reg = <0x5c42000 0x400>,
+              <0x5c42400 0x200>,
+              <0x5c42600 0x200>,
+              <0x5c42800 0x4400>,
+              <0x5c46c00 0x190>,
+              <0x5c46d90 0xa00>;
+        reg-names = "cdm", "top", "qos", "pipeline",
+                    "bus_read", "bus_write";
+
+        clocks = <&gcc GCC_CAMSS_AXI_CLK>,
+                 <&gcc GCC_CAMSS_OPE_CLK>,
+                 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
+                 <&gcc GCC_CAMSS_NRT_AXI_CLK>,
+                 <&gcc GCC_CAMSS_TOP_AHB_CLK>;
+        clock-names = "axi", "core", "iface", "nrt", "top";
+
+        interrupts = <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>;
+
+        interconnects = <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+                         &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
+                        <&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
+                         &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+        interconnect-names = "config", "data";
+
+        iommus = <&apps_smmu 0x800 0x0>,
+                 <&apps_smmu 0x820 0x0>,
+                 <&apps_smmu 0x840 0x0>;
+
+        operating-points-v2 = <&ope_opp_table>;
+        power-domains = <&gcc GCC_CAMSS_TOP_GDSC>,
+                         <&rpmpd QCM2290_VDDCX>;
+        power-domain-names = "camss", "cx";
+
+        ope_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-200000000 {
+                opp-hz = /bits/ 64 <200000000>;
+                required-opps = <&rpmpd_opp_svs>;
+            };
+
+            opp-465000000 {
+                opp-hz = /bits/ 64 <465000000>;
+                required-opps = <&rpmpd_opp_nom>;
+            };
+        };
+    };

-- 
2.34.1

