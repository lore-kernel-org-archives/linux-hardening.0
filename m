Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CF3EEAF2
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674308; cv=none; b=DPt2QxlXDZ6cJHNM6fD6hxFjPkt5OMdYy+VYSWcKOmNpTvWs7EqhZghLbTaFrTIo9CAYXTVZGCTySVRvgzM5hx7KFVcGR5699cCVq1ESztRDysIeylKr0c1h5Gc/vva8I89p5l8CCER8KNfLygUnix9lVCLjFNpHVOFINTh8Sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674308; c=relaxed/simple;
	bh=VmSVbvVuTt4AN5C8oiuT9E98mX8DRT9XHfPGxKvhc/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOjKFUTazujbWEImaDooNmMbhm236ztrlJT18QbbSb3q/MOBznRyg+ahVECKzYWxVJ2pzjlWHwd03sn9W9YxpChGHUg2/3Fd7XypNJq1TK3AzfKNwC3YT2Cw4t0X8GxbNBXQJ4gsU7dUlwGfGLIST0HhTy4RAjYNAj+N+xOiyO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMYkQD6+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UVnoE0W/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMYkQD6+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UVnoE0W/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7drDm188269
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rzlf2ZtK9nuTY0MJJWVDEnSEIyJ35HZ7vs1BndCygtQ=; b=MMYkQD6+kI8HwVus
	v+lIuYYzSiya2DyC+iLQXcxhHHHM3KItB/1J6Ce391tk0SPnlpDVwFRr2+Br/rTB
	h6q6MX6ocPwBnqc/JCOZpsnjvmOUgM8awpXqpOeuEuPtbf/y/4ipDRMtFvgW+Bhz
	G8tRID+oL22dAYzIRw/XKe8bmpGfs/C4YHx6z4YOrmUivZIMj24fo8ELPv89hxHf
	Biwmd5xzLMwW4t9mopGddztqe2KBwIJ0RoBYvWvCHl2uER30pNlq/UbGAyO+GDFZ
	2jPOrX2DPYBao1DdTvQKRnzu80FgbnIaVuAjpgTnrYONTCDqojJr6x9tL6cyMx0q
	tDdToQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesup7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a236220so6775071cf.3
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674304; x=1784279104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzlf2ZtK9nuTY0MJJWVDEnSEIyJ35HZ7vs1BndCygtQ=;
        b=UVnoE0W/7Dw4Allld+YSFVQKmwQvyFhgiF8dl6Xs0tOWpObNUOlQ37CcS5ePu2VjKO
         IC14PeKD6LdKWuU2fbI5qYOIjxv8SIbyh+PNP1vQSxSVpZCLDoY7UZSwnwX9NwVFr0Jb
         G4xAHKCoVnoLhJ2qRI3UMxdt80dJU5j0jnJwZfETMG0jtbaHSZMk9CUc+057p9jTk+Ot
         EE+xUgvnAI2diZ8RiT3v/S74MARadEZcvXb6qjfK412I+KOTm/BDOBPbvSBA7NS7epQM
         dsjtghc7SHJshtSmfbcfFqx2yK1nKjQq2zUNLVbAlPDoIhmKZV9+Gr0Skvowi1oQ1OzG
         VkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674304; x=1784279104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzlf2ZtK9nuTY0MJJWVDEnSEIyJ35HZ7vs1BndCygtQ=;
        b=lLxRo4MiMuYYM61JjqW7MXf31plP5cIaN3MJDhBgitXBDeHjqI5ZOwk7Vjo+dcn3yy
         wzO3NpJSfEe8URrwx0JCwa0F6VtyR9krNJbHO8t9zAqIV38SrO8jn/pSXOnFuLW/CCVS
         +vrQ4lzYCzH4EkBpFVFi/9IpgUWSp8qrSw/+PZ8IcRBo9dJwzTzs+14v+JizTKPHhX8U
         9gCripkqjo9ZTbKryqRthudi/CNqzMzWX/cJXrLVOuNqOOQZAVegd1QUhb+NzOWTUw1U
         frG3aGn4ACLY49NpGs1LeISByKhUp3+1kb4mA7unQuGnn5y+KsUI8k6QttsaQPJhoE7K
         A7xA==
X-Forwarded-Encrypted: i=1; AHgh+RoEWlHHbPXLDmcEjbcswvjHTu+3vyDXtfiQjp9HBtZQIZKDYEm+6It3507+21853YIBDkoUWhMERBSg4YPrSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4y/7ZMDZmeTbxG3iEPNyu4B2rH9e9gn+aJ3m5OXCPRxun6EF
	JuKxKHSQSwNjTb9wkP+WBh4dRKDrC3maTVG0PsC1X7O+NOKgPSycsmUXf9hGn5Aj9fIHWJJzOaP
	1q7yea4LZ4fshTZaIoTzVXr6bMXHeVzYqW6UNtfFjmMTSDEDzSsOhS+X2HDMO6vlHMX4GHDk=
