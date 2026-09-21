Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F54BB275
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005007; cv=none; b=RWz5CrHUud+/OG86oDHfTD53D7mxxSy2+278QjZ50U78raQiuK0RqkpuFno4nRg4cCqveWwX3g1Wqckw1m3GdZSw+rIvcMgf7MOQhSV2LQ9QMFLL05oNq5XXIg+UoCT9djvWM2C2zYSLOC5CSRqw3wwxU/+jT4NxpsHRWZVNvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005007; c=relaxed/simple;
	bh=H3FZ7znaCS6E2tCa+3jHj85kDw9yZ0pmbfqMcQI6JqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGmY0SG1CmmITBmZJHcABmN25xcEtDlOeBsx5uS6GA2NcRgbegwtUsn6JdIxNTLsD8IyspnI3tCbG63vkNoL5Vl1E1pP4H5Om/cxb7TuL/BHpdBbGWLavNtq4b/VuGrvCnuxyEIbxkI8bav/82gfkYXTYkjnFq6eu9Lu0tq2yx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dWbQ9jUe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HeOeX011; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dWbQ9jUe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HeOeX011"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFABmb1532389
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=; b=dWbQ9jUezQSJ1tuY
	T1FrdwSBXPFscE5nNBotwR9KY+RQClgxdJ7Eh3nKsIpq3uprWwc2VT6riLALZKFN
	JZ1P0uO8FvO48KBuda7CqQsSIT+c2HFGCqHtSKceCNYH8vkXs+2hddrAtmG09shs
	5dWoZwkIHt7oR7/eVGEfYJXBhjiCJP4U6DH/j+PJMIJrWsEWjK+F1eBP4ob0wlWZ
	4RvkLCTKxq4Cp1/Uj2Hv6yOFvCKpPnjp/Hjt47H+gZDunJFDsKJg181+8W/XIQpe
	WsUOS96FjyptWRBJi95Gn6TdsLaCrgm8EqxUDuY5ukXDXyohRSI9nnwnUR5Ruj+e
	e3js8A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8bbe01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78faf713ab2so749216137.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790005003; x=1790609803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
        b=HeOeX011pehEoSKLv2ZUhMJpfX2NH9XxqoWkEZAZQDUtvFxSBevbStdRwxF/lV4pjG
         F5i1U7YclRTyxijPBKhDHsAYdezlJlWb6t5XRa/qu0R+8qKJNSu5Cyb/z7tC3gjgx8oT
         xDQEmyt1cbBXgAI1DuQt4CgOKE5GdTj/JOCD3225SWNjYww+E0DrdUkhSnPi4nKklPQV
         n7fHROSeDvaEdDRAFfhCXDy7u+IcUckSoNbGyWA+c6LjiOybDTwFzryrFMPPItuIkEuR
         jLhLgozyxhTb7L9iTuRG+z2m+fkrMQvbfn/ndE8EZ5NnAlnx2S4Dpb+CdBq8ejl356qL
         Y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005003; x=1790609803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
        b=zBiBek1Yo6iavy9MG+JkwAqihHiEd8cZzQUFEfaDGXqQlA89O+UZPsapqpYH/BNt2v
         iakVzVkf1YyM4525ps4NHlhFg9SlN6HU66SoLTCzZqJSC2x1E/p45Vm6IGXhT30jF0kp
         89ugZl+loo81NB4b4uC1vXYM7p95sJL/Bjm11CNHd/FcJxpsq0TrmFHOh3noONBULauL
         ns1HIALI6fLBa9j0x6GO8O9RI3zzAJqJvt4wonUC9gFaR9QHuypVr8vw9FTcoTqzyTBM
         3KndXzG2OvxaYjj84DcxS8Cc1pGLn0Lw7kU+eZC7teFw+PNOqLBpcQp4BBQikEcu9NpO
         8kJg==
X-Forwarded-Encrypted: i=1; AKwUvByQgZK+6ivhAWiL0GgB8rLIDbKsrf+u5hG0/fydtcDT+nrtHCiqYQmEO1ZdLGNaIBgKjo/8lss6ckWqjuhAk0E=@vger.kernel.org
X-Gm-Message-State: AFuF++kiG43PayXph5IdO7YO9NwDCHlxlAWErlmgNUR95DJSqvLzZh41
	DaTvOzeVA+q4No3aCZjGflPLrkja3w9D5iYhunIFK8xJbVUB+CtU+z1HvVoTJ7cF5KlgsX8Kc/o
	WH0TuZW5ozxheM/MdXJcrqH63az5ndv2+0T5ums91xcarA4M9NWEl4gp+/ODMGsfmd37p7T4=
