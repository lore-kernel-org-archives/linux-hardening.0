Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D739449C
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483266; cv=none; b=Y4yB19F46/10SJM6r4WkcvKNP6O0v8YXepZY+L4JkYBBsrTtohVrDPh16AitdKSf6i6P8uWVsehi/nQdi9wu5fSvX5QupJACPNQevNqcpE5TGaOVZG01Oo+ZkCJwDc8jQokZRc/8w+oB14NZOQfhK8t9S37RvwCthAEce4//H/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483266; c=relaxed/simple;
	bh=abcUDzMsgI0NC3SXlFQOTmLmr7KJcSauM8GeBtGxewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPwlaVWuD9+fdcTlsjY3cY9hsmznKlCKNvuwBaipPGOsvkffJh3wFZ9PhG8dLHHBlhTAXnIOlDkVm06O18Z5qhATEaML194qGy7zhFHXMyTAJpzSMlFMPUqC/cfUQa5SbCZDRFueXMvR2dDqbwc6QPgSHY5ZpxgiqVCfpQH+hWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlAon3Pp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlAon3Pp"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b876b691fbcso182706666b.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768483263; x=1769088063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=po4SDkFceK6L+A0r9CoW5e+XAeuKVFUf0lqkYgvkprY=;
        b=jlAon3PpurmiNxWJFMaLDcAYNMKICmkJqYtl9t8bvsbkTI8e2QStLKRG0ix0u4K+Xf
         FBT0a6gsS02xlw9J3T2s8hOvnUqxmYldl+HR07gQZ8syA9WxINMNlg2I7+46eHx95N4Q
         LzxwsVNdqW28NDIhereW4XkwFVDmmLBCd2en05MpuevG9pYEQ0nS/AGeiahTOclholuP
         4yaVkClhSr7kTI/5eyV782R8c5LteKYjKeNkGxayIFTrgY7FBixIj3B5KPdpEIMWXwah
         fJ7qqfSHUFEP5zEHILOd4i446EEYZ9HFzFgWPMFhNw5opMHvTIwvXZmg0Gnorv+5R2J9
         HArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483263; x=1769088063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po4SDkFceK6L+A0r9CoW5e+XAeuKVFUf0lqkYgvkprY=;
        b=Hx2+v9n1w2QtCnLND6/rn48/yNF1n8KK1phCYapprkcxOmRtqcbbDHqA8hAHZfUDs0
         RknSA6Ydj3BxpLqWuGZF6KTbhRI2HMWCV1+fAOhQFShD/xtNs4HWr+nWTzOwQSlIVt4C
         byqbZMnwZ2fs5+yuWouW/OZDG+vKpw3g4hJfX5Lexp5uyuxzmz4TdgQuHVp+mCGXCrtF
         NU817n63+/Tcw2iAN7myVs0Xwj/fMZbmhbmOmoytDMtrqYsDOyheL7GqUK3X23To6lWq
         aeeqbAb/0lN9Gqvut/ghbsQlKUQ1cXYRix44IFd0MRQZjp9q8KMjNhyzkMQeKzK1lNKv
         l/7w==
X-Forwarded-Encrypted: i=1; AJvYcCVh3b2kNYa9DB7ufinBPuN3lxGP9S/Q7x7ssrWszgkEAhSxdolY8rdm6S3zad2WRLDDajMxWLMs6UEKfTsyw4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzukspe6kkYsci8GNYnvQ5AJv1Kt8mcy6S585yitVegkCTjoIW8
	GTmo6Iwf083svwrQD+DCDkwe2sVJFbQRCZ3zMtjr2u0IVp7jUqfTuFnQi8TMOSbx3e0=
X-Gm-Gg: AY/fxX6QdWp62p2NtEniGsPvY27c4/IsvfHYMg4B9ms9cgHgK6RlOd2HrzqMTggwVno
	s88iwljOVL2sHJmQoGVw/JR9eCRiW8jBej2JMbx/lPZ4syf3N1ttqI03jmVUketvdPyUOfckTh/
	LG9bLFLYUC14aCbdh/orHxeLv6bV8cvuXVn0Yp7iwRwwGdbF8ecxHJdfUwVsXigjFyR9eUdzwNt
	3exNFFTYWDtt5WE3Xyle7+Ts5qkbgxz99X8xwwyJRHFsVWFxiDVeR2C/RanwRvtZ5c2QPOC/SlJ
	uqW7TT/EPM3fhplU3uumH8Rn/CUc8067iBKec97joSPHIb7B8SiGlghvlHdo3Qv5n1Vn5+2SoqF
	hNpwMWZ+RJzM+meHGtkoZhNYmfsgYEi5R5Js7UlrOE03rOR2atESnq46YVw/t8xZRIXG5zAmAkm
	xHTCbYHFnA5Gs/R76S4g==
X-Received: by 2002:a17:906:f58a:b0:b7a:39a2:7f50 with SMTP id a640c23a62f3a-b876113a364mr534982066b.39.1768483262801;
        Thu, 15 Jan 2026 05:21:02 -0800 (PST)
Received: from [10.11.12.107] ([86.127.43.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8767042186sm467121766b.0.2026.01.15.05.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 05:21:02 -0800 (PST)
Message-ID: <f7d75089-732b-42c8-a5f6-2e42e6e82c26@linaro.org>
Date: Thu, 15 Jan 2026 15:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: defconfig: enable Exynos ACPM thermal support
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-8-cfe56d93e90f@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-8-cfe56d93e90f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 4:16 PM, Tudor Ambarus wrote:
> Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
> to allow temperature monitoring and thermal management on Samsung
> Exynos SoCs that use the Alive Clock and Power Manager (ACPM)
> protocol.
> 
> This ensures that thermal zones are properly exposed and handled on
> platforms such as the GS101.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 45288ec9eaf7365427d98195c48e2f8065a8bb1b..1bfe37857f51663c9d745cd575f107fef183008f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -752,6 +752,7 @@ CONFIG_BCM2711_THERMAL=m
>  CONFIG_BCM2835_THERMAL=m
>  CONFIG_BRCMSTB_THERMAL=m
>  CONFIG_EXYNOS_THERMAL=y
> +CONFIG_EXYNOS_ACPM_THERMAL=y

I should have made this a module. Will update after I get some feedback
on the rest of the patches.

>  CONFIG_TEGRA_SOCTHERM=m
>  CONFIG_TEGRA_BPMP_THERMAL=m
>  CONFIG_GENERIC_ADC_THERMAL=m
> 

