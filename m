Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71D210F45
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001641; cv=none; b=ToOd4tJU7WYm2zJr3T1te5hr/1VKvHJXqYcqjYindmEcu9VOPvxH+gBfRK7f7nvK4n+9eUfDdRNPJA0/BAAyEWryGZ2r+bOV+QSnb1yEGE15an4W+aMEPi7hlrty4Yi0LB5cm87wYI1VWQ1SSuGvYOc/89zwKD5eUkvftmdYqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001641; c=relaxed/simple;
	bh=nVqpkxvrkBQ7m9ihCa5HhM6ifP7VLjbv7c8Y8Iyf2ME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3DWJR6vJqcB2OpYk4cByxrA6IQslSuLKmm78Rcyc0ABGdij+GtZ5z10U/Cj/dZsuaU95VeFwtzd5ycAftNLKClM2dgoLmnGT3cMEfjKE8XMX8RfpUXQTvrm5yVb17fvG5/5jm822dhODYCd+j5qhcohrYiQM6j/WEsddNJObaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sfaMJUWz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfaMJUWz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a823036so68259355e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746001637; x=1746606437; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tM1VuxlxmAKqV45c2DIXsj1+JXKhlzv/Nid4UniVACY=;
        b=sfaMJUWz8kT8rRnUrHyOUvJ5MQYWTcXy448bp3RjUNheVoWgb2MTjYTsTkGZXb/cUb
         gUf/QtclDDN6BIcf2+0t9vTXcr5CdXJJaXjDRl3rQNhD0Zj5Nccp2YqNZ1GGjg/QrBHY
         wXdB0DU4ZV+wZ9vplzMJIHPi/luM0jGwr9DWQlpb5S9ElOuFkRJnY7H60nivQvvSNLC6
         k3vG1wr/y5QJcvZ5P3fd6EyOOcirBcoOEjIHnMhSpMmpfojeA1SXb9BZJ2dxORW1sL0g
         JSLhBq0V/xcbvDTH3NiPZOny/bUVsmoYnl1r3wQzn/2/KByWQm4vSB17gbpJFKbeu0bA
         tGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001637; x=1746606437;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tM1VuxlxmAKqV45c2DIXsj1+JXKhlzv/Nid4UniVACY=;
        b=oL+eBCWI6pEzA1LsYfLWy/fx/S75AZVyyKAPds1s0TFcDMBR4SAXzlVgGMEPevA1lR
         RnBpWa6b/gFISvktl6e+bSo1BucxMy7OXJe1AQ5babn2Lu0RDOuC4mIuiHGSR1rWT+fV
         CQ+LmuLSUyruwXh+cvuqm+pc/S0sF+iXbgIivjpGai/9+R897Jn+jTet2sMHCX3nC7OJ
         UyHFEW7VaQYqAmoXljyN4RC2dTN1AWmjahsR9jwzaV/xPbqxlARacGB8ewEs9HteFA4x
         LgLjjt2nYVm7/0gBQb717KJVaxGNuOY++grhTRwgxWiqgVVr5pNEblr9QxKmt3YoERs0
         uT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC7y3W5bP4SxDnnn9uUN14RUZPocTgzXUBtJwh610izY9QP2p0jnEKmlUYIK7pbVnFJNUWDxjPqE8G6ZQ+tLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJiE3vql9Ra2YbzT21wLH7pVmuVtEJ0X5ECD00ylm6DpuJH91o
	X3t3TK1XjDyFNcE8SKgOORJJhzECYzaWpzocu1mf2fquGIsMn5V2Sg9fhN86+9s=
X-Gm-Gg: ASbGncsjvTUOlG4CdLquhbu8G9dFWu/FBYLQr/8uwa2WvXY/+bMzQ1cz3tVTvS3stqc
	FCHRfUAj9HTfQeljk9pHysM897DCu+zfQMTzgz0L7KOzFYpM8/WARZBxKN0ZZBX74I5jPwzKrM2
	jICwTWothTPb3/P9aKWaw44DxYoqCrG4pUKj1f7sigA//nyiSHcvO5zC0JvvJdVplTvxR0q6OTw
	0cnJKppX7ys27VsJHyoB0i03ozZGv9IDq+jT7etnIozpUdQi10aGhBLKfsPHHVYamFkpAFZdPCv
	T3ulgDfyEMytVCf340X+Ou3I64LlMoZGJEyH4b20dIoP
X-Google-Smtp-Source: AGHT+IG9+mBoVfuFZsSy3AwJh8ZczldRvcThwYGVbzvcL8YQZRS+lmMJMo0olXC03NYW48gy6CBSeA==
X-Received: by 2002:a05:600c:4f53:b0:440:6760:d06a with SMTP id 5b1f17b1804b1-441b1f2efb2mr14215575e9.5.1746001636943;
        Wed, 30 Apr 2025 01:27:16 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2bbbecesm15466895e9.27.2025.04.30.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:27:16 -0700 (PDT)
Message-ID: <bbd392787a28743a499312069c51f083929e546f.camel@linaro.org>
Subject: Re: [PATCH v8 6/6] nvmem: max77759: add Maxim MAX77759 NVMEM driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij	 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Kees Cook	 <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Will McVicker
 <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hardening@vger.kernel.org
Date: Wed, 30 Apr 2025 09:27:15 +0100
In-Reply-To: <aBEtzh8w5PZKSntr@srini-hackbase>
References: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org>
	 <20250429-max77759-mfd-v8-6-72d72dc79a1f@linaro.org>
	 <aBEtzh8w5PZKSntr@srini-hackbase>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2+build1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 20:51 +0100, Srinivas Kandagatla wrote:
