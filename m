Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025481;
	b=4+515OGlUv3F6uvvFXeG+OMlrSNB73JkQYnpA9NGbxBHY+Wt9D+02w7b6Z7ppePArElv
	 GbTY0Ht3K87SOYRXFgE2E3Ra3AzPnAtsOsFmmR7YUcGM56/fKO3ovvBtO9ATovuQ4RYpr
	 y5J6bLVNbJDYMWdCU82/XHpTtMPrVIkkyVUw7nFgZt7FjFH9rbQ48xNUuhs/HGNyUfJ3U
	 dlZEOxjDIR2+Abw/azkPe5Sr/x8iJEP+XU32HjYc8s8s+uXEg/HGgUB4tZzNOhZBjHJ0v
	 Mb4U3UPVokmnfCG6iNcaxlGM/okgtU5lFWAiXe6Dkk0TWD6Q5j1TKlsX9xBWiHjJgAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025481;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vye2QojP6EGv6J8Kkl73mdS48Ovuumpgs4z8jA+t2C4=;
	b=Ax0o2MuCTu4xfrkj9yMRrbewd+2wbMIhHp8QnapV1k1h6WW7cc6U5GKrYBWiGWvoGzsE
	 yVH3RK3O/8rBy+XefLqp97WOglRqy1D7RPtIxYyqdWwT7tURbv38RaGql+iY2qhw65Dtx
	 M4/536K3cBjANxd0+SrThHahkRBQUGbv5c7YIQWxRDVIHhe96Hg1HDnDSmbLeFKPHFtNV
	 m2BqKoxCTApyLGJVH9RVd7Q+lvNorHd8EvTujTMM+X/lANXpIlQ+/pHEFQi0ydPZu+mFZ
	 NteYfNyEJ0S9dhPIQtgN/tbntsY0Bp6aCGhxsev45tn2tHnLn9dPdvEUat7q4Ii0/Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIpEEz2e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UCpbZYWQ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D1606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 14:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901D1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SIpEEz2e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UCpbZYWQ
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt0Y03631949
	for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 14:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vye2QojP6EGv6J8Kkl73mdS48Ovuumpgs4z8jA+t2C4=; b=SIpEEz2eZw98yKhH
	fgoxNVcUqPhWnBenUcNvlM4tR2g6tnvu+Cy9rjUlQRqx+HxZ+Ypw1NDuFimrNKWa
	6TDG9tR70RKm+ncoDuTWu1AKThuIwlPv8L0w1HuMu4c9Itym3jLs63j9rAQF6t8m
	c1pULjxtauFDk/TM7m9xkTJIf5WwMMQXNwf4DVO/k0z2kqiHiGkOwQ2EhNUON/zr
	mzU5rIqqrm90hakqYSCh2skec2XWyrvE4wZj6npoTFwM3FW+SqJwOw1DBRZT/oPh
	7gmAmZfeH8IyhT28lecl1VU5mpl4jOPiEBLqztUXfKXoGlRLCmyolyGLmsJKILOW
	9dxgcQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf10x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 14:37:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c61cdfb0aso18609896d6.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Oct 2026 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793025479; x=1793630279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vye2QojP6EGv6J8Kkl73mdS48Ovuumpgs4z8jA+t2C4=;
        b=UCpbZYWQgvOg13z5R1QmKBjrHRnqqwX3lxXLDWfOffh6ZADOLl9ArHXwYvp2vyL5BC
         /bGQrqdznLiXPBqN7wr5yqacYwGg2nbKfdM+CdXeWl3jTD2i8m4tIO/fTuIPTsBWOQm1
         UV3ReOI41UAh+ZmbyWNivMkxR4+vee9D6Fum7Y8mTBcjz2ibitUvr+kNzsb4acNlg+LQ
         zdZpNh/BrDHoD0DHPRICUBAaW7Ei+L71boOoYVcxQZUMPFi0+/9q7kejnZkLWstOkoXH
         v9erBaTxzNajLnj0eKnMxWkdHd9f2D3DNutSyz2PTb/gvki0whwezpnTEbrrYVAM5VvR
         maSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025479; x=1793630279;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vye2QojP6EGv6J8Kkl73mdS48Ovuumpgs4z8jA+t2C4=;
        b=lrvgshVMrjx/ppsBl4YJPw+eeviQHyhk8wym8DJCO2K7kd0NPW6LwDPwyHSuAd5sL5
         Ar3u7/Wul7EamKi/RkI0O0J1r11W7ssZiY1YgNIWviOHXlPjak0sq6PYLEuKVmG6lBnk
         nOmxkXI2WMkFSCpxaB2dmka6B25lKLuY7k0O163ztrDhMA913uWW7XG0dO32DStQidAV
         VL+PnByoMNYbyYzSbujKM2XbKye74R938YBS5H4/ISZbsUAm9o21AK9PKhEcZAuraAjP
         GJkRA5HeqDfwPMNHzWeTUJ0fomwgLTQbb8aDg6CHVXV1BpWy9W1zDB9bSTfR73wBQgq0
         TdvA==
