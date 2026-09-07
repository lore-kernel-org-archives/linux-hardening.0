Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4A46D554
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778301; cv=none; b=NqnhN5B+lxZzj37uBLkaBI5nic7QFKDnPCjJo0Tb0H939wxG9LG+g82TDxUZas3zyZG13RQqk8TKQuk1gQ8DzjXX6fX9VYMdmerbcBMeIB6cfS8e3NVy9E51Qx2ZSD7nRi5fZ4EsDc4wBUJjur/CPRMlLTiib6zz/IIt8XR8Q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778301; c=relaxed/simple;
	bh=95bc2dL3j7zvq8sUrPF+9bW5u8zLw6OG/1joY1aHH+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXz4VA9PX/CiUOfaxGsfINfp/obWqQi9z09RvWokPgeUT79hQLL4KN9C4560dgF48QpCC/xjDqVwUbFjRJcBC3ahncSRBC09DXzP3gVsqZCfYYxryCaSaH6cLcjP9DKNm8mVT8IEnX01oO69Ds1df/r6Yay0xAS7PkxkTueR/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnv4DWm7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g4PhuG9z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnv4DWm7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4PhuG9z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Amr0C3872680
	for <linux-hardening@vger.kernel.org>; Mon, 7 Sep 2026 10:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25t8LZQEskZfrz00VfAiIDyejLTp3B4Ek3J9ELiuiog=; b=mnv4DWm7lUIjYC0m
	1NpUGTYcRsRUhjgsEFdcrG60wh6k7akZ3QUT8+2Xvdb/VspS2uaPdXeWQ760SaAa
	KJW8QkR3JI7OnNu2LNaW49ydQHuNnm8h+g6rlkQjXlsyCeHre4gSIGeAPa+B5vVM
	SIbejZRUQjORITbNFGCE5Wcu2b3MLpYQ2V/Je9lFtOITNZdnlBXzLvnz0u+w22HI
	o6/rHA2xVPQ5Zk6sstDb8ZQ7JdclrduyJdnyr9gWAKgfHh5PHBr0JzBEMiAnIdRV
	EGv0XksXXUIN2I4Cu3ZBXPLmqWugV1zhORV3hc5qmZ0d8Uy6LbKfSaDsuQ1YuvNH
	7c3Vww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj1nmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 10:51:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4f946461so640271185a.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788778290; x=1789383090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25t8LZQEskZfrz00VfAiIDyejLTp3B4Ek3J9ELiuiog=;
        b=g4PhuG9zqQYUVKYsnYtY6qdL1nn457/SJwNd/qFjNJghDwQxBorywWasQvcUXz/Nod
         wDiCRokNb48H32hm4rVU7j0EzxHhfLdmjy1Y3jTdOzFd1aEBOwcH7HXiHEsxo3qbpEjZ
         ghA13ylhhISJXHDIfErNqldBdlSehvOp4DYaADqyqJkLaIyeJjG6xWdeySETmzsz7Jbx
         Gd2wikG5D8hB0hPWjitH+SU3ApeJPyXszsLxXrMT56NDA8PoUAIzJAg77tlPslR4EgNo
         xm4RTYAqh9GRLR3m0r/plFnwQCAuq8Pod0lzS5PaDyk28XSDJyvf7d24ZLr+MxhP7GY5
         UCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778290; x=1789383090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25t8LZQEskZfrz00VfAiIDyejLTp3B4Ek3J9ELiuiog=;
        b=GvpzOBja5AA3HtlNPtsE+lzUyckLU9EXZTsAkNUNxaoNEbguSmUeATGcx1HNZbkW+5
         CJM1zGLTs1hlU1CmM8hpaQj5RZT8RtdZzvrQUXfHQ83C6wLABrffYdEmgc1exrFTp/sL
         OWXNcI2LVTcWYBTIPVzjyug3S7Bw6bH7qTh4XUjtC9pe/LznVBC+zR2y+gfTTGkPCe+l
         89nWQiKXAb2vopUHgKjMMIGlAmuBCxDkhkMdAD+urW7OHwCTDAOH8wQEl9i1zmZCKXSh
         jZMPQb5fnjMaomMoEZ+JDCqB0RxHalhKcc2stYEMBxRWA+hwdei77oODXyEsPa3o3+Hp
         XaLQ==
