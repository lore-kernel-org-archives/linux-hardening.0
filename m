Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695DD271471
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557154; cv=none; b=SLaBBVumHIZ9Yemw8dPDpDjeENif51fZZAmWurH/q8lSs0MuFqklppIHgDQse/wXiagE86yS8xEfCV90+F6I5trfD2LrRxmuzB/wnCy+8802CWJvY8qYQ/1E8TQKwn09jjRNkBWpiGLrzaUFxBqrwKC9Mx28n9BdVkRU8dI/6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557154; c=relaxed/simple;
	bh=XFZavRyoo/GcZ+nYMEPWIrtkLwaggwm55zfwFeWAdxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYC3pIh35LSsjlPS6pewWgYLG8HfapJJEJteH972bTIsO8cBqSPPB1xknuOaWam1BMZqhpuVv7J8ualRFksNFAEpMp1P5tv/NBlkS0AkTGLkymg9T+wUqTX5tMa5KoyDC5s7epkqCV57I9CI9zaExSEyXuSLfP18eCOJbes1JTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AAfuvwPE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhJGrM/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAfuvwPE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhJGrM/o"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G8VEpX1240876
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EgzvyyUoS1nt6OXKkWlbx24PxE7R3inU1X13PpTUzkw=; b=AAfuvwPEJzTXI5rK
	PIzCyupyzO95egByORyS9dAprXtfsii2X+Up6a1+GRWvQIa9HAKuokSFsF3dYWLi
	5NvJUUwoEGGQbbaDY0iq/4QTeb4l+SzRc9J/wRRdQ9gR2zoahLPRgfF9FDWX/sDm
	seFDcOOZyo7D3m/kIWqgzJYHjrsNlNL+hKGKMVBqYoLOmLs1jDA+sJRLDjBJn+VM
	YpT2lwSLzcGXwlbzUVxUehyNThX3TGMKrmIC56N94P7xPwy37hjGYK1dcjgJa6x0
	8iy5QrX8kePbdiJtIHRJFIAyjXysNnMa2x+E6EhEoTP4IRgtRcJiacj6fys/6PKq
	EEsdsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96ssp0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:52:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c536c9d2f7so65261685a.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 01:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768557152; x=1769161952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EgzvyyUoS1nt6OXKkWlbx24PxE7R3inU1X13PpTUzkw=;
        b=YhJGrM/oBeP+X2UySISM67hTLZuztFH+FrpRztqSG4v9/TnYPDbyqgGnV8mcalCdrE
         164jojIpreeG7f3/VADQjMTsvQd/7V6hMVOl150B4vJ5U2AhCdQMbgL1W9maiPlnG9fR
         RFATDKO7I0wrCXCG0bSdzQ8oTmPy1tF9U7P/xVv5XVCmGTY1dn1yArUihf7xsyOqflaX
         UW3Z38K+VxCl3zxIi+B5dWbELbIWsF+uy46ffXGYExvS3uwahysLk/S6GK5qbxua0UZS
         KuyWtNCjeK4ijtnr70WNDOuy0j0bTyshCIEpolB3HPcMpB97B2k/b0TOMZt2OmskmYJN
         ynPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557152; x=1769161952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgzvyyUoS1nt6OXKkWlbx24PxE7R3inU1X13PpTUzkw=;
        b=W1N0O3wHAQG/Y9uaeYIT2sTpQT1QBGEbR+8CheULbDpmmys706BShFFXeV7mrt8JuQ
         Kls7u7wc9T1amp/Ec8hrSMmjt9rvjwbN8iB/GoiXqh/+GtdXtVP66CFoB6Vjh/lXs1VP
         2oO3tTbBczrjLsmLwajGgkqpzPUeUtdpR6tQGJNSaC64/QNIenwxxrDKdMLcQ8miLzdJ
         h0mHqocVvioKxD5Vk4zOQ8dO5l808UuLLvJQZiIk9pgsQj+QwFIvJZkiFECSPMajY2+K
         11YFbgcgDjPaud9VxHJCVSYi7SZ1++AJyizizeE6q0DomHWLCNHGzfInpjsSwjJhEL42
         0zPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSMCvVdqHzJFVlJnBNnEMmmc/G+SoAJvH5aappZrCi967H4wNJlAWppx9B7P+H47EIenqEyunK+/M6/INmNaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWHctUdtjS5h9vh28NMvHXSbUFXFKoG8ZFrzm6NmjOk8Ghxmb
	yiNyvmUilMRg240bkVCPnJtZVl3BnN6BrlIGnEyU9jNyWN8lhfab76Hbz2j3RgjGUVfxniNlMu2
	3+H8TfG4VDSs+FeuRp2oYOW5MEDa0B9YVepkk0rWQKBmJxoiGYk7+fmdMYCxVpn3fwr0Z+R0=
