Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F53366560
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294427; cv=none; b=E0ndvr3QPxWKlsz83IqE3tVz8As3nCzqI08ZQHYV0x3RPoBSikhlIpr+wjJcEZdQ3uU0MuS8KsacVgNZpp9veSk/0Un8vx6tX28Qoa3/IIxbPQWqjallpgdUQaigHP9aVgCNfROoPfeEb+Gane954t5Ci8b+4RCQD1/7NFNK9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294427; c=relaxed/simple;
	bh=cv7hnS+ut8vOX95nWjWi3gXGn42xQsRCogx9/q2/IGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txCt/d/iBOgKETnB3O11mv7BoP8i/haguoqsLVJQfiqZJMRNrPXqBON15RpfVtcpeyBTPuu3XuDKsSTNAnbD1ClbHC3fSedWrlX1Qo6CMutskhXKNURZbU1cwMhwHquhW51uzI3AOCZ/ei0efkwXniAjkNTjSev3HZGNHcn9B4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLWgXxEm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hxh2qrEe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLWgXxEm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hxh2qrEe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7fDLB1934912
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Psi7qEvREtLaJczZVKXOsv3Qvf7qSf/aYTMPnrtk5zo=; b=DLWgXxEmEPUKCfNB
	yg9bLLX50/mZivp9InHL5nStiKptoxJcutUo7HNHga9C/gOdBHBNfPVbek3aIOgH
	CAiBpo0dzb3kNvGHkhOpVakLHNLwrv8KaeTi5d1K5mCqKll7ImLScJ1Jdxhg0DZl
	w3daP3l7TmXcDnGY9uwWsFWD6RvXTqy7zZVeqy3rl1Jb2DClEjk2L5zITsmmt4U0
	ArdqJTMsXEb+86+JOeKNi53YzpNXSLEqKN+AZDYqSOdQ46Ul3SFb7r2kYawktSN3
	h0Z+noFJvi+4wk7BzjWGaztKEsP7tZ9SlIeWrGP+ZJAzmHtfK7lMQ+mIpYtyIahw
	Ij1HIA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6cnj6nx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 08:53:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1aba09639so19756141cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 00:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768294423; x=1768899223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Psi7qEvREtLaJczZVKXOsv3Qvf7qSf/aYTMPnrtk5zo=;
        b=Hxh2qrEeEMs7GY16HH4UJFjR3YWOms4VjOh/ri8ODrNAGUqzBi+O2g0b100Vb96Jx3
         qrBSCWoKnTpS6XntwzbXvXTlkMzarXaJ84a9MZCVYj3Q+CSvEvz/hjQIWu25P2EKtNb0
         6vEJlcAcCGHSZE6jMDRCO2N9eE73i6rKsexRPzoMdTtVE4fuBU/7R/JoBkfHcSfqjKna
         lVqvJtKNHvPZP5LfEndF/6rtIltu8p73M/THUcVDCoBT5LUWcXeVsaDefQMgbuY7daI0
         kMdv9qibYf9ZOzVNS3URW9jrswpFhtmZm4Ohqo3EFjtqdbQHL+hte5jRu8/Sq6P9F3Gz
         oVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768294423; x=1768899223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Psi7qEvREtLaJczZVKXOsv3Qvf7qSf/aYTMPnrtk5zo=;
        b=HAxEH2lNkaMw+E/M8dUz6ywdV6/JyttneO4zEUsv9t8791LBFkWx1eMzUI0WZ3J250
         fckZCaJ4b0U6cZ7Tr6Q0FwduKaeNQLkpAagyipdzsEb2zKedkY3ZUTK+LVsC6KpfrE43
         Gavqbb7fVuceGTzv5tp7r8q3Led/ZpB22Tii2ma7tzJhi8OVzYXjUAYrNHmt77p44C+h
         82FZiid9ObbJCFSJrsJsJsUUH9NcgelPk7X+qCoc3Bgv5VzxZCaFpW0LT17GbXfArdCq
         GoigkzZzzYlSc1HKDj3GJYPx5chTF/wRMDeyBpbmHMuvnzswlsXdqn8C8x/KmYCvijvz
         DkpA==
