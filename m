Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFA3DA5DC
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674305; cv=none; b=UNE22QPTBPCZQt3hEGU3UfiO6s3GdGLdSCyzbJp2yBnAyxUp/GfZQ6mlIKG6mXXLcU5S9jDNI/sH6Igrkw/QTJSy8jnFVRzqlbJvoQkShKLQ9d/9vh8PKELNcYNONBTVukJAeYj4xZ2QQ8FQEw7emP8Qzer46aT+krotDeLaTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674305; c=relaxed/simple;
	bh=LkFnGFAWssGPIbolVdpYF874p9uyyDT0NSK2OsrJn1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIDhNjSbT0Yoq5R3kp7zu0hHMy508RpJP3rDhJVM9BLJdeDw8FPS5tKHHENKeNVsrb5ozrgba5DoWh2a2sfJynYNUU4XYesl5HsBlJ8wvq+aMdtwYb1k0LzkcsfklIJsw6rQK3aVOOLXWS+6thguilLm5tAme7Aatk7CHB8iPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mwSt09Iz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HAym3anZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mwSt09Iz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HAym3anZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dbLb140919
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kJoazphX4WE+SBI8eVQ4A5Wnlq+yoJNtNK+pdddGKWQ=; b=mwSt09IzPnNNl5TW
	WhAA/t5I8Bq7dJsk83S6TeAHUlzRb4hg72tsGMPvuhfvByTdPQAaMkAqpLfPqduZ
	VlG3P4PDwj9oKIZUBSbekhOo7Uk+Zoi7Cj4l3mbg78n0P2XF/u2foj6+bwGBczMK
	3jsyrxjiN1Xoo0Azyt3C8upGzOtJvpInXAstG4FkGMzXb8qm1ylLVPDLEALPH5A4
	4ZSngC1VzHNmIi/+zKkqhcyDuEQDSdJWnCkJT/JYzFpvmmzD/LvU/3uEdqNhgCO7
	FjN9+UU0OYW0CR0SvR/ts30sx+Hw/uKffYlSvbKZ3dw59rTdugmdtZx07u1J/Q1D
	FMrgpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpm8v7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so6880381cf.2
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674301; x=1784279101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJoazphX4WE+SBI8eVQ4A5Wnlq+yoJNtNK+pdddGKWQ=;
        b=HAym3anZIzCt/7LCqz0juTlrafRarEow98naC2vrtJFHg7c9PJcsGZeX0uKyaNrUy1
         ZFwDGGdh3Pk3P2bjEk0k2ztCkfT+w9HeaMOR0KS/aCV/hrq++X9Z6qrgLnA2njmG85yb
         8IsRaFa0EBBPyJLGbrLNce8hMZ3FD2tJDlP50hrCHFaUuBoTCjIPkCWxzYC9GQ7hjW+R
         tDM8lb6BFyHwEL1kJBG7tH5NmaE8gYPsCy/tlCoUJzwye8sFAPtb4J9KYMPLDzrcnumb
         8b7FJgEBOBLy+w6DU5N9e/Cnhi0o1sBgcWzUohYVJSPRq6xrCxHnygMQyHOfReq5yoVR
         rA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674301; x=1784279101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJoazphX4WE+SBI8eVQ4A5Wnlq+yoJNtNK+pdddGKWQ=;
        b=duAU3eW3wWo1dGTBfIIsI5CtZRa3NXrzuRw2Mja05qw0LTiDCVoAwa8Jsq5dG1F6Vz
         ClY1sg2d0Xo/oyVWEfCV0vGU12dvuF09onF62voRNjepIP11/xUMedQnKtCmQDjU6DoE
         ZJBNOHhwdJ/on/5oi2SXBiqRxLuQ7iisFxnP6cUcDHbjPCIYjLPjvJCzfyO1EU7q8FAQ
         9B0eaMLvxnVdVUtaz/ARb1YyrBlpJVAWmOjQtr7Kw6Qr2Ztm+8P1uAt+IQC33HI1Lunz
         eo1/IvuFpYTv2YUD7wU0/clbBHTsd6qXqIxiEDW0FiY6Bdwb092+6Ku6VpnpyVIxPHWl
         78uQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqd2nq63x9KvA5ImrH4ORDWAyLqc2qqkQB7HrMlPScnu5BSE+90gXe4AWRYpHJwq7uGO1j6la9rzjDe0EaM/JE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8N1HYmSFI9GNjln5eEKaVaus+JnvbvX17zgQz8QdjpV6Xe6KH
	tjmFeL8bsRTVqwywFyqd6r9sehoXgd74OJxcRjuWj0etf/eS5u3fSlXZAA9+aHKLLQ4Nx/ToNPx
	KRoD3E65qgNnCRdRkvuVkuiKywaqwInAV8Z0n3qgKBlLsu07PLMiwgi+ydeQ3/VkA+mYpiHM=
