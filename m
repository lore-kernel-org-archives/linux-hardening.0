Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A784BB298
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005006; cv=none; b=Pi98bWHrcjDPkpuTPNh/yge52Nz5REHInuIV9YXxTMie1GKgMkM7rDUCBWhE7P/s90oeFDF7fyYEpj2eEJy9hxmiBbVb2/Uz3zenGaxhZntVZeDWZeYIUrexdbKBDm2yqfF0LlObb4+s0/XMDUl/Ao29cVSF5sJPUi+SH7jAenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005006; c=relaxed/simple;
	bh=Z6cS8aJK/HbBm0d7OT7Xq+/FQXVHHZKwWRt5CJiiGpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QH8h/XRMkjscbA0pIaz6cKrnyE5Kec4ZMCdRNkLI0kfr9eTjvuFlj+KZfb0zi+s6QCA2Ji0PPtrBq8Hc6UUtbQKiAyWGRmoF/UBklpC/eCJtbBPMTRoT53SHgoRbmnB8cyrwtN9pRhhG/cAQBEEyLP/d6IlgcrX3iyio0VsVM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6FyLu8b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PKeMEYQQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6FyLu8b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKeMEYQQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFApCb1817496
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=; b=n6FyLu8blSR0foVq
	M6sxjbQJRCDeuqQRZLMgjpIbW3TLMF+hkkRo7ZlobsCcehIlHx4BaQ72jWyzpw3Q
	EYIIk2/u2r4dyy3C8LzqhVzdD1eFceotWayOUWHpR9lwQNjg21a+Tw/+1HKeFywP
	tF0GAV1ohHZ1V58JkNvaFte8U2TwYeHowhi3Lfsb0+ViywgWn0KsnqkyqOz34ZX+
	HSr3k6OZDQR+tdVeXsQX1O4PcTIjiiNXDmjT5rntD+fRp7zKmK1wsaDaviTej+ad
	byyPRUuIYy0dHlBGCff/+D/1O8yHaJOiAVgu6gTY9tTA8EnFjNLLyyxF7Xmrliy5
	mmJgtw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu011a2nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78d25a8ff32so844810137.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790005001; x=1790609801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=PKeMEYQQBHrAYPoobmsHPRtT0HRTn5GIEdjSGF2OrQtXPswPzy7YmG+KFHMhw/RO6C
         HuIzt7BU5CvRSCLp56/gG2RGr9t+QOYUbM+RGQEotTw9SOUFsNTAlpt1+2mG853pjCCH
         VCMtyNlArY4s9IDP/kWRury2tzxY+MVS+xUEDQvq5tIaAhAkPThUjfd4JVraxyGZW4Oz
         vHpWOzgjs3jEOhI6dLqSTGQNQtvpLDHWLS/5ew0T39dsgPYFS26wBaYCiKfscfPfBoba
         oSVU5VlerX2v7ZZk2yWrvcARu+oQgtqdWj1X1fao6+MSWbLWVS0e5eVOqxGaRudlLLda
         mtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005001; x=1790609801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=g/9VSNmZQX6iX1Ra//rvErj+yXlQLkuuEuLfrxhLl58uMXGKDwHl4OqSjDfMOj1P1I
         C63L1sSOZVRWtYy6HJ0Eu2f9bVQ8DbF7UCWqIn18xjLAP09CdYOebklzX/fQMravOJGP
         8fPR5VZzncjlAtn8+xgUR9ux868aM60juSfI5I11R1Z0ZT64eNrSJGZ/ZMHUGqpzV3IR
         Ze/d8aQKhxi6jaTyfNkKnYHMfu/iAHrMBduRf7arJovdUqs9yjZAySi1rDOsFU+HnUxl
         naDcXofAlMNMuIADTDTqngUkUThuP0pMMwfAHwaYq2O+EZQ5I9kT7phWGWwyiSZ8pqQm
         s/Zg==
