Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3838944F
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386505; cv=none; b=h+M57hGw7KtZaczXzduBp48J1XH4CIE6r4vR7rXD74TDSXiD2cv2SiYQhFDuwsrZRVyv0zi56+4moemFkF/UrUmxtCU2OenQ7NSpoX96hpeViCRv7skLgzFB9l84tp5BdCNIK1A17/5PaM6qmBxJbL569Xzk8KiVT1ePtr06xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386505; c=relaxed/simple;
	bh=0CbyshIj1CFfi3rZ8711K9DQYajBFEov2AFFETZzmJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ahl9gTZTE6ZQrU+PmUn7iGd4sZo18ALyF9oSeWgOSM68B1nZlYMVNqa2n4XUw/hDLJYdTQEE9oUAqHHziL+ea5XbcXtd+9vG0XJOr1tMCKggU7oOczEkGS6LtT75gtkeTwESqhgY+PTPhXeH6+kqRRSb0d8uf6EYscPCfh/Awyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4Y7jY8t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJAHklZW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4Y7jY8t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJAHklZW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E85oVh1943025
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 10:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2rUIWP734jgyS7kfTHkz2k68tE+yGXTA1ZKqPQH6og=; b=L4Y7jY8tZjq7r/mD
	hQzFvYOFvfU9JrUK5CwE6O+iHhAC4cIrR8X3ek6CvmLs47DY8JgtEvl7AE+O3b0b
	MHxQ1dfKobRAoPJJWcLf/DMlK3umedQYtsj29x5yhxJHnQPaQUNGrWAs5heJzhHH
	kvY7iPbdQ6dNfb0jKPpNyoNMrW1hTyCDRWriWzvvHBidunOZfxXsYX4EpScElBd6
	CWxOdT445z7cz6NaXJ7tMNhcgMpJJHXsY0LL2wxvXW/5RKdHqtUqLrG1BquFdw03
	iEfftDnx/92CsZMudse3feCnXVI8dDlITb+BcGvZRPB5cbS0r0fIa2TpA1WlvLX9
	IDjfXA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp7b6rj2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 10:28:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c536c9d2f7so1899385a.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 02:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768386502; x=1768991302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2rUIWP734jgyS7kfTHkz2k68tE+yGXTA1ZKqPQH6og=;
        b=LJAHklZWs8jmKxAxN233zesN+nxbeA5DORiXTA2x++5bJ/4COzWqMSLCxl9fAh13DR
         YPVk1aRkXxMS7l4sTcGU9dk0/g4u7NsWCqGVZlrtBuf5evgBvXZKTYpB4B67w5CWz59N
         4v4R4sjGks9ks141s2+kwJU6dsDe+MkBOLlcUB0rtcrQ3m+qhuRPl1naTq9Z9xrtaZZz
         /96Ga6Q+1io/v+a1Cosfleyz8GUJ38bXJ2pZrtx0psDxx2B137NZ2uOiSycS+eN2IinC
         ScEqyScklGOvlIIoQwxHmajepLiKXTSQirpOvFiXORZGo1/+VjF/6TyEFPkUsqCy6GWc
         HlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768386502; x=1768991302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2rUIWP734jgyS7kfTHkz2k68tE+yGXTA1ZKqPQH6og=;
        b=PhPctJ5VeJm0M3lbIjh1iSMYSK4SLUgkKo3Rtjtb2DRVjA7bjjUVsjyNW5VToXbH1S
         ps5NpCjQZ8OrYm5Z3KtIBr9dm9yiquzd9zP/7SOZ/ltyN6l6vt2YmBR9Y/Y6tl/iUJaw
         hD+cpbBKUtLX5B25TfZGUq1ObXRtSTx8y5PalF45M2xU5RGsAAe3lgV1YO2olpVx0Bnm
         w8aAH5hENY5n9NzVk/Ag4Z2V3uG3MyBu+tJo6TqDKHGM69hmQLJIWNNZ12OANRtw4Crn
         8zc1jcsQSQBKMTADm5621TJVVliR+zUuMXyQUNAu4NI7yXd2Olz+0YQigvr9NHcTl4WS
         2JXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzMchUjlJoXC3ruZtdf089shhsealhRLgB07sZej4gkw+AYC+1GV6Ezisahv2g64VEayKcPL48aQv86Vp5wG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mliL/awCF9llJ0jpuWwrjskaT2ohmWplDzkeMCEpCFxfO4oJ
	JuDWAKy2t3LnBdxRX3+UX6GggU/9FlSKsaabtRTGmWisXinGJFDN3vQo9YYbcUSagmrB0Ri3eok
	dRZ6DTYbNSs+d1WPW90jMTYfPu+bLb+Nw9YdzDwm0MA4BhgrLTdlsG/p1Yz4SQmm9mXPx2MY=