X-Gm-Gg: AYBFou3+0+WqbPxYAGekQyWSbZ4SWc5D3ni4MpZrKgAHosDuDblIfGq0WBY9M3ahd6x
	W4l51TJrL25KFDJOw/Fu1JBeDX4cx9qhoile6ISYc/cgXLYvPgOFuCAcbNsEqyVTPYEOLlG/qLi
	16tNQnnbW4zz3ObSrRxURDM5heqY377M6xQeG2057eY1II07Xg6+Cdy3YwTsLBypu6rbHcfbw+K
	wrix/4CO9G7nKLVlK6CzJKC+DYDqHOD6ztTeEwLhCh8Otb2xQaj0X1H4u0yUAltwI5Etv2bBreb
	g2vEKuEFPa0yw6NT/pfHhmRhfYY/3p3JpcJbRQCMFyXK7Ehz3jmVSnXRCm1ESupJyPJzi6qiGhl
	VgQVq6t36yWn9+MBmixSXy6mgClr9A+O99A6Qngowin+zeIFxtrcsdp46P1hpVuCUWsKtc8KI+3
	EVEASHkZ8t2gXhb1vY/CTsYtabAq+FvQ6XpX6Z6C7Pr/9ZX35FaVY=
X-Received: by 2002:a05:6102:6b0a:b0:7a8:10eb:96c4 with SMTP id ada2fe7eead31-7a810fb1f76mr2252332137.20.1790005002774;
        Mon, 21 Sep 2026 08:36:42 -0700 (PDT)
X-Received: by 2002:a05:6102:6b0a:b0:7a8:10eb:96c4 with SMTP id ada2fe7eead31-7a810fb1f76mr2252292137.20.1790005002356;
        Mon, 21 Sep 2026 08:36:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm231054065e9.9.2026.09.21.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:36:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:36:23 +0200
Subject: [PATCH v8 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-camss-isp-ope-v8-3-dd1c86a3c8a0@oss.qualcomm.com>
References: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
In-Reply-To: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX02x2SmqHi3yi
 4EKvV49uyTZEIXoSilJWFy/KwEqShOJK4GHqQKjYRRv2m32c2iZEEiOgVjySkIY0f4xAkaXMjni
 FTfR6PYLN0rkdhr1KXzuNs8hXvco1bNZXHzQoNxCtBPug8J2s/960cs5Gzl9zuXENPaQxkMAOUI
 vBzl9ABFgzxA3B7o8Mf8vsVYtywsPpy7HJ7nuw4JwaT9K46fzibJJf+l8KFophH97HtLEu5uKqH
 I/4jc54i1y2Vz+3Zw4P9LptkOE5Sd0jO7qtMq+UMnOm8Q4sDw+1A0HTpfEI/Cjvi3Xc4J7mQ6MW
 WkEPriJ0Tc8Y5LhFhw5VpwtAG+/NywmkJqoUMaIu5Z8uGVPC7bRYT5ffMlSY7tH7gbTAsQ5J0CT
 c4zEUfndWCk4JsKpN8JfwwhQ5WrjQUNzCEQ0wf0uPmq3SpxJ4Qy7xgmVO02l3CZ1sLneVEkms7f
 w5Tjf5WhtfCFQADo3rg==
X-Proofpoint-GUID: voPEGtJg8HmhFqQQJUKOiqrKbYK5C-xP
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab14f0b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: voPEGtJg8HmhFqQQJUKOiqrKbYK5C-xP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX9kiYktZws6V0
 QrH+MlAIOvKe2T7u2CuIJ1Hr85gzm852Y+l6X3es0heVm7FL8yOIIhw4pOCgkKzroj7chY28iAV
 4XUjeHK48snkRwUW6VQYp9W6ZZej3Wc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Shikra uses the same Offline Processing Engine hardware as QCM2290,
add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
as the fallback.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..3359581bfb13e918bb4efb3bc41749e60d772ef4 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -19,7 +19,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss-ope
+    oneOf:
+      - items:
+          - const: qcom,shikra-camss-ope
+          - const: qcom,qcm2290-camss-ope
+      - const: qcom,qcm2290-camss-ope
 
   reg:
     maxItems: 6

-- 
2.34.1

