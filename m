Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222521A459
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526545; cv=none; b=ZLTMCrB8sHiEuhnJm635vCnIHDcsYLkyS90vghrn36M+3i1VoRMyRzN+XEHdzMPU+x9E4AXsxsBrYfrVs4oHfq6QU7AV9yYjbiYIENAHya1eQeXcATtvzpd0ETOSLGvKpOYtBO6FNmUXBvaMov55U2DTMyvPBcwkYPddxB/XOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526545; c=relaxed/simple;
	bh=jaF2/WGmmF6IhprUJ3GJa+AzVehMU23iTKAX6lGzPnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diVsLmhnuJ0AHL9ayaEmKyHpCYXcEvKnxZut2s6yCkqUVNrT5F2TYH5F/ytL506FqOHvbB4RUMXs547bbqhZNs/rsg3mZJAfQxrP/VsMhPfWEPdPAjI94UxeehoewQKp/Uc9+qumOGTNoeij7k4fs98yZKRyyY2xjUq6u1j4vtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuFXDoxV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuFXDoxV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJmffK006908
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 20:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AE6pFsekqcqEpjtxscTH0U9yzSRkz2si1yg/1Rn6R0I=; b=FuFXDoxVcgsmKjY8
	bMlQIDCswn+OWe9kpnZwSVbK/gROM10pRlRH+jjoT2NZ5o/BOvs/L1U1fk1WWelN
	PRAh8+BzNJfrzr9fjgBU79QOpCGmwZYm+W1sV7zsUPL3NQdMRvYyiP7G8DTeL7Xo
	AbUP/VmKBR4jeBQDSbtnSSP5o4SwTFVC+P4vVf3f7v9RAMugBeJaZghvaHOISPZF
	xt1j+Ew1XUisdTeuFo1SjnkT9XeScVZoIyhBhD51u/phtHzuvgVgG/tWK563h3s7
	G8tHf8aMxpPFSjY1c5DLX+RAXQ9EfWgmRbt8+ljbSB6cjvJfE9oQ9/ZrRpn3BwlV
	rn4QDg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2evu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 20:29:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54734292aso31314185a.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 13:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526542; x=1746131342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE6pFsekqcqEpjtxscTH0U9yzSRkz2si1yg/1Rn6R0I=;
        b=rHIhGbKKvAJIrT0LGrjQywFn8ANG0nYiztDO7iJXPwDNSEAfjKx1iS85x9Gk3rP2YH
         V6VX1BeBcbv3GodeZl2I3zizb0q7YLlnvGcgJgYo9q6bUYUdH3X1DCTu40yRyI0C1oCh
         gBQdAc4vxEk8uL2uNPe40kRHYbjwSXd8bJNREKA2YjalKLqli6Da31DEEzNctJDemyfK
         Na3rqY8GS7cI8nrNwV8njFpSJ2JYYBo499j4nbYzvQug71NNZXyL4f0/rGHkXVQI5acO
         FvXqgvwg9zY2F2r81P7oOampJMVgx0i/gpowtw6vwlhyzxOt2SDsXZBtLQgT9ybjX53s
         woEg==
X-Forwarded-Encrypted: i=1; AJvYcCWL2IwJIrpB0bkAhMzTudZJ7sl6UCIxISuyom7AYavv91fEplgkOITh4EbsBRBWxtgIysC8SmOkgaBnO18PioU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAiI9qhLGtzr5YN5koirDH/gpDySZ/iTeekPLSsAoc5E3kuBy
	mBNyN1BGohMrGOfikE66uim8aMXGxNdxwGXa3T3pI4CW0LeKmFnbxBXtyW01vEo8zraNIhyUeUS
	2p51bxve8eAw03agxO7ufk88eIff4FogQu0h5Xz42NdQefuzqcYy6SkKA9grmpQQQ6X4=
X-Gm-Gg: ASbGncvYVT401clZS7idNXS2gXXYYt5E95E48xYgHaPQODr2Yu1GMJIw/Jsla73MO2E
	zuR3OyAEqlqWABDXyH6Ay17qBqCp+SFJLiMwt+qH6CKYJXovN3vJ4xiStwdV4Ne26aCMlth1I/g
	zt9bWKEOZCSQuHsPuOBYo0KpaTJUUy2iviZyJK+x6wEQAatvK4bo0tFWyKE0Yx34+dJCRdO/yIV
	mN9OI+E2yOcXspeeDhMEBiuMguUmDFleKMdWFAUgtnrWKxA6UB8Yrcrahhx1BfBPkiZegm+nXZs
	vwgrV2doQBEURcwx6zAyabd3jh+vVjppzAaNCO/c1jw+cU/X8ydJJ2K06sxu7CoRbsQ=
