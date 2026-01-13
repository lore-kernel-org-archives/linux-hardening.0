Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED5389453
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295622; cv=none; b=U3PxgU1lmFHHg8ySztlEihAdKIRpIuY0EYgEzh61feA1R6rdSxRq875dYwWafjQ6SRgsnQ2MmBIVyuhU8oHpdkHbTUq9CG+n//92ft99xeerXE1w5kfcFVbxpmuU/sR7mJ7Zwyh6r6U1KKorzTo+s35Fx/RXiXA5v/7OD5UfVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295622; c=relaxed/simple;
	bh=Q1wYa0r1Hyd5dnZJUXucqongJqDvGWFO8VfhCJnw0Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DM3KmDQfliqriXWulPaa8QjOotK6VWRknmeNRFqXVi6IEJAIJWmdnoypvW5hr9BomvVQ1ij8austMNOA/ohGKQFiUGV65pqCGUSYPoPikZEAuqcvR0RO8X0FSCzMKl9ejyrFnJtfs5O7o/8s2YZNcW+/uiozfwfn7usX6gb4+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLYwQYyp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yq2/jXV3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLYwQYyp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yq2/jXV3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D535Sm2865775
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 09:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q1wYa0r1Hyd5dnZJUXucqongJqDvGWFO8VfhCJnw0Y4=; b=FLYwQYyp+BA6tKSF
	3v+UnT3JUPuh30aVItflTjHPpQoEk+3ac1eOapGW/WIxqE0cIvqFWHb6hWG9n+KS
	tLpSaekguF8y+pH43JXz+kb7eVToX5C6x3HRHGNTwc1Ce0YL+pLExjhbGtnWf9kN
	KAWTmGxjfk2UAHB48Wu7XNSsiocBVm0rAI0K/ZLpHe8bvo+CsXUJfhdXw9VChqy1
	umHyUwGCNCr55oFrAlrgcBeKo6h0bBw2FOK6ICkA2FnIwhSrmQJc05EQ8tXgg/vK
	cN0+DOC7jdGxSmttdDJg9q5cgaeRD0qyGIEJ/fZvD9B7X1cPJbqJ3MAaLDBvlnc9
	0Zb+3g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnfjh8qwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 09:13:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c1625bbc20so175850985a.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768295616; x=1768900416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1wYa0r1Hyd5dnZJUXucqongJqDvGWFO8VfhCJnw0Y4=;
        b=Yq2/jXV3Yr56QsqEyVcmE0lgySOjPcKfW/UK5p29DOat/JxVumXUiNPbv7ZRjNFxH+
         LGd9/AbKkE9hoM8Q54YJ0LZanLfWL4jGut1odKapWmnI1oZL4S4qWzx2zmM/mtxW6sxK
         +4PcZf9/tw9/sXKM+sYNXsQT/LRY7fet7q3H2vmRf37Eh40qvZhH0SHRDxTDC7IlyTUs
         sWnfYNUzJ7ZGACJ7cnqjWeHib/L8HnoaAe7D080iLhWeN0vkHbhYgoChnh6rW5JUszoQ
         aC2x7YEmytcHD1UsdfTy+c3fYDMCzhAY8opuMNy8KwdVYsnhG111nibk8OMwf7uFFGqd
         2s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768295616; x=1768900416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1wYa0r1Hyd5dnZJUXucqongJqDvGWFO8VfhCJnw0Y4=;
        b=MkkpF2XO6Cupia0XXjBTtjNSEfkNvbiS8gGt4lduZ/R2sReOWzah96zJaFb2kn7GS/
         KoSErnfNDuGbCM9ZwwRWa1AjJUFACMwXvkgbfV7IOIP22DkIB7E4zd5yf5pnYnB8o5E3
         LjExZ1cT5JOFpKVVzC9wzcKqPxy1CD5kaGOiEZOVMZYPQj8BQHrVm1PspgCvM414L/Vr
         2qpt/DLtUIZ6Y0q5eqNiTKUq7yb3bD2Cq0se74ft5TjlFdzp47vq08dPIg/Yy8sWAJGH
         OnBx5h2TR7Bo0qNIE/Cwxu2zYCwZFOHMsRUrpKY7E8nysmJKcChmlsOopPu0vPsAyPg0
         a1aA==
X-Forwarded-Encrypted: i=1; AJvYcCX51zi6UMZ+u/khfVtJLgfB3wOQlT91bloPWCecQtMO/36u8a+stMzDpkFKSbq+za1X92tJLu/Haoqyzaa/ymk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBfx4EgOlwGyn5Mto5kmzrmeVnkb03qSl8jXY90Y02vOAUnYIU
	3nAphxxis5kAx5zUarSR1YWfDl4Ke+lCcHjggtIqUi9dXSR3k1abRn3ZbO1sqm0PTdMHqGPBZW4
	/BJC1nl/pads3Ov8/IPhla1IuLb5rfs+lQ/erQNv/IsTPx1sEBESbuyXWAKLCEvCJZBE70wA=