X-Forwarded-Encrypted: i=1; AKwUvBzi5pyyb0xUtvI7M5xgGzlPsis4LMpfXsh5kSGUfwqaU2pubp/B5KGpdmTwD4TSubcYEgRuBjHmERF7NHa59/4=@vger.kernel.org
X-Gm-Message-State: AFuF++mFS38FshAxF0/pC3nVQnCSoJxV0iatSITOwIeNNYwO1Z/jMY5j
	ZQwElSU5/PUEXimZOF2k7FsHQwoUSPNi0x6624t0Qu/aW3KQ1Ar4+rFo5TUaP62XjbsbNTwxSKi
	HjTS8SJe5P+KlUj5b/RwV22JcavR+GRjn0XFb98IgWdB42/PUPPSnDaC4/8EtUSmu+O9cR2s=
X-Gm-Gg: AYBFou37d4SaPcAMLSvsc7ROwzVqyTAJjgxHEx0vnosifOBKS4NkfMSXHyvJfGxuPT2
	mxhGiRyhuiijtidzYEhd5YSxMlCMs6hfl4Y2ynrKQxJjNFMJh4hVcuD1yGIzRxYJRxJDDNhlgDt
	x5pcdd8+mTJZ7jT163T75f72I0BhkbNvG4DzNBxZEzTrEq7L0zXZfd1JZ3aa8RtuAabGg0FOxtq
	3NuaPWY5ogLBFJjLUu4t1YfMX71yPAJ+m6PTIb8/s4PRAquZgfGomac0XGGATMPFO4VxUpoziC1
	OnHHgcizQOUAu5F3btllt5fTDIgMUH11AYrX9FjgKnxYLHDqirTR7cisWB3sb9I8cWI3FhneKSS
	Hs0y9AKKrEEzwNBsuaZlDS2wvK13AZFCznJjpCYtk6eQFiKpJRwNBZv9dJ+Zae1pJJan/ULq8Bk
	U21Uvxmv5FdLDYYxweNKQW7PStHuhxJKMujEdMX2AcHjBPVve69ag=
X-Received: by 2002:a05:6102:a46:b0:7a2:4b76:6b65 with SMTP id ada2fe7eead31-7a55d69a2c4mr5106500137.25.1790005001100;
        Mon, 21 Sep 2026 08:36:41 -0700 (PDT)
X-Received: by 2002:a05:6102:a46:b0:7a2:4b76:6b65 with SMTP id ada2fe7eead31-7a55d69a2c4mr5106428137.25.1790005000601;
        Mon, 21 Sep 2026 08:36:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm231054065e9.9.2026.09.21.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:36:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:36:22 +0200
Subject: [PATCH v8 2/9] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-camss-isp-ope-v8-2-dd1c86a3c8a0@oss.qualcomm.com>
References: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
In-Reply-To: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
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
X-Proofpoint-GUID: TGLPNimarZbdY53LoDB-UyJGg5w4nyRD
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab14f09 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXy3p0rw06jSot
 WHJmf3Jiq5rbIXnW2/tgZnM/oo9w58oR8SZMwkiIBe6SFTFX/KoU5Nohizzsb+qYhwgmopjlWJc
 VELJ7z5VQn2WqueToj8zTtz5JW6IhMIlyhvuntoOmRufG2h1fK5WCxPUMxtSQzsMVcyFCMTsVQ0
 bhZmiJMsFFv+wl3XT+nJjlPEd+AHwa+diEnMOu+BQ0ZfgKzXmvIv38IV3O0H8oFXvLd6kIhO4YJ
 zUjNhzj/8dP4RMeodENKVBPrSSMitAwph0YHH2N2A8cn8dEj898mCM0dPVcKa4fNpJYERhpOOp0
 k4D0a1MrHEBjWAlzazwSWiKY2sVcvmai+254/Eq+Hgq4+H62BHUQFuefSgGPpdnP616qWLuVB/1
 QDfYnjfoUPwYCBFr82o8YxM22AKcG6aZBc5X51Rha+EWU6FfCNnrFABz1qmy0iCpA2XIlXtZbI2
 7GkW7q5VzCXYtHswW9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX2/NTjpBAFbhc
 XvsNGJlSF0CDMYqU4XS8ny0yBWg9pQphx8nJ7wbU9u87srDPBnAGeZQ4fOZJVbL3mOEm5zx+LQg
 sutUVi++laNU1LMoN6/Dzf5y/wPtzgo=
X-Proofpoint-ORIG-GUID: TGLPNimarZbdY53LoDB-UyJGg5w4nyRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

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

