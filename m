Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611103254B8
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327398; cv=none; b=AEAbzIt3M11/e3CrP1xi3qMc2+ZttL9pss5DLKHLeLtrpZK5Ls2SsA78U7Kz3Nkk5zV90v3GOtud0MdhsNB0nh+ixMmnyhPNEOe5+wQvVF+c28bTvP/e16tG2Drywb3/rQf0vTbktJ8chajgC88Rdi+dAdrTaImtCscVetFSibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327398; c=relaxed/simple;
	bh=t9VRl1nMX4c51HXGRlVcUrJ2vYPgoDYjYMTLiyXwefU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxVoU5PIpOeH12YYu+NoDmSpFcHL+qBO6+J1wW4u/OzITsZaNvrOIEXZ+fNotoYzA/2YSjHeQjdQzlVchYQZd305I+zhq5sGy0BPTFAWnY5VKsT02ob2dQ1p+JWZSbzIACCcSiDzuZb2BLdW7ua9ERZ7iflHN903hG3tfasLsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/QXYNGB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gjPv/i3Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/QXYNGB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gjPv/i3Q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4Yq2Y1194213
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=; b=O/QXYNGBS0gU2Wwj
	BSACMd2AutM8Wriv9s3EDD/t0SeQ3tHAxUJCPc5yhB9muONFusmu+Jjt36mWXMtZ
	t+Rukl2AF9W/Asz26zxAB/wEvf44UQL57ydgo+ggP0bFMSyCVJdW3YbuerqVOtXg
	wEMK7PfZeq1HgBMmnBj+ueByLT1p4ZPdd8kZEWxNIYc9UxYLQto/IpPtFX8efeQN
	0c1W63ycPoeuBp6YoXZeB8+pYDJPyPBIdXzyn5O8Xm5FLMHe1dVghbAZRFKZ3MSg
	Xw1EVOYHHsr7Apwf3sjreOFobu+8QRIqL+hlO3zS1jw1YQmNs85WVCFQRYsRJVpk
	IFGSbg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw874jsvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:09:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93be1861d2dso104897285a.3
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790327394; x=1790932194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=;
        b=gjPv/i3QM7yR6P7n1zqh9tT5okYYsu7GteMflD4j0ouMYrFaLAIv1BRGX9/liZl+sR
         O1M1MZBlBvwYn5CEsxjSWdQl17jWeHyYYqZ5l/Jzse0+aBPm6489ZeF5m7CLtbRL5Aay
         9Y/bZaEHQ3Prfxl5pYxUO3Ge36isz6KUcHNCV6UHvvCRGe+R7rx6K5ypK9SM/92/cHEI
         wBLkvH/3s4nW7gFrSti2SGtix8JwEgWNbvbbp5/q91sLAHe6LtQQ1bGo7HeuucqY2Fko
         6FqCh4k2MswEQRv6sjuJPTc/KwG1tdpZdupSH7h4zUB8bDRVABuZXS96lOn846R4+bkU
         w1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327394; x=1790932194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owC/0Uitd+RPnqSaxCQ8n2UoAK7Gqnd+PP1VG0zdCcc=;
        b=QbbJRLZ+pI8blLPp5O1XrgbMQJZuf2d/KgrwMi2VYJGgdjpds/8d27EQBgQM3tdL+N
         U8Ua23U5otZcbcXDeVIkzp47hEi9hz9YnilyWaFaAXy0NLKJo7TEjM8stHDOP4GzbtBi
         Zigef8j0Jso9AnRR/BkCLzyJyP2+UbdAOgxR9Pth3JKlpVh8Le1/nb2w0Euw04DcZqTS
         JLBDH/il+U3U779evKfx7c8xa7PrvpY12QKtsbeFFb+PssLxPhnEpXhbiuBj3atxj9q1
         JAPqy78a+I440zKs9we6JQtLD6ckabAB1sPNvJFq0v2ekDkh/EzW68IxQ+xh/vUApLkO
         DoOw==
X-Forwarded-Encrypted: i=1; AKwUvBxVCMPPoPIzTrnT7eCDXdbRg78JjBrDJyUdNTxqBtJrlbiSSluYwGy2wtnz3VrGP6y1JKrt80E4Mcx8UKkXQII=@vger.kernel.org
X-Gm-Message-State: AFuF++kW47gokx77UsREfL/kNy2hUWd4xnf57froDuc1ctdUIx7IfxC6
	qzOqIk8dMb8I21iaW5iIoSEvQ0ddpgyUU0omW2+0y6JCwuJuLZUSDZdeIkpIWdDDwGQky8KboUH
	9aadhkoyi8YrkBkwa8kqjUZ3DKLYFKLvJmgwpJxsgomX3SoacXrt0atj68eOSGttI0m8EmzY=
