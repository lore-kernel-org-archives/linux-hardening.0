Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D0221723
	for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150653; cv=none; b=X3ITyBN4aVo9gIYpWHpPPS8PqZMcXZvceiKFr6zWB5N+KPT+WQEKGLzbP0MbrlcheVFf/s9MnK6gq9cH675eO7NZQLmGdkluLxBDxOCryN6EwPQ2cPZn0zHCwNDtoh3oh3Ejdz+QadPFtFnkaxnkDS+oBKY9qoNu2S7n8kPnP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150653; c=relaxed/simple;
	bh=lomnEJ9yPVx44OUpUFVsAUpjLoAdKXlzeGHzBgBZ8co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUKi6gqGTosEFgoLcNfCdWUDiQzx1PYJgMKPNGJXv4egzfvDIggOrQAqcCahyyiY6qZM2SQMmL2D2zkDULnts9vO6ZBY8bMg2t17Y3cloerVmWEe6TbkCA9rmDYLhA6EOu/5zKJZwg5eglhRx3HO1ECKTIYKS84vNkfDvlxg+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvVOo5Xg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvVOo5Xg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMPZD8011072
	for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 05:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZOJ5RR3PqgCQNdZV6tHlQpMWfAVJArmZDw7MU6+DL7M=; b=XvVOo5XgoxdS+3Sf
	Bq2yXWJ0hiwSTa0MEuZoW4IjIJC86W8OrGPMHs40+cf+tOMSGGaYuKi7i2oPVGqe
	gSWw1VbakLMUewkEiRv1vIbQjopB4W4bdMf67x+MclV95o1iXuDkfsK1sau/aKQv
	VhIikW19P9Bevhi8z17Bu4IrPqlmDJJp4k9OK73+oqjS7XZt9u5HR6yfL8wFwz77
	0gV49EtbSLRjR1YvMPZeSDnV9uKscVy7QYe2Iot+qf+vee8/8A7pjLGkH4JCW5K/
	HorgUiylHUufqpREbDbZCaH+kbcZdkZg5+arxe1Kgc/kbYdf+Mo/szhMVvUp85zv
	DNaEqg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbhkht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 05:50:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso5515705ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150651; x=1755755451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOJ5RR3PqgCQNdZV6tHlQpMWfAVJArmZDw7MU6+DL7M=;
        b=MnaaUW+QtkDOs8CywO6UaW4RpHfVkUcZqrCe7Va1FTHqJ+F2kATkY2oYV2bq+ONLDl
         x5ti6+nyUjjhyotPmMNBonCcpbuEpCCuH83tgFZDIalTbKbKlHXWI05EPGvPSSdCSFmm
         d/8HigdGfGn2lFzMlF3wYhYN6akKYsG5dS8AYmwHm5vpwd6DK/GfHBpuOFJufBhSM8bu
         43aORjFcVtFkDKji8lciQFX0j1gV3Qex7XIJr4Kf1Opa6Yl4GbDUNoPLIaBgMKXuoz8o
         X47G/El27sbbVlI2R4eXFp8DcTGg+16dpN80StCNwrL7J8Ed8dYx/c/9m+vVl0k3tZcp
         1fCg==
X-Forwarded-Encrypted: i=1; AJvYcCWcxvD7tX/6ph6mkAw6LyAKw03cqA5ddlFSHMt8iobAAMwyAewkQ1Hu8ILx7c3ANraCULVEayBS419VWw+EtK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAfSX+AEVRpKDmMVJDaNxZ5LUjI869d9/KVPND1LVIBtddtul
	IKi6HmAamr0IQnVfcnBV8wWSuG1Z0zPVQgiXT6tPHHT2vS68Nvs3Dy1KuMM1hD9+wZMnv0Ymc9A
	yQ2KVYdflotZ3Cc+q1+X+QucTMMdvsJaFDFkS4db7ALdu6S3I1+akjTcP2T6AX+XvcpAklA==
X-Gm-Gg: ASbGnctHtXuO9v1kar9cisGCP6jafr1klYI+wAVF31EXsrHxyAPR3ZAj+5t2tjFcZr4
	OqoFAsowdH3n7HeVTw7pzKAABXhiU/gV0cIV3p7iWFQlkvs9vd3tjFO50Wp3pc5tBPDk2pN+I+i
	sIWLt/UsU2yySWibAWXjEBrE0OusJ7kmCKQAYkMMDI0Fx0rH3BtAXoxAz7upQsKNWtS3InZXjhG
	0+GFzDKNQnTSaMooYbZKgtibjARozNVa7BGlpdXOduD8MOiWwNk/8HNzHgxXAPViDXnM9HpOOUB
	KastPWZHTy9l8PEBSFCo0UxwPxlr+TRfHfDSqOK4t8u/wrxAVrIC8KKnEJetJJtwUqewRxdvwtB
	WW5r+3bYmnlS1aS01IlvnP+E9ANrfiNu2YkmACw==
X-Received: by 2002:a17:902:e784:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-244586efd7amr26911695ad.54.1755150650521;
        Wed, 13 Aug 2025 22:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+3/0CB4U2pDNP5uuELEloHSNUMx8oZuD+AyTPJ8LiDQNxpnVIDTDJbE8IvvpsAU7Y3B2/w==
X-Received: by 2002:a17:902:e784:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-244586efd7amr26911215ad.54.1755150650056;
        Wed, 13 Aug 2025 22:50:50 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2430558a0b7sm52896745ad.85.2025.08.13.22.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 22:50:49 -0700 (PDT)
Message-ID: <22d6cbc1-90ad-44b0-80fa-c3c67abdae8d@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 15:50:41 +1000
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
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689d793b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=oZdMm6XVNGq0ThNLGeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX1WYgWAOsQ5hq
 aqe25SjzrX82y9Q+nNg7Go186UT8CHSQy7ocBZA352Cryc/E5zCA3tklAR0vD10NhxwwN9+0rQo
 dyXbdktMstUdeCf9U7VHXY7XS0U/mlidedc0YZpAReAJO+iSCE8sp9uvNbQ5FjSind3VaMP2gGb
 +PDRGGz8LFZaPicxld4pbfhZaifBi5hBV2lzFI4WBwDbZ1+scqbweXJqgIybRCMAoEhJ7HOEFyJ
 sSgU2GrkJSdlh8rQ4EUpv031jTGcEU+4yhtJT4gjA05CAjT/mR9EgpOclqHX6r3B4+9/x3ec+YP
 pullTqN5mqt4Do2DpZ0iw6v/FQuj6YO5PQ7LdtZvCHipMSjq/cBNrnQsINfm+Sk4oppzO0qdQqj
 JejN0MV4
X-Proofpoint-ORIG-GUID: D2UlM0ev8h2-jRxKYk0gnOnEcGOoOe1W
X-Proofpoint-GUID: D2UlM0ev8h2-jRxKYk0gnOnEcGOoOe1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097



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
> 

Okay, I’ve thought about this point and also discussed it internally.
I can add an entry to Kconfig to ensure the driver is unavailable when
CONFIG_CPU_BIG_ENDIAN is selected -- for now. However, without a clear
usecase, adding all the le32_to_cpu/cpu_to_le32 conversions just makes
the driver messy.

Regards,
Amir

> Konrad

