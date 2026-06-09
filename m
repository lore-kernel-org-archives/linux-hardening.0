Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D74028DE
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005927; cv=none; b=KAbcvrXNxeduPWjUY+zbktiYiPKpPQEazfrsk+/VqPUVAwct+OSD8tZ3YXMM8qRg7tGB7hEn2qkpyhRNl39QhwNejw6ZVvYgrITM9DjmoVnD9qf8y89+RcTz+8PY/yq/C1nmfXUOyP3ZO950JP1CNHwnHtUux4GzUjRt1yJE8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005927; c=relaxed/simple;
	bh=V0cxqAubJ6QT3mDQJiG+LniCIaTw7Cb6nFwnYjJCgPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJjtFLlb8miLvIsTv2MGxNPnnFfE33zekOijdNdZM+7Pe9nW1bn4PsWIStsDcYA1z2BSP3aPDIjAKFFz81OeG3F6YRgXsLAMh2dsfLR8A2zKiByT0I2KMbJKy3JdjRHFCclmIz/x3xwKF+PfyF6oz+eJ4REzWW+ogRzsEcykI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOH+VyT9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOH+VyT9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-befd83e0521so1158016466b.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781005911; x=1781610711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qh57ithdNaKLyKzJTn+bCZN9e6uxSJT+tkkVV1Puba8=;
        b=FOH+VyT9xEKbu6IWxcRRWvbBOc4pUiHnCvLgH+0Okbl4v9UNhkwko8KaN72jvaPDnZ
         ldDUMpvgJ8SCFf/VD9CgPO/T1+Thx/B2ABb8k+BtSLVMDSbK+4/AhF2mznW7tVZ1W8ZD
         gW2st3hsaJOBGJuExbYJRNFHPtParGC7GnW7YwpbGaEXbgULUoJkPVpgvaP8dy4h8hJZ
         5XKqZ+o4D8GHE31wlg24NSu1EU1eW0tmW0zn0pt672Aqv+bsaGREB7qihnBNyYhVBQVE
         +6D7+jxJ8cn6WQSn2hdarhOZmMAozy0o9OauH5XopxPKZJSloSBa7xIsMZbmky3UKgCD
         yZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005911; x=1781610711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh57ithdNaKLyKzJTn+bCZN9e6uxSJT+tkkVV1Puba8=;
        b=ZcD6PYKNyoh+b9Q2wc/Tf/ZORZVNT3b1QxnrDpCodcn6g6BRCQ69tiIA9GWHYMCnuj
         62Ad4nLd4QFSxsynj77FQKCMNvDg8OQ5dn3AWNh6v99GHJwyZ/AaIjcQ9K/uJAnuDaIG
         8aPWi8VD9Tk1sQvyIkNGacwWCBz4kRcfveuLd0l91NvuAwTOkGwUU4CUo/QsIsVn2WLR
         FtSVnYQN0B6oFlLCNMjaeooP6Ai9Lv6mplB+bQg8hwahyBR9ucv0fgrYorZjw23zSpil
         1qFDaQ3xSwVNPOpYaPEWCiyPGMvZkG0xk6v9iPKG4z0uExlCNfRB6ofbHZMEESEwlstx
         O6Cw==
X-Forwarded-Encrypted: i=1; AFNElJ949cLuSs4ucnR3RyVRvopTAJkmuWVD8KWOo5InBTDb1bBhG/tBSprXsly4UO52To5wgrl6X3uIiupK2HzTzUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu7b9/zVUHxVWgLmkvGtIV5rI4KEl7O7rIJ/mgVz/RsMESDXX4
	BU3+QCjy2RomOXQCi9xDROOmiS+KcMHiHRpvj9s4X4M9IlKaIkKzzV3ySk7y4UL/gaY=
