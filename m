Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D723AB28F
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459874; cv=none; b=lmC+RyN/EQuu6su6KqZrjWkqaWntpf0y+nirik93A1Z63F2HCKksx5VPQs4nfBtjXXLt9wn2i/pVxH+B4Kn5vPzRmDQ277X1ukfbXPpf1nudeGrrlP5ZsvMqEhvhd5wu0218TPlmLfyv54M5XQr6zPZ/c7NziKLVkPfCr2XEVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459874; c=relaxed/simple;
	bh=Z6cS8aJK/HbBm0d7OT7Xq+/FQXVHHZKwWRt5CJiiGpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcYwMRe6sTfvFj5SXTx0fdp4LRVUlS3W4eT9wmUIQTQmqKTLgR92AC5CNYp3H89NNvm+p+9r6o2LCpDdx6+8kUUuDOderTdS5AoFkH+u4VegdLpzdC0cD+O/CL7XmGBrqqh+lmBfPP6R2MPCQ5LN+DAEeCtCmRLkVhHh9ThFHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nKX10Ys+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gLSAJ5rv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKX10Ys+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gLSAJ5rv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZBoZ2983706
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 08:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=; b=nKX10Ys+WXtgZEky
	aNm0qUs3q2jb0QImk6qA67WoHx/eMre6W0OmGTWzYbxHP7xdAd7Pz7X084aeHVDy
	VwbiCbjAiGTov3Rdv12DM+i9kWk3EI47KxEKBGZGcmRr+eCyR8DFlx6Vsuzu/ecz
	XJ2yTr95W14fKJZS2UJQqUilJzszsrVumUxxo1qL+CAGQxumMuTIafDIS+Vz7kRf
	9KTArW2Wbq4SUIZyR+DpF77TXfH/BmrMIMGE5hd9ih/grNpr24iaDJLOkUj4Yjg0
	v1JP+vNFrBdjfvzgsOqmY4dWeaxmCKJhH8PKybuYjFvEmY3wXCsjBGu7w8VamypJ
	4MNQdw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet375u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 08:11:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e8dd8be81so54976136d6.0
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789459870; x=1790064670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=gLSAJ5rvmwIglFD9EG1hYthmJuXIjIboO7q7QS2PQURmTv95Ckd9t/1OTzh/ri47Zo
         CbDBwF0i2BOUJU6mSt8bcN6h6DWPsh3hOLDhvn+OQ7WOsM+OdXn3njUYO268JVG3j1Q+
         HKCSkZVoJ/I+PLsWZ0pcJqK9bJRwYZvyJLGd+w0Pa13ZrFvwL3OKGcdKYwxFJ99F3VAt
         dEAaTBdwP+5X0ANmpFILR8e2VqJT3/GWs+JtfUfQlUs41FhuSHUaF7gdS7Iak+lSc4RN
         Li7yB+Etnh4V0mkuFV/UdCJV8Focxl+CWS/ZoRG8VAWjjqT72VRSownPFSr5mACLdwDf
         JzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459870; x=1790064670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=Dxldhtq+isHuf6AmMUvtxEXw6P1l5hrF8mhptQ/ZgdTu9Y9vOWvQyMpR6wnZ6cP2Z6
         CD4n7Mw8LiFOq6YCQxZTKZD6F7XOpEkTM0KjtE7iscfZAcn+3StIiW2iT50bcNFOmjkt
         NciSR+Wvf+L4qnXZjoqv+sCNIQ+pCDFEPKR60gJ/fOo37AzjGZ/lCmMVj3UsIs6lhaDp
         Ow+JYsbjNuP4ovO6peWitf+oWWhXKmGXQvThddm0ge4nwkw/25bh7ladK6aDmisOaXSu
         L+j3wJQNjWdK6mRWDLPWHi+aOJXKim9A35fz0wEfqBfa1i8tlE3AcTo5GC/pnJ9Ebp1E
         rZ3A==
