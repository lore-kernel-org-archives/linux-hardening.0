Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD54BFE76
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179246; cv=none; b=ZQGBsswDJvSz4Tm6CLtJe0klcPK9XRk2Ydv/uSfiYhA4vmDRN5bYXXZyx4BhlZdP0awKaxMuusd6jtXgl7CQ2GwIbj4sIXRWCLrw6oQbHz6VoCx7krGuND33VqVQean2QDme2eDVY2o+Z2ySap4CaDEK3hqscNGtMG91QpTonC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179246; c=relaxed/simple;
	bh=eFX4xFKGu1d2iMPrSFu9VG2KHuB4iXe/IQlKD1I5PhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyw8NHjmRvll6HrdZTPwnMysRBpMLwfjmgKOJkZhqAtWMN6OlAsuwVrO6f4eIJlLxUEU3/AuwYc8hY6y1Gxga5ky+j2t67r1eQx2LvZ/yUDbLJ6aLgIV93zzGEvGa8372uuCBwhNdHz8HW5lanxtNtg5MJSVqH9V0+7Nm4H+asc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4qJG6Z8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YFQk8wkC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4qJG6Z8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFQk8wkC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDKsFv2056327
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lQGoGb2ujLMFHLGciJF9hIS3vNu7w27PseR4q+F9Fug=; b=A4qJG6Z8ErtUAn53
	Fh5L98Jspc1kyKpD7I3qeGeyvigad3JgbvdqLU4n+iYTNXf8zwmxz/hOGbKyIGky
	uq8mNtpa6kLu8FIVLFJUkVTS10pET7XjVoWgDPyK0b/yZ9/4M8IWCs8b7jiaHcj6
	qYLt22bLdUyLiggcHI4Jyw5kqsXgOiqNxOIoDu4C5xg1w0fTFWJpuRYGNbY7y7FI
	PFSvhkkTjPrRh2sg+xm2D/wTtoI5PlXszRJ9MAIaoDMB7xrlh2U8wv9Ip5ePfjaY
	d81xdb+y6v0vFuNXji22RQO9IpTBRB+Aqn1vbiOvTMo0pA7arnGO2sqVqoA550qU
	wKLXZQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv0qkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:38 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c7d2076f8aso1146e0c.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790179237; x=1790784037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQGoGb2ujLMFHLGciJF9hIS3vNu7w27PseR4q+F9Fug=;
        b=YFQk8wkCKrkc61+/gTkZJDKRUv//dFE4P159/noeLCNoTN05McnQqMXZ4gyinCGzFn
         g/AkSCQcJNM45awrOfOT8ww3qphXzeYa92YY5drjBbAFM3vEHPHilK6q1lUYVtzbXNkj
         OO/P5egRQJQCRi44VlLpcdQNitWNGIpurQIfYEcycNoUs7npD3A7aM1sF6I9bqw4BBvP
         H8UwFLaL0k1FQCpIX2t3C2PLQ4YWc+bB0UDK3ONc/XjWfoi7l/9d0fNqPe+4Zz1bbX7R
         mdDakaEqKlthRRtW4L0NogIimnLGemTdKOF/VHvYdXMs0AcNkoVN7pptsjZlLAqwn8xX
         Kt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179237; x=1790784037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQGoGb2ujLMFHLGciJF9hIS3vNu7w27PseR4q+F9Fug=;
        b=2jwzqvsmOQRZbfI0FbLPcrKAhzpbihpGFy/YVCwcWpg0Sw9l0ilYWzkRnjR1ni8uaU
         tcdxvkTl1nQTpjYoLYMmvLkmI6h4ZjiXY5ZKA9U5eOyeVNwWQIopvTnKtKl/2oMALyWM
         SHXzuTypiwmiX4YooTdApAAZUeNgb4WIUUxIKwC96OWkwkS/ZlWtDMdq03GwYRwwLzn0
         oEwVwKAXIBrhmwDNxWUmVrdsVMJJ311aiBJC+ujuU6iDfyC3Qx3xHyoViAT5g7tdx8ss
         KAu2YG7ao452N2YtNjbvz58iVeGEbm4uCWft6SMOoOm4MxsU+I/ZEaGCeB9m0iTnRK9e
         vw/A==