X-Gm-Gg: AY/fxX6IG9ABL6wbuX6RX6wSJvpwPfDPOiAWuzss78/B9hXRdhCl/AAMOxOYmQPKCIN
	Kozl0Hlu4dm67iAN0H04gyQswJYvIU1QycX13gSyz/3GllSbQG1/gI9yna6AThCUG6RGgrHLz1b
	be4DQKLAgr6p2U2EmjUJQ5oXaXZhQJCogFO+ujD+u58/tmdXwPmVQz8+E8qwC1QLAodfS4ANEZo
	xgqOLORpqnuiq/+TAHpWm2DIt9xHqW14Hmy6Wrc1kOHiefzx4ugzNlf5ZwKX8URxWHXpMID4vgS
	JSapYQvAxY8Npfbf1AmOVzKtLv3a69PPRp7URvEmA3oFdSA9qqz9Om9d21e7oeqA7oR1zHGKG7m
	WaoOu9L6YZGyWeEBnIwJSAnl2KSkoAqsCW+TaKKR+0LaGRvMxOBr0iMa8axwTh3L8vuU=
X-Received: by 2002:a05:620a:2945:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8c52fafd3d0mr237609685a.1.1768386502245;
        Wed, 14 Jan 2026 02:28:22 -0800 (PST)
X-Received: by 2002:a05:620a:2945:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8c52fafd3d0mr237607585a.1.1768386501828;
        Wed, 14 Jan 2026 02:28:21 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm1275650366b.31.2026.01.14.02.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 02:28:21 -0800 (PST)
Message-ID: <ff4d697c-2007-4b2a-b66b-dc86053a20a6@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 11:28:18 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <723357fc-a785-45d6-8d49-4c00dd4f340c@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oHrFyxXzSEFndpxNSfO-g9E1zpIQ8NQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA4NSBTYWx0ZWRfX0f+qrLpopB5T
 Mc2zKPRQDJuW0l4RN8q73T9qAUlyFXb6uCybhXUJsNopGtAJrcmustzCEzN0F26N4823TgnzP09
 rmPCdrvhHymD4WkBUo5F28lNFqtC+fa15mnP8lDu50lzDRYQSdQ7Wj01yysbJtFKGNQqVjNZW45
 TM9nSS/A83AoL+kbL/KkAivWeHW/pOcjTMlP1f5WXhQqpl2v04DHWhSdihxpZ6ZXsdkYkikeDQx
 9LgnR0xhgMpAW4wfvbFB81AX7ZTHgYH/eVfQwXMeiK64buyA95QEK1rW+2gzoPq7AJO70tR5eDv
 PpwRYNAGTKakF/Ml9ElMYHzh4ZUgVvQGpAhjv0Eil6exKoKIhgfOngR3pN9yEavqn9qmcyQnIML
 Gfwph1wx1/3To0PShYQRqIIbhTfAnf9F9SQxHtRMk5ueR3EiX0i1GYdiUtSmKezNfxaL5f4wmlQ
 sDkhG+ta4OooseTlY0w==
X-Authority-Analysis: v=2.4 cv=W+w1lBWk c=1 sm=1 tr=0 ts=69676fc6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=za1BG0YIFsB6r-OV5FEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: oHrFyxXzSEFndpxNSfO-g9E1zpIQ8NQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140085

On 1/14/26 11:15 AM, David Heidelberg wrote:
> On 12/01/2026 21:13, BarnabÃ¡s CzÃ©mÃ¡n wrote:
>> The device was crashing on high memory load because the reserved memory
>> ranges was wrongly defined. Correct the ranges for avoid the crashes.
>> Change the ramoops memory range to match with the values from the recovery
>> to be able to get the results from the device.
>>
>> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---

[...]

> Hello!
> 
> I suggest one more nice to have improvement:
> 
> you could label framebuffer cont_splash_mem since you already touching the node and testing the series.
> 
> Then in additional commit, you can replace manually defined `reg` in chosen > framebuffer node with
> 
> memory-region = <&cont_splash_mem>;
> 
> For example you can look at sdm845-oneplus-common.dtsi
> 
> Tell me what u think

If you wanna do that, please call it framebuffer_mem, "cont_splash" is a
Qualcomm-specific name for (roughly) flicker-free bootup

Konrad
