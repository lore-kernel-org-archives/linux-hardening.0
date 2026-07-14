Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72A2E62B7
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005196; cv=none; b=VQd4INHwcUv7BJNbQX4VIm/aTSQm+4k6i4L9Kydwm8XuyL689GWwE3UmqlSmMronP57V/8cfyeiejPOimhnYJ+Mh8FCkIPDXrvtPKHJ+fTiRsJPkWMGv1lYfjAX76s0MWf1+wEPJs7xlnN9FImlUhAY9NVheVUMM6Wn3bCH0U10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005196; c=relaxed/simple;
	bh=LKAINk67qcWpTEFbooGQl2hvLx8wgZLI8xl/8ZLIRNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWoeHjD2/Sfr5oxodp69x3QjOsCyBrdwo5E0zflPJzBztxMPIvmOAz1S0dzV/XBtMdHvn/FzXRjyZ0JClYEMD0VqkQFFxJUF8M+8DOChNPp1xsHK0AITSMkjOORWnn7yMmA8Lh09GWmTT/qeu39W2oNxgJPSMethyw9KtrOxWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0A2q4IN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iD+JJyop; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p0A2q4IN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iD+JJyop"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E3885D3482864
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0BcJHYQFSbu4RvEjMIgNWDsUGzhhHcMUNQgh7uDdv8=; b=p0A2q4INMw2XRv//
	SKRJmuXlEGNNee6OhATXDvS3l6sVIUMp//K6fSYBVGQRePtII9AjRZPWql/RYYR0
	IOZzUiW6N/RymmtdYhD+l8c4zX/I2qBRwn3/0Rki7G8PjV1nCRuJDEiCdCiY+gnD
	kTUjJ2h9cyWfxElbaV386QdVNWUqqDk0tJilroZSOtyWXf2Ooq4XSYrROJz4goyX
	iBOdqGBEGcczDEGYvdNdNmsIs4XPAlyB5KRErWgvN1fcAef9fHK8RXW4WS82NgPM
	Iuk9YY7LRLkXsiYyEKNuIA0/odioVwEOvvADwyWs3kIp3F+m4TaencXnz8vtrcFg
	pDC66g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37xa9hd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca124bf0189so422254a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784005192; x=1784609992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0BcJHYQFSbu4RvEjMIgNWDsUGzhhHcMUNQgh7uDdv8=;
        b=iD+JJyopmAhmrBugCwgI1MMe7Ef9G12jq64ePnx6rO4lWaCp8JF4Tn00ZN1cue37g4
         tDTZftUN7ZlrEVD2zpk0gzf89PryF5S+mkFhrxLFuzphZiCW0US7ifqxlTgdt64juz5W
         Q0b21Yc9ZO/iqjTndJcUcrqDzlxRNtZBwP0J1lZGXJ1579IVF2PH/nzPVu9QWzRPuFli
         EQ5Vb5DNxpIJBDJ7K7FXPzw020hyuqk7noI//ieZ1tfdb3Tk7s7/mAZixA/m+fA2eLoU
         nYt5Yb6N8fqkL7xjcoMfVjzjT6jipJqIlFn+crI+1sFcA3KYLTF3iyPEYXtNrlsqQl3Q
         j/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005192; x=1784609992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0BcJHYQFSbu4RvEjMIgNWDsUGzhhHcMUNQgh7uDdv8=;
        b=T9JQYHruKjgk4qYA93EXAuOHA9uq9lD35N9tKLakoiaGR8PgLzH8Nb90M8w9ZuURhc
         QGO4SCf5crxHLBOMkxTaGYaJpRYW5UyfhGE+2u7TT1jUHp5uFCSQP8u0/MEMrupmduwP
         fl6qMRXyVrTQXCJC5mt30DTsgPcSxyqN0JXo7tGkyBBkEewKc/ae21rd7XkaZrKfLsHq
         /voM4jdFbR61GqbuEbb2UecCkwlbtltuFF9T1fKTXIvCNZzMmKdaCwds3UikAPFF0ROh
         v2hruyAru/C/+hm+qi3BXpXwz5Yd8QZHwTDfc4kkdrnjtRM4pkJkQulmnr4tZNyBHLjx
         ZoHA==
