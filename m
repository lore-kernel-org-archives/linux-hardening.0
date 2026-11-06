Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973340;
	b=QAgrkZRCBn8QgM3h1lUs37SHIj5cfj3I2F7MAsqDNLTN27N0N7DIPYWWslMk3BlY6U4O
	 7fzDYIcWVSnd62SDTXfELUONBYjM1/hkIPcNnXrQg/kUgHcJRVqpKaUsVhGzS0SOELQ6t
	 J4scksd0I/pnMhATDnlnzo5k7Y01NZYa6IQ35QVjhpQ5UVK+1/GxOCQoAcJF3GlMo7ip3
	 c9WI5L0nQVrGT+fKp5BuVodD7Fk281wkWb0pGX6Ns/2sYUhz7wyG89aeTbtDMS089LkqK
	 les593s3UjHcWV2eig2iOX1i2/l6l4mWBiMiadZOtEerb/dTlKltd7M4S1tPyW2wkyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973340;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6S7Edw0jHcescwVG0kcrpC8Q6ychaU8y1Z44WpereTU=;
	b=v/Hnhd/KlvhhfBZVRG3QDtT59s+uWtZq3negujk704J0MPmp5QgRnimVGrqIpZm2Dw4X
	 kYYww084AvDQQwt2ucYUPjLa2GUSis4PlhsG7DaiiD7Us1o9K7//NUIeZdZAcbes+NelR
	 puOtDYcIKESnrVL++J74I4vek/bcKwicOvaJJlp1EBacsaraVRRzEgreA0+PNbueoD/6N
	 Ofact9GUD1Y+YziSQZPLne2k5MTxxDx6IJ1xy86YIYXRiQdaaDBMKYvhEJPKejFaIHJ0U
	 ClgXH2Wul+Y6AxXSbBO+lWMiQ0zOC/0Onc+yi/xKDhbJtPHhhMfRPP3ue5OftY9vjUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a6TZZjFv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QIfZupd3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EC606A32E
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1EC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a6TZZjFv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QIfZupd3
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoYYb558004
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6S7Edw0jHcescwVG0kcrpC8Q6ychaU8y1Z44WpereTU=; b=a6TZZjFvyuFTgUQH
	wd6Jf++e/FUut1Sd/baqOgIAMcZyNhMkSYreKw+U+rZeMmy6yl5fv/VFbhbmR8ye
	G7GuWuNcV+4QXMzi0OeR++Mr9xtQtbjnjM/fUoFyIDJyUFZvXjd6wDM52pTtArVX
	z3eJjKjhpgloNzoF6a3AEqRn8hDHOz+4MvfSWgqqmtFNRE7N5des8knqNdYNEDHs
	2h1GQx5+Nb73VGY9eO8kriJWvL4wRjLpmlYBqhZAii0bnn8URGl/4T7cm7xBp3la
	6+57fvnDU00rgA+Sb+hgsxxaFfEzmDs+xu827xmHGexfqb8bdNrgDFLjL8fF3EZu
	VavW4A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pau107-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:38 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc4149b885so580400137.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973338; x=1794578138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6S7Edw0jHcescwVG0kcrpC8Q6ychaU8y1Z44WpereTU=;
        b=QIfZupd3veUvZtyRoHrrznRvEXpFeQS0TO3htKSQagYfpPTI/sNLuee/ETmi1uzcrr
         8fRnGo3YOBzcYsrz7BS34RU4oSxilVFoDMM34UaqB23pMTGBmqVavTK8UdpD7nR/4nOa
         bilIXm/naLYfmB247H2/PX3l+lxUHaqCTU+94njB70ur9Va3ACFEgIlJWYCp4T408cOm
         OkhV01rGqYH3Eb9U/uTENUXTZoLuYF4xpdvqQQvkEe9ONvJG8xGnynbBp1QTBwUbkeID
         YD2EEZM0zovwwGxyn0ESbKtEDUsl8B+OwKXo/b/pk0PSIKCMxoFiTb4mD2lVRUoh/XkE
         MVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973338; x=1794578138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6S7Edw0jHcescwVG0kcrpC8Q6ychaU8y1Z44WpereTU=;
        b=edVSPRR4HwfvYiCS5kFIGbunFobKdkJ4UKauvniPowz+WYda+2FUf/PwusEPxkJ+SN
         7W3d5m45b2MhSmlsxVCf+FDJE3rAhXzjmj8/tMwOYHoADpTG/d/65IiR8FOZjBkpwU+B
         tZpMMCQOZB1AxtjRLSCBY0lvqBY8lGBbTykw/7EzvsBGMumI/HoFqP8Ae0FOk0FU29a6
         Wex40hWgSWnSmbEasM2vvXMrcS3HvCBsaqE/+BmqV6RuroQGHJdETXu5VX8cMC1/vS7z
         DrwJiN2Fm9oCK9hihpUTIZRwb1nAr9XnjDyQ68l7BMbSQyZCRs5KgctC9x43CBeejx16
         CY1A==
