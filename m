Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129D33122D
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699944; cv=none; b=R/cNeLkPQNsGlpQiscCS/MWJQCSt689ekTUFhRi2gYo9aruGDKZMioiTTlT9e2rbUZkjIpRMBGlQJXyEuz9dFAgxfFwywJNk3YSBN3O0QJn7/dxw6P2KRsg0e5XJWlZ1sSu6vQakadlE8L1MO5lLEL9NscIvoGgQFuf4sK9vE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699944; c=relaxed/simple;
	bh=LKAINk67qcWpTEFbooGQl2hvLx8wgZLI8xl/8ZLIRNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daII3QS5QjmePG3X3Uxb8jWUOGpFVUo0tm5BE5r91lG0a+xk7sBtgDfyjm7hlvUQaivGYTThzNRjedRPVrEygYS5Is1upJF89nYi56Iq+5jyIPrDDadCIRJivrah5zPmhJX5BkGULmWpRQbCtjA/c5455x4Z+1MApSjpaEJKZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anVGZUG3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NY9t8S0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anVGZUG3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NY9t8S0R"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53fmE4027287
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0BcJHYQFSbu4RvEjMIgNWDsUGzhhHcMUNQgh7uDdv8=; b=anVGZUG3Ra4TsdrN
	7IQrTWTAHugt5ov0qH2L+GwOdVkWgF9MvenIcP9OVGpgsBIuWcEE95R7Yxko2DLb
	AIYuXaBV1J34dQLIwfu81u2+lIAqzOZhq8enJwZxJmLy1y3ngjijMeQuSkwFvZTS
	UBI1q2gndUzLhFB5d4tft1hrHWASB8wtpndoPIjYU2ZkUcztJ13kYMwKzMdDJy+M
	YPGzgkKOhQgPnkb2MJbuGWkpWtZg8QaLY9G7GFvyM2bHLkJz9axodYU8mnlvpL5v
	TdWvQBY5Iw8A8CPLtLNK6WEVGRFszDfb78xSjcf55n2sBxtN+EbXnhK+q5+2H5RN
	5I1kyQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbr1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so22463571b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784699941; x=1785304741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0BcJHYQFSbu4RvEjMIgNWDsUGzhhHcMUNQgh7uDdv8=;
        b=NY9t8S0R+XefWS0vbUHxSWAmGn1qZr2VYpos9k8KNWwdvsvvkhOAbidg3FK6shsRyJ
         XsBEneinjt1ILMd2Gac1LNhVcnYTGa8jXRnOkr4SuPysnjFmHnQNX+5tYYjo2UgTjhhJ
         x4E+zUC+WmclKx0TTBU6GAxQqICuF+WhF+MhgnM9yXXik7RLvwZEKMeCYoaEJetpUDMo
         8KS/0nQA37FKycg6bq8l4/Gt9Zxhr+KufZIQdkM8niAi2qd0lF6L+G5IkVnp/scn2ntQ
         yjP+aO6OHEvLtzaBNM/LiuqevUpkqNdC7asVjOHYrwu9SsNx2lvjbx1+wu64b8xkd1U7
         TjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699941; x=1785304741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0BcJHYQFSbu4RvEjMIgNWDsUGzhhHcMUNQgh7uDdv8=;
        b=Dv7R4gvXnACdHanEI9dX4l0VWAh6uGln7MQro0UrRYjaodHyRcRRsbaBn+Vz2ZUJlK
         /Glft3PcRmc+JuRKBvIHCUVWFAGbtYhbCSJSUCYLYt1N4Nn72rLn63c9737n5RG/oih9
         KDcdJIybZuZ1Pehvc9wcdWVYxIeRUWfDMfY7jVmcyzSQvr4AIb1G8Bmbg2fuKxCDp/Q/
         /qikM4uPFxqCn9J7Gs6TcYocBKun11A1VGqk/40c3yBu4PuuAS2hCdYbQpz112YE0n62
         EtQ6XTGF3vRuiMUkvCHcJE9RvrLHVV8Y9Fxx8lydnEqk+uIXujLOkGp7RMpAZkRVjaNB
         tQZg==
X-Forwarded-Encrypted: i=1; AHgh+RoAaHeFtcARzj6gNgVZzmKS+jzJyw8X2tupCZYYruvB3uVDLqROVIwnm56v6dpfZz5WbmpBZrOiR6MhDjj1pkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4HCE5Zva4ee2KsIYrZhuUWLw3sZufT9Z5cR4iNNzrGdtH0oY
	Hdl7ekir4YJbwQ7INHrLNS+BUpykEMvGNFw+4HuwQkvpdsb1Nt1JoSdJTmMMRv4g21p9TI7T3hK
	cR9kZBqNFxuqbv4sItY7oYCzCNMo9aMuRHp7mcYM3/iv7pIn6Lh91JL+Ctz5UCSTYBYnBAyY=
