Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2793537DD
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098903; cv=none; b=YUoo0M0KrVAsMdLwqpbTS+Ppq+6SNAFurIGecMUOQ1r1huocudh9J/b27ew55g5L8JTNVsfWT9hNBZQ9ack6eBlSrKe1e+ja6/TSedMraPYJFajqcWOQdti6Sfs0yrUpeE2ZEpQSt1CoaGU7Jgvct6MrJ/gW3IhGsu0zOitN39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098903; c=relaxed/simple;
	bh=xvIhsQLnf6VaC5Osn71e2H8dj70AFPG1lZSuD4kkNsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhAMjt2aG10EQQmEy9j1dN+ZfOo2RWfvat0YCXuOvFEzcB6+1Frnn1nYet5BMD1+wJ9dqNBeqbzLRbyozsZpKMrXPs9rAu1E+pUxpZv70EbDsUOaNBRV3sCGihQtkTVsvGbzRf05o+1gKZ/xIBhRSlWNmEKTpbfHa79fem56Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=atiKGzz2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4lMxbdI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="atiKGzz2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4lMxbdI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M4LBO4009752
	for <linux-hardening@vger.kernel.org>; Thu, 2 Apr 2026 03:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AllDrQRxwAl7RCBJmeePH104tAT70KjLDbo84NciKdk=; b=atiKGzz2M0U6E1Hh
	FbdFOgHERWa1EoiVQq0p495S3zCEoToAk76wytbhO+p0iU54f9isRvFd/pcb8gzC
	4Xgir+644U6/f+s4Fyez1uwJIaVOj4hiU6e+rRoiJwwZUQDHb3En92mwPGCPfo21
	8G1hI/lbUw2Mj5QsLQczobOTr/Vutd0RfPacLUr/1eLrBf+TS8/GnLIpLMiMQ+jq
	9ZZF9JnHTbokhj1LQmjj4WRygTVfMA0ILQIZ+4/p91ilKBWsYA4s/pfoPYMsElI/
	5jS5pEBNDlVDc/gV67JmNQ28QziI6rAG9GA+Lyzn/qTlBm2ffnGnCq+wLDvnIeby
	5WXPaA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e01sjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 03:01:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12a77b008deso2083771c88.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 20:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775098901; x=1775703701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AllDrQRxwAl7RCBJmeePH104tAT70KjLDbo84NciKdk=;
        b=a4lMxbdIOfXqNNutH0be7n/SdnlHHtv59i0YYOUSeRSYeYL+LVUIJ4HF/92DV+Y4PG
         bO5ykosA7p4LCOLxzdpuJ1BspZw/HH3IqPBuyzyp+uDvvvDD9/HtsyEpslRaQSNIP9uf
         lEpDCIsMS9JZRoH/bmmSBEfndHbNVFGeMe3bkfrsZ3L/7MbaWTmwM/ficu55UxTv63L/
         dxvXmI7sdyrpScoIEV7T0xVR34uGMlGE0Z/Jz2EhedU9vev5MNGm+/HER6m4Ul4SqjLo
         XijJzyCuWhzw/F5Gb2BiXZjZd9juxopqhZVaDNNqbgxSkDsvndyjvw3lu44fbdbgkmy8
         xQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098901; x=1775703701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AllDrQRxwAl7RCBJmeePH104tAT70KjLDbo84NciKdk=;
        b=OQeU+AGkbMMtQ/2mU3Ipn8TWAPugsitKRSxykq6DCEchQRADJ7GZaY7bak5wRort9T
         TFN8gqqreFJM9wo1kU9/FfNlx0CToft4qMaFdbd6nAj0r+gyUBSM6gDtCT+L/lt7ICf1
         7fsjkUOmoRbG9RYTYv20JV6uI6LCz+IDbg2yJfcGDqjMnoS2ZPO9zfTA4yauaB1qL5m+
         pA3Qz14Z7OHWI0XM4H7/tcohEqGf8KG5IVZOoSgg/AEaFQwsFjChxcyRc+W7tme7DWgI
         74lNStNcAkSQW/4xzJXSpG0uc5/+Y3ENV0dDtgXbBsPMh8FjManu6LeLHmmO90i1kzm8
         GCMA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Rdi9AcbQSOfowuPVIq8zwWJRvuwaxDgcyRVjfTsDX7H0nVWYHz5jPr3UV4DLAZi1v/wwVAn8o2X9D7dfxeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL31f/tQBWmPJg+ENwcY5nXhjR4TDpdPjnO27d7qWyQRdG81Di
	wIG038I77VAjephH1CvYmIP6ZuE45dFM5mB17Jk4rzJM9Yd2hKFQv5OwZj0HcdaHnmjzixlWDCK
	efIz4IbhdG4GHp7Hpj3jYkaCn4WxIGKpMjp2VlYI9sPZL6J8T+RmX3PfnlPL0OWwku/immw==
