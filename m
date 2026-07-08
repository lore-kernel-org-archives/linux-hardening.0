Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FA34753B
	for <linux-hardening@vger.kernel.org>; Wed,  8 Jul 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504969; cv=none; b=CCSKVUvR+u55w4wmdEXEw2/DDeUb1z2PKuxo6LJkTIIaKqjyig0Uj8Nwhbi46bFznllawGOmRhJpkg7m3KLdLXg49x1exQL+4TElVeTwER6x7Pax1OJM25LLPhWMsISGD+Nnbmo6jCBGyapmHmtRf9sBzUu+UEQ+ZT/T3FuASv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504969; c=relaxed/simple;
	bh=eaBbOLzTd1NRZfmmVkcPAVA1GiZLMJ+ycXX4tsfppRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frrDwc4uQ9wwIKZCP/ozvxd3RUxP/szdMUWHVd42AdtuQQVMsqjmxZ3b3BRHV/NzsoWdhNook42u2BDdAlNUU1hOaaEb3wajjlXhbDl8hBDeZyMadCmeTsOtBnhuXCzTkzA95loqa6/qxSZNVjdBQ4cbDd9Yz4yJPIQHbYeF67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZf50PFf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SNE9uQVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZf50PFf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNE9uQVp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66889QOu2197329
	for <linux-hardening@vger.kernel.org>; Wed, 8 Jul 2026 10:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H4o0HZduDvBsZGq+Uz+XOOu8qcBxQJSd+TFpft7ScI8=; b=QZf50PFfcv5+GRG7
	ERh7kSN8SNcYRkqDl67f2/HvO2Nx5lVuLOvmFPlIJ3pglCAAJW1JC4ydCK46Matl
	M1mLIf3qM2Hy/Du94eOYKOsZ+YRMr5KQf7YcinqMbqhXx4hxCkoPY1d1cSDcC6Mo
	WbKP24sADx6PNaw1EQks7NZ/GwEDKVLGvJGom84G9LpU7YAzx5PhX20o2RrRaBeU
	qDnxRbLqopOwjMujUCEtsHYmrOp9ItZBSXnfDpGmQNtR8XFAFHjIvWTJXumZV3ct
	Oxe5/QcHQzc8reKAuX4rV7gHlCdgH/PhckJ+AicFWGrVKufVsTwXR32znKNcj8pz
	kot8LQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6aa1hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 10:02:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c8018f11fbso8346085ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783504965; x=1784109765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4o0HZduDvBsZGq+Uz+XOOu8qcBxQJSd+TFpft7ScI8=;
        b=SNE9uQVp6FhAWxwzjEWYUTRIXpr1zFpGtBdkWQo3fH9cQ8w1xSa4BjYuMOtWTUSK5U
         kKYL4FrCCc5wPfYx/SVD6AKXWHV+vkdxU3tHQdYBg0gW1TUAd6MXomzxtC/df0jSUG48
         jaNOxkO/0JjBp+W9qWWYSAirFGZOaft88jlNjeL4ZOZW3rNsidNZUGJ09tGtiUS8BAoN
         4a4Lt2Jq2nuP0kaA8rZeo96kvY7tLtV5grg3No03CHL/XK98z8fhzF+HxloEQPuo+Epp
         Lbuobzd95Yb34NYLOWEDT55Yl4PcMgxYBB1ePBaKO+GGOM6oSNI9BslU/8YhxcQ7E9gc
         s2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504965; x=1784109765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4o0HZduDvBsZGq+Uz+XOOu8qcBxQJSd+TFpft7ScI8=;
        b=ax/qstmpRoZ6rLklULGDi4Vn1D+tpkNaoHCUeT63c4FPmlUc/30eK9lImKwz0pLrhe
         HAniXtHh1MpHTD98NzV20MttjOMMj9dlU4Oiw1KUsxIK6rlaw1/LJoRcoG/vxsp1lYGS
         lTMj0xLdyejp5yWIOIOcE+9VCshtLjRBmdXcQL+LaNlrtDsmneTJL174T/1PMxI91Voe
         1C/DRniulOgulzfwlDiUfXxhpVXGQZ8yklek1Zz4HNQc6Ji8g+gL2+YxzcNFcP2bTD46
         Rcj4gTs1YWW3h4ALdetgjllSfqodc9ooOHpwf7shxaxxi8M/QlmPF9U8bBZ+mk2N7bQg
         hVCQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+w7N7BxDDSPkqC5Cs5CKmO2XWankaft36BAbrQS+m+a0npQRXfF4HoRnCCVf/0V6AWogfJ7C7cgHPRYZaADQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uliyfhE1HOoVe/zrVk8S95mlJFCUFU4bw41w7C8uG+HW0Oiz
	x79fG9x4Yu8d7ycpR7dOwUBfLIWbZhOU6tKmRYT70NUqkTi+cgurspGpMqt1JuDTcwTR//CiIWF
	6RUkjcfi0kTnUO1cNfwSBzMEXUridA6GdsY1kYVAcsHVV4vMyjHiyWrPhFwROOL0C/DW0S7I=
