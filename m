Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DF3A9602
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999603; cv=none; b=Xm3K/VapNr4fjpMGag2vcDgnCUPxozu6v96+KLISBQs7VYVdUn4PLTFIhyh5LFvQXQ95NuCKD1VIloCE8WyOZ8SxA8PoEVXM+jYJfUwOqhqEeuuNZbp/spDWZiQA5BI8ZGelhBEdsZRHpAGKOHI5OxyWfLTpVVE/UxrRShkrM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999603; c=relaxed/simple;
	bh=kcWVg8RyE5oaA4SLks1HrECuEVk3YXF8f0EC75DLLAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOSSmX4Pf07yfYDcXXWwgtFbdlRexbDqCPe8HDUFS7rcLe8JNgVOHULQOCmSoHtoyFyiQNp/OCM4xD5l1mfbC4X5/ixFdYWKA0JXRlfRkI5sIRD5TZ58AgfZVn+kkeHD74NYIxS6X0UYDXO/esFfDZeM5WW6hK4tOW+0oGifqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BhTDJAQT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KaqPsMg5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhTDJAQT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KaqPsMg5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LAEHBm3229089
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CuuE63FU7lC5Rz3dqZ/OCsZHThjFOq/fH50DC8Jq1ps=; b=BhTDJAQTCyVn/CuP
	0reyujoIRLNZ9c3K/8tACGFP2/kvpxlxlRQh0ug6r48dhlFLzzWn8O6A3TVnA72W
	oaQm+Z2vKQcpZIoMevMEqbGglRD+n4ZYt+Rk73/e/IHlbs0ojRVFOUSfUNJUfO2i
	cTloYxpkMoj9/KpJJLumLVXCb4HJaLwA8GEVtHOhhmIkWAwPJzrS3OsGkwDRcQkI
	VKBYH9BSF1oY1PtfTHBA2shob/Jv/Tm1DGP8ilng7pfgIEjVATJgO8/lQ/xhmD/W
	rZ4olGAGBPR0for2E3VffHTm7VvIgZYLv9vyBa6WBAC3eRys1s3croE1PDLAGHQU
	fW3jcQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqvp9rkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 12:46:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c52d47dfceso123644685a.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 04:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768999600; x=1769604400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuuE63FU7lC5Rz3dqZ/OCsZHThjFOq/fH50DC8Jq1ps=;
        b=KaqPsMg5N0Tb7V6crdBUPPGZBUGR8SyA8w8Au3E0kGM3BhLS4pB/1o4aXLv4mUqX4e
         YlipTQ11Z77EqiSbxmKS7mUoKIpbDttwJCfpVIk805/dCVoVZBI/Qy69gn9Su6aLbLrQ
         N9WP4KC+BwoUO0/vtsKWYDBbYuOolkO7rn5jERBV/XULy/k9iC2IQ0kwGNzpvnNUNH/4
         gw5WE1jUSBOBbXUhE0puOlXYst/7Aqb6IiUf+jZ3jHKn/62vCRIwaPRwoJ3qJ/Ijw2xH
         vYZFDDwsEjXpybUaU+gr3f//Ws2QsdnRJGdojVjltA2zE/Ugi0eKNgpWIegUrmKsp6LM
         FntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999600; x=1769604400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuuE63FU7lC5Rz3dqZ/OCsZHThjFOq/fH50DC8Jq1ps=;
        b=VKY8bjYyjTponSvOJNdKfsPERwSs4lrMGlv2JsdKR88t2RhhaLBILQt70wV3d7xNSq
         +w92tTnltBlzMfic54jhlC4U/kWjsP7qX/r2+4CkALXRFJS0OHk8KBs5FdzxdyJrMpwP
         2VW3EJoOnE39ylfY9a5dtuphJPyx+41ZIza8nujce+UuFlSaOyq0KRi0vydB3g/0pnYM
         Bg1GX/E2viW/k2xPhKYqq6xUARPZgewFPePyZ3mAp8/4+iuSgaMVKEXb2J95vy7eQ1ai
         h3j/YcInxtDhpCBe7YBmXndGxMiY6BT2y/zJCSElZpO8C3wPdkkt5GnJv0ObsZYlyE5H
         RVqg==
