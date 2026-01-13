Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6C3033F5
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318284; cv=none; b=VT6Bf4CPVISX1G6Fjo760LYwj3Dv+UVPvhOBZXaX8+jTWtDiyOeFVZim/GccXgU398vKgxd14XmkcGc46XKKRXB0XK4r9HKOWXLwG7tYfS+sfS4T9RuODMYwcKgJxM2Azz4HLkRe79bSx1oS0ypr8+6j3V9UA0YrNVaGY2N2Kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318284; c=relaxed/simple;
	bh=pagwsMEhIBmSOcK4BaiKARoNQzk6E3odr509GL2yYFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHNd3l9/YLSA/Ew9ISYLYFEVXnbinDLJVgFYdQjRGpY3hzR19EBg/GiWaGbAdXhUkTyoYjmJPlWeiWZKEodnOYFkE4rrf4ERbPyatO27dx8LzMPSuxPpsWwq2YkM5wTWGg0bL9/nGaqmu0mqLYC2PvMqqDqRG1TrluPvCHoKjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDuBqgf2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OdKl1DoF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDuBqgf2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdKl1DoF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DBDeRc4164961
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jdh/o+SXQDB+611mtKFjE/D68KoXr5mEtsYbTZq6sHI=; b=NDuBqgf2zIg+H73n
	i6AtMEXz6x5zXjXzrYrAyKNFRBSo9tcOl+8FFlednRWBrPPTu6Tn2nML5zR0OQrL
	q7TjA+gyj8esCth8LQ94/XNe/yuGGEd9s0DoQyjR4xv37mXSAbmLdcg4+3U/AqTH
	RzZUvrygy6dPloZ73RjXgb+7AyLbCygJUV6Xt2aN2Da5JEO+kuJDN/csT0yfoK5R
	0U50xIj/IkbofXQRRgHzKZuzX+tboeTmaId8X8pAZgxQaDIH/kB3UYX37Kuq8Eh6
	moH1OK6Gd4CioisOiVJL6FfmnaMXxZQ5fPzEZyiCerLX/8cuNcZSxhr6nbJi5whD
	j4nXKA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnn06rsh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:31:22 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ed07bdcefbso208503137.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768318281; x=1768923081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jdh/o+SXQDB+611mtKFjE/D68KoXr5mEtsYbTZq6sHI=;
        b=OdKl1DoFMTqXrGRNmSffDWgsPivJa6NYgjD8AVe36bFKl5yFwcZ5V/0Hs7wrgAB+0d
         GAG2IJjGZdM/YUr2nnJwc2xlT2lfFR0UbgzQpmVhMJ1fZWy0v67XjV596/cGE5aazbIR
         s2F+nPvU5rgB8MvYAgvnXuIo82YSrTThwTrX79Ta/nKAjDaK04O41aVSu+ALJUX86jZu
         lZ1AFKFQum76NPVQ3ngoJhP0wBHQovnjzv5HqtXfH9Oj38/BdzqW/nhFtq+dcaV6oCYR
         dB/+zr6tQVqefT/pTrPEougUUcNJXvXoDfp7M6ZWfYu/SFTIQRUVFkF8U/PEfVfNCDSO
         pKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318281; x=1768923081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jdh/o+SXQDB+611mtKFjE/D68KoXr5mEtsYbTZq6sHI=;
        b=FJzxCCHYX7hLqQTDcVCsOw+Hi4icXMVpJixmatwPiaas8KSLJ3jC7aZJo4CAEw8lXH
         sdwRRSt6SfNmU5BBLDJDVNS660vkbhOC0N3nzH2LgcykDZUlM13qk+O6+nb14wsynq4q
         yvYJGGdg4AR/DZwSFwQQf5rMcS3dUyuRkVtvKuKXzcCLdEmk84pNDHOMZW6H3FJGtlqL
         QPAn1M1VF8nA4u5d8Mzfzk90JCQFeqcCs24qs81hnhoE9I/eXg7mOl3AbeXnMg4K6uGq
         OSIsXwpRbOMkf/8MeaVyu06LDyu/udq79+mE7i+j9zcShzIOYGYoUBIkwbbtCYebAL5H
         C4Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUne6ZT5ysyKqTmViRuoLDqH95beJHqI+lxNdsM+AhrbpA8VeM87D3Uqcwt07IctbzSq89hpxq9OhQ67pQOZ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoUvL4KIHss/KoEkv/wEW/mnGkacIPDyIicphNCh3PE0oFI3T
	0107jaYwdMgeHaXjjK98i6C5LPy39ZZg8xm9mhac039eCGH/w93W96mTfbq55lZs76dYeklBdEt
	Yhvr4kQda/moHwpMR0iaJ47+kYHg5aDUf6UJ0dj7scxNE2OWdPNl99MBFg0A1LcAYulU9XUk=
