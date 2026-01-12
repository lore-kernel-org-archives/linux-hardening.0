Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12D2749C1
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256133; cv=none; b=limbSssVl6j91Ghzyy2+9dPuO81eMlXPmqGyT/VtG9y4DcPIumJTJF5uzzkNJMtyBYo4tqx6dvvF4biIPVjVoT3OQOi7VOduYsEFTZyE8hPU7p1DmUgu8OkoxQDhsrDz6L3xa07MQ+sWCTsC+kDozl9Up5L+6ZONcM0bzcQph2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256133; c=relaxed/simple;
	bh=dFUBb4Bm5zvwO2hzE5lf6QQqrPXNl6qymeK7PEmVev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSKKrE0iERBJFMZbG8Akoa/RvzLvVcH4y6il5TgoRhcMZ2eIIo2QPZz7CTYh0Tei+NbRq6wfIz0JDjGzI97brLdjiG9ZdjDd6LQuuyruSWe3eSOETP4IpXtRH3a6jAYsvfqPm4cvFTPQ0lOxlnNLPL45+4dgPbAiV5B91qIc6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbI83lS+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JW3EjrY7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbI83lS+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JW3EjrY7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CHfBva1376558
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 22:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zTEjLDFec8WnTGsEtWIyapIr+kF46TTSBI6jZIc0xF8=; b=BbI83lS+j7PnOhxK
	TGCemVyIMurSPrqG56EHTKd0t0qrhGGRKP/rduNnyWEiBDIOYXlbXXDiPjhBK79W
	C4ZNp204i8DiKYfaEsAla66SvOwASHu+FWt1nyHypntDvbGq6TCTy1U2x9UVfVGB
	Ntp0ztjOAPpshT+Rqt5EieQg3JoYrNG6qbzfPpDrzD8d02cX4VHJXJ736t/lxIVG
	fYVMuk+kTLQiEw2AaG0ZsX2M9NxLSXy1sfkBfKKVY4BBshRAE+5ndbPFBMZ1U3pk
	QUslmY28XFFXkHM7Ef1W3E7kZHCejQsZ0bI7DEtmYVkCePgFDL5jnicWNpoeNPtz
	APc0lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmxdvt8sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 22:15:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b51396f3efso1332507885a.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768256130; x=1768860930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zTEjLDFec8WnTGsEtWIyapIr+kF46TTSBI6jZIc0xF8=;
        b=JW3EjrY7SmgsCpwfNMnhMftj9s0nrSoEHqO1xn0Py+AMpOnFgubwoI9RBnWHqsWghE
         1YHNLGdG/xs9RODTuSSffVkCctLujJbfdChqrh1gNt8xf4nAGhQokJxyDy1E8Zb/Up4K
         aWov5lSBy5+7EW6bBZhRRpesplKmlM8Mt3b9xOUjpeQ1DZ7PAY9v6UgwEGNM6hzS1wdb
         jvRhILEPWFbp11TjwJpIIV+MFifSW7cOOo4VqZXt3SyxdI51cUPN7KZqioBXqCfNGW0H
         O8xHNIbfTc9FgXRY83hqCVY+D3EzkzAeddLB+j7cfIrwAbX6GgtXbjk/3/wgWp5UV5dC
         /Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256130; x=1768860930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTEjLDFec8WnTGsEtWIyapIr+kF46TTSBI6jZIc0xF8=;
        b=JVXga3/Gbmb7URvVXS3fQtWmU+lq/V78MT6EU0laugQoSHnsoch+xTcPaxCXbUbq1n
         6vcAsQpghcbkoLaHMc+tLvI8O9/OueXxoBQDEb31UnK/n0Ecm2odtGIAo1T/jz1tpoVX
         oybTn7BxHmp+0Iq4KObtHr0j3Fj7CXNAgBxkgmMQsAE2q1p3Ipfwj6ZQXiciFnle/bcr
         SQn4jXP3Xz8egpbY7PZbmICXCGTIT4VtuXWLsxgaWCjfKFQgSuorvKOelvUm7QPPq4BW
         qOMsCxRpSwgAo+ikfj5C067z78WvozqmG4QWrGo7KZqEvxcEfIRw+JVM+nI3hBVoHBee
         STmg==
X-Forwarded-Encrypted: i=1; AJvYcCV77lXT0FHQOcuQlkHzRS51rIPbuAOS56/ISayvTf0i5cpmI+TwiKctKtoLrjayDjTXN9/LPH9WzR5sXFdoE5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7m2JnnW5uNY76TbYqLMPuNqO0VzNGGMKmetyTuTG4PM26khc
	QiwOoQLdo+PoBRhy6Bk4VQC9799VVfoqtyCJ9raI9/2zzxN4l8l6mYo/Gp33hZOiTff7IsZR52q
	FJHVeZaLjdwzSGAJQVIPiqb5Ubb5xlYUFGAS9C2wDaxNvE+6kTiQD6dJTHA5O9kRPBZYdL9I=
