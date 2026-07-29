Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFE4503F8
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349883; cv=none; b=K1T9wOPJCDvo1r7fj2rNgLuygmbreqIId6aFVRurbgwB+X9B3B12VtuXf+gBgBhBpm1zUUhuO+q8GdDlzUOLuYgVI3XpDRCG2zC+2QEn/2asGa+Z33LTZp+dSIwBguiusNc2VILoTGhJJgd0iyQ7hbzcYbcMClIO4HaLXc9efs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349883; c=relaxed/simple;
	bh=6Jmw8fadTclbG2T2Z68Rl3Wmmn5n2IP4R+z9w4+C6/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8RSLO3LxfQvsSB7pFz+8c3FCclnsSRMEsN9QGeffwGrD+/nfE2SqIuwMT5sfXSAa4GaT+l7IiaDO9B7UWD6N5qUnkGgSXgZ2A+Ti/kkAKfNG9QdlioxEC5AXYu88Zx/NtNrBU7KIGrB7J4ZhPtcPc3bB6QLWDoTZyxk7PKqdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OpOTluwo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SAbI5V10; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpOTluwo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SAbI5V10"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TIR6go2663215
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6e9PyztcWTGin2D498CISl8xSLMp4ILlbC/KGKMteYg=; b=OpOTluwofiGYgtjD
	lgoZRmTSWWinkWDadOgTD4hNi1AI3YjQb1xWwxVxzZDsEWAg4mkXHxZ9XgKN9ZLU
	gjWu7jPHsUMpj/d+r+QT04q+KCeFGQkeF15rWU8b10UwVDLJUdaLAo2+9zM3+ew3
	bqWcqK9Pe87PkosNZ6fv5mJVAgwm/VCDJA7a3XMR+ioA53Da6mDpeDdh1Jg+edZn
	EQliwjFqUaPdsSSQUxcn6g2BNE8HdCsZTmIpRW5j6hsqn8bjGyE+OPFLUe6z/aOH
	Jv92sgn9y+WvOzk9tx2Bz/I1ZzmtJ1WtBk/HRHKnn8Px10/SkE10W7O2jXpFCNwh
	oD/MnA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkfm9agp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:31:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a236220so12478531cf.3
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785349877; x=1785954677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6e9PyztcWTGin2D498CISl8xSLMp4ILlbC/KGKMteYg=;
        b=SAbI5V10WveV1v9cvqlR7gQUl5Q6mI1RIhmuOv8+FtHfJvV/M/9MLXTHH2hXQjVuWq
         PZiXhDL93iKAxz8bNOuyboW80GapZoxqSgWLdnB5ys6DwKoiwqUC1JNS0lekG9Ur5F+k
         VwHYpVXtmM4iliUkHygPxzjzI+39vNDcguN2/CRMwQab71uK6NsWfN4TKmijyJAAmp4D
         n1e0KEtMpLF5p44JC6lGpcia9uAAdfuc8pbCkoSS45pAA/XGg5CJ0qWHXhhRd76P3Zum
         qZayvIDOhzrdLQx9/YW4109IsEnzdgnbdNtMFJc7fkVEtF0N/7wc1eReDzC3UYGYVNe2
         EBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349877; x=1785954677;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6e9PyztcWTGin2D498CISl8xSLMp4ILlbC/KGKMteYg=;
        b=khR58vw2eBJvh+A7GW4UFZ69VyRdwvD3iXhLleDYHBsNGYGBrUDc+773cTYWy7MD0F
         bVsqLaXl7COPQRpaFOg7XUn09Y14wS/poj/l2Uw/P9cBZTdOQ4kkUidSATH3hhmvyDo3
         DLzTd3pN1/7YaO7Lo4qrmQkx4ToQOd/LcPSSt1OaJ5NVQ+UV41aMJoLyyTxrp39x8lzK
         99LAk0Ml85lVN6TTy6N/TwNt5H043wa1gH+Mp5k039QiPIaEPZZ2PJlh+9Y4h2f0G24U
         mMmOScYSspPdLwXn4/4ldLQSUYdxxW0LX8KRMjLeQB6FKDatvK0Q0NLes6g2YYGcgyZ2
         m4fQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvtVjo+9ZvmeeEZokCYDo6PJRstOTkj2nSlugxtc4PBxF6UX/R4XHzR3VinZlawitd5E2fP8pUm1emDuIQxiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4i+g7kPtkjdmsOwtLDGwMDFg+lwih9OIwoLcD3DkihAdlV3i
	skhRRJrdBtUmQ7lpGqCWFxirtmfFM6bb5lfEYxEr7JaEhX4CHjeG7AG4d9ojXvAOWmZbw9642ve
	saOUyO8iRLrh37B5T6Fv/bnHAVlsOSmBzHzowja8ErxA09JPc9RCPSKMi+1oQbNCtveMxyj4=