X-Forwarded-Encrypted: i=1; AKwUvBwBmBrbvNjx0toD11P31HM2Ct2TkeKu0YeYI2VCNrqz3nWKgBJnmXR7Op8yqQY2n32d7Y1n1YwZUjdraD/BGc4=@vger.kernel.org
X-Gm-Message-State: AFuF++mOqkyrO9X2690CERRr4KCrXhOzlvXS5uS/0NP3OgsKtkxDWnrZ
	3cqdxxd/nczap8wYWXAsSmwitkOQ4rA7mayEcYrqGZSYfxm+kgGQ3uUzXKSCXdQUsFQ32GCic+8
	pDut/NMhASmrQ0Sm5GVdcmyl+HMKqN3jkKDDseUCrU9OP0aP0RuPSP4KQVpLqvn47TUEYHbA=
X-Gm-Gg: AYBFou2ZY0IZICFw1M9V6KVg/5WaZW8T5nwhKryTgmHNlV5oSwc+ILJNND1S7l66Lyc
	6m2nOjylnUXkbkBgX9P226I/jwugvdsCSnVSznjRlFqFHlC6ff1aP2AARvsEGXn0U3izHm3qUYg
	27pGXb+sWcC9bopqgfJIbW8zP8wEW45RIusTgvZhTNCFV+Jtmrzekg4+KWmsoDwLyEMPL6JaGg7
	+CFbX5gaMD8yPx0NRVVCoBUs0BF+4Me47apDJv/8+opRIEwY0gLH0q2QE/MKl2uvMO09L5pfKYz
	Kh/CffHjibMPbHNZDuRliJctZpWgGT9P/+jqegK7KeLr/4RzQkbGJkTWewphWdWMIy1I6/6hT+X
	rO9IDPj9nRfJRG5vwBmn36hUpaXt9CKQu872t+GaUVhQItqW6HZt2Ans1qci25L0MRTdR74B84C
	xOahHiP9UVKsJ2qcX98ZpmRcKg/Kke0VkYcbo/4Mi5AJ3qVizyZuA=
X-Received: by 2002:a05:6102:14d9:10b0:797:c1fd:9d87 with SMTP id ada2fe7eead31-7aa9df9017cmr5462195137.2.1790179237317;
        Wed, 23 Sep 2026 09:00:37 -0700 (PDT)
X-Received: by 2002:a05:6102:14d9:10b0:797:c1fd:9d87 with SMTP id ada2fe7eead31-7aa9df9017cmr5462181137.2.1790179236754;
        Wed, 23 Sep 2026 09:00:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm80739325e9.7.2026.09.23.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:00:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:00:25 +0200
Subject: [PATCH v9 4/9] media: uapi: Add CAMSS ISP configuration definition
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-camss-isp-ope-v9-4-86a75dc18b83@oss.qualcomm.com>
References: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
In-Reply-To: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
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
X-Proofpoint-GUID: lXP3XKCpu-31grzZpVkY9FJsrOzL5b3I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX9uSM+DMt3V/8
 aiD5CAUEV8xk72Qu1JEmCO+noJRIQ083V16LHW/QTmwF/+DiaOm9V2bcbujTX0SLw5YHCxAJ5o7
 1LmPARKz3GhruR2/LtVy//7nJV4OrXY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfXzfXMcCQucR4S
 pGxCw4IFXfgd84GAxui5RrP999X+0/Jt0xMpZVp1PXt9xd1MOA+Ppi1KHxQM8NQuP72N+of43f8
 BnNJivr7Hf1GFEKtN+iUXsjTSXqk+6EE+k9NrF8VHF1+l7U1zTfBEE/6/OxBVT6qqGSGC5NVQGa
 pq4SnvpkWokiljmWgFJC5PstrqcTCvMMqFbp1UhyS1wgNz0CbP17NrDZjuM21sddzFMfGe6jjRo
 ce7s63H+UtIC1w473Cuka+8/+stkbvlzwjj/Saa/lsWHLMyHnUb0s6plCZjhvHFxln+MUE/iIxb
 TeNN/ZkiL7LalGg+n9DrM63dsYzz5Mpq0MKR340pRkHbeewxnn38yLB0IjrU/013W++qI1ITRwA
 qvfEA7CLmESF7oXLVQaYkhCjLOkNDw==