X-Forwarded-Encrypted: i=1; AJvYcCVtPQLM8vbli9E8TfSjCKliTKP1/7FcJCkq+n5qtP6alVkzKkFa5b/e+sMKmn2ZHUQXW5caRPORHn0B4Ynq9Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVHr1PeRoroRPYDrJx0yBmMbIA94mstoEHrft1kS1s7EqcXVj
	tiWPpzuBPwr7L3Yvy1YvETaavhcLBkRp/+YtAIPOki2OK258hrYE+pW+66evvliSFUIhH77lwVR
	grOi4Oq0TwaJWLM5QVdRHm7MR9mgB1wlGkasjl5CMwLyiZZ3vTnu4zkxA8/1YC1hjvSDcDgo=
X-Gm-Gg: AY/fxX5Sv+DH/vWNHb1zajIwbBkCVEIH7PDRDtMudG6mAq7olBjyJgn4e2AQFNc1ygH
	VdI5Ug/QGW4z3EekmGD4KAlcoxYbijaV2F2Ux31ab4WKzoRNh4lqjnVo2spDzbSxUcY7p7/CHEM
	edgq/sguiH3uoTLoW6mEX09B8LWX4Au+cvjK3DsGC1kachxbh/bqKGyQ8griI5DPjRMVfAEffh3
	EjzFiOKeLGxcIeSK+2+BRKUN/jPwy+UPoCJq9+WZj7Eo4bciBAS/dTtsBQhaAM3NI87nN8TxJGQ
	myaaQRL+bFcNaGwCK/HbexW5PtAFUI/2OeZ8pk6tV3VfuCpzNydeHsCTZOSTsczPULdbEoXp2IO
	eMTnQc9qMFFPqfnGoCGUppdSTX8m6Xp1qS7zxJkW+mHTULvaV0hJsMhhV9UNRkM6wow0=
X-Received: by 2002:a05:622a:211:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4ffb47cfe1amr231915381cf.2.1768294422952;
        Tue, 13 Jan 2026 00:53:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSQe90rpoUq/AXRxsY/4nRMXlotKUzchkhtZgMqGYLkUq6f0eDYLcR2EofKxgr7vGuSq+P4g==
X-Received: by 2002:a05:622a:211:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4ffb47cfe1amr231915251cf.2.1768294422543;
        Tue, 13 Jan 2026 00:53:42 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d51basm19593087a12.12.2026.01.13.00.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:53:42 -0800 (PST)
Message-ID: <233f73de-b247-4b22-a079-5bd3f5ece5cd@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 09:53:39 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Correct
 reserved memory ranges
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
 <20260112-xiaomi-willow-v1-2-8e4476897638@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112-xiaomi-willow-v1-2-8e4476897638@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DfVIqaBBPwmcVyC2YysS2j0an4hxYRr6
X-Authority-Analysis: v=2.4 cv=KK5XzVFo c=1 sm=1 tr=0 ts=69660817 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=D8lG2y3kz9upFi25nxsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: DfVIqaBBPwmcVyC2YysS2j0an4hxYRr6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3NCBTYWx0ZWRfX6lIAB/tdORPe
 QPTksPt2+eJVoBYo4UhYDSLAUiD97guCPnhWQlwuRx0A0vmlqezZTwxPorNKfqLSl5H/S52RObt
 3bH7CRMriSnOX9/ziJXNPnnFdqj1pG/kv/PMpRhqIZu94Fcj0uZ2uneXlEDn1LjHmChgN/7+bAA
 nGv/EywFfg+6OkPlbYZtrKNgPqSSk0TbT+HedoECuzRDknfTkRmVhTA8svZ//oWBfvB9Z8JTw9C
 0X6q4ld9n6elK4aUHp1LLKO4zWgPVD30o4RNda+Ekd2ABayWTqk2xjcZHHjHPdUuPuaOTKp0WSA
 JwpGuNtT4bh6jtqWH1WYj+dsy6ZoMfg0eoAwgDGCcIKDFbUqCa3zkbUB3VCiUKuRhT7csKIRNDH
 /E4Q5Zwor1BeXenxtkOyd98aRxGSnZ/uVQuk3gP1gluTEIU/6i8fpI1xSGOnEQ0+b8Lg2JjV7qv
 ve1H2KLUTvoiNmnlUbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130074