X-Gm-Gg: ATEYQzzsFvYH5jDBdR4G7elibOw72BcvzX7oX39SnpXdOsS7GZ/HnVa47xcjSiOc3+v
	YNL1OJcIi+IKgu/YvvWli3+G0YIirSBzs+95cVEUGm0baqC8mWK89lWcXNO3KSYMLS0fEQt26tW
	hAmLIbHeRZSP1fsPmKTmDNoApPtF9yOdd5WIUhLNE3Wxj52ir962ICPFNgoZaBoHWo3mMUxXhGo
	3RpgY8eyadRa+654TLTh2DTSgaADUI9S6i9r33g3wkTlTAtVHX3OI6KIIlMlUhjgsWaoxCW/qfQ
	KLLSCH3JkCTqLOK58SD3GILkFSHzAOfJii9lX0YUt9zOr1GqSIUpq1cT1pwhlQkL0yZL1C4xRZl
	BSsF6AWqK5qk2VG0u9Mv2reydeuJ7u/U8n3/2JiYlbCF55kke4oG73WsHb9dYW9O9dZINWc631g
	==
X-Received: by 2002:a05:7022:458c:b0:128:d5f1:d594 with SMTP id a92af1059eb24-12bee639048mr1075727c88.10.1775098900991;
        Wed, 01 Apr 2026 20:01:40 -0700 (PDT)
X-Received: by 2002:a05:7022:458c:b0:128:d5f1:d594 with SMTP id a92af1059eb24-12bee639048mr1075700c88.10.1775098900112;
        Wed, 01 Apr 2026 20:01:40 -0700 (PDT)
Received: from hu-fruiz-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf010d7sm1287044eec.25.2026.04.01.20.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:01:39 -0700 (PDT)
From: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 20:01:34 -0700
Subject: [PATCH 1/3] dt-bindings: cache: qcom,llcc: Document Hawi and
 future SoCs
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-external_llcc_changes2set-v1-1-97645ede9f6a@oss.qualcomm.com>
References: <20260401-external_llcc_changes2set-v1-0-97645ede9f6a@oss.qualcomm.com>
In-Reply-To: <20260401-external_llcc_changes2set-v1-0-97645ede9f6a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775098898; l=2958;
 i=francisco.ruiz@oss.qualcomm.com; s=20260305; h=from:subject:message-id;
 bh=xvIhsQLnf6VaC5Osn71e2H8dj70AFPG1lZSuD4kkNsA=;
 b=UxYvpSs3KbM8aGkfbVs/PZ16ZOn9en7czLcEF7YcFwobXdVfJEh4SPICstvLteJNbvx+sIXV7
 2ShvmHAjM0hByZFthynH2n+7Ryn0Ycq2KboA01Y/dh9NFEoeo3gZ4Q5
X-Developer-Key: i=francisco.ruiz@oss.qualcomm.com; a=ed25519;
 pk=Gcv2CX7iHozjnQ4oK+9fINmBiQTmVC4SpaZzoM63CHE=
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69cddc15 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=TYsQ6n2DTjt8ZF7sQeIA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: LdiB9Og59TDAWSZTZ3LVo0m_EcQn-8Vv
X-Proofpoint-GUID: LdiB9Og59TDAWSZTZ3LVo0m_EcQn-8Vv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAyNCBTYWx0ZWRfX7K8HvXJ71Usz
 jThP04WUlGN6spGuFk7sQcNwvWhkkzF1toS4v5dvbtCldTHV0JE6SNLs6I2W+qqkm44Om/cFvXB
 l9cnulsH/z5ZwVhQ+NU5TbEeSHMmPABhuRbO9Y0afsIHERxQnNeSU7WLWjVO3TjTYc369irMd5d
 y2R7j2cDR24py2XUOMagQ93gv039vv0Nkk5I7awcJkzBljkGyzJtQkY9B+6m8B0MKn7De7oEltV
 rMRxCvvYFQAWr76Hb2GVZ6a78cq8vodks8NYW47qcQ1S042jsQZd4w3r9gic4VFuaKkCRE2IULw
 LKbBZy6pahrTZAZUCP2xyIvuYMqtYBwSvJtvOMDR+j1Nj3Bv+HP4NwNc57zEnv8pP11TtR+pImv
 LUcjMEQoguq34/Z4iYhp8mOyUaNVLlPWD6nLbCTTkw2A0Nh4CIp9yTOi8bNoBTgNHsbV4CBQ2yR
 NtsEAmrIhu9IYPJGfSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020024

Add documentation for the Last Level Cache Controller (LLCC) bindings to
support Hawi and upcoming Qualcomm SoCs where the System Cache Table (SCT)
is programmed by firmware outside of Linux.

Introduce a property that specifies the base address of the shared memory
region from which the driver should read SCT descriptors provided by
firmware.

Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml       | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 995d57815781..ca1313de10ca 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -11,16 +11,17 @@ maintainers:
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-  that can be shared by multiple clients. Clients here are different cores in the
-  SoC, the idea is to minimize the local caches at the clients and migrate to
-  common pool of memory. Cache memory is divided into partitions called slices
-  which are assigned to clients. Clients can query the slice details, activate
-  and deactivate them.
+  that can be shared by multiple clients. Clients here are different cores in
+  the SoC. The idea is to minimize the local caches at the clients and migrate
+  to a common pool of memory. Cache memory is divided into partitions called
+  slices which are assigned to clients. Clients can query the slice details,
+  activate and deactivate them.
 
 properties:
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

