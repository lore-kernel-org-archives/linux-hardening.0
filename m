Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3ED48CD4C
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331676; cv=none; b=MrZptUoJjCg0/F76VyiSwHs4AwmnMaReNFcHxHC0zY+2ul6s+k50THG2EG6jdomhIDuzJX6dR1D7C8EJpyAoe0Rit10bLVWg20N+sXOyy/ObZUjB1xWRJhrgBJP9QbJnWZAEbuzNtVQEJ2Da2pBfw/Re3PcSqLXAPL5bNANHjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331676; c=relaxed/simple;
	bh=w3fr5/TCewupjjc/06eOJlChCypygNYvjxJt8ddjDZ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b+QqDBEUnqvxeXxe1LPo1dkzVfS8qbFfDjuJaltN/Uvat6mjIM32HrvgRgv87vxzWDIv/TYijiJM55/+uPY8IA1K7Z1oHkUDh2KlQ7qHlaxxKITJBvFx7pP28KQWKMWZheUdJ854EJnZZ0skzgWOnJZ8hkNeGaDPgBjmDzNITFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FYB9D8Kl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DwF1wL7i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYB9D8Kl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DwF1wL7i"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TD8RTV2324863
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 13:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AJHjeqtzLBJ0DkrIUXw1kLHv82FgzBcaqjy5CMcQQxI=; b=FYB9D8Kll821myGp
	oCtjBA5mlKzjiHzcQ/B6n78Yp8NwsVzF+CIYghhFFk65d14nNoPOhr8WZhWBzeIO
	lLSaD83n15MRZSrWgISmNNClzT3tZYrfhLupLQaQsi4cZK179+Lpx7VPX9DF7Bik
	vT1o0pQvVFdajP2u9UMplhphA1GYv5Eg5+gp7e63v9puAfTExapkLbMfDaeaNbwr
	rj+EgZK3QuYZY4OKMpnaKcheHtJZpc3MMQLQiAEb7R7Jp1EKTryaroW23+5lHVSp
	z7MT/DGxMwaMcPAtDok/4sMxY030oToj0Q3tdO8efpgG/z5TzWFMmMY/zyZGTUaq
	cld70A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgx80cf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 13:27:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0199faafso10013391cf.3
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785331673; x=1785936473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AJHjeqtzLBJ0DkrIUXw1kLHv82FgzBcaqjy5CMcQQxI=;
        b=DwF1wL7i3HWouzqXupoI/JBUnrUF5OolaWzyu0r5T7pToUzpxDTU+7ggxLA+1YtnFZ
         bFSpebWpjCdCUlC5KQZKnqZVnCTZCzE3SKyCjJfy4c2pSPSgPNMdv1nDoZKR9xVAOxFk
         QY9MvzknKuchJSMM8oULdMFxdhLyreBPZ/xFpAxilofbOvotDlqnDMZMVGPmWxnod+FI
         udQwbA/JYjQaiWY/Opa3Oac9JlooIfbKL6rH4/vBWvMkS/XBFPzRPSgY1vXP1jirlMdn
         dwR1DgW0kYxvi8+MqAXTf+DwB5TT1iRK3e9zpukr4dNVASzE+g6SsUhV4hiKaNsV1OeX
         t5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331673; x=1785936473;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJHjeqtzLBJ0DkrIUXw1kLHv82FgzBcaqjy5CMcQQxI=;
        b=B/WDSTKYS8SsvTW5+gfhdBOGdefZpvclTdi/jTDdIww+k1ZzT/RZfVHxDA9r8qG/UA
         CA9GuACtQoIaJ1lWjiZpUgrNf1xRDmkH969kIrAMUvYbiDUzIQ6+IhS/M7FVA3Ng8WZ8
         mHW0A4FPcBfhoP0BZg32B7HByM4fnpOND4FTgAJD/aOK6vsqwXWrnNFhAuGm/6WjBQIs
         qP2OZevdkZqH83mG6mgmlMrPRZt2DqnnUPLGri4YHDGCqaZKX3LpiSFQwOY9+hV1IlKM
         4NMODTg0EqPawhhKH/V8NACv+v1lPYbLO8ufYaR7E6csgWwB4STf7HYXnq+isdimrj51
         F6GA==
X-Forwarded-Encrypted: i=1; AHgh+RrKCU7UrBL5HpJHDEX9HC0dcbKJRD1r/BYsWaRfMsPxYCh3KaJx8ICBNCReoq50cKgUIWaRdQtJsf4KHFT63tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+1EkQQLCuSg/hvvZnuAMUtazvg5YeD4GpU9oQ0S5uIOHdMD+
	nc4kbDdvjPhKZhGHqZn6bdfJe76skRsDH31P9gyaKMEHSTAsJt/KRPoAeSqxIr3E1ou1zZkTVjw
	xD3NeUZXe30+OeDhgvK2+EJbj8RfCn7ILwelAA2YDD+2Bed4KT2TuS3C3shu4XvmEwZXQLp8=
