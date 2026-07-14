Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053E2E8B6B
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005196; cv=none; b=dzIFOV8cc+I6rZNl0+J/M7dNMM3RJhUBnsFLAngivWI7CoNObUvuZAS0Ajz5XeAFYDfdJdv5uqyTmrRzy8DcY1AqbPwerjq2ekKkXO5ISa200jlci4KHCW4YE6xe9JtlTg/zWEwUrX8huNO4RS5XN4bNoLGKAcwVRWxqSY3qmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005196; c=relaxed/simple;
	bh=rWbtb1W+stySBwVTYmTH8aWgwOvBKUz0d7zkndsOrdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqiEuD2jgItwWGQ7dCnr72nA2vOwTTd5oD+cWDgSw6ouqsFcbAWG0GsmOmWVEywLJ2+ORB0FPxfR7JAvHvylBHl7lltcQoyslY+K9FZMjp/YyZU6wU2eDjTUHA3ibRr021+Ts6+5Suo+Fubooxuqig3hGilqriYYEb3HR2P/Bh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1y6JH1T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CWLgc8bV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1y6JH1T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CWLgc8bV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E383hE3482744
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtW4Ak09kXgiLEZNs7J/4jrifXCWd9zql1exxl35Rg8=; b=g1y6JH1T6DfjzNF6
	BaerBrMsvlAy9iKUNiWhxq1pTw21/asu3EKKt6xD6zkOXK00gmn+Bj2FpiGbVNGT
	xUadMmgzdCSf/RayBktt7iLrdPVoMCaImbRO6HFFwe9JYyNX9Cv8HWpWpyb4ZpXy
	hHebozuIijuySV20hRiuSCCo0N4YY/ILuEXMOplRbG9VlBXmB94xnY4h6SKkPrEO
	xBhyzK7i90MKeva8FaOY0NTQ4wABXfTkWJnB/Pkw4gcZnoAonjm5ZTYu5Cs4lcyb
	JJehPMvmjh6yLO7pf1AqUKRyHsidlEsS+wNdsoN/oYnFMUPpOdbX0KNaO6qUvMcl
	FPAXKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37xa9hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 04:59:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso1430483a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 21:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784005193; x=1784609993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtW4Ak09kXgiLEZNs7J/4jrifXCWd9zql1exxl35Rg8=;
        b=CWLgc8bV0DXk+CwV2TsVy4TyUq/geqeg7Vz1BvW7Ppn9jrIQCG9uVIFIv7evHI1peu
         VR2x3edpFOrKLtHstVc5dpvz/2zRGVgH78kopdDhRTSIdWMaV4W6umYn/9PLx0NKdQmj
         BXn5IYZg/mpVVzXwMPHzNDXxHGCAga/YL3FEfWyd0s7vc8zJIWqBm0p78hmwLeeoUg+2
         xqAN8skXn+VFwjR+jW8Jktgv5FIMWciASSEwWNIb1NSKMkLdWzt7+OEBixmNY1U0IGZA
         zVBBco3/1OcJJRc+bN3kA7Tdn3g+06tM410Q+SfywHxqZTQgrDD3nb3FhLUNB/pas4B3
         SUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005193; x=1784609993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtW4Ak09kXgiLEZNs7J/4jrifXCWd9zql1exxl35Rg8=;
        b=N+SHBjVx2Ax88bhHaJLzhIoN6ThlSYIqKlBHynAKSX7Z97WBehlwx66I3kHGfoba32
         naR/41g+H5UaNb4Qi78GPiFujgeGOzX7eEB7mh4jrFbv8nRS00A993t7opi8MUzwVIP8
         zI+aR29592/i9XMjhAODVxT79DeR67j+Ub6f2WIv8+FeD6N0Db6kt9LE917zL4GzpZHt
         gvmZn1aeA5P3mxXpiKc9qnbomiINj0V4Qqm9DtqYMeE09pyQ7bP9Pok9kjO+S9/8rxXK
         yX61gH5z7VjeucQVG1EOAVHnbVNmfVcdAu3Ko95PsKFfq7iwFMwQcSw5QfkFX5DawxGW
         efKg==
X-Forwarded-Encrypted: i=1; AHgh+RqQMDChCl361i+TdcFmBYBCaIvgfWGl1x4QFamTbqnoZ+8T4vcWyI7kTpoRThiiL+oAyhySjHJlEqY2qvh2RfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSPZWJBfIrlBW6X0hAo+WtsZhSK4JPViaZdJxtSqAptIkDGJM
	q2YVy/18sX0po9q1my+GEgDJ6JJhWLl/K+avDoZ/ZdZjCKD7I9hljoncxvGsObKqT89I5uA8+9x
	ZmUbvA1n1grvYqYyQcAm/P2Q9HbJp2CpscjfT0syvE+niRnuLX4IuoB1khUfr2YzuOY/Ny5Q=
