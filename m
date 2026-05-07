Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D83D6463
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194229; cv=none; b=UfTBtihO8t25QsOgQEVVuof8mQovBexc5Efc3ARjCEh1UkJBay8XH5bo1olnfAWqdLhqka/C6l/Q20kUfkGjzHJqMKi+H3RDgLJhEjp7Nwg14Qu31mqd/4vrfBCVkp+V2GEtklFJJ66SLotBg1B3JINSK0VueR7iyM9SqaiWZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194229; c=relaxed/simple;
	bh=Mh7PVsHAeBxro5wjXWn2s92lyXis/97vUohYTl63Csk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wyp2ASVjld8ZZESluXto3SJI6qZsRTNLuTjZWP8OnwrHEhfudGeKjSdN4tLhtaiQsHas1eLd9cakW81cIAXme5HX44uPfxAtNq8DEKgBMvRERDSYQJQfSEZp39ZQh+FYVCwoK3J2K4AF4veHneM2fe9atYxVQEVSi0PYdMclG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cm5cXAyn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j6jHnOaK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cm5cXAyn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j6jHnOaK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Hq5Yg2734234
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GkDMdHG4MAKPTHoh78zrZYswwET0RC/m0vlXIvO5Ql8=; b=cm5cXAynoc4yOlLQ
	Jgq7Sn2/5lfb8qefqI1moOAHcnBVK6py1EVTTTQBE9ZuPE8ue/beKKNxKf79hVer
	d+8PcKd90wkmQj3WTNzlUGRc8iZyDyaNmYzHBZpcLeOcZa9wueyNPcaocMcXN08b
	bOo8l1r8O3pdhi38r0eAQhUoVCeiS9PkSLQXvlOMsG8vh64beufan/GDnrG8nPIc
	CXcQKCCxfDGL3TLfFi1WGdA+y4BA0RklDrpoDvzDAKaau/R2PAG4uduZIxTdp9FW
	R2h+m19auigZT+nl5ixXBMcph2gCg+wAZThbJWDKnJRN0i08+3ryCt3s9FnVXFCD
	uTwIQA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqtbqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:27 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5fc74c6634aso323857137.3
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194226; x=1778799026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkDMdHG4MAKPTHoh78zrZYswwET0RC/m0vlXIvO5Ql8=;
        b=j6jHnOaKrmorfm+f9mAo8le7AMYl+hjGCVyNCRuytYyYfU/mD0y0ELN18+YyJNQddz
         gQBXCPkDmVrmgMUsBE2rIHbfD8DGLv9pM39cEqyREeWT7uW7S1DFeQQABlpIO0v/R1Qi
         OWWrNeacCb6Sm5+AJ9UcGxd1zMrefX80qouObUz2EN4vYlBbS3dv9WarQbdjkyRyvodO
         zScYU3rWoqhLmse1S1hnDZ+0yGi7myF4UVXby8BOtwlLRbY0pcxP7J0bgPAgDV3Dj9b5
         Cj/xil7Z4FiWKTrN6Yjbn+QHnRHdwTNdp0U5B9sU8a5bKH1Gmiv4u6Sqc9BZl/QRyGhy
         uzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194226; x=1778799026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GkDMdHG4MAKPTHoh78zrZYswwET0RC/m0vlXIvO5Ql8=;
        b=Rual2abd76cekBayKWPlIW61vXGDCQnXpmWdmJfjThT9yVcZ32r9z2igpD8mFsRgUc
         m+zTDNxrVKSvkpFV5A3dpodWdTytZbYSqT7q+N3Qe7RH0P2f/P7cJegEvM5NhSGLndOF
         ZDTYPvbqWafMea90RQmkNgTCuGfmzpK/SrVK672YZMu2Mz93XReNK7rgMzBpAkV/8r8/
         GBAYEU/pZAKtlQ9WBYn1IkmntasDZm0VHZ5psD1CSo1t87izp8ALTZQRkPTD6ImmBGad
         fBNk2/HzSkQHtLQ1d6jQf2a3ueH9/OCMbuGnSgbt6wRZkjFfREkdFTmsJ7s/mlroW+Qj
         zANA==
X-Forwarded-Encrypted: i=1; AFNElJ9UJ/SMydIvMGSWu0icUer9xNOZQAWwT/pOL4TTo9Vv25ckmOO78xdUQc0AVE4T6n1NlieCmS0hyN79l0Sfwx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Fv3e9ouaYam1RmGNIrDB52llM9xtRXdf75+Ka6/yIqy5EwKf
	kOJEgGelS+OEOyTGHHQLHERycTR78tlBEGXmKleWUCboFpLeCsLcIKhQ4HASh+naFbV8rLhXqKd
	niS8Wmph2oTSY9kiGyiMw2zEMVK3666mCA3FMjsNk2ZoiOZQQhW2lmsz0EYB/AZd9i1lpiDU=