X-Gm-Gg: AR+sD13xeIRT7DvVHoRY/UwOnzf/ixsLnfGyi3Umg8QYJDk8T81d4QoJS8zPzs2XZf1
	7SrN1ePvxJgxOSrIRfYwmeFyPir5jTCUJwjyWlj8PPT5x2VrVAw0VfzJnUCTCzRxBa73tKqRG75
	mxjtEn1wduJ+aP1CL0041zW6CblIFn4bG+iuAL5PIg7dFW6kLAb5G7JwOd6rmDzi/R9FM2XNcm/
	BtwtNpyhr8Bqqvkwjn9xPrb0KhIw9LTQnlNwTlYU09CWJ07prGf7l5YQK46hCmQ364BXdTqwYZp
	eZsDRqQZUj0y4QRDGsUAHDjKnxC+9al3vbHsZYw2NScL7zSInCKQtuqeZs9JazMj7Jlfbat6bAC
	A4s1L3gVGg7LYzuLN8fI/6n1OPilGxjPVaPmRTOJ63T/16sBlEYfq7CqbSWsKFc7Yu0G1vDAfCH
	K+y3TXTsgInCY+FzLDQz74FPEVCgJWoWCVHjjT9Szsrn+pUJAgOzCi9H4IouBPWdybG/Q=
X-Received: by 2002:a05:622a:1a99:b0:51c:1529:2c0 with SMTP id d75a77b69052e-529d71d71c5mr59746471cf.43.1785331672848;
        Wed, 29 Jul 2026 06:27:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1a99:b0:51c:1529:2c0 with SMTP id d75a77b69052e-529d71d71c5mr59745981cf.43.1785331672302;
        Wed, 29 Jul 2026 06:27:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050be9a91sm897907a12.13.2026.07.29.06.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:27:51 -0700 (PDT)
Message-ID: <77f79a27-6a19-4879-b302-e7b42faaaced@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 15:27:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH v5 3/5] media: uapi: Add CAMSS OPE ISP configuration
 definition
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com>
 <20260724-camss-isp-ope-v5-3-e70ad4fa39ce@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260724-camss-isp-ope-v5-3-e70ad4fa39ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExMSBTYWx0ZWRfX9LXPaNn3EPR8
 H4gA1BzN0uzFfV+MPxBJ5r7IBhx189cWFHJ9OqU+3UDkDu/JjFMGBciLdXlVqT9X3gtkztqnk7C
 6mllWmYpQR4QWB7SX+raKGjlXHQWCfg=
X-Authority-Analysis: v=2.4 cv=MZdcfZ/f c=1 sm=1 tr=0 ts=6a69ffda cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=YAyIRdgMAAAA:8
 a=EUspDBNiAAAA:8 a=Fwsc5vey43vomTLazAYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=o1rO4XtwZBNj6n05oSJ_:22
X-Proofpoint-ORIG-GUID: yQEiWdf6-NoXQKXYJegfawGqkoVSzI7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExMSBTYWx0ZWRfX8TantMo34CJx
 KFZhCvSW2CQPIL9fUNT8DhRe/zJho75GrakAAcfXNktyDVcwXm9g58eOH0LgDKIsgA6fOYWhsXB
 3XJrQLJoRpGd84pX0MwIy15RMIR6+PnKL9ZnVU9Toy/BqdL1Py0d96vT/rCq718oID2wqA1gdrj
 FiNFNaG3n7MTGYeVG+WueI6piY9/v70qD7gLkGt1PtVzBh/r7KXfunBnX5+wF6nbn1AH+sIVPC9
 ryN8XnGxm8Vt9qNio+QV1G4fjN+WsOfn83PbGMh16zRt4+O0R5zne2A8UiMhaFw9eThEGu/NRXM
 T0ewSCaAwtI2xz8ThX3lmjBgXczwmV1EsEsgXSVEBwYyIlaBQcrS33zVN+xrGOYGnTTppmL4YsO
 tuDz2jNneEMHnBYSIUJVA6wLqE7JSTUtQen4X8QUpyANF2n1cne/l2FWHl6PeCFfx1S5E7i+vub
 D8Ngbz1By83/ghZDt7g==
X-Proofpoint-GUID: yQEiWdf6-NoXQKXYJegfawGqkoVSzI7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290111

Hi Loic, et.al,

