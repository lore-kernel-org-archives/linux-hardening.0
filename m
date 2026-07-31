Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEC35F199
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477694; cv=none; b=HNoCbVbq7pu6qnnmi6I1wWAO8Uq9TY/yG5+hv/n6acDiaIAa7iV0XEhTC2TROtcFLQFS+Z7RvWo9v5YoMGh2AUQaBTI8Kx4xaMo504kHLufNYNs52AOAr0epEbBuk5d/3GAlYAZErHHgy57DJv/f55d3dTz2g8+8k8ywOG8x8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477694; c=relaxed/simple;
	bh=9IAiwHERiQkQn/Ry44QWMoA1P6ukK6hO/AKfFxIf0tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XM9l9yCHctK7jGFxOrNqq0y1j4647a7w8QkbR3NmJ5QXWhhC3xZmB9/9BSF4p2aWesab/pxhLRikzlm9ztfHNGCZQwcFGe9m19pY26X5txTWxDn8xgOWbbwNIQS+CPKROw9F7T8n3I/+eyfBgDF8RHQpI9dwfJ6rdjZByfAIhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/poziHw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kNk6Xyz3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/poziHw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kNk6Xyz3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5tRxn3130401
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 06:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yp8Mavcx6CQHzFiv541AKdT+PiGfdYKPQ+fSQX8jsE=; b=Q/poziHwoBoxGXeZ
	Ww+9uNCbsx/K5rn/sz/ShHj3cgIJ7SiLBM/INrNavhUajMIRCr7GY4zcmSqTsfbg
	mOuoRD4IvirrP/KqYVJWbshAWQbI9ctWToTqn1da2OYx2QwEbaYwAQoVLvIdoSv7
	gKs4WZxdhYVIxCAWvBZXKXoDwXAa8IrW4C37/yU1LfcIxiC2s7KUmDCydRE+5ftt
	ycUrhVDcb7nVPOreLbyJG9TIIl+XqRt2EeYnwmf4cnnY4f72wzS8es17ctt+PetD
	mq705IlDY8udmWrbBUUecs/pqVOfajOLbx9uYEHW7QZRXg9KvIcVXCXnoEpWZZU3
	aEoYVA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp0180tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 06:01:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484b9fb055so1932091b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785477691; x=1786082491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yp8Mavcx6CQHzFiv541AKdT+PiGfdYKPQ+fSQX8jsE=;
        b=kNk6Xyz3ASCX3QPM2PUgtVyI7thC1z7auD2nlTH05pie4UmcTxhO9ns7lmHuy4XOYh
         0LdDPynrcSCzPBaCmlh6zRlw+L5dk/t8OOKkP7JD0dRjoTz6IG362JdZjieMw5PXzfSN
         5i0Dn5mnCPPzV0cOWYONcgDyIbhNWMWkZW6ibTpleoRuDwAMDlLSJtXj1Ej6iDOTRrF+
         vrbicK1OFMIW5gTZoYyI8E9qwV27qyht7yv8wxXogew4tuvllHl5bC6E0uY9Qtm3+1jS
         MfmuNkBLpo52gbti191wpEYVH2APpH4mBufU2S9Cd5wlp8dfD+A5h+00ko/75GHnfd0O
         0jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477691; x=1786082491;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yp8Mavcx6CQHzFiv541AKdT+PiGfdYKPQ+fSQX8jsE=;
        b=O3fgHSqkYEcsF4C5qX/kgCyJ5BBapiY8yI/nwuiOd6PXBljN5MSGCQn5WnPGFNBh81
         MV0GFAamxCxogKvh8J3xkG1lyABqvnmaCTy0GoD5XuyUQMmEgoDwYLREHJT3+LsLgT8n
         jZGLKrFNmtXzs8cufxroBg7tI9T3RkS38I+iLKjWPpPGghCA5eKJx/V54kQbyqnLnjXu
         J5flfhgh1t9wizhPL602Oan8jdvClrggVjE7p2rl8e6Jbu41zhaPoGM4hJz/4bzhbI2h
         S8mmP1UZlop9VvRvADLkucXrsFIyen8tFLgPGleFNMZYQTP417GxgW5A4wvtrJs6/dQM
         S+mA==
X-Forwarded-Encrypted: i=1; AHgh+RqPYqq5KCfXUEbbUsjtks6bp3V1fTI7H5OLiwJbkX+7X5C5fdD4e+bFM/Ru00w9HupvjBhL6Eerb7Xm3Yzfj50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0b8iwON3SU2xfG4z5ddgcO00tjIFWwnW5CyiXxUXjpGPtB3+
	UJVQXAh23o4SBwTiLb2OUUVbtOUZp2s6Tqi/maFsJamv1VMGddnj/BVwe1xeLW9oeeo4Ebr8WRk
	AkjDdqlFU9LrGQSyoZSJzixg6SIkcrrI8lRMGl4hNzh25phUcywD5pZ/1I4o+9PGltJWB+Ws=
