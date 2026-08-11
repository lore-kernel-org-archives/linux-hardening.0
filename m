Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA9426D2E
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439577; cv=none; b=K6/YDzBX7StsTxkwKtqp+qLzl//MjacfcUuP1xpsXP1HPeCu+06g8USQBBs+2dvIrbxIFdAWCVXoIYxgXvkRXfFSo9ACrYKquRrLGhOeMEBJWOAmsx42hfHwES9/RTKkdUNUoPjreQI3d7W7EKLjMo4iwHFCJoFoTEE3LllQ+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439577; c=relaxed/simple;
	bh=HbMRcUd2IR9+AKd4eYu59PgzfutvcCldJ+T+OmNP+DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWar3p/ix8roGDFVvfXx6aUDPb4mIXZfOm74Q4NoM21kjs4nDkC0fSmkW302fbT0n+nfjwoXChXNle1HUWibdlqqIXhfOoo4hwrwCV/h9m9WsQIsScZFTgtNw1ZZpW49u/ciE4PaTtL/PP6C0K0AcuJngSDzIVKWJLnyoNZam0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJMLAvpE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iZXEpPiJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJMLAvpE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZXEpPiJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B7H8nD3008761
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 09:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PYbmL5om4yZbKjFtuY1xAW57
	q9lUv9Daz0PG1f5WID0=; b=oJMLAvpEVMcJH5/QQVi18Xo05ex0VHrd+zwQzALL
	m3BlnReGzggQuwwq8V70Am/9gghxA8qLKguyBF8l5bXTt5PPao7+TzmKnkoAt8L2
	tF8GrlGWDmyen9iX5rRkO54o/dUgBKrww1B4rO9JWMMGaN0YZDzMj3BOu4es+TcS
	txvYXUMZklscAVVl7mzieiZ19HXQB6vmyIbaXzn9u7NNguKQL7nWBeTBIuGMA92D
	d1DQmg+B5oObe8vi4DXjV0XMvACWxq8X99mWLhI1fY1/g17cwkGg44xfeQIFMfgo
	8vRgMP9lOgHmRhYVBWeyG9vPibrdyBm63jGyM3gJSOPORg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtkbt7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 09:12:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52769fc3f2eso36815151cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786439575; x=1787044375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYbmL5om4yZbKjFtuY1xAW57q9lUv9Daz0PG1f5WID0=;
        b=iZXEpPiJggtp+UtKta41q6wsHFm1ecU2gt8FIlz6udtYz30qkvQ/98LJnDo7nbt3z7
         yVNVWYbWYXRIepsfC7gFaKmQCPouYc/5M5Bl5HagrZfnRu2cK4+knHoy9k2S3dR4ixCz
         XyjgK01aGO6Z77TfQbTtCMkWDFVT7IgsERlNH9q4pmDp717uYEudvEjk1SVtqIboxR3t
         72nxdYeNdQEhSnlTdEGbGRGWmKVkFDHkYAulFer0XecQWWANo0yBDwn6Fqhizpvq4Q6M
         d3ukhW+9V9r7mDAUemONipT2PsOJbRIoGtRaxLIucroeclbSS4MtxuboCO3i6WdcoZ95
         HmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439575; x=1787044375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYbmL5om4yZbKjFtuY1xAW57q9lUv9Daz0PG1f5WID0=;
        b=b1Hbj2IUwOph+9VmfnjmbHfc4iMRNMKFZMUAEoXbniJq04Dkc9Ut9XtYpVnfY8pWLF
         FDHXU2bAgKT9GpzPHogW+B1TZ3OYwi3GEaojNBI7zP5hpaLCIB81Fm06lZBcFSNqhC34
         /7obIxBKGKs30rWBRXLlVgwLeFd5uXhWpZiXEC6R0GkBsn5DtpaGEXTiVhJNFVKyQXSR
         kJMnv72WWF2GzyPf9jwyItfI9fKoTiDCeEI4X6h4n6sOwablaA4YQr8cwnn2wXbOKpFJ
         IFpQOjxc4MJ7GD5PIppYk/CVW2n+MKL1tY/QWDJ6/IjTvfW+2c0aLRMeL8pYmYngdHPm
         n1IQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpo+PvP/xXmYKE+kR34Ey/lK+LFzJHhhJsgm1DRvEHbPM9a6x9FhmxXxLg17lSvpClIphndckwATnb2pE/WkdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Z1tcwGYIhMQo3Ks4GrnKuVZbjCVMJ9f8HxBdrbP1qMEGyglI
	GRkASv8iRs6PqUpHlQTFQyxFRV7DDCVN2tTt/rqaYwMB/Bhu+H6jLOHfDmNQCnKDEUg1f/X1EHc
	8ewVS8dfyU5xPqXlmp3L4pSzRWfkHb9IZCwaVOfJplParlGSDOhd3IgzBKiQHoXtU3eyLqkQ=