X-Forwarded-Encrypted: i=1; AKwUvBz64yifJ/CC1LnV4wkFgITLCX4LFuF0Sk8jxXZZ/sGg2Lb1g69hviVON8kWyEt7J6kJ9D4SO0jHFHG8qELaj58=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1m2ph7AaIPIfVV6skQsYCtTIZFQEqlpeT2GQiN49x1ab3H16v
	hWN9mPPYdWxODxYpJoJ/Q06UJrUKoK6OfyZHeVQb/c4Pl3X4nSvlladoppxesHIsXIc+s1UxzeI
	SZIYw5i+5CScyyId+jzho6y92vUQsv9DZMV2YUPrXcWd5Dty9jnrbKnT6VCoHwWpbRJc6nd0=
X-Gm-Gg: AYBFou1+bt2CthZmtfCAbFg5mmIhDW4+dXN7OpVmlCyUUff2eH+XT4M0SaNcNNBA/tv
	eOykqpP7SLeumgVNJ5WXWa9piZw7JKoL7Dpvp+EcNlReOlb+YCzTncFmtSPNOAoSRGY41Ahk4+z
	lDBqVL16i0g081jVF9gF7vqjfULWRCrFqa8t9LFr7tl+BMep8aLcezwyzZnAJHl8Wt97FJ15Lhj
	Prjx71i/iAi0J+9cGGHJUkgc4YW89SSj7azwIv5rJcYU/2cLIKUzQC+Fgr/vgxlFhm/SNcP7wZL
	x/Tdj7OfcsoNnkvVSDI5OXSU9yyM71WeLUPzGlQVbri/7xk32D39JQIVjT4EqtPPLXt8OzhLS8N
	r5xZV9EytRJ3Y60oYjjc=
X-Received: by 2002:a05:620a:6187:b0:93e:9508:8360 with SMTP id af79cd13be357-940ef914a88mr1135332385a.27.1793025478504;
        Mon, 26 Oct 2026 07:37:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6187:b0:93e:9508:8360 with SMTP id af79cd13be357-940ef914a88mr1135325685a.27.1793025477836;
        Mon, 26 Oct 2026 07:37:57 -0700 (PDT)
Received: from [10.40.99.45] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595d7c8sm3777243a12.8.2026.10.26.07.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 07:37:56 -0700 (PDT)
Message-ID: <272c9cff-608c-49e7-bfe0-c41e600c60fc@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 15:37:54 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH v11 4/9] media: uapi: Add CAMSS ISP configuration
 definition
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
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
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
 <20261023-camss-isp-ope-v11-4-0c2937195298@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20261023-camss-isp-ope-v11-4-0c2937195298@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1OCBTYWx0ZWRfX+vLrBgyMKgZJ
 gZDg8qcOx42fpa06L90zk+LYrDxxNMx0BPmsBn2O8gK8PEXaBgJ1SeEKUkJ5e3mf1+eu6AFkYhJ
 m4HkfHM4y5z55twf3q1wPqWSr62G1Hg=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf65c7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Lucp4ZlCNH_4nIn85hAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: cWgOIyA2XE9SpjiNCmQNu_7Re9RGMGMD
