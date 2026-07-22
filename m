Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9C2E737D
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699945; cv=none; b=d/7mBII8PV+3gp0qYhR/Rx+2UPlaI1ZfQfasGdQS8hAKCcoNP4ZIbLZd8gmyVj1DBZq/n7bWNIX+zB6krbVae4MyYCEtfb2A4aRycOyHNLFwEp6Fkvc3Q1jOyfU86SYtCAKuSuXZXwWnzs+27bjQtGPCjo3gmfN3YbblZlTlQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699945; c=relaxed/simple;
	bh=rWbtb1W+stySBwVTYmTH8aWgwOvBKUz0d7zkndsOrdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nF7iLc3W8OLnC8ZTWcxLzdytKSws4Z3oUeMKAijzFh28SOE1m5TPsqecf9OuaHFNeVGGXxVzLKQtdq8rxG0IdUP7KvveBi5bRR46+EALPyiU3GpL5wIzYRN6mEpMEuKYKcqyCPL4Ab9eYa+mqqZuSdaKLyq9+mVIOmWpJ7ROxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZwvCShcH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j3iFH6PJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZwvCShcH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j3iFH6PJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53eFF3662714
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtW4Ak09kXgiLEZNs7J/4jrifXCWd9zql1exxl35Rg8=; b=ZwvCShcHSC5Aq9aK
	faPklVALiY8rUwZMNaDPaHF7b09Sl7SDJOTCOJdZx4LNSdQGzIQ9De7Rn+A1b74+
	I6/En+fdku7Z/GbjyIuDaqZJN/pK0KgE3W9SQJugTWbpnIu1QqrR3DVVtnvu37vO
	SkdtzCBSrAE05RdOCR/nxdhozA74KqyuMOAWM+c4t1fhMQgunxb+0h65RDVx2yFj
	AMsXXaY/iB2L17+uOokBrcSIw9EPhgk3Hn4FZw9Me+fit0HLcxxidjTa5gftEY3y
	T7fevUpwvJfd0G1nY4uzlF/Usl7bAkBM3TfqHh6naIvTQuCkEbiXyHcS/Fh7bsi8
	UiMtYw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2drd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Jul 2026 05:59:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so15895775b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784699943; x=1785304743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtW4Ak09kXgiLEZNs7J/4jrifXCWd9zql1exxl35Rg8=;
        b=j3iFH6PJr5Zrl0cObbWN1INbEj5p9/FOd9MC3N3dSJPl1OIaaR9Wo8HSPQvZlGNSdH
         DhC6GmidoJy1DCLgwGNhywQWq8OVfNjc3OZiYUO+PaJXwJDsGRWXOsUsO/Ra0P5U4HuF
         f/ZOfxWG1mUCwMtwKXkdQGt/ysKDUXSBwYGMJdzKHvPLQGXzpxLFb9dpMqCKLbkz/i/f
         nIOnR4XSFYSqDscnwgvoarlsrhyIhSB+CAU8h2G2wTWbCuT1Jt3BZgaP8MolWjUz927A
         KdrSdsOVM2WbcT4rk541h7h6AvMdF3jERTL8vP8A4pe23p4MRq2lQefVgk7+JKHRxcw4
         anHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699943; x=1785304743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtW4Ak09kXgiLEZNs7J/4jrifXCWd9zql1exxl35Rg8=;
        b=svBi1UJbdsIMSzUMReRo//yA6V+VDmk5uU9et3OO8M1FvgXEbnD5MwpZ4GwL4Qk74x
         risZrSX/Qg9Kg0/p+DXaM/oj72GTE+/lD9ZjIABzrd/C/+Q5Rg4ZDnqCxqFoWEs+QOdh
         tKcwXA/OOAtPMYuAf+cZiKeRhQiPH+y9TWS60XAAonjJDqmCDh9GfsGfTmbjvaf6a17h
         AMGuAugvEZGKeRZG+yJGRa4GbrIlWGY1wFFhTEguNnTqwAoieeJVDjBpcFfOPS5WylSa
         yIlh3AQzVxo6ObeMBfQgsTawv1eJq4UCTzBCbMO+AdCNkeBHlM0K+wvYQdBwPZv54e43
         44TA==
