Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A003D668F
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522279; cv=none; b=AtVE046eOlmeQIsZssL0XEbwdK6kk146DRpyrOa2fBqWausNv1QHY0iZikmgIvr24Qiyrshof+6lPParYYlouFUTKMQ1+LofgM6AMtdXUdqXDmjGSyLssTNMRwA7YcufMeuV7KFuonibQIHWMyV70hev/YPZP8Xk6n/FnCwUtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522279; c=relaxed/simple;
	bh=0YGp70VxaO91HxUJFbJnJ5F6HFDYP3i2GY/s4tb/z64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYs+sO0cI2n+xKtOiOrpIZ4vajJgUd7A9OU825W2Vxp8zwaSi4+Gj2ha/8nRgxZo3WcCl9v8Db9h0NdMpqFTmr29/DLUAOH4Tv9irou/R1ewB7DBThT+bCpqiv+ZndoztiMNx3EEof+cz719FOt+2lebCRPHx4tAtMbda5evLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYmeYpeJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vyfv24g1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYmeYpeJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vyfv24g1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BDDtte3333473
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 17:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Qcv8qjr6fEiDbQpPSdJkFDL2
	ZBM50yz1nWeQcqgmxfo=; b=PYmeYpeJBuZK97ZYV446hAl1KADeJIk+uHpFuhpA
	/bm+VPkw9lMtidiAynOxByRt5o6jaukhZj2cJQgZ/lFUCz5y/U42jFRBfKbgumWa
	i5gbcB4BSXZTvV7pjja1Argky8ToxpKoKjSXo13M8/ijal2JTJ/o+V7d4pcpfnTg
	NUDhL5xuvLaBIQWQnEkHFCWynqMHLpW2NJk7YN2HTF1hSyKf6dlzq9CVNcrR4Hlq
	js6gPhtg/XWkKM0hlEjvvGRL6ja3mMnfCEvc+gjOv6njMSMeHVsR1kQCwZnYZGql
	WCcGVIOvyrLQxYTISqVs9foNprFggSclHreU/fE3qK7oBQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ajgth5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 17:57:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5104b861649so132277981cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778522275; x=1779127075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcv8qjr6fEiDbQpPSdJkFDL2ZBM50yz1nWeQcqgmxfo=;
        b=Vyfv24g1gNUIP0gA01wve/I1Ig1HAK7JD1hotvcer0m6/Ukm01z771OI78Uuqzd+id
         PysoZ+1OBkEXmOMUhyp/HJtXnbp6EEsvFGsWlnAfvYxp2EfLzKOc8Pxbh0BABEFEVb9D
         9QCy4Espxam0CTGJclMfxGCWSDEte8meb3Mw7yyI5oavsTcp3VqoqoJVxcVIObt9tuwr
         V/YNOduwPM2XlWKrwidARTxEB/YkyXrM9VYjAEpyxq5y2g09eqnaS3gpt2YHhQ//d2pn
         zxLSB4qAwccGH23UI6n8Z2gyuqCE1+yRzaTvpZP46VnFeHX/SwSdt+JFelH32BaPl/rB
         zBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522275; x=1779127075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qcv8qjr6fEiDbQpPSdJkFDL2ZBM50yz1nWeQcqgmxfo=;
        b=QWIBTIBBPf+/UzCO7dnZkU58wr9CtB3Dcfl0rQYatilOMG3S1pY5bpIPNFKRpusrgU
         WOEPOPIdDqAEBuV033uZohJ35niSj5Hf76/G2B/G1g3n9HAjCLFZFW9z0m8i9crnoXwY
         9y8gmrDwvdBBsg1C9L6z4c9uNEfgYXskzGX/bYU4FYNo/wvTbjFV+D+q/qXA4cGlMkKX
         5JqcdmZDeEcmSC2rkpj/1uU2nhzhwrzn4r/Gncv6TKK+HNyI5Dr5XpDh03+CVreicrM4
         qKol461NBstKb0ZMAwfE6asQAs9nUuengFnmxM+aK3zTp4H2LqNqRhmDQrl07Nfkauit
         DNuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CCtzcZ1DTANkjdTAORgJVmVoRFjFU89iCBrApyHc2UwfdJC8omhcMcReZiMCagQ2NKwzPuAamTMUTvu0UgKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzdiRKslFzegkpLj8id4tRckcP369wZjLVaJVWse4yq+7G/18
	STCwvCnwjHoDkSw+9C7vYXD2HaGNv54aQp2uFSt+kPHicMcLCeZnYFTBjJ2Eo36zdWWYtlw3Sif
	K/k4Cspk76TL9m8XSjk0W4TAP4b4fL8JlJDDKV+scYABu1u1reCBpjTt3CcCYeSRUff/Mkj0=
