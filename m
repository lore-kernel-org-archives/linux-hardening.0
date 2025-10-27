Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47342F3C23
	for <linux-hardening@vger.kernel.org>; Mon, 27 Oct 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564951; cv=none; b=P07Y4lal6sHOkKS2/p+aI+7yH4cxiMKMvpKauIdsNstIYqIicHk/uUGyqeeJe2okXUqgDc2Od2kn3wyF+wPow9rSBFGb3oSxonHreUt0PLsA7VtsF8VCdyeNcjPbXnbolMCIaqzyPizKq/6xA2yAuHMQZcpQCd6L4v/ZTK2zCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564951; c=relaxed/simple;
	bh=z8JMmtO5pPNwnHupK7VV8WcW+3BYrdml7mecpOldSXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMU9iVim9Me/8t1KhTVs+Qoo8aRqcpAmFkjQUaHeybbwiskjOCCn7wc4k8lh0T9GI/x/P5SP4LzPIsKo7Lz5h0Hp/bUiS29uKght9uP/wMU8ljFReaeimKLXcUq7H4wPDtlk5HhJ0t+8aBLDoQKP78j28jhIALdL6BRB+uUMf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQyQc2T2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQyQc2T2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBK0Dp2546933
	for <linux-hardening@vger.kernel.org>; Mon, 27 Oct 2025 11:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TU1kj7nq4ocDun8TqNLhxKbF9wpc+NkFZouW7rYkBz0=; b=ZQyQc2T2h+tLoAgm
	qVrNqEsapCOLmOefQnrDW29hYm4RtSy/thpCiCtKRfBzVHdXiaiEgvdutlY+Ejzu
	yaZB7NQ7BME+hmTKQeaf21gEqWRmDlvTyZCnCzjX02PIANnul5Q3X2qpFBXrgPxB
	/pwAyNibDmGh9lRQQMTVD1pVjAoea8QBRpz+uc4kKazHVfpZ9SnrYz3R2kF6XeWC
	CJc0nQ3JYmBYz1Kq4wdonvPzZF+9ERQUSQ/IS/C7BMytg6SaZ2LPN7i37MwWXOIJ
	E3Tze/89WmpLnx0jJ3/56yDIQ6fq3p2dRdq9m9FSr7YFab7rCLgWZwGt3rELKOOO
	ln8SyQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2g13b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Oct 2025 11:35:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87dfd456d01so13944386d6.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Oct 2025 04:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564948; x=1762169748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU1kj7nq4ocDun8TqNLhxKbF9wpc+NkFZouW7rYkBz0=;
        b=hrqKm15jzULHbVhsOYzE2kYrPrGeRsLOj3bIHPveNxs8M76i/SaUQL+TBHbtXvEFha
         7Sr76PkttkgNeFHbcg7QqW6WArkjxNU9d25bMQpAT8ELAn4e8SmaqLLrzZSRGRvHY7Rl
         xW9mO/9oxeT9Hmk/VW1G8NsTDYm9k460uYlHehrNYILwEmPMnCdjwJY+dMGNaIlTbzzv
         ZJwVSnda3TmB3fhWli5Q1x0oMCeD+89RggxDoMNbSkw/+59oNL9fhbFSb0n5D3Fdzdgd
         lEqJ2RoqeL7iTT59P9wNIVqTPWXMiL7D66iSVTPojaqDqI9GQ9e3JX0r3+ZV0vA8mC8Y
         q3hg==
X-Forwarded-Encrypted: i=1; AJvYcCUBOMqCB3YjcYSm0dwmuPhdIMu6IOYZIfW0ds6Wbt9eiedxh2X3KIHV+gdhYBmJXnu/54TBywJ/b3u8DouBz7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxygOSYI7jweEb3CGPcKOhKrrLcrJDrjAvKTXoNLdiO372231l
	0DEOfl5AKv7l9oKwVHHn5/4AMkVM2inhApVD7zxXwasJTJ+rBMZGreIojA+X4+Omk3TrKxs5GgU
	iMDPnHaJ+WsP1h6SAwJtyjUZXUntdh0LW1RebQG4QASa+kUuPzsWP8fenII+i3q1VGUzP4+A=
X-Gm-Gg: ASbGncv8oTxc4Au170SDjG6Tu89ogeYukoaVc1xymWAGJ52sN1oUQZN09njbH77HN82
	w8MYV+U1cC+6DWSJNtkxjPmy9F3NaX2NNjHJa7GUVQB2BLN6cSZvAgxPTi7m1n9usAEMSYE+vox
	RfeTiUN1W491W5/+r+gnUg9vB19KTYLF0sVvMaBw9WrPRvPoM58mh/HjEPJHBufM6w729wGichD
	aFEAxBxnvDL6QFI0czypY2XetWkyzHrU3IPMJZdI2MnZNbFBu82eCKqxipiOu9o7jlhRG1O13gX
	eUnT39EGg0I/qtSE6qJ+uIHkYQrwjOT+WGFqCRb+DCs4UNpCQ52cLlvNXTMJdm2qH7gjZXioFFy
	dDUA3+4mXQrUecCc6cbMxWUO6m9h1Xzf7ho/A7hvylpVvnp2+nMOnpNIX
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id 6a1803df08f44-87de70b4724mr201372596d6.2.1761564947768;
        Mon, 27 Oct 2025 04:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1KFM9AHLmnI7IFMN2DcxC11NSgWpPMDkmEheNEQeOvudyiBGTHMvMjndvOo4TT8fYmLKjJA==
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id 6a1803df08f44-87de70b4724mr201372356d6.2.1761564947284;
        Mon, 27 Oct 2025 04:35:47 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6c0e9sm6005786a12.1.2025.10.27.04.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:35:46 -0700 (PDT)
