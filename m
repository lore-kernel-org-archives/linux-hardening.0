Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48C44D6AC
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575940; cv=pass; b=DkEGb+en7MhTXJZYPZ4WrgqjxIQLDuB6HSWrhskmV/nzmdzVA2RaUKc2h49eTXXZL6ZVCA+uokgDVNto2Jh5yd3TA9OhSc5TerTCHDEEHHB58+vR2PXKo5965inCN+r0xD2rUZC6wvBEF8Bkv0M+LHqIvgo2DGzvQ8UYI1x6gLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575940; c=relaxed/simple;
	bh=QXg9S3LANuU2Vu2CwL7ml9RG3pg9mmdQqBn/HO6HYQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng5X6ejTF2t5AcHdg6HT2z2v1UyEz7GLWy2YGeY/NUhXWZnGCCK3D9F22y2BA664XM4XK/MEM44PfNso6QrSBNHlqD4SLvBPKO9kEVu7NgsFGDxE+0y6OmMH6yhVDHr1dHe/VMhKg6nvGMV9SBgblVzbR8P7HbXHqx+9ziLnhPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNrKS+F5; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNrKS+F5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso724546a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 04 Jun 2026 05:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780575936; cv=none;
        d=google.com; s=arc-20240605;
        b=Ps7TKpHPu5QUXvfmSsHeA32GP7JdMUQFWRtY/ncQZq/uWd2Njv3SDS5wrNegEZOiwT
         XJtjU8Uf79QezshuenmLvrmYYM82ZEYjmEVbs0pxLskeGDkH0EqvLTbo9BA0YJL3j5zC
         iPpiKjG1cPqKI2pW6QfWtQWApi+12TwjUcx02s1c1WuHf/Yzn6S+YHlvT9okVuNezuuW
         4CJ8Sbck3F82THYW/9ZIDcICTeopyrfxDEV9/8E2dMbsxxQZMCZAeAWZ6QNPDJVzdQaL
         0CI+wT6a+7GluAnKJmUVf/6Zmz14pyg+N09lg8mLhRbwyLe0EM6NKrifXZ33r1xX78pR
         LOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=knW0aQIBp4ONXOIx4MTZpzmtpQjVdTKmzR82B1HLZdY=;
        fh=yAFFnbBZ+oBid/uOFlv53R5X1va46WBI8cOGDbCci5s=;
        b=AkbRop8bk2unasBS1Xo9XlqeKLAlsfR4o67lZnP8AXZdhoCmLgysVGSD+ZxziLq05Z
         EZ7c/7OPtsVL+RuZla+qcDGi2zz2kMymOwJya5MbnnXDY0dGBoGgqhkSnhkhhsucBA6z
         U4OiqTGZbwd4VZO1nzqCrxRQiW5HbcT8GOL/M0Wc9ovaJUgTRZZ501EdWAUV8bDc3lcJ
         6P7F4Dgy/6k2zTpl/myVaHzrNvTlQWdr4JELmxZ8Y6D+bZ+/UXgVkuZ780VPFNNYswyu
         YLZUIW2K6RnBmt+lPbJ/iBOwYct7gofArJMkBV6kdSxYBOxKjzOeiSKKyE/81998SJhb
         6eSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780575936; x=1781180736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=knW0aQIBp4ONXOIx4MTZpzmtpQjVdTKmzR82B1HLZdY=;
        b=VNrKS+F5Q/MjcXlX0j/M0qvcolEc5C8XWATfjY3gaaCFWwg2vK2Evo3JIiAMObMPdY
         5inFXiO8SfKHFAuzsDNFOwybZV2xkgMrXpJxBzRgKvXINWORM0AVzr3LNLKefIB1xR9M
         OJDyeItVdF+aMiCL+PBnBbP+qS+Ao3Sc7SGxbFnLCN7HlYT1KYxSA3Cxdc3+2AAQwbG7
         IFXA5OCQXcSr+mDSwVxdUirtrs+ESNJlBPb4G9ZWZcPWdB6hv9I5hJYIBfgORf0zzKjb
         QU2tBJh+3O2/RFVFsJFDgFNowFbj7Dgn0ZL0eWjfHtZTiSyst1DLTalXaF/vlr8xDgyf
         0B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575936; x=1781180736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knW0aQIBp4ONXOIx4MTZpzmtpQjVdTKmzR82B1HLZdY=;
        b=raW+JnzTn830uscUrKVGbrO2h1JA7z0n53MtSeKmvNd8+dFXFRHHbEzw5GiJS0pSB4
         whYbQWpnPRK4Dy1zMp1igCV3EvvSuH0jRsOYkxCChSOCKgw5XSV/TfAs1CG5DGU+M7jV
         HZREuiMPZwZERSKU0nzuSap5srsOV4YwOrrh4hC+jeJ3RDlmcc6et3AABnjZY4CIpI44
         uUBSrfUJ/b7ZUE6cR6tmtW2uPwaLo78/naTRiQH2FRSUKKmYy0Z/QEuKJL89tmiQIl1o
         tIu6bzWdPGI6T/PpmHBZKNb6xilZ4M2VNRr6xVvrslX8tt7RHUw1DU8lSHjHbYJnT76r
         9L6w==
