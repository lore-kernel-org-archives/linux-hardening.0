Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3023815DB
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294932; cv=none; b=cG3POHMIw7leFt2sXP30J85WDEwdb5zPUbnoHW1cWAi+g53rQOFQVSikdMqJEIdyPDNMrkm4gDx7dV8i5ashzejfqfOyX+xvwABshkwZ5BbfvlRGfKdpW2WJ88W9Tyd/AQ1RCdkFllXpQ6ZKL1a5VG+kcKgOStgCCXhn6HnmF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294932; c=relaxed/simple;
	bh=E/rHAaELYlivdofu5n6KJxhOc3XRDcBNMHgQOTIvEb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmp8K6KAXI9BC9NBy1UHqyeoUX6tnTEV+SPc7kfe5T33MntrAYc7cWWq7tIUkEivNkRpaD4yyslOZ1Ia9gaa/fYDh5sb2PbB+VGufta3cisMOjoJTpTrWJFJHhp7a7ILbX5lXNZZkqyOSmLK2Ht3g2jKOSx6li0H6Tb0u1P3fgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nWVpAVnm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G59eD3mv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nWVpAVnm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G59eD3mv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D59QZL2835888
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 09:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GPT96PTGUv2d3VCwf4G28uAn4AI03K7pwV8OBWcEcrc=; b=nWVpAVnmbiBS5McH
	6KWxNlk8DbudJmoh7D3MH6Ixd0uJBZAUaawZIkcaqNVwAy2aTDM/QZdAgUBG2fHJ
	YYB7OedkXlsNPpjgv6g0WG2fBbnlyLDTkkxRpcw7IC1LGV3cyRdkZVM9Vj2vzqXo
	5hXqOo/2zexGOF2DXPuIg66qjKOw47UZadbVgfMrsRnz5ZE8LEOC5WgE5bukb9Ki
	BiEOlL6i7FlR0tSK/vK6CnhS1W3w86tPrfTLIyp57nstXf1tven3CJuX6znKSvjw
	MBvBWdpU02Kvbk697MA7DyTTNIHTQXSncu3Q8Ma/oSijFwYVV13BYvHDlKSBaU88
	TmI2Jw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnfn9rmwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 09:02:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2fdf3a190so137453885a.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 01:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768294923; x=1768899723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPT96PTGUv2d3VCwf4G28uAn4AI03K7pwV8OBWcEcrc=;
        b=G59eD3mvPyOkG2avGdcn/RTrI3VrcWWOpiwkj0kxorxUbC7Dmzyy417eUuxlxjYATX
         +3xPFBjgx7O/uCWk50kdCY4I1fsY7NyyucXdmUViHajydIOOZEioJhHBPrUdH4gvfpKj
         2+sPqnFh5F0tpP9CFn2YWT+ti3yHG6/H7np9vRUxaWtRnKg3dGZnTxYUPeSvb2VuFRrD
         mwY8ECdMuuAkCcYFZ1ewrbFIaucafxgGigdfIAMCHCo6w9T7GpD71kZ+uGnTB9vUhtxr
         tPfHAFIYUmBbwRZjgGYT/o2p9pc/KEIUDxdSXVdZMnXt9VKmYtbYfk9JyFSmi+dOos7y
         SH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768294923; x=1768899723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPT96PTGUv2d3VCwf4G28uAn4AI03K7pwV8OBWcEcrc=;
        b=CV/Jmem72EUjozkfPwJlyKlILwmqEAMipyIY+5qd2oCSsbSqBFu9zP0vb1g6jRd4g/
         MgXCAtUVFbQitgrYlrmK7rDHmZtJpqEQ0AkFRYH+Qsw/Ig3s59nydtxP2ylrM7s6ObKL
         ZyDyKx1Ol3uaIJRyglIoKeewcnpSJY4WcWBNvvMKB0E6iha476ivk+sXIP/beW2MjfG+
         0X8rTiuSySBbhKtWTWz0qfNgOscOLnW8dtuljL9VTESas1R/B5cx7IyKYgzmzJZLa1Sa
         NxVtAvUeN+nBhltB3TapL9HRG1hAeiIffxZUsCeZJ/+WpZ6QFQFwjYXI7XoiIzc3A6DA
         7zig==
X-Forwarded-Encrypted: i=1; AJvYcCW05KQVf2xQPue0utLdyaWxfcTv6kryQTXcjNhAolj3JPwCeHJLb2pc1VvFDtEWTrtYBsKKzQtIzFSp5WGf2tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0IZ0DkIsCeRC8CdNfDIC/dcxKx5JTXsoRIXmBhAxKhJy36K4
	IjS+91DE/fg7kDgvLO1Ms0soxMZmpTMQHA9/5pdk40P7xjJl5vLWmcujU2Wp1GUpt4pJx9a9i2x
	phZ1osHVLwBAkAUvT1T1kfOxLF6F9AGdpyOUkgoyyiDxypKldpUqk9yJ/kRLdY1soR3fdV70=