X-Gm-Gg: AR+sD10NcfHiet7PmF8uTjO98JRhDo+moooQn/R6qFVAqLjdEyCcSWtLGxirioaJR3C
	MMH4QDnXNTHPn6isR/N1MzXh5kxbfAVDijBqoVLpQ9g+XHBA9rviePKKp8tlzNMl6OWuFrzfUl5
	Z27hdqvujWR4J1IjVsSfwUNE7KtRFUj1s2MV2ghTIqsNiSdaMMfxK4vPLn2O/WEXlHmSVizj2Gk
	AEJiyXLNIV6EvV+4FqJmui6QEO4HR66ZcbI0QqyaCgFxR+ti7p/YUmjYT+s7OcMrpNjo3T8GnWw
	o/UTO3JFDvFOIMGbC/QvVY3IU5f5gaxjKcj+0V5rc61YYd3KUf3cnGR5iNAT1s8ClB7kulN/wD/
	Np7w5ROqe5iQpT4VrhG9cmZsPvC+yIA3Y/1CPXCYwNrZ0d8RG8pGPdi5nzs2W9hwUsAEU6W/S
X-Received: by 2002:ac8:7d4e:0:b0:51c:1cbd:5fdc with SMTP id d75a77b69052e-529d6faf8eemr75038051cf.10.1785349876803;
        Wed, 29 Jul 2026 11:31:16 -0700 (PDT)
X-Received: by 2002:ac8:7d4e:0:b0:51c:1cbd:5fdc with SMTP id d75a77b69052e-529d6faf8eemr75037651cf.10.1785349876366;
        Wed, 29 Jul 2026 11:31:16 -0700 (PDT)
