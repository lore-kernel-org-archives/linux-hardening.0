Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C0446C01
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778290; cv=none; b=lRloUS+FHeh9HtocIkZYbydXGPxTFK0ImrsM8BTSOwNjR3REFTCambGQ3wU+vnqB7z3Mek57k44mEsoMixrdjPRsKMjPIbJXxBBRvFPVQOOtaenT09nBZaXQRwHnkBsGtd0+YnnGVSbnPI2ssvGvO2nAmrC1ZUQqADO8FAi7T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778290; c=relaxed/simple;
	bh=i/EfGcaVwPdBD4d/EhaLA+xeFVF7rZ7sN3Hf7EI7L4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3ffCvgjN0Fd9Hj0ksJKj7O3B9YfSD52t4hhFJzoq89PGYD2F8mHFNso5JOIdwq5gW3o0rHS4rKzTaJQTILXeuC8GlanGrmB5dfg1MShlZjfyzjgsiparIPlvj2k0Q5jNjobjW/xMBoBTstJSCsjRXfOy9lvflupHrNHaBWwXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NkS27gba; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j79izR2/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkS27gba";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j79izR2/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnRJm004319
	for <linux-hardening@vger.kernel.org>; Mon, 7 Sep 2026 10:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	49efvhs3N7tvBoNjWBAmSpCtljSdwWvZsY5EPmUlnVY=; b=NkS27gbaG9d3MtXD
	EallBjS5w0lf0sqjQLAsXEOywa0b2z0b052QCQ1y1M4O4+dlsA9xeG4HXFExz0h+
	jUJFk+4RqFImX02ieA2adl1CAhMSFb5om239ggLmWUazZM5TEfE7Ewxcwo3il836
	f1Ji8CsfCTH19QE+PrT0ijMcCR8hjrb9qMkA5WhC/t32O8AsaMX/OhtMtqwQQGfH
	TpnH25dfQ3pHJe0vBfyVPf2gIYwgiUsW+B0F8WMOEygtZOZqn6BDC4anI5hne7V2
	sop9JBy0pZYYFF9eDfhigjSL1J17NzdSOe6HMexkmybb/FHSlMtkX6OLj096ILr7
	W+FUxQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg0mw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 10:51:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936e393061dso457232285a.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788778280; x=1789383080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49efvhs3N7tvBoNjWBAmSpCtljSdwWvZsY5EPmUlnVY=;
        b=j79izR2/HteKSAIM9n+xKBYPrcPp9N0AMBKowOvgX7aFOeHnjVmphICkkxUIkPZewX
         qZkXStNoku++bUrtTJPhJvYE491bwFM8+8EWpo6pgJevCzHbSp/IrARW6IrfOa1N00m4
         X6Xre3U43xvoErvGNizTYOW9AS7BrZNCOGaTFWjVMAeEOJ4Xq4GosOuBUfrQQJPJw4QU
         nZva+4YNmUXUa5IfoomI0dMDbTwsb6UmRaZZpWmo1MU9Ax9t7YGGmf9wTBBtS3yZzReK
         MueQ1+YjKQUulh2fCCHs7OBSy89knSN6DAlIvyT+sT8TlfvDiBRW2HTf4+fKkG1nwgYh
         ScCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778280; x=1789383080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=49efvhs3N7tvBoNjWBAmSpCtljSdwWvZsY5EPmUlnVY=;
        b=NT0t+7XwL5Zo85uVU8bEHjVsPhxJ9oulGSD5aUgV8F4h50byGLqb35J4zf82BMrQO+
         fvQpGAalTdjs6hz+6nkrvB2sjb9wAiqduTx7LwbAqFd2mNvI7gO4Qc/4vuiy17rUwFAA
         S7M1mxpy7yw95bom2uTzzACV9AMpImPaTZQy3gK+OoJnqn2U0lQf6qrhUStPlG8dgfU/
         8hKktelihOsiq2NwtV8Xluo+YAO/99gsYlKQBNjonkvU/ymxAzCP1oTxpGoD/pupxJEw
         YJmqDrgENrWWUsZY40JzgUH9+BQQJMokurkK0L6bBwMbwGBceY0GnXvpHkr+6bg5aiHF
         SscQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrPd3jXRBGbtBzihQzeKAZddFAzhjVD5v2rfJeQZ+e3MmR6zE9lf2qhqM3sQ/FVgGW212RvFdRml13c6tBpW0=@vger.kernel.org