X-Gm-Gg: AR+sD13s0p2xZ9EEjCQfcljhuNg5I6XlHHoonMN0LFVV01NjYFy7dXUQ57+x1vRclSm
	E5RB7gJlHdtpTelGVTyttCTwLzvAUMS+8ssUiTzNFQ+z7fTLUQiAcqZINS5mipu+/sHdxt/eS3O
	i/BSSrYbqqeTjk0yEPPcB76p6ZV/ZRiU1Zy7569nP94+2pzSUTbXM/arOSWZIg/5bUiKDDj3geb
	c8Ym99NbiuLU1uTaax7vC4y0UQRFb1f8M+pARNPe+Za3Db9Y+WCM12gpm/rFhf9JEMIyFqd0jCI
	oYsgjAfuHF8OK6B1IZ1UQ6Ek7PlDlF2oW4bGFWXsXjlBUM2XK4HpBd20Abd54j+WU8v6hrzJJgL
	mDHmbCp1TRfb/VCzFXTDglglAXDLDYE4=
X-Received: by 2002:a05:6a00:12cb:b0:848:80ec:5d2 with SMTP id d2e1a72fcca58-84ed6f02d49mr605933b3a.51.1785477690454;
        Thu, 30 Jul 2026 23:01:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:12cb:b0:848:80ec:5d2 with SMTP id d2e1a72fcca58-84ed6f02d49mr605895b3a.51.1785477689968;
        Thu, 30 Jul 2026 23:01:29 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ed5deb8ebsm311596b3a.40.2026.07.30.23.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:01:29 -0700 (PDT)
Message-ID: <548b30dd-915f-42ae-896d-3ab8c955b0f2@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:31:21 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-9-973cd3a226af@oss.qualcomm.com>
 <0f56d22d-437d-409a-852f-9fbf4e303284@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <0f56d22d-437d-409a-852f-9fbf4e303284@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfXyWCfpiRutgiE
 8/rQPwXxVUIJVje7yB1F/cyNyCoScjo1cYeTPbJcHqIGPXlbZESoKvAg1tzfjrjfEn3rvSpzp5q
 IH8zszMwXSEmyStIMl1uN+6MF2H6+Hc=
X-Authority-Analysis: v=2.4 cv=Q/DiJY2a c=1 sm=1 tr=0 ts=6a6c3a3b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=couP0MF0vw6ipDBTzhAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfXwdkx/J9tVjzv
 ViRxcVdzNmk3xUlcKAUoRAFNLXpZOL24WXvOIu9/npgjZV7Mvw1AOGbzoZEoHXhM7iIqhjAzp+z
 spMnvTwepClUFUGM5YTMZCAESo60rdqPe/jnbLLN7pBvo5lyZWKA+rjbndo5eiVg8w+TSkhXSPt
 ULV3kzcA/JjMiIlGUQ6BvTpdqJSn2vh3keR/nNj8Gl3yG9v7Let1NIAzRa0TYm5XfMkvQ3QAoQx
 JBBDBnVElpdSk8BKuE2QmTklzawVRs+t/dF0pe1ioqxSiZCC/M8XuQ47tseJnLz7afRFmlWED3E
 gINC9Ksfo6vgqQveJgEU18c3bNfCBfsgF7rpdfuZdX4RAfjCjkxgx+BNQ6+y7cnK9UuZcJFXn/S
 iUq3XMwEYJEE3apQPLTVwn2nWUx2S3ilIwcTfXCbgcSctfc8pXCBO0IHFzduMHjysfCz9uO00gj
 jtpGOUCnhGB1u20vbnQ==
X-Proofpoint-GUID: QJ9rX6bS6qMbQ3bOGl7FbTODOE5JrXVp
X-Proofpoint-ORIG-GUID: QJ9rX6bS6qMbQ3bOGl7FbTODOE5JrXVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310038



On 7/30/2026 10:40 PM, Daniel Lezcano wrote:
> On 7/27/26 16:22, Gaurav Kohli wrote:
>> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>>
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in hamoa.
>>
>> Set up CDSP cooling for both instances by throttling the cdsp, when
>> it reaches 95°C.
>>
>> Add polling-delay-passive so the governor periodically evaluates
>> the zone during passive cooling and steps up cooling levels when
>> temperature stabilizes below the next trip.
>>
>> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++ 
>> ++++++++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/ 
>> boot/dts/qcom/hamoa-iot-evk.dts
>> index 9fa86bb6438e..a146be1cb5fb 100644
>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -1684,4 +1684,36 @@ trip-point0 {
>>               };
>>           };
>>       };
>> +
>> +    nsp0-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    nsp1-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    nsp2-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
>> +
>> +    nsp3-thermal {
>> +        trips {
>> +            trip-point1 {
>> +                temperature = <105000>;
>> +            };
>> +        };
>> +    };
> 
>  From thermal-zones.yaml:

thanks for review, actually this is overwriting temperature with 105, so 
other properties are coming from hamoa.dtsi.

> 
>      ...
> 
>      required:
>        - temperature
>        - hysteresis
>        - type
> 
>      ...
> 
> 
> 