X-Forwarded-Encrypted: i=1; AKwUvByFPMSIoRlf5Z1Zq6ehRLDv0suPKbS9fdC0+w4qbjJdGDWv9eh4GbshIm8Le8FsUmgIyrwgGYmVKf/rQM98h48=@vger.kernel.org
X-Gm-Message-State: AFuF++k8eZ5r+c2WDRBucVjvVpe6i8thUxxsuEigS0JxAfQoaQfgaK8a
	NLtFMhnmH56VnLELf5b/Ub2E50UbogPjObhhlAXCrsRy0y5LgpZWC30lbEPjV20U1pkqOq9cPNn
	My44J1vxvErP3e1GzrH8vMcCq88pfvaZQgyqkuBncv2R/R+58Z8pPCJ/sI7RSXI6VCmLlgG8=
X-Gm-Gg: AYBFou1J2wgPkpwf9fO1ul1udz27gx9BFoBxX3SbsDTMbY0OASlL/tdqTr+40hcW51W
	H0ZnBomzfdzmUk+nJOyB1tcwc2MCCrwgEn1qDnp+DmLSBMuMxWsBAjVlrpsVbLVcZQ3BUfokGTK
	jNoer+NCfU8QNrhKBTy2F8M30RLxNIRQwP+eJDTbIUnOoWElgNeEECmZu7Du7B1Ckcg4N3/2SaY
	Pz2/EvZhoT0LpxWttZBYTntezdT3Y9e70UNeGGX1vMwFVpTliDm3Hl7Jwqwc6m36Llgkzm+Ywib
	jfNuTkr5Y1Zq+yLmJ2v/3oVWLpHfqBec3TgSoGdDmM9mISVRwpuBz3XsSHoR2JytS2JDvk5lqiS
	8w+k11kg+O4k4JLe32jGGRNjpwoyBJ6ROyUcICLsUnErvAd9DcGdTPMocJIC6iXblCUAsP3UbbN
	VUjTeZHQLKTRNbSfhAFyHxny3M/aE0mFzLDuIX7tKc4NSzcf3DY3g=
X-Received: by 2002:a05:620a:2ad2:b0:938:39e7:725 with SMTP id af79cd13be357-9398044de6bmr2002577885a.32.1788778290122;
        Mon, 07 Sep 2026 03:51:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2ad2:b0:938:39e7:725 with SMTP id af79cd13be357-9398044de6bmr2002574085a.32.1788778289725;
        Mon, 07 Sep 2026 03:51:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm410263775e9.5.2026.09.07.03.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:51:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 12:51:18 +0200
Subject: [PATCH v6 8/8] arm64: defconfig: Enable CAMSS OPE driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-camss-isp-ope-v6-8-6b915b9c5131@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfXxKfCisAxFwd6
 mJHRcVNk3olWRNzCYqYbyWDhkBH3jArP4veGMkB7lTVm3MTexxvtEFsT5qdBne+H0lOwmX0zlJK
 QUYV2jc76V38gOUIvGW1L2EaxQgCd5I1WIMFU7L2Li7NkP/bD6Mu81bK3JIIr0UbP+uva9k4sIV
 TNX1+0B1ts9VXrqyVpnRXrWZbqc/5crJQXsrLIvD27riuGBcKE9jLfi/7EClY1LU+RESmBlmi8E
 yUsm6/PuCElmxNHh2f5HxupGKfL7C+HiwrqIOGmr8z2Zi4xQ7CR885CwAkHhn1w+qbE7FOj5wQA
 azDuOMjBmflO3NOC6ry8VLhQHlvAlf78dOAMLuW/o+Qi8ULrePq1ZwPll7VFEOLGwezlEAEiHfx
 bm2fw1t6sKFAzyZmyWV5PqiQQzlU90DxN6n0bePzayChOtaYIj4Muf4oM9TpavAg0S1tHixZv3i
 auH+aMJnOEKU0ugicqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX9xeWbCKRnH11
 rKFFQqc9W3/MjHB4dvR975cDpbwtvRz0k6tX6pTyC0zR7oQ0waMbGbN+mHxzl8gTCy/VK7lkyuH
 KDAIaVYrXCneiiPfgpsYW/hGxw7REpM=
X-Proofpoint-ORIG-GUID: LQ84oi2i9a_y4WmHISrhtQmAgnxE2gHP
X-Proofpoint-GUID: LQ84oi2i9a_y4WmHISrhtQmAgnxE2gHP
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9e9733 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=BUwzsxYIp--Ly0ysDZIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070118

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add CONFIG_VIDEO_QCOM_CAMSS_OPE=m to enable the Offline Processing Engine
driver for Agatti and Shikra platforms (e.g. Arduino UNO Q).

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