X-Gm-Gg: AeBDieuk94eNLenDDU9aOMpmGOZU2TyzS/ImWwmlLjFA2v3RY+l8JTyfIh3n2UMkItj
	VAdaG33NZIxhK78ZLXEEqAaWzEejRDWOTS4DpTtKnSDqtRWllxQ4Dl1qa4kbgpKzD/edVplwnMh
	TA7sUlZHQjnInzwjD8pexeaz1GL5tdVOwYa9QhgcsbTCF4SCn8r5/T9UUcN+12LJRST8DsE4w0E
	JEFnzTiufnDsUROMEBspWNtas/ZMbG0jFvfvttNr927Zqv3JAhFGyDZl8RPudqInBGck00dehRf
	fhdwzxAWSZhA5bW4vIq3rOjrfBRt8JfleOoVvztRqk9lPo5jxIIQMc9WIZH7RlYNcH9cD6nCjUt
	UEuEYcZe0gH02xKYquBnL0TTdW+p8cqE//XloggBh/cO9XZhnGmuIjo1qXTNBYrV4bSXNIXXBvB
	Mrbq4mrCnugf4AjuFuDFYyIV3HvFw=
X-Received: by 2002:a05:6102:f0f:b0:606:49d:1861 with SMTP id ada2fe7eead31-630f9058f05mr5648719137.27.1778194226279;
        Thu, 07 May 2026 15:50:26 -0700 (PDT)
X-Received: by 2002:a05:6102:f0f:b0:606:49d:1861 with SMTP id ada2fe7eead31-630f9058f05mr5648702137.27.1778194225890;
        Thu, 07 May 2026 15:50:25 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:24 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:22 +0200
Subject: [PATCH v3 07/15] media: qcom: camss: Add V4L2 meta format for
 CAMSS ISP parameters
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-7-bb1055274603@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: eZuzNVup2Uh8Sz7TOpKZxSjubb6uVwej
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fd1733 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: eZuzNVup2Uh8Sz7TOpKZxSjubb6uVwej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMSBTYWx0ZWRfXz7ZOrX+DGB0R
 9TI1cEuWDp6FsSWYwaOLbuNTUHVcOorItW12xXn6u6yHK0Gkpk4peuHdUVKJdv4U4KKGsNMtl5B
 UXdrgoMWNBSgw83mrei7AOmIObjZIC5i7t2isl3QBK8r3R+ORih7CkHhsJltRGwL7t/H9u5wlqE
 0uniIeY3ogHjMP/1aJIDyC4VN/rkPvWaS3FsnR3wW1Kqq4aHVR+gunMLO0E1S/aGpR98+0d1h0g
 iQmX+vklch9eEj5NL46a/Ebv9K1VWlgNJ9EY5IEE1p2ZOd0pS5TiIK9axKlGZzDRWJ3xfvJ0561
 m2eyaLnyU0Nn0xL0BP+yWgboEGdkT8/rjezTeaZ8xXzsZ7UKs+oRIPpbOPPutdPW+PLhh0YZtmz
 8prVQHcJgRePzekUFMUisLU8GLXXQuOx5SWZ5KZiC+fImvFiPKJXWw15qW8MxQ7UgI7O9L3j4w+
 /K8FZ/QGEPhT+x9eCpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070231

Add a V4L2 meta format code (V4L2_META_FMT_QCOM_CAMSS_PARAMS) for the
Qualcomm CAMSS ISP parameter buffer. This format is used by the params
video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
per-frame ISP tuning data such as white balance, color correction and
chroma enhancement settings.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 98512ea4cc5b9d725e1851af2ed38df85bb4fa8c..7b6e9a9a514f037190d55d59409dd6cc97522943 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
 	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
 	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
+	case V4L2_META_FMT_QCOM_ISP_PARAMS:	descr = "Qualcomm CAMSS ISP Parameters"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index add08188f06890182a5c399a223c1ab0a546cae1..f861211ebd7aefbcf4096885388069efed27ddc3 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -888,6 +888,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_MALI_C55_PARAMS	v4l2_fourcc('C', '5', '5', 'P') /* ARM Mali-C55 Parameters */
 #define V4L2_META_FMT_MALI_C55_STATS	v4l2_fourcc('C', '5', '5', 'S') /* ARM Mali-C55 3A Statistics */
 
+/* Vendor specific - used for Qualcomm CAMSS offline ISP */
+#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP Parameters */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.34.1

