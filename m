Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10F302760
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123875; cv=none; b=j2H9VOGVFrQbqtWFnob9ZIbhTsZjFeW9k/3BGgDLQq+uZZb64UXPaNXQFO01kvLqradFSuMLK3zaGk01AZM7cDQrjSZI1/3U1Egd+n5+4fySt2+eao5p1Bo8I37IHUYpFZYPJxtEf3fgeFoqG6NLJZzX9XL12HetEe+ai/AwTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123875; c=relaxed/simple;
	bh=MkzcIASgD2QGbcPW+Wul+0S3bWjeYPRrF6/zdQI2jik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNpXYKOKoUb6N8Ry9M9Ov3Kxo5pQMWklggYNTV3WRky44a/Bflxw5CmQQG2jba/xHSZmXM7QZoxV8qpCwtBoNXnuXMtBX9eKD2Smme/e/OfgjFRD2o9KMPCFiiyd7PX9drBCfhR0wvGJ29ZsIhWhDdK3TWQcaoMkitJKg9LzHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9Rmk/HK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9Rmk/HK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMBZt5012236
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7gth1q5wXt2kbolj7dWwKraNNmPxnZCoAelNEomImI=; b=K9Rmk/HKt+36obya
	M7UIbbgfRjSYDDYDWA3EMZ/BOIvwNdm2eFMRYEt3okNQRPA0cpkcWri3lnn2208z
	b57DhfPUBmsM/a71CsC8D0O0AGP4VNVIBDndA7NCLVIzbv38FMJIAfi+yQht2xNc
	VSuQDiWxyoC+8D1qos/8AaQZjYj43EmBU0CdXTGnrPwt10R0byL6SP7n2tRHtW4e
	MsTJ/Yw/hRfq5eyXk2PmPRIR41v/3ydboLU2mE6ABUihzo1eKQ5uTw2fr3QnZz06
	ecyaMqZzanckeqGnfFNvxfTg4ooITRU5EAIh1v9QvRicXdAvrfMU8kKF4NuFc7QW
	G8R6UA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxbjuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:24:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e614e73so349401b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 15:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123871; x=1755728671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7gth1q5wXt2kbolj7dWwKraNNmPxnZCoAelNEomImI=;
        b=Cg1DkMHD2KG/9SnWp7jBeW4bnpTyAeS84q6lgYYDYDeFUggilKOhRW0nufMNFhDJFM
         4itkcp8blyDMxFJS/Yr/H16Li3Q5y99YhhYdTias4rYIwhTsB73gPaaznhdXQA5XILGo
         Irq77oxrdKc/KQhBLL5W995VFmislFPH0WBLwg8y4ozlcn3mBmDSjzX/a+/fWWnJJh4F
         K+7dzYGRg7MkvSIXfKsJcrHiYJuk2XLMLivM0wjYnnWQrp3eMCxamCA7lw0hdDD6oFIo
         F75WmOQ6F7bCgy/L0x7TDh/VlEzRNyAth5O42KAA5ybkG3RjmJEKBtRV34qcvv5ZZYJp
         wBjg==
X-Forwarded-Encrypted: i=1; AJvYcCXyjgtfndjAhuI8HXizKdGtWEeQUGJMAJbth8jTxJbVOQbUlULfL3kpSn2q7Ca5R9d4b+GD2lS3JHk0vHWRsPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwbwhBma+h9dJVMvuZ/nsdFUGjBfK2+BzmoCPx+lcMKERkjK+
	h65iyl0nkUCqMO3iiA0V44qqvZX4yDZZZZQLU+tS6mczzm8wmsodWJrvj0ovrbNq+0fbfPdN4a5
	wv4HUOh4XOeZ18vFWxwiCedIV3R7crfzErHG4n6nf0pRG7tfATjNgcS/3jAEYZKp4N3llEw==
X-Gm-Gg: ASbGncsresbrK8ruaKdESJF5OMsU0Fb/FYLgpBVvBeOAvuC3sFfiNQTjGcJdS8r+nv4
	TmjlejketbA2RYlwKSNADomgV9KtoAdRy+Ms5OBOM6A0of2+W0JsvHvYi6OEyfthblvCQRZ+ulS
	PY3cvyBNG+LI/BwjcQbCuuqe58djWCaa3DXiMbOZxEc2XDF9vGmdZe5rbrWJxOZ8PZ5hbWO1Vfj
	GnwFuESb5spRj7xhX6t7VHDNOQkVToYXryMHpp85t1jHiVnagffn10jJGqzrPFOHbqcjLhY6THa
	7vjaIcBHKRJNic14I6Sqojf6yKkHPhAa6S3ng4tdKaDeaQv/T2NtcrPk+/pYTwLFfutQGr1db9E
	1uLXdurjeE/qQg4qYx9j65/7CipteXMDGQEMe5g==
X-Received: by 2002:a05:6a00:3e24:b0:76b:f1c9:4ec9 with SMTP id d2e1a72fcca58-76e2fc23e59mr1085318b3a.6.1755123870900;
        Wed, 13 Aug 2025 15:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrd6YX7PSuR1I0NvscqCwDnSHruYilibycjxTioyww4LMs5uJhtMWQp7pwAdosrJAlaZ3ajA==
X-Received: by 2002:a05:6a00:3e24:b0:76b:f1c9:4ec9 with SMTP id d2e1a72fcca58-76e2fc23e59mr1085287b3a.6.1755123870379;
        Wed, 13 Aug 2025 15:24:30 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm33032684b3a.102.2025.08.13.15.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:24:29 -0700 (PDT)
Message-ID: <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 08:24:21 +1000
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
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX/jJNdfVi4wer
 ko57N8vL3R1ahpNcahBjJNCfVf3XXkvzdMFTFPoYfs2HT/g8ccBAhmKb+eYRf//xP0E/Mu4YmDr
 4pK/M7meXdg8eEeXkc898xrBUXr/ox6PgWjEc2BQPSWAY1h3IO1OlaLfKnNKzx8DpiibEWHk7SV
 v18HLa6yoEXgIEY2loxJD95U514rTSeGp1E3UoVg3yP1ARNH38znY/kxTGcuyV1NPMsZD1eA4y9
 bLS1kA6mgUEBhTf7GLXc+KiD/j3n6i4+kA8Poyu7aKUScyvDY7QzNO6pZhcoVB01bRG5nKr8Ug0
 UgCFlgIy5Tg+dkz/7VIJZ/79qXncQ37TB6eM7+0JgGdckqsjy/T209zdzhGmucVDJSkNkXKmSKF
 qsJUxqxP
X-Proofpoint-GUID: bPRR4lZcBzEcnxaa-dzHc5BqIBXyDvF0
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689d10a0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=ShNZIzb07UMatG3o2d8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bPRR4lZcBzEcnxaa-dzHc5BqIBXyDvF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>> Enable userspace to allocate shared memory with QTEE. Since
>> QTEE handles shared memory as object, a wrapper is implemented
>> to represent tee_shm as an object. The shared memory identifier,
>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +/* Mapping information format as expected by QTEE. */
>> +struct qcomtee_mapping_info {
>> +	u64 paddr;
>> +	u64 len;
>> +	u32 perms;
>> +} __packed;
> 
> Please use types with explicit endianness, e.g. __le32. I'm assuming
> TZ will always be little-endian, regardless of the host OS
> 

I'm not entirely sure how this point is relevant. As I understand it,
the core that populates this struct is the same one that accesses it in TZ.
Your argument would absolutely make sense if the host and TZ were operating
on different cores with distinct architectures -- such as one being
little-endian and the other big-endian, which is not the case.

Regards,
Amir

> Konrad

