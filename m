Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A481486E77
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327416; cv=none; b=XUjvwi8MS9qkk+HQkFC4U2epuna7vXTkXf25qUxEtIKZQyxivttisBYjEeBb2bJkHqT9FQXSY4UhQSLR+pyEKIXu4sTRLN/66A29fBSip5PJkoHxXaH5dLzkavmo7pTi2xySuvSTINRiL+zLstNGPRDYLZxLloroRzvujw+KXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327416; c=relaxed/simple;
	bh=Dzpg26Vur2DCvULsTE9E1JAC2Y7NSf6GVeoLlup85aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgL+dxbT+R47/SZh8EPEkQo8ECKBH77Wcmg0/Aw+8ErkcWa1Jjhj/TDBXWtswUZrXJ/2O1yuQEieVYjG+ybPN810vGEwcnNgwXROrQK6FXnG98+NpW2GjBLt0JHaIZhwvVp8cOe4rnuOP+bGwUSh/KTCWYKnRjVKB6muHrJunvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCXfdnzs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFXYL+eo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCXfdnzs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFXYL+eo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YROl3736777
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=; b=VCXfdnzsBuAxysu4
	O6uJHtTkow49ha/+RPdqHJab41tX5nEczGltusQP0GLq5MsO4Nt1yHTL09vacODl
	OVmcsrgON/EaByj2NDK0DIcw7vhOe4+wHKJWp0aAUKkn8zgXLrlasPU0eNPVvRgs
	rQTntLrm4AmkJTowsjg1cJ14Add6dE6IHzwhlginxV2GxGzY4wo7mXoKyuRz964h
	A46AOhScf3JcRZmV76f+3mlqnJOQKUBxEJ9hgYDuD+mmb13ou8TwgDj/yN96MeDN
	oaDgBBcaP7GAtNIchR19Ypx0UNMVLWTU4+R7ZZ+bKT0pCrcftaEkBJjhPJeCYqKC
	udwEiQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e3fwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:10:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939c30aa9a0so70256385a.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790327409; x=1790932209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=;
        b=JFXYL+eonL3NXP0P2pMWehXGcBhZT4a/3iDTpPm9fAHUzn2kvxbI7TPWNteVhQzOs/
         dab7ULbyvb9JiHtvb08qc/QUEoQefJsNQc7SXIrHArR1jSE80J9sJCR8ABDmkxPcKkHM
         4GDjmoVYXALxWkSc+cdsWmvxPDCqnT67Odx2Jcgo5xnRU662pVxQDRya2+Yo4ZW7C7Ml
         yefvJURjCJDoF0vo1QsPzro2u3v+zcLxkbNdvKht9BgOwl8ugusla4mZv/OjLNwdraQN
         rjUofeg+x3KD5LCVprFWYSz8FCC40TV5sL8tQ+ZYHS6cjuzoKNF7u17nYUxB8MpZ1zzD
         nxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327409; x=1790932209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooijHQlhry9x8ePNW1MEInw6PQc9F5ZMCpXfK0l0qXU=;
        b=cgL+epc85ZTn3d1OsxtFvQkTbxofSmE1//OcXnpiBiopjWS0WYKiML3TWS8N60Ssx3
         rZDnq6BI5K8s0Z08WZTUVLjN3uEdtwQCt8IxP/d8G2+SvVvLvEfsPUUrMFiTZPXlwDUu
         /R6cj3SHTD51erefcstHJMaEEe+nJTStosPSnCKI2cH4/Ycj7TksQokVdGDgB+/qgckT
         GNVNA8y4QxlkzC9gVrMc4iLES7GBKpQ4ZkwfOXCfVXNYIvzj1dZMwO6sgfszfyL8NZbW
         Vl9S2gRWjVO4ncP5HBUn+Oe/Env+OmO2ILOLPaq/IPCXsIowzjaot5gpeW8NYox0SbKb
         wZdg==
