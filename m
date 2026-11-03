Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736372;
	b=RYW8BzbJTNQvjjbFinxynhJyYwVjlGbzsQfHC+WFHd6dqcLjjBTLWkLUuoquHsL7ykLE
	 3Ep0gsV6Rc2LrpTqAkeBSnMrkm4VrsZLUOmXKqaT7kIrhNDNChYIBHrIM5FXTvAKmYCXq
	 pHfVquuwS/GOUjumXYGITcpxNRhb1V85p7xG7r2Xh9AmRaIg6Y4qnNshVU6pW0j/xutJi
	 43IJ9rHybVHdxoxiIGNernrZEgx1I6EeUfWrlMG94NEGwkkw2g+hzGG1rgOOcqCZU1ciz
	 8I1DY4v2KTDDkMyKM1RFkSX1xew74fDpwrM3TThdF8GJ8hcBVc//UUqOeDJWDt32/cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736372;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
	b=SpnclnvcgKu30d4X2hJOCgjR00uV99Eye1v4+gRVO6WlnsVmIBAg/35rE7ba1zgaJqp1
	 Lb3XPqwdoxS9EqC0w8VWWrgv2dUcBWeAKi4A5TF9xA3BbyrTYhkMED3HmCmrYk5DcLvJg
	 P1iiDFei6XhkTIOFcTzOi2FFG+uYQl+Hxzp3ZW5Lj0cP1y771KL6Xil2CLU66ohBBgC7X
	 FOrWt3jZ+7C2zsI+lfh53jaboKG2DksDaCRi/RcH2Nls5aM0bPcx+m1dhPVRmtn53rkJ8
	 +0IF3O/2REysnJ709IoquMe7DqGM1g2zdlvDCvauh9zldffCYTZNExxkWC/iG6f4zZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JGdEkNDH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NGUUTUKR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D8606A33E
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 028D8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JGdEkNDH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NGUUTUKR
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZ8Vt445641
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=; b=JGdEkNDHLQfE3n05
	rV1gXVqqthXZL0g63tjtvD8mQDaOjhtSC4DqhHtws2l1rzoH5Lf2GwZuSEgyNIJd
	EGBofOiK4F5+U+zyVidg/hlyJqFVjN5MJ4xdGZJWQK6zIPg52N+iLaeJ++dXRRw/
	H8JO2yJ6Do/QI9i//nNhb18WjdrPB0F/7wV+1dX9wD6RDFWjAsqf5J3PO1xnlYKr
	KzlC8AjMViZf898NaXkZVl9RD1jMa2Qvig4VHnqRHN7rJBmu+FX52iJeR8dEJhXq
	SqcCbqkE8UtQ5KlBgKXccx+q76B6+chIGutG3uppRiB/iKWoZKi4rbtyyqOuCiQF
	B7j//Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pgmnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:05:56 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99062be02ddso606368241.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736355; x=1794341155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=NGUUTUKRZNBf3dSdVwi7rT2zYA8bL8+42INiMbI/SZG/dn/CBmajUP9zOcHkP46oiH
         RiqjW8gc33t0mBQ0lhmVAtDDjtVz5Pq6c3AlqI/AmGfLTvch4TnQZzdzaa1Flc5RzvZc
         BVCQjPHtXApz/IrXf/EuD5ojwIsWhaFGr8kmCxvSDmPdCHm4E3V0xB0SAKYK32YdMWsx
         /IF8qM5O/kBOB2lpUCI1iOUJJSyJo4OTZlEV1b2RWAzewNMPh16uUOWEwBAsz1doICSE
         KIbubIehKU2qmZWeKik1iyYf7hhRpppgn7lNCS8Aja4Oe+w0j1FaCq45T9ReycQHKAlw
         s3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736355; x=1794341155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=CGR8LP9D7B6wUmTklbtQLciBVlsIqdl3o5c0qomMttKBe591izd21X7PWzRruyHrbe
         qh3vl1DF1J/GcTbLeUdmly9ChQ9di4kB615h6+2k93d5RJJLZEvaDIsJBLz6rhdFLfG2
         ZO0fjruCdq1LwETQfdG7TItCp9Dnw5Q11l1Nm8GsKNErkd0on2yBLh0cT1cw8ozrx41Y
         hVxZpeqBRbW37ThgHYwgZi29e9zeqxjcLYXpUcZGbePh6T2jFKf3Vg6YSZBrXOKwAgC2
         CtOyCDLV92xmyoyrBKHvgU4nghGj0dHpSCc+2rZXaSdhYX84Y9ifSwP3riGsjCGYEPPY
         Y58A==