X-Forwarded-Encrypted: i=1; AKwUvBx5OwUUpjVqE6qFJpEneZpGaHNDDncH1FLrRcvmwomItabaCuMh+ufWfR//WyBagKRLhqRZox96y863xzf8/g0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vYjDZWDI9XKLiiCPa23PEHq9yRVrr05k1auES8ZJo3akBfJvt
	3k8tXO/X71F3wi8ZM0OaxYu1UZmm3ScT1cgt/VDLB8K+WrwVw9TvPU9kiScksALdclePMa19yUD
	vgNUCSal4nBx1ujRxs3G8tRe5IPmwj+EJNmq1eHMSF0XnulJ3S++uy5jh+DvD1Bt6UciJ0zw=
X-Gm-Gg: AYBFou0clMDuvc07ELBjQag7m3cUH5i4yB0BqAJ1a0/7/uivsRRDAA2VfcJB2NyZA28
	wNQeK/5zipiUcEnS6DBsgbTDNsK2/NQNzDLFbH0s8EmDEe6s66fQaJnwdbJGjdgxMbye8mBRBkS
	1nX6e3aKCm4ejJnpUqCY1r7SnQYBSRoaSI+4FNHYSppJbbInuMutcm93KvIjcy7sDlgWyFD4rDI
	zsq/PZRnfV4z8Zf6rVpIBrXbCyfUTbxvaHXk24cI70GSc5weKTujnD3Xbe1H7lfiWTDlhMIm1iy
	EQqcRSlxxQ7C77eROqu/LSNCa4L2ULshYacbvZaPips4cbegnDbq2LA0FQIR5mhYI7Qr4OJKTUe
	OuZhjtTPaAkAJBnSb/S6OKig0sX3s7GcRH08wZIfjhArJn8kl1XOnYhriYicUxX+eoWV64xwtOc
	q1Lw/XAcKn07lf/4BWygkRjyAHalIXjeCTbXWxQhCn6h5j8ns7on7DcE9WTomEgNS+OEFOH6VG3
	Git6bLzIOuREwE6/BuJMQ6lWKU5
X-Received: by 2002:a05:6102:2d0a:b0:7cb:288a:b678 with SMTP id ada2fe7eead31-7d2a15d5ab2mr1475560137.19.1793973337819;
        Fri, 06 Nov 2026 05:55:37 -0800 (PST)
X-Received: by 2002:a05:6102:2d0a:b0:7cb:288a:b678 with SMTP id ada2fe7eead31-7d2a15d5ab2mr1475530137.19.1793973336734;
        Fri, 06 Nov 2026 05:55:36 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:33 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:20 +0100
Subject: [PATCH v14 4/9] media: uapi: Add CAMSS ISP configuration
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
Message-Id: <20261106-camss-isp-ope-v14-4-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX6j1aiC/FaoqF
 wRb0XAom7QXYqOV5LmV6F/OVKbEkwJc47vxymy/QFqAWCfcS+00CkAxxiWoDhEWnT5vAuQQauJN
 3vphStSoy3Le6jvGPdMv17ATBthVKeKemmACdiesSVp0Hf2nJv0X5PDRKB/fdVh8H4vGySZ6c4c
 R1S2jUBRrP4pgg7pGLi1vqLVMS0uXhv7djI/0iRJbda9NX+qjCwhwa1H270DYZ1R8CK1ZHa86td
 l9QgKl8n+LiGEDpkMdgNAvPHaz8kktcnXVsRqkxtNnuHc2PBXqJNU6hQDQGczua6YKU7TfQkRNl
 oIOuDnKcyjVn21+Bep4BHm60O2GbxjAUKBp2MM/KDYanW+Q4tbfZUQyNE9MIkdq4k7T0ng4N+b3
 Q7a/AoUz730Kn2hdOAEaiQelGlbXxvWdGsyIveIAswbcUoRQgP6iw5ipNOsQalsg3ZpIBZiTUce
 hKkmcLc8kVr2y0MeU7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX40wR4Kj7u/D0
 VraC+Q2cF5oQEQ7ULKOlaNgN0B8WR1c2x8odm6dBqnpUnMryMKtvLM3JVvTPjIdD+u7kPW1nUlg
 yiCbr1m8FWea8kjDJYv8lrmFGk/H52Y=
X-Proofpoint-GUID: wHQ5E2FAC5Q4UXG46-sPBPeNj35gYFwz
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aeddc5a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cBt3T3tByBXynNCq78MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: wHQ5E2FAC5Q4UXG46-sPBPeNj35gYFwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060055

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
 include/uapi/linux/media/qcom/camss-config.h | 217 +++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/include/uapi/linux/media/qcom/camss-config.h b/include/uapi/linux/media/qcom/camss-config.h
new file mode 100644
index 0000000000000000000000000000000000000000..11594828d435e6800c7c6bebc4ad69110c1334f5
--- /dev/null
+++ b/include/uapi/linux/media/qcom/camss-config.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Qualcomm CAMSS ISP Driver - Userspace API
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __UAPI_QCOM_CAMSS_CONFIG_H
+#define __UAPI_QCOM_CAMSS_CONFIG_H
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
+#endif /* __UAPI_QCOM_CAMSS_CONFIG_H */

-- 
2.34.1