Message-ID: <ccdd5d44-2382-44e9-a56d-cbc5da23b13f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 12:35:44 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8150: Add support for Xiaomi
 Redmi K20 Pro
To: Piyush Raj Chouhan <pc1598@mainlining.org>, linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com
References: <20251022054026.22816-1-pc1598@mainlining.org>
 <20251022054026.22816-2-pc1598@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251022054026.22816-2-pc1598@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AzfdCHeSvOLbk7UjQhbpx4gEw3U1_Apo
X-Proofpoint-GUID: AzfdCHeSvOLbk7UjQhbpx4gEw3U1_Apo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfX2ubFXTFOdkpT
 9fMQWleI6Q2WxtTiAsh4pU3vUy828K1JXEJ8OVMuqBZB0tcHj9MenHr3VeTZhGsrkL0IKxGom1A
 jA+Aib1upt0cMgXJ3WaLXcVXWbCh0qdLLCOWq32YEgJZd1D0ARiTjDkr9qZTeE5Uss54enYISZN
 84XpdFojuEy4qAe76eoKHy9Sg/ZjuLYw3nN92AhFQ6ytX0VswtUbcNkcjPoMHDSN/cAEyQtjmBv
 oKg+a4seOLPfEmdHWuh2BgZlc5XaTtlzNB6QQS91cluUvksuyu9xzsOd+zcKvJM0s6EzvQiOoWe
 rIPqa/rLFefw9P0BweD0mgWMbJFlQFRcHZIeRCxpcprUcrnYFhHNw5ZpLvhysqF0cgt35z0NPiY
 Y363UVw3bWu5upnXhDKcjDIdxQtGiQ==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=68ff5914 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iRxBnbZjw3uyMlr8g3cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270108

On 10/22/25 7:40 AM, Piyush Raj Chouhan wrote:
> Add initial device tree support for the Xiaomi Redmi K20 Pro/ Xiaomi Mi 9T Pro
> (codename raphael), based on the Qualcomm SM8150 (Snapdragon 855)
> platform.

[...]

> +		ramoops@a1600000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xa1600000 0x0 0x800000>;
> +			console-size = <0x400000>;
> +			pmsg-size = <0x200000>;
> +			record-size = <0>;
> +			ftrace-size = <0>;
> +			ecc-size = <0>;
> +			no-map;

You can probably remove the = 0 entries (although ECC is very useful
to set to e.g. 8)

[...]

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;

property-n
property-names

in this order, please, file-wide


> +		/*
> +		 * PM8150 LDO8 (L8A) — supplies vreg_l8a_0p75
> +		 * Device spec: nominal 0.752 V, active min 0.752 V, active max 0.904 V, IRATED = 300 mA

Hm?

[...]

> +&gpu {
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sm8150/xiaomi/raphael/a640_zap.mbn";
> +	};
> +
> +	status = "okay";

This shouldn't compile

[...]

> +};
> +
> +&i2c19 {
> +	/* goodix,gt9886 @5d  */

I see there's driver support for the GT98*97* - is there a chance you can
reuse some of it?

> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> +
> +	status = "okay";

Please add a newline between this property an the following subnode

[...]

> +&pm8150b_typec {
> +	vdd-vbus-supply = <&pm8150b_vbus>;
> +	vdd-pdphy-supply = <&vdda_usb_hs_3p1>;
> +
> +	status = "okay";

ditto

> +	connector {
> +		compatible = "usb-c-connector";
> +		power-role = "source";
> +		data-role = "dual";
> +		self-powered;
> +
> +		source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_DUAL_ROLE |
> +					 PDO_FIXED_USB_COMM | PDO_FIXED_DATA_SWAP)>;

Have you verified this is in line with your specific device's
downstream kernel?

[...]

> +&pm8150l_flash {
> +
> +	status = "okay";

ditto

[...]

> +&pm8150l_lpg {
> +
> +	status = "okay";

ditto> +	led@1 {
> +		reg = <1>;
> +		color = <LED_COLOR_ID_WHITE>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		status = "disabled";

?

> +	};
> +
> +	led@2 {
> +		reg = <2>;
> +		color = <LED_COLOR_ID_RED>;
> +		function = LED_FUNCTION_STATUS;
> +		function-enumerator = <0>;
> +	};
> +
> +	led@3 {
> +		reg = <3>;
> +		color = <LED_COLOR_ID_RED>;
> +		function = LED_FUNCTION_STATUS;
> +		function-enumerator = <1>;
> +	};

Are there really two separate red LEDs?

[...]

> +	/* GPIO 0..3 are NFC spi, gpios 126..129 are FP spi */
> +	gpio-reserved-ranges = <0 4>, <126 4>;
> +
> +	/* Display panel pins */
> +	panel_reset_pin: panel-reset-state {
> +		pins = "gpio6";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;

Please drop output- properites from TLMM subnodes, these are controlled by
the kernel's GPIO framework instead

[...]

> +&usb_1_dwc3 {
> +	dr_mode = "otg";
> +	maximum-speed = "high-speed";
> +
> +	/* Remove USB3 phy */
> +	phys = <&usb_1_hsphy>;
> +	phy-names = "usb2-phy";

Is this a physical limitation, i.e. missing wires?

> +
> +	usb-role-switch;

This property should be moved to the SoC DTSI

Konrad