X-Gm-Message-State: AFuF++nUcE+25IU4RyMSRq92LXHCQfO/T7TyWQXBa8zSzgC0ZMEZtlQz
	OTCsTxsjRWW10IMlfVx3tXKSaDBkasCfC5oHltNIaa4faQrcO1+r7ehK2uO3ZbT4EYWzK6T/5s7
	2WY3m6YcoIjejXPupYPSCysLWa/bGN/tTV10W9bBBkLzdm2b8twNuzYwEW9XgwqvixssKL3A=
X-Gm-Gg: AYBFou3CtHEPDEEJNP5EcC3rk5oLT9a7ZUliHKRcyjz29jjeG1sY2goVOcyzRMEM4se
	4xfB47aw1ckTEwWmt58KWMyQqGueOV/M5fLes5gXVJ3bdCgw/22PJaGMWhTgZ63+4lGRW5jdTqu
	v8v3Yhhmp315gmNiIxfIEPMtU/5O+eSSTKdiH5v8mfNrOMMFlyEKwyOh9UxtoXj6cbYGMLttXHw
	iAOVkUzNndis9n7ROTQWTR0w85gYQOI/+x+ypmHNGSGHfQYMkX0zYYH8nzWAIz8mB6QPIs52fop
	e32E5/XredYCZXsLgYzq/2qKpgjc3romfwNrSsXKR5+aLaOpuOckz7hKlsgFPJzOjggo4XX3zZx
	8zMyug01G1k4C1+ysSjoI/whzBfr8A80+e/VVM8P7eYLPiXdrwxSpAB0UV5fAdKfQgieUNKGEtq
	OMSD7gg87+PHVcYewZLgs/hKOF65hPjatOPzu1l+IzIsBJyV7Ryp8=
X-Received: by 2002:a05:620a:6086:b0:915:a953:4b9c with SMTP id af79cd13be357-93980324543mr2237088085a.3.1788778280558;
        Mon, 07 Sep 2026 03:51:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:915:a953:4b9c with SMTP id af79cd13be357-93980324543mr2237083385a.3.1788778280175;
        Mon, 07 Sep 2026 03:51:20 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm410263775e9.5.2026.09.07.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:51:18 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 12:51:13 +0200
Subject: [PATCH v6 3/8] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-camss-isp-ope-v6-3-6b915b9c5131@oss.qualcomm.com>
References: <20260907-camss-isp-ope-v6-0-6b915b9c5131@oss.qualcomm.com>
In-Reply-To: <20260907-camss-isp-ope-v6-0-6b915b9c5131@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX2zB8pQyWXmZ5
 FlWQO0L/mpyKg7HAnaHIp4xi1HDMsAz7ag3CQNsSIqzppWELuT0vz8aGwVnpvaMbCrmIn25KyQj
 lRb+QZWfYc5SrgdGW33Dhqbd5tJaVc9mqXWbZOXWYpMolX4cHCQ891u17inKBIiKxyqjNIoMEJR
 z+QEvIA2MgNpdj639UFFhsZo1j6EVU9H0x6rpaI7h9OD6tethl9SQDOe3sMERVxY3EXdrq5MI4v
 kHmULKQERTUUoyjg0oi7o0DZf7PSr/v5DucscukGe7E90ov1BuLTVQrFjU4bQW5CSFjNVZN893/
 m3yjh/6CAb9f4KviRWG2UVpDON5oBxdtrXECCLXhdFAQB8aGLmkHYu170JSaq0Q8r6kegcjhP0t
 bgGA35T+6/OfYAEpMtpgSMnqf/hjF5uGtZkgCkT/KyosaX5YQYw7bdl5uB6uaev5wJYH75uDE2r
 00HWcWsQ6AhIw4ES+sw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9e9729 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SR-doY5mXIUmQjes8f5jTrA2L9_OW2Kc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX/GZR1g4aJYKO
 Zr8xN5bOriPoLMSBEX+MJaVRmQ4PuogajtsPYgp4XOgmA7bZjHgwNy4gnpQ0SVPpWqCGsEe4KeF
 Azj+Uj/KIkBepNhZFVph8r20c21AAIU=
X-Proofpoint-GUID: SR-doY5mXIUmQjes8f5jTrA2L9_OW2Kc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070118

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Shikra uses the same Offline Processing Engine hardware as QCM2290,
add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
as the fallback.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..90b54b9808e5999a4dead404aa2063ab695cdfd6 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -19,8 +19,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss-ope
-
+    oneOf:
+      - items:
+          - const: qcom,shikra-camss-ope
+          - const: qcom,qcm2290-camss-ope
+      - const: qcom,qcm2290-camss-ope
   reg:
     maxItems: 6
 

-- 
2.34.1