> On Tue, Apr 29, 2025 at 09:21:42AM +0100, Andr=C3=A9 Draszik wrote:
> > The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> > includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> > Port Controller (TCPC), NVMEM, and a GPIO expander.
> >=20
> > This driver exposes the non volatile memory using the platform device
> > registered by the core MFD driver.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > v8:
> > * replace MODULE_ALIAS() with .id_table (Krzysztof)
> > * drop previous tags
> >=20
> > v5:
> > * follow API updates of max77759 core driver
> >=20
> > v2:
> > * align sentinel in max77759_nvmem_of_id[] with other max77759 drivers
> > =C2=A0(Christophe)
> > ---
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> > =C2=A0drivers/nvmem/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 12 +++
> > =C2=A0drivers/nvmem/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0drivers/nvmem/max77759-nvmem.c | 162 ++++++++++++++++++++++++++++=
+++++++++++++
> > =C2=A04 files changed, 177 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0db5e1fe64930e85265913e6a7dd2669c645cf42..b821502afc48f95d48fb8c6=
ac6941d1dd8e63582 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14670,6 +14670,7 @@ S:	Maintained
> > =C2=A0F:	Documentation/devicetree/bindings/*/maxim,max77759*.yaml
> > =C2=A0F:	drivers/gpio/gpio-max77759.c
> > =C2=A0F:	drivers/mfd/max77759.c
> > +F:	drivers/nvmem/max77759-nvmem.c
> > =C2=A0F:	include/linux/mfd/max77759.h
> > =C2=A0
> > =C2=A0MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
> > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> > index 8671b7c974b933e147154bb40b5d41b5730518d2..3de07ef524906ad24a89e58=
abdfe93529a83c80f 100644
> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -154,6 +154,18 @@ config NVMEM_LPC18XX_OTP
> > =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the mo=
dule
> > =C2=A0	=C2=A0 will be called nvmem_lpc18xx_otp.
> > =C2=A0
> > +config NVMEM_MAX77759
> > +	tristate "Maxim Integrated MAX77759 NVMEM Support"
> > +	depends on MFD_MAX77759
> > +	default MFD_MAX77759
> > +	help
> > +	=C2=A0 Say Y here to include support for the user-accessible storage =
found
> > +	=C2=A0 in Maxim Integrated MAX77759 PMICs. This IC provides space for=
 30
> > +	=C2=A0 bytes of storage.
> > +
> > +	=C2=A0 This driver can also be built as a module. If so, the module
> > +	=C2=A0 will be called nvmem-max77759.
> > +
> > =C2=A0config NVMEM_MESON_EFUSE
> > =C2=A0	tristate "Amlogic Meson GX eFuse Support"
> > =C2=A0	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index 5b77bbb6488bf89bfb305750a1cbf4a6731a0a58..a9d03cfbbd27e68d40f8c33=
0e72e20378b12a481 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -34,6 +34,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+=3D nvmem_lpc18xx=
_eeprom.o
> > =C2=A0nvmem_lpc18xx_eeprom-y			:=3D lpc18xx_eeprom.o
> > =C2=A0obj-$(CONFIG_NVMEM_LPC18XX_OTP)		+=3D nvmem_lpc18xx_otp.o
> > =C2=A0nvmem_lpc18xx_otp-y			:=3D lpc18xx_otp.o
> > +obj-$(CONFIG_NVMEM_MAX77759)		+=3D nvmem-max77759.o
> > +nvmem-max77759-y			:=3D max77759-nvmem.o
> > =C2=A0obj-$(CONFIG_NVMEM_MESON_EFUSE)		+=3D nvmem_meson_efuse.o
> > =C2=A0nvmem_meson_efuse-y			:=3D meson-efuse.o
> > =C2=A0obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+=3D nvmem_meson_mx_efuse.o
> > diff --git a/drivers/nvmem/max77759-nvmem.c b/drivers/nvmem/max77759-nv=
mem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..df7d1998fa2f116450d2fd5=
0eba70d9b61a24574
> > --- /dev/null
> > +++ b/drivers/nvmem/max77759-nvmem.c
> > @@ -0,0 +1,162 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Copyright 2020 Google Inc
> > +// Copyright 2025 Linaro Ltd.
> > +//
> > +// NVMEM driver for Maxim MAX77759
> > +
> > +#include <linux/dev_printk.h>
> > +#include <linux/device.h>
> > +#include <linux/device/driver.h>
> > +#include <linux/err.h>
> > +#include <linux/mfd/max77759.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/string.h>
> > +
> > +#define MAX77759_NVMEM_OPCODE_HEADER_LEN 3
> > +/*
> > + * NVMEM commands have a three byte header (which becomes part of the =
command),
> > + * so we need to subtract that.
> > + */
> > +#define MAX77759_NVMEM_SIZE (MAX77759_MAXQ_OPCODE_MAXLENGTH \
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 - MAX77759_NVMEM_OPCODE_HEADER_LEN)
> > +
> > +struct max77759_nvmem {
> > +	struct device *dev;
> > +	struct max77759 *max77759;
> > +};
> > +
> > +static bool max77759_nvmem_is_valid(unsigned int offset, size_t bytes)
> > +{
> > +	return (offset + bytes - 1 <=3D MAX77759_NVMEM_SIZE);
> > +}
> Do you really need this check?
> nvmem core should take care of this boundary checks.

I think I went by what qcom-spmi-sdam is doing, but I now realise it's
doing a little bit more. Will drop.

Thanks Srini!

A.

