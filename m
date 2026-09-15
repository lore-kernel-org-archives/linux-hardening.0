Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C6356777
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459872; cv=none; b=H9A3PpGClCz1lOR75Ba4kgIEtyEn5Jm3/mgyBCMyrSOTRLAlL258dwVCr20qRoyV53G78d9EydVhW9VnqC/rrpW9tKC8pa5OP8g4DiFJSLViCsD1Ez86pwzYE75UCk8az16MNXUWf5WsnyfJRpsxrpehQnYS6W7K1lMunXK/1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459872; c=relaxed/simple;
	bh=TwbZMWaf5zHMMD2gf8LfNRX+QQ9gQjR1lauqLVDpOig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9cm+UmcGE7MXPplJgGxwWDVm/xt/I7CShZENFieYNhd4Z/6ISpIO7LIodlq0nBZipz93BWUU1FbvLAFXXwRjIkz32y2zra2hgM0w/19O3Amn8lg7Pi7RAtOinopAjqXxICe9F1Dnfu+ghGXJCyQDRt2UXK4hZJ6TpoX8GpGkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cmgdJY0R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GUfKEhXZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cmgdJY0R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GUfKEhXZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6Z7Xp2167830
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 08:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Mtr60xJ+ZTH3/m9/beJGo90PbSa/FEKMJzCUWRk9Mo=; b=cmgdJY0RFDho3MfR
	glnQVQdP6xuWAmMhvCZrUpvkd96Y+xNJE3HUhlAYqc+pQqHPpCX0EnNpbUDg1fEC
	LjevAMIen2bKB9LDxzRAgSylPUnr26t8aAZj/yqPBoiu0LwYswPFGbGGfw5VJdnQ
	JpJytloqGKuvJbDFGxJScA12zDZm2wEOB58mHAKBzo64NvxFjYMOucaOMd4ana37
	fyfYTYpJF2f8pqS8XCFe8oLsAh97Gd48Cs5uNKCOlNMi7dpDMHJHKWv7KGqDFeyb
	NEIlkQDmlzsM5EAiMb0VS88gQr45hisBT67ayzMocCoPxn0Y5MPHRNV1uKhUYV1X
	dExy3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpx4s911h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 08:11:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so873664085a.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789459868; x=1790064668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Mtr60xJ+ZTH3/m9/beJGo90PbSa/FEKMJzCUWRk9Mo=;
        b=GUfKEhXZH1PpdH98JhhXTFsajkaJWBvK4CQ35LIZ8lOYS0J2saKq4Rz6p2WRTEGe3P
         JlApvwa9372teBY/gyoEeqgV4T2xMYDhXhm7q+lwp5s2Flauj7ynp8r+JCaSTfacN06f
         axHjg0uLVKfnYIHDFMmV+l9A3wjDJ7h3Cy6+uYj17XTxAfXBMjPPVfutEQO1aYPTL0Sx
         g0mD7SfV5WLNhGaeNBT8mJXu9cEVmFlxDYKmDvPFJrWKcnsvstBXzDRHpqXwI8vJQbZY
         O1VpXVskh2TlBx1l9HQgDIlYnT7kc0ggTDg4hBI6OnsZmzcCug+wYBnWAmeMsyfwyXCb
         LnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459868; x=1790064668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Mtr60xJ+ZTH3/m9/beJGo90PbSa/FEKMJzCUWRk9Mo=;
        b=jTPmkFBoCnW5HiY5mLf2/sk1eGlNoVvpc9SLjzkROMKhC85WYUVz1sJ5+Llgq3MLwP
         2LKBRh5mN/d+MQhe51GShKgyCdZIJALmuA24JWBnqt8CG3d8izt6qVlzPOSw4MxTBmrK
         tlmqjEJeWBKNbnibhJyhQYSIEdnk8Gftp2hMI1Vetozwi27eSKDVRfaDp5IxkfYbJB/l
         UMJzmzQ2f6uY5Jn3GoHYndy9TIMEJ6g3DK6aGUbrEVFMHzNIgdZzBHZOnfOpJptt/Agc
         uX9OwTICSTHgalTJBWqWEWo87Wz/kQDukxBL6eAJV7hxlw2tNv44uHVDEgPUYqY9XjiG
         GxwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRDTFJ9qTAdP/ArE5QSJCh/3LRqQ9yxyvydLePRv87WjUPlFlHft8JGyomXfEto6nTKUui8Yrn5lYGoo61A6U=@vger.kernel.org
