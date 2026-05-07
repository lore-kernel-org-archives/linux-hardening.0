Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C53D9DBC
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194244; cv=none; b=SL2PuUaZGb9fIYS6iLSwGqCn/Q3yZELq8Skyaeo37/A7IMJ1gGWLCGdIvlLBJ/51ikYnzR4KGwKUBs4D1LgT1qM9xkyiVDrF4eov7TFp+dWi1rsLY8VUU/8UBm6GyxulUJuiLLvd9O6akBZQvrxMvPaNcaVgWLuix1yFAdIobtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194244; c=relaxed/simple;
	bh=HkTdVxm4w+k0/TVpI0ca5qa4aiZZTdLwg/kSTlh/tJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2m2MygA6Qfcor1aQ6QXwfL24qozQPBXhVcRCxqHqpeQbm+TaO1mbOgGGocru5Qj5VEa21l/hrelTCMJxCBbx4mlRbT0ZHr0Ufv3w01cFotd8bIfxCIltyDHQLI7FpZv9wVV3/R2hAK+JOTs/I39KFu7pFTHcmS0cD9wGQmmPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXoGOZgl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C2ZhE1nk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXoGOZgl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C2ZhE1nk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647IBdP52770992
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzmyzEi/9mP9ktBgplmP+G5vCsx1+ZwiDnCaxaRy2DU=; b=XXoGOZglB4Qa4NtS
	IJ/KERF7XAEEzfg5VydkPoYxF981Asfr6QicQqQ29VuIYQkz4cwjVg9MeA2DquED
	mntLMhIpH9ABZvrjTIUEM1dpEWvCO2rmExgBHVpupYiyhL/Jq6pKt8Iy/ouMPzPg
	M/JJ11nM1nTURwnDryoRBCsTY6x95jDC9BUTfI+Ij0rjNGbaWYec7VnJWtTNbLdy
	9r3FQBLQZeMPteOvn4dQ1N7QRaC4QqD7gvmALWaTmYxcc2frr6wQJxQGrp3QGpQi
	QSKAGKE5u7nVHfYNQfT5/3JPjQVE8bzwlNrP59sMBLxOfM4NERW/HUnbWBzXGKZk
	8c3kYQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5gupp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:42 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-57536338b89so2079701e0c.3
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194242; x=1778799042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzmyzEi/9mP9ktBgplmP+G5vCsx1+ZwiDnCaxaRy2DU=;
        b=C2ZhE1nkvUwTBk/HVNvDG5r53qTQ6RUxoAB72YmkaAu3HtFpWbtdpHazflaphUH9Dy
         CedgxfzHcJjcn5BiiRvQ40/dA4xjG2K1xKELpiIi2d/OGdFTK45LTYTJbvmyPTmQWSoe
         xmD2S3xj6kx7xD+fWrGBQcomXyhGhTfaftjE1LC9kodcNWVV22zEeHGLvgi+pjWhQAVE
         O7MAwEU453EQZORzkxXh0shHKZqkKm0J4oqExr2xKfJF8c83/NnIkfWRO6nZg2UgvfXZ
         6l8XouUApDv00EV+tZKxKEiJIK4HngqLd4XCqIBgV3pSOtzBPk0TD+uw85uDBd54NGex
         LJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194242; x=1778799042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PzmyzEi/9mP9ktBgplmP+G5vCsx1+ZwiDnCaxaRy2DU=;
        b=pjG5yePBoyjMDxiqgiRbvBiDXYIH6+vxcmG0S7LrBtrf2xE31CEmjeGFC5hEMiJQmz
         rZjplU3O6vwL7px9BDYMwa3T7RXCjMlbdLWlUgkWTSTTSNGz3ihRHR6chWFwTlPsLPKw
         54JnWoCxUWx8ci8ElrsgOB/w40qJgUUjo+T66qnByLnxBx42une1N4a+6/08UGkFilwu
         kyawzH5NaZvlPKTpBRWM6Ov1Szj7+639gv1nyFHBHDOVC0iof6dgmneyDzX/LQSLS4xT
         JQ1GkDHbGqplIzwUHwkFRWtWHLLjfxVLKCF3e8O4nzaZZpXxvRwGo9R1LrmeWZeSXcn6
         JbQA==