X-Forwarded-Encrypted: i=1; AHgh+RqUkjRvTk3bohKkUJ+qVEc45MHelHrP+ACrZLOcDQUbYhxiWAJra3kILoVJwpjZnuDhXP9YiD8VD3il+DNaIeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvwvjpLWabGp+TCjiQAQzZNeAjPDNy8CSkjW4TIM3L6azCj4b
	GqniKu2idbwo7Lf7PCIWGEveXuLQBHG9mZC6OmRzX64DNl9p8o/2zh70WgAbjmmpdJGNiu/eohy
	gLl6ExxxEDsBQuMCPSYcrY3ANQfcgAkuMzsHTjCToWQB0CaJ6X1TvEpfhfpT6BvNXrTy+He4=
X-Gm-Gg: AfdE7cnQsXz9EBDEcEq4ATDADPzBq8GnNbA2gpbiB6UGRY+icEfWsOzrDPALOqpkT4o
	6rXVj8HhnmtH2nWoduRQ/+1zpejn2GkMF6e4bwEx+pU2JDN3WlBOb9CQpe0ulIQZMcu2dbNm/E9
	ybfBNTGoNTJrUkXq2A7OJvln+YhgRZ5CnjifAfZTHShtWZvfwT4GgJg3oaXecPthZzgl/TMNH7u
	y6o4WlvAXAElFg27fmtilHhQ/+qhs+L/hH85A+qwrV7Ga7DOOhKW1nH1R+k2Ou5GlCVmXuI69Uo
	NsMnR/mC3OjYptTdTotCeDvvfk+OvcWIgeFppa/CECYRMCGPnf5gx2ZBNUI0Enlunhxqwleewvq
	JxdiQRoB4PHFM1chMw0yzHD5H2IBH+QMtEDxH43O4n9yBlkGpATX1uFybHg==
X-Received: by 2002:a05:6a20:12d1:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3c0f093fb96mr18680514637.14.1784005191772;
        Mon, 13 Jul 2026 21:59:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d1:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3c0f093fb96mr18680483637.14.1784005191325;
        Mon, 13 Jul 2026 21:59:51 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm41874021eec.15.2026.07.13.21.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:59:51 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 21:59:36 -0700
Subject: [PATCH v9 1/7] dt-bindings: clock: qcom: Move glymur TCSR to own
 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-tcsr_qref_0714-v9-1-373670ab15f9@oss.qualcomm.com>
References: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
In-Reply-To: <20260713-tcsr_qref_0714-v9-0-373670ab15f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784005189; l=5632;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=LKAINk67qcWpTEFbooGQl2hvLx8wgZLI8xl/8ZLIRNI=;
 b=MCSwBzrCoi31GS/AI8EhewAJanmu/dE9dSWBIP4u0je5ksjs3nQmD4+jJcSBOFeBufFPZICKa
 rhqY/C5MXn8B95xdkvxRk+5FtoTZF+UzXkXc9HjDqOhCwosQnjgscLi
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfXw+Im8VzULFYr
 7gzCIDQ6tP9mVn8rqVwrAIeD70f2eLxE3otsVS0s2o5zeOas3I/miaWcLUw4PIMfBt/K5dKoBof
 CJ785TW4R4/IulNmDLo7GgQ6bdVjlN9RddO5BNrpjI+qn3z//Js0lJEqcFNj0xTo66FOLgqwI1B
 pF++CBllHxVRWue/CkmEMQVyaYpeBjRKoBfx1Yn21xABmSHcWBkH6d+4yXib/mKb3pyXkZYvyrE
 lxEnF9n3us5yiWX/OoKOGFOgPThYH2ql6h3nXFVMZl8htd7BIyK2lvfwtfne3ptuEwjabGafbnx
 fbSbWiLpSe2AzBJMP57O95HDDDBW9zxwzoepz2++FvmI5wPbIkDsuksOHPOHYSkj9bCuXoLompv
 QlsllhYGrXZfqFz7FQkRZVxnaBKCA67xT4NRmz2kusbSQ/YjJRE3DVwZgdu1xY4XEOlaECsZJQb
 5m4ok0Z6TwZCzrH7m2w==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a55c248 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=12nZpKSYVJl7DlM_WUUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: qWRi2CDMWZTZYvsOfxq8EnM11jdDPGf2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX4oMxRvX7ZQDK
 DS6UiqeNXG8uJ95b9Wp09RbjLo6Ts4/MNKmuDk8Ersw1B0d8AA1v9Mz9mjSOTbD7HsjWaDkmI1N
 jgLDC8ZVineqzqtdctJDyk3HE4a0yeA=
X-Proofpoint-GUID: qWRi2CDMWZTZYvsOfxq8EnM11jdDPGf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140047

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

