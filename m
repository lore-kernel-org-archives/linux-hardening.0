Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A130F549
	for <linux-hardening@vger.kernel.org>; Sun,  1 Mar 2026 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772336007; cv=none; b=M0v2Ra9LF2C2+zhRh5LzARl9YLoVemwT8EAAuVk0qeLC98YX2woGKPvRufjRBSikc7bU4txuLx7DDBGSGUE9m0g1o4h9ijd4/t6P6h2J2cNWRsoa6HkeFhCvSSfqb7QxipJ59XwNaMZ9Immxx3WTzWi8RYPYnTWWLTJnrf1mJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772336007; c=relaxed/simple;
	bh=ayLAhF7pHHy+DRWLU0LDkHIehJneX3wR7Rs2/wiMYj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hxhMvKt6Uxw2iVL1h3Ym13swgmt6mekxNQVdH7I+W8I5Xm84gBzQg8B6JfSXUj3KVYcBFM0wRx4g9iz35OsLODlEqzLoC508yq/0h/EAVVlvomlLiWKz16r1Y66cOGXfedaQyL2FfFadIg04M/Dm7IO0fHiAY/YPWtOZUg/Nnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNdPxCyE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNdPxCyE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4376de3f128so2248291f8f.0
        for <linux-hardening@vger.kernel.org>; Sat, 28 Feb 2026 19:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772336004; x=1772940804; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGUtErtO1WheKt0/0USuDzWLghEWqZdNvFs6ivnvkR0=;
        b=SNdPxCyEn5zgt4YjRqNG62ApPSNudN9p6fa7NrUAyyLF7z7Ym5Ij2D0eQCNN/sWkIP
         uaCDPvL4UpOj6DoXdwU9ocfFknQ4Kf150mlSIx6VB50n2UoaKEidajHxtl8YM/wLyq+a
         yG8N3umw31HDo9sXc38ASNgJr/qxixial3FHHl6RNgaudBAotsaunsQRaL3yg6sNaOIs
         aj0O34ahYEU016z1/46A8egdec83HuYss3h2G4iQrELseAzTI8irsqYSkkIOcWVAFUw9
         p/MeJfdqnlCcBBWFWnnK1lokBF1n36H2m2tdMAkFXAd738Cm1B2C0uBskraxom1Nt3b1
         Z4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772336004; x=1772940804;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGUtErtO1WheKt0/0USuDzWLghEWqZdNvFs6ivnvkR0=;
        b=vgLfkF0DFDKKx8MX9awWKgCgdY6Xhj7fAKwV35/8fcQW9IOox5zIlvtL2NpRS9Nbhg
         8PVcyjaRF/vHUSp5VRcboKlPNukpWjCELsgzoh43/WuAioLqOdCDnwfHudrB8aVUxgV4
         EX2S0+ng6o2veWl4xnKpfQfoQMYfN+LdIGKP5wPPhkMAvt5xpVT6SSO1tf6jLHBqT+5l
         ZOn2AZsDmo3inNAUVhUAVzUrZpcPeAFWmy1H6Jpswn39GhxponjjaHkli8bE25au6Koj
         Jc3nJLAKlBSmfcS2fRxKuNpuWf7pSQRErmiYOc1rtkUv2mINNigwPMh2L7jPxku8p1Nn
         2TJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMxrWsBie7FY0aoUAUWom1Oo+zqdadfJL5nkgkFqnDsCDok67XcD6ax4h5edAhHh5d4NlfDDBgTqYQ8PmFxKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdzI1wDmNWeBeQRIg2O2B9sk4REv132HPpAoL4o79gB4Ihi5J
	t7G40WHeR2KUrghZNeQ9qSdzQQbOO6byiznSWRPiEVuugtzcMOt0t5mjVSq1AtjvygryWucZC//
	iUxCecl8=
