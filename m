Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798904DB57B
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349717; cv=none; b=d3oi82sqqp8K7U2CGLFxiS/avW4+35i1owo4H/+hRAwmP0dhgnKoLevC/4EJxHFUFD/mpxR+gn8l/por/FzTuyjHFGIYU28AicVpWks4X/AIDVH0m7t33BYHT26blu/ICx1XAT4FI3CJLioHPqyqPwKKVXNjYrPJPUKvUi8OhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349717; c=relaxed/simple;
	bh=eupjsbxKINcRQuC29F595+o6K1wLkOTXL9fh5anBXX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERWZXs3yk2zY/D8Y18rXsP3nJAlJLXvBoO/rrGP0OJYega5CTb1W7SFeA9m5Rnm0x4xT8W+286JV8HJXmHpU7GK+4bBMA8lhCKWB7jXUylILE+aBCeZ1hHrDwzWqc+yDSBXrpy6ZrSIZ8nRuqCa8b5d6003uP/XsKCaAnUXnUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+UjYE6t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWKXPGZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+UjYE6t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWKXPGZG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TIR8BO2881863
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AnU1zi8FAw41jHzsJAGhK9y6ec/GVYsZBSJFjyj491s=; b=E+UjYE6tKRDqpkD/
	RQfg+U1dEx8FBsE/fUbVM5whZE8WdrPhqNj51A0T41hzrXa15utlAa3z6u9d6m2s
	9vj07rIf9iwNfLSot+WxL25/VpwHb3NGI+PVxCJ3usRsb5wBHHkda/xXKzFtVPT7
	BxZjGI9RBwjBDTcftoIuawmOaJmmMHgIBkX/aor0Z5QiexIvgEFkvz8p/Mu3+Er2
	+36s+1zHy+z0qJ8yM5zul8WhWGhpbU2l2JNWOKSLBBoLT0t5DiJxpNj9iGBiz8PL
	jvNDpmEYkb8lniNQjA8z7c83+gl9em0bE1ZTKSWwbJ6ysyZhVbit7CQ20leu40x0
	EHf2tg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ghyrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:28:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe3fa93bso13330111cf.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785349708; x=1785954508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnU1zi8FAw41jHzsJAGhK9y6ec/GVYsZBSJFjyj491s=;
        b=fWKXPGZGVmhha9rppOsEVciPKdMGq7UO7+I4hhI51mjLJYZ6RZtojVJDlwxOyWx3xP
         SMCt6MV+tdE4gQk3dfbGNyX2yV2DNQBtYyf3RUltkYR9stdbOyIBiVi6dnKRRzNxvwkt
         VtYhlwBoQQrJPXPtww+qM3HgWrSyokUq+gV3oYts6t2jgTyrjmyizzglaiQ2mHiGS/vc
         kCDilpH345CLCQhJWGl7U13B931KdWsB7MkHC+QdZ+mOnOuVPDxueU3JbOf0HQj8hlJ1
         3I8kXp1k1r3b+/mWW4skO0HrOadIjzynkiKsuu1kdUYXpdcykKDw7iYa3+COGyogY43X
         vFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349708; x=1785954508;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnU1zi8FAw41jHzsJAGhK9y6ec/GVYsZBSJFjyj491s=;
        b=ifZeah1lMky8ptvuWB2o1p7Atyz97AEoVJNs5JnfVckjJZuP5sPBhR9hHzv9UwbAqv
         o3uquW+RPblt6BIiBXRvdg4wvuRaaE+ZBCmKDbSnSBb1FyWtRZT4KJtRlJwZpE/6m9Yt
         wsCK3W8BRkJYYv7H4Bv1xG2emDFQWNy7R4GJKC08EASG5iQUy7enI4n7PDlH+cu39yof
         /jKLcMKUQSpHGjo4rSRYQPaSfLeku/xT9eshSRAPvDed9JSKw4N0M8ITd7zOf8Yt3MwA
         uFR0vaBVd1Gc/QuQsOU4NF8WLzp2Rs2W1ksqZsLsLvBuvReN7H+Czumf8I8iKkHoapfF
         BC4w==
X-Forwarded-Encrypted: i=1; AHgh+RoIEbXOG2R93j26EbzF/qb0K3im3z1Kkc4jookGxi+rZYUJ5kOxbEyg0P/241gS++yNoEMGbT1/QaK+cfb4SWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFN8qArwniElY6sI4zwQB0VcFFavYfKDxTMZh9NJe7TYY2+YM
	Y7MUC1cemYxePiPk0smfHWMmeAk5M/Nfk70GkhX4RDSWTh6KmJ+U2jyODD5GFkGD7NJx3QKrV0V
	LaJcIh2zUx/fDvi4RyTSG1oQuVCHGFYP9J0eyefOprfCs5B3Hjwv6zt0Ti+n38RHnlqPsZLI=
X-Gm-Gg: AR+sD13vQWuy0XrgHsw8wXEAz7EWk2g0UvmN/sGNkX7rBEjDa7MJA9ypU+X9hd0XZ/U
	USNUOMZLqZcr5b3YqlNtEPMiFe2/xzlR49pYBC6LNKunfZtyaRcxAVJEv6+FscVif0DOblbRtku
	O/W4kN/XwbikYEa8INLHle7cqN0IDt+OP5XletBpv+bW2AX1DqNO7AU+OrhUiB4XV8lqWJiIR+5
	CTMbfpIgRVDFrGKZUCscmItfyGfWvoMtmyhDNUOaFY7jxIAQSC+Mc/YgjUDQhIi/NerrTiQAwiX
	WGXZTxHNlnKwA0++vVnuVJ4mPRShmPSSep6IOAoc+zW8ZWBxmlEiM4VPcqe9ITeOyMeFatdZus7
	LcZ+fzuqYNlvdkS5N1kcdYCLHrtUcTp6Ip4kp/LnWLbQ02A8d754Ud0nRbt/xf2lRfjEb+3mG
