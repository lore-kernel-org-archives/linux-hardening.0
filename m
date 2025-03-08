Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402481DE3DC
	for <linux-hardening@vger.kernel.org>; Sat,  8 Mar 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446692; cv=none; b=qfT5/FMwZRVc53PJ4trnDAF1ZPY4pA7Di9whNwlBx8NySpiajQKQ8/TulQlnux8voNdUlx/9IM85obQdGvf8SvXMBlGygayrazc6XjVcn29r1pRUQz68//7y2YNF5Uwx+vyttclsI5ePZxR8DP86fyNwKqajutCNSpvvcPQA518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446692; c=relaxed/simple;
	bh=N4Y/rWfX/ErgGuDVJeH/rMzbOw1XPcLiJZWRJXArGuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8QdusNhJ0bptRolAjllELdfFqkoOWgH0buqMuAOhZvTuxqO/WWk4KO+5WanaJRUzbNJYWCohCnEglKzWPYbeHBUrvEYAJ7PUoHzxsShP7TEoTZNWHEfrUZdvS/ge+6BIJ5tveUbFYwqug6zqYnX0jY6z+eLcheVI1drf1OLvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8d+6l9Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8d+6l9Y"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5285Mg4L017119
	for <linux-hardening@vger.kernel.org>; Sat, 8 Mar 2025 15:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17mSlg0TsgJpm9YrhYgcbgX70rQCMopp4+pGOm7/cOY=; b=C8d+6l9YXU1b4Cw2
	kMMMgzHOri5QV+oxQ58ANI9ZILrzOdJcVM9BuU5/MhM8zphVThAtuhhpXAOPc9rg
	wm6aWOltT3BISAyHqgT+v9l/F8Z+7pvkKGN38lCrCDAH0cp+mSvAZBHmM7A/2TAt
	Ct+k6YW58l37zWqjRt53K9fXdB1crdLbG2kRbtuxrm9nrY3dWjNPFj9aeZ8HopXM
	hYrp6ZJVTzW+01TTwvyZfxLDLDMZp2plFFZ/O6GUaA8E6BxoMESwuJxUdqwGbd37
	pYPEzwnH7Lv080J/ua6Y3eNnYpOaANyPx7NMo74LIznZBi004X/NxO0YzOSb9DaK
	jfbNng==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0w0qrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 08 Mar 2025 15:11:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c53d5f85c9so14877285a.1
        for <linux-hardening@vger.kernel.org>; Sat, 08 Mar 2025 07:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741446688; x=1742051488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17mSlg0TsgJpm9YrhYgcbgX70rQCMopp4+pGOm7/cOY=;
        b=KnF7EFTZbtOFUIdBZQDo+aYKQLFPlZKvYV/kro40S7dMD+dRwd8WxIaY3v4nOf6XuZ
         gsJCnNzYr3RRANrsdHtzpv8jbvr0jVFSNJ6pD5JkwYQpVuyDzKSTjKa7eXAZsVmykJkY
         2RCHCxOwaU1jWZ5zsVcE7osRrXcacbWpFQag0gBYRl+2TyWI8MZmNyqpzwXZ67PZMQKh
         faK5+wHwkG5GKOioowuKcCc0VZe0kmAlTt3vezujIt2xCiFxzGBtkSYTDOcFRToh6JTv
         4hQX2o2syFoAPG6Y3exSoASsxJZ7OzTxSOTC7Hl2U6xMWj9TNeMmcowoJsxAnA1xJOWa
         ZyYA==
X-Forwarded-Encrypted: i=1; AJvYcCWD2fxze0pGVW4lCfOIHYqwzSv+6Gk+vpLIBgUtF1wT2LS9DCK6zYQuEehG5mibYvorIjH0reY38QipOd0okpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ym5yJMEZ9itOsPmeImWdfkhIiJySC4pstIkpbbVbq7qpZQwt
	uYavaf8O29AVmAtcS+lLnOYOR9AyG5BFoNmJ+K1mT42kmxrX8m8LRa/61ajNJnjaN5iRuwoP4iI
	42svIhg9BQVJEdxjwsWOG1LtebNKNAxNoYbzCdbHV89y5XhUm2gpYwqvmDYnARnYLLLs=
