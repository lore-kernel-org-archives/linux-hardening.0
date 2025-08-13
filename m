Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF73009DB
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121203; cv=none; b=ruM+Mwk/sHJhOzh3rieCRuTxA5WQdJJR8NCktyZid+SW1urm55Lvp/0LKAJxk09Nlip6dTkZY6bytCVRI2CUHhl2onFpvGUGsbk2PwTvqdx+ERxJqyT2Cp3+4uxK2hvV/S5zBdS3kAUmQUoD1wwFEuaF2FWMAk1AA63aMTAKy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121203; c=relaxed/simple;
	bh=823prMjoJg1j0sL2l7SI77tJcgvJxm1hdEbc8+qPckg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eof+H49+QLYRp5ee0gczTg6X8L4MTnMutSfyRHOPfebvUU9zl6HZxGXfX+aQDL5EmatlxjTLPgVjCCj6UVYThNAU80fF6X1s9hMvg+zdMT1y+5vDNG3vK4KDzoMyybHW7M2Go9Q2iypOr5Ptcnkar9dZxidjKPlnR7NxDiJ0ZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RcAurwXz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcAurwXz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLbul002767
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 21:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsHqObljI/QrkzM/zyszZAc8Qk56TEyRi+eNAb+o/hY=; b=RcAurwXzpAKXEdOG
	TRd+OlbzSSziHs0RursQXpp6noZ1157tRtAJB1a5hc9wHvfkGroPDG5dHp6Ljypn
	0aGqE0F1t/d4Dd/mfibRk26WeUDnSxgtKX7y79C0/MDYNtUcq3TDGcV16JO8hlh3
	EENDO3rjpsi6Fv4IkkzTUAbvjJFcSsf3esTAVx3EujYoEznwzY0vrFdvvyYIM3fF
	hp20v9KwXZodHbcdfQgLfrzVbfsHbsUYycnGxFau+RMrcBfutST5fj8gPHEt+BcQ
	c3KdObkbzELN7QXHZYBC1VwYb+avioqwBX3p7DKrFP7aFYobmjX3ivPskkahobja
	vmWFOQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv5ayw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 21:40:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f4f3ecso2418045ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 14:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121199; x=1755725999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsHqObljI/QrkzM/zyszZAc8Qk56TEyRi+eNAb+o/hY=;
        b=Eg/Fj6OgZ+1m2AA5n/plVZjFD9TOiZfrc5Z9zdOdk25++XFByNyCXQGbeuJimnF2HQ
         hOiWVd2CN+kAFO1lHAd03puB2W9HLi93dp7Pi18HIVr5asbICe1ciLWD6TQhWrQw6ST7
         BD/QtV7CCmE7gf86OUzeYMY+ol8DbQ0Ig61MdlzqLBb3g93ESYJHUHurFWRwZMcmSbTf
         Y6huTuXDOquP8mxoywaqw4P5BhH4If5LoLEVIhmdWYGoJrT7Q8dbpBV3AkjHr/YAkUls
         gOXTjJR0DQPcekSBF5uXMM5OBbodt34hJJyClj++5OJO/tBxtA2PmuydKMaBtXT3QPGx
         hUcw==
X-Forwarded-Encrypted: i=1; AJvYcCVoMHQlSyv8vc6YxmCfEb0KLGaq9fuAw5kx7vLW4tsLOcyOyOB1cwMHVZ5oGLGwY3O7jYs/12fNcwyBQjCvjek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRHk1Ir6VHTrVu9goRrbgfkqnqyMK5OM+3rRk5Cvha9Oz16ei
	/kz7dvdgLXhBMdF0eztc4K8HnQu+UpNoitYGgttplIBhjP6gPs0AHo5EvEafjWb0ju0EEl+aDIb
	BB7Foyvzlhdfg0IFxQuxYSq5LXpAdM1jxnTHHha/HCBJQzfNcidLX0rGLGJDAl0mecQFQcQ==
X-Gm-Gg: ASbGncsblmc1Xa8UvTvFiqJ26aFYR27THuDXWSxJtO5wykKSElRxrJXLBRX+0/tst2z
	YE14ZOov8e34L7oKnbF1z4ODRQloy2COrGeuul2m9ZeO0w5q1yy4ad/ZHQmrHG8ph1ooADjlSBI
	WxMqhvXqn2ulpGhVmkf2lG14Lk2caOvTimBio0ExLya5B0d6UYONjsZJshUP7QH7WKOFm4UBMEJ
	DpH1S8PJ5lRXg2jTiPe1P6TQe/UiRBFO7CddoyMsg6fizchW9jFEBHOFuRrvXXAUxJNZneaEfdi
	HUmRaZehMW4UtZpwHVVn4cMpvDeWbGLRD2ANtUsfhuR2HfY0hpt4Vk+9U/lLf8IuY7CifbyObNB
	3LSEAYL+r4bgBaIlwD2OWhdLbBPZToqMn1bvOhA==
X-Received: by 2002:a17:902:e5d1:b0:240:7181:8287 with SMTP id d9443c01a7336-2445867ec8emr8191525ad.26.1755121199177;
        Wed, 13 Aug 2025 14:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxnQfRjpH03Kj/5q/5ynChdc9Gz8ERDFxOMx6F+r9zzLYTor/b2ISAK2vcBWx9FA/ouTeDg==
X-Received: by 2002:a17:902:e5d1:b0:240:7181:8287 with SMTP id d9443c01a7336-2445867ec8emr8190975ad.26.1755121198721;
        Wed, 13 Aug 2025 14:39:58 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9055sm336495925ad.150.2025.08.13.14.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:39:58 -0700 (PDT)
Message-ID: <d1009d7a-b675-4af0-a149-4856bca29140@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:39:50 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d0630 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=21D8NHQQAAAA:8 a=EUspDBNiAAAA:8
 a=tfL3YIuboUik3C6ywHYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22 a=aE7_2WBlPvBBVsBbSUWX:22
X-Proofpoint-ORIG-GUID: TJLu-F_qTXMTrt0BnzCrEySCgjpoC6KC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX8Aou8JIn1opF
 sMizFt290AI/oRs1ZrcXRoGolKcv0h3tAYBd57Xeo55j93t4kW4Gv5TMDBLxPDTJcejhHbEB32N
 mck1+4JrJ7C3Zr/pojH+WaRtUgx08Om7IIEOTMagOae+Jk+QDYLzqUwrwn95bovbnAokRk/tiAK
 SUsluzSuWYPNUbahc+R99Im84dvv0O8Ruse4msGdau98AYAse2/K0oqpIynzUM18U4D+z/XicVN
 HgLSKOBmRYAhm1fNy/payDTnBDUhKb/9U6sSk7epBQw+T85lG6kMsjdnN4Kc0/LiorsLy/7qvjf
 IH0HjLJXm6sIR2ihRhXTpVTKupjf18ICYb3X7Xo+SWOYqalaRbiUmQDA3GN7/sqRTglruGtT+ps
 x0ZzuPie
X-Proofpoint-GUID: TJLu-F_qTXMTrt0BnzCrEySCgjpoC6KC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Hi Jens,

On 8/13/2025 5:49 PM, Jens Wiklander wrote:
> Hi Amir,
> 
> On Wed, Aug 13, 2025 at 2:37 AM Amirreza Zarrabi
> <amirreza.zarrabi@oss.qualcomm.com> wrote:
>>
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>>
> 
> There are some build errors/warnings for arm and x86_64, see
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/jens/plans/31DmCOn1pF2JGVDk3otBOXOL6kV
> 

I'll fix it.

Regards,
Amir

> Thanks,
> Jens

