Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52972147E7
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365790; cv=none; b=uXj93PZg8wuncPu59QShA9HtLkWNhfFoTNrVK6pEAVaAKCeIQxEKPxxjlPohY0uLW8UnZY55iG7L8eHhhH0NMyQ6j9C0jdSf2VkdgI+IgVxlygetTa5hAfYzmWv9jcU3t3rzxXHmqYwgoXMLj/exeHsyTcYX4Id7sGdWJGa2ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365790; c=relaxed/simple;
	bh=ImN70cz4djh42SVt8sWQnPR6aFylty88MzicTBCSTIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWYRUoTB/QfReufzlyQvrTXy12GlcJSCObl0SKf3SpWEuymYtjbRAl4V8xSe4UNdoxSooW5bfuIFtyjPVKdEE74EOacRehpRqiHCL+EdqULbJWNukRuDMZriGUIv2loc+s+UxEA3gud/nk6unn2j3sAoJ33c2+cr52E7eJvm+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFjd0heH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFjd0heH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5sa2v028838
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 10:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TChXZ6jQnWmn2gjeO8rx1Bx0hrnCDqPo46JM3visYYs=; b=FFjd0heHTi5a3EYd
	unZ891elrIymmhwRuD77Z8YwUdTRanoczY0QVd38q9z1pVI/YDa4uNdGPODFedym
	HU82fi8CsN/eAfFVmJP5+UED2p42tmmp7SO0BkHwwerMo1oMT7MPeHf1RHqtCtJV
	Ypmo9iQbnnh5rrhcmL9mAlsgpSTDCcc/m8Kr3/leJ7q3GAcWcTJgQp/owAXa6CcP
	mSH4kwBIIr6e4X/Mv8fQzaG9mGWcAMfor3A/SgYa1YlSw1hp6qtgtLgPYuyvvkwW
	hZg9H/AsZVo9Jf0DFbqDa0RKnWdx7aX6sGIoZDowrxHLh6MlhpzCkv2bjEUlfmj4
	eClHEg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbut1en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 10:03:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c552802e9fso44735585a.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 03:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744365786; x=1744970586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TChXZ6jQnWmn2gjeO8rx1Bx0hrnCDqPo46JM3visYYs=;
        b=gkKdrYcKQtMIV6fITmlAu9e4uXizHl+VrVOt5pNVReG95Vh09zroTRedyoV9qd29fI
         rsiTlwD7lkqNVbiMLBVKFU5WOyQxNxrHQesbGm2dKnkPIeOL7IFdA+Pp8jYWlyz+pwiv
         9uke3MuLWZhq5Z6AoPa7NE3qqOgaCvBHAHvSJ5dwXEwK2H2eGBuEjXkFjvcfkUVM1Cxb
         EGHY5FpK/fma5BQKhcamHvQ2qH6u9FOMqXOeKQalz2TxOnQFMMCwrV0G7Cpsk9peWi//
         koomWlkvM+GNRiCUbpejmKLGqD1Jl1o97xBNI80fsnIimwQe4TA2m0oSqsdRfTqNtEdq
         BfJA==
X-Forwarded-Encrypted: i=1; AJvYcCVj89YdrvZWv95Wk21Hzf4TRUT2JiTOV43JchiIfwUeRW3OeTPmYZUTxuP2W3IX4gmqNoeJzk0Klkj0TKU2SjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxQDzXZn0CfsHAC6USfAbAN8D5Ds2eyW2qf5WLy7LUbE3nHqV
	D/GdzCWVgLLRhi5/z41aB60X6IP0fTxN11PFjeFJrXwNTkYZNUEd8jzGInJzrTCxZLCyhq8Pz6X
	2H+dTOvdU8SKk0JailcAbnEKnsKv7glbNh7xk8ZVUpiPq9wAeOjjssv3NjysPiHYzXX3akcMKgr
	E=