X-Gm-Gg: AYBFou2L4dxJQ9uDOhKecP7bdhth4jzEmnZNTvjmZqev9FuLq6BvLdCKXkpyHlKUSzE
	5Pt7NP1QrdxQxPiL8mi3bK4Ygnjldal4DNthCBLtWPd+WZYwV99qCoBreOYICPoIP/PudXqWN09
	IpB3XMeGuQvZDPYVBlHO68g1ndgsJBgkAU54A8RTVfAKaSjwLtLDxFz5MqSlicLvsjSttiq4zyb
	cj4gQtGGUaR2EpcmkJG3iEJntZLOfU+HkFlKCzJlDAfPmHDkVgLskqDnYYDVf5oKkXBDQ7heZCE
	3GEPqPNzqA+EC4o95ztrN6eoOPKUZdBLs13rtr2PdNbrN0jgd7XXqXIyBGjk4xWqthFvlepEksH
	ZEaT5147exHx8JBzkOwkJ98Xll82pFsgfdn88lLvP9EmpB8cNIkbM42QzETlEG0CVTerfeUAz8G
	xoRAcTs1LG/7feJTXRAS4OumJxPI67KlG5nAtKJZfbQvhwzbi/VMg=
X-Received: by 2002:a05:620a:4451:b0:937:19d3:3fda with SMTP id af79cd13be357-93c43c1247fmr298751885a.28.1790327394317;
        Fri, 25 Sep 2026 02:09:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4451:b0:937:19d3:3fda with SMTP id af79cd13be357-93c43c1247fmr298749485a.28.1790327393853;
        Fri, 25 Sep 2026 02:09:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm5269890f8f.9.2026.09.25.02.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:09:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 11:09:48 +0200
Subject: [PATCH v10 1/9] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-camss-isp-ope-v10-1-2622411034cb@oss.qualcomm.com>
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
        linux-hardening@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: TsvfDu8g65e4RzBoNYQNMGWqZHLnawtY
X-Authority-Analysis: v=2.4 cv=MI71C8Zl c=1 sm=1 tr=0 ts=6ab63a63 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfXyadUfSx2cY6b
 RMlQS3CRJFMO0mHi+lDpl8tLNK/jTZVca+bULPk7IuoXcvsrZVjEc//KwHHgy4x7NQFml4Xesy8
 nQE08Ws2CWMJ7PEbYOpzHJbbMo3mM8ThbnK39T475GLmPfLeRUz7xVRUTUQdzH2ScdhyxwFXqOy
 ZqquBJB7vM2tRusPpa79dyVQ4zUxpB2sG0yYbf3HG6ZeS97xIpwVmtPTALanULgm0h2TuFyQNLW
 DQoFyyel/mZU7Tf4SIokCyF7OzQJWHYv56Betbts4C08++pFimYfd31GWP/UT2bvmWAvCBU3P56
 xQFECRPH0VijHQU9zV7YOvRq7kxH10uc7gN6hnuYDLVgeUyQstNuWfyrDtanXCP8/dnal8u/wkS
 ZLkKiV9LSv7q8S0ChJsyDn8H4bHbMbU5QTWYZBF+d1BVO2fHvNGaNabyNLIQre0SKrad/YBSEnI
 Dsr3OQZztvsbTsRpK4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX0RrbWzcN/4lw
 yYNOAaV4weNWlbFUEKt0TWSXzsuea7WnSC/uX1roTlICOiCs5wi504r0JzRufR9ssVNSnWGnUn2
 SCh5dtj+tLvlI20d82YCOjS1Z5rhAww=
X-Proofpoint-GUID: TsvfDu8g65e4RzBoNYQNMGWqZHLnawtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250036

Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
Qualcomm CAMSS ISP parameter buffer. This format is used by the params
video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
ISP tuning data such as white balance, color correction and chroma
enhancement settings.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 17ba1ae707355a134047de646f61fcc2d1512d4c..cef1593c1835070f7b34a8b8c860738fb77f533a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
 	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
 	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
+	case V4L2_META_FMT_QCOM_ISP_PARAMS:	descr = "Qualcomm CAMSS ISP Parameters"; break;
 	case V4L2_META_FMT_RPPX1_PARAMS:	descr = "Dreamchip RPP-X1 ISP Parameters"; break;
 	case V4L2_META_FMT_RPPX1_STATS:	descr = "Dreamchip RPP-X1 ISP Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5373dba640fae3d19247ab1c74ba336e05dc0fe0..70208a9443d8ade569f130e2fc3d6beebab6b636 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -893,6 +893,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RPPX1_PARAMS	v4l2_fourcc('D', 'R', '1', 'P') /* Dreamchip RPP-X1 Parameters */
 #define V4L2_META_FMT_RPPX1_STATS	v4l2_fourcc('D', 'R', '1', 'S') /* Dreamchip RPP-X1 Statistics */
 
+/* Vendor specific - used for Qualcomm CAMSS ISP */
+#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP Parameters */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.34.1