X-Forwarded-Encrypted: i=1; AKwUvBzPtYQ5HYzOzqOkrxiB27RjE+HTKN/VLxCECNPx93+/4/K1pUFPMMFjUjaokPFK9l6D140jaPwpTsmLCfbov3c=@vger.kernel.org
X-Gm-Message-State: AFuF++kQeKIWD0Y+xZ4xek8E1Hb3XpzeUyCksq8/B/ESvbRFL1ly1S5F
	eZTY/BKIUwzi95QSWpkI7kYBLlNFwYbwdHXpJjBuuRG0z4PhSHIynN9Yn/q+1i3gEEDqqTbawIz
	xBQhjFVtEclrbAW4azOlzcCkGUC3r1B1yHdAVD6DDCrEHJFMZO4gPqvkw2KuDTbrRzgr/7yg=
X-Gm-Gg: AYBFou1PZzDwsQReu1oP/qBNQM7ORWdr0ABdYzaPhGNtBbFtB2h563WY+WVtjTnJj4c
	usEjktTuMkqyZ03CltzBknLbFqHC/YBqlZVITXXvm6qFubF9xZwfrVHRbXWI2kAV74VHw6UjU8p
	gHDWDvvdb3I/1TY+kUNOUqoME86D9pHdG/EFtIrIgeS/ly41y1/tV7DUz7upfSGkB2a4djqSCIV
	SBZDgBFmZbzsMUh6fpUK3KbSfg2yTcjla55C932PVL0a5O9r1ps6l3lvxZN9ipE4lViDAc1VTq/
	ycPChdzNBWKZZxgfocxxl/mckTmIrsVcxaGC2lq4KmwPC8EZdli/Btpn7aF0DFdgkNyUQo2njHM
	QC63pDJHKyLSQd5s41aIPR46vGR9bBkKIa3qnwFzZSvJIoF7MzNGV0LN/vKsITOp/ioj+wGJ5az
	1Hdw8acuLlRjvHj9eoL2wd8svpxDhUQ4mKPZb2isHE1oZracpWA9Q=
X-Received: by 2002:a05:620a:199b:b0:93b:e917:6888 with SMTP id af79cd13be357-93c43cb6c72mr320196385a.33.1790327409491;
        Fri, 25 Sep 2026 02:10:09 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:93b:e917:6888 with SMTP id af79cd13be357-93c43cb6c72mr320192385a.33.1790327408916;
        Fri, 25 Sep 2026 02:10:08 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm5269890f8f.9.2026.09.25.02.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:10:06 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 11:09:56 +0200
Subject: [PATCH v10 9/9] arm64: defconfig: Enable Qualcomm CAMSS OPE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-camss-isp-ope-v10-9-2622411034cb@oss.qualcomm.com>
References: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
In-Reply-To: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX2vsolKBx0QsV
 NaaDOwC0AuBj7dC18itfaZGG8xPXbO8/YIRSujCT/jFvPKUgbCk/jFCuEkO0rg6l1Y9dyw2Uie4
 0T7uIbPG4LotyaOfY4XvfANW6T5e70M31YRObEAa6SSqF2OU3u+ZZzXQ/n02uXMMl+F/Gb2Hhfp
 Kdjcjf0Jn8zaD+2lU7j62NU8v9jx9E4WhWuEt0ZzByo+Fiu2EeXTUyMrvqVt/xFoZL1Njfu+VGO
 jP93VtThAyhT3Mgn1mMd+wzQ9UJyxZKGAI/kbgcRdP2B9s2aoVAAw0WrSm5q7C1vjvA7G7/+UDc
 QcR03htyZQWtK9s6pV21vXGd3o0bDDS00bShs0Oi5iiAJb2uw7BZUIMVSimc97Rb1FBtFkq/Jf/
 HmRBIU3aOz6u7IPesJWBm5W1bqaJaNQC8ix4d7XuvPBFlGIWjmYlzcXgU6KVoz8sOeDEn2bdQW8
 s40NM7y+J2FsIrc3FoA==
X-Proofpoint-GUID: M-38pkAV3lxA8VgkrwdCTykBoAWBD0nR
X-Proofpoint-ORIG-GUID: M-38pkAV3lxA8VgkrwdCTykBoAWBD0nR
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab63a72 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=BUwzsxYIp--Ly0ysDZIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfXxDFZk/kG7SNv
 rJC63kBCm+rNOrmhZEyLIWYlnnZrkwV8Q6X9YAtiZNnRYuH78/DcFPoKaCakiz0I4KIRu99SdCn
 w/Ziwhu89hn1lokuHFXom0xrWO82g78=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250036

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