X-Received: by 2002:a05:620a:390a:b0:7c0:b106:94ba with SMTP id af79cd13be357-7c956efd7fdmr209395385a.7.1745526541816;
        Thu, 24 Apr 2025 13:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5WXJS8NaqdeMt/+KLcu9ZSJwqsayh1efliZCQC90ik+AnNBQkVEBnW9Khoq4PWXzzmvC+AQ==
X-Received: by 2002:a05:620a:390a:b0:7c0:b106:94ba with SMTP id af79cd13be357-7c956efd7fdmr209392885a.7.1745526541344;
        Thu, 24 Apr 2025 13:29:01 -0700 (PDT)
Received: from [192.168.65.221] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7ccbsm17442766b.59.2025.04.24.13.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:29:00 -0700 (PDT)
Message-ID: <eac33841-4796-43bf-affe-31901344c5ff@oss.qualcomm.com>
Date: Thu, 24 Apr 2025 22:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/msm/a6xx: Get HBB dynamically, if available
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        dri-devel
 <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org
References: <20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com>
 <20250410-topic-smem_dramc-v2-3-dead15264714@oss.qualcomm.com>
 <20911703-ab4e-4eb2-8611-294730a06d2f@quicinc.com>
 <CACu1E7HDmQXDNtEQCXpHXsOKPCOgrWgo+_kcgizo9Mp1ntjDbA@mail.gmail.com>
 <1282bf58-e431-4a07-97e5-628437e7ce5f@quicinc.com>
 <CACu1E7GwMCt6+JJQGgSvJObTMMWYLPd69owyFo7S=sxu_EEsUw@mail.gmail.com>
 <16845de2-a40a-4e3d-b3aa-c91e7072b57f@quicinc.com>
 <CAF6AEGvyeRLHFBYmxkevgT+hosXGiH_w8Z+UjQmL+LdbNfVZ+w@mail.gmail.com>
 <acd1c8dd-286b-40b7-841d-e53e2d155a61@oss.qualcomm.com>
 <CAF6AEGts5rWvgyZy8RtAaUOsad362AG-uNjxF9vyj4szg=b5Bw@mail.gmail.com>
 <6233171a-2964-4d57-986c-d3f1725eacd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6233171a-2964-4d57-986c-d3f1725eacd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HUwAVUJLJ1awU9fOyVCMgCZomCf8hNu0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0MyBTYWx0ZWRfX0rdQy7CBr9fO wuiAy0dguLT8sMGHQgELm6S2XFnPmg4PV+h6SANE5IV8Ly8UbW7YjL40A5LRjtaPDKuZXHpGy+8 WYIB4EHHUx5kO2eG6debZ0BcGJBhdFU9BziyWC/ny+xniPi5Mq6XecH1wEA/IHUvVv48X2HSrC5
 eFrXsAT0SthPgbwpv7BWpv1gusSCuinrQlz7GISaCQaeeySrPHa9Ueds7q5SlCK6hE5grRcWWfe bysGKhZDNXqgBINrgwAvrYyjqvswFT4XcQEZfW/HWwVB1ANrH7YUhpLQuEhzLV6nDrvxM3VUpAt TyJCgSIlJOMlMEouVmb143NU6ERLnciHKLs8Kb46fQWIAptaBPCi8Bfg2D+/iaIn/A8766FFVh9
 JHazaotqUq85ta380/1YY3I77OLLInfcuLfeyrjNilxdfEuK5EoSLZSKS8wFW8eKbDN2R05G
X-Authority-Analysis: v=2.4 cv=Tu/mhCXh c=1 sm=1 tr=0 ts=680a9f0f cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=U4o27yoWPFISaBf6hsEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HUwAVUJLJ1awU9fOyVCMgCZomCf8hNu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240143