X-Gm-Gg: AY/fxX6GdNK4z5YX3MPcduuLRvJ7A4bnXj3uqQ7YjhO/xIGUEAmdiQ8vKOYdYCmoZ5d
	UJH5n2MGb1B7fM++Bvf5xHjscyYH+339GYs6S2vpg53+oJjdya5qh/uY5hQV5JqpBld5xvYQK4e
	WzIpte6BasgLj8Nm7IaTHxA/Q6MduGzmklQikXA9r7EfHNRXFc+pUGBZjSzVn65yWAKzL1+wL1C
	UAjON5c4VnxUk1gODEdSMVinESyK8CT+TTGpRAj2IvnoPTztVJG3coWocBi89pFG/ySmIfFRxZ6
	LAgh4ikrlzCauH7YJ6IonvyR81lyirWtOJXsHR0ECZAyJiVbInH9PkHu5y+onbTuRYp/w5f/uI/
	DcLfIuuO2dxB889suZfdOR87W5oHwTtMriw8brMLRBAweAX0soDg2E0sl0Y9pZWjp2sc=
X-Received: by 2002:a05:620a:4086:b0:8a3:9d53:e1e5 with SMTP id af79cd13be357-8c3891d3180mr2156777985a.0.1768294923377;
        Tue, 13 Jan 2026 01:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFULj+4gsDIhecmRQEo0sCnejhnBMw9iTjvTptjSk6XDSfCyRFrWMa5xhAnDNPYWfQ/IFWnyQ==
X-Received: by 2002:a05:620a:4086:b0:8a3:9d53:e1e5 with SMTP id af79cd13be357-8c3891d3180mr2156773685a.0.1768294922810;
        Tue, 13 Jan 2026 01:02:02 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870776b642sm748875566b.21.2026.01.13.01.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 01:02:02 -0800 (PST)
Message-ID: <11ee77c1-2ea6-4c7c-b955-22f10d879ad7@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 10:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix reserved
 gpio ranges
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
 <20260112-xiaomi-willow-v1-4-8e4476897638@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112-xiaomi-willow-v1-4-8e4476897638@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DCsm3bXIaugbeLmO4q5Duv0Qv-UJ2pHV
X-Proofpoint-ORIG-GUID: DCsm3bXIaugbeLmO4q5Duv0Qv-UJ2pHV
X-Authority-Analysis: v=2.4 cv=HN/O14tv c=1 sm=1 tr=0 ts=69660a0c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=tUk71-pQmeoK5jN-DnkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3NCBTYWx0ZWRfX4CY+hlDNxk5X
 JKa0uoNIkooCXK8c11usA4b36aQoo0nDnqD8bKGrFvrwNho2rXPhqdvPAbPjc6bN4QfYozJG/if
 7Mqm5as/2pegpqPUYrcrL8J6dDIFiqEmThvRsVT+Ehb0FM9vhWgUooXMhzvA23chvMxHLiKLOgN
 s9HvN2KtI6bqQE8iYJiaO+R9Lc+HxHag8/n3y04K6+ba/lwR/krh6RcychoW8NwFHt5e3ZbcACv
 qYl+wcqzt6ywLZr+93JMfJYKcd6BmF59LN6kSDoCw6MUsw6oYNxUanIXC55+VhJb7LcILS447CV
 l8caGFA2ED5Y2IMK9uEHCOnktCIhyCz8e3mClUrS1N8rQCT/gsxhdi9u42jGcgypzhyVQh/EnrR
 kkgaEX8b21SdfH3dKVIvBUOlyvP8lXh5UXb2cqnLFY08s3R4ct9eLmMFhvxAd7+NI2rcNjsEFot
 kmXaZfHPNvyfVC3kkvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130074

On 1/12/26 9:13 PM, Barnabás Czémán wrote:
> The device was crashing on boot because the reserved gpio ranges
> was wrongly defined. Correct the ranges for avoid pinctrl crashing.
> 
> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

That's odd.. were you able to confirm that these values are alright for
both the Note 8 and the 8T? 

>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> index 666daf4a9fdd..163ecdc7fd6c 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> @@ -296,7 +296,7 @@ &sdhc_2 {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <22 2>, <28 6>;
> +	gpio-reserved-ranges = <0 4>, <30 4>;

Any chance you know/could deduce what they're connected to and describe
it, like in x1-crd.dtsi?

Konrad