X-Gm-Gg: AY/fxX7udspw4TyU2DZmytHJzutU3qQOeOakztGVIg4ylr9tLINIlLXy7X39X2Wayo7
	sQBEEaJjI+chJLziI//+eDakitlvRihYekjVbJsZC6nFmHNCA/Rp/iYv2JW3j6MvEg0/CYMX4fz
	Pj/1zfrx0y81KZ8mB+5suHG9zoBKGP9jTEY0a/JrtUzVUTPzwLbUUMjNfuNyORsO0EfEAMyroN9
	vR1b4ooLjqL86DvInlhsIr6M84R1lPEUCSS82RJx38dhPqTZtSAkfTIrRckUZm1eZqYNrDCf5QD
	QUdvUn6RwrvdUiikhb7plhhuFvEtNcQ4AJH1UA+srI5yektpia2tEA7VdCJZG504FH8Pi4u24UQ
	cLAv3T+Vk1PHj3qcvQy2rWVLnO7DzFNGRPkJHROgNCexol+SEAqqFyBX4CDE5tXwikGY=
X-Received: by 2002:a05:620a:1a17:b0:8b1:a4dd:3d66 with SMTP id af79cd13be357-8c38937c32cmr2408383085a.1.1768295616015;
        Tue, 13 Jan 2026 01:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE8mvcWRAOYV5ntkCc0OUS0wbdHsZPJoeeWyKuzfEDiYGM4KpwhZ7FxX+eV+Ru1vacAffWUA==
X-Received: by 2002:a05:620a:1a17:b0:8b1:a4dd:3d66 with SMTP id af79cd13be357-8c38937c32cmr2408379585a.1.1768295615516;
        Tue, 13 Jan 2026 01:13:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b22c3absm19741005a12.0.2026.01.13.01.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 01:13:35 -0800 (PST)
Message-ID: <68cde914-0eb9-49bc-a2c1-20becb91469d@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 10:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Remove extcon
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
References: <20260112-xiaomi-willow-v1-0-8e4476897638@mainlining.org>
 <20260112-xiaomi-willow-v1-3-8e4476897638@mainlining.org>
 <57ddf3a4-8e4a-4072-828a-9145f1f30d12@oss.qualcomm.com>
 <9063644cebbd401057533ff11df3c9c1@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9063644cebbd401057533ff11df3c9c1@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3NiBTYWx0ZWRfX0tZQMbLjFDJw
 At4VZjYmWFvEprWNOHYa6ZsuPwaO7ng6QjXQbuYzOK/4qyEa3ksYFFFrwdKxshho/dnUzL+1fX7
 yiRHukqW/NVxtQc+TXL+s2VPKiuxflp3PhJo8U6Gi8KoAL/YUqjHDvpRUekyGfgJkpO+ktxdR3/
 T/B2W6FiXMu3AzB+3+HaeSjSHrteAb0HSRdEj61j0vfXkzmQ0ZEn3Ce8+IiOCBq1pVzIRz4yGkW
 92DPoMDavRbb4sff7wTjVA1KXVCrEOEwWqxUZpn7JQkvx+vWRAfmrl2p4+0FQrbJ+iJlLDYdL6O
 v9VxMoOJHEVWtbXLDSjryRb7raIYZSVOw8JG6Mk77Z0mdAraMgqylGc0QAZaAs17pS9HJYA2Cc0
 M4N+T9gm1vZleAGioZl1tDqygdcKG9gha99P5dtAYFLhZRtKyDEZqqS+dn3Or0GZVIsN+jqBUQm
 CYdlPGSdh8uwYiB6Y3Q==
X-Proofpoint-GUID: 9gCyGscEOLaAlaqwUS-ElGk4S7YqIfW0
X-Proofpoint-ORIG-GUID: 9gCyGscEOLaAlaqwUS-ElGk4S7YqIfW0
X-Authority-Analysis: v=2.4 cv=XJQ9iAhE c=1 sm=1 tr=0 ts=69660cc1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Uyhorv2uAAAA:20 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=0eC1ZI4lsAi7hr2-BaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130076

On 1/13/26 10:11 AM, barnabas.czeman@mainlining.org wrote:
> On 2026-01-13 10:00, Konrad Dybcio wrote:
>> On 1/12/26 9:13 PM, Barnabás Czémán wrote:
>>> GPIO pin 102 is related to DisplayPort what is not supported
>>> by this device and it is also disabled at downstream,
>>> remove the unnecessary extcon-usb node.
>>
>> If you put the phone in fastboot, and connect a USB3-capable type-C
>> cable (making sure that it's not a fake one, usb3 ones are noticeably
>> thicker), does it show up as a SuperSpeed device?
> No, only high speed is supported, and qmp_phy was changed to nop_phy at downstream.
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/ginkgo-p-oss/arch/arm64/boot/dts/qcom/trinket-usb.dtsi#L99
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/ginkgo-p-oss/arch/arm64/boot/dts/qcom/trinket-usb.dtsi#L89

Alright, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

