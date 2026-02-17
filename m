Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A473559F5
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333195; cv=none; b=Bd/aLTAljFfvaH9T6dy3x+FJ+QIbBJR8pKw/W0VHAOYEHKV8L9rR2UpRW+hE9h9WMp9Oic3zQS97Kr+nEn73uaOG4r/E/6zK+L0EJaw/WEOwpdzvECDM9VSmOfGatfGwuW5YfTu9bxVnyn+uG/6BhYXiVw6+eY15LFbjWRLWR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333195; c=relaxed/simple;
	bh=mAuTC5AJsCNtBLP24UouHl7/vDNnOp6omGtW720jvec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvGyt0cFFwU+8kdXHhKnhhve5YZcv5YBtAX5Lp3V9Q3wsPI9GoqXiWdul/rVFjNCAsThyZic6NTuR1g9mJxJ1WN698dNCGkRRPmtkUblLW2h3gyPgtMJfd9ciK/L5mLwhBvuiBtSYQaL7EP6sdinMRUxzUGDVTAl3zazUuysH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LrzkrI4q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XkiKEGv6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LrzkrI4q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XkiKEGv6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8vAIe287925
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 12:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0wA2FAQrRIGzPhPiBC+jIJgFGTOYwSshXjcsEayItQ=; b=LrzkrI4qeTtEcSHQ
	xzsFERCf21mSUWkLSZdYkdcP5UMuBa314R5LBNEBiKGVayLnNOvhn/BJsqpsfD3n
	bmSpOOx/C7ZH58ZRKtA/BdAnLPbOxw3UHPztCW/GCfSGmAVkVq7w2Q4jMlj3y27l
	wKSr81teZ6Tn7T/xtJb13uKmv0d5ipWkKBEUoqJe7WwEHr0EWH4a9BjGwG4c0AE2
	kE/isX9H3Pge0CMe7C3321zr4v7ceOPZ5Wj1cqpzH95yU4/O6FrnNKGaBo8AajHs
	PelJLnDrTqx1Yt1BDmLHqD5YzunFill2Ra6nvdrjqr2gr8FvLiYnEofGVwi1BifZ
	2sOECA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6nrtcpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 12:59:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4025302aso335163985a.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 04:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333192; x=1771937992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0wA2FAQrRIGzPhPiBC+jIJgFGTOYwSshXjcsEayItQ=;
        b=XkiKEGv6v8kzpDUPIbIS6JUxRilxoLxu/uQ/IpeQjaZKWq8vE3XnMWINBu9DevyiFH
         FSFmYzAKK/rFx6bX17agG9g7c0yC5tQARtIph6iHoBMuVfOaJ2WYQeDmX6eZ5kbUeZ4V
         KYOG/hFVZ1YPd/fQOFLI9eB34Vb0Gq2gSXDCss9GyYV5twU/KHg4Km7JE6IATAq+cT9/
         Q1A3/+Lis48gj93ZtiJi9glukutadmqKLUGfSCo5PKuNQxwVnwVKD2StKonHv9xShZHV
         E81TAhT0ZsauyDLk5yqKgSk9hO6m3GJ5RyY1fVJY1OCSiBtkQfXHGPKqQofEbMvctUEd
         16IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333192; x=1771937992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0wA2FAQrRIGzPhPiBC+jIJgFGTOYwSshXjcsEayItQ=;
        b=eifP0w13sJBrdVG9qpmVh2NbtH5duTQJ4n6GtAoQaomK2FwnKlm3MEWmLh2wNmg1XZ
         NGQQhzE7gWhxf2DlZRtmMt2C5Jojkqd2M/17iefsdQrkGvzh5WNTTc16MSCUcpscvhcP
         zoGas3WgPtb33SWe0B//zxXftydy9ketOcpdB5lPvbTVAp+wfoFDW/2Hw+tXuBogF8gB
         WH9QSy40Xm9yzGIf9bSJrPmmuoe0L1h+a5oW7mtoIHPLKSUpK3tPUQIwevCF2W/8bgf+
         8z9P9Ami5sQbuqliakh9FBp2kjHoltncconPJ49K5L433Z3bjVCWFHUi+WaWr/Eq49++
         D3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXHKaEMHga/Ob2JD95r9ZQvuIJgkOCQm071OVX7QcRT0e0EZBVAVl4GoFiCS0ArpLhchjGuIH68F/J+tyUOVUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrD6v7QD5aLAdFiQ/3xBtA+T488hVHs8PWOKJbYQQYSbdfpTSw
	OZ7ouWynifWuMlHT4TCD1yTkYUnMhaGPgl2cAk6HiqsNZZEvK5OGODiZ4NQEUJLpqecXlKaeLU9
	yhxnDvmZvtb8xhRZWAUPJ7a5D8uCk958Q22AraClt0MQrtTW6XfAzmgNHhWPK2odk8nnOyMs=