Received: from [192.168.1.31] ([85.196.172.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6acb6c9sm11104361f8f.13.2026.07.29.11.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 11:31:15 -0700 (PDT)
Message-ID: <50662ecf-22a6-43dc-baca-9cd58001b51e@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 21:31:13 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] media: uapi: Add CAMSS OPE ISP configuration
 definition
To: johannes.goede@oss.qualcomm.com,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
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
 <77f79a27-6a19-4879-b302-e7b42faaaced@oss.qualcomm.com>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <77f79a27-6a19-4879-b302-e7b42faaaced@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D6p37PRj c=1 sm=1 tr=0 ts=6a6a46f5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Q/e3f29T3Hw2hnAEzBPF7w==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=YAyIRdgMAAAA:8 a=EUspDBNiAAAA:8 a=Yqt9_RdanuqypNOcg2YA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=o1rO4XtwZBNj6n05oSJ_:22
X-Proofpoint-GUID: g6T9MbNIkVJYXP-LjylWG7e-bBAm7bko
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0MiBTYWx0ZWRfX7Dg8O/QPELCu
 53jGQxnnNtxRvvKBC18PAO1aqbDP4eFDtbDWZWhm49LfEn9m3whkCDYTUPq4eUixt+F026RElq0
 KNyImcf1GcTcEHN/jUZiOGttVIA4tac=
X-Proofpoint-ORIG-GUID: g6T9MbNIkVJYXP-LjylWG7e-bBAm7bko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0MiBTYWx0ZWRfX++18WOuLIsgT
 hYKKIt4TDpPcgb+5GEAO/x530koCf8a/gaTBeiAtT8Nyij4zvweCfg93SFxrmXQ39bhP/CO1W6V
 SoSCFnvIPkW9YKPDqe0RK8E54LPBwqEF0jPAtpndVp0XSkq8kqqE/1jRSLx/ZefRBm7ahoiKYnP
 MIIZG4nqE3FiUsDU7hmsaaS3xyALLx3yYVQzuI/U/1bHGB8LSOeOIk1AhfVrhZQGTxIv9zmUq9D
 Zh3SXJsSZVaUPJR1V24WAYXYN2auJJBYD2k1/nxaUOLGX7wgL2BLadrTjPMVhr3NyI++oBK/kXx
 Msrkx0VXJol0mjasbcwHKfeA7L2QHT1jIIRPiEkH/T//XhRw6FeaS7Mo68gd9gxHVxUFZOvixrr
 dR7HUVxJ1dbPG/f9g6m/FhvgJ9ZMVtz4KtxLNHXXL309Lp3vrmDo44g9fTpRsvaVVkMt9YKYFVs
 u7HtkacXdJd63glXPDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290142

Hi Loic, Hans,

On 7/29/2026 4:27 PM, johannes.goede@oss.qualcomm.com wrote:
> Hi Loic, et.al,
> 
> On 24-Jul-26 14:42, Loic Poulain wrote:
>> Add the uapi header camss-ope-config.h defining the ISP parameter
>> structures used by the CAMSS Offline Processing Engine (OPE) driver.
>> This includes structures for white balance, chroma enhancement and
>> color correction configuration.
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> ---
>>  include/uapi/linux/camss-ope-config.h | 160 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 160 insertions(+)
>>
>> diff --git a/include/uapi/linux/camss-ope-config.h b/include/uapi/linux/camss-ope-config.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..800e6ef1dba218ca33b565e1e51d6647f02f8753
>> --- /dev/null
>> +++ b/include/uapi/linux/camss-ope-config.h
>> @@ -0,0 +1,160 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> +/*
>> + * Qualcomm CAMSS Offline Processing Engine (OPE) ISP parameters UAPI
>> + *
>> + * Uses the generic V4L2 extensible ISP parameters buffer format defined in
>> + * <uapi/linux/media/v4l2-isp.h>.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef _UAPI_LINUX_CAMSS_OPE_CONFIG_H
>> +#define _UAPI_LINUX_CAMSS_OPE_CONFIG_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/media/v4l2-isp.h>
>> +
>> +/**
>> + * enum camss_ope_params_block_type - CAMSS ISP parameter block identifiers
>> + *
>> + * Each value identifies one ISP processing block.  The value is placed in
>> + * the @type field of &struct v4l2_isp_params_block_header.
>> + */
>> +enum camss_ope_params_block_type {
>> +	CAMSS_OPE_PARAMS_WB_GAIN = 1,
>> +	CAMSS_OPE_PARAMS_CHROMA_ENHAN = 2,
>> +	CAMSS_OPE_PARAMS_COLOR_CORRECT = 3,
>> +};
> 
> I don't think we want this enum to be OPE specific. The whole idea behind
> the extensible ISP parameters is that there is a single set of parameter
> definitions spanning multiple ISP generations.
> 
> There is going to be a mirroring patch for libcamera defining some C++
> magic around this header:
> 
> https://patchwork.libcamera.org/patch/27430/
> 
> and this will be used in the camss libcamera IPA and we don't want to
> have one version of the libcamera wrapper per ISP "generation".
> 
> So I think this should all be moved back to a generic camss-config.h
> (or maybe camss-parameters.h ?) and then if for the planned Hamoa /
> Monoca inline ISP work of we need say a new version of CAMSS_PARAMS_WB_GAIN
> just add a CAMSS_OPE_PARAMS_WB_GAIN_V2 for that.
> 
> That is the whole idea behind the extensible params, otherwise libcamera
> will effectively need to have 1 IPA per ISP generation / type which is
> not what we want.

Can we change the name of the header to not be OPE specific. An proposal will be camss-config.h,
i believe most of the parameters will be the same for other ISP versions.

~Gjorgji
