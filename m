Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736361;
	b=PdZQRwF4IQS6j4CEVCg7MObSMAPW2YTIjVOlhe1LChDQCIhTbTi4IxT/HflRaa7quUP1
	 v9ya51JSHyawcgoH+gcPOf/h5iZpJoRRn3ERuNb/1cIrJMSLQ1ASnS7tA3zJpnqTNbRk7
	 RoKiuIlkVn0PfV3F/T8/qngUnRvqWGV6en7CSdnRqVKm6cqLm9OYqbWpxVHuB1b7xj8RK
	 I9Vjg4d0kkBrDbooIvleGHuM1cLn/cpQztJvBK+puhYcDChY9Ipp0iK2xBLCItXvfIb5I
	 nX3atY/Lo6vnFqAwOkvVslKgtuqzf0949tDFEc83GvOPaqNlc+gYfTZMSp/FXjIJiEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736361;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EXU023RtjmmS9ov+L1f+Bq0MztJ3nGlHC0RmWtYt/nw=;
	b=Vb5g3Z8OkYZC83Egq3TzE+70g3SAEIwd4u2TFznINYpbv3ugNCPAic2wEBmKWNH3Yi9l
	 hj/1fKhAfvOp4tarlGZrPM0B0pkVpQx3GBLX/0CqqhAcYh5SoOd2wBPNTxUSJBiJMBFp5
	 MfyzKavoZ6+JzpSk5MZ1p8FlC4+s0SJcBCHxMpk0b/aKiQ9XPlpMtfh3tcrCJ5aELRux1
	 VgNxfCLuu99npWxyA0Ii+zVimMQyCv9QM1NlTw3wuNN931WZD5tmy/eguqqNZoGJONMyp
	 nWpUj/pS5VBeojpJQ5J1mU7SF7D8x061MULC2UJWjz9hvvIA3wVz+DSzzEjk/zh7S3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MSzanUVL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S8zD8Ijh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC4606D805
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AC4606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MSzanUVL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S8zD8Ijh
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZ20k2586359
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EXU023RtjmmS9ov+L1f+Bq0MztJ3nGlHC0RmWtYt/nw=; b=MSzanUVLZesrDiRG
	ppvI7FYUiSvPoiUlZRpUr8EbbDkgvBIc+T/bajmYAuRVv5DtRAyuJCmnWvASsWOY
	1TbCPzMz2Mnd/4h6bRQMt4ehju9VRoOO8NkFb6Z+7OWcu4eMK82UkJFoU/abKSn+
	wa6u7F60PpOwV5LWdCNO1moPgegm5MxZqTgpNsA9siKdC2RmbuMebP4jmcOo7zZl
	PurCr/St2EuqdpHlVsG9HrN2vsMdW3THTzbmxj3CAM/X5GaakNoRMiaAd9NLdWQn
	QSRw36bI3jUFpgfMxl1smfr0V07el9/EcNBXYCAClLOTwQnKw8T+CFikaA0+Llw3
	0tcaeQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbrf6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:05:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc175cb172so3936012137.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736359; x=1794341159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXU023RtjmmS9ov+L1f+Bq0MztJ3nGlHC0RmWtYt/nw=;
        b=S8zD8Ijh1KPRaksuDtJFP1f/v4CWheCEm2+ZuQ9ZKzQpllLkgaRob2Dep+LgFFYyis
         UxLhwCVzkyHqXxn5DeeLcReuULnARQdaAdxV6GyBpJB8CMIXTRIj6cLH2NPBP726k6GH
         6jRNczOVCe8rcE+2WdfkNQp0a8KdtzLU2sMzE7Sutv+pc+rhmobrYaHXbkOZ6AV477Ln
         aW4UQtxCHVZFqLuYZli6tlECtcs3FxGoXfompmBEFkPAM6dVE4g5pMsCTlxmzwBYymS1
         f6bNbVX77ddvpDsp6UxjzzKlIQShdh47VpLQ6jJDPv/YV6UPhmMxrD4/1FJ2mLzsMydx
         Ygsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736359; x=1794341159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXU023RtjmmS9ov+L1f+Bq0MztJ3nGlHC0RmWtYt/nw=;
        b=qdT8bKrifZzwKMub+5MpVFKnvMAjq70jTMcAz9Nm0moIJAEo/EIPw6i8tC64dQGiAy
         KGXhpZG8QqbZDJUG/WgsquDf8stNWkQGBTFC/O3iqg507aqjyBhgXFVtctue9gIrdcbG
         1X70GCSFIYPZLc0Skq7yDXObBek5vsAs4isuCSBD/tQZga+ZfSkGf3DCs1iUEofkhnKQ
         RBEM7fqAW6mdHDRWluDfSr6DIggV9Sq6mlfLzufXw97/S3638KJqQwSA6ztR8dzj1xob
         QzgsYC4pS60yoRUpbuC6A+P1DjxItbgnbrQVdb+Vms6nvtO8bTzPKrseyzqt0oUT0spz
         zR7A==