X-Gm-Gg: ASbGnctdv24ez/qeVKWioIcPjrQQOiB2+RONL58x4xokdpV4yno4vD6iJFZr3iaX5Co
	MMzDmNXgNfyoAAUsEytBgHxBHF/TqYT9CIcW161BLqLytki6sUTIcHyLcZjuqaDAH38Piz+Yhf6
	ErHCoOk100m01zyAQpRadwKmx7r9FKLINijiacLloihqkyGVx/CE59CH67Zd8m6VkNIGMHjarCU
	w5joWlxAsHbpK3+aw+6f0ZhZSHGo6y/+J7Stf+O/fClOQ765qAFJ+0XTmszIXBsE0Ot14dczP68
	IjoPAivpPj1dzqnm7A5yBLWhXBJDCG262LMvMVzEeEspkdJ2kzuX9ARex2L8FR3b32R9zA==
X-Received: by 2002:a05:6214:ccb:b0:6d9:2fac:c208 with SMTP id 6a1803df08f44-6e908d77c32mr16126356d6.6.1741446687825;
        Sat, 08 Mar 2025 07:11:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi5eX2rYARXcGdEIQgWGA3D1fX7uAbjlYAvKDaq9ISUAw0zxsgCH2/EMLyFZmrNwsKqRwNMw==
X-Received: by 2002:a05:6214:ccb:b0:6d9:2fac:c208 with SMTP id 6a1803df08f44-6e908d77c32mr16126206d6.6.1741446687490;
        Sat, 08 Mar 2025 07:11:27 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943878csm443853866b.23.2025.03.08.07.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 07:11:27 -0800 (PST)
Message-ID: <0bcdb8f9-9a3b-4d6b-bf7e-55a22ffc5df9@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 16:11:24 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-ginkgo
To: Gabriel Gonzales <semfault@disroot.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250304043742.9252-1-semfault@disroot.org>
 <20250308013019.10321-1-semfault@disroot.org>
 <20250308013019.10321-3-semfault@disroot.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250308013019.10321-3-semfault@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LAbIETl032UJ24bETOusVifdxAFvnzgd
X-Proofpoint-GUID: LAbIETl032UJ24bETOusVifdxAFvnzgd
X-Authority-Analysis: v=2.4 cv=MICamNZl c=1 sm=1 tr=0 ts=67cc5e21 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=LpNgXrTXAAAA:8 a=iFAeERd1oua_AfBMzccA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080114

On 8.03.2025 2:30 AM, Gabriel Gonzales wrote:
> Add support for the Xiaomi Redmi Note 8 based on the SM6125 SoC.
> 
> Defined features:
> - dmesg output to bootloader preconfigured display
> - USB
> - eMMC
> - SD card
> - SMD RPM regulators
> - Volume Up, Down and Power buttons
> 
> Signed-off-by: Gabriel Gonzales <semfault@disroot.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo.dts    | 294 ++++++++++++++++++
>  2 files changed, 295 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 140b0b2ab..4d7d54f69 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -246,6 +246,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sm6125-xiaomi-ginkgo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> new file mode 100644
> index 000000000..c4677cffa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Gabriel Gonzales <semfault@disroot.org>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include "sm6125.dtsi"
> +#include "pm6125.dtsi"
> +
> +/ {
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <394 0>; /* sm6125 v1 */

#include <dt-bindings/arm/qcom,ids.h>

QCOM_ID_SM6125 and drop the comment

> +	qcom,board-id = <22 0>;

[...]

> +&hsusb_phy1 {
> +	vdd-supply = <&vreg_l7a>;
> +	vdda-pll-supply = <&vreg_l10a>;
> +	vdda-phy-dpdm-supply = <&vreg_l15a>;
> +	status = "okay";

Please add a before 'status', file-wide

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <22 2>, <28 6>;

Would you happen to know what's on the other end of these?

Konrad