X-Forwarded-Encrypted: i=1; AFNElJ/mT6CgmxHJVKJeJQMjR0UCqpikwX66EbkUd5xztYfgCYUyq466s5gIEkt0fEVTYNDXhZ6TzQl9AKKmfv3yQ0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+nAi+NxWNC2XDaZuUysZpdKNH/5lmBzxNtvlrV0hHc1xXO1B
	9OS4ZbRe+a8SMOnTyWlMv3KAcrIN7SMn7fo8ejPvEG16CM+F5h+HE49BPDqX+XIAsYKelbhQxv8
	5RU7e9PTNWrf+Yx0omdjN5z8rbqga/1T8XQ/xOlgYxo2/zKaP/c0Tv4jfkAW9efqWu+QCnVs=
X-Gm-Gg: AeBDievQg7DR6XbSBzu8a4WiNOkienKWOqJIgV5Upy3DOV2XZf4xqHjgW3CuCEpoXKr
	zjSQ+nCgJsuSMGMLW8GJK5LU8jajvFKd3j7SWAWabhNFkkvpBFNlFrQtrFNMawagTLWjibNuHXq
	KsjTbyUBfCcXOXxFvuU8TgL9erLBK/5ivrzWsG0IWiJDlqJ5rtEGCxHfQ7N47YaP52LxHiC8xFo
	Pux30WF7lOToLoJC+bnhl07If9xlT+tqI6IkLZCmz2zcWiUJCQjIEPjbiuXVQQOFUGbPQ1bJMf7
	xt9z1g+s/uvQ5FFLlwKwttMgBX5wDDTiIN+0kPs0HB9sgHsBWFhCkIoE1TKA99sU+ATZ7DNp0qT
	/nhtX3oHcf8A76T5r6LnTd+OFcc47VxRC5J5CpQ3BE2eW3L6mluO3xDVoQfIZZGB2D+Uq1UE6eg
	ijKjqbu38ocYsgPyNm
X-Received: by 2002:a05:6102:5a96:b0:611:61d3:819c with SMTP id ada2fe7eead31-630f8ee055dmr6123864137.10.1778194241584;
        Thu, 07 May 2026 15:50:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5a96:b0:611:61d3:819c with SMTP id ada2fe7eead31-630f8ee055dmr6123850137.10.1778194241060;
        Thu, 07 May 2026 15:50:41 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:27 +0200
Subject: [PATCH v3 12/15] media: uapi: Add CAMSS ISP configuration
 definition
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-12-bb1055274603@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fd1742 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=GU9a0yZhNO0hLPa97fIA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: 2y5czWYx7bQ5OERC-ub8bA0XADNofo9V
X-Proofpoint-ORIG-GUID: 2y5czWYx7bQ5OERC-ub8bA0XADNofo9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMiBTYWx0ZWRfX57rhMJcTp1Yb
 YuNRxVYcJlfMGNtpQzirF6fY+PCC540bhNtRquCyEAtI9UUfkmY09S6KCpueNZkbu/NeK/tCiK6
 7OEqrwltgSB+n13k+b0t6Myi/D1K3riGmq+XJJCPAjA3DhJkdpCMoBLCQ4TrMBwf/K+7uaiRrOG
 k/ieWtDo5KGBxV9J+DgN0cZYgPM/uwRsWNmqwij/6w5ERvnpc8/URKbfYa81U+kQpmfppzZD7Xd
 /viKnQ1p6SSbsfHgnqx2puxdGfmACFr6LP0axrhpx4Tc2OhDWCxa+7BbPciSuW6+bPPnBqUkKYw
 2v18VBDsHfK8ouUuRRTVthWuPJzqk6/gXJ4De7w+ichgMqlqQ+5i9+/9kQVh4DhtyVvpeLMHAVh
 a9WRiGo2+u6L/euez/yoWkAQ3lzM+up8swU/nXyArJFYYCWz3PDBz8EXqEpHEOmpnIGjjipf/Y2
 3yj9QlMbwMEKLXAeILA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070232

