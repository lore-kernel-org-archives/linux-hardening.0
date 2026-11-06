Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973332;
	b=vxq85jMMhyTgKLzo4+Pzinm/8dLmWzI3de/rJ05Alg2vbvepYQLP5bIJG/7jpda9zqPd
	 xa6kdzhhITrpkKWr6+Os1w2B38rE1AljKP7MAMpwNue1Avlnp4RuIie5SBRx2JC7SERsM
	 CIxUHK4RuSWkNv0XbRFxi3nJVuDm/faFOV1aUtHdtv7QpfJYWIc4yDS5NH124Bmz7NrEE
	 +Fe0PyLRBF8IZvjeM/u2c+7QJjTwNM4WnO8tFx9gloQtDJenGMnBO2IUA/0pY3XLfBC3O
	 o0eKmPrvlpUWKyeOat+VzvrH/Y/xRV9XlHae/C+szHQDUe2+KAG3/xwR+gj/xPX/kSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973332;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
	b=Mxs5oI0thWFhwrzYwX3I++gJcWCOx3RJZ2TKo5CO16CKPAMwYlJNSWtJI7iqTk2b0zFI
	 9dpOwb2GCWK50guo+jD30jk8zocnNwviRBi4cBpoMCYCztDH5n4bIg8DeedeCeZdoeiGc
	 EYqGWpKsFbUV0rgyR8FZIUKPff9Eh8tno+KYFI+ceU+tc64h+GBt34cgxhh5UQJLKK5A1
	 pbMqkAIAPPIrKrxU+eTOK+e9P5eJcZ73D27O04zxPsAGOpITROZfxmT7u+nRbzrRSAnw4
	 cLurIuU5gjVwAZdM7p7t3OLZCmpJpacrcpTb9JbtcN96n/U8dln2eMFZHs9n7KFOCmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="TyR/YEPk";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGFcS52A;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C98606EE99
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C98606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TyR/YEPk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kGFcS52A
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoLkf3776258
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=; b=TyR/YEPkABFsBr+u
	aYp+YS+zHOEzOqBrFp4xlfFnX26NdZV+QDRcY37O8XhvmSWSvl7PVp2ZkCHkvFFA
	dTG6galMukQhos82vKXl9KscbZWvr9hrXXE624QMJGBzIYzvWQYQp3929hI7xrdX
	78UKsZmSx6o5uL6km85urCeQpnUPMp21inEyNP9cWyzDmMICwADxPoE4rMz3dPZC
	Z5qeJBuZwA04kdC+PDte4Nd7QJmMcmTEwt2w1nyUvDSMZ9HUcxFv2OY6Ra7TuTgS
	Dp5o5RiukhKvhBU0GIVp0bo0J7gWhBSU2cDMbf8LzXrSaG6fnB0xpU3ydHkdkccN
	1gWkKg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa31bw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c0f07b4e81so147537137.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973330; x=1794578130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=kGFcS52A5/ZURsI0i1bYzDCWqq4AB6l03GptD0yz7HdiSAT+ejj86XUGdePOUM8MGt
         FGXQaYAro48+EwmTPhb2Fci1TAsc7/5VO9YKiQFngfIlcS8Ldf1bV6P0p4xadEb2rwQm
         nqi4rqE1SBz0ncUnUSw2TK4KEKhrev9LiSyHOinbr41dwq0lpIfdjaAPsoxhx7J3z/9x
         yIAXxQl9lDRo6g+liZHmi1XMUoa9TArcQiMy99E/rUn6X16O1qlCejSSdCo+t9JGw6U/
         sRWklFCoFT1MFK0QmiFSyXWL9MHK8kMdxD/qschYlPF8t7E85wExaxPyBHSmEtnSMUgb
         EcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973330; x=1794578130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQgJsfAJIwc1P3YmgjY5JtZQxBkIW43VtHK4ofExmak=;
        b=uIIo5MHIDEelXu/PdI+CE8bzl5+JwxhK+WLIlcuqZUJPen240gRbPHB+5oOqis2jPj
         ZnluzmWPnJmQuauqdbkwtnmF3nFlcPPtrmUrt/bF1oEwuzgMJ+4jaJxjvvEIhujkW/Va
         mNwUIwGJUQb1z8obYDIDIszHAAMw5oROyXJyDoK7dHX4LbV6pmX8AjLdRM9ob0wDn0Zx
         JpA48vgjsQPzSfkJ/DGOyoUD6Iofui0T4EP5kYxQSBP9mr60t+UfUFcbyp6uFNjEeI+d
         jGQ+fHsf16nWjlsj4b3JWDHCH74TCRh7DJszunFI5GvUkWwChwwX/C3kYTQqF6JUg7M3
         mMiA==