X-Proofpoint-ORIG-GUID: cWgOIyA2XE9SpjiNCmQNu_7Re9RGMGMD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1OCBTYWx0ZWRfX56z/habDhTM5
 StIIigZOwKYfoxRKDyi3fN3p6BpLVpA5WMyCEzwvsI4Pbd3/jw4JjuqHPt+hTPZkR9Qpb8h/cp4
 PEN7HMjyxQ1ML+3CNZZCkRchbUsgZ62S3jqbjkO+ijUd8tSIBj5+g+DxxYfvP7F14Pqt8Dsx8Ik
 811oU12xyRzgKBPMSsxtENnIKkWUhbzNabLANzBUrjWyBUsi1IB8v0goPaSqYfMyb1+Bvx9FQCV
 8iwzt7GIdVIdqCWWizwJ5O3EoRPpJodZ1i41mVibZ3tAnY/klUwYQySjHpFKcAOh1wsoOruZAa0
 OnEJS2iXvDwq8DVt9g/6T/YChev0NUikXc88PBNUpnruBFc47q/rcQ/A2TCAYktvxxNcwmU4x0x
 q8AO0WcCPeuxrCOPENds2j8kTyyyFztdJ26bz3Fv6V2IaTdLMYIbWnMWD/HlLDTohwecA4IdFCG
 kpi3kV0UPwh1H6aiUcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260058