X-Gm-Gg: AZuq6aJk1KP6WIGfO2leDdl9R5PXnxJH6Z24pgqGOR9PMmIJEI/1p5Vz5iHlDR5bp9G
	UaWNNgnND28FCnXAgEZb5On3UXFyI1EF0P6HbOs7WL4TKv65YdSIODueNFeHVEGMDj+qa84+ER4
	RfnDzFHvZCOy2jfWHkmlXR6rVGcoZfnY8xvj1ytwB++JmGN59Q8tnfNmjftXo0FHaG1OJHQFFQ5
	ZfYQsLNIrlw3mETzcHu6Sene/BcEva68md28QRcC/tsdnq8nNSwbwb6MhTffwLvo8/Ik8bZt2kV
	5mz13lbCBh+52I60fmLPxH3MekfA/C9u0ZzxU15qlY6yDj1USOPvE+eLORHireGjLR77pZ/lWIs
	OrMBWi+vEDBbhJNR/y7cHssDIEYO4zcZSoiWTJxU5cswydMO3wduWQlGwqLEBi7cTUf5RGLqhoD
	uBhzs=
X-Received: by 2002:a05:620a:1714:b0:8c7:110c:762f with SMTP id af79cd13be357-8cb40850a6cmr1368757585a.4.1771333192542;
        Tue, 17 Feb 2026 04:59:52 -0800 (PST)
X-Received: by 2002:a05:620a:1714:b0:8c7:110c:762f with SMTP id af79cd13be357-8cb40850a6cmr1368753885a.4.1771333192029;
        Tue, 17 Feb 2026 04:59:52 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385e60sm346966866b.19.2026.02.17.04.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:59:51 -0800 (PST)
Message-ID: <203f6f63-e81d-4db5-8ede-ff6695a847ed@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:59:48 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soc: qcom: ubwc: Get HBB from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
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
 <befc5600-5cfd-4134-928c-80e3b1b4102a@oss.qualcomm.com>
 <iqg6jpq4i3olwugnlnsczisbrbysxzik6otby3pgkv5uqsez3f@diwpjgf26mk3>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <iqg6jpq4i3olwugnlnsczisbrbysxzik6otby3pgkv5uqsez3f@diwpjgf26mk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XKo9iAhE c=1 sm=1 tr=0 ts=69946649 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=R9SVTSvzoFrXFbf9F0wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX4Q+teLLKWDTZ
 W0zBdIxsqOa+3F8nwdwPw1ibs2ND1cZjWqplgyzIqPCXjzekQK8GqjqrI4MmFG+3F45CKA5/2od
 jI0F3hEjorhhsa7J/Q6HdNxNEt011tIQKORNvTxBXoarc68FYwfVrm/g5ZAONYjeAUOQSOetrLD
 EDOHX1qKPYg+IwLe00rWoZgQjaouzToByD0ar45Fwm7V2IEWEY2L4jq97Wnzi2m0YbocBzFwQj8
 B+iIHjKWdEDlYb9q+z6W+bbZC3YYTJ6Z7nxmYYQOMiDRu0G55YXoTGLalOTM/cekSvP89LeUQV4
 nkmaw/eTvqYr5YdHOMyAfdazML0kp+4j0QRdgCsjE1ORDwQz5DbNu+2wo8nY8HT4yTgFZlHIy6/
 nsKXZHo7XfpTEIGTyu4lVKfC5mjeoKGNt+xVm/St0pnxDxdXydAJuAkYKjsg/WBbfh4BKj/35g5
 Jbw0FNv7ueCtPwllCyg==
X-Proofpoint-ORIG-GUID: q_QSev7FnChOi9lyrNCbRLxKgd4EaW9j
X-Proofpoint-GUID: q_QSev7FnChOi9lyrNCbRLxKgd4EaW9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170106

