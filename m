Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5543D34A0
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194214; cv=none; b=FIUgaRlMp60JFXBYO/qeSV6A2LbOS2zVJQja17zgdGr2UtTWkIoPF2uY7O/LGNCK1/UsLSp/h9ZOr2iviM3Mh4dXZ3xWfwWCoYzG6109xgaTbW/H+3r49T3yAYOvzMGrUBT6Tqc5iCzM6dn7H4KSGYUV4CBB/V62fDFWoC+zJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194214; c=relaxed/simple;
	bh=DeoGvIk2JM6d3iYKy2epXQEX0HxjaKrwSQKtJe5us/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMGcRjb6vsZlGO1P5cS9rxwqEdXnJ8u371jZUo5BEM+IEOUdsJqLMI3qSUMrKjFBY6h4fAHizOq6lIvWQnupdKUZqltDFD6TANCEZtjiqbjfLQH37Q2IH+AgQr6s1Xj826+Lbt/CZqhP+QJItzX+XkmP7bBpk14QunWtvPKnMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCQoeyTp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hY84Ia4U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCQoeyTp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hY84Ia4U"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647IIoUU1417671
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c9vAhl3V7MUdd4qjbESfTeY51BTylAF+5R3us3v248k=; b=mCQoeyTpvVA7XDYn
	ZJ3rL90ZeOGF12kxncfq0nwsHq0+hl9jeWIqVrJyX34O39r6SHIQuPGMBduHpyeQ
	uV32k9OdLE91iCmWbyfcEgi7EQnxrBHnynuYk2XknEWh9EszpJgM08yjF/BVDW+6
	nLsHvSLahnbyUZGVpc/9qsrv7lUr5j/9RxW2vZxlwuKGOTjknbCQ4mkfoO4E2QCb
	AP9PMNeNN5mgW1+xhf9TPCwYOcwZN+Xls53EMqkDBYDGoGM913ftm5DNl7xLBWam
	E7jFutzSm4uhPoc2w2Kcr5hYr7oiZgRAb6coakDzXDhePcAjZsoXDcd2mIsdIoV/
	uGk1OQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0ywhgt1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-62e94ae0479so5172641137.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194211; x=1778799011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9vAhl3V7MUdd4qjbESfTeY51BTylAF+5R3us3v248k=;
        b=hY84Ia4UACwUitlRjctguziFEGWLtwiJU5yxbCZbmLM3QIHWabZ9D0m2oO+7u7Yqcq
         fXdEcXDqM86PCWjjXvHakGpxgWPYBN5jCMQ/h24ef1gadthThUfBLDZOszeW6NVs0qvu
         PnbhfDZIOH7enMVbYtMEcQrNbrOjSoYGmhWhKyHw8eWZT1QsN9Nflk3Q/yy3/9NAtEIy
         HuF1UzN0RlZICpmEplkKm+XqMksPkaZcSsKeuDyrtuzuPn4VcjyqciCHtL+t5km914gr
         s/2rB8hWAw/wQ4i2LOn+jIlF1xwu1NCxWhfLLdueQY28jP8MY3wC8BrlUtD+YHwJQYNS
         IuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194211; x=1778799011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9vAhl3V7MUdd4qjbESfTeY51BTylAF+5R3us3v248k=;
        b=b824TVD2N6EUSkNjeU8lputnfj8A+XuvxJubwcl0poxXeB/US1wUkEXLOuE5yQU5rg
         Kn53BZ0Z+ELWkjaN4dqmjlLgFAMp+PETlqXOqmzRKuTHQfZggqv4luH9nmiCRqEh05VY
         UHckonUWUgnXFJXD9nGmOHcWkzxwB3wXIi1P3dcNZa1dJFnw9y8EE6CjpLzU0RqSkVgQ
         0V3vo5f3uYdmfv1l+qYrjd2nxrGJJ+KK5bB8wkcIeyIcXp+KeF/WwuYdOjTW3/WsR5kp
         vsgw+q0nRq3WKqmxm4sb+MgY++lbkCqsFzX8YkWpOHc1N1tuGK0YMXjsQZI6+sjx3LJd
         dTZg==
X-Forwarded-Encrypted: i=1; AFNElJ8dPb1GHiexhlaUO/JzCIjt0Cg6qmVGKdTYT58tMf1nPpLT3du6ahwoJ+/z42t1RSmsXlveVVDsiz/StHoRQv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/Xh7HMNt6wpNs7h9vx+3rqkZK5aGfaJmDIVAkTFGz2fJ9rYg
	vfkTJA3z5OUYYsBB6paIF//pQS2YkILCMWiMisWepY2Z+YGHnlElBsdldXt7o6RUEAmCAzmPQwP
	/B8+t7roBb9sPHk4U6s6c7u8VaW8FnstIMkQE3wQ1qZWA5wqgZ4O8J7YPqz846vKEwUmyMU8=
