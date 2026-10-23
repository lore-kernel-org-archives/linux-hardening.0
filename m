Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768194;
	b=UzaI52OYzPIXS1Uj5ugDaYWl1SkkuqI4e5Jx9dfAZffFoLGif5h/GNrYaJVVvyiq4K0B
	 xkQl5QA338al/rAMomm+yhnSMZH+or3nvQ7f9bc/z+zFH1oa2WkevzJdXL1+he4wOPewf
	 ZMlPfdze6MPAr1R04gQCQBjFINv+7IWWfSoNqvGqiO5HbzpBIsHNRblWHAN6Y+3BlbYre
	 Gxx6u4Ggf2DU8tn5wZBUxqgGiJv55KwZ7BcFKw0UeLj41er7n+zkScjnR+hDbCIZCMUZi
	 oJljSgRPP4ir2gXXD1yMjL+idPt8OOXkQqbVkyQ/omPSUVMM86FgW4wG30gCHRxpTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=;
	b=IhnUExaQmL3HMdpJHKprRGjJ11rmDcFwGaEmiSORcjM9xHvWNnXzw8KT+fqJqLzvAhC9
	 +Is3bUYf3g3D+a57BnFAXNbIG7Kolgo7wtRHJb+Vlu1Usk8VY2y8T+J8YgMr/IOrtGhGj
	 XWYGZAzVwSpo/jFT431sf5MqDAFS7B/GnhJKCnQGA9InYXH1PhAIPi4Aij+fi7358ajei
	 t7BNR+8yakfdVpsCHJmsWk+nLdLNSaC4r0itGIgcLsWYQKdj4N9jQeeU8H00ppVzo0ZMz
	 /dJ0u3kJsDvpYx0s5wTQh3403DfDD8qY5NOmLq4ZUQuE4zGImVz6x1Li4j6UcFytzZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=py6aQLEB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ReGk5p9V;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EC606C958
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881EC606C958
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=py6aQLEB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ReGk5p9V
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE7Ko13002685
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=; b=py6aQLEBrnTvjNjU
	gz7uI22+xwpuJzETVKih34DNDaXYpQiDG/Vw+7ck3gZZn+ACPRSForH3VG12l1uw
	NKH+7didgfxVfOjWgkyT22d3pZxBhS1XNci/Bp1OApEPg7bjlXoZ/GPpfBQ4aLes
	+Uger+I0Qly92vg9OJul2+Z5ROMBDZ0FZ1gNgWYWU27n5vNPxVAoEfNf4IIrp84O
	CPSSDOrO68aODZbvMp/pDIcVEpW8dXxSPf0FdxyyrtZUDOr8OWxQ80omy320pEfV
	1njcrBcJpUu8c9UIpPmcsOyI3EbAN1EZAdKNK3oQncT4+98Gs3HRaCjF7QMcjo8q
	u6m6AA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0mqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2005ce21so167477585a.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768192; x=1793372992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=;
        b=ReGk5p9VKJC7gySuEs2XffAnHgdebkv6gwvtb5BqhJRTopXQ/PjHRlqO8kDhhkxQZj
         Ci8Sa4G9XdJnfE6LqzlZVlV/yApGX9NW7aUhfUlZjxw1JJ0lcpkMuyCTR6tRogyfboGw
         lQFmFietT6mulfE0vE6Y+nu+Xumx+qq8aALWG+JvRHoSx7vTN8XqIP47Mqwk/5j+3F2n
         O9+ogMfocNrFgy2JgRWY7Kc5N2J9CPOZiU92O/k9uBL8VIPAi493h8FcrzdZhTjOzcwJ
         gbZT+ML0sW84oeWOsqeDocelizaSqfYwgpqUprqVGFrvswUOtgfbedt3kJEcZ6LKMZxM
         5UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768192; x=1793372992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=;
        b=mywMvRdZk8JVfNWRxzKU6FZC0yuLMlqpiDwKr8V8PE7BRmfv6XKStXES6PTyekbQz6
         g8eotiHF0WVgpqR9s4SKKWulyZ6vbdzN7rcyk58kVjY4VlBvO+oOuQWi7wf3Pw2Ms2ls
         x/9EdYaGQQRoY9RsghfHwlVlwAOv4erZuLPhtd27n69e6WIsw5kMnaJKvLvxkUOX6IPo
         WrbZBgReqQbRQybEKHIDGDYilGcPD6uD0uFh1vT1ud5WBNPVQSdOPO8UZJtZ+hj4HJLO
         OjWaBYEl3SeeF1a1EQPYWkN32YyEjRTohfxRSnOTWjBO900JJkxxtHR2OrmB/GOeWlYh
         HufA==
