Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED646A5FB
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778283; cv=none; b=Oeg+umCXm0F4nHHukFYsGUtZgKJizyU+jMktlC1DIqpjDSEGCiu0suGsU11r5i77Pdy7TfMfNCFXNYA3tKniDlPfNvRs4LWX0bpiyX37rOFxsoDQX0ovuhwdtkwizKh2c4OjF8qBWW6wra5UazwdLylicx5k+kwZFWitJLmoB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778283; c=relaxed/simple;
	bh=TwbZMWaf5zHMMD2gf8LfNRX+QQ9gQjR1lauqLVDpOig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IwLVFJgGTxeJo+ihczMQMtYSk4pSF8i+h4fzJZlAwLgHphIQQ417hea7D9qLGu4bgdBUQ56SoYlAlflX9GahZS4x4A/HFb8R7rYb8LyoxpRkkngvKb1KSTVUEABBF956txamcQIM7hiDSd3UQCoUOHafGg972Th4JTEyDjmY8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYMywZUj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e5yFI0cH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYMywZUj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e5yFI0cH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnMFT3777241
	for <linux-hardening@vger.kernel.org>; Mon, 7 Sep 2026 10:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Mtr60xJ+ZTH3/m9/beJGo90PbSa/FEKMJzCUWRk9Mo=; b=PYMywZUjHZOZ+ucH
	uIPoYtEMgKVdton3e+zSZUdbwWz5+nZTgeIUVlv3sgiWN+o6QX2TCdUMZrnlXDUZ
	jxXq6nH/yTjuLAw9bGlZ9jodiBUW165Zk+qFeuLZBGAqIFtsijWt5gDm8LKc4RWc
	rZnGs8m85D2GrWpdr5F/WPxtqxkZTCotOiD5rIKBhLwf+MhC9kF98OL1ie9Um7w+
	BjeT/pVR0TPy2td5CtjmyX3NQI4X59293u+KMy38330tu4hNixcnv4e4khTzcv2z
	tR+pc7oRTFDhgIuF65d0Zvt/wZiXihHM2HJbzc2EX7FcRWN2IoPp4PEk2nhPDu+C
	1Uqveg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfygq41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 10:51:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e4f946461so640243885a.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788778277; x=1789383077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Mtr60xJ+ZTH3/m9/beJGo90PbSa/FEKMJzCUWRk9Mo=;
        b=e5yFI0cHS62PIdBk8luSXTxxhgN5lood98Yg1hPXxXBeZhUFu9luk4TwPSj5R6D6SK
         k6h1EI5yJ1paM5bzi4sUJa3XHFho3tMtT3SvFzDvKU+1LxvQIFQM/N62HiLgjsDOsDiJ
         Eki0ypReYP2SHsQIsXAhfP+l9w5ZOa2k5xHfRFfYAc1F3WH0P7cLnM2LFPS9NyonnFJO
         LCam39Y08Jh5jUB0WcDrweaiK3VEFCxEYZpe5bKjFemMSLkqMS78lRHfY3qFQiqa2CPV
         ksSthG+BwHjAHZ8qNH7BFDJa230k9gKDSORLqCKf+eW6k9WcYw9x8aXUC+2/nnKcfaog
         27Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778277; x=1789383077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Mtr60xJ+ZTH3/m9/beJGo90PbSa/FEKMJzCUWRk9Mo=;
        b=b1wL9C9jTZVxrtGA2ZxvWyOELjhfzSCNnX+KLC4EX4sl8x8vIGVeqYZL2MSDFShBKR
         BqCbsLpA4NiR0Q+2qHFUBM4NuOVF1O6mqtVDmBwBZDcdXo2UVm5VXmq9PKXdBc+hAQHC
         81U5HT+1UFhaOwoG09t/6WQJM/KnrKnPKLaw4XcCJY4Nq9YBdy+dgRPROzeplPhAbavS
         mW58w8cbi0WDCcGUfFitnlN9UpjU4bNdf2upPXxRuuZR0tM6oFXaja9SQPkFlJV5l4yC
         AxvQQE5gQ7ItG9WCeZ3UVgtcx/QhWezJy2LkEps2y/WZFr/G88orTYKtkQ0ixKkFz5Yf
         1E5g==
X-Forwarded-Encrypted: i=1; AKwUvBzZWSvd+wE86XvQGMwRraTTQnbaO6fGEJZXhGPZxzyityecCASaXdADd/oWy4qwT+o/w2NJ5Z3+CgVFAf1ujn0=@vger.kernel.org
X-Gm-Message-State: AFuF++l4YXIplulTpEbjLrV1s1aX4nOZxUyGI28/rrcvVEfbmRuVtQas
	hgbKa72Swkv7z6UzLzW9YQu41bJG8lXMgTBi2zgFQGoEWxlWGO+rTqh3iXF4FptLLe9rXzXuV19
	fcgtQb5BUDq1+RRidlaYvzV3+V8PlEQZx9WhteNpEYg/72TyurXhclb0wQ66+6ZyhVvjqG0s=