X-Forwarded-Encrypted: i=1; AKwUvByzfE7GYRsWOC+4Q+Q4zs+TQ4VElsUd5I43HCJu8NoCT5fG69HIBY09mj2l/V2BLt1vFb5bGwl/hwK6gdBBkS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XZd8XIxJFJZN7KgHIQzQUpnUq9eRFnQJSL9gOgl33dAtmyeHr
	mqRChErUq1SY2pBSfRsJqMdA81WHLIHKzJdWviPwEzaMmEDH14ZDH/26dM2VxW5p+ugZ2QUmv4Z
	Lzulos8/ffb1glBYPY++IhWDAxjFThgeKLkDx4GeS5g4lPeyQbUZkbkLtZHVwoM5L5pdjxMs=
X-Gm-Gg: AYBFou2qalQcTG2MUJopC7puaEaV8XGlj5zl8/zKgKPAzhG4ndR0z7928XbKHCsEELp
	NDy/jqIb4aLQECoQ8X+iGkflFUqkPriNaQVugH31Pq7Y9crQ1EwdgWZ8mXKLxo4rOvMHMVjkmKj
	fhaPK/Y4zZEk++U3SSndpnBBTnScEOpwRuZ//ssxYkKkZpQsQSaLs7CQAVhYfzS/T0x5QZxuJ06
	BCx+4JZvqW/eFegF4wkl12fRfvajepGMzAiP/jnzpuFtSFAE42QygXMxLaNFONLLqKIkgpS9nvM
	JhH+La5Q4Cc88YVvvF1VPGWqAt3jMsUKe9XkpOvnzHusRvz9B+9h2XrMR4G98Nv9UCGBXc0gW2Q
	gEevJ8E6vBllZT75CFbSAexX6Y4eQ84sFcayfRBY/YypOwiNiMCV0lBwj3BuGzWUnOpJp8rN5jc
	WLNAOPEjT2rLqU84V8i/6EUQgzPAYPc0Wbx6wFZVgCEkEm7CG4FFcD5DHgicsa7D1Za/1ifhRfm
	Z+21u+bi6vOGo/BKWcNfHcDN7o4
X-Received: by 2002:a05:6102:390e:b0:7d2:7dcd:7c99 with SMTP id ada2fe7eead31-7d2a152a24cmr1200762137.7.1793973329639;
        Fri, 06 Nov 2026 05:55:29 -0800 (PST)
X-Received: by 2002:a05:6102:390e:b0:7d2:7dcd:7c99 with SMTP id ada2fe7eead31-7d2a152a24cmr1200734137.7.1793973329028;
        Fri, 06 Nov 2026 05:55:29 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:27 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:18 +0100
Subject: [PATCH v14 2/9] dt-bindings: media: qcom: Add CAMSS Offline
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
Message-Id: <20261106-camss-isp-ope-v14-2-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
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
X-Proofpoint-GUID: SRYarnpGVUcU8FhqmcUfsBxm7adL291d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX6rvZzlRKy2Ov
 +LUaspbgfcoG5QPugTsdxsUu+BnOpc0wLUkSvKRv/3WUUwG51ukLbEub74tVk86dH84a2KRsXI7
 ZVLJEubAUKjj23KmwlkJLsWA3wHH74v6iGbbdJXC8HLEMvs/qHgb6z0fOUsR7jGnspO13ady9XT
 kAe7bSvrH2AOkPASNObOKKiTVqPxrM1ynsCqkJo8brEsvkt17RbG0SrRT5NCPumVzT079/7gJyS
 AOd/rk2HvPrzjcOBXD1LZ7x46kyqqAMjAlpCK9nqEg285dWJq/Mh8EsG7/PktjLkmJExQYSmbhf
 V1MKS0BP/S6Uuv21JSclej27498WqbrTxh3vJWCIk2LPNQRpD0qMASX1/yv7XlbJEEhvl//tHb3
 4dyGh/zQAE2b65Pw9aNA7nsY2zn/dsnKmzNEAO1mX+0fBaKiT5nIaRhFdKmeHS/FtMywBMnGZrG
 ONVO1h8pIxJUggsK3Aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX0OtqcjdIJ70H
 SNdm7oYdt0gwcbHJWJROc2aVISykvXirdVDoLI7SUCIQYNfyeEyC4vTf5XJN/n4PfoP5K5bcE2Q
 ztZ4r1ea+CcVU9EKGm4T2GNgg06v5x8=
X-Proofpoint-ORIG-GUID: SRYarnpGVUcU8FhqmcUfsBxm7adL291d
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aeddc52 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=l64rWm3OqFMOLA4dSg0A:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

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