X-Gm-Gg: AfdE7clp7jD2KGI6AnE4Of2RF2YXglCAUZzlpvm5UFeHX+F9jN0y0KFc+I96YtR8w47
	8IbHnUPwf/Pn0lTP9Lsew3Vqi0RZr0QqOiy4LWCECQDYKkmi+TsP4XNuRSjqkKFdxIlRShdY5Mo
	P2KsUmcepbCvL9T2B5M6HI+gZlceU5/z7GZcwkZ7WsXJbUri2L5U+RFDO/9WngMSosZmp/sQcfW
	8PGL0jxJhk3gEx3KKodZr9oVNa/fNBeVpP+ur6nxOAhjaB2oTbbhWvNNx9tqt02KqQ1kczWunZa
	hzwdZo9cSwxLLcbca9H+7N138eG82nATxZRjLitQPh0TBt/Vf2AZdXAA4Dam0+ACG/0SQnVsSeK
	6pVa+eHwfIWlfjB2XSalZeIebSEUCCcPbBGu3f02ridZC1FeUb0iTgPIKu0F4iQySVDYUtUs1GX
	5ldB44hzlVqyeKsEq3Ah0ACearU+v60EiwSgzxf30/aF8CLIkpgg0y6ECRF7/uzQ==
X-Received: by 2002:ac8:5f12:0:b0:51c:83ee:e429 with SMTP id d75a77b69052e-51c8b422c6fmr109839671cf.78.1783674301397;
        Fri, 10 Jul 2026 02:05:01 -0700 (PDT)
X-Received: by 2002:ac8:5f12:0:b0:51c:83ee:e429 with SMTP id d75a77b69052e-51c8b422c6fmr109839171cf.78.1783674300888;
        Fri, 10 Jul 2026 02:05:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm259932266b.36.2026.07.10.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:05:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:04:50 +0200
Subject: [PATCH v4 4/7] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-camss-isp-ope-v4-4-51207a0319d8@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
In-Reply-To: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX7uc11FW8GApn
 +8Ls3SsU9bpZWJtcQB2z0p4uWV2CfmTi/TA+2KEyRO9s1VDCKq0mKOxQ21Lu3yQGJisJya8RIro
 fcb9rLTenPnHwDrDGlJkHkEkUZKcwsoS7hrgqpC+X9b3fg9TFz+wXPejPwUD2e+tqUuKZofvkEv
 xNDfrA4AfASXkgp45YkREzYjUJX47b4WDKsDB69slo72ZmaPPHb8oXIY4eyylNalMGj16CkJKKx
 igmXqTmeABMXKDYbZHeISwFfrWRJNawCcC1ZCaGSwMQPJzRJ/e8GLSQs+cr32Ae8NaidaeZfXB2
 Emh12JGSCJiQt2MUxFIchflQ3dncyz7A7YhFrdeK1V095p/0k2A0RaccrGIdIy49frmsipcNT+k
 poWT4UFQvNCAVPQtemrSdh/U8HmWX/fLh0HCKAefTm8THyDrLKpKS5bhTVLH6pu7sCr65W5iFLY
 eioCt5mpGHvA3oI0Lig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX0VtcY/QiMOrJ
 23WUl3R8AT+SQOT6kn5IVUdvgk5hELJ8cf8o+ari/nOSQQQVn/5X5AHWuml0zT7McZ1bHw2tQPP
 JUGQH08U6F07IIDW4z5ngBIAf1Us19w=
X-Proofpoint-GUID: v2rcK8vgrSGrwOJj7dwO-1Ua4Ra4JiJY
X-Proofpoint-ORIG-GUID: v2rcK8vgrSGrwOJj7dwO-1Ua4Ra4JiJY
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a50b5be cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100088

Add Devicetree binding documentation for the Qualcomm Camera Subsystem
Offline Processing Engine (OPE) found on platforms such as Agatti.
The OPE is a memory-to-memory image processing block which operates
on frames read from and written back to system memory.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../bindings/media/qcom,qcm2290-camss-ope.yaml     | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..58bf79ca447f7173933f6c5641add1f8035abc4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -0,0 +1,147 @@
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
+    maxItems: 5
+
+  reg-names:
+    items:
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
+    camss_ope: isp@5c42400 {
+        compatible = "qcom,qcm2290-camss-ope";
+
+        reg = <0x5c42400 0x200>,
+              <0x5c42600 0x200>,
+              <0x5c42800 0x4400>,
+              <0x5c46c00 0x190>,
+              <0x5c46d90 0xa00>;
+        reg-names = "top", "qos", "pipeline",
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
+        iommus = <&apps_smmu 0x820 0x0>,
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

