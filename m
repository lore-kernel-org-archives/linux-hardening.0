Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D84137A3
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221055; cv=none; b=TCffANyT5yoxT3Gb7jng7WxHnIiMQzLCS3Txc6pjaFykWBUlnTgy96HTt7nrBh7J492kuLNOREjbh1Z45EFm6aS29jlnib9KF877VedmKecO/fYHZeLmLPz8oE652V4TMQKSi/znr6cw9FzYao0SXoNqfsplpG+ruQuS8uJ+IJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221055; c=relaxed/simple;
	bh=Rt4KCNIC0bk4LE3kNjZBDI9ppI6hU368mOP8+6m3pu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv2AHugdMni6zW8lOK0GIx3/7NpLVs3SY4CZqS6aOqbXIc/fCy6f2JIr+tUjTh/0O4Umx3Mvh9VtmmwZJ52lSc4xy9F/2omrnYh+f++dRV+iSvTWJnieoTlYkRqz3JXsHrTDAY9SA66Ny+toDCrBHVGFEQHKMk3FZhrm8VIwnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFv5c1Hi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=esdjtWs8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MFv5c1Hi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="esdjtWs8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8tFdk3515433
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZ8bSWEjaxQsf5haBbDFpLTYwqaPZD3nOYIzf6zf4FU=; b=MFv5c1HisMjCcEdY
	P02LVDO0cNXReYCDtoEh66zz0umjXu6YAhOfS1iHv7HcB/MDQCB4xoWyT0kyvQQH
	ftVk4OU+7LiTlIUl0PUbJKe3HD/UX9JwYfVnvzvmFabV0ZNakNHuefiFshPCGym/
	KuZLqViSjyYpj/usGaTpIchsDsUUnFGa4Qo/tveI4237mNDl0riNDP4mR5rXYziw
	OjF/EXiGeOT8I46bqW6j5XWX+vrENwPT3bJ7RhQA8bNid1tQczoDEZQ2nFJFtt7X
	CBcJcE18VIBaXzl4Rsw8NJQgvX0xWR8uM7t06luSRuxr4yAFP7fdFviA57h44S7Y
	DCNTAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgc8b5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:17:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51e9d892f0dso1405161cf.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787221040; x=1787825840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZ8bSWEjaxQsf5haBbDFpLTYwqaPZD3nOYIzf6zf4FU=;
        b=esdjtWs8ZiBtHoGo/1XzJTxVH/RcLNhIeR/suXgF8eCH0XmUobrQK5zSGisHRXBfsx
         DGgQT86gk1CVqXHRS6bA3dtQCYFC/FO83z9tlTQp+UcUg0kGEx0oRGavFYwNnwojA4QM
         RHigFxRBqxFoRHsanlRmciRNrzBFuSk6+nF6nejO5KnuNYzmW0musWbdn8v+/YeUcEu3
         YtGFYamzf9ZGcZL8dkQMF05BQhBxvxmfIcD1IKOl4CEhRzSUIH1TQV2atobZ3T41h7z2
         EgJyTaKMYXS+P7ijdaFcyRmSIavpeVPqxrU9h9zwDfHXia2AGd9aPR0ppy4bcs0DCU9H
         MyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221040; x=1787825840;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZ8bSWEjaxQsf5haBbDFpLTYwqaPZD3nOYIzf6zf4FU=;
        b=sS3kO7oIbY4InSCw4QWiu6l9XvLcf8tE7sz/r9pw/EYcy6TOzZhz+rVUWgBRlOA4QD
         nIAmAnD43VD5RjMpceis6rHmJv8Rje2P0gdJAvC45vdf3314l66PfkLBNS7jELAUDfoY
         eGhElsYbsdDUlAQJnWxEAYxoOv3r4Fb7L6wQ6abPlfUqyiDsR6ChGTfxYE2pHHVeG3bm
         3UizpiJloFgdSIk/+vFX/z417Eq0pz5iCjw1J9KmWkC/mL9GxSZXILzns5AwwNaSr+p9
         WvN8RNV6lGfgKUWshrpQMQrECnaFCbwifirp5/NTE9ffTXekRt0IEJm2FY7cxRC+M8p1
         PFRA==
X-Forwarded-Encrypted: i=1; AHgh+Rqkp8p9k9TbhALZ2/JkPIkzQTmEkSlkQ0cTaqCSivPbClfTBxDnxAFCieqTSzEuRfJDFwL66NGqXEWFDZTMLIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvjp1qbuJ+jefmoZDdeXcNPmZEO0oTuCbJmMY28wTzFd7bueHM
	99ISZTPVBf/G9hyDZd2mjZgNDypaA79P6iHvSYSoRW0xZjiyjl2Xm4GswNniDw/wfD2y9EoqG1N
	BduvqHXLmJT2JivEMJ9qOfToxLtuW2qtTHisjJ4YgNeVT2n8sqdx9/HVcvlMMpHQLaHPvxko=
