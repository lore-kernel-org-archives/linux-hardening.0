Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5243F4BB
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982256; cv=none; b=e+J2HdGYduEON1x4K6qoANHDWpW0zVmKQKy2elfFdu66jHd+Fr8+eiL8zv2tmZV4fLXRMjPH8JX7jEAAimbw9srbtgPjrMQIcIUsgo7ttY5TrrujNKyDqbZdBxXckq7hR1vuOyV5kTB+7mhCetauB/CeDUPrCLqxX2/SQ0e6kdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982256; c=relaxed/simple;
	bh=emNPuRCAyxU3Gn6X+B2FnhI+z52aNUB6G0TLtPQJiWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZM94Zr2ei82x65fVGZ3xzBml/And7q++pLEOZQmv4x8gSDYZkB8LIPlvQaJUSqb887ywBWBjGzknlOfUx78I0IA+8ClEtTsR4Jx8tvB5Tqnf6ofx6/duf91IojJI65K+hPnirmn4yd6hyg5nFcCG3hSVuliI4CKpxFt+wRrwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnwFx4dN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fUBpxje6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnwFx4dN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUBpxje6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYduT2730322
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 15:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jxcqqZMcfMQG0NRazNx3M9ckLAOYPTmpP07Foy6k8GI=; b=GnwFx4dNXJOck/32
	lh8S0LUpRjNWIkYURELTU8rv18AsJKu8lilSCK6u/YgXq+eO5zRkKK3Si/ODV8xE
	lH+obl33oBaaDqqIDa4rmwwlKGwFu0Vlx9HkN64UVo1wYTKgNaOLrTwIk2YFTLRW
	5BxsPmUrVltriuvzZ+Fllkxt3o1snIwZ+gICy05W9pCuQXxv0SSS3n8KY1ZJlyOL
	j9t+lPkau0N27xFR9O2KCbyWx8fK1rI5SgpaphB4xAGhgf+c4S9GHljxX245RKrW
	DxH+iO0XmCbRmpIOYd2lfG7LJUkYTSjr+9huQqFGoMajSyKqQTzQ+x4g8tXL/bF9
	2Yz8Uw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txyapcw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 15:57:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07313be5so4457931cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786982253; x=1787587053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxcqqZMcfMQG0NRazNx3M9ckLAOYPTmpP07Foy6k8GI=;
        b=fUBpxje6KytuzpyPr2tTmNvyeOgVwfmk/mQQ5gAjCHq1sAApy5dFtnn4Q3IPDvx1c4
         CVAQjs9P4lmdkfY7Iah5kGHzBHkmRnGzPlkvyyuimqOR4atvX/BQljBDO3bQE1CWuOk9
         PmWveWLiGwBo/RL47YWp89ImQ4C8gyPJu8XAh6gjBM8hDYEczxNbqiWK9dZF2vbSy+/2
         ofu5nRsDEirNcwdCQhabIUMxe943/hAo99L0A/Vf68bwnsVFRCzEUIjUzGtKrAoPDwnD
         iwQimWl5go8fbl3cwpJhYeXm9J4ZVYbixTn2xxdXtuLyArd8TKMt9DjNr+z/XplzXGob
         9Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982253; x=1787587053;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxcqqZMcfMQG0NRazNx3M9ckLAOYPTmpP07Foy6k8GI=;
        b=YnFXJuYWPlPDvbez4zJOaDMh11z/Uxv2uC5m4FGtWmUtII9H/6DJdH0BHt1LPbktci
         4CEV0nVaAxuOXgzKm5XTz+U+ELtplSlAHb/kLK/Cs6DnwYyqQxm/9fOkELH3DiiI9hEO
         qh9YGXExgp89TJf3Qt5HD4bYPkXc3z+Xv43aSJpLs+o9BGt4J7fgOkS1aHWtnKCed2MU
         sgCMWDiOA59AuA2s8QHQWBE5zw7JOzBzS4NuIrP4wb4FUwy439vY/ymJwEcpad0pnwmS
         cjhMeef0M8H1c71hqptERCgbIzs/o73lzVarX8V+GSJMfqY9dD9EA8JmJcSmDQhy0zck
         592g==
X-Forwarded-Encrypted: i=1; AHgh+Rr501BjE1fy6amjdFUJ0Dv84dwFjTwdV+2p5fGfPqszz7Hf/qI5tseY1OoE1c3eWn5Y6YZlanKRIIT/40D4o3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvupBX8P6GsJdj95ws7E39XOAB9tm16T7+YlMSWWt7Tdg52C8p
	/0tf7lsekazjiXgxxccRznSgGeVCDMPpcUsSkwb+ab0I8qWvA8HqsgO5RqdI1HX6UTfuPfv4rfm
	DiTc9wmKuymobCaJYM8AEFQsuNiZ2g+SqaGPhylOjerLk9u97nvtpYzJSuIy7aSLM0MkxAlo=
X-Gm-Gg: AR+sD134RdRwrmH+NMLld5Gabhx81ltd0KFROnGwRIOcOuQHrzqqXICw/WWaL2j0CfH
	kt1cDOJBMb5wTM2udXvuVxuwL9YR6DTbHQHpDM+uy1agXSlpSV49WwJ9LDeJC37CmtH1/NQafGX
	qMSayeyUu6KUlZ3lQaV0O1C8kjXBhzX54hRvBzQtNNmLTrbGUglWUZetY+VkshTDa2qSZiy8v8s
	MuB2Qyj7ZMzfSFBpO/hoQ3QliAzE2Kvp2Yj5Tb+VsENfKi+Ak4v6pBMD41HH/aGkSJoOZt2WCar
	hWT+tlK0aQGS6jVl82afclqqC7GWHtXrCMZaQSAQFtbbuhprb+EhBpNvj02tLjCNc0/KqqXSwAf
	dGNVHhdBecsoVYV15Squy3Pzt