X-Gm-Gg: AY/fxX6iHQk68gcVHm4YlWBVh2DY+NP4D6NnGPr3wAP6wNdsxnlRWXomvigpeDDFYm8
	rJaViC684fDT/JCaPPOloaxKIrumastzTN8NbHE7N2MHyFm/P6O2XQcuN1d2E++5p3vpEyRE0yB
	8zFsNCkO95ZM15PdqezyibBMDtffOq1twgQEWaK7Mff3sBpfWqF5GKXIxZ/NrG9kYHhW9++TNE7
	WTu6q6W23arAfiiZAJ+6V3ieDn9702KX5CpFRL67hlRY9GSjSQRPTQ81AxyGd99hlPvmusgE+nk
	S0zkFY6qZISzAThbW1gi8k2gTsE8i5CGeMOVjhCvAs/8lRRMBJIP9epPkN+eR+RSnSP0rL/kngQ
	esYCD7k/OtSgltlQ9joV5q13fSCuh5ba0qAQqa2n6WDuxClafIFPiQ6IdTNF3QHO13/46YhMdtv
	2ohnVgsYmLKAe2RzYkrfMPcPs=
X-Received: by 2002:a05:620a:4385:b0:8c5:2032:3766 with SMTP id af79cd13be357-8c520323a46mr167439485a.35.1768256129745;
        Mon, 12 Jan 2026 14:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEltePUoFwRmiTYPIwJ28sy0z2ZcfjKl/8aARMEpYA7EJ2zFc21wvz/9YexYqf/X4XyaZQLAQ==
X-Received: by 2002:a05:620a:4385:b0:8c5:2032:3766 with SMTP id af79cd13be357-8c520323a46mr167435985a.35.1768256129201;
        Mon, 12 Jan 2026 14:15:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3830c2a2dc8sm27328361fa.27.2026.01.12.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:15:27 -0800 (PST)
Date: Tue, 13 Jan 2026 00:15:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: Add Redmi Note 8T
Message-ID: <3d2qboek2kzsnsjmn7rqi6xkfotfchc7vdmyeprivu27l3rw2b@i5lbwsvxfwdb>
References: <20260112-xiaomi-willow-v1-0-8e4476897638@mainlining.org>
 <20260112-xiaomi-willow-v1-6-8e4476897638@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112-xiaomi-willow-v1-6-8e4476897638@mainlining.org>
X-Proofpoint-ORIG-GUID: gt7sCw6KT7R6ZmGPl0sQsNPzuCyzIiNw
X-Proofpoint-GUID: gt7sCw6KT7R6ZmGPl0sQsNPzuCyzIiNw
X-Authority-Analysis: v=2.4 cv=HoZ72kTS c=1 sm=1 tr=0 ts=69657282 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=LpNgXrTXAAAA:8 a=a0QMBuUGJFd1xiM1Y0MA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE4NCBTYWx0ZWRfX1Yo0hLL8ILXg
 Kf+oHFYAhT4s6IfBniQRxQSodcXuBCXcKp2YNrGf48A0P7IKB+oSO+xNlcxm8NwboxNXc1KSnwp
 CcMWa9gEjpH8+mrl+cdv5mGtEOw0mCR2O43NtnS8Q1ipFGaL04hp8Dx//P2Z3GnMMFL3cceE9ma
 xHmMT7nCLfKqCRbYutOm4ftrlo1U/Bf5LpUFJW9fS0Jk0NayRSeGUoEngW4xlyNPpE7oYRXHVf5
 dwVZbDnh6d6s6vPS6/ZWbF98M4cxRoXMEs9ECNkBAxzkSEyJtrYIny2kf/F2GBYjEqNFNf8e5D+
 L23fOA5nTXyOJkzv0Y1o3d2qnNtClfZbepbhCaRD1YNtb2SEy87ZeJGLhWppXlutCZit3DMgLku
 1tjgTH1ODSAuViE+b0hvf9RdBa7EEgXtSAUMau2KyTlCQIu+SOaeeYG5a7PakiEDgqJ69OEl2ks
 u2onSjCJVVm/BFhvLXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120184

On Mon, Jan 12, 2026 at 09:13:29PM +0100, Barnabás Czémán wrote:
> Redmi Note 8T (willow) is very similar to Redmi Note 8 (ginkgo)
> the only difference is willow have NFC.
> Make a common base from ginkgo devicetree for both device.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 302 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts  | 296 +-------------------
>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts  |  13 +
>  4 files changed, 318 insertions(+), 294 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> index 163ecdc7fd6c..70be19357d11 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> @@ -1,304 +1,12 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2025, Gabriel Gonzales <semfault@disroot.org>
> + * Copyright (c) 2026, Barnabas Czeman

Hmm?

> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
> new file mode 100644
> index 000000000000..9e3aeb5a9e74
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026, Barnabas Czeman
> + */
> +/dts-v1/;
> +
> +#include "sm6125-xiaomi-ginkgo-common.dtsi"
> +
> +/ {
> +	model = "Xiaomi Redmi Note 8T";
> +	compatible = "xiaomi,willow", "qcom,sm6125";
> +
> +};

Please consider adding the comment regarding NFC.

> 
> -- 
> 2.52.0
> 

-- 
With best wishes
Dmitry