X-Gm-Gg: AYBFou2KVTRc0x9ffeOIU84q5yhZ8H6Uz9t0Gjh+IZ3qaHYUJmv34b8LxkM6IXRTCFA
	4Bdy/K3FcSkJuJtXFw6CJabk6JNHS03ueH2TuQB5h7CiUdYy2LASvDA1NFDA2WIQwYNZj8kkPN+
	ndByD2pGPskXSVhM29BfdJdMSB/axJmJFOyw5rGtB4x1PpGCfxbgJKnAehutfWn6hopYAk1XP7y
	afUiF3Bzhvl+4+vedaLXBIXFNdBUPnQCYwRouDA5YbjYTsuHSeTCRtdNtLRex6dRotK/Oz+K95U
	ryTzQCjWo+y3iJOdN0XpSg6cqe2wiVrAkH78iuWiA+V5A/7jkGc2sGvkA/l+vrTSYqvgf5xI9NY
	xGYrmfQ0gvARBFuvMIJF2+ePUmlT0+K99w7XW425209oRCHxEEQmoXIShjGBF9Sl1giMbrG9NQq
	zxReWRPfhcySv5UxpP7gicPKCoqN76rcWQBp6BFZazkDSVuYerYgo=
X-Received: by 2002:a05:620a:4490:b0:930:9585:e08e with SMTP id af79cd13be357-93980328d99mr2054534685a.10.1788778276667;
        Mon, 07 Sep 2026 03:51:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4490:b0:930:9585:e08e with SMTP id af79cd13be357-93980328d99mr2054531185a.10.1788778276164;
        Mon, 07 Sep 2026 03:51:16 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm410263775e9.5.2026.09.07.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:51:15 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 12:51:11 +0200
Subject: [PATCH v6 1/8] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-camss-isp-ope-v6-1-6b915b9c5131@oss.qualcomm.com>
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
        linux-hardening@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: FCc9OUp8ydIiQRKbl4gKmJAmmUMZzqtQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX9W6QQPIo2mny
 f8d3JC3Iv+XL4bpKe6psjKTOmQGpARvhutx+0Aq2jmgjt0UmrihMC6bbKj9/b+3Hpy07ti84eNC
 2dxQb3y7hNXXyKwjCvngCaPkvgkmryr4D2AhIT9kJ3x1MOo+FPJDwND3UE7UovucZKEji8vvMg4
 3bs29RtoVnwyPWjL2R4s1Q/bA3efCUYEbXYE6bEVAmz3d57N3oHaNXHsVlBStQFrkvSXTxuJIOU
 vHAF+d6ijW5/i5TEn3GObKCIuVDTHIrA1QoWniv2u4DDSKYONCm0C+K4Hjcn/i8RO5KFqoK6yn0
 dxjCtAWZySiCR8wtBsKo3j0tdvNWBOA+acNKa6AR3jJbZowCOaokVaqxJTvMEW7X32ygfYSGUFu
 4U+EeD7YdDKvLepIif/kahgQIxY49a7quL4SivAyxxdR30+bxhbiNn9V+xlWZjE+PbNy5LC4wks
 2KV28Hbx7u9fFFqXmmQ==
X-Proofpoint-GUID: FCc9OUp8ydIiQRKbl4gKmJAmmUMZzqtQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX5VRp1kphMxHQ
 /E9TQ3O4QtSfu3l2plJPw5jTYDQ+NA5i/GZzzEvDjYRV9GMD5lf3oi3ByS+ha/Eore8JLxGo9z2
 93K9liXiWm4kFhW0dqaoJqpPgeXzuBc=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9e9725 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070118

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
index 5373dba640fae3d19247ab1c74ba336e05dc0fe0..fce574d9268a019aa7829e8dbc06a6187cbc5c62 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -893,6 +893,9 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RPPX1_PARAMS	v4l2_fourcc('D', 'R', '1', 'P') /* Dreamchip RPP-X1 Parameters */
 #define V4L2_META_FMT_RPPX1_STATS	v4l2_fourcc('D', 'R', '1', 'S') /* Dreamchip RPP-X1 Statistics */
 
+/* Vendor specific - used for Qualcomm CAMSS offline ISP */
+#define V4L2_META_FMT_QCOM_ISP_PARAMS	v4l2_fourcc('Q', 'C', 'I', 'P') /* Qualcomm CAMSS ISP */
+
 #ifdef __KERNEL__
 /*
  * Line-based metadata formats. Remember to update v4l_fill_fmtdesc() when

-- 
2.34.1