X-Forwarded-Encrypted: i=1; AJvYcCXCAhyvRIZAdC9v5s7O2wwCyv/BX2bPseiFFoSp0lvYG3aff8u/zFu6WvgI5sUSNYUATwEtxLVrLQXCLqHWf4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3Ndk50DG0PtxCukaR14rkM/qX3mQ5kkpFUCbxJAUO83hLpaM
	0XALX+c8xhvQyGbfEklwNjfcdaNZn+1zjF/CUiBnRvTZP2fsXfaKUgGhXpr+L91/IUT61S5WM0n
	Qmn+ckLrClEyakBMdol8lH0Z+NXwsdTPnLsTnqJxs31MhB8L94iQDSCCFHhWHWe2LHHEFfWo=
X-Gm-Gg: AZuq6aJgnRxdkzVUSlwQ1Ya4iodi26ncQvX0j99RiNt/T8IWBnFXCk0cWFxSAYaqZ2W
	hLKC4TXCWY3AInarlRkZQET/RNWPW4O2H+5HYlDMLQCRXpgi1sg+pzGG7HSt2+ufZYafeAOY86e
	5xPfG3xOTWmnrsU+xrQNOPrCzXexybOnuPLsJyGd3EX4lZhMa7AL54kaS+EoVLp2/hg57hCCjg7
	y7eYK9m1JMeo1QFTTo9ZR9xLLb4C59KYHjox3sc302irCMywR/4K5S4pcBX6N2TbwF31cA6rJl0
	VJbnQCjF4qyAX/iXC/8anO5TRFbw2fC1Idpbgx117HJgCrI9X0bqXZ+NQ1mJsXCd+Qb4c85DRGt
	n/ikQnbzxrPBh0lgXQEp8IotsL1dtu9fYOEiOjiyzj4swKx1mzkh4iLj83mAI00vWzsk=
X-Received: by 2002:a05:620a:4492:b0:8be:6733:92b1 with SMTP id af79cd13be357-8c6a6606fcamr1768446485a.0.1768999599938;
        Wed, 21 Jan 2026 04:46:39 -0800 (PST)
X-Received: by 2002:a05:620a:4492:b0:8be:6733:92b1 with SMTP id af79cd13be357-8c6a6606fcamr1768444485a.0.1768999599575;
        Wed, 21 Jan 2026 04:46:39 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9f98sm1639061466b.42.2026.01.21.04.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 04:46:39 -0800 (PST)
Message-ID: <4d3db091-ac43-439a-b065-c6b32da65f80@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 13:46:36 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix
 reserved gpio ranges
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
References: <20260116-xiaomi-willow-v2-0-4694feb70cdb@mainlining.org>
 <20260116-xiaomi-willow-v2-5-4694feb70cdb@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260116-xiaomi-willow-v2-5-4694feb70cdb@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rNY0bXdAd4R7fK1gPhjO9mzgIvYbskRq
X-Proofpoint-ORIG-GUID: rNY0bXdAd4R7fK1gPhjO9mzgIvYbskRq
X-Authority-Analysis: v=2.4 cv=cdPfb3DM c=1 sm=1 tr=0 ts=6970cab0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=76ccbOfYyMFIcZEcX7gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwNyBTYWx0ZWRfXwR/MwEM/hn72
 WNwH1fANNjOuHg3Wr04SKjMHfNDuyZu96pXeFa3RsTdfmjF7yTcj9gnHlQt/l8uDMYB6fSYt7Gq
 AR2LN+1MymvnyVBA2/fKScovxWeubVS5lW7+00Kj+W4CNNWFrI7lMyM7hFhapuhENbsx++Fwkf4
 av0zxCSWCxmNwtROOSMAIwskdvHW0O6XpTsGOK7LDcy6f0QYLDdVbKwJwNY4S4DWRaMUa8JEil5
 RAp6dWilfCL45KAUSOK8xNFYW7Kyg+3d6Qoq8KtbOjFb0UB2Iu39gCmdUaYhBbzQp7E3u6/Z3LH
 WU3fd/qDjC4+uRllrit4Hmr28D6EaKt6dnkI8GJ5YBsqSMU5Hk/q20Sfn+sdJRn5V6r7xy00lDV
 c5TiYbio07InWTpRq6MPsOitLBJLJJU0I8mLwYBd6Lx1oqWp+tEvkGTQQ9WQm3Gkmu9qtwhal/X
 4bMlkx158X9TsT+zyjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210107

On 1/16/26 4:54 PM, Barnabás Czémán wrote:
> The device was crashing on boot because the reserved gpio ranges
> was wrongly defined. Correct the ranges for avoid pinctrl crashing.
> 
> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
> Tested-by: Biswapriyo Nath <nathbappai@gmail.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