X-Gm-Gg: AfdE7cnNwdRIyvobaXAsrWDd1VY+wTSR45FmN3a5k5M8/6XCEo26lKMgxedc6xGljTp
	b1vsnID4d0RRUNAcdaAcd+EWj6+IYAyIN0Wk+6jVa+MoEXfYT0o5PHoZ2M+MCUgDIDLQLkEhYYY
	MxZxbSJEj5ijoevhAoX5IOieDrSgbneUyG3fF+k9obBpHViwPZ9bUbE/H/fbBMeyJM9rp+r1KyB
	vrKVkxGQZAeXUTNvcCyl9yn9y2N/3sDOHPZVY7uVLrNGY0HXhtLWA8GU/VC8CauJus8sNR7Nt/6
	MTN8JgbnrIthNs3qv/EBD6LGLP7cfnDEyTIMe8IWA4PjEzs2Yq/eCae0WsAi2jtO9HHNOA0Z0RS
	4WvLUpRL7q0k6MYWjYPWDBR5HQwcGjYiRE01Cs38DI0sTNGcNjAk/xtPqEonvPdXyvU/Ktkoja+
	vsyoXxHOK+ZYhbiskqi9MrN+UN1ldq92TGnlH4Sl+a9yZNJDlclc+QOgxS8AVS+g==
X-Received: by 2002:a05:622a:1819:b0:51c:1a4c:3c91 with SMTP id d75a77b69052e-51c8b2adf76mr112432921cf.1.1783674303235;
        Fri, 10 Jul 2026 02:05:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1819:b0:51c:1a4c:3c91 with SMTP id d75a77b69052e-51c8b2adf76mr112432391cf.1.1783674302574;
        Fri, 10 Jul 2026 02:05:02 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm259932266b.36.2026.07.10.02.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:05:01 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:04:51 +0200
Subject: [PATCH v4 5/7] media: uapi: Add CAMSS ISP configuration definition
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-camss-isp-ope-v4-5-51207a0319d8@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
In-Reply-To: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: RyQ1znjtq6jE3LRNJmlvruGumgAJL3XD
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a50b5c0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=kFo2aqxNIXtk6PDOeyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfXxMufgMWAyfi1
 B/SCwbqUajF1Hv5i8TE/vb+8v5GfpoNJmYlHDYq4fd3JKyKqJ8jY399ueIrq1yvigfvIYkmPpve
 czLotOgIOkAS841wcfZbT8WevY4dovU=
X-Proofpoint-ORIG-GUID: RyQ1znjtq6jE3LRNJmlvruGumgAJL3XD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX6I2uPqzrh+Yt
 ndDxb4VKSUQ4Rr9RZKLYKynS9UOpboYma2KhZ/fc06zBmtwHIDE3iuoS6gqflo/MOsrK1OYXvnf
 ybTkjpRc0G3B3/lw4OHhu2jhE5Cpx8iwkVtA1BpklQ+p+oYR0QBCnSUk/kCvvxycWeWAwO+TjdS
 E57BpzX57hzLYW4oBJZeMDMV4J+TjiMMIchZmsoa5GIA19LMyf46GX3V16OxCxotEpLQPO2Yknu
 b5mJukBROC2t29fD3p9VLtDiKrS3R3bmQOe06lu/MjA0qibK7i0BQ/un1sBEkGW1eKlfqSwwl5j
 MLOCkictQ4zWGBRqdh3+MwROcjtcp21sr4kuWPkwJQDZ2Rlv/issqKToE+Rua0FjFqfzpQ0rlwY
 Y9eSdPRapHpNSEmnnr7sl+AAqGDr0vSu7CpQYZQjoB3es7n/npVcIUFbeCUVfVJF4Xs2c+OTJYZ
 qj75yR6E1RPuPPudOgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100088

Add the uapi header camss-config.h defining the ISP parameter
structures used by the CAMSS Offline Processing Engine (OPE) driver.
This includes structures for white balance, chroma enhancement and
color correction configuration.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/uapi/linux/camss-config.h | 161 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/include/uapi/linux/camss-config.h b/include/uapi/linux/camss-config.h
new file mode 100644
index 0000000000000000000000000000000000000000..d0d087eea08337fea14211d356195cacea2fb050
--- /dev/null
+++ b/include/uapi/linux/camss-config.h
@@ -0,0 +1,161 @@
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
+
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
+ * Implements the CLC_WB pipeline module.  The pipeline applies three
+ * sequential operations per channel:
+ *   1. Subtract sub-offset (black-level substraction)
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
+ * RGB2Y - Luma (Y) ceofficients
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
+ *           0 = 12sQ7  (range ~-256.0 .. +255.992)
+ *           1 = 12sQ8  (range ~-128.0 .. +127.996)
+ *           2 = 12sQ9  (range ~-64.0  .. +63.998)
+ *           3 = 12sQ10 (range ~-32.0  .. +31.999)
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
+#define CAMSS_PARAMS_MAX_PAYLOAD		\
+	(sizeof(struct camss_params_wb_gain)	+\
+	 sizeof(struct camss_params_chroma_enhan)	+\
+	 sizeof(struct camss_params_color_correct))
+
+#endif /* _UAPI_LINUX_CAMSS_CONFIG_H */

-- 
2.34.1