X-Gm-Gg: Acq92OHFbBOtf7JqjiobCCs+Wj63vL7ZVt1146Mpz7HizoQmniYUQVf7MibQIHMNVFS
	HQzx3ZFXs8XHAiUtHNOakrH92YGvcGRh7LOt0IeRp3zeC6WsiDTmjEXcvXjGS2ZEd3VtcFb1Vlv
	MRngwjJOT/d+sFNBdMMQhAekUijhpblmC3ti0+3FVslcgZ8XuiEInd0oSRNEDNPsjsZ8JuOgkNd
	3p2MYzK41XKlWWlxTI3Y/Rema22XvgT//dPyI9kPTGCaYG47p38iNPxaNPxxnfhRD1jqDdTrnZU
	z5OexkoCHqp7oeyIEs1rEFa3xic78+1ALC6ZaL5umtP6Pfwyjris0o1oQVxj3hvxwk/nyH3hunK
	2K0Jq5ey5mkA6S2x5gkYVQw/5LIH8Fkwl8hGZPhy6Q6HRltLazaX62rVA1yg0UlbBHEJJh/DzhX
	oW+HPYwgZlpCJujs1aGrPmf9W3eqA3P8UjP6Q=
X-Received: by 2002:a05:622a:1985:b0:50d:7c4b:5c5b with SMTP id d75a77b69052e-51461bdb425mr364047011cf.5.1778522275311;
        Mon, 11 May 2026 10:57:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1985:b0:50d:7c4b:5c5b with SMTP id d75a77b69052e-51461bdb425mr364046621cf.5.1778522274860;
        Mon, 11 May 2026 10:57:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951cfb4sm2788709e87.20.2026.05.11.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:57:53 -0700 (PDT)
Date: Mon, 11 May 2026 20:57:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        bryan.odonoghue@linaro.org, mchehab@kernel.org, gustavoars@kernel.org,
        kees@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: Annotate flex arrays with __counted_by()
Message-ID: <vqcumtz4quxxbzg6gytx2wg5bhcawqjes7vra5nd5mirimmay6@k2pmiss5jlrw>
References: <20260511130538.33443-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511130538.33443-1-med08elkadiri@gmail.com>
X-Authority-Analysis: v=2.4 cv=GfgnWwXL c=1 sm=1 tr=0 ts=6a0218a4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=dTTBFGv0oYrt8U5ceIUA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -yX9_vFsC2AbQ8Ojod5OP5IkuGp89gzT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5MSBTYWx0ZWRfX8cNwpHBNwgcG
 eh+082DlU84QDmJvdkpW9ARcC57kmRhLb+pbkrl4nzmI1TBQDTR6VdEE4dfokasEqFBMh5G18JB
 IG2BaG9R+SGEEtCXsQgCkuXcOAocJM+cJWD9TUl1XzYV+HZC6hctW1P5QdFgeqlJNfvpgLjQn77
 xZoP+wilvyQMfmCC4/L5to5nVNVJH20+svOCArJVzHRZqeF97LKxGBtQTWPf5B9elB21/FjQ+yH
 15HZb8GXZw7Ri9G4eaqfTUIX0AdTwIgY+b8+b0LH5Q2IhMZaE05jTDjHY5FGQeuh+xa7I+sHt/Z
 DCAbfPunmef4ZNCSSC3+l2Sv62gkoPb8Z8UWmhVXtkcxREmQNhWA03S1KBg2Yw7DeNRruBdEAg5
 mdSDEqfLi5MA5VRui7ztkX2LUwaKb6Um73xwWxeYzhBNXZmBM5cgQuRBjhvTIwASGFzs5dSjgv0
 DGi0kDf5dXk16tV6CpA==
X-Proofpoint-ORIG-GUID: -yX9_vFsC2AbQ8Ojod5OP5IkuGp89gzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110191

On Mon, May 11, 2026 at 02:05:38PM +0100, Mohammed EL Kadiri wrote:
> Add __counted_by() annotations to flexible array members:
> 
> - hfi_capabilities::data, counted by num_capabilities
> - hfi_profile_level_supported::profile_level, counted by profile_count
> - hfi_resource_ocmem_requirement_info::requirements, counted by num_entries
> 
> This improves run-time bounds checking via CONFIG_UBSAN_BOUNDS and
> compile-time object size resolution via __builtin_dynamic_object_size().
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_helper.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
