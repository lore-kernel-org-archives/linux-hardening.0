Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C772FB97C
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127236; cv=none; b=RX4JnoL3MfLJvVVmCDUr/pYBny+5IXmyN1cQ+El5mgMjsOoDu+3PJeTcfM2XciFrpAcvyb8Bl/H3gd/T+Qs/0UQa+KWs9WRLdr8VEcYO5rsqB7gMGgyxHKo7ZBUMuuIi5NYj7KeEZvsH+c5qq9AfIs4tLpZiZH7TV09eZ5ahZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127236; c=relaxed/simple;
	bh=K41reef5ANbMRiF4uxfGDDzVnXCjuA+uPaSg4T4I0S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHvoX7jdDcpyghbDik8oM8yTIQG/75PW0wtNsZCnXN4YheT7Tn8fOdMTrV9syhf5Iv9ALwUG1wm4LmYhxakf7DgBfVM9EkRVFgP8bwXVVvPX/08D3C5tFOqoDXz0VVBFFnA+92zwEmnl7jb4bvV4DrPu1vxZfOvi4au4/bZUh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZUr3CSHf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZUr3CSHf"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNDrmU025646
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 23:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MqQ5LAlEsNqEJ+2SlpIbhfIckQ4duQR//L6MMCTIFNU=; b=ZUr3CSHfaxYU7N0J
	LwQg1xZ/rtIGFfgOgxl//7sS/0lm4Aj5yk7ZCp2DrOeQnltcqlalw/MjKgKXJmB+
	oR6whs/bwSNoSSjCUsRBmrqLCuyYyseg7WuKg2byxi3NUBFU4hAcB1Sdee3KVWPP
	crdL2t/xZelR9gxtErvlVatGaPVfFcMk+mzQujkhNYImlwRCBKmehZkMqLAxIAXM
	ApjsmvSP8+P/Lhv6k2mBaW7cR7600sun5hZnVYHOR82/Gm4jqyUqYAyyrV1fU002
	d28pwp6qqgU8yccOV33hbPzippgHDkbiotXdJ726hvXMeBz1QTAZ/E0N0QmBMdb2
	A5tNZw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gdg3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 23:20:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109935129so556531cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 16:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127233; x=1755732033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqQ5LAlEsNqEJ+2SlpIbhfIckQ4duQR//L6MMCTIFNU=;
        b=AikjmQVnTgzNvb3rZoRsSTVQh45ZvuhlWRxvAIHoPMxn25e4DqDweFEMK4y5pqTh0w
         JxyxWpV+ygtkYGru28AmnSLmMMWINtNx96pmpto/L242M5Cq7bP1zx3Mr6Yv7X5GkhYH
         0ulr5vXL/WekLgV8wiDL74o/icYSyeaPZwa2vODw75kJ38tReV7s6gXW9eJTJEk/PGa7
         cJXnEqCxHJi2O4yYoI+22mCOElrlEnCbPckKGPbb9LlL4isa7UoJy5hSxxnW5Q1cBJcO
         fRkyB0KtJL6nevf1Hhhb7Inbr/lVF/0rZETwNMOXdIjE1it4zGfBGETY9YGBAUa0fRJJ
         jWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/q5OcnVfWlrbOBn7o1q+YDTSbFxPR3nGHNKOXWahzUm3kYM4EpNlqo9UQENrvXT6oKRVvC/9VYpQ/x/ko/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHup+TFX7Iu3MkKKV1/AuMDLpAgTVJK0aQ35gdgKLKcDI+M65n
	rkacndnZYgh1fa8yGS9japobPJXll1ZqpsdoDdAFxmaLQM4Q2r3jks5R0Fubw0Q1aO56ZUBecGT
	Z+c8u+Eu7lmMIV4sGKoyghbAd+Z2n/ltaCTkBr0cZHdtjO2EqqmHERNC+wcyw6JDnZZu9WQk=
X-Gm-Gg: ASbGncvUVHjexS6zJjfGdJoeNLvidqDbgSRffFJ5KZ854NHVI86WERBqKgKsDyGkqSr
	gIRvGwJTtjELXd/hgOYCrIQtcsf0xRQXMTEKN826fXu53/ewDwktMaYF8kMPjjrcyAC8YEOPBsk
	akmE37HUCg7N9FiHuxyfoiAktukS41QGoqprGSmD7/w196cANMf+Rfsf/dwDYXaqWfwDXLT74Mj
	6kXwMoyiPwMvgcKI3Z6Rx3v/6L8IFnwCIveZ3a9i4RSoOi0PCacAHHlt2bwC5JqJ1jLzB5aVzr5
	oWAusUtF7gLSP5mVxdoK3MbWyCqAcu5lmIr6+cE2pz1HzWzVOFWnnz+Uv3aOoSj29WSot7UJZ9e
	QpSKV7qYC6sXzaZiXKg==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr35471981cf.10.1755127232823;
        Wed, 13 Aug 2025 16:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEerwHUOumqAcf494bszPPlRc+za1y06J1v7a2/RnRceuUSxkyYhtRk1xeTG5320KKmAVxs7g==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr35471561cf.10.1755127232170;
        Wed, 13 Aug 2025 16:20:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm22753076a12.57.2025.08.13.16.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:20:30 -0700 (PDT)
Message-ID: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 01:20:27 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689d1dc2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=frUY0QHmMtcHLPOZDgsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX81GJ2E7zwKC6
 XIpEfqZX/d3w0cWXYRkYdvdGwpYqrc+TnRHQRyW/SQnOpgUlF4ca3xCh2TXyePgdStD/ux55RFy
 t9Orh96/DR71FHZdUsyH8n2EJWz8u5x2zbvXoHtKhg+kJbhls/6SxwgCiM1XyPO2qtCkt6Pmh4B
 rECdEzBNWJJFmtOXzNPqbwpA377yH+jgTKcx2GGTqtBMQyn9ED4BfwT6s0LgI8BhFBhhVKlP45i
 kK4uYCrt4W8fFuhUP5T/z3LBjZxsm2HKJk/XniocXQFVJNQFQKxipsj+NDPieWUyQu3FZu4Swzg
 0Eo/UsCYPcZ/XEumYqcXEZfnvBRqA79Qd4K301QGonc24eD4LkYMPcmIIbt/UFnEOHSkxBnjFlO
 Wwt6U/Qt
X-Proofpoint-GUID: CssqxH05ecL7oT0q0qPoX2P2aoPFTpQR
X-Proofpoint-ORIG-GUID: CssqxH05ecL7oT0q0qPoX2P2aoPFTpQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/14/25 1:19 AM, Amirreza Zarrabi wrote:
> 
> 
> On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
>> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>>
>>>
>>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>>> to represent tee_shm as an object. The shared memory identifier,
>>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>>
>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +/* Mapping information format as expected by QTEE. */
>>>>> +struct qcomtee_mapping_info {
>>>>> +	u64 paddr;
>>>>> +	u64 len;
>>>>> +	u32 perms;
>>>>> +} __packed;
>>>>
>>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>>> TZ will always be little-endian, regardless of the host OS
>>>>
>>>
>>> I'm not entirely sure how this point is relevant. As I understand it,
>>> the core that populates this struct is the same one that accesses it in TZ.
>>> Your argument would absolutely make sense if the host and TZ were operating
>>> on different cores with distinct architectures -- such as one being
>>> little-endian and the other big-endian, which is not the case.
>>
>> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
>>
> 
> Or, you are saying we may have a configuration where host is big-endian
> but TZ is little-endian?

I was indeed about to say that.. I believe our tz is always little-endian
but you can run the HLOS of either endianness

Konrad