X-Gm-Gg: AR+sD12ADgSDlYa25OME1T4LezUWLSbHahG6UEg3gR0XXGBuprjMzAPjd4XKcXJhLIv
	IG7k0Zku5M6spy+NvZfiU3TfjeteMC/3stiJKDXpwDRV9AOTHBioVp3sNqclvK2qAa0fEv6fHPy
	Vo6Khnc81XPYGdlIFmNYxoBvUvn0DAFkMak4djNcR/hPPKQt1Pg/47o0C64zIPUeC/z8p6YAUHA
	cA2YAHRYtWm+p0L1qKpvJELtVREQFaodO9szviObn9c/wShZUGnLgDa0umr5TtB3jPzSRa025mH
	msokeOwjwViTxEZRYQxVjFkCndMHMkw+m10GBJvUnpu6kHJDDabALRHR+8NLNVKC4tgfOKfMYLN
	OzQNyZV/mHBa7chiEMcftMzEG
X-Received: by 2002:a05:622a:130f:b0:51b:f40b:2fa2 with SMTP id d75a77b69052e-52dd574ad4bmr78013251cf.1.1787221040245;
        Thu, 20 Aug 2026 03:17:20 -0700 (PDT)
X-Received: by 2002:a05:622a:130f:b0:51b:f40b:2fa2 with SMTP id d75a77b69052e-52dd574ad4bmr78013001cf.1.1787221039762;
        Thu, 20 Aug 2026 03:17:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c30casm1866261a12.7.2026.08.20.03.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:17:19 -0700 (PDT)
Message-ID: <e16a7122-18c3-4bc5-80c5-1cda458fa2c6@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: Add Motorola One
To: Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
 <20260820-next-patches-v2-3-7130d68183d9@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260820-next-patches-v2-3-7130d68183d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a86d431 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=RkJc_Q4fNhrpPokiRjQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: aKE_nmWwSYAPHtnvxSLgucDsBTV9ICGG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX02IgLHDfRZwO
 xry8ejpfpjvs0b/TgZ1wEb3PjtZcATFlsyMPqFJXEVkT/K+Vjq0l9plfWTXWG/O3ep7GNw6z+G/
 WkQqZUQ5IkRt59DC1izebLLmIS/LzfekgHg6YsCQA+MFZ8WF8DpWigeSknndbZ7NbHdj6SKuCh8
 qvSILWyd9egjiM6FYwheo5RfKdIg6weqtn3rSdFfJ7L7N0/nqkMda5kXOJphuINHrhQvfQ4ERZE
 0zHl17ctsljI/HGSBavVfqojft1RepZOD8Ij3OCve9PoIbwkFgoTN15eysRxYRB1wvDm/M9pqOH
 KkNKnbfYG8yo/Ti7A/vr0v7Y2HETeszb9pdGIS19idaBo5Xh1WwmYP5fG4ffqB/5tTK6cOMzfmA
 vykt/lLCzvvqLh8OKdChTOK8GI2JZRcwuai6MG+lRZT89TuUY99eWQ570KYFPhgv5PmiwtdPC+2
 BLbUfcr0mggHGRIdsmA==
X-Proofpoint-GUID: aKE_nmWwSYAPHtnvxSLgucDsBTV9ICGG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NSBTYWx0ZWRfX+3SJFDPcy6qF
 t3WPjhApqoAR5W4ybfF4zhxWqWeUbpL+hPhVZaXEq45Ftjl/rcpq+HIfO0HTGS0JpbnoKwpDInc
 o2TWBQ6G17FOeoI0eTR3T+1L7w/E+z0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200075

On 8/20/26 11:42 AM, Adam Skladowski wrote:
> Add a devicetree for the Motorola One smartphone, which is based
> on the Jacala/MSM8953 SoC.
> 
> Supported functionality as of this initial submission:
> * I2C peripherals (Touchscreen,NFC)
> * Power Button, Volume Keys
> * Regulators (PM8953)
> * Remoteprocs (ADSP, MPSS, WCNSS)
> * USB
> 
> Device tree also contains supply maps to other subsystems like MDSS
> but due to missing dependencies like panel those are disabled.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---



[...]

> +	typec-portc@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupts-extended = <&tlmm 9 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fusb302_int_default>;

nit: outlying sort


> +
> +		usb-role-switch = <&usb3>;
> +		vbus-supply = <&fusb302_vbus>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			typec-power-opmode = "default";
> +			source-pdos = <PDO_FIXED(5000, 500,
> +						 PDO_FIXED_DUAL_ROLE |
> +						 PDO_FIXED_DATA_SWAP |
> +						 PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000,
> +					       PDO_FIXED_DUAL_ROLE |
> +					       PDO_FIXED_DATA_SWAP |
> +					       PDO_FIXED_USB_COMM)>;
> +			op-sink-microwatt = <2000000>;

This is inconsistent with the sink-PDOs you defined (5 V 3 A vs 2 W)

Konrad
