Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9237DE9F
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598730; cv=none; b=fdG0M1Ab0d4FtAdYEr7Hradf13/iKRe3RaFdorZ0M7R582fgNiIpB/WcLbHJHMK/lUZSs62WzHlxy0c6Gw2JVTTwqdnU1lrtC3FAIMOwwgZ2x+Y+6uV/IdXzOfDS4dZYxWrWS4SK4l3vgjX1wZbRvEutw3iIKC0MHHe0bBodYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598730; c=relaxed/simple;
	bh=JiMXN5S+khsxEmu/YLnrH2mt71+1ZhM3x6LB0MpuESU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izbvbl7XZs8oBT1Z5p6jBqBW8A7XtquqbgbrPbKVivqWrhbtWVV995UCqZwEADdwkah8REma88qpksgvQpUPWFPbJWivRjYpkt7+xah239Q/bay6P8VI8hktT5BZ09AS376CzA/lXIqSDpyNEEqQa6fqqpJ1j8LFrO5ZnqWGWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmffRrGD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NQBge165; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmffRrGD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQBge165"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637KO8Rq249488
	for <linux-hardening@vger.kernel.org>; Tue, 7 Apr 2026 21:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hC3RvSZ8HyqLaVrBqnS8owGniowsj4R1b4lXtsexSKo=; b=WmffRrGDOg3L1jJ6
	CCDGWq0785ohz5Fz+8B/b/tT0Bq0ClvrvvspRIml4K0nXCcqrUyivv6u77+Bpl/U
	wGFaG7UMmcUvh4ATK9Bd1VhvYjwlqnAj4zXbw76P+EZOYF6dood1rJW+dG8U2nE3
	G+SV16PthmYuNGzla/Se7o1KmIaoVck4i1AyC2aFSy1FXzUP438Hflu6L09MuyvG
	0WU1bjAHJsMHrhuQq+px4+xAZe1a/9GW7Bvx3aMD+cgycll9sqZhVFE6f9ocZzvt
	ZdyxkqiqNQLfyOpT4X9JC6kJUIN9eEiseuWbwj68vu7767apWpRHw7+msugP9huk
	jfr/oQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x987c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 21:52:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c0ba59a830so7748776eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775598728; x=1776203528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hC3RvSZ8HyqLaVrBqnS8owGniowsj4R1b4lXtsexSKo=;
        b=NQBge165TqlLG9PeSrEMh8R2qBx863ruI0jLZ01YjxsDTlgS+1ULvhTMpERwLavgTY
         8M+oxTzufI2mINwdKILTSLErf1SQ0BQ+eQ7j2jgbe6x8x3kBEtWFQ8KuUQSQYcxtRMpI
         yzhtCuXfVnU6CO/oN/k5QbKpsBqV6fhzQkxpjD+0lQCiPQ4Zgs+ZDMMIQ2VR/sKIeO0M
         DHNflLBkfPvL+BhzoBduTFwixA8M8Thru7DchYxZ7DQQwRDODGxGjW60APAwZkfwSFBx
         DP8oT6RWDeRdCWshw79SF5be9W3OUMSofcK8gxTrrah0luqzim9aOaEzildC8JNGStX5
         MtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598728; x=1776203528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hC3RvSZ8HyqLaVrBqnS8owGniowsj4R1b4lXtsexSKo=;
        b=GBlPng20xSjpXE7LRjR7jO4JhN6xPvMZjiNcJCClxCR4Brj2xqtlBRRSL3dsfry6Cw
         RgAE43dsgk26j3kv6mSKWe9FFUYgEvYH9n9XIwO5dbmg2II1UgYBW+prdVCy8O6Bpjnh
         Zh+11Tr5y5LYNcHA947HlruUzGtRpe5Nv5fKPv9hrF8CdGhKz6npLR+KUsn/V66hufZk
         8HkJPTnDmdH9XhWNbSjPWuzku4UcSqN7bpeJowU/UOkjDqpN7hvnCCB1/wQIPzSmlUrD
         JunSXDFdVkFjL669/+xXP48hcWVxvjFHOk8NQ+GKzXJowCQqOOecqZagYCbiaGGcUbXO
         Sl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI6BwCIzRLnhjE5knZDQTE/RJR9mAKPbZ4JNKGNWrGdTp+B4iK4nfMHsl2hN8jrxH8ZoMuaCrNXtplSHKC8nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNpcVbKDtnFjgAA12zPIlkOzc+BlmysT7a3am1aSyDb3bsjQK
	inuKzuZNssYzV1bZ9RFvRLorRosPivA3K/R9HY+CuMIEcySO3HqTga/7rG7j0oFCZ/rhyujB3i3
	pTyeXDOuaEm7701NY+mDBI3kfBhVfQs0xTELJ4aWGlw9gqLJY4dLiKoVluK6V2BisYJSdLg==
