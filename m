Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAC2FB99E
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127438; cv=none; b=j50IKHYIl0WP8QORCzl9tMUVY1N595hHbtKRTplg5sABB2QN2MH1l+H84tcaOefn6GdSfCnjE0CwjEK87+6kfo7Aa2+RZBwbAeHfST3bV/YCGBfQD/I7f8XEtf4kEPNvBCPFO+lAnsqdidbPskrQK1HoyfSNGF6H5yB/egYnpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127438; c=relaxed/simple;
	bh=D66gSkXwljvzFre/FOcNCT6buXirBv7V//dYm97gyAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVTQgzS8anQKquM2yecyUvTxAm0F6Ha5O9Q8FcjWc4+AqUWSSm/0eKsR1SHMJrcn6JrFO5e0q8DK28hZRwA0N6ZHbAMI+IKz75zLOfalg+f00IBlvkTmYmBSSk1xf+8T9xEao7CrRZQDSGP4uoBUlD34qulEn7vCx/X7ulDEaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOlzgTDK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOlzgTDK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLVFiR020584
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 23:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iA6096032O8eraf5ErblJhkD3Z0jA/+vFYM4Vm1Ntuw=; b=TOlzgTDKGLoL6c3W
	60rRpgi2e6BWCynvvUsTJimxfrH1Jx8J+fCpYryKmW7KR/hvmWWF2Jfo4T2p6uCN
	noWNhlxOve1trqDf6IhHj/SMuv0NQfd/FHIVd8oi+iG7+QYRck3i+NtVgSXpU977
	MD2t/VBfUroL47SCDqUCaAGSnHVsr4viZcuBVwSig7q1InVKvA/MDVALiwsF0ME4
	JICcAwhzADnlR0Vr0LDHRdy6A9LPxvYsnxI2o9CO4yneATGRz5mwmSljp6/IeV3f
	q8IFZw4KKqV8sRseqjUy2KqIZEHjqEIXbf7mOOIirlaYQ7B6bEVevDhviQwWLwdh
	9inxbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmdg98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 23:23:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806dc88so5990915ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 16:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127435; x=1755732235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iA6096032O8eraf5ErblJhkD3Z0jA/+vFYM4Vm1Ntuw=;
        b=ucPXktQr8Fa8L8Y/H2eelszz6vXtK18Eo8qxBCOEegXx5E2S4Y4orqnXQmkDGoW/qe
         RQnpzQgAfmLZwfEKoameZO6MiXibGzdwJH6tUUZBKpcdp40pILFQOTophlxBXbjn5uM2
         nX+MD2LaFDuHIpUGqUQ8Q3DBnbx+9SUs9cMDAlYAVRlEsAYWmkL0h2Uy/YS1naFR5w9L
         IkZDYXe6UTXXYUZVkD8gQqeiONp9JR5WW6vkBONkB5jWhGCVEvCZJEGMXrXXHVbwrQGj
         gPp2SEFX/FG2wadHYqrVkUiMme7hGj6x1/67R9HWF0JmpInBWOZS/0VrBTwhbVZvSRDA
         AOZA==
X-Forwarded-Encrypted: i=1; AJvYcCXTq4YRQCJOg3R+l0eIICcDcmh21AD7jmtIY+Fryg0T0OtyF+2h7dGrN8sF1dTO0k2dYBAmhdCg/BgMIPifLSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7RAl8CqRV++oqhrqYGisesh5Puyje9+mh2d8+7xOWOz/5Dl5
	DOmgDLuQC460rhGuHVpBJ6Z08DE70RzUZG+XbIsUQVOlh/UckvCP0CS8rrx0SPDsPUQIW3vCFiw
	qoyZTjgwhMgr1yYHV4SX6uHw0wVh29E7k6ipwt7tdNPOsUZmKxyIrteaViLqElJYX3SOTLw==