X-Gm-Message-State: AFuF++mbREB3jtZNq0JwvR0sVEl9qUaRpVDis77gL4NyztHhqdMzENis
	vfKGrGDNrdPLuRsN9rf0B8x7rd/Klvaao3jFTCe2MG3JPOxZDq2tbO2mc3JQ1022cZ1axYxXIhS
	IoF4xHJTKQJkqGGOJgE+odYf4np5PnXY5A/BhqNgjoZ4jHe74fK1qvV0UHWwbgW+EBsP5n/Q=
X-Gm-Gg: AYBFou0xEFdBGm+Sh0xWXagrZP5sYvYaRLiQoORyPzwsYDffC34yMPUJ3HIe7amsz86
	t2SXbOeRx0XdJGhiRaC6R7b9uEjT79jcYOJFhwf+C6Tyg8UK58pJ2QFS68YoJBtDxrDoBKzilzr
	t51D4gmaWkOLRQ22pgEKJPTaStVZ5TQijZuVzb7NZ+gWD7g9n74tKxNRdrj95qvD5H6luOxMDQb
	bEheWgAEFhzHY1aHzhUyf1nSAmzY1WwH2oRm1ksk1vxKE4T1xVPg9fug0fiHisNsYVwWwLzBNTe
	p+M2xTCs1dbnvSW1VwXi7m80PFCdL/cRSap2GMmqC59v6n+1QVoDRmK4jZUGYgtphLfAYLQZ/pf
	eQ6skl23NvalYQg1p5HQ07Jy1lqzJEMB2cvyaM64hQjinrq8u42Xiks1aWOPHOnJcfNeRxGH2Sk
	hlOsNg0SOVPeUCzrIEGz152lrukuWkYbcSPqGK7QUfygwzUASCdWM=
X-Received: by 2002:a05:620a:84c4:b0:939:7c8:78b1 with SMTP id af79cd13be357-93a29999e82mr1026086185a.24.1789459868538;
        Tue, 15 Sep 2026 01:11:08 -0700 (PDT)
X-Received: by 2002:a05:620a:84c4:b0:939:7c8:78b1 with SMTP id af79cd13be357-93a29999e82mr1026082885a.24.1789459868076;
        Tue, 15 Sep 2026 01:11:08 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:7034:b557:872c:5602])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d292d3csm48847885e9.4.2026.09.15.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:11:07 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:11:04 +0200
Subject: [PATCH v7 1/9] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-camss-isp-ope-v7-1-77b13d131d3d@oss.qualcomm.com>
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
In-Reply-To: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDExNiBTYWx0ZWRfXxEv/+SXsvoS0
 yeOnwmPOmVDK8JDEkDCQp5tWO/hT6Cga+bvu+w1Fo5RgILpbjLtkiuyo1KMT4YB/QKVIv73ueFj
 oBpj/oaZLinIp2Zc10KAHXLJy4M+Bvo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDExNiBTYWx0ZWRfX66WMcIex99SB
 wXUCkdd0wUATXJur3315UmEz014+e+T1Wd/8Rm7E/wI9pZBfgoUNjj8XGtPInZZswEB0z8PvLZb
 w0LLRV+3t8hKFzIE+XSKVh9ceAfwYkoZ6LcSA8PA4hw/DHjcHCxbepav7F7nja4RsHJSpL1GoRd
 h7cToR+3boeO8le+pUaVaQ4DZMkOTXMp/XfQktH9Q7csFqgS+Qu9KRkrMj0yW2Qx9XjC6EakHBO
 67gJdKGdLnGNnxo8j9F4rVBq2Ps02/Xj2hpeRMfq7muxB93t+bEvwiJLbL/o7raADgYjtTpM8V6
 bsE8w+Xs6BHZHZsVX2uQwMniTeo24BjsPGp+PuC71pXTOKk0O05KcZtuYG8WdsZBj5ioGffDbQN
 gUo2ignlJS6w8hW7mr1/TTVtOafwMy74VCbX83CjhMaWP8Y6RXlaXOJhnl6llycxgwR7O5znf88
 QPpHJp2FhRZrOgtNHWA==
X-Authority-Analysis: v=2.4 cv=HsDjiETS c=1 sm=1 tr=0 ts=6aa8fd9d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=mDm0RygAtmZY0osY0NEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: zfOtkMtH3GaDvH0kX7uBZeFzL9wGkzcE
X-Proofpoint-ORIG-GUID: zfOtkMtH3GaDvH0kX7uBZeFzL9wGkzcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150116

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

