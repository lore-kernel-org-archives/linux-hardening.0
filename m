Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634808;
	b=irrKtmR9UZWHcSrU4ThMVFVCTyKDA0xcfndn2RrK/XTCR/K3oKmOnaBKse9HmI612uGz
	 PCvBHvpEqn1TfkxFWUyN1vS6feNGxJdssPVBMhTIJ8YifbMf6/DnlT7d7vVyZKFfzG3tR
	 GKn8rt0vwWFSCDVOvYPj1Jf6PbCHlEfBPfwFrNbweAU+dSUQoFlGG+JNPnM0FwZprxry4
	 TdsyMg0vsLF1ufCka5PGfjfMS9jRFH+3LHr+jQh6husVyrwFTPSrtXs08146jsBJY3JzQ
	 LKNFQyOiuMQb/B7v8ROlbIGoMz83BDIo8VRkXGyV1nqq8A0SgzfGg+tY8rrABNq8s3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ODaIjf5VwjF2KdsntRNya0T1MnDIbUmL9YbGffxb1Yo=;
	b=H3kAJ2ukp30uoQ2YTN1A7m6xHvmf346fnRJIIInAywEiJnaCdtnBRKAm8QYOLem1IbcM
	 FD/5S3H7KN42ZP0GvI7Hl90NxzmxJ24yK0gGAFm8bo7ZlYkm9J5Yxn+s12kogL+jwNCZX
	 jV7uD1qvZIfyj4raPHSOm0NytoHgAWU9IkZNVDjG2A2TLgdhxhJOAAOGhgZIkrewp9TyJ
	 d54/G5cu1aHGYjT+E/HAzZe/EU0G5TG6RYiQMWvEe/QH2AyBU8G9pP4hOfy1gslhNySxk
	 7/tefnbzHX447EUiuC2QpIXXMF1iXox3YlGAD21m6jqSw3rcCO1NJuJW2Si24asxHRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVu4Tnj8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="a5kYb/jA";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA160AED1B
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 15:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCA160AED1B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVu4Tnj8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a5kYb/jA
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp9rW894137
	for <linux-hardening@vger.kernel.org>; Mon, 2 Nov 2026 15:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODaIjf5VwjF2KdsntRNya0T1MnDIbUmL9YbGffxb1Yo=; b=UVu4Tnj8ZPUJ7Yp1
	Nf/ExzKQ6Uh+3p2uwCXvsyNhHRzIPSD/RuneqmCjLih5DmcBTRhsd2ePvq1XO00j
	W01HwsJP+l4mpH/CDgMQM7IEaW9oaKAiJSgw8U0d0at0X/87L9yhM/G5uBMQKcsV
	MVNFG7aWQu2q15aezJGkIJBtqq/D9+JSkz5RQxMxk1eb6KGLE77Huy6jgbHcAvPq
	PfJFawohyY9mcNhig8w2JvzriBjo6Wfnrdu2Iz0/6S/dyXQwfH+mxjtaqWpCXmfx
	KQ9vc9JkpX/EsQ6z6nIFOoxI1fDpRgiETxgOC5CXuEmpb78Vwd4iSCTf4Oc5MvzI
	nLJt1A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvsn79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 15:53:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc01d48a1bso3699689137.1
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634806; x=1794239606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ODaIjf5VwjF2KdsntRNya0T1MnDIbUmL9YbGffxb1Yo=;
        b=a5kYb/jAVHknx/3aN6HG26siSYVZoKfDaO8Hhzg2IUCB9f7407q/RcnPY+BxjM4CwM
         8BL59ME0iqyZplFN+eucL4TTfoVPdk3jxCC5MdOGMVvL5xuAEmVXZjzzO0ivVGSGOfoN
         2kKYA/pSqPSOzY7slVpJWcWXP8a4xElunDNwilYtiB5ExqZVt/UuFV4hxcOnJPA0122R
         51MfQ7nPvfl2TR2S9gtG76CuhZC9/SjCyXsb4X7zzeGF5B6d5KBSOEIrfPsHOdEMENnv
         EbIYZ9Nvjl8w250Nji8GF8ZTvL8MJkZcbIiRnUdERO2DvD0xUCbMaYt75p23eJDb5icS
         OQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634806; x=1794239606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODaIjf5VwjF2KdsntRNya0T1MnDIbUmL9YbGffxb1Yo=;
        b=OLZkf9ZnAWBLRjsnhh2PAhvjdepwiUKKcgyoxiUcEqtlC9dgloYYnX4Eku3Ne11CQW
         X/jCLpBm3GXCNcLvuUmMbjTpeLladM3KmjAsRlICNi5aGQSGjBm/DLJEzttV6ZWqE6Ft
         O2Z4HKeYyx9jR3vY/hJon4d5gGThZ00h7N3b2D59Aj3Af/2aweMHOZJk2jSEv7mUR2jU
         RM+iqQ//gkP5TMYdzm9awreiq/EoU85Uv/t9VAQuq/wJr7MfcYNt4vOCxFLObn3VMdd4
         iSOKGqIeizWzYZN0ObWScqGxzY2yrBi6e39+L1JlxZble+R/eLmE9UsgOnyWXjxlI/8q
         Fvcw==