X-Gm-Gg: AfdE7cnSZuDDv+wSInujMBG3ArbdKWjAojqqTkpZnSw6lqZ99frQmotRKbXIFoMOwBH
	bbsk8cxMafYYZtfr+3Bfl7bVgtZ83syNY2HpeE0QOWR/whuYdb2puUSgDfdAFCCFakmjq2T81jo
	LOv02OHKKEr61+cokZSpT1j3tx+KZUvc97ky9+rhlHAj8uy4rcSmUxrw5B95e38+9Jm8RnCbhB5
	cXbc2yemXeoAk0YGq7KCXZfpC8gXBYtYMW/auY8KV437e1r6lLRry8Q8Ntq6ArxCIWq8qbR9Scy
	zwdNZJ6caePqDoJ6q8qg6H5he5Wju98Ez4WldKMGqEjv6wXfWgRaglkQo0wWzkSL3uJi93KDf0D
	uSRK4nVBhIXzJv+E4TrVYWMhoXfsksewThaqoY3qIU4hAouxctqE/VFMn9w==
X-Received: by 2002:a17:90b:4a48:b0:37d:ac5b:392f with SMTP id 98e67ed59e1d1-3893f97dbf1mr1732924a91.8.1783504965446;
        Wed, 08 Jul 2026 03:02:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4a48:b0:37d:ac5b:392f with SMTP id 98e67ed59e1d1-3893f97dbf1mr1732867a91.8.1783504964694;
        Wed, 08 Jul 2026 03:02:44 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-389098609c9sm875741a91.13.2026.07.08.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:02:44 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 03:02:38 -0700
Subject: [PATCH v8 1/7] dt-bindings: clock: qcom: Move glymur TCSR to own
 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-tcsr_qref_0708-v8-1-62c42b5fa269@oss.qualcomm.com>
References: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
In-Reply-To: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783504962; l=5848;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=eaBbOLzTd1NRZfmmVkcPAVA1GiZLMJ+ycXX4tsfppRo=;
 b=7/xZ/xCVc0r9NEfTCsXrijlahP/DMeQkSoe7X+ALVXyPKtXlgxqV/Xc+JsFl9p3MQA91yYF5j
 UlEZtK89/jTAiJDX+/YKVVzLnWSA7fUIktiNNeDONkQYhAvdbPWDqrK
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfX8EN7VW/zHg4n
 nYYhN41MRwKf4G6Tr/K/xRGy2sZxaJRJ3T62jvTJRBkFwimLnFpgWweosZTg+EOYkUfOQRQ0IFH
 EtnpjeijF/xLFUMjuOlR17P06DnAQnERhCsOmTGYoG4ploOJhHZ9L5A24/LLCB8kPYYexxdhR7a
 mWmoCGKDNTuwDQoh8Zx19HCFqIhcG346QYUp+FCDet5DNljv+TNnTgE0tcUno4ZmAq5ja7wSTw2
 RdMzhq9/PzBWITUzkut0NgNs6AEBTcUK8x7ke4qf2p8MS1IhhJ9kx6qoM/p2g/v9nErUuA1YE2q
 qVu3LNyCkzmx/mTMBcUmXRVE8IfGnyATcTx/0fT9P0T2ojCW8idxSX7EfAlqWWUDISR1YCJRf4X
 uJ7o24kVldeGHKo7U2nSUOXS7gXm3q0MCnwWzAy9AuiSBs9G3OnylLYot69rU/RvqN8MW5DxHxM
 zdyX77Z1fGxOAWMuS9w==
X-Proofpoint-ORIG-GUID: 7mHN1Ivdqd6o6YMk100SImQHSay0exwe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfXwvscMgSJy0Dl
 aKJHDmqqKONb63w/NvGIJYBMXWjAhpTQuDx4FK4SBEHuB3Il+9+gqMUsH1kgDSJjP1Tn2x9CWEX
 ZOOyDwnDPLSykdcoOI8t7/fmleexqg4=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4e2046 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=12nZpKSYVJl7DlM_WUUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 7mHN1Ivdqd6o6YMk100SImQHSay0exwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080096

The QREF block supplies reference clocks to PCIe PHYs and requires
dedicated LDO supplies to operate. The digital control interface for QREF
(clkref_en registers) resides in TCSR on glymur. Since QREF has no
dedicated DT node of its own, these supply properties are placed in the
TCSR node which acts as the control interface for QREF.