X-Forwarded-Encrypted: i=1; AKwUvByReO3jnJ+p9s1hVbvTzC8F5daJhBQbb+Fjtqo8YLz5KiGaZ1UlkK4sPKWOLcAawLWd75M+0lBozBf10wAGR8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2z2CGHev36dU+y1gh+caMs3OF7k9DxnqNiLL1BI7OsSssQKei
	n22miAbq1+QFgYaVo5xbbrymwLL7iJ8IrOllO92CJ+eumPpQ7+Wms4R2nt4kBn0akB2hkXgBE0H
	9arV5XsKTzgEesOzbBEYH8+PLnZaqd80yHGIP87T945WFUGcH+o6rlleGiaRCYlcfwdZakPk=
X-Gm-Gg: AYBFou3V8p55RJioU/CEwPYM5wZSLX4P1lgtFicR+lwUkLaD/2CxTTigK89G4zA/PYn
	UvycJns5gylyLEhTC3icCID7ZU2NEWZRo+DYIPjRM3LwiUxUWXFepUoh7iKc3dYCCwIp1nrLOBo
	NAh+tSiAlc5QBIUEJmG7jMmj1Za+7DP0xbzXFM1syt7xvSiG+QbK9fDX4OHC5FTqLj84uj+xjTU
	plhMdSUBqmUcbD/F9/hKemMg8yVI9t+tXZ+8R14B8ajyKPBlOn9dNPSDTbW3tcqUnuJKQGBwLCH
	OHZoXbybFI8SJetfupkapQ62eC/UPkxeJhsma0mS04cv6g5sFDSsxB9hXIszzRc0rIKu0KrcjaH
	0o4y060F2F2ThNwgzQVBmhlXECYgTcZi/2zY2JbzIZ/a7Bn1o5AA1OhPUPluy08avmfxa49IUZi
	ZERFs5Le9wfyGgmSKBjUBneQFX4C0Vav8xoF5ceiZA2gAbtwgsNXiZpcdFWh6iY5Ru33e47+Txq
	FODY44iZigQTfWfmdwOTVRKrEBU
X-Received: by 2002:a05:6102:290c:b0:7cc:2152:4f72 with SMTP id ada2fe7eead31-7d072238fc7mr5124531137.1.1793736355028;
        Tue, 03 Nov 2026 12:05:55 -0800 (PST)
X-Received: by 2002:a05:6102:290c:b0:7cc:2152:4f72 with SMTP id ada2fe7eead31-7d072238fc7mr5124518137.1.1793736354436;
        Tue, 03 Nov 2026 12:05:54 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:05:53 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:46 +0100
Subject: [PATCH v13 2/9] dt-bindings: media: qcom: Add CAMSS Offline
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
Message-Id: <20261103-camss-isp-ope-v13-2-c2cbf15a39b1@oss.qualcomm.com>
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
In-Reply-To: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX0WuLrXXNxuLP
 /IcrVrSX0mfTKMwyABTY0TPLSBaOmrh2b2MyAocsrbODtrTcGPF0TsTaceRR2RcqJbkp/Jfp0H3
 iYrZ6pcbPLG98zz8wGel7NapLixS+dzrRZw/B2DP6eagYIRVF9tzgMhlT5as5++937B+uu2hGov
 /zQCUeDIO8cbVpUsC8Ys7/MkgXdNYvEGVxXcOWAd1sbHcUDsjOXvh+L0ssajhbkWE8nsqc93Ix6
 TtVf78G9DJPGQhLx8QcH4rwIz8FRRPuPuF5QRCYZR/hZX0wX3czYlhzA79k9c4sXqFTUy9K0bqB
 miZXV5PvpsSpa64BlXxSCLjJeXoLtr6ui/Dl1Nr5o+pdn4I/yxyvBiGVGGE6ZGiYWA331vFieTS
 MXIP6Habjo6AVm4sru8FV2qaqH8EHtEXH9O7j6VbzJyy32ycaAa+39tSOXFRvqDlnik4oYkq45Q
 UrzU+/NP6EBqe7Dy6eQ==
X-Proofpoint-GUID: GewYVD8_g61GD5SI3QsqKoWy9K-Nmme3
X-Proofpoint-ORIG-GUID: GewYVD8_g61GD5SI3QsqKoWy9K-Nmme3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXyCH12Zovca4v
 dKzDVRBOG4XV3nq3ct0O8fEaSz4qh6j90iDX/Pbg70IHT3ph5IW0ZvknGSyGX4S1mF5FPSMARU8
 CFmzGwePUJw4ZeyysZThFBz5FID5Atc=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea3ea4 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030080

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

