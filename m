Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18303A7593
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179238; cv=none; b=hm5g//m/I2DKQywQMuoKbG86T3BBg8Dwb0aiNj8G2Lhkv2AI9hbdEH4KMvVm/+blzmpx53Fhvi4bN8LVftzwdClOsw/Mnnh6VNJb/NsMIpDSjXn1HNviZFULSAHrTrm8J3sGmbYJewBTrO+K4DRIAS3GH45vve49Il2rcIWKqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179238; c=relaxed/simple;
	bh=Z6cS8aJK/HbBm0d7OT7Xq+/FQXVHHZKwWRt5CJiiGpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFmUL3LzHHIxr35tVZINd7c/dUrR+M71fVzPXvb23Eu0XTm/oQ/xcs4NqvhqHkjvnVjTy9sNYnaVPsOHUV5pAGtR4dkk4yHzbkwp5d2tY+H1+crpnS8vY3MYNDHXx+lddq/mwMwQWP4AbkFPi7tYG1LI6TpUMjmioVRGJfV/54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVMi0vfp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g4gjwnA+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVMi0vfp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4gjwnA+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDKgK3322189
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=; b=SVMi0vfpY6ftJGib
	Whf6TEHNuVhV8IJYYsM/inzioIIOF7WeZkw7gsOnAjM3iu5C9DKb645316JYMJxO
	kRptwVMxGyUbdqH6YGtSRx9qGZVp+dPYZOPNfgODKXMbM3tSx0vZtOfm0Odxm7Ak
	8XC4pGt5OVLHZSijuDMiIdXjKYtnQXFBSRs8cuh52CGuxQmNo7YLPZ0oyA0qTyMA
	tpoLYwGWAuttawCw71QKwtinjTGZ+0trXXzrUM2KhmZNl81zTBHAcASxfa4h0UwD
	ZSFRYFySCmA5aClXvKC6MvmNXabBZauDxujWonNQUnj1l6+x9bBFdtF2qzyzUPPC
	/WmUIg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjsgr14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:35 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c83007a11cso447050e0c.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790179235; x=1790784035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=g4gjwnA+2kj7QpUle2gsZrQwKWPzS86uR6WuFF7I51sEHtq3TNeXvLzF6wvKBN/9tx
         EX8stoSRicZZoa2zdELLw0nl8xkNvsIcRj8XIKdYG5JTLoa1rE7eyKA43kGxGBp9x9/s
         kzJMPGTuZsvhRGr8fUXCOcaidwegpcpt9viz661BK5O2+sMf+UqcuQf1EPoirowA+/S7
         Dsw1xp7k3SQ/WdmRIOyjlZfFlhzv+QTLwVxC5xtzT60WRxrAVBp36AamoKWuCohOHZ+w
         x6cgjPd4ateOdtqHspYgnwZTsG5YVtpBo/Fjx5Aie9GXEgWnqRuGmSu9/U8RJdpcFBeq
         MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179235; x=1790784035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=VzbpOUWe+lnG1n9vcsJLv3L7gDGw5M8a4Op62o/oh4ovsxP41ub1z2ZkuPrLL7FqTs
         nduOtV/RqaVmLg4Qn6MTf6jZdfICmm7NNMTdW40T+AF5ncIz30EO11JfCj0Gt0u0W62h
         UKvQEN9W9Q0dTefSjzvMGWxLP/v1kUceqUMk1MfPmGFis7dZONnXGUvgtfLSMNrsrKs6
         XLk4wcQrqSy0jCHyhI2taIknvOQJGWQJQxa/EzH7QUjKVD1wUwf5F2qBBid5BkA53lBC
         owSlZlKSjb9eRnnBGAdWAVIzlLH6/zSd5DL3XlAQZ43Ya7RAVDIqjwiC/u44YmiedZFr
         JsSQ==
X-Forwarded-Encrypted: i=1; AKwUvBw616rScRYIhcLQ4s+ST7AWxo4PsJTa28PZ8fLhnHMCjLayJQTjAn7XRFNeDkITLwTiK4o/SsDDRrG4Q5KXF+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lTaTjzhrQ9BXHZE6DlFi45UyZ65ffVSb38PPIJERj6XmVz4jBG
	o2o4hh934N3ZlC0JmRqn+REeMRBEA2oqLY9/Hb91W/HSd230I287sDU0i+iOj7YoHYVwnKyJOY/
	g7OoCfzuWVhsjol8mxm+NmoZK39BduJJJBTxW4h9yxQCTSdJ9N02O+0DNvDL9QCAZOfmlxgw=