On 23-Oct-26 5:09 PM, Loic Poulain wrote:
> Add the uapi header qcom-camss-config.h defining the ISP parameter
> structures used by the CAMSS Offline Processing Engine (OPE) driver.
> This includes structures for white balance, chroma enhancement and
> color correction configuration.
> 
> The block type enum is shared across CAMSS ISPs so that userspace only
> has to deal with a single set of block identifiers.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Also I've a test camss pipeline handler exercising the wb-gain,
color-correct and gamma parameters, as demo-ed at LPC 2026 :)

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
>  include/uapi/linux/qcom-camss-config.h | 212 +++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
> 
> diff --git a/include/uapi/linux/qcom-camss-config.h b/include/uapi/linux/qcom-camss-config.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5756d165e7e873a6d268909da077acb6f5f56054
> --- /dev/null
> +++ b/include/uapi/linux/qcom-camss-config.h
> @@ -0,0 +1,212 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Qualcomm CAMSS ISP Driver - Userspace API
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef _UAPI_LINUX_QCOM_CAMSS_CONFIG_H
> +#define _UAPI_LINUX_QCOM_CAMSS_CONFIG_H
> +
> +#include <linux/types.h>
> +#include <linux/media/v4l2-isp.h>
> +
> +/**
> + * enum camss_params_block_type - CAMSS ISP parameter block identifiers
> + *
> + * Each value identifies one ISP processing block.  The value is placed in
> + * the @type field of &struct v4l2_isp_block_header.
> + *
> + * @CAMSS_PARAMS_WB_GAIN: white balance gains and offsets (CLC_WB),
> + *	&struct camss_params_wb_gain
> + * @CAMSS_PARAMS_CHROMA_ENHAN: RGB to YUV colour transfer matrix
> + *	(CLC_CHROMA_ENHAN), &struct camss_params_chroma_enhan
> + * @CAMSS_PARAMS_COLOR_CORRECT: colour correction matrix (CLC_CC),
> + *	&struct camss_params_color_correct
> + * @CAMSS_PARAMS_GAMMA: per-channel gamma correction curves (CLC_GLUT),
> + *	&struct camss_params_gamma
> + */
> +enum camss_params_block_type {
> +	CAMSS_PARAMS_WB_GAIN = 1,
> +	CAMSS_PARAMS_CHROMA_ENHAN = 2,
> +	CAMSS_PARAMS_COLOR_CORRECT = 3,
> +	CAMSS_PARAMS_GAMMA = 4,
> +};
> +
> +/* Number of entries in each gamma channel LUT. */
> +#define CAMSS_GAMMA_LUT_SIZE	256
> +
> +/**
> + * struct camss_params_wb_gain - White Balance gains
> + *
> + * Implements the CLC_WB pipeline module.  The pipeline applies three
> + * sequential operations per channel:
> + *   1. Subtract sub-offset (black-level subtraction)
> + *   2. Multiply by gain    (colour balance)
> + *   3. Add add-offset      (output pedestal)
> + *
> + * Gains are 15uQ10 (15-bit unsigned, 10 fractional bits). Offsets
> + * are 16-bit unsigned, normalised to full input scale (65535 = 1.0)
> + *
> + * @header:   block header; @header.type = CAMSS_PARAMS_WB_GAIN
> + * @g_gain:   green channel gain (15uQ10, 1024 = 1.0)
> + * @b_gain:   blue  channel gain (15uQ10, 1024 = 1.0)
> + * @r_gain:   red   channel gain (15uQ10, 1024 = 1.0)
> + * @g_sub:    green sub-offset, subtracted before gain (16u)
> + * @b_sub:    blue  sub-offset, subtracted before gain (16u)
> + * @r_sub:    red   sub-offset, subtracted before gain (16u)
> + * @g_add:    green add-offset, added after gain (16u)
> + * @b_add:    blue  add-offset, added after gain (16u)
> + * @r_add:    red   add-offset, added after gain (16u)
> + * @_pad:     padding for 64-bit alignment, must be zero
> + */
> +struct camss_params_wb_gain {
> +	struct v4l2_isp_block_header header;
> +	__u16 g_gain;
> +	__u16 b_gain;
> +	__u16 r_gain;
> +	__u16 g_sub;
> +	__u16 b_sub;
> +	__u16 r_sub;
> +	__u16 g_add;
> +	__u16 b_add;
> +	__u16 r_add;
> +	__u16 _pad[3];
> +} __attribute__((aligned(8)));
> +
> +/**
> + * struct camss_params_chroma_enhan - RGB to YUV colour transfer matrix
> + *
> + * Implements the CLC_CHROMA_ENHAN pipeline module. All coefficients are
> + * signed 12-bit fixed-point Q3.8 (range roughly -8.0 to +7.996).
> + *
> + * RGB2Y - Luma (Y) coefficients
> + * Y = v0 * R + v1 * G + v2 * B
> + *
> + * @luma_v0:  R-to-Y coefficient (12sQ8)
> + * @luma_v1:  G-to-Y coefficient (12sQ8)
> + * @luma_v2:  B-to-Y coefficient (12sQ8)
> + * @luma_k:   Y output offset    (9s,  0 = no offset)
> + *
> + * RGB2Cb - Chroma (Cb) coefficients
> + * Cb = a x ((B - G) + b(R - G)) + KCb
> + * with:
> + *   a = ap, when (B-G) + b(R-G) > 0; a = am, when (B-G) + b(R-G) ≤ 0;
> + *   b = bp when (R-G) > 0; b = bm when (R-G) ≤ 0
> + *
> + * @coeff_ap: Cb positive coefficient (12sQ8)
> + * @coeff_am: Cb negative coefficient (12sQ8)
> + * @coeff_bp: Cb positive coefficient (12sQ8)
> + * @coeff_bm: Cb negative coefficient (12sQ8)
> + * @kcb:      Cb output offset        (11s)
> + *
> + * RGB2Cr - Chroma (Cr) coefficients:
> + * Cr = c x ((R - G) + d(B - G)) + KCr
> + * with:
> + *   c = cp, when (R-G) + d(B-G) > 0; c = cm, when (R-G) + d(B-G) ≤ 0
> + *   d = dp when (B-G) > 0; d = dm when (B-G) ≤ 0
> + *
> + * @coeff_cp: Cr positive coefficient (12sQ8)
> + * @coeff_cm: Cr negative coefficient (12sQ8)
> + * @coeff_dp: Cr positive coefficient (12sQ8)
> + * @coeff_dm: Cr negative coefficient (12sQ8)
> + * @kcr:      Cr output offset        (11s)
> + *
> + * @header: generic block header; @header.type = CAMSS_PARAMS_CHROMA_ENHAN
> + * @_pad:   padding for 64-bit alignment, must be zero
> + */
> +struct camss_params_chroma_enhan {
> +	struct v4l2_isp_block_header header;
> +	__s16 luma_v0;
> +	__s16 luma_v1;
> +	__s16 luma_v2;
> +	__s16 luma_k;
> +	__s16 coeff_ap;
> +	__s16 coeff_am;
> +	__s16 coeff_bp;
> +	__s16 coeff_bm;
> +	__s16 coeff_cp;
> +	__s16 coeff_cm;
> +	__s16 coeff_dp;
> +	__s16 coeff_dm;
> +	__s16 kcb;
> +	__s16 kcr;
> +	__u16 _pad[2];
> +} __attribute__((aligned(8)));
> +
> +/**
> + * struct camss_params_color_correct - colour correction matrix
> + *
> + * Implements the CLC_CC pipeline module.  The matrix computes:
> + *   Out_ch0 (G) = a0*G + b0*B + c0*R + k0
> + *   Out_ch1 (B) = a1*G + b1*B + c1*R + k1
> + *   Out_ch2 (R) = a2*G + b2*B + c2*R + k2
> + *
> + * @header:  block header; @header.type = CAMSS_PARAMS_COLOR_CORRECT
> + * @a:       G-input coefficients per output channel (12s;
> + *           a[0]=Out_G, a[1]=Out_B, a[2]=Out_R)
> + * @b:       B-input coefficients (12s)
> + * @c:       R-input coefficients (12s)
> + * @k:       per-output-channel offsets (typically 9s effective)
> + * @qfactor: Q-format selector (2u):
> + *           0 = 12sQ7  (range ~-16.0 .. +15.992)
> + *           1 = 12sQ8  (range  ~-8.0 ..  +7.996)
> + *           2 = 12sQ9  (range  ~-4.0 ..  +3.998)
> + *           3 = 12sQ10 (range  ~-2.0 ..  +1.999)
> + * @_pad:    padding for 64-bit alignment, must be zero
> + */
> +struct camss_params_color_correct {
> +	struct v4l2_isp_block_header header;
> +	__s16 a[3];
> +	__s16 b[3];
> +	__s16 c[3];
> +	__s16 k[3];
> +	__u16 qfactor;
> +	__u16 _pad[3];
> +} __attribute__((aligned(8)));
> +
> +/**
> + * struct camss_params_gamma - per-channel gamma correction curves
> + *
> + * Implements the CLC_GLUT pipeline module, applied in the RGB domain.  It
> + * holds one independent lookup table per colour channel. Each table is a
> + * direct (not segmented) map of input level to output level.
> + *
> + * Each table has @CAMSS_GAMMA_LUT_SIZE (256) entries of 16-bit unsigned
> + * output. The number of significant output bits follows the width of the
> + * engine's internal bus; the upper bits are ignored by the hardware.
> + *
> + * The module maps a 12-bit input to an 8-bit output: the top 8 input bits
> + * index the table and the low 4 bits are used to linearly interpolate
> + * between adjacent entries. Entry i therefore represents the output for
> + * input level i/255 of full scale.
> + * Output range: 0x00 = black, 0xFF = white.
> + *
> + * How to fill a curve (same on all three channels for pure luminance
> + * gamma; different curves per channel additionally shift colour balance):
> + *
> + *   Identity (pass-through, gamma 1.0):
> + *     lut[i] = i;                                // i = 0..255
> + *
> + *   Encode with gamma g (e.g. sRGB-like, g = 2.2):
> + *     lut[i] = round(pow(i / 255.0, 1.0 / g) * 255.0);
> + *
> + * @header:  block header; @header.type = CAMSS_PARAMS_GAMMA
> + * @glut:    green channel gamma curve
> + * @blut:    blue  channel gamma curve
> + * @rlut:    red   channel gamma curve
> + */
> +struct camss_params_gamma {
> +	struct v4l2_isp_block_header header;
> +	__u16 glut[CAMSS_GAMMA_LUT_SIZE];
> +	__u16 blut[CAMSS_GAMMA_LUT_SIZE];
> +	__u16 rlut[CAMSS_GAMMA_LUT_SIZE];
> +} __attribute__((aligned(8)));
> +
> +#define CAMSS_PARAMS_OPE_MAX_PAYLOAD		\
> +	(sizeof(struct camss_params_wb_gain)	+\
> +	 sizeof(struct camss_params_chroma_enhan)	+\
> +	 sizeof(struct camss_params_color_correct)	+\
> +	 sizeof(struct camss_params_gamma))
> +
> +#endif /* _UAPI_LINUX_QCOM_CAMSS_CONFIG_H */
> 