Add a dedicated binding file for qcom,glymur-tcsr and document the supply
properties. As this binding will grow to cover more SoCs, mark the
required supplies per compatible using an allOf/if/then conditional.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Krzysztof's Reviewed-by (given on v6) was dropped in v7, since the
compatible was changed from const to an enum and the allOf/if/then
block was moved into this patch, per his v6 comments on patch 2 — the
diff changed substantially from what he reviewed. No code changes in
v8.
---
 .../bindings/clock/qcom,glymur-tcsr.yaml           | 126 +++++++++++++++++++++
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |   2 -
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml
new file mode 100644
index 000000000000..ec89feff89e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,glymur-tcsr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TCSR Clock Controller on Glymur
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm TCSR clock control module provides the clocks, resets and
+  power domains on Glymur
+
+  See also:
+  - include/dt-bindings/clock/qcom,glymur-tcsr.h
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,glymur-tcsr
+      - const: syscon
+
+  clocks:
+    items:
+      - description: TCXO pad clock
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  vdda-qrefrpt0-0p9-supply: true
+  vdda-qrefrpt1-0p9-supply: true
+  vdda-qrefrpt2-0p9-supply: true
+  vdda-qrefrpt3-0p9-supply: true
+  vdda-qrefrpt4-0p9-supply: true
+  vdda-qrefrpt5-0p9-supply: true
+  vdda-qrefrx0-0p9-supply: true
+  vdda-qrefrx1-0p9-supply: true
+  vdda-qrefrx2-0p9-supply: true
+  vdda-qrefrx3-0p9-supply: true
+  vdda-qrefrx4-0p9-supply: true
+  vdda-qrefrx5-0p9-supply: true
+  vdda-qreftx0-0p9-supply: true
+  vdda-qreftx0-1p2-supply: true
+  vdda-qreftx1-0p9-supply: true
+  vdda-refgen3-0p9-supply: true
+  vdda-refgen3-1p2-supply: true
+  vdda-refgen4-0p9-supply: true
+  vdda-refgen4-1p2-supply: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,glymur-tcsr
+    then:
+      required:
+        - vdda-qrefrpt0-0p9-supply
+        - vdda-qrefrpt1-0p9-supply
+        - vdda-qrefrpt2-0p9-supply
+        - vdda-qrefrpt3-0p9-supply
+        - vdda-qrefrpt4-0p9-supply
+        - vdda-qrefrx0-0p9-supply
+        - vdda-qrefrx1-0p9-supply
+        - vdda-qrefrx2-0p9-supply
+        - vdda-qrefrx4-0p9-supply
+        - vdda-qrefrx5-0p9-supply
+        - vdda-qreftx0-0p9-supply
+        - vdda-qreftx0-1p2-supply
+        - vdda-qreftx1-0p9-supply
+        - vdda-refgen3-0p9-supply
+        - vdda-refgen3-1p2-supply
+        - vdda-refgen4-0p9-supply
+        - vdda-refgen4-1p2-supply
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      clock-controller@1fd5000 {
+        compatible = "qcom,glymur-tcsr", "syscon";
+        reg = <0x0 0x1fd5000 0x0 0x21000>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        vdda-qrefrpt0-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrpt1-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrpt2-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrpt3-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrpt4-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrx0-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrx1-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrx2-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrx4-0p9-supply = <&vreg_l1a>;
+        vdda-qrefrx5-0p9-supply = <&vreg_l1a>;
+        vdda-qreftx0-0p9-supply = <&vreg_l1a>;
+        vdda-qreftx0-1p2-supply = <&vreg_l2a>;
+        vdda-qreftx1-0p9-supply = <&vreg_l1a>;
+        vdda-refgen3-0p9-supply = <&vreg_l1a>;
+        vdda-refgen3-1p2-supply = <&vreg_l2a>;
+        vdda-refgen4-0p9-supply = <&vreg_l1a>;
+        vdda-refgen4-1p2-supply = <&vreg_l2a>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 08824f848973..19ae0634b922 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -16,7 +16,6 @@ description: |
 
   See also:
   - include/dt-bindings/clock/qcom,eliza-tcsr.h
-  - include/dt-bindings/clock/qcom,glymur-tcsr.h
   - include/dt-bindings/clock/qcom,hawi-tcsrcc.h
   - include/dt-bindings/clock/qcom,nord-tcsrcc.h
   - include/dt-bindings/clock/qcom,sm8550-tcsr.h
@@ -28,7 +27,6 @@ properties:
     items:
       - enum:
           - qcom,eliza-tcsr
-          - qcom,glymur-tcsr
           - qcom,hawi-tcsrcc
           - qcom,kaanapali-tcsr
           - qcom,milos-tcsr

-- 
2.34.1

