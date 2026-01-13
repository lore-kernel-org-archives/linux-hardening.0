Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46A3806AF
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294354; cv=none; b=B6Ol2AHjRS0lXRVkNdly1mXkEfZuICGvc4pBe2KIv8WjvYinbyKp950kpQdbXSgTCRi7DlCqQhHmFRIfVmwGjEhzdg/wDdS6S/wbxcyPKdN3qB0xihEkX3qrvANxbCxv3yYbNR4L/4FmbFHRDLcARiZR4ZrYCAy9xPc9U1nAeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294354; c=relaxed/simple;
	bh=MYVpvlzSOVjOCvsPeYESexAjv7dAT3KEzdLpa0xc2IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1e9dVua29kbnvdE0Wm5cOTnUdC+yFM3wQ4jIXLYd7pAESKWe7TcCcrHRGlKYiAtAXiBQF0WcBrdp1xzBVSc8umlL7NQH6ZLsiEP32Gd6xmqsD2HVrrvq/kf0r4pX9HiKIL+biar3AVOQAzHaI0PICgUsWeAXQhTAG1irA6t1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jGbyjE/n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kc5YUaMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGbyjE/n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kc5YUaMR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1tenr2751751
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	akSlLBvxW6+m4cNwEhhn8aCcDRvgKbnoX5vi2x8CPOs=; b=jGbyjE/nyE4cMI+G
	8+ZcKc3q19HIGMt7pNWhzN8Z1wILioluZDk4+YrzgFlf6byeJ/iz5OTfDB+frLmZ
	SE7fh4JC3Iw7wSXpIPahyy+5V9wzkKi39CWTPQMLZ9BalLDGt9w3qPdmN9MzmN3K
	70bp/cI5Q3Pm5hmQx/3ZPzC3JIYFbpcHLRy4il6ae0owMWNcjkD4ZoyEeHUS4SEN
	485FBV0jeGMQ9uaVcyxQiWGKRRMrnBEtnhSGVAiDevehBHPo4l/94rhPMT1pdqUG
	V4xuYBqqTeqU8hdT4YluvXJviJaiD/ns7gmJIARPdOrVxUT0/7sF8ur1sISgHEgP
	IAVkcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnctjs2vr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:52:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2ea2b51cfso166415285a.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 00:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768294351; x=1768899151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akSlLBvxW6+m4cNwEhhn8aCcDRvgKbnoX5vi2x8CPOs=;
        b=kc5YUaMRuPM0+Xg1hYPyX/v6L4jCHcl0N0lg0/HcTvH9f9Qc+Bc3sjBHFqPa9lwtCZ
         elZIpZt25jyVLT/TV9UixFiw97IXYxsWUsRHpZYI/TKo9S6qz4PFHM2TQVF6Q6GfHM5Q
         LrwwrY0b0O/NohJb6jfUqcZuUVONgaw1KK0YWq//9SVCk3JFm9W3tLI5GhY+dxXbAowf
         +xjc+HulVjaz8cs7o9Bvl0oHDq1lVDTfTJwrDRGrYkC1rUmkT2tC9b6cnbbowgw4axbo
         xfz3O+5lfZxFqOq+M0GJE21PvuGOQXsoE3RJXQxHplx28yKi0Pdg3SY4VXU5+g2oQI6G
         0srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768294351; x=1768899151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akSlLBvxW6+m4cNwEhhn8aCcDRvgKbnoX5vi2x8CPOs=;
        b=Cm1urTUJM/hINBNlRjo0qdg/QmmW7mTy7U1v3CEhCMAVCX8XDZ8DkXglyLNd6PBR6f
         V8XzsrqhTCsbEhAm83TpP/NOKpEv9sEMIYliugWJH6K2iFBH3ClRafqxiZvUDOfepCQ6
         GPNKXwLHmeyQEI+09ham110d3CJLViy2rw7nPigQ54Imu7gcA6Delaj0Gv9R34gOBsyF
         1oMmZn8Qb+6RVQBF4uMvEohBDmLBNLiw8s8yP65PxVznffs61jlbvNCanvI9qMIhsDLY
         oOEuhXqIIrcLnTumoEqMhk8PRHPLCdyamUPM/gHyfnlije5ogyXgY1fXiZo/lW0zkoQD
         61BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEJa/AnTuXgeb0r2ZkFwCR3iE5x9imQ8E3WaETu+hvDI9csS1ws8UwC6VRw9lGZ6j+U/08JxTYXKwnI46KGGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7Gj8lVY1YDCEIGzQyry3yZFcqeOavK4bAkgYDBfRkh3OrafV
	kzDQavhGEueteeke2MngToKcRmqjz/+GDdlz2GVHJnoFeQ2/9A0ixB866GoY9Aj4AZk+C16Wmyr
	hS5AWOQOcxDZ8vIeRIz0pe09xXmDVdAFyCAqo+bLNUD7LRc0+e71rWmAmsmh8dW0LX1I9Olc=