On 1/13/26 5:29 PM, Dmitry Baryshkov wrote:
> On Tue, Jan 13, 2026 at 04:31:15PM +0100, Konrad Dybcio wrote:
>> On 1/10/26 11:45 AM, Dmitry Baryshkov wrote:
>>> On Fri, Jan 09, 2026 at 11:50:46AM -0600, Bjorn Andersson wrote:
>>>> On Fri, Jan 09, 2026 at 05:21:10AM +0200, Dmitry Baryshkov wrote:
>>>>> On Thu, Jan 08, 2026 at 11:49:54AM -0600, Bjorn Andersson wrote:
>>>>>> On Thu, Jan 08, 2026 at 04:45:49PM +0200, Dmitry Baryshkov wrote:
>>>>>>> On Thu, Jan 08, 2026 at 03:21:51PM +0100, Konrad Dybcio wrote:
>>>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> To make sure the correct settings for a given DRAM configuration get
>>>>>>>> applied, attempt to retrieve that data from SMEM (which happens to be
>>>>>>>> what the BSP kernel does, albeit with through convoluted means of the
>>>>>>>> bootloader altering the DT with this data).
>>>>>>>>
>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> ---
>>>>>>>> I'm not sure about this approach - perhaps a global variable storing
>>>>>>>> the selected config, which would then be non-const would be better?
>>>>>>>
>>>>>>> I'd prefer if const data was const, split HBB to a separate API.
>>>>>>>
>>>>>>
>>>>>> I agree, but I'd prefer to avoid a separate API for it.
>>>>>>
>>>>>> Instead I'd like to either return the struct by value (after updating
>>>>>> the hbb), but we then loose the ability to return errors, or by changing
>>>>>> the signature to:
>>>>>>
>>>>>> int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
>>>>>>
>>>>>> This costs us an additional 16 bytes in each client (as the pointer is
>>>>>> replaced with the data), but I think it's a cleaner API.
>>>>>
>>>>> What about:
>>>>>
>>>>> const struct qcom_ubwc_cfg_data qcom_ubwc_config_get_data(u32 *hbb)
>>>>>
>>>>> I really want to keep the data as const and, as important, use it as a
>>>>> const pointer.
>>>>>
>>>>
>>>> I guess the question is what are you actually trying to achive; my goal
>>>> was to keep the base data constant, but I'm guessing that you also want
>>>> to retain the "const" classifier in the client's context struct (e.g.
>>>> the "mdss" member in struct dpu_kms)
>>>>
>>>> If we're returning the data by value, there's no way for you to mark
>>>> it as "const" in the calling code's context object (as by definition you
>>>> shouldn't be able to change the value after initializing the object).
>>>
>>> And I, of course, misssed one star:
>>>
>>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(u32 *hbb)
>>>
>>> This leaks the knowledge that HBB is slightly different kind of property
>>> than the rest of UBWC data.
>>>
>>>>
>>>> You also can't return the data by value and then track it by reference -
>>>> as that value lives on the stack. This has the benefit of making the
>>>> lifecycle of that object clear (it lives in each client) - but perhaps
>>>> not a goal of ours... 
>>>>
>>>> How come the ubwc config is const but the hbb isn't?
>>>>
>>>>
>>>> If we want both the per-target data to remain const and data in the
>>>> client's context to be carrying the const qualifier, the one solution I
>>>> can see is:
>>>>
>>>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
>>>> {
>>>>         const struct qcom_ubwc_cfg_data *data;
>>>>         static struct qcom_ubwc_cfg_data cfg;
>>>>         int hbb;
>>>>
>>>>         ...
>>>>
>>>>         data = of_machine_get_match_data(qcom_ubwc_configs);
>>>>         ...
>>>>
>>>>         hbb = qcom_smem_dram_get_hbb();
>>>> 	...
>>>>
>>>>         cfg = *data;
>>>>         cfg.highest_bank_bit = hbb;
>>>>
>>>>         return &cfg;
>>>> }
>>>>
>>>> But we'd need to deal with the race in cfg assignment...
>>>
>>> static struct qcom_ubwc_cfg_data *cfg;
>>> static DEFINE_MUTEX(cfg_mutex);
>>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
>>> {
>>>         const struct qcom_ubwc_cfg_data *data;
>>>         int hbb;
>>>
>>> 	guard(mutex)(&cfg_mutex);
>>>
>>> 	if (cfg)
>>> 		return cfg;
>>>
>>>         data = of_machine_get_match_data(qcom_ubwc_configs);
>>> 	if (!data)
>>> 		return ERR_PTR(-ENOMEM);
>>>
>>>         hbb = qcom_smem_dram_get_hbb();
>>> 	if (hbb = -ENODATA)
>>> 		hbb = 15; /* I think it was default */
>>> 	else if (hbb < 0)
>>> 		return ERR_PTR(hbb);
>>>
>>>         cfg = kmemdup(data, sizeof(*data), GFP_KERNEL);
>>> 	if (!cfg)
>>> 		return ERR_PTR(-ENOMEM);
>>>
>>>         cfg->highest_bank_bit = hbb;
>>>
>>> 	return cfg;
>>> }
>>>
>>> This potentially leaks sizeof(*data) memory if the module gets removed.
>>> Granted that all users also use qcom_ubwc_config_get_data() symbol, it
>>> should be safe to kfree(cfg) on module removal.
>>
>> I really don't understand why you'd want a separate API for hbb, if
>> hbb is already available from the larger struct *and* if a driver needs
>> to know about the value of hbb, it really needs to know about all the
>> other values as well
> 
> Please take another look, qcom_ubwc_config_get_data() is the only public
> API, qcom_smem_dram_get_hbb() is an internal API.
> 
> My goal is to keep having UBWC db which keeps const data and which which
> also returns a const pointer.

Right

So if I understand correctly, this is almost exactly what I originally had
in mind in the under-"---" message (modulo having a static global ptr vs full
struct instance) but I failed to express that I wanted to keep returning a
const pointer to the consumers

So in the end it's

A) int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)

vs 

B) const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)

I think the latter is better since we won't have to store a separate copy
of the config in each consumer driver (which the SSOT rework was largely
sparked by), essentially removing the ability for any of these drivers to
mess with the config internally and make it out-of-sync with others again

Konrad

