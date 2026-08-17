Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C76413230
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982931; cv=none; b=G5guF9MxIRmPcmC8fq4Vz5mJ566XFIj1l6sCOzY6Uk3AFbATsrhwC4nWLYgP2yekIVw9Hi0GimuJ94J0Hb/sDVUN1O6OBQOuUNoQro1tdOXS0H8atwX97k4YHUAafmk5rNrz6HVD6LConjEJaJvB0NLRqjHT3HHBRudR96PUPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982931; c=relaxed/simple;
	bh=gRcbiXfBc1xHk1KGU0otuDcHYmR9hB18zsIsMVxfBQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riz1RIlnKH+4I7YosDr0iLnXYdpmnFcS/lVH155ByPR2MZJ+sleFnOwOooGd0Uqi6KyKP4G9nM29HVrY8VFPDVCTmiN2dZmwy+nRoEWNSpuSMWgcNL/aoBHeh0kVzMMm9XRHvnsaFp+AOACko8by49AezP+GBllX2nBwJBPEWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqf7ThK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KCl28YUK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqf7ThK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KCl28YUK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYitT2766970
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 16:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4IiNHZhXD4zVpU84b3/87tpD7H4RzexzgSBw04b8Zzk=; b=iqf7ThK8DyslyJpE
	rqqCR3RIH0GrLpJeT+sokLZUFxkBvQz5kh+10LmMNHRvTFo0+T672KVs+ZpQ6PTv
	vroMTmApAEuDU1yg/+0IkgDT/dSaJCHzjNZd1IXqEske4nXRw0cmNBaojohN6yKc
	2VvlUFWMRr32RaxYvPiLP1Y2k6M+88gCeHRWU/HHJP3UKWkYNGVglRoBm+6W2nSF
	iLIkkUz5fPm0d806tN5PmavJSuixsetC1tP1UXOyIxN+fomPdibsIxPuWZWGqR3H
	omfCTWGRW0ubsPXppYyj1e5ijG5qkFubilT8heEDZrKIfMcWePYeWbNiGwkjw1Np
	UxLAUQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wrej4fs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 16:08:47 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-737ddaf8c57so63061137.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786982927; x=1787587727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IiNHZhXD4zVpU84b3/87tpD7H4RzexzgSBw04b8Zzk=;
        b=KCl28YUK/ciH3Uzb+QLV5Cu5b8sbgz0OVnrYPu1uiN4e51Czgln1hznRW8VBO2XMv8
         pQa/+KXXS5AkRNJ+7MGGYtRFEzuYLegJG3gjLLBMeTUDop/yymEys4T+0j1vyXYfwN3s
         xMsVTBJduo2claH1bWH+zuYjCixR5QavJHW46j7UAlfxVRzubtla9Nz+9qnyRtV6Tba8
         phC5evGJvPGtqLa8X4v/qN5rZk2LFHIj3g2EAHujA9T7c1fyJJOg3t6JIFC2iFnwaBLs
         pNZHDvEauxEUBNwy5oQoAlLgX1VHMuc0RxsUsy7skYnfNZPWxmwm9RGp3Z+rxJSYI+qN
         YKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982927; x=1787587727;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IiNHZhXD4zVpU84b3/87tpD7H4RzexzgSBw04b8Zzk=;
        b=ijeGdONdMDxbKAXigj7ozj2ywfpIh1hFTkygDaEpRFt0yWeAz0Q5q+FgBDppBV8MPJ
         WAJhVYmVgk10pbjgx3aZhY/8qmStlXcNBS35W+aifMwD+FgI4axIvOQF6y1oVsyAA/LC
         Xm8o5q/0hqQbTOvQiloGhcdC4OGIz6otGo4hmRC462JlefwQuJG23rWNHGE5JqS9XpwQ
         CXSALpdiB6JfHyWdZed2V0yBqfpMSd6Gdgqk0zC7KCr4gog6BE4KITtyjZ8DksNJ6aVT
         x+XgkerMP+oyMZ9GwmOcq1uHe7QztgscpMqsFWM4lv4joHGr3jmwPkPmoDWbAJLCP/xo
         yqOw==
X-Forwarded-Encrypted: i=1; AHgh+Roa67A+XSVebuAVY6GKoF/0U9zcpcAj5qKQwhyfpxULT5xxCqHEg8+Ivo+svdnP+fEcvusZUbJ38crV0h1dPu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKICn+ylpsJeRkM6djGK4X/ga8aFdZ2KOxo6pq6GATDoWZ0HEU
	e1QWljV70dGhbVRdJKK6+7auquJMI8yI8HE+mmF7WXCjBkl0ECjsT/0G+UdU3QHtXFhzbdbW0pY
	HG8n+B67BydLX8KyDfzorzSBzGVA9fBXxB6cKyaUd2VDIYIGace6FMuDp+vjBPY0e6cjCNv4=