X-Forwarded-Encrypted: i=1; AFNElJ/pxc5FuFUCuxSOwtVphzED3+VZ4RK6Zv2L7IC1gSKE/beiI7KU9dwhlFqC0kiIFxUq5vaxRnYBTUje36ZeB4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTXBlRMYQSLJn9l8iEnFjpD0FaH3yNdvJ78+YVF7gbFHlRwpG
	Ept/wCXFFWkCwGXn78M+Q6uPaAo4vu+BlzvkK47VfoQ4+xR5EDSZhl9H+1O2dzOZilTuiEDdS1x
	QKgOWLuHlO8+EuY++t0PigrdcmQL7w+itFxPg8EjP+Q==
X-Gm-Gg: Acq92OFGaT/WFhkFlpMAGTsMrm6cwVVE0Hij9bZ5iKwsSzbxajq+Rlv3n0++hTYzNSO
	IIW8q+IgbmxthgwzvR/yrMWBRuCMPqSZIG9vyJg2M+ILYAYHFAb3ybprK/IvDucHyniXmVbjCy9
	lzjtK/9ryvd6t4s2zRCUcKiuIm26zjEiO5J1AnQlRyOewXU8ePuu4kjk+hPRoaLnsRa6SOvcqPF
	dGRZpP/NExeeRlRr0aF8JL/d63Cgp17ognTr278qOFSKzedNekj40DrBRsaVS+8Qr6ZyoNSWMRc
	83rUEvT3fVWiK1wSW9cNgrJHHz4jdrQaB55WxOpqA3/cKqHl
X-Received: by 2002:aa7:c3d8:0:b0:68c:3439:945f with SMTP id
 4fb4d7f45d1cf-68f0f3ef6c9mr1109192a12.12.1780575936462; Thu, 04 Jun 2026
 05:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-5-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-5-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 13:25:23 +0100
X-Gm-Features: AVHnY4J8PoxEVn9YHkIV62f2JcL-eq6_poQLFyumkGxMP4pQHp8fyUwqwpP8j1s
Message-ID: <CADrjBPqXnv97XX2y-_YKi4=NCJw5CcaBd5b9ibQEHLZ5N6ZYkQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] arm64: defconfig: enable Exynos ACPM thermal support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
> to allow temperature monitoring and thermal management on Samsung
> Exynos SoCs (like Google GS101), used on pixel phones.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d905a0777f93..3fe76a4c2633 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -793,6 +793,7 @@ CONFIG_BCM2711_THERMAL=m
>  CONFIG_BCM2835_THERMAL=m
>  CONFIG_BRCMSTB_THERMAL=m
>  CONFIG_EXYNOS_THERMAL=y
> +CONFIG_EXYNOS_ACPM_THERMAL=m
>  CONFIG_TEGRA_SOCTHERM=m
>  CONFIG_TEGRA_BPMP_THERMAL=m
>  CONFIG_GENERIC_ADC_THERMAL=m
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