X-Forwarded-Encrypted: i=1; AHgh+RoQZEFaz2AeZeY8EO6DjUilBLiGQRYwMsjfVD2mGID0EoGs9Vpj9m4kMlWjNq9PmXQzrGzvYfZ18rIuX9LaLmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkU3ndv/xT6M7OQEbUv9KE0TprT5aJC+gJeG8aXa1LliB4TOh
	BeYAr5iQuM2+9RlDo77bFNCr4Zp/tLNlDaG6O6J8ZLdQrZyB/bvuhkkPBznfAN155H49PvZwbHo
	ieEFikw1U7GjYouOMPfcnyKqMbdmOr3NAJmnC05+ldriMYyEMHGiAWUBVY8G8aaatZHIB8WL9Cr
	qiTKUFxw==
X-Gm-Gg: AR+sD11kpSX794QRDnHZovkdNjwthQH03jFiJ+kB7esU21Z7dE4UCNoXLYwkjaK2Ld7
	09fF7tKBPsHIufcUr6nJo+WaV4fxO3AJtKKRfdaPUCyjJAnCCAKqqsK8hXxZqw8o+MLWgHXrrFV
	mpb4Nexx7rtx21NmLvGOcvnDDqJDcqo6riHmFWZhw1C/1L+Qpx3Y/VGIk4uWc1uFTml/BCepun3
	+nt7uW0Ji9ppvE1IhKwnNmm6VBaEY6Gw1nKfuM3Ss2wosEEJ15Q3ajqpyInyGpSdFm9CP1s5iRu
	lp2AQooZT/mn0FJTs5S2S4pzjYxpcEfmwCM9+KFjo2TnHhC4B4SU3XSTriT/CXV3+ycfOuZVfoA
	IK/7O5tirbm81lR+ifeFSO25bm17Bie6SEE2U3+tKqlbUkzQ=
X-Received: by 2002:a05:6a00:228d:b0:847:e791:d5c5 with SMTP id d2e1a72fcca58-84c2948a367mr22080867b3a.35.1784699942759;
        Tue, 21 Jul 2026 22:59:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:228d:b0:847:e791:d5c5 with SMTP id d2e1a72fcca58-84c2948a367mr22080844b3a.35.1784699942362;
        Tue, 21 Jul 2026 22:59:02 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm554013a12.12.2026.07.21.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:59:02 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:58:57 -0700
Subject: [PATCH v10 2/7] dt-bindings: clock: qcom,glymur-tcsr: Add mahua
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-tcsr_qre_0721-v10-2-d2fa68c63b78@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699937; l=1880;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=rWbtb1W+stySBwVTYmTH8aWgwOvBKUz0d7zkndsOrdM=;
 b=fHB78UmzUM7vr7beJw5MaWS1jyRYLYkJ0KXYoG6XSzfCQWGmrswWgi1F4TiJEGbb9VAqW2kdF
 QcV5ZiG6KfvBgXFkf31yv3yQBpmhJ24e3Ht1tZhac0EyZelZkf8QMOa
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: oWWdn645bUn1zkEJ8lN-F0Sns1xM1FCa
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a605c27 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tHEUkVd5BVjdM4dvyhIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: oWWdn645bUn1zkEJ8lN-F0Sns1xM1FCa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX44u/kaEsNCUL
 +kkQjfJllOXBkEjUVAzk21FOACmAVHMwtmTjwJgaj2L5oeZGi7itA0IBDDbDRRHtonlFRcKs6Yv
 1rQIEmMmSxGSRHZVW5VnlZlM/egWx25Qi9A6ydK2tDGQp/eVLL45h+W6Li1YbIuqh1QQFYwtHWp
 W7W94K3EHe4VEKnlOHaF2vYWbMwpfdvgiyaeRezPi+VGEBLGYQt06Un/wcqDiCHfaHbJCHnxfcs
 mZosW1t1L8ZE+46UeWgdqKZrndMUYO2pkEjo0W7uPCFaNtmshpAIbcwF+695Kkti5jU63iHGATB
 9cKXuYUJBjxRGbGTd7vykZaHWXhgSrfqrf1G8oGrkFU4Bs1caKL2zkeH81+bvQO6iFf0anRmneA
 bTcAVfh0ft3o4QIqUo2bDU6dCJiGnIRR4Hcsrd6EvHjyD+znQMBteEqLHdsY0mdp4AXBl2I8bBe
 xmBBgfTn1DoMCxQWjnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MyBTYWx0ZWRfX6bBHR2vIN60v
 HwG37WrlXN8UZMSMc82M0ysd1DiJ04dtPJ7rjc18W/6I+Y8WYCu+30eUIz55zK7nmu3s02hVvmr
 YSF4VOuMn7hdGZKdtKd9GbtjkcKvPJo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220053

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