X-Gm-Gg: AfdE7cnJePBV4W9+tZj/s8VIdKKWmr7Rcj8iJLIvNhU39N69jWtWpcIyQcZk/wJMNXd
	AgrvnGneK6KeQuf2PS0L68ORhsoiTd5EU9wKe8fG6VRqCEf7Ncjgl7NWqF8qWTe6UK46yoQksaj
	Uu7OENHR7+kpkBjzVI8sZ1TfATNaaijVt7DTVxyMweegUoavSf9lsiyFmv702WvSz6B5qnPiEZG
	wJF8Lr9fjrBLYY7HqtkH0nOJFzK1/21p3bA2LG5vaT2IeOvjmtrbJUu92VI4DyRdL9hClHt9glN
	ad+TDPqYVWRDbHivmcGp039Da7xd4vw44D419jOEDdQLAZWa2kpg0OhpCkeEq4gbg+nQRYGlQ8K
	jjiZbM4GidHd77nqngJ2UyoRNtCfk4Zsl/yoMDSNVsOHLU+pHcbY34BbbDg==
X-Received: by 2002:a17:90b:2750:b0:387:df8f:1405 with SMTP id 98e67ed59e1d1-38dc77badd3mr10713095a91.38.1784005192923;
        Mon, 13 Jul 2026 21:59:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2750:b0:387:df8f:1405 with SMTP id 98e67ed59e1d1-38dc77badd3mr10713061a91.38.1784005192490;
        Mon, 13 Jul 2026 21:59:52 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm41874021eec.15.2026.07.13.21.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:59:51 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 21:59:37 -0700
Subject: [PATCH v9 2/7] dt-bindings: clock: qcom,glymur-tcsr: Add mahua
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-tcsr_qref_0714-v9-2-373670ab15f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784005189; l=1880;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=rWbtb1W+stySBwVTYmTH8aWgwOvBKUz0d7zkndsOrdM=;
 b=P8t+Vk9j0quvabeBmT1OdSoFANC9FVLIAbuJevQ1qm4wbN2sJdQmDvyRxiniMg6PzlT4XgYcq
 TRLkHILtCrhAx7A84t/1I5FRIVZ121m3BHONU9+3jxPhK7UVaGD2dLD
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX7t0SSsk/0aQd
 UnJc8vJ4DC4S3gV7yHyjJvic3GVb5/4hGTAWa2+UxRAx6P2eEs1CSOmY0AuOMReUi3FSwpX2mll
 4c5466xooniqdsXAgmVGO9zb0zmwLhEkuAZlZzwDWS8CV2U234HsSrz9WH7N2XmCo+ZPtP80NIB
 +njI0bKejJTwmOhmW5AzRuXkkmgI3Pg3AjNEtWVnyfUyHhhemekaIwVvVRFLoEZDaUh7xX+pGaU
 FVV35t/IwY9AQUkBW1cGARZLL6H7pmW76W2+C13riZWS/Qb+3bnJueYQ7AzEbdjYREsiAYv6TxP
 NqnS+XbibN+eVKFUhW/pXH9Sz19dU4NayMmsNsS3e6yI6EHIjBSndABZVrMgDc1H3aUVlXerY8I
 o5fjLWMFPWsTs0uKGKWHzpPYIJ5fA/4djOJ9h4uo9FxO+nEr1pRhXOaVQq1FHz8Bq/9p8JsA+02
 wQA6w5wmKT0d3oAHP9g==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a55c249 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tHEUkVd5BVjdM4dvyhIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: hCW6l9bWrnLgVPnbMBfvrkskvpw4cZkO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX40mZIKRE5gzR
 Fl7i1QRES8DZu8DyQ3/rih41kHCeCDHFvXryT8HaWX0yFqJ2xyRHrkAiH0263uRHwZVHfP8PsTh
 eMLCwBwKhi1rpQmR5cUab54hUu4xefw=
X-Proofpoint-GUID: hCW6l9bWrnLgVPnbMBfvrkskvpw4cZkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140047

Mahua shares the same QREF TX/RPT/RX component naming as Glymur, but has a
different topology: a single QREF block fed by REFGEN4 only, rather than
the two independent blocks fed by REFGEN3 and REFGEN4 on Glymur.

Add qcom,mahua-tcsr compatible and document its required supply
properties. Note that REFGEN4 is supplied by regulators vdda-refgen3-1p2
and vdda-refgen3-0p9 on Mahua.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,glymur-tcsr.yaml  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml
index ec89feff89e4..2b6422627165 100644
--- a/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,glymur-tcsr.yaml
@@ -22,6 +22,7 @@ properties:
     items:
       - enum:
           - qcom,glymur-tcsr
+          - qcom,mahua-tcsr
       - const: syscon
 
   clocks:
@@ -82,6 +83,25 @@ allOf:
         - vdda-refgen3-1p2-supply
         - vdda-refgen4-0p9-supply
         - vdda-refgen4-1p2-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,mahua-tcsr
+    then:
+      required:
+        - vdda-qrefrpt0-0p9-supply
+        - vdda-qrefrpt1-0p9-supply
+        - vdda-qrefrpt2-0p9-supply
+        - vdda-qrefrpt3-0p9-supply
+        - vdda-qrefrpt4-0p9-supply
+        - vdda-qrefrpt5-0p9-supply
+        - vdda-qrefrx1-0p9-supply
+        - vdda-qrefrx2-0p9-supply
+        - vdda-qrefrx3-0p9-supply
+        - vdda-qreftx1-0p9-supply
+        - vdda-refgen3-0p9-supply
+        - vdda-refgen3-1p2-supply
 
 required:
   - compatible

-- 
2.34.1