X-Gm-Gg: AeBDieuPLvz72qxZPVJNoIEWhWcPI8Tac+CmT8NGM6GIKRAcP9sCf4L1R2VFzEhGmqM
	4yJ4tuSW7oLjDPUK5c0OFsHenTcDd92TJ4dINVYYAGRid/qrZauMV+aGhXZpNi8cKckYRj7OpPq
	0ot2X1uDnct45BI0Tv+YyPwyO5dLzsoUU6tkBGZyVRBa4vWmTZYpfiJx5AXLZ6ZCWbgVT4qVWju
	/dHEHwcveIsmY7WEOncwh9Dvo38M/FovPxT+NsQlxZxCiUkfaVGZlgDSnS4BZH9j6AC1EFTIDQH
	eBdpbFg2dASJpwHmAiYY0u+QNtctwXiQV9c+BRcJAPrSJaXkbfmxqM+Gz8m2SUBHN9X3Nd8BFmt
	Ct7GUH69j/6dj4dkfivMsG6TFPiyyDC1SWHOtACe5qCYJOiZylGRC7B7n7l5ruiPS/dNNpNC3lg
	==
X-Received: by 2002:a05:7022:6097:b0:128:df3d:cd97 with SMTP id a92af1059eb24-12bfb76759amr8382890c88.35.1775598727650;
        Tue, 07 Apr 2026 14:52:07 -0700 (PDT)
X-Received: by 2002:a05:7022:6097:b0:128:df3d:cd97 with SMTP id a92af1059eb24-12bfb76759amr8382858c88.35.1775598726842;
        Tue, 07 Apr 2026 14:52:06 -0700 (PDT)
Received: from hu-fruiz-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm16224123c88.2.2026.04.07.14.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:52:05 -0700 (PDT)
From: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 14:51:47 -0700
Subject: [PATCH v2 1/3] dt-bindings: cache: qcom,llcc: Document Hawi SoC
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-external_llcc_changes2set-v2-1-b5017ce2020b@oss.qualcomm.com>
References: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
In-Reply-To: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775598722; l=2092;
 i=francisco.ruiz@oss.qualcomm.com; s=20260305; h=from:subject:message-id;
 bh=JiMXN5S+khsxEmu/YLnrH2mt71+1ZhM3x6LB0MpuESU=;
 b=1QqFNH0elm/zALyXd4UmResxPKUk2tddNnaN3I35PveQ6ZFsfJfjqlOvG0PjoVnde4vh9yKhD
 utrV3NYkMW8A1kHe6sGR+jHe+jWgvj9CNSDxCIjZrynXEm6lMoJk+hI
X-Developer-Key: i=francisco.ruiz@oss.qualcomm.com; a=ed25519;
 pk=Gcv2CX7iHozjnQ4oK+9fINmBiQTmVC4SpaZzoM63CHE=
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d57c88 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cctpUGu4WP7Cl6E8askA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwMCBTYWx0ZWRfX1K28Tvv+Pmh3
 WaVX72jIRVi4Z6BcPPakfoqmrAHIZ736kJMCTarOng0QFL6cOwhCRl+VIou0j4IksIQMrZaB6yF
 B1vA6xyOKs//gANV0GCneO7uwTD9w14ZN5k1Z0cpQXLBb1b+4UIhG72T1RhhdYyqVPJxqsjcMy1
 cmwyvmJOy+T1OUPnoeDf1AmDu+Z2ansfzHmbFH6UpOCegOK08uTjZ0udp8/+vRdpMIaBmYRIpKM
 WUDPSVmUVeWMoocoSAwA5YvX410wKFe0/88WeRtp6N9soH1MwCwEd6VfYMTwQ/91DShewLDlL23
 wo/gAO1Y4u9Uek6l1LOwidI9twkrV5CQYQkNQQuuSs7jyL4jCw1mcRmbNMt8xVXTTgHCtnpth72
 Ru4O6jV4Sz9TAy+EVkfU/1j82TBNpqWhOSzN94Xui0RnBrXugdkaOD2NPTTdFJSILmyKbbDCM4f
 HcUwFHLLzACPYKPQWSA==
X-Proofpoint-ORIG-GUID: 1fsHkXecjiktIve9XihOpMFnUHtFW39h
X-Proofpoint-GUID: 1fsHkXecjiktIve9XihOpMFnUHtFW39h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070200

Add documentation for the Last Level Cache Controller (LLCC) bindings
to support Hawi SoC where the System Cache Table (SCT) is programmed
by firmware outside of Linux.

Introduce a property that specifies the base address of the shared
memory region from which the driver should read SCT descriptors
provided by firmware.

Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 995d57815781..40b737ad2230 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     enum:
       - qcom,glymur-llcc
+      - qcom,hawi-llcc
       - qcom,ipq5424-llcc
       - qcom,kaanapali-llcc
       - qcom,qcs615-llcc
@@ -57,6 +58,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  memory-region:
+    maxItems: 1
+    description: handle to a reserved-memory node used for firmware-populated
+      SLC/SCT shared memory.
+
   nvmem-cells:
     items:
       - description: Reference to an nvmem node for multi channel DDR
@@ -318,6 +324,7 @@ allOf:
           contains:
             enum:
               - qcom,kaanapali-llcc
+              - qcom,hawi-llcc
               - qcom,sm8450-llcc
               - qcom,sm8550-llcc
               - qcom,sm8650-llcc
@@ -340,6 +347,18 @@ allOf:
             - const: llcc3_base
             - const: llcc_broadcast_base
             - const: llcc_broadcast_and_base
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,hawi-llcc
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
 
 additionalProperties: false
 

-- 
2.34.1