X-Gm-Gg: ASbGncvAoBPFKhz1MseSJrrvFFcGlgxqQo6Ip6xaMfnSOL/MpXXnhyPTX0QzeFPhOHO
	v3lOZUc55iSXzuOnzy3O9N1ZKq4VBgJAGZ/rgEHRjNzke4EMAltfj3x29MajhCcnTWdkXNMKtZ9
	+dqZQOEeF72u2Lk80cn1VEGEsGmOI2zbvplp7x4MNhDCVzqKwK+AjhxJvy3O7Y4lQuTIVmRDGf9
	biyiD0tHLu3jIq0AD1Hu9MAlQd/uDgQxUwTplc3uGCmVASypu3T3aFCg6Iagy1lQqC0w2a8nyTt
	lS0pzARZftk4RGh6998MnYI3iA+st4j6KjHAjoet0iJAuGXDl6BZGET0kcvIntS6Qg==
X-Received: by 2002:a05:620a:3945:b0:7c0:c024:d5 with SMTP id af79cd13be357-7c7af116677mr129313685a.8.1744365786424;
        Fri, 11 Apr 2025 03:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAMFmbhBPTTCvhJj0P5xFnbrJJ/hfR7pw3RAhhVJwTUi6Q679ffPasjTr0Us/aTCC0PySNjg==
X-Received: by 2002:a05:620a:3945:b0:7c0:c024:d5 with SMTP id af79cd13be357-7c7af116677mr129312285a.8.1744365785908;
        Fri, 11 Apr 2025 03:03:05 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd1ebsm424629266b.140.2025.04.11.03.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 03:03:05 -0700 (PDT)
Message-ID: <b04464b6-2ad9-4866-88e9-437e96645726@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 12:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
 <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
 <e7bd2840-dd93-40dd-a1bc-4cd606a34b44@oss.qualcomm.com>
 <CAO9ioeUeNeSxz7ADZ-BbJbhEKkszVS+SmbqaZCgTpL=csak=hg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAO9ioeUeNeSxz7ADZ-BbJbhEKkszVS+SmbqaZCgTpL=csak=hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KLeTKlMGgqDawnwMP1kjh19qlO9Y0bxG
X-Proofpoint-ORIG-GUID: KLeTKlMGgqDawnwMP1kjh19qlO9Y0bxG
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f8e8db cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=uBBskLQT7c7fgIZri1kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=907 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110062

On 4/11/25 11:57 AM, Dmitry Baryshkov wrote:
> On Fri, 11 Apr 2025 at 12:49, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/9/25 5:49 PM, Konrad Dybcio wrote:
>>> On 4/9/25 5:44 PM, Dmitry Baryshkov wrote:
>>>> On 09/04/2025 17:47, Konrad Dybcio wrote:
>>>>> SMEM allows the OS to retrieve information about the DDR memory.
>>>>> Among that information, is a semi-magic value called 'HBB', or Highest
>>>>> Bank address Bit, which multimedia drivers (for hardware like Adreno
>>>>> and MDSS) must retrieve in order to program the IP blocks correctly.
>>>>>
>>>>> This series introduces an API to retrieve that value, uses it in the
>>>>> aforementioned programming sequences and exposes available DDR
>>>>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
>>>>> information can be exposed in the future, as needed.
>>>>
>>>> I know that for some platforms HBB differs between GPU and DPU (as it's being programmed currently). Is there a way to check, which values are we going to program:
>>>>
>>>> - SM6115, SM6350, SM6375 (13 vs 14)
>>
>> SM6350 has INFO_V3
>> SM6375 has INFO_V3_WITH_14_FREQS
> 
> I'm not completely sure what you mean here. I pointed out that these
> platforms disagreed upon the HBB value between the DPU/msm_mdss.c and
> a6xx_gpu.c.
> In some cases (a610/SM6115 and a619/SM6350) that was intentional to
> fix screen corruption issues. I don't remember if it was the case for
> QCM2290 or not.

As I said below, I couldn't get a good answer yet, as the magic value
is not provided explicitly and I'll hopefully be able to derive it from
the available data

Konrad

> 
>>
>>>> - SC8180X (15 vs 16)
>>
>> So I overlooked the fact that DDR info v3 (e.g. on 8180) doesn't provide
>> the HBB value.. Need to add some more sanity checks there.
>>
>> Maybe I can think up some fallback logic based on the DDR type reported.
>>
>>>> - QCM2290 (14 vs 15)
>>
>> I don't have one on hand, could you please give it a go on your RB1?
>> I would assume both it and SM6115 also provide v3 though..
>>
>> Konrad
> 
> 
> 