X-Forwarded-Encrypted: i=1; AKwUvBwnB5aKYgMxqmuqyD2aVY/HXiVAYxMh7xgaUwUAhcJjh5P2NN49xlH54sNvj1oIbUj0b46Wd9bYqeRJiXfp5vo=@vger.kernel.org
X-Gm-Message-State: AFuF++n+RlVLNQeD4QDVhMoA/xFXlxc+D5g6VLrjj2MfPXqxECKokMS7
	4bJLVELyunG9SKu9RYsOvmuP4HXhQUKVqwBXkusfMVL2hI7sZ/HuuS2IJBBhQ2TPqdE2k8ME2Ph
	xm6Y/y/BuRpXsaSHys+krds/CGfbFvTgWH68a0SVk09i4BhxFmzGKqzmyzmMGCtLXohlS1TY=
X-Gm-Gg: AYBFou3TmtaChhMpCuTJ1gslsjYCkHaGl61Q+ZdyXKu9ikPLCAFv061O36DYbOyCVlm
	1eGrqGzLqnDXQ1qqu+qiBada5g+ggzPqQIEmSqTAl05s056lHkdubtZHlCVrhIU/C6yWxu8dFrK
	Lt3YRozO+m74+CWaaH1CIIPHOj93h3/uOEbxfGmN1I2Q38lI5SA/33b8azlrL9hLirSpe68VWbZ
	pE82Iuj65+10kmxQEVcbzDJyvQxg1EEjXr/dx1Dch5N5xvGiEpqiNDqxtiYZVEo05xc2qKsrIkF
	a2rn5IXVAox9xIj3CbHgATd11T2rVdzwTYRrdRlfMm1xcz8xBUWZ4eN4qYjSNoaTBT/YllVyBr9
	8GP5kiRJ1P96sJ5Upc6DRkuRe4qC+TsOlnCLFvuwIXOdqVhS6+9hLyvPpj8zrBZnTTiWNFCS/hL
	WMKU2MAz5rRQ25NbimUTijznveqTyrV7i/dQn1rCy/8Fm/CpT1Ft8=
X-Received: by 2002:a05:620a:4481:b0:937:675e:2903 with SMTP id af79cd13be357-93a29839ca8mr908876485a.14.1789459870092;
        Tue, 15 Sep 2026 01:11:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4481:b0:937:675e:2903 with SMTP id af79cd13be357-93a29839ca8mr908871185a.14.1789459869528;
        Tue, 15 Sep 2026 01:11:09 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:7034:b557:872c:5602])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d292d3csm48847885e9.4.2026.09.15.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:11:08 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:11:05 +0200
Subject: [PATCH v7 2/9] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-camss-isp-ope-v7-2-77b13d131d3d@oss.qualcomm.com>
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
In-Reply-To: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDExNiBTYWx0ZWRfX9h0kMmdHGOTQ
 cHMOfMKJUXMTVld9hzfpZasFHrZVzEhXHsZ0B+gzn44PzGtiKkyVNrNH0Z9a9POBIko7mcxVMON
 UsCteNdSAACRt4C5Y2G2HdJIeErQ1TU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDExNiBTYWx0ZWRfXxFU5xdScr577
 iPJhMH8k/mnO0D3llkFdC9TzIcgO5nqbYCxrkNEBD6YZYVNhH78jirlwz3YJdOw75fxJaTvNRyt
 PmTGSqSTTh/XUyFXOIJ4/BkNGZ84tLZB0Va/UB8NtFHQEWv2N67xoCWdr99pPN/yy5l7Icp0Zzc
 cMwqSMFYWy2Tvqnm0v/6RUoWViB2UDh5vmYoaInir8gUjTECBUQzpTRKQX5gVZ7Fje1KgrZNfU3
 U8UasDNgFAywFOtPe6B0L0In9Hc5Q0Em5iJlYqoRoJUhWH8bwlGt434QBFsCVbAm4wMqbi9u2lv
 En3ulgR7X9c+H8DFEWE5BTn6TZ/AAo4iGVXGDX0K7Kp8qBW7QvGN7LWQVjITyu0B4bbz9HA4h7S
 OE+a9ZldTg0RoMvO3L20st80irtU2zBkrwG0S+rP+0X8CN7NjKIdkbRaQvzGiMbTw+c74AsssZb
 tmTXDNoLN6mDA2nub/Q==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa8fd9f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: vNtEdUi23tXi9wvXWzIZKUC-JmSPehiA
X-Proofpoint-ORIG-GUID: vNtEdUi23tXi9wvXWzIZKUC-JmSPehiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150116

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