X-Gm-Gg: AYBFou0YpVhdQWKNnOVChns6m7i34VDcLizadMs/tV1O/h0L4Z59KYZckJ381bGQJST
	m+09ffp/WB79oCjNFcAFzFJp05qOQrHqL7/X7rNscamWgQ40FnppfDZdQZ8VN3QTp0LRo3VfbU2
	lVmmWaA1lgABx6KS1HffRG2dVGSGCjnThgr+anctYX9bxsf0pw6mufpKJEm0d0y7A7a9c5L4eJh
	TRo2Yl9hGF0eP6HCNX9WV/7nc8zY5jFgv4ncSD8tpHZivWfTnwWqT4AzXp7h+BydRmLqJE79vZA
	3xQeTorB87kpDqbVcOcfetKdz0FUrEW1fA7HTB3O01kMlJOe2xvdYKWTrTs0SNzfR07CMNLkN09
	GCtucSt2xqT2KBlK/p6qqjK1MhIYMUiSbQy7wuPZi4aScqy0Zpnu85IUHpVhIkrnqcTEsdbK+3T
	pzPdVv8FF5WDTaSKsLudSEWkmiwDlwFCJocOh+KTDolPvuBCeIHjw=
X-Received: by 2002:a05:6122:3a14:b0:5c9:a610:cecf with SMTP id 71dfb90a1353d-5c9f16bb4e2mr3557806e0c.22.1790179234764;
        Wed, 23 Sep 2026 09:00:34 -0700 (PDT)
X-Received: by 2002:a05:6122:3a14:b0:5c9:a610:cecf with SMTP id 71dfb90a1353d-5c9f16bb4e2mr3557461e0c.22.1790179233095;
        Wed, 23 Sep 2026 09:00:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm80739325e9.7.2026.09.23.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:00:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:00:23 +0200
Subject: [PATCH v9 2/9] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-camss-isp-ope-v9-2-86a75dc18b83@oss.qualcomm.com>
References: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
In-Reply-To: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX8tTHnKECpmvo
 enUuk9j3EJT2apA1mUCRSZagylGgHEwd7FrIneaRuQ4BoJ9ns/HdvFo2NEayh4kqd6OGr3f2Zm+
 X1svNmisYyO4hrabebHSYszEcu/MHviN1MS/AQiNmto6+kwdzD3t18FDsQznyLfy8H/XQGFVzLZ
 Mhj7SHlwTZ1Dpk8WjkGMGzaVVgLsWDQsFdks2amzaR7pn6A2wVEVChnOHsUJSW98PVlKzmpVnOj
 S45KA+Xx+cjKPm4dmHWNRo6sMhMnl6LW9JKHyprt6V8uvmDPWRFoA5VzKuepJ+/fI/0lvuF85Pw
 1kvAVy0GnOJ+H/+m7uOGKtHspj7kW4ITyigWnkIsL20mHQzhgNAhJd7ZD8+ZdxVs0gxvSoZHCSS
 Hz8HOGbkDdXsL/J2c2EDzSUFRhl5Bv5LlF8tjtd34mGuPTg1rKBj9j90UvX7tSCjGSSgqdwFrN/
 CL3n8OaEROEpIeUOLpw==
X-Proofpoint-GUID: XQq0RZpoA6D4XHlUe8Fsgi16daXWH_S2
X-Proofpoint-ORIG-GUID: XQq0RZpoA6D4XHlUe8Fsgi16daXWH_S2
X-Authority-Analysis: v=2.4 cv=K4+3jCWI c=1 sm=1 tr=0 ts=6ab3f7a3 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX7akEyR9xw/2n
 sZW1PGWkFk0uVcS8jXYqQsu1JYkAHam998JcoLQcvuOhQX8etB3eFY1Pcv3wOMmpZbNUlzwZ6Re
 aES6AAhThAHxtTQPPXG4rZ2Esax4CSk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230063

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