On 24-Jul-26 14:42, Loic Poulain wrote:
> Add the uapi header camss-ope-config.h defining the ISP parameter
> structures used by the CAMSS Offline Processing Engine (OPE) driver.
> This includes structures for white balance, chroma enhancement and
> color correction configuration.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  include/uapi/linux/camss-ope-config.h | 160 ++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/include/uapi/linux/camss-ope-config.h b/include/uapi/linux/camss-ope-config.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..800e6ef1dba218ca33b565e1e51d6647f02f8753
> --- /dev/null
> +++ b/include/uapi/linux/camss-ope-config.h
> @@ -0,0 +1,160 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Qualcomm CAMSS Offline Processing Engine (OPE) ISP parameters UAPI
> + *
> + * Uses the generic V4L2 extensible ISP parameters buffer format defined in
> + * <uapi/linux/media/v4l2-isp.h>.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef _UAPI_LINUX_CAMSS_OPE_CONFIG_H
> +#define _UAPI_LINUX_CAMSS_OPE_CONFIG_H
> +
> +#include <linux/types.h>
> +#include <linux/media/v4l2-isp.h>
> +
> +/**
> + * enum camss_ope_params_block_type - CAMSS ISP parameter block identifiers
> + *
> + * Each value identifies one ISP processing block.  The value is placed in
> + * the @type field of &struct v4l2_isp_params_block_header.
> + */
> +enum camss_ope_params_block_type {
> +	CAMSS_OPE_PARAMS_WB_GAIN = 1,
> +	CAMSS_OPE_PARAMS_CHROMA_ENHAN = 2,
> +	CAMSS_OPE_PARAMS_COLOR_CORRECT = 3,
> +};

I don't think we want this enum to be OPE specific. The whole idea behind
the extensible ISP parameters is that there is a single set of parameter
definitions spanning multiple ISP generations.

There is going to be a mirroring patch for libcamera defining some C++
magic around this header:

https://patchwork.libcamera.org/patch/27430/

and this will be used in the camss libcamera IPA and we don't want to
have one version of the libcamera wrapper per ISP "generation".

So I think this should all be moved back to a generic camss-config.h
(or maybe camss-parameters.h ?) and then if for the planned Hamoa /
Monoca inline ISP work of we need say a new version of CAMSS_PARAMS_WB_GAIN
just add a CAMSS_OPE_PARAMS_WB_GAIN_V2 for that.

That is the whole idea behind the extensible params, otherwise libcamera
will effectively need to have 1 IPA per ISP generation / type which is
not what we want.

Regards,

Hans





> +
> +/**
> + * struct camss_ope_params_wb_gain - White Balance gains
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
> + * @header:   block header; @header.type = CAMSS_OPE_PARAMS_WB_GAIN
> + * @g_gain:   green channel gain (15uQ10, 1024 = 1.0)
> + * @b_gain:   blue  channel gain (15uQ10, 1024 = 1.0)
> + * @r_gain:   red   channel gain (15uQ10, 1024 = 1.0)
> + * @g_sub:    green sub-offset, subtracted before gain (16u)
> + * @b_sub:    blue  sub-offset, subtracted before gain (16u)
> + * @r_sub:    red   sub-offset, subtracted before gain (16u)
> + * @g_add:    green add-offset, added after gain (16u)
> + * @b_add:    blue  add-offset, added after gain (16u)
> + * @r_add:    red   add-offset, added after gain (16u)
> + */
> +struct camss_ope_params_wb_gain {
> +	struct v4l2_isp_params_block_header header;
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
> + * struct camss_ope_params_chroma_enhan - RGB to YUV colour transfer matrix
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
> + * @header: generic block header; @header.type = CAMSS_OPE_PARAMS_CHROMA_ENHAN
> + */
> +struct camss_ope_params_chroma_enhan {
> +	struct v4l2_isp_params_block_header header;
> +	__u16 luma_v0;
> +	__u16 luma_v1;
> +	__u16 luma_v2;
> +	__u16 luma_k;
> +	__u16 coeff_ap;
> +	__u16 coeff_am;
> +	__u16 coeff_bp;
> +	__u16 coeff_bm;
> +	__u16 coeff_cp;
> +	__u16 coeff_cm;
> +	__u16 coeff_dp;
> +	__u16 coeff_dm;
> +	__u16 kcb;
> +	__u16 kcr;
> +	__u16 _pad[2];
> +} __attribute__((aligned(8)));
> +
> +/**
> + * struct camss_ope_params_color_correct - colour correction matrix
> + *
> + * Implements the CLC_CC pipeline module.  The matrix computes:
> + *   Out_ch0 (G) = a0*G + b0*B + c0*R + k0
> + *   Out_ch1 (B) = a1*G + b1*B + c1*R + k1
> + *   Out_ch2 (R) = a2*G + b2*B + c2*R + k2
> + *
> + * @header:  block header; @header.type = CAMSS_OPE_PARAMS_COLOR_CORRECT
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
> + */
> +struct camss_ope_params_color_correct {
> +	struct v4l2_isp_params_block_header header;
> +	__u16 a[3];
> +	__u16 b[3];
> +	__u16 c[3];
> +	__u16 k[3];
> +	__u16 qfactor;
> +	__u16 _pad[3];
> +} __attribute__((aligned(8)));
> +
> +#define CAMSS_OPE_PARAMS_MAX_PAYLOAD		\
> +	(sizeof(struct camss_ope_params_wb_gain)	+\
> +	 sizeof(struct camss_ope_params_chroma_enhan)	+\
> +	 sizeof(struct camss_ope_params_color_correct))
> +
> +#endif /* _UAPI_LINUX_CAMSS_OPE_CONFIG_H */
> 