X-Gm-Gg: ASbGnctOSCgJpp6P0Y+S0K7rO/6582AodvLlibGr14/uDWqiOv5fR8xeVlIu5Lz2X2I
	A0s1Hb9vlderwAVNFjXlUgLJMkqpdeoQCYH9pqZaOdg5oxUDQfUw63BzitdWOk4DMkPjxhp2f7R
	10vuLHpg+1wsagMLxq+CVp/xxC5JR+8bQTAjc9zEqZ+9CpPIn2LCy3pML3yj6wfIXM8ghTs1QVa
	xDbYYFCxFQhVgzbtyYd3S3jTuL49BtBPI9M3o/eKwlczaMwUDfOw1ipSn5aQ8UZamctSvgvtbRD
	x7JB8qfcV8GLyzsMxpdHkcUSjahB/NF2yzv1dWTZx9NN6wvHmQMT5IuTqnKM8lrh6ejbjakY+Zg
	B484qUdLoZDlfqENV6zJptSSqXY5GtVGCJuVVhw==
X-Received: by 2002:a17:903:1c8:b0:23e:22dc:665c with SMTP id d9443c01a7336-244586c46fbmr13119885ad.33.1755127434797;
        Wed, 13 Aug 2025 16:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHDCnRh0Js6W0SOu+on6VKjPDQGJcgj0Cg2MJ13k4MfvzHuV5x1VI5U3usKguIYljIv3YAFA==
X-Received: by 2002:a17:903:1c8:b0:23e:22dc:665c with SMTP id d9443c01a7336-244586c46fbmr13119515ad.33.1755127434369;
        Wed, 13 Aug 2025 16:23:54 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f33asm28118326a12.5.2025.08.13.16.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:23:53 -0700 (PDT)
Message-ID: <0cc814ae-ea8a-44cd-b502-1f89876e61b9@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 09:23:45 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
 <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
 <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX5muo7g3CcTSu
 2q58IoZQ19mMO6y71E9XMl7WRXxHAVdii3ocU9Fyfu14a9cN0/nzrMHoMhkx5stxobLSSnrL4tf
 9FzHcupKuF2sQWYzLsrS+BIpPRaOuIiHz1X29cCpTCH4ZRTxCXpB5iOnDTCO9kcqXxLkWvL1fnH
 DfGtOSfJCKLQQDSsCS375xqJRuao72oWSRVPcoHhd54+k7G/r7h8qfPihEMb//Uh2+YZP5P9t5h
 sGl6mQ4gBRjIwMWSlwU0F3FU60t2re/YO1LqToQ/AixdKqZy41ZHMDGchCw8T+qXNIdrYzxc9fK
 4VEPjlozy86wpL5VtEpO2w7TAWu05thC7V2tX93NvOw6QPReBEQFdAcALedpR2lcMw3ifYAjAUe
 VEFoDTcP
X-Proofpoint-GUID: UILkT0Op4-bJI_pa-UomDtGP2rGVYzRk
X-Proofpoint-ORIG-GUID: UILkT0Op4-bJI_pa-UomDtGP2rGVYzRk
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689d1e8c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pGb8jkpG1LKJgODn460A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119



On 8/14/2025 9:20 AM, Konrad Dybcio wrote:
> On 8/14/25 1:19 AM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
>>> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>>>
>>>>
>>>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>>>> to represent tee_shm as an object. The shared memory identifier,
>>>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>>>
>>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>> +/* Mapping information format as expected by QTEE. */
>>>>>> +struct qcomtee_mapping_info {
>>>>>> +	u64 paddr;
>>>>>> +	u64 len;
>>>>>> +	u32 perms;
>>>>>> +} __packed;
>>>>>
>>>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>>>> TZ will always be little-endian, regardless of the host OS
>>>>>
>>>>
>>>> I'm not entirely sure how this point is relevant. As I understand it,
>>>> the core that populates this struct is the same one that accesses it in TZ.
>>>> Your argument would absolutely make sense if the host and TZ were operating
>>>> on different cores with distinct architectures -- such as one being
>>>> little-endian and the other big-endian, which is not the case.
>>>
>>> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
>>>
>>
>> Or, you are saying we may have a configuration where host is big-endian
>> but TZ is little-endian?
> 
> I was indeed about to say that.. I believe our tz is always little-endian
> but you can run the HLOS of either endianness

Ok, I'll update them.

> 
> Konrad