X-Forwarded-Encrypted: i=1; AKwUvByssZU2XoO1CKEErAP+rAdOx1Wy5rnNvqk4yRNnq/p9tga2U9jO4DYGBS+iu2pBFKB1vGAfadUfGZ5pobm2yuk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK48X3IjP1SE4+DP4RMh9GKalGBnoTKUG1QHJS64xuUr5L1gzZ/
	Ws/qDRjCqZwWcpiRe+QDQvZxwQ9xM0p3BzXla6Mhd2yVqlANVzhotCvY9sPglOZo4hAZ4xgOs65
	DJDQ0THq0qn9K6Td0EP/gYOtIXjnnINKYtpwRAz4HhQsiID98N92MN89XGB6UQ2PUh71f2PY=
X-Gm-Gg: AYBFou15CRIKvrUA4tQFb1nzTJCiD/rK7mxGTDvLcPQgPLgxfmUAeOVuem8Ul3Sb0SC
	GWBnz3tgaqYOLYoWNe19UPgnle0U+ligu/SDSJjXv4ricVmuBZhmwyR2XL6GyR1U3lZNFvjlgQp
	QxEd1S/h6R305yQAFaagNMrM32zL0PxVBM8z6yJdEMMztHKxeOOYfbpBEmiUEXhv3/sJ80fP7EZ
	dOEInSkZcVHh7R8AkU4aRoDFpplLQ3RHBMoneUBcsVfggrRM514zOQRhOyZoyW7qTE9A8D/B515
	cUOskU4TgcAYLlWckePlZOLD27vPRValuMQ72gtcNiIvgx+bxgluPh8yzp99rU0qj4jYi+Csw9S
	DzPK9Vd6t3g3wus7EAPkkHmNRJlLx62vSt5f5wgm9W7m1YAB5za0km7Q3ZGfXFZmPSzD4Ozc+QZ
	D+bv8j8lgAqwDscV8FQdsniwO+uio3pmCcVf8TXDiz3DyrX4qSW9M=
X-Received: by 2002:a05:620a:4712:b0:93f:3bb5:545d with SMTP id af79cd13be357-93f6f91c414mr483895985a.27.1792768191773;
        Fri, 23 Oct 2026 08:09:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4712:b0:93f:3bb5:545d with SMTP id af79cd13be357-93f6f91c414mr483884385a.27.1792768190952;
        Fri, 23 Oct 2026 08:09:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4040d3sm323962f8f.27.2026.10.23.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:09:20 +0200
Subject: [PATCH v11 9/9] arm64: defconfig: Enable Qualcomm CAMSS OPE driver
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
Message-Id: <20261023-camss-isp-ope-v11-9-0c2937195298@oss.qualcomm.com>
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
In-Reply-To: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXxHYjaEBqkfgV
 vLWCQjyEZoTi2wNimrmsJwpSYvkyvITo2FgIwGeixsPeSa1SMkJfLr8oNmpB1ZvYSE7Rn5Degye
 i7T+Os8ldGh4aDUID7gKCVn6cusscxt5QwN6BZkwSlePxuObHEKHeay2DBnlIu8aKE35E9yaOq6
 06Ce/l97e59nf8rlQld81Di8WO/nGR+ttAfElqRKbjjPP8dBE/CXUWQtHY4VpHNlS5hjmlPhyML
 jwVRKQx9/xWrfO+Dd4fYDF/8M6m09ftAqi3X8ug9XxQ4VzTHW9ng+K6cnaUEUz/kvNYBg9Hb4wx
 GKQwHaabQqM3E2zBpyAycK/hraxUuSDJ9jCoSKIt2DGirVKb4zwFZt1rZVOOWqLVXedb6f3GuVg
 cBd9/bkh62B7B856KjvA9UkjSgNNHdgNz1Ni+NcOMXALbI7/40iYMN2oBqdo4mcYEBkWcmil7Ds
 N8pXc5mdBd/1tKDlwrw==
X-Proofpoint-GUID: -6CsFDRAqfekvMTKhWeQGSZb_DgZ7XOu
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb78c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=BUwzsxYIp--Ly0ysDZIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: -6CsFDRAqfekvMTKhWeQGSZb_DgZ7XOu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX581ZBmqsqajh
 gOeB1sqe8H+JYxCo06kgogTJiSf42eM9Cn6+64JJUfVbAoqsL29/dRhNhICEMVR8+0loq9ZYu57
 duyRe43lkWs+TY+2qi2mdgf/rs/m82Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add CONFIG_VIDEO_QCOM_CAMSS_OPE=m to enable the Qualcomm Offline Processing
Engine (OPE) driver, an image processing block available on Qualcomm Agatti
and Shikra based platforms such as the Arduino UNO Q.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6ec8d3a69c98e0da38465010d11166bb0e058f4a..604a0d58521dd6a1df8718ea3fce28cc727a08a0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -931,6 +931,7 @@ CONFIG_VIDEO_IMX8_ISI=m
 CONFIG_VIDEO_IMX8_ISI_M2M=y
 CONFIG_VIDEO_IMX8_JPEG=m
 CONFIG_VIDEO_QCOM_CAMSS=m
+CONFIG_VIDEO_QCOM_CAMSS_OPE=m
 CONFIG_VIDEO_QCOM_IRIS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_CSI2=m

-- 
2.34.1