X-Received: by 2002:a05:622a:2b05:b0:516:df62:bdd2 with SMTP id d75a77b69052e-529d70e2ed5mr75381711cf.55.1785349707679;
        Wed, 29 Jul 2026 11:28:27 -0700 (PDT)
X-Received: by 2002:a05:622a:2b05:b0:516:df62:bdd2 with SMTP id d75a77b69052e-529d70e2ed5mr75381341cf.55.1785349707118;
        Wed, 29 Jul 2026 11:28:27 -0700 (PDT)
Received: from [192.168.1.31] ([85.196.172.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d777afsm92277955e9.4.2026.07.29.11.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 11:28:26 -0700 (PDT)
Message-ID: <e50e3859-0343-4795-a564-757ac58f6cbe@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 21:28:23 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] media: qcom: camss: Add V4L2 meta format for CAMSS
 ISP parameters
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com>
 <20260724-camss-isp-ope-v5-1-e70ad4fa39ce@oss.qualcomm.com>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <20260724-camss-isp-ope-v5-1-e70ad4fa39ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0MiBTYWx0ZWRfX7Vb7lq4RKi8E
 PQmxGtVvv6bUkgAYOPRwBF/LsVcqusl8LjNAzbjonJU3uv6pD2ylXpPH9OjUsBiOgZofEhf+FPF
 xZznAOP+zGRTGaRWLRJ/a1iwdR8RBfvFXAD3sPp9o1klp/s0VA1J5SvZ0QoqjemJYBbrYtl2LUw
 FbbVaS1WeoGv9W5Ehkt4YeV7nP/ExC/bSjBeaJY1RUsSf0W6CRD/HdRYhHVWQ7Xd6UKnafH5NaU
 8GmAV38/ES9X7dtsmV5laS2CkiBrwttYulsAdm1ZocJkWEjnnao9A4Cbj/iuer3ABKCvSfz9bMF
 yiY0lfFYdNJmc29CGCyQoiuuY1cjxMW7KhDKqSaSMu8zlbSqg7kCLb3xk7zMHEu9Q9G8tay7sQv
 f+yQ1H2ULdPzJYi9Rlc+WRX3MQyeJIMfzmUUVkmgLUZDVE9Pn2u+Zs7yZLbXGFFLG1Xu03Kp/bO
 Go/6B7RgXuzIt063x3A==
X-Proofpoint-ORIG-GUID: MqKf2cnQP3Z5mTclwE5LiSqr37G40puV
X-Authority-Analysis: v=2.4 cv=EOw2FVZC c=1 sm=1 tr=0 ts=6a6a464c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Q/e3f29T3Hw2hnAEzBPF7w==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cfCy20KhcoV1EizUSHcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: MqKf2cnQP3Z5mTclwE5LiSqr37G40puV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0MiBTYWx0ZWRfX2YDkdHwopDcg
 RrmGzk/swLXMoOqA+hIKWqbQxVBTUtUkPo8SdfURO+btxHaZM9xBCiB8sgDMqAm3sudIl5DCe8B
 wZ7ToIP8ZZitTuMHEoQQH9IlWX80C3o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290142

Hi Loic,

On 7/24/2026 3:42 PM, Loic Poulain wrote:
> Add a V4L2 meta format code (V4L2_META_FMT_QCOM_ISP_PARAMS) for the
> Qualcomm CAMSS ISP parameter buffer. This format is used by the params
> video node exposed by CAMSS offline ISP drivers (e.g. OPE) to carry
> ISP tuning data such as white balance, color correction and chroma
> enhancement settings.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>  include/uapi/linux/videodev2.h       | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 98512ea4cc5b9d725e1851af2ed38df85bb4fa8c..7b6e9a9a514f037190d55d59409dd6cc97522943 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1471,6 +1471,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
>  	case V4L2_META_FMT_MALI_C55_PARAMS:	descr = "ARM Mali-C55 ISP Parameters"; break;
>  	case V4L2_META_FMT_MALI_C55_STATS:	descr = "ARM Mali-C55 ISP 3A Statistics"; break;
> +	case V4L2_META_FMT_QCOM_ISP_PARAMS:	descr = "Qualcomm CAMSS ISP Parameters"; break;
>  	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
>  	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index add08188f06890182a5c399a223c1ab0a546cae1..011026194a20cde22a374e6fb2570cbc6bced230 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -888,6 +888,9 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_MALI_C55_PARAMS	v4l2_fourcc('C', '5', '5', 'P') /* ARM Mali-C55 Parameters */
>  #define V4L2_META_FMT_MALI_C55_STATS	v4l2_fourcc('C', '5', '5', 'S') /* ARM Mali-C55 3A Statistics */
>  
> +/* Vendor specific - used for Qualcomm CAMSS offline ISP */

It seems that this is generic format for ISP parameters, can we update the comment and remove offline. The proposal:
/* Vendor specific - used for Qualcomm CAMSS ISP */

~Gjorgji