Add the uapi header camss-config.h defining the ISP parameter
structures used by the CAMSS Offline Processing Engine (OPE) driver.
This includes structures for white balance, chroma enhancement and
color correction configuration.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/uapi/linux/camss-config.h | 115 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/include/uapi/linux/camss-config.h b/include/uapi/linux/camss-config.h
new file mode 100644
index 0000000000000000000000000000000000000000..665406969e66927e8bce83afaa9a3aae53ba2803
--- /dev/null
+++ b/include/uapi/linux/camss-config.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Qualcomm CAMSS ISP parameters UAPI
+ *
+ * Uses the generic V4L2 extensible ISP parameters buffer format defined in
+ * <uapi/linux/media/v4l2-isp.h>.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _UAPI_LINUX_CAMSS_CONFIG_H
+#define _UAPI_LINUX_CAMSS_CONFIG_H
+
+#include <linux/types.h>
+#include <linux/media/v4l2-isp.h>
+/**
+ * enum camss_params_block_type - CAMSS ISP parameter block identifiers
+ *
+ * Each value identifies one ISP processing block.  The value is placed in
+ * the @type field of &struct v4l2_isp_params_block_header.
+ */
+enum camss_params_block_type {
+	CAMSS_PARAMS_WB_GAIN = 1,
+	CAMSS_PARAMS_CHROMA_ENHAN = 2,
+	CAMSS_PARAMS_COLOR_CORRECT = 3,
+	CAMSS_PARAMS_MAX,
+};
+
+/**
+ * struct camss_params_wb_gain - White Balance gains
+ *
+ * @header:   generic block header; @header.type = CAMSS_PARAMS_WB_GAIN
+ * @g_gain:   green channel gain (15uQ10)
+ * @b_gain:   blue channel gain (15uQ10)
+ * @r_gain:   red channel gain (15uQ10)
+ */
+struct camss_params_wb_gain {
+	struct v4l2_isp_params_block_header header;
+	__u16 g_gain;
+	__u16 b_gain;
+	__u16 r_gain;
+	__u16 _pad;
+} __aligned(8);
+
+/**
+ * struct camss_params_chroma_enhan - RGB to YUV colour matrix
+ *
+ * Implements the CLC_CHROMA_ENHAN pipeline module. All coefficients are
+ * signed 12-bit fixed-point Q3.8 (range roughly -8.0 to +7.996).
+ *
+ * Luma (Y) row of the matrix:
+ * @luma_v0:  R-to-Y coefficient (12sQ8, e.g. 0x04d = 0.299)
+ * @luma_v1:  G-to-Y coefficient (12sQ8, e.g. 0x096 = 0.587)
+ * @luma_v2:  B-to-Y coefficient (12sQ8, e.g. 0x01d = 0.114)
+ * @luma_k:   Y output offset    (9s,  0 = no offset)
+ *
+ * Chroma (Cb) row:
+ * @coeff_ap: Cb positive coefficient (12sQ8, e.g. 0x0e6 =  0.886)
+ * @coeff_am: Cb negative coefficient (12sQ8, e.g. 0xfb3 = -0.338)
+ * @kcb:      Cb output offset        (11s,   128 = +128)
+ *
+ * Chroma (Cr) row:
+ * @coeff_cp: Cr positive coefficient (12sQ8, e.g. 0x0b3 =  0.701)
+ * @coeff_cm: Cr negative coefficient (12sQ8, e.g. 0xfe3 = -0.114)
+ * @coeff_dp: Cr positive coefficient (12sQ8)
+ * @coeff_dm: Cr negative coefficient (12sQ8)
+ * @kcr:      Cr output offset        (11s,   128 = +128)
+ *
+ * @header: generic block header; @header.type = CAMSS_PARAMS_CHROMA_ENHAN
+ */
+struct camss_params_chroma_enhan {
+	struct v4l2_isp_params_block_header header;
+	__u16 luma_v0;
+	__u16 luma_v1;
+	__u16 luma_v2;
+	__u16 luma_k;
+	__u16 coeff_ap;
+	__u16 coeff_am;
+	__u16 coeff_cp;
+	__u16 coeff_cm;
+	__u16 coeff_dp;
+	__u16 coeff_dm;
+	__u16 kcb;
+	__u16 kcr;
+} __aligned(8);
+
+/**
+ * struct camss_params_color_correct - colour correction matrix
+ *
+ * signed 12-bit fixed-point (Qm)
+ *
+ * Out_ch0 (g) = A0*G+B0*B+C0*R + K0
+ * Out_ch1 (b) = A1*G+B1*B+C1*R + K1
+ * Out_ch2 (r) = A2*G+B2*B+C2*R + K2
+ *
+ * m = 0x0 - Coefficients are signed 12sQ7 numbers
+ * m = 0x1 - Coefficients are signed 12sQ8 numbers
+ * m = 0x2 - Coefficients are signed 12sQ9 numbers
+ * m = 0x3 - Coefficients are signed 12sQ10 numbers
+ */
+struct camss_params_color_correct {
+	struct v4l2_isp_params_block_header header;
+	__u16 a[3];
+	__u16 b[3];
+	__u16 c[3];
+	__u16 k[3];
+	__u16 m;
+} __aligned(8);
+
+#define CAMSS_PARAMS_MAX_PAYLOAD		\
+	(sizeof(struct camss_params_wb_gain)	+\
+	 sizeof(struct camss_params_chroma_enhan)	+\
+	 sizeof(struct camss_params_color_correct))
+
+#endif /* _UAPI_LINUX_CAMSS_CONFIG_H */

-- 
2.34.1

