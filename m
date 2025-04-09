Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0A26B09A
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213628; cv=none; b=cPiBZC5VMQqHf20sWpDAtNcZmcFGTWvqiXTlOfL6KooIcMpmh/2N0lkneHjOzsqfBYB2eLyVJn+ShLyV9Mo4ixmA278kFVtxorwHEUHpK3tlz4F8bqA4O9aT7yZ6fJsrU56t1/Quo14b78p951Jv1Z8uh8DyVmQPTbC2ibAKN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213628; c=relaxed/simple;
	bh=oG7tmQ/ls/+HhXNBi0mONoy2wFrs+TaCAhJQB10Zq1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTmHAD3tdxy5XlIAW0vmhdGGtWu9WdsW4GRleN+pw/ResMr8TpwEJOCkKVc8ob+qoyjD2fdAINTUCIUwesp3U995hXwN3V72ummYEFd2wVETNAmJoVFAHAAOlByx4Arhej1z9DkVUIXWaheoFD1MYVhuK2MSutPwqVoUvioiHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGXx7aN8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGXx7aN8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53981reR004569
	for <linux-hardening@vger.kernel.org>; Wed, 9 Apr 2025 15:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mGj9y69QHKe3+tDT9FnF5QoDdKX7mW0cM2oMhuEhV7U=; b=IGXx7aN8BJcqZ0c/
	ExZcZRCzzLT0FlxaEWfaTB812bIDqg6FoU3dlGv4o63I3ZPeiDF0SsW5SMIrD0Fz
	xJDCNR3aEGiz3D0WsBGoymBOWWi84M6Ez/5OGMYp2/rtCmcpFHW7+0NxBAdv1sXm
	moqUrRDx4i+tDF8HDEVaprvxHd790LuxywfQmUb3uxJrNJ0kNUAUDRn6WjPjUclL
	h0Qc6KNJ12IKfMSKvAA2H/f81mBMyPrKBoRxrFL9Ad8o1US3L9dW7fG85X1j8/o4
	L4Dodd+efAT7iozwI1n5+3qrbkrRKeQ6EB3QMHgPKC9coJnCXpy08+5pPTBkza40
	u8YCNw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb3yjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 15:47:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5ad42d6bcso190666285a.2
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 08:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213624; x=1744818424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGj9y69QHKe3+tDT9FnF5QoDdKX7mW0cM2oMhuEhV7U=;
        b=g0hE5CmtfoavxU5jlaV2j/NMYRy6gH8sWlchldxl3Prfcjm9nFCfJLoks+wNbDKNaN
         f9q1N1a9v/iIsJupggo1UhNlK6OzYhAh2mQJm1F8SWYDhDcf+0wghh3bQFfaWrWO4edL
         nQ2r/zapAs6Yppt3qZERGvN4sAISv6pdclOd/c3ueFn3qOE8ypmxJsvzzfmy4Nn38BWI
         VxvG92rYrQBuMWDRTo5zJhNacGCZVPAlBfloK8OxhEQFSfrkTjjetJSXQ7Hp6MQXMVue
         xG9PwGJ1YVRoUfN9sxfH1USlDtsLLU5Avgem1iwY1zkzu7Rpmfk9BqHF3ounEZzmL7b+
         Jv8A==
X-Forwarded-Encrypted: i=1; AJvYcCVg1qwGnqsV4/nA6BsWsacY5acXQpMapBSlzN7XAjERMsuVQWAVaiGeAks0USqQJ3frBJQhXQgIgURPjFOcnWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8EV1b6uoulO5TNOUihJGZ2D+xqQ1UvMMXDgp1SbhWpwx+miM
	C+6BXszalwl9Emjjq0PSfzTq96tsePCl39U9zxmLtGJjiu29UsUJZMuS9pjWQCFte9Gb2K9LkZo
	p0jLChY/9O7Je34URfKvrgM3MlScCsmnvHtHGlC5nLoI2F4/MSOmYYEeS2/9fEspStnI=
X-Gm-Gg: ASbGncsWxmwi00fMZrXbTOmtHm2olKhUdAIoS+9BldQvYBWh1+f3NZ4Qz/Smj1BTrcC
	v+NiFt8Fiv5mCt2at4i7mRicVjMiTskI46XuerEkK07RLb8FsHwcTY6D5eecTfn3clbEVx7bgtp
	BIOHsQLAUoNxG/HwpxR0wQU3POg+4xFk/NmYbFw17vI+Uv3LLgoIn8P8fJuhdIvS1QdbOAYQZhc
	A2t2yVPhqZCZCS+t2HH3BDtfVOSZ6tVNFqQhFZPHDTRYub3jrrd8A4UD+pYzS8UqyyLVvaIV6hY
	u3lC9fvpXTqLXaBWx7ggyUg+kor4Qbuql6p8LedhzkBrbWeXbJhc5fMCPOxScmTYrw==
X-Received: by 2002:a05:620a:319d:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7c79ddc0062mr131355585a.4.1744213623570;
        Wed, 09 Apr 2025 08:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9BR2XdeykvWdhqJj8WMwZYRklWgdHjFIJLEq2GXaWcLHLQ/K0yinWTGwViErAHu3nY6Avsw==