X-Gm-Gg: AR+sD10qRN/502qWeHJwKIiOV+rgY7JzHg57ytmjHAK4d/XnnOi9IEz9RBhdJi8yt5d
	EyIm5s+8rCBO+5B+zO13AFrYaTJF30EU9QiVPFWexiymgtjvZb00vxrdwuGC7X/UZ/q0zLu5xFG
	EsVrpB9dWxHPAfdkiF32pwFPP1QcGT4wDSmPe3vK0rNj6TVm7SHoS78z8MPcj0sUOxupSAxQHA1
	rpy/n1oQ9s0INJSpHhj6wLYmas48V0Rrc64QzLUByi/Z57GxJmpSTQGZicJDXKf6Q1biZsP685V
	V5z/Jm+KpQ7JAZW1ze0D1sm7QMgC/ZUYiiZHiytIlYgQTDxAUTzcRf6G03w6WwLiOnLK2SgAXoK
	fsO9wEhn93Pk8FsLvj6pMuO+d
X-Received: by 2002:a05:6102:a4c:b0:745:17b0:10cc with SMTP id ada2fe7eead31-76f2df883ccmr1649141137.4.1786982927127;
        Mon, 17 Aug 2026 09:08:47 -0700 (PDT)
X-Received: by 2002:a05:6102:a4c:b0:745:17b0:10cc with SMTP id ada2fe7eead31-76f2df883ccmr1649134137.4.1786982926613;
        Mon, 17 Aug 2026 09:08:46 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea2cdcsm77637766b.18.2026.08.17.09.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 09:08:45 -0700 (PDT)
Message-ID: <79c3c201-395b-4a89-bd4f-0e64a59a1fa8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 18:08:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: Add Xiaomi Redmi 9T
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
 <20260810-next-patches-v1-7-79a779d76173@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260810-next-patches-v1-7-79a779d76173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FqI1OWrq c=1 sm=1 tr=0 ts=6a83320f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=mdXfIj6UjNWI-6idB5UA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: ofUMUHlv8mLpJINrK1VuVJ4SuBZn4QJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfXxY1bJ1nLsaGk
 9UjtrhHxhF9J7kDTBMl72rT+DvBs5IV+IqwrTMdBvI8bjPXFIMAytFsmJPhzCnyTkl7vjB1YXLY
 Yvy/aLSzuSSk0QkhnOuKzJgU7frp1RE8xra0/BxyPUrNuEtQSjA2EtAaehEKAeAnXbgX1EbnbZ3
 XSDPho2mzHWVRHn0hhs4EbedRbFTVSPgxF4K9eTwYIwkfkNOd21JM1u3Q4DB9h2aNKkED5uwy2L
 lWdpdWwmoNlWSUt62ZYs0MlJFu4byTh3VP+RLOqXc/ffVx1SdOmRnfsCgHaZsK4jIP3JwG71uf5
 tdnpqtzcG1XPPS2E9ckJ5UcwBAZKl9hpRcEdS50CfUvp75MDXWjcv04lKga0XEBPBrgP0cKJSWw
 ZkeRO3qz8/aK8IGrlUmdIcDNUJfHyIHDQ7l0ij+r9Qjq5AVlpLxFKQbO0icnmLG4hJ11lqE4M1L
 +dIHWGFZsNwu8iGnr8A==
X-Proofpoint-GUID: ofUMUHlv8mLpJINrK1VuVJ4SuBZn4QJN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX3ZCTiovC8vux
 gvCZS+Av9c+sNiWhCoR3IOwRkD0wWL7v34YW/7Hkf0qXl+9YjzvbHN5PJHJgDKyF83CszFBe/N4
 CanKC6WJ7GO7IwKSGNCSwtxi8Ps9cDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170123

On 8/10/26 6:55 PM, Adam Skladowski wrote:
> Add a devicetree for the Xiaomi Redmi 9T smartphone, which is based
> on the Bengal/SM6115 SoC.

[...]

> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		framebuffer0: framebuffer@5c000000 {

Please add a \n above


> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (2340 * 1080 * 4)>;
> +			width = <1080>;
> +			height = <2340>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	backlight_dsi: backlight-dsi {
> +		compatible = "led-backlight";
> +		leds = <&led_backlight>;
> +		brightness-levels = <255>;
> +		default-brightness-level = <190>;
> +		/* Backlight controllers can differ between panel variants */

Should we at least enable it now to make the backlight level controllable?



> +		status = "disabled";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;

property-n
property-names

in this order please

[...]

> +&usb_dwc3 {
> +	maximum-speed = "high-speed";
> +	dr_mode = "peripheral";
> +	/delete-property/ usb-role-switch;
> +	phys = <&usb_hsphy>;
> +	phy-names = "usb2-phy";
> +	ports {
> +		/delete-node/ port@1;
> +	};

I think if you assign the supplies to the qmpphy none of this should be necessary

Konrad