X-Received: by 2002:a05:622a:1a86:b0:52d:9db2:7924 with SMTP id d75a77b69052e-52d9db28d13mr113108921cf.1.1786982253478;
        Mon, 17 Aug 2026 08:57:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1a86:b0:52d:9db2:7924 with SMTP id d75a77b69052e-52d9db28d13mr113108391cf.1.1786982252961;
        Mon, 17 Aug 2026 08:57:32 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d85319b1sm921569a12.13.2026.08.17.08.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:57:31 -0700 (PDT)
Message-ID: <3021cb06-7219-4e54-8188-e9cef09aa1ec@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 17:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: Add LeEco Le2
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
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-5-79a779d76173@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260810-next-patches-v1-5-79a779d76173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMiBTYWx0ZWRfXyEaKkWrA1zpd
 UheAhduxgZ6zsyVNvCQqbkl0AMdk/gh766hIWvurrMDYqqxr6V1M8Sjgj/MqZeV8QfQMAPgsnDo
 /VxSlnrNpO9UZJ6WdzQzGyyxEjaVNoQ=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a832f6e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=c_BSE4CSJTi7_uz2YGEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMiBTYWx0ZWRfXwcN/kS98iXSC
 MqxyBZQ7k0MKkLZyANEnjF9PHo8J37s/32NecsNszhF9+wBZWhND2m2M97Rg7v2fxPs+HL10bZG
 Z4lSW85fA7gdZAWL0Y6nGaronGcugBXSFLaoAKsLsJmBSWdULcyh5bQk8/2g+bhanvPpItuONdi
 /syyI8C4Q7juklgF5f7f7nMwznbMkMGLIAUZHHuKQNr2LtYdEci2b77MZFmCIOmIzkO6yiqpI+B
 nWmnTP4E8kFZFeZr9UM8UvXKiBHLp1rdqSkUlHah5dM9yXTeSOTk3QoWjSyWl0T9TavARunEAmI
 vVLfmh1V02q6LhvIHEND9Gb36MSfTrBOVi7ZpNUmzySp3LGVtmLtjxTQN4haAdGLxB9v7qOISpi
 BEX3cHgWC/YN4YCKw3iHHQhUhvalyVRLvInzjkVFuroEKZDuXO8JwB/KmfuCo/Yc+53Da5LRHe8
 h00JZjm6yI3ZJ7xwvQw==
X-Proofpoint-GUID: CEcyhffvQEBCk0FSZzwOxbBbRvE7LxAM
X-Proofpoint-ORIG-GUID: CEcyhffvQEBCk0FSZzwOxbBbRvE7LxAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170122

On 8/10/26 6:55 PM, Adam Skladowski wrote:
> Add a devicetree for the LeEco Le2 smartphone, which is based
> on the Eldarion/MSM8976 SoC.

[...]

> +	reserved-memory {
> +
> +		ramoops {

Stray \n above

> +			compatible = "ramoops";
> +			no-map;
> +			reg = <0 0x9ff00000 0 0x100000>;
> +			record-size = <0x10000>;
> +			console-size = <0x60000>;
> +			ftrace-size = <0x10000>;
> +			pmsg-size = <0x20000>;
> +			ecc-size = <16>;
> +		};
> +
> +		/delete-node/ memory@83000000;

Referring to nodes by their node names is fragile. In this case, you fell
victim to that since this node doesn't exist. The more modern approach is
to assign a label at the definition site and then do /delete-node/ &foo

[...]

> +&blsp1_i2c4 {
> +	status = "okay";
> +
> +	rmi4-i2c-dev@4b {

Node names must be generic, so touchscreen@

> +		reg = <0x4b>;
> +		compatible = "syna,rmi4-i2c";
> +		interrupts-extended = <&tlmm 65 0x2008>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vdd-supply = <&pm8950_l17>;
> +		vio-supply = <&pm8950_l6>;
> +
> +		syna,reset-delay-ms = <100>;
> +		syna,startup-delay-ms = <500>;
> +		rmi4-f01@1 {

Let's keep a \n between properties and the following subnodes

[...]

> +&blsp2_i2c2 {
> +	status = "okay";
> +
> +	haptics: haptics@5a {
> +		compatible = "ti,drv2604";
> +		reg = <0x5a>;
> +		enable-gpios = <&tlmm 109 GPIO_ACTIVE_HIGH>;
> +		mode = <DRV260X_LRA_MODE>;
> +		library-sel = <DRV260X_LIB_LRA>;
> +	};
> +
> +	tiusb320: tusb320@47 {

I'm not super sure what this chip is, typec@ or extcon@?


> +		compatible = "ti,tusb320";
> +		reg = <0x47>;
> +		interrupts-extended = <&tlmm 21 IRQ_TYPE_EDGE_RISING>;
> +	};
> +};
> +
> +&blsp2_i2c4 {
> +	status = "okay";
> +	led-controller@45 {

Let's add a \n beforehand


> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		compatible = "awinic,aw2013";
> +		reg = <0x45>;
> +		vcc-supply = <&pm8950_l10>;
> +
> +		led@0 {
> +			reg = <0>;
> +			led-max-microamp = <5000>;
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +		led@1 {

And an \n between each subnode

[...]

> +&otg {
> +	status = "okay";

Let's keep 'status' last and with a \n before it
> +	extcon = <&tiusb320>,<0>;

The second extcon is optional, you can drop it

from the chipidea bindings:

    minItems: 1
    items:
      - description: vbus extcon
        maxItems: 1
      - description: id extcon
        maxItems: 1

Konrad
