Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F7128819
	for <linux-hardening@vger.kernel.org>; Wed,  5 Nov 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303624; cv=none; b=q0FAWOdx2ErzcQa1k32QTlfWwNZw8WH7ndcm/cS+u6ejuPkR7BL1/FrozVzlFB3gC1yDZxxhNzosxC6ssVpg1mVbOwmuwNwr8W8kt4KA5VLfJJy0fsS2Sj6bMn8N89qt4M7f+mdwCXJT6UO4rMVoFnK+tGvwhJ0i5meXEBle3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303624; c=relaxed/simple;
	bh=6F8Ze2HqT338sAZLldmfyih2VX+hoXm90QpRHVpFcA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJOekmOXZBJG8W/ZQIkskBPOxdtW/pduVhm+7AfJQScQjso/lPuGxQ3LkVX8BL0cvaJmGauZMa5m5HVULSD4OzeGZqigMTEv/oRCfdzc9bk24HoAMomEMSBRDCWr+FRVS+8IBkDoBcIecnVxgj/ki97cITx/awg7SqV8na9L060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8qH3CG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DCZtTfAm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8qH3CG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DCZtTfAm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KgNBu3165840
	for <linux-hardening@vger.kernel.org>; Wed, 5 Nov 2025 00:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=20DVmm7uuh12nXsj8hrA392r
	YXJpIcLN5xeBu9rny2Q=; b=m8qH3CG2VGn2+/23AvEF4QD+vI3GWfmZAryiX9df
	JxnDeT+IIkincnsOzjeClIbX2XV4jmqXC7K3rVmIjDAzjd23JkhNDYlvPlVBKv+r
	bfaV2o64BFn0S6DS/a4giayUnYKvoyAT3TwMz/oSXYQllG+yjuHNoWRO8+lbG3pl
	FsUR8tgRrPu0pnL/UklFxbVhBC5YWctOt3IQweTqmn7ZTmz4JQ8qkuWOoGfbhgS9
	X8woIPsicN4rHVUhiJ2/mlxEDc9kZLHLX/RH9jikOAMZxGMRLsUFHxlUTTBz/oBU
	mkWXpa6eXOYrPnmr1m1xZnAtq1EO1zTqe3lZEc8iwn1/5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7kethsx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 05 Nov 2025 00:47:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-892637a3736so1947156685a.1
        for <linux-hardening@vger.kernel.org>; Tue, 04 Nov 2025 16:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762303621; x=1762908421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20DVmm7uuh12nXsj8hrA392rYXJpIcLN5xeBu9rny2Q=;
        b=DCZtTfAmZEBfbJhHIHblDf+akQk0PgX7GzI/STqSFvE54TrGQO5B3NgMg6WBTyShxb
         S4mKw+fIs4Xyr0IuXYEpm9D+xzUkcE4HgUKqHH3NOTKUmSaeggF4QbVh3zAil2P8ib81
         v2igHsWlrPkaJ5w4KZm0Fmfs9xO6SiGHDwp8mFu/DEdKuvyots5MvpoYa0NeHKac/kJA
         kwsfOfrwf37If6Sh13V3xP9cjpFLg/KOLVkkjvEQTTg1506ROTJhB0/xCi0eqvB5ck7S
         Rsk3dy1pgIpHsZZ0njismTbxbyb4E4J/h84RsOs6dA3xt7VNPTO9wdvC9BBdNPcusqZp
         t0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303621; x=1762908421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20DVmm7uuh12nXsj8hrA392rYXJpIcLN5xeBu9rny2Q=;
        b=QjMcyXcARsGgcuud26s0Y834WyaedfG9lxobCYBOeqH/1eKjbU4I8lRSmx20NDii5n
         1LsyH95vn30Ds+Hq//Ibc++GqZVVPCC8gM+JBMnrFcKcNeZ6fh1UAinIiml4YLvCLBpU
         TRHAdKYlu439O7fd6YOJcaw5kNozXf/CHjn5lzaOQWkfDtsz6Xv8iaWOD6U4czrBIJM5
         iCYumaOzIvx19RIHcg9+z8zvqTPIrGa8qXprP+DxEzCfkDMA0TfYw+NqTT3dxcncD6nD
         Vkey5lpryyLq96XrmUC8Hw/2/YypStiFpToiYW3h4cRnuX2PCjCYS9GHlWT9osC0Sb9t
         o3+A==
X-Forwarded-Encrypted: i=1; AJvYcCXIZVH13u3oBnPpULaTyBF/t94WN/6OW32ImYeKrTHFmA7/IfA6ORLv8X/zCX5XUfy+7BaC53w9Y91AOfS6jCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95LOUT5jWRUl2lSK1jAF6NxaUqplZCf6Sv5CIRtJbZZODPE/s
	8vAOKYgSDqYb2DAbW6oDueWvKcGZYGnp1I5Op7H6xLInMY5KOlVWTr4R2w2EnEaGH3IQTFOIz2u
	hq9O0Ojur/WPbMtRZVEOmwzip/IqJg+3f2M9faYhLuLgwYwNkTs6gD65eV3PsfECdVSf1u8o=