X-Gm-Gg: AY/fxX4/V0fgE+cojlUqtxcMOyZ10lGXAATcSa6ejsEdQFc69nHTkVXmHFbQTSJZmZl
	aAnZzcqye49NJX9ZwgW/ke00+fD/fA6quQHmQWCpOGbNYA7QLmeQDDqE7zD60rwRERmv9sTjOuw
	/fB0CnPIb/qjNMvoGPE31LASk023SzFbZAwPKXTUmpzOsoYWnPwNRkdIzNdOTAv0D2SMzFded/E
	LFYZNzUw0blTUQ2GcUmwlJdG7LOwRK/n4DWt/oRbsXHaXl9SJ02pPcuqrp7eEH9w7we7KyN51+G
	Ora1pFfLqR/3bqg1PouUi1hby0n1G8FJbh9ZNYpNdg7EwGooJgAWd6hP6mSyRqlqgnAzfSPTBAx
	2kgZ0J6dkBB+xehcrI2EXFRo6yn4NxLQIjh2LWAqZL3owClZ2m7/BC1Ik4CnfL2zM65w=
X-Received: by 2002:a05:6122:c1ce:b0:55b:ac1:d05f with SMTP id 71dfb90a1353d-5634735d2e6mr3999022e0c.0.1768318280019;
        Tue, 13 Jan 2026 07:31:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJaDNb89277U09zQgcbIRSDmN8Tc2NQbPIkmYjjiiCT9F6GWII0ZfQNvgvatDzT93Kgyw+wg==
X-Received: by 2002:a05:6122:c1ce:b0:55b:ac1:d05f with SMTP id 71dfb90a1353d-5634735d2e6mr3998977e0c.0.1768318279128;
        Tue, 13 Jan 2026 07:31:19 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87207e08a7sm519832466b.55.2026.01.13.07.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:31:18 -0800 (PST)
Message-ID: <befc5600-5cfd-4134-928c-80e3b1b4102a@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 16:31:15 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soc: qcom: ubwc: Get HBB from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-2-6b64df58a017@oss.qualcomm.com>
 <you4xijwc5g4ngcnhxm4ecn7opexnsdfayvd5wiiqpl7734r7w@bdkpjqmlzxre>
 <b2pqfrs2ptaoxxeanzumxyibmydsoiqslcsg6yrm4hihynowj4@mzazqnrptnyf>
 <hunbpvbfkcxzbnwr676z6fncgdhfumjedx7jp5izojusg3rj7f@5te77lmqcdaa>
 <cleh7dolqus3grexqfchtavvnj6wef6rlslgv3r7gesfuyxhs5@5b6z5gwtn36b>
 <nhgxvv5bm3bevq4qkqnew6gaqlwiaicrs7yjckg26fgwnffqj5@u2phabfukljx>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <nhgxvv5bm3bevq4qkqnew6gaqlwiaicrs7yjckg26fgwnffqj5@u2phabfukljx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qvE2s3lPb-mx0LCPqcJPCQQce_065ItT
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=6966654a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KxVwwE8FzcsyeGkQqd4A:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: qvE2s3lPb-mx0LCPqcJPCQQce_065ItT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyOSBTYWx0ZWRfX6C20Sw64HqDf
 X8HZuFmknKobhQvX9Xuj9Q+wXlw0dULFtrfbGTQ0RYh1S46anPqYX8YtOTbwmIeHLsx4c8dt90K
 usBPNTdH69jcC+GBZSqIb2PGeJtWp7Xxvpjii4UinIzbmzUbKjONKJzmGZzRePc/5XswtP9xl69
 6xVcznq3PSjJPV72pE0UZCvLRLXMajwSK4CdtFE8rTuThUo47SmShL+YwOfBAl5UFX4l/m30UGK
 kMzOWOzxYICXwGNGAYNPyJilKhjYe+iDRgDXP9ajhH7B7Gveq8+AvesbK/u1pD/OJZ0IwD0ufZH
 +1GCTApAjVUnm1HG7lsa8TD7Z+6pxEyeaf4VGQLRiz2ocKOnqafOZ9yGCA31qv0Bc4BWUVMXYUH
 w4vHjt6qCEkA2kpLE+jey2hl/AzLKH3V7gRxgRIP36l719IkhZgLVr3EQGkuzZL/Xb2xBvnXwmi
 h65EnfpUMu5etSh6vtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130129

