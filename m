Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5B3BAD9B
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294018; cv=none; b=s04RotQCFlMu/bb9hDeTMtmyhvNzS9Nq50ITVHzDA1DmBgI8FGlQ5VOlwawmSKksNDDS4+/3AZkoCj6Tze4OrAjgbZXlw3YGHEDtOPIOupCZeebbXWd35TOzuIPqQypK5JuXb+T2b6QIp7BveRK2lhr1WNq705UmV6jU/I8N0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294018; c=relaxed/simple;
	bh=t3oD0Wav7XG6nXX5m+LNYCFF8Do+gS8hdZjFgoDgo8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lk/vKEmv5KJ5O1ztRdyy2pjS7zminI2/igc6pd0rMYrQlNJ8nNxkmifsx23ypp9usM9ZiDm+T4y74Pd+Ja6NOtlSexlNRvC1TdQ6JsItdFNEza4bMTwtxVptX9mVx2G2SoKCpCrc/bXAPgi8+AdEu00t90xDWbn35LUB6AOfn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFX8rnwF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S1Wi6fqm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFX8rnwF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S1Wi6fqm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TAaW2793059
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LiDzM8ITkpj2w4YZF7EhsRvWIrQfPBSfCjKhrtsK9Ck=; b=lFX8rnwFiwmXWMMV
	uKZWpXFNFFpewz5mV4Blv5ebSfs0DLv/1Evh8VsiDfUtNGIQqCR09+Mn2KrVuyfj
	DHzwr1ZJ4uV8Fbnbz2MOo2nfsluC0WQ4hS+3/gAcIBqAtDcmX6cEU2JfDf2Y9tlJ
	t8fFMJC7z/bDl8Xw/q+D1y89VxTjtjhh+MuC4q+yp7dRP/FvQgmD8bn725XU3L9H
	wy8ASAHmObO8Um5OyCdIaiPHgDmckMhA672HEQlOuSNr5Z8aOoW9W0Z2H9CRZtd3
	NU3qwxGWzqBiwD99SX1vhpOrDjm11MVK9fd3hNFTLCpemNH+QtlYWwV1lDLVfbs4
	CK9oDw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsa4uv6xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fb3c7b989so113829601cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294015; x=1777898815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiDzM8ITkpj2w4YZF7EhsRvWIrQfPBSfCjKhrtsK9Ck=;
        b=S1Wi6fqmYU7Y0sSWuPDqDBkwHXyUemTAAFAVl4VoXuDVHqBIv6q2PLWNsDNz8NaMpe
         3pPFF3Jzm8HbAHDa8/PdG9XlJXMzdDi7l1jLDSQyIuMWxCOoyd0iYLPeu26pJ0IeYrX8
         E8hDaqcIyXW0YrV8hul2rq7JjK5pfxaPlcT+QcCQjDD37+gClRSu1rbNRYtyEuNvm+pM
         IELOVuFL6IDG8DpNxcqXzBhWN15sH+3tLC9KmXXfHbby2DyDcW/GPwTfKjtVHTquykre
         a8O7wusZxVl5XcOokSH4mhQNHGKCcJrgYqNNdURYW5RFiktADFvp59fWkUdXRyNkCYYR
         QkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294015; x=1777898815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiDzM8ITkpj2w4YZF7EhsRvWIrQfPBSfCjKhrtsK9Ck=;
        b=rScFGDZYJVabPp9ZytqW1rMgqNG/fU60vYQGQaDOGCduEROUJ0w8sx4ywnSB4FsPam
         hAY1JHvlWMkOvMUpqWsnVL0xQ7H1zk0ftopLbhnuBAWd8rb9Szl18eNvDaiVL/TVFfvy
         6+DTI88+Q6o9y32HFNOkv02EgYfHsdqaCGQLhC+8zQY0QcJXf0wB8NO+PZ47Xmy+cyU0
         V+PicKIYSabxEy3cFS3WpPquo5Kpi2scUcHydPWD2h2kwDrvatxMMpixCCBksPmHSz4D
         PPrkw6wblKwMfchH4RVfZjXBTVWSiUu9qo+kMt4D77wwQSFFMjRtQSy3ksKvnVT5x1ML
         bPYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P3elt/IxdsiL7N9P80GaCg9VGejNRBpjTIejtCmBAq3G69AhubGqdsXTh47up4X2XqeOSQPOmrrn5gR+7KBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlDeGw6t6H0fzCzTtqc2p0qp6yk0DMSzsDBuOnRRpl+9gr4ts
	lWRlRTxnGrcfqQ+NGk4v1THvLFBrnhaJzhl241M0Oa3p4N2UGxEWG0bagaTelYnwqyWLIujJkmT
	gErvzhus/BYEWKOUakZSLjq7ZnjjjSoosY6rRtG5O+xqVgaghY3MIWOYL4dHqQEy1CP/Dja8=