X-Gm-Gg: AY/fxX4Vfs9EDCEx64zYqEk2VP0eToFOcPsUxD4Q4fkc9A+6g0a4k4LfnE9f+tIZzZ4
	K4WsFx45AnKrrlmqk0X2GhyLRiplatO90qC/sqwadPYfTGv3miEgJgeffczRnIFvkuqzOcbPP9x
	BaOK1SAfmGkVhCzMvQKCMZUOcNH5z4WJiMd66sBSsT7t/RhOvexiGe7l4Gaan5qXUwojmqRTsS4
	muB8g7uOX/aH2q0g4aneK/wPPwW4o/+tsjb5685iGOMe5nRTFVXe9d76DjxubJbpcGpDi4mw7vV
	8qvfhabu3Q3UQEOHMYWN8ygQGrR9XeHQnwu0mEk4hQcUnRbsnrrqihizMkOX+LWXfaejzmUdomQ
	/BoyHjqFqabyZ+nQUCHvaMMYyD6kMY51qdUh/lra+lMik8VGtSj4pEKWZyowN8FKhwmM=
X-Received: by 2002:ac8:5e47:0:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-502a1633ca4mr24349801cf.6.1768557151466;
        Fri, 16 Jan 2026 01:52:31 -0800 (PST)
X-Received: by 2002:ac8:5e47:0:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-502a1633ca4mr24349641cf.6.1768557151060;
        Fri, 16 Jan 2026 01:52:31 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a214e8sm188219166b.60.2026.01.16.01.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:52:30 -0800 (PST)
Message-ID: <e0f33ac2-331f-4ab4-a960-6bd8bcac7306@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 10:52:27 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Correct
 reserved memory ranges
To: David Heidelberg <david@ixit.cz>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20260112-xiaomi-willow-v1-0-8e4476897638@mainlining.org>
 <20260112-xiaomi-willow-v1-2-8e4476897638@mainlining.org>
 <723357fc-a785-45d6-8d49-4c00dd4f340c@ixit.cz>
 <ff4d697c-2007-4b2a-b66b-dc86053a20a6@oss.qualcomm.com>
 <0da3c96e-4f20-4bd0-836e-73d20581954f@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0da3c96e-4f20-4bd0-836e-73d20581954f@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LZVOQHDDBSgu8o4moq4FupHmdtB_NliV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA3MyBTYWx0ZWRfX5zIp5MiqWM82
 hJYwoviHdyS6uTjdecn4oLWknXoiq8ybCk8XLbc5bP0T/yoWd7I3cHFghDQuI2f3vnBp14aj0Pm
 QVkAcx1GD96yO50M4B+j2lfa9nTiioRSfyK44uZWOH+SGgpi8Ee/zJXMOCPizK2fR2P1odd7WMN
 AjeBOCgkbXxOJh269MIrNj1e/rL/H9fELxZRKHsEiZCuRLTdmK68Bj7Xl9Xr+VwZeeZBSyVu5ds
 pif1rVwN3jn0h0wPghBZoxF6EoQk0Rp3HXyqCYGktcErG0VDR2OwgSI31c6nJPDIGG0MsYxnjde
 m1yRmf8xF5kTHePRdwVHF8QpjrsxB7dYZoZFlLHZniinWOeiPKbcgtEZaBjaGG51Q5OhHOT/p/M
 KWykWQkK2IoMkRyG5EXPTWzEbyWUBZYRO+RLmtwny/bu6IjtzPNtdjkaOQHOwgNGt9AVGQDOiTQ
 rFG11XlS+h5f+fse0zw==
X-Proofpoint-GUID: LZVOQHDDBSgu8o4moq4FupHmdtB_NliV
X-Authority-Analysis: v=2.4 cv=M9tA6iws c=1 sm=1 tr=0 ts=696a0a60 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=4BfmCM-U_7t85Gwu0wQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160073

On 1/14/26 10:55 PM, David Heidelberg wrote:
> On 14/01/2026 11:28, Konrad Dybcio wrote:
>> On 1/14/26 11:15 AM, David Heidelberg wrote:
>>> On 12/01/2026 21:13, BarnabÃ¡s CzÃ©mÃ¡n wrote:
>>>> The device was crashing on high memory load because the reserved memory
>>>> ranges was wrongly defined. Correct the ranges for avoid the crashes.
>>>> Change the ramoops memory range to match with the values from the recovery
>>>> to be able to get the results from the device.
>>>>
>>>> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
>>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>>> ---
>>
>> [...]
>>
>>> Hello!
>>>
>>> I suggest one more nice to have improvement:
>>>
>>> you could label framebuffer cont_splash_mem since you already touching the node and testing the series.
>>>
>>> Then in additional commit, you can replace manually defined `reg` in chosen > framebuffer node with
>>>
>>> memory-region = <&cont_splash_mem>;
>>>
>>> For example you can look at sdm845-oneplus-common.dtsi
>>>
>>> Tell me what u think
>>
>> If you wanna do that, please call it framebuffer_mem, "cont_splash" is a
>> Qualcomm-specific name for (roughly) flicker-free bootup
> 
> I have feeling someone recommended me to stick with cont_splash_mem.
> 
> I think, since we'll be doing the mdss reset anyway in sdm845 (which I used as an example), I can do the rename in our sdm845 too then without any harm? (no it's not flicker-free takeover :D )

It's not flicker-free because the OS must cooperate in that process,
whereas we currently reset and re-initialize the entire display subsystem

Konrad