X-Proofpoint-ORIG-GUID: lXP3XKCpu-31grzZpVkY9FJsrOzL5b3I
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab3f7a6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=cBt3T3tByBXynNCq78MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230063

Add the uapi header qcom-camss-config.h defining the ISP parameter
structures used by the CAMSS Offline Processing Engine (OPE) driver.
This includes structures for white balance, chroma enhancement and
color correction configuration.

The block type enum is shared across CAMSS ISPs so that userspace only
has to deal with a single set of block identifiers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/uapi/linux/qcom-camss-config.h | 212 +++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/include/uapi/linux/qcom-camss-config.h b/include/uapi/linux/qcom-camss-config.h
new file mode 100644
index 0000000000000000000000000000000000000000..aa3d97cfcc78e22a6f7ed79bee331c2dfd06f662
--- /dev/null
+++ b/include/uapi/linux/qcom-camss-config.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Qualcomm CAMSS ISP Driver - Userspace API
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _UAPI_LINUX_QCOM_CAMSS_CONFIG_H
+#define _UAPI_LINUX_QCOM_CAMSS_CONFIG_H
+
+#include <linux/types.h>
+#include <linux/media/v4l2-isp.h>
+
+/**
+ * enum camss_params_block_type - CAMSS ISP parameter block identifiers
+ *
+ * Each value identifies one ISP processing block.  The value is placed in
+ * the @type field of &struct v4l2_isp_params_block_header.
+ *
+ * @CAMSS_PARAMS_WB_GAIN: white balance gains and offsets (CLC_WB),
+ *	&struct camss_params_wb_gain
+ * @CAMSS_PARAMS_CHROMA_ENHAN: RGB to YUV colour transfer matrix
+ *	(CLC_CHROMA_ENHAN), &struct camss_params_chroma_enhan
+ * @CAMSS_PARAMS_COLOR_CORRECT: colour correction matrix (CLC_CC),
+ *	&struct camss_params_color_correct
+ * @CAMSS_PARAMS_GAMMA: per-channel gamma correction curves (CLC_GLUT),
+ *	&struct camss_params_gamma
+ */
+enum camss_params_block_type {
+	CAMSS_PARAMS_WB_GAIN = 1,
+	CAMSS_PARAMS_CHROMA_ENHAN = 2,
+	CAMSS_PARAMS_COLOR_CORRECT = 3,
+	CAMSS_PARAMS_GAMMA = 4,
+};
+
+/* Number of entries in each gamma channel LUT. */
+#define CAMSS_GAMMA_LUT_SIZE	256
+
+/**
+ * struct camss_params_wb_gain - White Balance gains
+ *
+ * Implements the CLC_WB pipeline module.  The pipeline applies three
+ * sequential operations per channel:
+ *   1. Subtract sub-offset (black-level subtraction)
+ *   2. Multiply by gain    (colour balance)
+ *   3. Add add-offset      (output pedestal)
+ *
+ * Gains are 15uQ10 (15-bit unsigned, 10 fractional bits). Offsets
+ * are 16-bit unsigned, normalised to full input scale (65535 = 1.0)
+ *
+ * @header:   block header; @header.type = CAMSS_PARAMS_WB_GAIN
+ * @g_gain:   green channel gain (15uQ10, 1024 = 1.0)
+ * @b_gain:   blue  channel gain (15uQ10, 1024 = 1.0)
+ * @r_gain:   red   channel gain (15uQ10, 1024 = 1.0)
+ * @g_sub:    green sub-offset, subtracted before gain (16u)
+ * @b_sub:    blue  sub-offset, subtracted before gain (16u)
+ * @r_sub:    red   sub-offset, subtracted before gain (16u)
+ * @g_add:    green add-offset, added after gain (16u)
+ * @b_add:    blue  add-offset, added after gain (16u)
+ * @r_add:    red   add-offset, added after gain (16u)
+ * @_pad:     padding for 64-bit alignment, must be zero
+ */
+struct camss_params_wb_gain {
+	struct v4l2_isp_params_block_header header;
+	__u16 g_gain;
+	__u16 b_gain;
+	__u16 r_gain;
+	__u16 g_sub;
+	__u16 b_sub;
+	__u16 r_sub;
+	__u16 g_add;
+	__u16 b_add;
+	__u16 r_add;
+	__u16 _pad[3];
+} __attribute__((aligned(8)));
+
+/**
+ * struct camss_params_chroma_enhan - RGB to YUV colour transfer matrix
+ *
+ * Implements the CLC_CHROMA_ENHAN pipeline module. All coefficients are
+ * signed 12-bit fixed-point Q3.8 (range roughly -8.0 to +7.996).
+ *
+ * RGB2Y - Luma (Y) coefficients
+ * Y = v0 * R + v1 * G + v2 * B
+ *
+ * @luma_v0:  R-to-Y coefficient (12sQ8)
+ * @luma_v1:  G-to-Y coefficient (12sQ8)
+ * @luma_v2:  B-to-Y coefficient (12sQ8)
+ * @luma_k:   Y output offset    (9s,  0 = no offset)
+ *
+ * RGB2Cb - Chroma (Cb) coefficients
+ * Cb = a x ((B - G) + b(R - G)) + KCb
+ * with:
+ *   a = ap, when (B-G) + b(R-G) > 0; a = am, when (B-G) + b(R-G) ≤ 0;
+ *   b = bp when (R-G) > 0; b = bm when (R-G) ≤ 0
+ *
+ * @coeff_ap: Cb positive coefficient (12sQ8)
+ * @coeff_am: Cb negative coefficient (12sQ8)
+ * @coeff_bp: Cb positive coefficient (12sQ8)
+ * @coeff_bm: Cb negative coefficient (12sQ8)
+ * @kcb:      Cb output offset        (11s)
+ *
+ * RGB2Cr - Chroma (Cr) coefficients:
+ * Cr = c x ((R - G) + d(B - G)) + KCr
+ * with:
+ *   c = cp, when (R-G) + d(B-G) > 0; c = cm, when (R-G) + d(B-G) ≤ 0
+ *   d = dp when (B-G) > 0; d = dm when (B-G) ≤ 0
+ *
+ * @coeff_cp: Cr positive coefficient (12sQ8)
+ * @coeff_cm: Cr negative coefficient (12sQ8)
+ * @coeff_dp: Cr positive coefficient (12sQ8)
+ * @coeff_dm: Cr negative coefficient (12sQ8)
+ * @kcr:      Cr output offset        (11s)
+ *
+ * @header: generic block header; @header.type = CAMSS_PARAMS_CHROMA_ENHAN
+ * @_pad:   padding for 64-bit alignment, must be zero
+ */
+struct camss_params_chroma_enhan {
+	struct v4l2_isp_params_block_header header;
+	__u16 luma_v0;
+	__u16 luma_v1;
+	__u16 luma_v2;
+	__u16 luma_k;
+	__u16 coeff_ap;
+	__u16 coeff_am;
+	__u16 coeff_bp;
+	__u16 coeff_bm;
+	__u16 coeff_cp;
+	__u16 coeff_cm;
+	__u16 coeff_dp;
+	__u16 coeff_dm;
+	__u16 kcb;
+	__u16 kcr;
+	__u16 _pad[2];
+} __attribute__((aligned(8)));
+
+/**
+ * struct camss_params_color_correct - colour correction matrix
+ *
+ * Implements the CLC_CC pipeline module.  The matrix computes:
+ *   Out_ch0 (G) = a0*G + b0*B + c0*R + k0
+ *   Out_ch1 (B) = a1*G + b1*B + c1*R + k1
+ *   Out_ch2 (R) = a2*G + b2*B + c2*R + k2
+ *
+ * @header:  block header; @header.type = CAMSS_PARAMS_COLOR_CORRECT
+ * @a:       G-input coefficients per output channel (12s;
+ *           a[0]=Out_G, a[1]=Out_B, a[2]=Out_R)
+ * @b:       B-input coefficients (12s)
+ * @c:       R-input coefficients (12s)
+ * @k:       per-output-channel offsets (typically 9s effective)
+ * @qfactor: Q-format selector (2u):
+ *           0 = 12sQ7  (range ~-16.0 .. +15.992)
+ *           1 = 12sQ8  (range  ~-8.0 ..  +7.996)
+ *           2 = 12sQ9  (range  ~-4.0 ..  +3.998)
+ *           3 = 12sQ10 (range  ~-2.0 ..  +1.999)
+ * @_pad:    padding for 64-bit alignment, must be zero
+ */
+struct camss_params_color_correct {
+	struct v4l2_isp_params_block_header header;
+	__u16 a[3];
+	__u16 b[3];
+	__u16 c[3];
+	__u16 k[3];
+	__u16 qfactor;
+	__u16 _pad[3];
+} __attribute__((aligned(8)));
+
+/**
+ * struct camss_params_gamma - per-channel gamma correction curves
+ *
+ * Implements the CLC_GLUT pipeline module, applied in the RGB domain.  It
+ * holds one independent lookup table per colour channel. Each table is a
+ * direct (not segmented) map of input level to output level.
+ *
+ * Each table has @CAMSS_GAMMA_LUT_SIZE (256) entries of 16-bit unsigned
+ * output. The number of significant output bits follows the width of the
+ * engine's internal bus; the upper bits are ignored by the hardware.
+ *
+ * The module maps a 12-bit input to an 8-bit output: the top 8 input bits
+ * index the table and the low 4 bits are used to linearly interpolate
+ * between adjacent entries. Entry i therefore represents the output for
+ * input level i/255 of full scale.
+ * Output range: 0x00 = black, 0xFF = white.
+ *
+ * How to fill a curve (same on all three channels for pure luminance
+ * gamma; different curves per channel additionally shift colour balance):
+ *
+ *   Identity (pass-through, gamma 1.0):
+ *     lut[i] = i;                                // i = 0..255
+ *
+ *   Encode with gamma g (e.g. sRGB-like, g = 2.2):
+ *     lut[i] = round(pow(i / 255.0, 1.0 / g) * 255.0);
+ *
+ * @header:  block header; @header.type = CAMSS_PARAMS_GAMMA
+ * @glut:    green channel gamma curve
+ * @blut:    blue  channel gamma curve
+ * @rlut:    red   channel gamma curve
+ */
+struct camss_params_gamma {
+	struct v4l2_isp_params_block_header header;
+	__u16 glut[CAMSS_GAMMA_LUT_SIZE];
+	__u16 blut[CAMSS_GAMMA_LUT_SIZE];
+	__u16 rlut[CAMSS_GAMMA_LUT_SIZE];
+} __attribute__((aligned(8)));
+
+#define CAMSS_PARAMS_OPE_MAX_PAYLOAD		\
+	(sizeof(struct camss_params_wb_gain)	+\
+	 sizeof(struct camss_params_chroma_enhan)	+\
+	 sizeof(struct camss_params_color_correct)	+\
+	 sizeof(struct camss_params_gamma))
+
+#endif /* _UAPI_LINUX_QCOM_CAMSS_CONFIG_H */

-- 
2.34.1