On 1/10/26 11:45 AM, Dmitry Baryshkov wrote:
> On Fri, Jan 09, 2026 at 11:50:46AM -0600, Bjorn Andersson wrote:
>> On Fri, Jan 09, 2026 at 05:21:10AM +0200, Dmitry Baryshkov wrote:
>>> On Thu, Jan 08, 2026 at 11:49:54AM -0600, Bjorn Andersson wrote:
>>>> On Thu, Jan 08, 2026 at 04:45:49PM +0200, Dmitry Baryshkov wrote:
>>>>> On Thu, Jan 08, 2026 at 03:21:51PM +0100, Konrad Dybcio wrote:
>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> To make sure the correct settings for a given DRAM configuration get
>>>>>> applied, attempt to retrieve that data from SMEM (which happens to be
>>>>>> what the BSP kernel does, albeit with through convoluted means of the
>>>>>> bootloader altering the DT with this data).
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> ---
>>>>>> I'm not sure about this approach - perhaps a global variable storing
>>>>>> the selected config, which would then be non-const would be better?
>>>>>
>>>>> I'd prefer if const data was const, split HBB to a separate API.
>>>>>
>>>>
>>>> I agree, but I'd prefer to avoid a separate API for it.
>>>>
>>>> Instead I'd like to either return the struct by value (after updating
>>>> the hbb), but we then loose the ability to return errors, or by changing
>>>> the signature to:
>>>>
>>>> int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
>>>>
>>>> This costs us an additional 16 bytes in each client (as the pointer is
>>>> replaced with the data), but I think it's a cleaner API.
>>>
>>> What about:
>>>
>>> const struct qcom_ubwc_cfg_data qcom_ubwc_config_get_data(u32 *hbb)
>>>
>>> I really want to keep the data as const and, as important, use it as a
>>> const pointer.
>>>
>>
>> I guess the question is what are you actually trying to achive; my goal
>> was to keep the base data constant, but I'm guessing that you also want
>> to retain the "const" classifier in the client's context struct (e.g.
>> the "mdss" member in struct dpu_kms)
>>
>> If we're returning the data by value, there's no way for you to mark
>> it as "const" in the calling code's context object (as by definition you
>> shouldn't be able to change the value after initializing the object).
> 
> And I, of course, misssed one star:
> 
> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(u32 *hbb)
> 
> This leaks the knowledge that HBB is slightly different kind of property
> than the rest of UBWC data.
> 
>>
>> You also can't return the data by value and then track it by reference -
>> as that value lives on the stack. This has the benefit of making the
>> lifecycle of that object clear (it lives in each client) - but perhaps
>> not a goal of ours... 
>>
>> How come the ubwc config is const but the hbb isn't?
>>
>>
>> If we want both the per-target data to remain const and data in the
>> client's context to be carrying the const qualifier, the one solution I
>> can see is:
>>
>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
>> {
>>         const struct qcom_ubwc_cfg_data *data;
>>         static struct qcom_ubwc_cfg_data cfg;
>>         int hbb;
>>
>>         ...
>>
>>         data = of_machine_get_match_data(qcom_ubwc_configs);
>>         ...
>>
>>         hbb = qcom_smem_dram_get_hbb();
>> 	...
>>
>>         cfg = *data;
>>         cfg.highest_bank_bit = hbb;
>>
>>         return &cfg;
>> }
>>
>> But we'd need to deal with the race in cfg assignment...
> 
> static struct qcom_ubwc_cfg_data *cfg;
> static DEFINE_MUTEX(cfg_mutex);
> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> {
>         const struct qcom_ubwc_cfg_data *data;
>         int hbb;
> 
> 	guard(mutex)(&cfg_mutex);
> 
> 	if (cfg)
> 		return cfg;
> 
>         data = of_machine_get_match_data(qcom_ubwc_configs);
> 	if (!data)
> 		return ERR_PTR(-ENOMEM);
> 
>         hbb = qcom_smem_dram_get_hbb();
> 	if (hbb = -ENODATA)
> 		hbb = 15; /* I think it was default */
> 	else if (hbb < 0)
> 		return ERR_PTR(hbb);
> 
>         cfg = kmemdup(data, sizeof(*data), GFP_KERNEL);
> 	if (!cfg)
> 		return ERR_PTR(-ENOMEM);
> 
>         cfg->highest_bank_bit = hbb;
> 
> 	return cfg;
> }
> 
> This potentially leaks sizeof(*data) memory if the module gets removed.
> Granted that all users also use qcom_ubwc_config_get_data() symbol, it
> should be safe to kfree(cfg) on module removal.

I really don't understand why you'd want a separate API for hbb, if
hbb is already available from the larger struct *and* if a driver needs
to know about the value of hbb, it really needs to know about all the
other values as well

Konrad
