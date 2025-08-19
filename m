Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2383218CF
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628782; cv=none; b=rkAePID5p5DKjR+xeP0HYwKfybnkfCNyogiUFnsdyjYGuM3/RtEp8oAfk4zsjXVoVT/zZ4b1tpa23TywVQM/tAQB9sN5Mw9Bo9W78BiXDcT4KCmz1QlO7j8ITlOYLATenUJF5pv3e6J0mJZIAmnSAwzoBaFcpXJ5P35w8eou4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628782; c=relaxed/simple;
	bh=attFyXnsjHZ7VC6hMeNw79npgKt7Qbm7Wikl7gPhU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLW59Ygxlx/CfhJOBNia1nO1SexTfDUgpLdHDa5vQUxlbb0hV5ag3OXJ1N+zvKQucnPfwffxrqRSkm6LnCreXxupwqXYr0C7q088895s2Y4r8jGva2Xoa4O8VEB8iFnb5FXqFDl/qF2ArNDb8Fl4h0ALd9634iz7oc2MiDzZv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HA8HyV17; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HA8HyV17"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHZt4L027029
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B/NaYmJCzR8gO0DUUe2ae+cl
	BVLL43im9S6/z9w+rf4=; b=HA8HyV175E3ppKJkvp3ZXjn+X1lO3j/LLsRYtcj5
	saZyrC6h3vauSLYZ/bkqJursuLjCblbztWVFx3Rzmq6HmtkK+xYh+a6LUaE90wNv
	IlHvUgN9aCH6Lvs3iRIe7SsVKwYWIundaswflKp8KYpXlQs0/sYVq/4nrGjSpvVp
	abypcNFh+2mVsFV3VOT2iJJY9d18UpOgj0UpAix04OdIj8CKP+BMVg+8i+LaEsNr
	IuOxYjeTUADvIimhGGRRfYMIlnyvLDUYxQlj+vhErW5w1HkW2B9WXdAM/fZACLM7
	X8fZ7qgSiqt6Z0dFKIq3LkQXgcQ8mSVnY1O0hYEAm6t8/g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyhkps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 18:39:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f534976so181930426d6.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 11:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628779; x=1756233579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/NaYmJCzR8gO0DUUe2ae+clBVLL43im9S6/z9w+rf4=;
        b=pfQIPFfGdldT3+hobByUpqPE+hyU3BOWfrTplAbSQTV2U+RF+AA1291J7ow1vmTW5M
         vzndE6Ps25M7qvOa3CBIYzmUOqbl/Jefz+m1zolAdv8oH+jus4mrMdvawsA5adGXvvug
         XNaMpU8jTkomgyjO3IoJNs27fWU78W2pWosabvsIu2GF2pCfCSEwMGa8eGyw6KGZP8vc
         eDi9X8Y6170gEgnYiT1F2YyaM9Z2TziWI09gvfktjkHZNGV6oaS7KgFUwl7mBrGLV5cI
         D5cfkr8m96zRiKfAtw6VpZHGEnVuBiAQ+0ZgrGz/MNZ2vTUkIsXZz3FcXPWaklgEhMGN
         MgkA==
X-Forwarded-Encrypted: i=1; AJvYcCVY4UTUccOB7wuJGr1p0p4HQESPyybD2aTFbeObtsOBzPFGROVa7jD+6PBhvrY4HUJ+veoi91MFjpJP8SL6V70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDE91X3muw26LaVH7Ryd9QD+FVYapNx209jYzkJzgrIyEZyUS
	jop8MKNFn1WRRAor5JGX02nwYe58pQfU8Dcrm0vZLTSEEbpHvMr01wfDPWlUoleM74kWM1Own5r
	4NdraLCbsuynkgTc0DrY7cqu8UAUxzQRZ3eDgBswVMjFtFd94xQkvJBDLmWpv+tMQfvAOrKk=
X-Gm-Gg: ASbGncvJW7dvK3WSmTaYkXWA5nuufhCOmCNsNKWo0teeq3IjWjdw4QIXAOTxFYxg2Dk
	P1gWb+fM4vj8aS/b0iUnfismV16mrqn8ZPMlx31BwWOMciqE/53G+aAq2xUwLJLO0g/AiPnx/Pp
	YWaVYXsrN6Ga6f7EKNcnbduI7X+fOU908zyzEcb6i/Ls5wqlYUdfxqFGqEa/p2+vgRVC8ONsmj/
	7xKNMq+LHf2f9aC/M6mY3qbykIKxfrsWUoaxQV8Bl9yHPWQIDxejjE0o4e7VPoQ1fW2BrmJKqNg
	fKyOhcLR6MB602H9853Bh7GN1lTPxK1hB22SwKPkKIZbAQhncQcVTJ1LMPMAQ3izkF7JLiLUvr6
	zO6loFTOaDsiSJrz6c5c3GLND34mwRcfHJjy0nVZr90XsQCQ0u9r1
X-Received: by 2002:a05:6214:2464:b0:707:68f2:3275 with SMTP id 6a1803df08f44-70d76fbbb32mr550156d6.24.1755628779007;
        Tue, 19 Aug 2025 11:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1qwSILdKAsr0GJZliDLF6PIj5cZ2w6GM1QhNowyGfOtSCmwfpTie6OxhRJWiVBpMO8KPupQ==
X-Received: by 2002:a05:6214:2464:b0:707:68f2:3275 with SMTP id 6a1803df08f44-70d76fbbb32mr549686d6.24.1755628778433;
        Tue, 19 Aug 2025 11:39:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc9d3sm2266106e87.73.2025.08.19.11.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:39:37 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:39:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Minor whitespace cleanup
Message-ID: <vmyn2kj7ln4a2acwfe4c2qedw7onrgzxylcojsxtuzhpbd52zh@6h5jpiw2r6yc>
References: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
 <20250819131717.86713-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819131717.86713-4-krzysztof.kozlowski@linaro.org>
X-Proofpoint-ORIG-GUID: DuvXAxqUs32sETZ2DE_cHDG2vRX85fN9
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a4c4ec cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Gb3ubVUUNhpLmocYnzIA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DuvXAxqUs32sETZ2DE_cHDG2vRX85fN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfXxNP6hAOCVzuq
 V3qDSCNiVV5j5XUFAORf+vapp4no2dWxaeUR4ocoBxZVXM7wDNW9JkesxjXM7dRlPkwuzXhLll7
 Eux5InrXgia+QZo35weDAg3a+r8RxC0qV6HTY/nIdO7SqVV+fwdGKrPKcveXScioDX2MfvKPCVo
 YTTp4q4R4VOV0k4CIZ3BkXGMJfo5rQroHkooiiS0HljeImIVCb714+iHE49MXgIzB8m3mSJ94w/
 4THtfe4czx9amrONxvhVWlVYRM+FbjB8f1rv9qlMaRpp6nLZazDjb6aJXpbgK/lax/mDEgWiDxp
 lOa+bv/UpzglCITwQFbtgbuSz10itEM4u197wy9JCHchjipNDxyDA9C+mEn3Mp//ItEgjxVbChz
 cAVxu5eJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

On Tue, Aug 19, 2025 at 03:17:19PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi                   | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi                   | 6 +++---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi                   | 8 ++++----
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