X-Gm-Gg: ATEYQzxSH25QkJ+s0omgaAHpgPV96bgXEn9kLKwi/KuB5XcE4BagItqzCrA7hWCDiep
	sLgBuA3MyQakNO+mxLurHSNIUlBO11LexGa9rgiIuIQNlUKze11sn5Js6njCx5HISWAebQSyfbg
	TrrFl/XqWHqFKeDjDQl4cAfbKpDZVQP2n4D3mcDcNw4ro9E0Lst3sBOBbTdWryNPuH61POksJzi
	h12rfHMIJNNBYjxTgiPHngvsey8cyY5xARBmfImUCgah83jyxDlczhyU7+N7CJT5XSPsj72lsGw
	huv3LsBq7LV7Gv0CwdHUYYg4TA4SW3A/g1Umof7cz4fpes7cG/6QOW/VfckpbfBJRV7G3WPE/bG
	1K+uEJBCC0cDbdOPhdGKpVCAv0vqoWUq47Qc+e76pq0FCJUM/ksSs0M4h0eHDY3kF8iJ81d1VYo
	8mONAzlfazY9lpjsdkPFvWEQlA+DtIkoyTcE9FVQ2MY+037G7eD6ZAh90wzxCkhbrRne0uCk9wt
	7dSN6mmNzcrM6ar/g==
X-Received: by 2002:a05:6000:2dc6:b0:437:6963:a115 with SMTP id ffacd0b85a97d-4399de2ca49mr12536069f8f.42.1772336004517;
        Sat, 28 Feb 2026 19:33:24 -0800 (PST)
Received: from localhost ([2a02:c7c:5e34:8000:6ece:b3d1:ab81:6eaf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm2970858f8f.18.2026.02.28.19.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 19:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 03:33:23 +0000
Message-Id: <DGR4OFNJXOI2.3QACIHMM1V429@linaro.org>
Cc: <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] thermal: samsung: Add support for GS101 TMU
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Alim Akhtar" <alim.akhtar@samsung.com>, "Bartlomiej
 Zolnierkiewicz" <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>
X-Mailer: aerc 0.20.0
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <20260119-acpm-tmu-v2-4-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-4-e02a834f04c6@linaro.org>

On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
> Add the thermal driver for the Google GS101 SoC.

Is this driver for GS101 platforms only or for all Exynos-based
platforms where we have deal with thermal unit via ACPM?

> The GS101 TMU utilizes a hybrid management model shared between the
> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
> firmware. The driver maintains direct memory-mapped access to the TMU
> interrupt pending registers to identify thermal events, while delegating
> functional tasks - such as sensor initialization, threshold configuration=
,
> and temperature acquisition - to the ACPM firmware via the ACPM IPC
> protocol.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/thermal/samsung/Kconfig    |  16 +
>  drivers/thermal/samsung/Makefile   |   2 +
>  drivers/thermal/samsung/acpm-tmu.c | 643 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 661 insertions(+)
>
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kc=
onfig
> index f4eff5a41a84ce02b12abb85d6a0f8818031d0dc..5679dfa85f4079c7d40317ac2=
31bd6a1af93c7e7 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -9,3 +9,19 @@ config EXYNOS_THERMAL
>  	  the TMU, reports temperature and handles cooling action if defined.
>  	  This driver uses the Exynos core thermal APIs and TMU configuration
>  	  data from the supported SoCs.
> +
> +config EXYNOS_ACPM_THERMAL
> +	tristate "Exynos ACPM thermal management unit driver"
> +	depends on THERMAL_OF
> +	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOC=
OL)
> +	help
> +	  Support for the Thermal Management Unit (TMU) on Google GS101 SoC.
> +
> +	  The TMU on GS101 is managed through a hybrid architecture. This drive=
r
> +	  handles direct register access for thermal interrupt status monitorin=
g
> +	  and communicates with the Alive Clock and Power Manager (ACPM)
> +	  firmware via the ACPM IPC protocol for functional sensor control and
> +	  configuration.
> +
> +	  Select this if you want to monitor device temperature and enable
> +	  thermal mitigation on GS101 based devices.

I don't understand this. What this driver actually supports/implements?
Dealing with TMU over ACPM firmware is not exclusive to Google GS101 SoC,
some other Exynos-based systems has this as well. However, it names
the config option EXYNOS_ACPM_THERMAL but a lot of other things say that
it is only for GS101, isn't it?
Does it implement the generic layer dealing with TMU via ACPM (hence the na=
me)
and adds specific things to support gs101?

Should it be something like this (feel free to correct):
Support for the Thermal Management Unit (TMU) exported via ACPM.

This driver handles direct register access for thermal interrupt
status monitoring and communicates with the Alive Clock and Power
Manager (ACPM) firmware via the ACPM IPC protocol for functional
sensor control and configuration.

Select this if you want to monitor device temperature and enable
thermal mitigation on Exynos-based devices that implement dealing
with TMU via ACPM, for instance, GS101-based devices.

?

[...]
Best regards,
Alexey