On 4/23/25 5:23 PM, Dmitry Baryshkov wrote:
> On 23/04/2025 17:55, Rob Clark wrote:
>> On Tue, Apr 22, 2025 at 4:57 PM Konrad Dybcio
>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>
>>> On 4/21/25 10:13 PM, Rob Clark wrote:
>>>> On Fri, Apr 18, 2025 at 9:00 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>>
>>>>> On 4/18/2025 6:40 AM, Connor Abbott wrote:
>>>>>> On Thu, Apr 17, 2025, 1:50 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>>>>
>>>>>>> On 4/17/2025 9:02 PM, Connor Abbott wrote:
>>>>>>>> On Thu, Apr 17, 2025 at 3:45 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>>>>>>>
>>>>>>>>> On 4/10/2025 11:13 PM, Konrad Dybcio wrote:
>>>>>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>>>
>>>>>>>>>> The Highest Bank address Bit value can change based on memory type used.
>>>>>>>>>>
>>>>>>>>>> Attempt to retrieve it dynamically, and fall back to a reasonable
>>>>>>>>>> default (the one used prior to this change) on error.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 ++++++++++++++-
>>>>>>>>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>>>> index 06465bc2d0b4b128cddfcfcaf1fe4252632b6777..a6232b382bd16319f20ae5f8f5e57f38ecc62d9f 100644
>>>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>>>> @@ -13,6 +13,7 @@
>>>>>>>>>>   #include <linux/firmware/qcom/qcom_scm.h>
>>>>>>>>>>   #include <linux/pm_domain.h>
>>>>>>>>>>   #include <linux/soc/qcom/llcc-qcom.h>
>>>>>>>>>> +#include <linux/soc/qcom/smem.h>
>>>>>>>>>>
>>>>>>>>>>   #define GPU_PAS_ID 13
>>>>>>>>>>
>>>>>>>>>> @@ -587,6 +588,8 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>>>>>>>>>>
>>>>>>>>>>   static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>>>>>>>>>>   {
>>>>>>>>>> +     int hbb;
>>>>>>>>>> +
>>>>>>>>>>        gpu->ubwc_config.rgb565_predicator = 0;
>>>>>>>>>>        gpu->ubwc_config.uavflagprd_inv = 0;
>>>>>>>>>>        gpu->ubwc_config.min_acc_len = 0;
>>>>>>>>>> @@ -635,7 +638,6 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>>>>>>>>>>            adreno_is_a690(gpu) ||
>>>>>>>>>>            adreno_is_a730(gpu) ||
>>>>>>>>>>            adreno_is_a740_family(gpu)) {
>>>>>>>>>> -             /* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>>>>>>>>>>                gpu->ubwc_config.highest_bank_bit = 16;
>>>>>>>>>>                gpu->ubwc_config.amsbc = 1;
>>>>>>>>>>                gpu->ubwc_config.rgb565_predicator = 1;
>>>>>>>>>> @@ -664,6 +666,13 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>>>>>>>>>>                gpu->ubwc_config.highest_bank_bit = 14;
>>>>>>>>>>                gpu->ubwc_config.min_acc_len = 1;
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +     /* Attempt to retrieve the data from SMEM, keep the above defaults in case of error */
>>>>>>>>>> +     hbb = qcom_smem_dram_get_hbb();
>>>>>>>>>> +     if (hbb < 0)
>>>>>>>>>> +             return;
>>>>>>>>>> +
>>>>>>>>>> +     gpu->ubwc_config.highest_bank_bit = hbb;
>>>>>>>>>
>>>>>>>>> I am worried about blindly relying on SMEM data directly for HBB for
>>>>>>>>> legacy chipsets. There is no guarantee it is accurate on every chipset
>>>>>>>>> and every version of firmware. Also, until recently, this value was
>>>>>>>>> hardcoded in Mesa which matched the value in KMD.
>>>>>>>>
>>>>>>>> To be clear about this, from the moment we introduced host image
>>>>>>>> copies in Mesa we added support for querying the HBB from the kernel,
>>>>>>>> explicitly so that we could do what this series does without Mesa ever
>>>>>>>> breaking. Mesa will never assume the HBB unless the kernel is too old
>>>>>>>> to support querying it. So don't let Mesa be the thing that stops us
>>>>>>>> here.
>>>>>>>
>>>>>>> Thanks for clarifying about Mesa. I still don't trust a data source that
>>>>>>> is unused in production.
>>>>>>
>>>>>> Fair enough, I'm not going to argue with that part. Just wanted to
>>>>>> clear up any confusion about Mesa.
>>>>>>
>>>>>> Although, IIRC kgsl did set different values for a650 depending on
>>>>>> memory type... do you know what source that used?
>>>>>
>>>>> KGSL relies on an undocumented devicetree node populated by bootloader
>>>>> to detect ddrtype and calculates the HBB value based on that.
>>>>
>>>> Would it be reasonable to use the smem value, but if we find the
>>>> undocumented dt property, WARN_ON() if it's value disagrees with smem?
>>>>
>>>> That would at least give some confidence, or justified un-confidence
>>>> about the smem values
>>>
>>> The aforementioned value is populated based on the data that this
>>> driver reads out, and only on the same range of platforms that this
>>> driver happens to cater to
>>
>> Did I understand that correctly to mean that the dt property is based
>> on the same smem value that you are using?  In that case, there should
>> be no argument against using the smem value as the source of truth.
> 
> It is, but is done by the bootloader that knows exact format of the data.

Right, so the only point of concern here is the handwavy matching-by-size
logic.

Konrad