X-Gm-Gg: AY/fxX7qE220/xHkscz0F8KDHanVv8/MGhHriczqfPGmxTUGStGn4wTRAe5FXT7P2pv
	ULuJCWUJINMNGIN6PBL4WY0qxrC5+qd5tN0s8qNgUA4xxZfwcZfFv5n0dcvjwvOSK51Sm1SMzqM
	zbtxXHuiMF0aznfoyIAoS32AVfsJ0S7ZvTVYhaCfkg7XXftKWCzX43aQHnNXnXfN/zsTf2cu9Dk
	+36SkrH9X0/w7Cg14eNa3x6ihXyr/tavVPSpiLhshh6SqCsK5gLhV/g/yxe4Vs7snXX3nKR5AwV
	Q9inFbcZG/F0yKVciq5SHLD8ILye6HhnP9S/dstKAwK6MsN6/zS2xL4eRut8OyoF22nqUMQHl20
	EoEUPG4X2rpMfz04JYX7Dk3tL/6Q4jpNAOumPjPk4pVOhmIwaJAMiuY6isCiAeBjwTpg=
X-Received: by 2002:a05:620a:f0f:b0:8a4:8825:bc6c with SMTP id af79cd13be357-8c38938b477mr1976257785a.4.1768294350729;
        Tue, 13 Jan 2026 00:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe3HcVWbu4Z4k8wHtyc1vE5rWOAggNipetl5IuElZ4I9M3hRUy+qBAyoWR8QocyXaFxxBFIg==
X-Received: by 2002:a05:620a:f0f:b0:8a4:8825:bc6c with SMTP id af79cd13be357-8c38938b477mr1976256285a.4.1768294350310;
        Tue, 13 Jan 2026 00:52:30 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d683sm19788252a12.34.2026.01.13.00.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:52:29 -0800 (PST)
Message-ID: <69ddd3c3-e3a9-4dab-9c0a-4d5cb3763a5c@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 09:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix msm-id
 and remove board-id
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
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
 <20260112-xiaomi-willow-v1-1-8e4476897638@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112-xiaomi-willow-v1-1-8e4476897638@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3NCBTYWx0ZWRfXxhdRq2okzfST
 nk7XpCGRPXufSuJq1cU4i8v1OHVLO2QHNJTVqUErpeL6h4xvzi3jJbpQfe82FBgvqFXPaNSz1U0
 TgZkwrQ4f94k71RdwGEa5cOeRdUB0Ngl1mA4uFc+OCFGzsosNew0A4UrR6p9eB4SOuwsOl1f4l/
 H4e+wBjGNpWDO6qfPEeHdU3DkQa3FhtTf26hS74ji/Ear+MtWnPucv1882yk9ymn9/4LSUH1zFS
 mBqqutlh5xJgWoOLUYFP/33ES1APREaEzudtIgJkc8zxuhFa5nYV21TuTlFJLDExsYsKM1hejck
 Yna0XKYalc2QC8tu6ijqDcQNyHy/oFR/5FEMDzfaqV6AsO3Jpj13cBjYa8Hok7ewkebEvEYCAGB
 /tRntquixvuV/a4glCA+HzAHS6JO8C6MO1VuiZC8JJLUVsDv+gTwSjC8Yml3x7dzfsGue1aJmCG
 OwHN+PGvLdPKDKei/nQ==
X-Authority-Analysis: v=2.4 cv=Ls2fC3dc c=1 sm=1 tr=0 ts=696607cf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=4Ix3DnIw-zF4zot3V68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: t_AVK5m9TLKnNVa72SnxhMRflUBURotT
X-Proofpoint-GUID: t_AVK5m9TLKnNVa72SnxhMRflUBURotT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130074

On 1/12/26 9:13 PM, Barnabás Czémán wrote:
> Correct msm-id what should contain the version 0x10000 and remove
> board-id it is not necessary for the bootloader.
> 
> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