X-Gm-Gg: ASbGncsxxCOwA/g88pKH3DgdbAGSSvP0OOpaBUZ2rZrPGHQPQHICiddY6KF6fj9Fajm
	enrZd+hBljwb4UxBoPu8rxQIXXDW5eFhRKu9wS1J8rTQJEnDUqzKgPLbcsO3qxezlIoVJYcxbaE
	NjgqCVbyJFsnWEwm52rNCp6pg0w31XbiyGIPfTKSBQIPx9rg11gRvi5UqOvZ6alPHp6NoRomJA9
	zBfQWA7nIyAWYp3WYZ075aOfqhiCdtj8JXH1wfY4tvqOyxAFI8zaGAcCAkm/zVlHELbx2dnDTGP
	KnJIODsanXhY48IDCXatGlKmJ9Lq7Ilt4uwgD3GwORfBAtpkDQdg8pLwF1I/rbmjFZmBMuRJ6jS
	nAOHyCsgVdbZNFT5qo1Qm+Z3ylTNinWZVIdQjmNNVLtRtXRjIckebkzcyKJKySx4sQGZKwqwWNn
	augjGzEz6xifZS
X-Received: by 2002:a05:620a:4044:b0:8ab:7ac3:3271 with SMTP id af79cd13be357-8b220b14872mr232599885a.36.1762303620766;
        Tue, 04 Nov 2025 16:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMkUX7jC+eXTRNJvJBEYnUpg6UwMXTsq4CChhPcvUGcohxQhFgjhegR3VopNF4Y97oL3PhWg==
X-Received: by 2002:a05:620a:4044:b0:8ab:7ac3:3271 with SMTP id af79cd13be357-8b220b14872mr232597685a.36.1762303620300;
        Tue, 04 Nov 2025 16:47:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943437ed06sm1178233e87.16.2025.11.04.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:46:59 -0800 (PST)
Date: Wed, 5 Nov 2025 02:46:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Piyush Raj Chouhan <pc1598@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, david@ixit.cz
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8150: Move usb-role-switch
 property to common dtsi
Message-ID: <caf3qjqs45lbmb4fb5mj7qordkh5yb37iftwro6y6jitn5fhj5@eb62whwvo5g4>
References: <20251104221657.51580-1-pc1598@mainlining.org>
 <20251104221657.51580-3-pc1598@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104221657.51580-3-pc1598@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwNCBTYWx0ZWRfX2679Kzd9qxwF
 RR2l7lYi8zFOmVcXAtpZVKwiDVK+4P1+4O7uXn1eEwNKqsqR1t57k6WGXiG/Eu224NvD/AjUL1K
 umJn7+DvM9YH4SF1aNctC0cOVCbdqHqGlzMAPLIH1rZqDBUYGlmEZP7po4x9ToR15FTXg+ZRJYt
 w+JRliJHM4ku+eSKD9qzd/Cu2CVqm2oK+4hhiFPmHM0mqu1erYivtiBOIGD7sXrhy51XpWGGNWu
 i2e/FDrIZVZOEILYYximEOCBSspEQd9ZUPulyaECeGb/dnPnWYjSvAiF5hrF8zdHtElUy4wpWj1
 mGlqv/FHBQllhw8vpT59+44r0ig7buXoPDR5eIqK80lnmagjR0cyFO4++uExfflqS887Gujb988
 X+9yzY3Ncsq/uAc/rUrRWUrip5LwRw==
X-Proofpoint-GUID: g4XVkZq8Swr1UlYAOmMuhF0TTsPN4fDb
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690a9e85 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=qM2R4nZWQg-DivYOzAMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: g4XVkZq8Swr1UlYAOmMuhF0TTsPN4fDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050004

On Wed, Nov 05, 2025 at 03:46:56AM +0530, Piyush Raj Chouhan wrote:
> Signed-off-by: Piyush Raj Chouhan <pc1598@mainlining.org>

Missing commit message

> ---
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 1 -
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> index 0339a572f34d..29afee6160cd 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> @@ -693,7 +693,6 @@ &usb_2 {
>  
>  &usb_1_dwc3 {
>  	dr_mode = "otg";

You can drop this line too, it's the default.

> -	usb-role-switch;
>  };
>  
>  &usb_1_dwc3_hs {
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index acdba79612aa..cd05975dacd1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3661,6 +3661,8 @@ usb_1_dwc3: usb@a600000 {
>  				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
>  
> +				usb-role-switch;
> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> -- 
> 2.51.2
> 

-- 
With best wishes
Dmitry
