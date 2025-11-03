Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F7303A05
	for <linux-hardening@vger.kernel.org>; Mon,  3 Nov 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169018; cv=none; b=MwKCY7jNnrgjrpAtgihYl/IjS9UcnF2jbfVeVoFyvwMK44BS2UMAYD2hO1JCJdKb1ldmpbys7q9FhdRC72e8oQlaIfxg4+IiiiMMCmclbYBsOCwWDGjjZuvO+BFR8bt6wL1lfNfzt1eCusxu8fQHOKQimcZ9+k2V2fJJEQ6noIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169018; c=relaxed/simple;
	bh=4/8WP3/8KyyzzaZycL4PjwRartXnOK5+lfg70dZVDxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OCguQZh+Y//gBSDoAw3ZSkuOo3M4urjKOm7B3hkOHK6Qf6GOq9S3PnmWDsdonyTJy3fiSC4qDMnlJNgQPRpS58eGsxwlJTn1MIHNIX/u179bhSdIq+jWUcNJ/wxZXxU7V/eCk5tnPBrMi4Pcj1wQbJv07B81KpYKUR0Nv5deHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pnLOgxBl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=akzN7B/O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnLOgxBl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="akzN7B/O"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A39ILw21402870
	for <linux-hardening@vger.kernel.org>; Mon, 3 Nov 2025 11:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5b10FLwdc0HwfhtHnLEhX+TKUMxjRqrZdtiXlxAFFhw=; b=pnLOgxBl6+dCHxKW
	lAlsG/z2cU0VId0oT3LbCKmtvWPxR3REb+eQM7EyiVfXDaPLUyuE/2nm5TG/DKDY
	diRj+4sRVi53bHFaIa9sMN+h+BlCjWOGKwigyiK6cRZwa6GaqCMJyZhO29+RekOv
	sQykdJ5ZemSYs4LIcO8g2nPi8kFC/0c78+agaj5OJvkEiVdy+0OO4AxoCl2ADcaP
	iQOzlHbe3zoQbZ7N5bDcyGuu5VnB/Z+xb1Y41Mtf6pVCj9e66W399KbQvtFXqgB4
	8R1E9KlfOPA0+uRByYIeg2vZqE82hA+rxNmiM7EWd3DlCs5G95IVqJL6fZY/ZzBd
	9Jowtg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977chhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 03 Nov 2025 11:23:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8934ae68aso19041571cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 03 Nov 2025 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762169014; x=1762773814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5b10FLwdc0HwfhtHnLEhX+TKUMxjRqrZdtiXlxAFFhw=;
        b=akzN7B/OJ2YJa3MSJThD3J642zoOtFyRr44q+yEXxFAtHuljhSKinNr1PNS6uMYqsj
         h1NSluTJ0yTX+DOSQECPx0ZRJySA6D54BByAo0lheii1UMAzwnQrayUnPAurlLCBaCfK
         kiSpqroordh4+55WJYgAqvdFhdtm9Qm+lGINri6dJqzH9i+81ZDt5Zk1lk0ZplT9dtyO
         QTjjYNbvg0IXfUZWoRtXg2wENdxqFs6OBgP/bPybQA7RPgMGLBxgs9alLJpWQRF6BHKB
         6sTIBLe/XqThcRzVTv2qFWB0MEFMaQL8Vu7SHFZiZKWHX1XXGA3TX4Cxwdm2fi7PQN48
         b4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169014; x=1762773814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b10FLwdc0HwfhtHnLEhX+TKUMxjRqrZdtiXlxAFFhw=;
        b=UDyIf1Uc0xqV5/xhjT9hLT+9+x6RqkzGTkkofG5DAEO5wQaE9617+Ecp7M93YVwE3G
         K9VEDBghRFGILia7YJLpxJciq4rq1Txy2pBnVq9GdvcNorz1k9lx90BZp6zr+/7czQot
         hlprXT3G4Is5Fiw8Uvp3329rNmgY9OwLEvZoLM9zh7VE58k7LWhyyiLBbWSi58N62gDd
         QvAixOrrOZT+dYStlv6MftkyA/Gqft12fqTTYFvI5eLr9kE5E3kOBkCjZSx13hpotZDc
         JkSQnJs0+e7XVQYKiUdoCHM6qAEWjLni00H4WaS8O7azJXe4KSLa01aoPmDUU7YTfHu2
         ys9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUloNJ176+gEhFush1pduuvLvMrRttSucfv+V6Q0CDAaUeFPSvK6A1mmYh4NRk/jTD8IhryqHANxwwypY5B1NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzbtKp49hZNTIRYgEacVFAfqc8FHTV7QRP8K68gi8SLZJCcIp
	TBduaakoAMhPwLaiadY0rC5x0kURh+N6jg4aS7yv+XV9miHdf0RyZzO/3pURgkggxtJFSPqSl49
	TSwDKhxH3FZmeX/CYwqNThTxmnm7oPvETH3XWTJ8QyYi3xsUCF0KGnD6rbDqfHMuYkK1B6Hc=