X-Received: by 2002:a05:620a:319d:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7c79ddc0062mr131352985a.4.1744213623083;
        Wed, 09 Apr 2025 08:47:03 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9c0dsm116187766b.61.2025.04.09.08.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:47:02 -0700 (PDT)
Message-ID: <0fda3b72-8bff-4f3d-b9e2-cfe1ac1d3082@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 17:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/a6xx: Get HBB dynamically, if available
To: Connor Abbott <cwabbott0@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <20250409-topic-smem_dramc-v1-3-94d505cd5593@oss.qualcomm.com>
 <CACu1E7GMf0Mx2ZX_t76h+b1CPin49LGix7c5uvoWaJZC3dKyOw@mail.gmail.com>
 <c2dac38b-bbe5-4cd1-9d33-b4bba629d54b@oss.qualcomm.com>
 <CACu1E7F71M0Z5KUdArRYbLEMXoS3jQEtp=0-4LEYFRysOsYZfA@mail.gmail.com>
 <9a12e042-487b-4937-a583-709f0c37ab12@oss.qualcomm.com>
 <CACu1E7Hto_Ms3RxQjXXYB+RB+FC5n1VFtohKbe4EzKWgEk9uiQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACu1E7Hto_Ms3RxQjXXYB+RB+FC5n1VFtohKbe4EzKWgEk9uiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gKbHRaLSmk9aesDsYZuYWq_xS-WtISiM
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f69679 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=o9cw19nxWuB9g-ePJCEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: gKbHRaLSmk9aesDsYZuYWq_xS-WtISiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090100

On 4/9/25 5:44 PM, Connor Abbott wrote:
> On Wed, Apr 9, 2025 at 11:40 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/9/25 5:30 PM, Connor Abbott wrote:
>>> On Wed, Apr 9, 2025 at 11:22 AM Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>
>>>> On 4/9/25 5:12 PM, Connor Abbott wrote:
>>>>> On Wed, Apr 9, 2025 at 10:48 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>>>>>
>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> The Highest Bank address Bit value can change based on memory type used.
>>>>>>
>>>>>> Attempt to retrieve it dynamically, and fall back to a reasonable
>>>>>> default (the one used prior to this change) on error.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 22 ++++++++++++++++------
>>>>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> index 06465bc2d0b4b128cddfcfcaf1fe4252632b6777..0cc397378c99db35315209d0265ad9223e8b55c7 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>> @@ -13,6 +13,7 @@
>>>>>>  #include <linux/firmware/qcom/qcom_scm.h>
>>>>>>  #include <linux/pm_domain.h>
>>>>>>  #include <linux/soc/qcom/llcc-qcom.h>
>>>>>> +#include <linux/soc/qcom/smem.h>
>>>>>>
>>>>>>  #define GPU_PAS_ID 13
>>>>>>
>>>>>> @@ -669,17 +670,22 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>>>>>>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>>>>>  {
>>>>>>         struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>>>>> +       u32 hbb = qcom_smem_dram_get_hbb();
>>>>>> +       u32 ubwc_mode = adreno_gpu->ubwc_config.ubwc_swizzle & 1;
>>>>>> +       u32 level2_swizzling_dis = !(adreno_gpu->ubwc_config.ubwc_swizzle & 2);
>>>>>> +       u32 hbb_hi, hbb_lo;
>>>>>> +
>>>>>>         /*
>>>>>>          * We subtract 13 from the highest bank bit (13 is the minimum value
>>>>>>          * allowed by hw) and write the lowest two bits of the remaining value
>>>>>>          * as hbb_lo and the one above it as hbb_hi to the hardware.
>>>>>>          */
>>>>>> -       BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
>>>>>> -       u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
>>>>>> -       u32 hbb_hi = hbb >> 2;
>>>>>> -       u32 hbb_lo = hbb & 3;
>>>>>> -       u32 ubwc_mode = adreno_gpu->ubwc_config.ubwc_swizzle & 1;
>>>>>> -       u32 level2_swizzling_dis = !(adreno_gpu->ubwc_config.ubwc_swizzle & 2);
>>>>>> +       if (hbb < 0)
>>>>>> +               hbb = adreno_gpu->ubwc_config.highest_bank_bit;
>>>>>
>>>>> No. The value we expose to userspace must match what we program.
>>>>> You'll break VK_EXT_host_image_copy otherwise.
>>>>
>>>> I didn't know that was exposed to userspace.
>>>>
>>>> The value must be altered either way - ultimately, the hardware must
>>>> receive the correct information. ubwc_config doesn't seem to be const,
>>>> so I can edit it there if you like it better.
>>>>
>>>> Konrad
>>>
>>> Yes, you should be calling qcom_smem_dram_get_hbb() in
>>> a6xx_calc_ubwc_config(). You can already see there's a TODO there to
>>> plug it in.
>>
>> Does this look good instead?
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 0cc397378c99..ae8dbc250e6a 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -588,6 +588,8 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>>
>>  static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>>  {
>> +       u8 hbb;
> 
> You can't make it u8 and then test for a negative value on error.

Fair. I think it was u8 in a pre-release version of the patchset and it
stuck in my mind.. though I'dve expected clang to warn me here..

> Other than that, looks good.

Thanks, I'll change it in v2.

Konrad