X-Forwarded-Encrypted: i=1; AKwUvBw88E43SHJp9z4NGERi/matDcZVA+9jo8UJLCpnNQWCALkCHfB/6P94iQQtDtK+PxQnHlVk7OLyNugkckuvsCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BUDSmaJ6FJ48DPjWJ/kvxy0jBUdmsZ65piS5H5zaSf6t3TOuo
	3U+9WSwVhT8jAtGweqFkiXSsiZKOPyIPmd5fBSXKBTUug4Glrox8MqLj2q10s2n7/cFHlFAOZdU
	vObF8t4vh3QKE5CNuQ3ruSPoY8WEQQ4gaRtDCdst1QQFzoWRv1ibxOIGLZjfgpHQYGdbwHQw=
X-Gm-Gg: AYBFou2MJkFYqJ6Be6Csq637uTbfslj3O/prR7xCczUNKpb5UtP9qRPL6CPxLoGUq8n
	F46uU3Svy8IG+LxQg594OBIwugSSsm9148dm8XDGfYF0HgPCRaBy+bOP0xPKzPSY+cOYkhSsKpY
	g7RtJ7P3Mde7ZEtHTRzGNLn7JN/dhgp3cBNhOFgphrRhelPaDSk4pUx/G2sCFBi8oLzcZ9SemwR
	b2vU2yVUiKGGbl+ti5Ww6b/Dm54hPoth8FCXu4kPhlh9aPXl2XR6V9IwY7CL84A7Dw8uUfbQG1v
	jdqtG6T0pQICHX9yqRcyjN4BoR5KZxVgtzWYI9fWXc+466dlecaFA0AK79BImK/e8vQr1hTSoar
	vBXQ7xGjJ6Gj6PxRpG7Ey268j1LFmOYYOCYkYBNeFotulV5jVLbvYVnGtoL+qj6el5KtGmeUrr4
	DBQgwv9r/8Zv7VwP9BB/FUuhH5uczTs4Dj2PHLqZvgdeVOdKuATHpGtBKOnSLBOxFt1Xi5SNdJ8
	0DFZkl1VSk0KfmjkuH03Jxf8ne/
X-Received: by 2002:a05:6102:5126:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d0726cbc51mr6026345137.23.1793736358910;
        Tue, 03 Nov 2026 12:05:58 -0800 (PST)
X-Received: by 2002:a05:6102:5126:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d0726cbc51mr6026338137.23.1793736358435;
        Tue, 03 Nov 2026 12:05:58 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:05:57 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:48 +0100
Subject: [PATCH v13 4/9] media: uapi: Add CAMSS ISP configuration
 definition
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261103-camss-isp-ope-v13-4-c2cbf15a39b1@oss.qualcomm.com>
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
In-Reply-To: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: tDR68hSM7m5IDtjlH8yq91Um2SMS8Prl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXy80hpihHekvp
 GWeX5UR2Jvb1AkHeCnRwqbRAELGn/07XyEVKiHMwpEK8SdI4pbWLKN6kMNyGSx0oDbnNSAaaFco
 Xx/wzClffCgYpL6Os5M+3HKhRU2RwIHICZgZQI3dTgEdi3/eoBIRim+n4Ec9Yl7B41AGt4yPp10
 AwphMc5RfDFKABbwWILwwFVMnAaT9cEbYZpCF757z/XiM4vbIMaYeU4Z4LsJv+P9E9cNzbzS708
 Yt26y5GSW938rgenwqDwTmGzAFKaFoV1RiX08PByaZyFGB4KquO8KPgc523HG1pmYKKYJ7NNiEW
 QjCgUJ8jlp/UX5t61+537A+GEpZpEiY4P63z46dtCP9kuqiGMDK3yZ6cAxUjvHPOt6VsFypAOBT
 0samgvn2W6sotCA27e4TvaFG/NrExqZhUgLIA2G468tqCDAmVzxLCDSbWD28QL1qOIbnpOGLXSc
 DEBfhcR+ZB6LeI9WZrA==
X-Proofpoint-ORIG-GUID: tDR68hSM7m5IDtjlH8yq91Um2SMS8Prl
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aea3ea7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=cBt3T3tByBXynNCq78MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX1spQl7IS/0bP
 veHiwtXDcTV7nGIKfdFh4xJOrcwHztOBmbTXn5EjtABD/YnjCFjvqPyJB6WtjGRM5a2y72gbipk
 kbwKDgceghQSUbuqWk5Zvx8pDynuQ8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030080

Add the uapi header qcom-camss-config.h defining the ISP parameter
structures used by the CAMSS Offline Processing Engine (OPE) driver.
This includes structures for white balance, chroma enhancement and
color correction configuration.

