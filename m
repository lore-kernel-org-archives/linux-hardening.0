Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7093429032
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439997; cv=none; b=EPtsv8SgGbcYCJ9DlhIUlxSafGosSmIfomLrLMuYqKgUvp9OT7i6wsnR6DChx6pXS9L7644gZi/eSkQl1qUaqRKREAXat+Kqr8TrKzza+CriG31UyB5799DU69oywls85fQN//MVltl66Y+X0eYZVmNHojdWMXntb76pfNDKnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439997; c=relaxed/simple;
	bh=LyUpJFKfESBHuLkCIiDNQZkrg1ABi7qIcSdkqeBKKZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9P92p0G2H6lZpj3rvkjLXZQ+/U1tlUqffZegwUMBVtyS88zEEmcADvc0BcIrEEpkUuVxOKOeR34IWf5lq4uGZzMNPoTutFKiC2ixIX8f+jp6iQl7VIGRTEbLCMXzEKunPflyeWs2gAken2EqZqa1g06Bum2k9qg5BSyV0+pkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4YtsrcH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jX/rYETL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4YtsrcH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jX/rYETL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B738Hr2252429
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 09:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vQMbBYKosM4bhsnucZvfevVV
	XwVTm2ddA2HEncy5r1Q=; b=W4YtsrcHS5KTk3OmKdZiG0dDZeKyHSCayC7uSbQa
	4kbmuzC9iyeFHwOL8eyaQ3soKvYupucQuYXK9g7ydYuSxArS8/PGD3A6EjQqpb3i
	cM5dx3IGYVls3S6Rnh0F0QiW+/sY121CFnUp2n2zLkClEEUf2BSGJtRXUplJEG14
	suxCPa/huS+r9UyQF5ixOXViFu7lus3XVJKBqGnDSf5k/vpZ2bAGpTd75VsLu+38
	6NCGHbtlL4PTax1a1wwlrB/Nnnmm+zqq+j8rpxlyBO+D1P3+N8IcnNF9foR8mtJn
	/9t3gENY3yZpa5uH4znixtbqTuPyGWCgdn/WpWgjcnTakQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7bes8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 09:19:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d30035dso20501821cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786439993; x=1787044793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQMbBYKosM4bhsnucZvfevVVXwVTm2ddA2HEncy5r1Q=;
        b=jX/rYETLNg5KV2nInv0LuXHPe47v5L9JjbQixcNTheyvQmPZRzRy+KtUIFXJGjMb3/
         EuFFGiI5qO7vti0si/pt9OdIDesn6WWU/1JHUEbrFRNyqlzb7gRiaegdx1B5OGCwjz7b
         5DMJWmA1hl1WXxb6n/VupfyrEXYu7xAPwW8KwwTB5wRA9fLDEziDTwnQg8g0QH7pwWE9
         QUL7WaFCVKavgWzic6nNFVBkbiyM0CF0BvQwjxc+uzbhWVNwmr/8Bb7w4wkj3AHFTrms
         Yfux6UwPcCU8/M8/WSsCXD5MZquwmYxXsrtU35an1zxyP9omFdsmoHf3qKZNbFGHyBs1
         q2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439993; x=1787044793;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQMbBYKosM4bhsnucZvfevVVXwVTm2ddA2HEncy5r1Q=;
        b=Bi4pt03vNCNalTOpzTSbqbWJCMKDiHrQJRDyKapYUvSibIVCDRUmLhQzX1l+AZdwU9
         Fzi/ZFhAgJ0e1bU3irf2SvJ+11httdyn25P/6SLPyI7dvAlRcQOAldByY1wgCyVjLZYv
         c2AczRG4rUbrq67ycUedcTEinu/GagPryf2NEQ/I/i8HAM3HsHIouDIL3YFVf+MP4nvm
         6W8vJP0tP0zcimGWEUlIsldCqjWr2SN7ntnHbpS5W/mw2HvxQN97ppkWL4Y0xRWLMiQV
         l19vkFXGVbmO2oVXS41K2XyRnHgN58AKvcuLaKdES32qfgfhaCEIeEGu1kLHVNyrgTKA
         dK2A==
X-Forwarded-Encrypted: i=1; AHgh+RpObFr86QZbr1QfGo2Y6CFXVSAG3iBayDHNUsRVh8gvklRipKMOfCM0WEealpw2HnticP9fGLivKDiORqQxdgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxFuzbetcJoIh2NjwMhlrI9cDeqF8D+1ZRJH5UZXUK0dJWJ7P
	ZwjLL0Y1b6u9zOibZkf3ckNBvtn+szFfo1hQIi0kXgnpoDqXikeoKpQur+M86whBKUzyR0g0nuD
	Y4UtnFOkVlpKG4O1aQvr05VXUk7vqt5lb3th4G9Vfd0WULQqL+fBnfllHfIhm4WnG9uL+y8w=