X-Forwarded-Encrypted: i=1; AKwUvByhIV3r0UU17To/lzEnBOsII6hxKS8wZlJ+lpf5Q50EWA+wpszTuEhgE30iQCLGg91xA9EGAuXCjjm/+z04wq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jE7lhIwgUrZJwL6fxfTzTHA0qT3YpjEz91SfHda/yQbcpUbcH
	te6N11jCgqmWPE0upt6myQESAKV41rdKEc3dWxM++wnhQOGNRCLB9Pe4cE5RPhRjzMrGuZW5pdH
	MKgKGpZDAembIfl3db7vCV4RMAo1PLscgyogP+ZcLJpQJaoaJn4qC7TVKsjSUD2KBrIXA1mo=
X-Gm-Gg: AYBFou2RWxruBNb1XsIaWe2+sqqWRB6KbcKag4Ru3yuQctoSOdnVElwb6l7EsZ41UaG
	QeezB8P8/JGvr4BjG44sEtSght9T8PQ1JBFZH3rDyKKwoB264r1jAHld6bT9Lj2RWX+TqGjAgpP
	L/XvvArt6SjLjMJwksK6AlADAd0ExYPeJUb623f1LP6X7Cmlsv4HILTZr8G+eYT7VLRpiKsnJxZ
	7dzW/hCsWtOGptYKBGh6cTsmpt++oSDGRYZhnZYZvvSTczEaWSfVXhaFCtjxH+c0DjBagup6T+A
	UiNj509g8TlMQhXG5ATWpA5WgAhxIuHOrVNkfJTksWs7ymLGbdCx9FZXhoWo7MpQB59xQIcqx1Z
	znn2c7otijnklzPuTqQodDmMYJFjdSYSbmlGRtK5wzNVw24XYVclg/wdwq1ebZsZ8fN6xjEg3NK
	vyrJ+dfHd6FQgT6ui6IzpRUypgfgqesVlrOE2SsZ5AmkfUizBZAwU2CU49i6BMi2mw3A+VEQPMa
	Sh7rhxOLR8TbOdwKf2diTRXmhNz
X-Received: by 2002:a05:6102:5244:b0:7c8:78bd:fd7a with SMTP id ada2fe7eead31-7d054298427mr3918346137.25.1793634806134;
        Mon, 02 Nov 2026 07:53:26 -0800 (PST)
X-Received: by 2002:a05:6102:5244:b0:7c8:78bd:fd7a with SMTP id ada2fe7eead31-7d054298427mr3918321137.25.1793634805562;
        Mon, 02 Nov 2026 07:53:25 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20700323f8f.38.2026.11.02.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:24 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:47:35 +0100
Subject: [PATCH v12 4/9] media: uapi: Add CAMSS ISP configuration
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
Message-Id: <20261102-camss-isp-ope-v12-4-702254689feb@oss.qualcomm.com>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
In-Reply-To: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae8b1f7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=cBt3T3tByBXynNCq78MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: EpyJIBw0Vzol0R4HoP2azKqTB20K3qN1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX8CBEwbPUZKo6
 XqAabSUsscEYFgV8/ODpQjesNThT3d9J3g8V4c1aD2L6ro2Jo4BI9nu/UmRQK+nFTOeFV+UIvnp
 /OL23IPIUnk1PJFpXqCAR+Kg/zkFLQk=
X-Proofpoint-ORIG-GUID: EpyJIBw0Vzol0R4HoP2azKqTB20K3qN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX6U3D38+BHbd8
 3ml+EElXWhq389EX5mSqo16nxggBSyPAKpXTnB2Gb8/qzj4eU07yo7JWjg8Q5yDHSSz2R/H1i+/
 X9xJYRZKC/4Qh0CqbxngmQ31GLFBEyuYKW4yHIJ1vAGYDC2iJcu+5xD5Bhb4cFsGBf32YwV8JA7
 Q29lfKOtzRgLhnxCQq7xtCBzDHDtDblTr0o61LuLyg0WmCfodGWpw3tfD8i/eJPVU+HkiP9QLRV
 zDQvSLyYxzjShIfcAF09fDkmVRjMT/8x7C0i71jQET0VS32oR1aJUDbtOUarvWCUQwMd7Fb8nVv
 i2GUwhMHPMDRHcIBGdhpd10IoEnKyP9z73zbEOLPjA+KH6YEYO31UWTrvTRTm5UJlnsdY//zhqY
 NCwg+4Xy2Xh5jL5LVCaOYnTvKMbYmNIunP1oKdVAUA0dHmshXM8I9+9+WY77QynZ4exx00SXiYV
 TMdIbHrBieAcTXe6qJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063

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
 include/uapi/linux/qcom-camss-config.h | 212 +++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/include/uapi/linux/qcom-camss-config.h b/include/uapi/linux/qcom-camss-config.h
new file mode 100644
index 0000000000000000000000000000000000000000..5756d165e7e873a6d268909da077acb6f5f56054
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