X-Gm-Gg: AR+sD10FTyxB4zg56ri9VFxkHcDfqYZoj+qh8cS+6Uu6hdm0LX/5pYP5akotrEdIY6m
	WmGhu4+QzMeaCLabfKBY/wV9H1vwYiUwjyLBXV3aFxDkusU5wlNGks5KJ0XxG0imFHjeKjBCbWC
	nBTS+7j6v6R7WFxsDEBTskeq9qOIeIVaXaioWvdvop2HqLXkd0mWVzloRGzglXn5EPIbITetK8h
	tl+eABQnQkckhVhiMHhO0Ct+9aGunsZTwDlS5VZsV2Or46lMCYalYidD/n7APn0O7w6vyW/IFPj
	9gyeg4b1WPidFD83n4pmEbFu8SeF9CYxdru1YCOQOt69R4A3VF2Up8X64sS9E2cNwhmN2dDRK0W
	Hs49mnXDBlW11UkZ6N0uYK/5sb70tleHV1sUwkum3H7p37s8=
X-Received: by 2002:a05:6a00:368e:b0:848:7e85:f208 with SMTP id d2e1a72fcca58-84c29467cc4mr22840708b3a.37.1784699941453;
        Tue, 21 Jul 2026 22:59:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:368e:b0:848:7e85:f208 with SMTP id d2e1a72fcca58-84c29467cc4mr22840701b3a.37.1784699940988;
        Tue, 21 Jul 2026 22:59:00 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm554013a12.12.2026.07.21.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:59:00 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:58:56 -0700
Subject: [PATCH v10 1/7] dt-bindings: clock: qcom: Move glymur TCSR to own
 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-tcsr_qre_0721-v10-1-d2fa68c63b78@oss.qualcomm.com>
References: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
In-Reply-To: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com>
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
        linux-hardening@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699937; l=5632;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=LKAINk67qcWpTEFbooGQl2hvLx8wgZLI8xl/8ZLIRNI=;
 b=i2xB8/fmHHfe+GuwzLZqUe64v7gCZUrIEPiHRqVWzF6wcSKvtoPirUj6n7/a1+CMJlYDUrRSR
 /ekXwDZLbumDbddf8ZSh0dThdVVfC7Dt90p2A6rQw5INamqyrnqSNd5
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: wb4_NeyI0fQBU4aGS43EuoA0TQxmHbXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX5TUXPitJddzO
 a3WKOKTrEVemD8si3kF5ik3+7L0yQjIASZFrfU7T+YyvmVLLmtJrfUlra08pWilR9A9IHIlzg/Q
 1iigdHijqgTIIME67K2k/7Jp2PzWOz5IMscs5D/IwRkEyXHtCbTeo95/VK7Brp+gkxo6ajBPpT6
 BSdPplIwBtr2WzMcoZLZCn0i/N6YzzjDJUGFq8q2RYyXa2CBvDxfxuHvA/iilSyBIWYqtpOIpAM
 yxP9sNqkOiKR+D0O7ZxlEML/jjHiT3Hn49XuFBe219GIaPH13lNz11zSRFth/k4XupbYbcViBnc
 VEicVUFd4bIhgOacUbUane7q5ITKi9v7QUdzpuxF9VhEnjMt4zCXlcAB4peA3jQeJA2QUaUv4q4
 MGjBRUyi1nsowut0ptq8KKo8EG+lqjQGxq3GJd0AAPUUqrEcgjmsBPKU4VwI3zYNSNedpX1zcTr
 C6fae0QBpvcJPxEbYzQ==
X-Proofpoint-GUID: wb4_NeyI0fQBU4aGS43EuoA0TQxmHbXX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX/WXaQ8q6Gp5C
 hvNRCmsySt+dZKpgqywQbmiHtlMcP80MLUA7pHrEujZn64abq+C5V9E1tPVoo+0V4DnWjnsHgHq
 TZEeFjEGEwgGmbd+JksjFFJ9HFzLAWc=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a605c26 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=12nZpKSYVJl7DlM_WUUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220053

The QREF block supplies reference clocks to PCIe PHYs and requires
dedicated LDO supplies to operate. The digital control interface for QREF
(clkref_en registers) resides in TCSR on glymur. Since QREF has no
dedicated DT node of its own, these supply properties are placed in the
TCSR node which acts as the control interface for QREF.

Add a dedicated binding file for qcom,glymur-tcsr and document the supply
properties. As this binding will grow to cover more SoCs, mark the
required supplies per compatible using an allOf/if/then conditional.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
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