X-Gm-Gg: AR+sD12fxDNxsUSHBG1TW6zy9hv/xdL97nNSkpkDSDZSqZct6mOjTCsgpK0HMhCER0b
	sMYzou/hiIAYpNzV0PNOTnPxoMURIWNeKYbd7uFoMzMLYr+833UiJrRYodEdLvZJyw4/PnOVFv7
	Rc7OuIwaNUPkFNFr1p4HdpssLhbWSrHA/8Qw9XoEWP3h+25KTfZOl8h+ArX+DIhjxwky3y9myc5
	P4n8MjMUeM78wUoKYxUlHdB9MzhOOPtuVdqFwEAwYWcBaAkqVNfA7YJoqD9hm8eWl0U+tB8zMQK
	NVEt3J3jUo+EwktShPP7AjZ3GFRbNfYGHNnnAQ4i/ix9Mwiptt51LT9Y/HXwqi/A4qz7wRQAaZv
	Wi4LAcc7EGrBBWC+50ji0BXfz/oXhLyh0pb/w4iYcwVduzT3lBuUfma8LOk8vUZaNlWChnSjQKP
	bQlshc2/9wmXVdig==
X-Received: by 2002:ac8:58c7:0:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52d584f6869mr11929381cf.11.1786439574777;
        Tue, 11 Aug 2026 02:12:54 -0700 (PDT)
X-Received: by 2002:ac8:58c7:0:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52d584f6869mr11929061cf.11.1786439574399;
        Tue, 11 Aug 2026 02:12:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa6e0eb8sm1307051fa.38.2026.08.11.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:12:53 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:12:51 +0300
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
Subject: Re: [PATCH 3/7] arm64: dts: qcom: Add Motorola One
Message-ID: <c6zmjiwf7kplcu5qjb5bwq32ddppzexqturyhobrjwrr3c374c@nrtwenzvlkj4>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
 <20260810-next-patches-v1-3-79a779d76173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-next-patches-v1-3-79a779d76173@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NSBTYWx0ZWRfX+4zUp74nS2bS
 7mPIcpvLsmntJvpBZWa4+42jMmAA4fQb6PQiTeyR5PJFWfPetoOOkRLR432/zrwSY6sUEQxlX/I
 4YTjm7MoivWV5yUXJyLwjUPs7rM/Sb+s538xFaDMvvNvXTJjgQOmg11VUNNCf68Qi6rkmQs7t6t
 YQmBaIj9Ozgu9SY92rcqsGJssiuXt01gJJnnLg8mjwMZqgbD6kijnoyMQxBrDEwiZ9T7DnwN+xu
 aj+Yc2YUvfIuC1Z1zBwE5EzHBQah/EqFoIJSjFzOQNcGdqZye16OSwVslymLYy98pbO7yU4j0Oz
 5usJ5AzqjpbXI1dwo0LKEwBCkyLR0fGuuvHiMvjDPPiWVddm6kMYRfCbh3Rv9XptgA3YUYCHXFC
 zh5UuX84It494ZAxF8rQ9mZcWHOvs3H9ob1KmBem2hDNw1/naFVkJKWRF2jDabgdZdoIcfS1oVq
 uqmBKPtqNAF0s/XWJFw==
X-Proofpoint-ORIG-GUID: A6eU7FIiV2fw2EJ4nFDi1bbAqNlqGtDF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NSBTYWx0ZWRfX6UoINVWXu+K+
 Zi0+WSjAIuKljn/WOrSISAmf4wD2+Rb9FYoEVw2nKGOd+UW+eh1l24CHWVc568yP/A5d0SgqLZe
 bpnQolGlJ8TgWFzfY1JfH42GLH6MJqA=
X-Proofpoint-GUID: A6eU7FIiV2fw2EJ4nFDi1bbAqNlqGtDF
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7ae797 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=Az-PErcXXn3KkYGSV6QA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110075

On Mon, Aug 10, 2026 at 06:55:36PM +0200, Adam Skladowski wrote:
> Add a devicetree for the Motorola One smartphone, which is based
> on the Jacala/MSM8953 SoC.
> 
> Supported functionality as of this initial submission:
> * I2C peripherals (Touchscreen,NFC)
> * Power Button, Volume Keys
> * Regulators (PM8953)
> * Remoteprocs (ADSP, MPSS, WCNSS)
> * USB
> 
> Device tree also contains supply maps to other subsystems like MDSS
> but due to missing dependencies like panel those are disabled.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  arch/arm64/boot/dts/qcom/msm8953-motorola-deen.dts | 443 +++++++++++++++++++++
>  2 files changed, 444 insertions(+)
> 
> +
> +&i2c_1 {
> +	status = "disabled";
> +
> +	typec-portc@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupts-extended = <&tlmm 9 IRQ_TYPE_EDGE_RISING>;

LEVEL_LOW ?

-- 
With best wishes
Dmitry