X-Gm-Gg: AeBDiesdU3mg1Nf1OLJf/Dquww1S3QClEs7gj3lnZ8/+WR7Hoh6Wb9BdbPBtbYZhyzj
	z3KtY5iUXZzEVNLzNdgLnmDESjD/e6nOauUTnChlfvasfIbk0IoNy0WG+l8FaHMr6nk3/tKRn5v
	Q5ixIFswSvcKzBLbx17Jio6fZnn5OQUtqOUxk1Z/lfj/BLzvU/WmiJWN7sF0AYrdKDaljWb3We7
	C/xB/XOT6yWnpmJsuXuL/WvQMbDTO3GUP8OZJNMj7hcT+qTZ49CJgZjVQxs4CbzEnMNmWHBwMqU
	78loRyR8NBF4CHaSZhJxxUED5I14ppXOFq3Cjz6GnbRdoMvEUrXqtNHNFyhtExJI2eb+JyWbxhP
	5FZSGxNLndf3OaHeXODQxZXSOeXlRaE9+BIpABeb761KyoJF21IMRAfn2xGVPwuXyDKkqgJMq9t
	A1otDMG1EVn5hnzZnkaKLHjjFrEes=
X-Received: by 2002:ac8:5d12:0:b0:50f:ba44:ce4e with SMTP id d75a77b69052e-50fba44d76fmr368833251cf.6.1777294015194;
        Mon, 27 Apr 2026 05:46:55 -0700 (PDT)
X-Received: by 2002:ac8:5d12:0:b0:50f:ba44:ce4e with SMTP id d75a77b69052e-50fba44d76fmr368832821cf.6.1777294014697;
        Mon, 27 Apr 2026 05:46:54 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:38 +0200
Subject: [PATCH v2 11/14] dt-bindings: media: qcom,qcm2290-camss: Add OPE
 ISP subnode
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-11-f430e7485009@oss.qualcomm.com>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: pH8kA3KC2EGfztXONMfIHmRP7OvIOEiB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfXxgECRIHbT4cM
 czXQO1Rog20/ZhPQ2b9z+7t2k2jE75PT5VlMmv1ze8HPuEbl8uA9DsJDuQ8ib4+FPjIJNIyIxlC
 Ytw6FbbiG93f75fS8YCbozzxvYIDszt2lsSetY5+oD1Zrk13l9n/eW2xXSvgk08+zqC4mlb7YjX
 HEPzjnWvC2GGHXDWxNWjdsx6vbpvaYLHtGq00linFAT0etfugOZrLJ0fM5q6O1sa8Z29B1ESKds
 ioeCf4SJKx45amppxiw+BHRIFdtiuR7JHndZ3GdyZXhCqMJ33Uo8uE/m0Z2FtXf+MFqgbyhn8kj
 ymNAMqR1w5oqlj19hFES0drhLfJ7xX146s0st5HkS0GYZS/PcFfXPW2ilGomGYlf7KjfpHayziY
 YXxUUNbgu5d+jQKXZE1F+ty0Vgh0SRsmeVfPYYSXHfvddv87xCPYK12zZLYcRu/qhJv0vaCjS8p
 P+JEBmIfbCl1SfM0vsw==
X-Proofpoint-ORIG-GUID: pH8kA3KC2EGfztXONMfIHmRP7OvIOEiB
X-Authority-Analysis: v=2.4 cv=J/GaKgnS c=1 sm=1 tr=0 ts=69ef5ac0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270135

Extend the qcm2290 CAMSS binding to describe CAMSS as a simple bus by
allowing child ISP nodes. Add the required address and size cells, as
well as ranges, and validate ISP subnodes against the existing
qcom,qcm2290-camss-ope schema.

On qcm2290 the OPE (Offline Processing Engine) is a memory-to-memory
ISP (Image Signal Processor).

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,qcm2290-camss.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
index 391d0f6f67ef5fdfea31dd3683477561516b1556..d8b356028e24c3c5b2e9b7f20e220db7d491ad68 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
@@ -52,6 +52,14 @@ properties:
       - const: vfe1
       - const: vfe1_cphy_rx
 
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  ranges: true
+
   interrupts:
     maxItems: 8
 
@@ -117,6 +125,11 @@ properties:
             required:
               - data-lanes
 
+patternProperties:
+  "^isp@[0-9a-f]+$":
+    $ref: /schemas/media/qcom,qcm2290-camss.yaml
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg

-- 
2.34.1

