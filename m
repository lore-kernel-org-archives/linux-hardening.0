Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1E30E82E
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125389; cv=none; b=crUxqVfHiI3VK5i+mwccJMctv63UZYXlW7kf3jWH0C+rr2cyGAMXXlzm43zq5FY1fosOJk360IZpSLnVEP+UIv0DN6w2cA920ntporZypD3mKHgJT/K61P61jPYSZzPuEBuHO2cizBnhlORpL732Yzwn/XbO8F3kh385q+urq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125389; c=relaxed/simple;
	bh=GwWQIqDRWNR8rlc3sYd61ddWtomTVhI1gZm1AYNVkd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4GGGOZjRRw8cucsTeesqbLw1PbADvmBAkCGch6nSwaLar4VPYQme6LDNhuUm+mSAuHE5J8I1Tcb/Eb9m24XO2xlgr5wZSRNbzHyejhrdfRyFXHWyHO1hRDNVOk4thbhnX+2UEkDR5ebdHCeTyC+tqSEvGgbn9n22s7xjxDJNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VE0ATn3B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VE0ATn3B"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLVFgx020584
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1y1eNmB//F61SipoixUPmWI3edeccgArIKxTM78/+/I=; b=VE0ATn3Bals0gSW4
	+bdtKCITDeGJTX4UJeqZJ6AqzNU2Y+CcP+0ZiRu0/e1mI62QExXllwlPJu2FPv24
	u001U4PpaGOEi9MXWbvM9oqU2EF60TrDYhD8JW1VZLcDI22vTB1dO52BVp5fpCmw
	81lkpE2ARNo8zlCNp25j4eIDzXrhUjVaVYI2vB1AFcL6sRAnwCYiRzU2v1TVjx5J
	iX1XFeFg60S126SjDVQg0Ei91wpRg6/jPEya2VzWUbUSM4qkdaYMapH0NPKxiGxi
	CScpMuJBBqJFdL9VUZ6SAtGJppSuQEkIZqQwRSzFKk/bSC/gin5fKyTxn89UIV28
	kxZAgQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmde18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 22:49:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a92831a0dso1078126d6.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 15:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125385; x=1755730185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y1eNmB//F61SipoixUPmWI3edeccgArIKxTM78/+/I=;
        b=rI9sehDNbzL9B2y4jIupg1Ynry0bs1ZfWuhFUi+h5kdTrS6tNT944XWIHGsaILl02g
         rqysjN5JhlunXONppVYblDaRgq+wmFm2O1PBIHT+tchwcAI2mJeBYy7ASJnqjE5QOZwY
         p6VVUt2xgdfQrpDbwZFfqlfPygIMkjmpE14vUwlDzBx0ry8DVhPiLcsWAvrdeDZjgRqD
         gVunxx8JHxz/smmnvsGA22bKc9DHM1kSikz4eYNXWyA3GCbsven6UbKLCgzAdIQMP5rD
         3RMdvwJk+hTAN1QMM3xEjBtfgzF5WT99lxc8u8uzJr4QRF1rbVBYnfDwVo+0fRRVhRrD
         zrHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1WixqgMnO7ZPuciTQH2P2SK6EFQV9p3TESkVvS8VtwZcf4UrGXJk6BIx3+/2YjWDz1JMLqY9u3kouExCGWC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWRdCCuBhvWBD0GC5q314wRx9uI5EZEJawfDAS/fX9stzQctk
	uZb/HV4JRm7ClN7ID168NulZrxwxyl1QxEpn4bhTmiU/Jw9TkFa4JlmV1uldm8vYql61USpG9Ku
	07ZqcgTlAIQJCi7Nlm5oHMMMYLQXNhnqAApGHULDZEL18ikob2A4c3d3Q2GZ/bpQDgVY7ro4=
X-Gm-Gg: ASbGncsicm4eWy4dtq4icb08mZA9A8pGNmN6tWrrpk6Ys7gAZW8BnKo88ooRiV2rVQO
	WKRvUUp6FfKAKUBFWTrBmlCVgMyRDgMSrR4EtZn8Fk0k+rJJBjJHYDRH4Vjzq1CD1irE1jCCOwF
	RXHyZgDCWrwjXCc0vMui3QNY/fXfMJLCEW5iAWTtmolcVU2ZtX8mKM92feUwRxq6Qg4Ai0G9uDn
	SBMmMWYr7+waGDjlm9uoAU8PoEWnSnv2gFCFrj6HRJA/zdk7KV3mDeqZppFJIsfNlHKhLZKgpXO
	RDMYmdRkDSG/PFzylPe7paEgbYazm4LcOC72uHSlzgI2SXaaPBJPNCxq7UUDAefOK5iOETinfTU
	ep7Acq4a3iwoe6Wsw7g==
X-Received: by 2002:ac8:580b:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b10ab40660mr6928311cf.11.1755125384973;
        Wed, 13 Aug 2025 15:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOa1EUACt46c/s0PUTGj00pPK/iWnH0SLzQKgyx6D5B8kmovv05Bwu05KhVWthG9YSv94PmA==
X-Received: by 2002:ac8:580b:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b10ab40660mr6928091cf.11.1755125384448;
        Wed, 13 Aug 2025 15:49:44 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2475800966b.82.2025.08.13.15.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:49:43 -0700 (PDT)
Message-ID: <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 00:49:41 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX1lUYrQKoKIbv
 WVwTXV5UV3UmTzbFiEvFieHWLAYzUwLEjz7xoqwFwZ6RZyPB0ok7m8Au8b/URX2sOmcAcatLWx7
 7zA3BlTZ5xFVad1X/61CVLE5YfbL7VFLzTdmXj27ThWHn9OUPr664HFvTHMsRLAQ9rnU2d4D4Wo
 duj+TopHaqEKlqsu0f5/vYtp2xy2K5Pg4pe67RUUGm9waiJYGZTOE5qN5vB38UuBpTJS3qN0ccN
 B03YXZZ7lKxwoI1JzbQTwOqpfndMuH8C4pheFCtQ8u7hd/QZADe4jp7MIFDbpwrodQ4n/YYZa/t
 /OEKBzcSl2sS5/QBs6i8L5+m0eMcWbK3CtN8yMZrtWDZpK8VvWWpExHdx6rpW3NWlJ/pitfVSX0
 xu8sZb6C
X-Proofpoint-GUID: wdM4GCIJMxEWKsDK_Rl656TCn-fJzFdR
X-Proofpoint-ORIG-GUID: wdM4GCIJMxEWKsDK_Rl656TCn-fJzFdR
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689d168a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=YlTi__48JDlbgKAADYoA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
> 
> 
> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>> Enable userspace to allocate shared memory with QTEE. Since
>>> QTEE handles shared memory as object, a wrapper is implemented
>>> to represent tee_shm as an object. The shared memory identifier,
>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +/* Mapping information format as expected by QTEE. */
>>> +struct qcomtee_mapping_info {
>>> +	u64 paddr;
>>> +	u64 len;
>>> +	u32 perms;
>>> +} __packed;
>>
>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>> TZ will always be little-endian, regardless of the host OS
>>
> 
> I'm not entirely sure how this point is relevant. As I understand it,
> the core that populates this struct is the same one that accesses it in TZ.
> Your argument would absolutely make sense if the host and TZ were operating
> on different cores with distinct architectures -- such as one being
> little-endian and the other big-endian, which is not the case.

CONFIG_CPU_BIG_ENDIAN=y exists on arm64

Konrad