X-Gm-Gg: ASbGncv5PSbXENLqLUKVqaSGQxSMdOEnaHDQH+lYWnub0HF/ZNANt7IuODbSfsmHGuo
	vhXxzKPbTXinbJL31kCiBd+cTPf/NKicdSVQV3BkCZzWhrt1t0skafJRMgFZVOS1bgF+HKCElKo
	mPxwr56XdqYPT0NWKMAJc4RXruQV7JHV9geaZBHrouhLzn0U4IjNZDdmcE+uZfzFWazT+XMQ4JM
	IZ4hNchqflsKRkrrMMt50ZTiNjd2BRYKReY2t1pHVYWgpyIfj4GPfflsdzPP45MzyvdCrvzmU0S
	uHYOz9IFIzIWmI0HMNdXgccFmX33IgqZbDXdYmLUoy3rRnWldO7jlaQbV1ThqsXbZ/X4rQ6JL7n
	GuuuS66ydPQjWCfpTwacdfQskR4ihX9IBJXPzpQcnIBjIPqR/trC5OjBg
X-Received: by 2002:a05:622a:38e:b0:4ec:fff:2815 with SMTP id d75a77b69052e-4ed30df2e79mr102046781cf.6.1762169013913;
        Mon, 03 Nov 2025 03:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZBwX1D3jJCH15p0kqXDXLz16GUl/rSLJBQ9cfFvv8QZ1FAc1bO2rtImHjVEhSEJLcC8qRzA==
X-Received: by 2002:a05:622a:38e:b0:4ec:fff:2815 with SMTP id d75a77b69052e-4ed30df2e79mr102046551cf.6.1762169013507;
        Mon, 03 Nov 2025 03:23:33 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6408ef1c486sm7892631a12.36.2025.11.03.03.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:23:33 -0800 (PST)
Message-ID: <e516564b-5e43-4628-836c-ff227a68d20e@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 12:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: msm8953-lenovo-kuntao: Add
 initial device tree
To: Raihan Ahamed <raihan1999ahamed@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20251031135506.214025-1-raihan1999ahamed@gmail.com>
 <20251031135506.214025-2-raihan1999ahamed@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031135506.214025-2-raihan1999ahamed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JjN_KYMWXNB5JpPKpGagO0VSqk5L6r4V
X-Proofpoint-ORIG-GUID: JjN_KYMWXNB5JpPKpGagO0VSqk5L6r4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX98jiwRp7OvkP
 mqrjN4giLZbNeBx/WLh4oiOpDiZhxSYXDHhQyQn8G/cbVW+Ey9HqIyzdwI9nUnAydCPdl6hKTWt
 eZaDXtSAoBuLZQWP8jakKYpZu047tBUTYCL9a9deFuT7JkLSlV5PTjfZokBC0noZOwV7byDxpNm
 Aai0kcM4gFuRkO1xQoM7SdNCXtGQvNNDYNZdQKQzsHaMTXsjsA4Clmt232zf1GAaHGOSxsIuo70
 GGGtffWHrR3ecC1TCNFefiFUmmcZm59rKLPprAwJwNbSTHFIm7Eln8zJ5WIC/34e/GqgDZOdjEe
 mebDHda9S1WBYN2OSZyAL6mfGfkgPG0WFQBJkD4rvCHNd1WlanEAcqreEKmGZl2efi75Hq9ga9V
 1rPoCG8NwZ+ljW7hURbSnzNMnkY3Jw==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=690890b6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=iN3SH9SwNKT8slD2fOUA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030104

On 10/31/25 2:51 PM, Raihan Ahamed wrote:
> Lenovo P2 is a handset using the MSM8953 SoC released in 2016
> 
> Add a device tree with initial support for:
> 
> - Enable accelerometer sensor
> - Enable pinctrl for GPIO keys
> - Enable gpu and add gpu_zap_shader
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - WCNSS (WiFi/BT)
> - Regulators
> 
> Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
> ---

[...]

> +++ b/arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024, Raihan Ahamed <raihan1999ahamed@gmail.com>
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/delete-node/ &qseecom_mem;
> +
> +/ {
> +	model = "Lenovo P2";
> +	compatible = "lenovo,kuntao", "qcom,msm8953";
> +	chassis-type = "handset";
> +	qcom,msm-id = <0x125 0x00>;

QCOM_ID_MSM8953 (dt-bindings/arm/qcom,ids.h)

> +	qcom,board-id = <0x41 0x82b1 0x41 0x83b0>;
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_key_default>;

property-n
property-names

in this order, please
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +		};
> +
> +		one-key-low-power {
> +			label = "onekeylowpower";
> +			gpios = <&tlmm 86 GPIO_ACTIVE_LOW>;
> +			linux,code = <ABS_HAT1Y>;
> +			debounce-interval = <15>;
> +		};
> +
> +		homepage {
> +			label = "homepage";
> +			gpios = <&tlmm 132 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_HOMEPAGE>;
> +			debounce-interval = <15>;
> +			gpio-key,wakeup;
> +		};

Please sort these nodes without an address by their name> +	};
> +
> +	reserved-memory {
> +		qseecom_mem: qseecom@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		ramoops@8ee00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x8ee00000 0x0 0x80000>;
> +			console-size = <0x40000>;
> +			ftrace-size = <0x15000>;
> +			record-size = <0x5000>;
> +			pmsg-size = <0x2000>;

Usually ecc-size = <8> is desired, as the traces are often corrupted

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <135 4>;

Any chance you know what is on these GPIOs, and could document it (e.g.
like in x1-crd.dtsi)

Konrad