X-Gm-Gg: Acq92OFhDXQgp43WMs63T52rXpWMjBlrTgeQiVvqpnpAMA7i6+vcuWkIDCPuLpLoJrd
	Xamfrmzx5htzCC9hvM0iF6LSPe3c4qlsmSFV7UrUhAx/hOXTv5hmiSE4SnqJlyZVdRTTfAQ4YxP
	jwsOh2iq4mYrcg5HNBGHRi4I4eMHdsTH66xuqnRGN92Tq5xp3+I4tydCH1AOy0JThGI9ryBlsmd
	6HhbJVRuduw5CyzoM6eL35wmjumiA2l0tNiqZGfSd9WhQtpPitAFXyvSamlkkSKbI0aDAN0DY/X
	MENBv933V7w9zJEr+RaVduB/Bz+PjEWwqBU28wuh+HAmC9TJcHHEJFZBubz7h74PmgvHHJ8u5Ks
	j0KxnAeL90EUoAv0CTwZcty0MdfvsT7uX7iumVtM+f7lQWl9In+hS5sdoxNSmFhopU4MPlDtAbH
	Fhn+1+azkaZLaRUY+Sh+AyoJKJkDHycMRMLDXxQ6VE8/tS
X-Received: by 2002:a17:906:5a69:b0:bc5:2352:555c with SMTP id a640c23a62f3a-bf3a841c5c1mr624677366b.14.1781005910578;
        Tue, 09 Jun 2026 04:51:50 -0700 (PDT)
Received: from [192.168.107.26] ([80.233.69.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553fd86csm1037260966b.46.2026.06.09.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:51:50 -0700 (PDT)
Message-ID: <5d6f1195a7ba54d41063b44d3907b7a22f620ae5.camel@linaro.org>
Subject: Re: [PATCH v8 2/5] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui	
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski	 <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva"	 <gustavoars@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar	 <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski
	 <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 12:51:47 +0100
In-Reply-To: <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
	 <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-03 at 13:00 +0000, Tudor Ambarus wrote:
> Add driver for the Thermal Management Unit (TMU) managed via the Alive
> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
> the Google GS101.
>=20
> The TMU on the GS101 utilizes a hybrid management model shared between
> the Application Processor (AP) and the ACPM firmware. The driver
> maintains direct memory-mapped access to the TMU interrupt pending
> registers to identify thermal events, while delegating functional
> tasks - such as sensor initialization, threshold configuration, and
> temperature acquisition, to the ACPM firmware via the ACPM IPC
> protocol.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> =C2=A0drivers/thermal/samsung/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 19 ++
> =C2=A0drivers/thermal/samsung/Makefile=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/thermal/samsung/acpm-tmu.c | 651 ++++++++++++++++++++++++++=
+++++++++++
> =C2=A03 files changed, 672 insertions(+)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kc=
onfig
> index f4eff5a41a84..bf9fb52e848e 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -9,3 +9,22 @@ config EXYNOS_THERMAL
> =C2=A0	=C2=A0 the TMU, reports temperature and handles cooling action if =
defined.
> =C2=A0	=C2=A0 This driver uses the Exynos core thermal APIs and TMU confi=
guration
> =C2=A0	=C2=A0 data from the supported SoCs.
> +
> +config EXYNOS_ACPM_THERMAL
> +	tristate "Exynos ACPM thermal management unit driver"
> +	depends on THERMAL_OF
> +	depends on HAS_IOMEM
> +	depends on EXYNOS_ACPM_PROTOCOL
> +	default ARCH_EXYNOS
> +	help
> +	=C2=A0 Support for the Thermal Management Unit (TMU) on Samsung Exynos =
SoCs
> +	=C2=A0 utilizing the ACPM IPC protocol, such as the Google GS101.
> +
> +	=C2=A0 The TMU on these platforms is managed through a hybrid architect=
ure.
> +	=C2=A0 This driver handles direct register access for thermal interrupt=
 status
> +	=C2=A0 monitoring and communicates with the Alive Clock and Power Manag=
er
> +	=C2=A0 (ACPM) firmware via the ACPM IPC protocol for functional sensor =
control
> +	=C2=A0 and configuration.
> +
> +	=C2=A0 Select this if you want to monitor device temperature and enable
> +	=C2=A0 thermal mitigation on Samsung Exynos ACPM based devices.

If you're sending a new version, it might make sense to add a brief
clarification to the existing CONFIG_EXYNOS_THERMAL in that it only
supports (the older?) non-ACPM designs.

In any case:
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