The block type enum is shared across CAMSS ISPs so that userspace only
has to deal with a single set of block identifiers.

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/uapi/linux/qcom-camss-config.h | 217 +++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/include/uapi/linux/qcom-camss-config.h b/include/uapi/linux/qcom-camss-config.h
new file mode 100644
index 0000000000000000000000000000000000000000..543c1682f8aed3b07d7085f54a24eb632ea190a8
--- /dev/null
+++ b/include/uapi/linux/qcom-camss-config.h
@@ -0,0 +1,217 @@
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
+ * the @type field of &struct v4l2_isp_block_header.
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
+ * sequential operations per channel::
+ *
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
+	struct v4l2_isp_block_header header;
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
+ * RGB2Y - Luma (Y) coefficients::
+ *
+ *   Y = v0 * R + v1 * G + v2 * B
+ *
+ * RGB2Cb - Chroma (Cb) coefficients::
+ *
+ *   Cb = a x ((B - G) + b(R - G)) + KCb
+ *   with:
+ *     a = ap, when (B-G) + b(R-G) > 0; a = am, when (B-G) + b(R-G) ≤ 0;
+ *     b = bp when (R-G) > 0; b = bm when (R-G) ≤ 0
+ *
+ * RGB2Cr - Chroma (Cr) coefficients::
+ *
+ *   Cr = c x ((R - G) + d(B - G)) + KCr
+ *   with:
+ *     c = cp, when (R-G) + d(B-G) > 0; c = cm, when (R-G) + d(B-G) ≤ 0
+ *     d = dp when (B-G) > 0; d = dm when (B-G) ≤ 0
+ *
+ * @header:   generic block header; @header.type = CAMSS_PARAMS_CHROMA_ENHAN
+ * @luma_v0:  R-to-Y coefficient (12sQ8)
+ * @luma_v1:  G-to-Y coefficient (12sQ8)
+ * @luma_v2:  B-to-Y coefficient (12sQ8)
+ * @luma_k:   Y output offset    (9s,  0 = no offset)
+ * @coeff_ap: Cb positive coefficient (12sQ8)
+ * @coeff_am: Cb negative coefficient (12sQ8)
+ * @coeff_bp: Cb positive coefficient (12sQ8)
+ * @coeff_bm: Cb negative coefficient (12sQ8)
+ * @coeff_cp: Cr positive coefficient (12sQ8)
+ * @coeff_cm: Cr negative coefficient (12sQ8)
+ * @coeff_dp: Cr positive coefficient (12sQ8)
+ * @coeff_dm: Cr negative coefficient (12sQ8)
+ * @kcb:      Cb output offset        (11s)
+ * @kcr:      Cr output offset        (11s)
+ * @_pad:     padding for 64-bit alignment, must be zero
+ */
+struct camss_params_chroma_enhan {
+	struct v4l2_isp_block_header header;
+	__s16 luma_v0;
+	__s16 luma_v1;
+	__s16 luma_v2;
+	__s16 luma_k;
+	__s16 coeff_ap;
+	__s16 coeff_am;
+	__s16 coeff_bp;
+	__s16 coeff_bm;
+	__s16 coeff_cp;
+	__s16 coeff_cm;
+	__s16 coeff_dp;
+	__s16 coeff_dm;
+	__s16 kcb;
+	__s16 kcr;
+	__u16 _pad[2];
+} __attribute__((aligned(8)));
+
+/**
+ * struct camss_params_color_correct - colour correction matrix
+ *
+ * Implements the CLC_CC pipeline module.  The matrix computes::
+ *
+ *   Out_ch0 (G) = a0*G + b0*B + c0*R + k0
+ *   Out_ch1 (B) = a1*G + b1*B + c1*R + k1
+ *   Out_ch2 (R) = a2*G + b2*B + c2*R + k2
+ *
+ * The @qfactor member selects the fixed-point format of all coefficients::
+ *
+ *   0 = 12sQ7  (range ~-16.0 .. +15.992)
+ *   1 = 12sQ8  (range  ~-8.0 ..  +7.996)
+ *   2 = 12sQ9  (range  ~-4.0 ..  +3.998)
+ *   3 = 12sQ10 (range  ~-2.0 ..  +1.999)
+ *
+ * @header:  block header; @header.type = CAMSS_PARAMS_COLOR_CORRECT
+ * @a:       G-input coefficients per output channel (12s;
+ *           a[0]=Out_G, a[1]=Out_B, a[2]=Out_R)
+ * @b:       B-input coefficients (12s)
+ * @c:       R-input coefficients (12s)
+ * @k:       per-output-channel offsets (typically 9s effective)
+ * @qfactor: Q-format selector (2u), see above
+ * @_pad:    padding for 64-bit alignment, must be zero
+ */
+struct camss_params_color_correct {
+	struct v4l2_isp_block_header header;
+	__s16 a[3];
+	__s16 b[3];
+	__s16 c[3];
+	__s16 k[3];
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
+ * gamma; different curves per channel additionally shift colour balance)::
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
+	struct v4l2_isp_block_header header;
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