X-Gm-Gg: AeBDiesiOhZNZSRF7sQQ1M3aBC+xhgyT5OgygsMCEHyCQVMtXtBFUGwGTXem8itf6EV
	mBDCnxX1emlTGGq9U9zn/vnor5J/RxA09H5rbAffaNgNglu5DKNryVWOAX9LmXBtrpYjP6HaIU3
	YYSRqnxOCVohvn6J1PB2ohbhT7pJqjCpkMuDlW2ewgusHg4BDSnYRmaUnPf8c+hkY2SeydIMZXd
	X1+We0gz/IBUMKtMtGaswqdnkcN/5Sdndl/kOIjwGhDKoaLJvNCIS+qu8mBdRLvzZii6srwWaog
	yA6veetwzSJjZA9IC4bJ+F9dcZbcosR3xEwoTvEzc2Z095G//4BcO0nhAUPM4RGaNuMqHa9WadQ
	qEUzO40Qd2J+iKACgfw5JZsUW/TV6pSJemYAKqx3iQ6U5x5LGrflEeDEST55UVY9ZjacK3ueE/y
	SNXF7SNA9v4mGPniPA
X-Received: by 2002:a05:6102:32d0:b0:607:d68f:d0f6 with SMTP id ada2fe7eead31-631160350cfmr2101567137.20.1778194211137;
        Thu, 07 May 2026 15:50:11 -0700 (PDT)
X-Received: by 2002:a05:6102:32d0:b0:607:d68f:d0f6 with SMTP id ada2fe7eead31-631160350cfmr2101543137.20.1778194210720;
        Thu, 07 May 2026 15:50:10 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:09 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:17 +0200
Subject: [PATCH v3 02/15] media: qcom: camss: Add PM clock definitions for
 QCM2290
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-2-bb1055274603@oss.qualcomm.com>
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
In-Reply-To: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
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
        kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=bMAm5v+Z c=1 sm=1 tr=0 ts=69fd1724 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=gZ4aIBoJpEVIEF-KsNAA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: ONf4IqBezPlI-nK5MlSpf4mrDvivegCA
X-Proofpoint-ORIG-GUID: ONf4IqBezPlI-nK5MlSpf4mrDvivegCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMSBTYWx0ZWRfX9gOj85B1zxXD
 9e8NcxTRgN/TqocI3dN7KRyyppJEVsWvkK5jnaKkHiu2wuTwyYAjuVQfQpzcw76Hoom1zQQrJzI
 y7kNG82z42aEGHwHS5eJcjc0ochQEzX/5xSKWB9dRbbmmUHW6TIug0FTaupD0glPtUD5H1OYDIW
 qX84mcHf6NxdOzsH/3lf6+7fsADwJxH0Pz+LcwNp6yYA2CkF4kBqjGMof7fxbJPFmmlM2UsaZ7X
 8i1uGPXDyPAM1k9mJ5txIQEky0jYddzTzQWNPM5ovzaJN4DjsjlZsm5GXaf4tEqxBBxqar6+JOb
 m/pSNoinkZYxMMs/X9f/tKp5uL5L1gYJe2whNm6g0gUToEYuepUII1pLtKL5iGFy4hqPH/v0UP8
 925r0PdJrXi+CLfQ9xmpIdd3K/98L3xOWv2P7/G0FarujkoSTNOYU3rvmB4dCO40LtZTRxK4U8j
 6nhk9kvgueAXyQN79Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070231

Provide the required CAMSS PM clock descriptors for the QCM2290
platform. Register the top_ahb and axi clocks with their appropriate
nominal rates so they can be managed automatically through the PM
clock framework (both are part of the camss-top group).

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c37d5bfb4072d4d94a8abd453b89c9aad7e15001..3bde26c4750ea932ea69fdbf5c5da9f959e5e5e2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4830,6 +4830,7 @@ static const struct camss_resources msm8996_resources = {
 
 static const struct camss_resources qcm2290_resources = {
 	.version = CAMSS_2290,
+	.pm_clks = { "top_ahb", "axi" },
 	.csiphy_res = csiphy_res_2290,
 	.csid_res = csid_res_2290,
 	.vfe_res = vfe_res_2290,

-- 
2.34.1