On 1/12/26 9:13 PM, Barnabás Czémán wrote:
> The device was crashing on high memory load because the reserved memory
> ranges was wrongly defined. Correct the ranges for avoid the crashes.
> Change the ramoops memory range to match with the values from the recovery
> to be able to get the results from the device.
> 
> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts | 44 ++++++++++++++++-------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> index bf03226a6f85..4c548cb5f253 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> @@ -13,6 +13,12 @@
>  #include "sm6125.dtsi"
>  #include "pm6125.dtsi"
>  
> +/delete-node/ &adsp_pil_mem;
> +/delete-node/ &cont_splash_mem;
> +/delete-node/ &gpu_mem;
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &ipa_gsi_mem;
> +
>  / {
>  	model = "Xiaomi Redmi Note 8";
>  	compatible = "xiaomi,ginkgo", "qcom,sm6125";
> @@ -36,28 +42,42 @@ framebuffer0: framebuffer@5c000000 {
>  	};
>  
>  	reserved-memory {
> -		debug_mem: debug@ffb00000 {
> -			reg = <0x0 0xffb00000 0x0 0xc0000>;
> +		adsp_pil_mem: adsp_pil_mem@55300000 {
> +			reg = <0x0 0x55300000 0x0 0x2200000>;
>  			no-map;
>  		};
>  
> -		last_log_mem: lastlog@ffbc0000 {
> -			reg = <0x0 0xffbc0000 0x0 0x80000>;
> +		ipa_fw_mem: ipa_fw_mem@57500000 {
> +			reg = <0x0 0x57500000 0x0 0x10000>;
>  			no-map;
>  		};
>  
> -		pstore_mem: ramoops@ffc00000 {
> -			compatible = "ramoops";
> -			reg = <0x0 0xffc40000 0x0 0xc0000>;
> -			record-size = <0x1000>;
> -			console-size = <0x40000>;
> -			pmsg-size = <0x20000>;
> +		ipa_gsi_mem: ipa_gsi_mem@57510000 {
> +			reg = <0x0 0x57510000 0x0 0x5000>;
> +			no-map;
>  		};
>  
> -		cmdline_mem: memory@ffd00000 {
> -			reg = <0x0 0xffd40000 0x0 0x1000>;
> +		gpu_mem: gpu_mem@57515000 {
> +			reg = <0x0 0x57515000 0x0 0x2000>;
>  			no-map;
>  		};
> +
> +		framebuffer@5c000000 {
> +			reg = <0x0 0x5c000000 0x0 (2340 * 1080 * 4)>;
> +			no-map;
> +		};
> +
> +		/*
> +		 * Matching with recovery values
> +		 * to be able to get the results.
> +		 */

/* This is an unnecessarily
 * squashed comment that could
 * easily go into a single line
 */


> +		ramoops@61600000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x61600000 0x0 0x400000>;
> +			record-size = <0x80000>;
> +			pmsg-size = <0x200000>;
> +			console-size = <0x100000>;

Does your recovery image not specify ecc-size?

In my past experience, that led to much better results wrt the data
being actually readable.. you might want to rebuild your recovery (or
at least the dt and repack the boot.img) for that

Konrad