X-Gm-Gg: AR+sD10YGxuV+EkNjZwmV9lTGpLYp5mJSqHpfjA1HtFOYaL8DBzb/gLHXm5apE3qE1m
	GIfVsFakCW1HzyufB0HRu9N7hhipMxvidwRuj9C9AhSQUftG8rP6dOtSkOSjYj58e411GmTdGEc
	Met26WUX7w1Ep0fHBIqUDuw9uB6cD/hTpkpFewjT9RDl6wFzNLVxi6ZAmAFBtVtVTHC6vSIxc1p
	PsoeyTmJ+mxwGpT7gZ5hJuN9oM8Tu9ev/CziE0zvGzexlR3VaBpY/kG+4wnxS5/q4RHsbagb2gi
	mzQT75RL+4X3/wwwk1NUy/hhXZOF248xGGZhu4z2Mp6q7m/yLpFlJqn7aTqHIAC1/0vO+jx4UpV
	lHmJeCtQK5D29TSian9cQFc8IOucMlHUcL/EOqHrE2aF3Js4C8u97rDWoL5yNuk/FXbB7mlZ0VO
	ffaUakg64weFkUZA==
X-Received: by 2002:a05:622a:a18:b0:519:efea:cf41 with SMTP id d75a77b69052e-52d585dea65mr14209631cf.28.1786439992842;
        Tue, 11 Aug 2026 02:19:52 -0700 (PDT)
X-Received: by 2002:a05:622a:a18:b0:519:efea:cf41 with SMTP id d75a77b69052e-52d585dea65mr14209461cf.28.1786439992397;
        Tue, 11 Aug 2026 02:19:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44872d9d1sm162976e87.60.2026.08.11.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:19:51 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:19:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: Add Xiaomi Redmi 9T
Message-ID: <6tyswguhuemcwmvkcuwd5ssk2xj7s57cufogkzk2jgisnygqos@dwvsicvnylf4>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-7-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-next-patches-v1-7-79a779d76173@gmail.com>
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7ae939 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=8dPnOhcq9ZKN02hjC8wA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: N8LKa2zGCnSHfrSQBxHk6myC8LMRbsU9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NiBTYWx0ZWRfX+MBTeU3gunSN
 VuFJud51V/00JRKTkvywu0QUKqsXkIQKxiyUzcCr3Da3XYnpiIM1jM+YDoRZp1k50RB3RIw/pqQ
 1+YHX/gZVq+xYvq5RzAI78Dtb1w7D4LRx0ErhXSOBYqyRbV/jLhnkz6VI1eHsFv29gVgjoTR+sY
 biteRBhpd7vLBkjHEV/PcIPrrowrox7GvQDIGF4Vqp8ahL0aKHHxUabZWFKLIhlFpQ6BqENmE62
 IbHk0osvJm7JBUGpbl6lBU9oW7xZSya93BqxO4OY2W/anlkCV88mjSYdVDsXeUdVwk4nvI1eixf
 ejQaitNQl/JitJMa9IGg4y2UmUqIkylIl7OZyPHuzIl5XARH14uDLIzEaVBapAFwqPFIAvVpkJL
 8oFrhAvnJWTgGvbEf4VFCTA/yG86LHn/64y+bDnPWb/VyenY1n2guOY2UlugMhjKHIgmCAUs3AP
 Og9oKmVUBy/R8l1rAsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NiBTYWx0ZWRfX7Uj1+mubwDWh
 5b89qV0WdcA2KAP5wdjq2861VVQjZuN6LNvaD/FINcoZn96/JLX8dntrAYOBJukKIWZyHyp/j6g
 QBdgDFv5E6jo/J6OS12ulaKd7UY8qsw=
X-Proofpoint-GUID: N8LKa2zGCnSHfrSQBxHk6myC8LMRbsU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110076

On Mon, Aug 10, 2026 at 06:55:40PM +0200, Adam Skladowski wrote:
> Add a devicetree for the Xiaomi Redmi 9T smartphone, which is based
> on the Bengal/SM6115 SoC.
> 
> Supported functionality as of this initial submission:
> 
> * Display via SimpleFB/SimpleDRM
> * GPU
> * I2C peripherals (Backlight)
> * Power Button, Volume Keys
> * Regulators
> * Remoteprocs (ADSP, CDSP, MPSS)
> * UFS/SDCARD
> * USB
> 
> Device tree also contains supply maps to other subsystems like MDSS
> but due to missing dependencies like panel those are disabled.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                |   1 +
>  arch/arm64/boot/dts/qcom/sm6115-xiaomi-lemon.dts | 440 +++++++++++++++++++++++
>  2 files changed, 441 insertions(+)
> 
> +
> +/delete-node/ &pil_ipa_fw_mem;
> +/delete-node/ &pil_ipa_gsi_mem;
> +/delete-node/ &pil_gpu_mem;
> +/delete-node/ &pil_adsp_mem;

Keep them sorted, please.

> +
> +	vph_pwr: vph-pwr-regulator {

Nit: regulatur-vph-pwr. But current name is also fine if it's an only
regulator.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +
> +&usb_hsphy {
> +	vdd-supply = <&pm6125_l4>;
> +	vdda-pll-supply = <&pm6125_l12>;
> +	vdda-phy-dpdm-supply = <&pm6125_l15>;
> +	status = "okay";
> +};
> +
> +/delete-node/ &usb_qmpphy;

Just 'status = "disabled";'?

> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
> 
> -- 
> 2.55.0
> 

-- 
With best wishes
Dmitry
