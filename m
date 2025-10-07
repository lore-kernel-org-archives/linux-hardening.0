Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694C2DCC04
	for <linux-hardening@vger.kernel.org>; Tue,  7 Oct 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840158; cv=none; b=uEm8Ueye6eFGYI9qt/duThmDwShxGNi49k5++YphuUkcoj3mduX0LtvQMzKsH1l/d6Yphboi3Imzg3ZrgxQeVTinJF+6QE/lZO4KeZigbydx12JudVMAfxLU9EKr4cy/Q2iN2oumhZvd15BeLYdBXqXsM6E19hva/S4WsIWpwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840158; c=relaxed/simple;
	bh=EnIFXZqKjMmu46oO94pEByawVJ8hwocGBr4EM7AEbYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5MlY6JdzrAMUHUsCEIBw+6aLdd306/2+yI91UmZwDAzo91nZtntoVnSRo3TZAVqvfLlwmQqZjxcu2wU/x0LIFAGVCyVp36eVM3L3I5Nc0di2WNNvKQhRg+xN6sKNC3gOUwa0mtK0Cmsqz9HcAScraUh6gQ0IVqQQ/c3VmFMkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LdleBcLE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LdleBcLE"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso7408146e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 07 Oct 2025 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759840154; x=1760444954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnIFXZqKjMmu46oO94pEByawVJ8hwocGBr4EM7AEbYM=;
        b=LdleBcLEXMPxkGZZ4IH7OHM1RCEfGKmTVWJ7BemZ0ohKWk3OZepLgJvzL2xrSFg4iW
         CH9OqqPR5znp1hzBs1NwrthbL8u9+PG0T5BZ3zcpfTsOtAYzDaU7qkEbOC1HKo1NPJ7d
         BuUkAPFGSIqB66oOCyrgods7ODqHz2NvVn2LTnCJU6Y+sdpB740semCvRU3NHwZcPnOM
         J7LqBsetSjjrQJB/xYTgdog+u9uwGlaEy3wS+YasHk3chLzB0brWBFz6xB4bgPMQiu50
         QGjKVnRLaFQIWA2hfnFCQ89dwUAJL41fACPNVmbBoEbTPq9oDn2VIh+wl/x1aGZWmHwk
         GwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840154; x=1760444954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnIFXZqKjMmu46oO94pEByawVJ8hwocGBr4EM7AEbYM=;
        b=ivVPNGCUPMGNnuMb0DVLeaeTw7/le/TKNpwjNxypd9XWBju7P01SIzYJm6qkFfQHCF
         jtmYRRiIBj/NO5djZ6oR7JBrUUsaS0ynS/XVygCC1pu+LkiAegBFz36Fpje5JiZdFN4b
         KXE9tbicm+y9TiSTAdMwyMzn89HwWubAV0JlybWdSkePQE5sLvzJ4BZonC7V0mDUYalg
         bTdHCuWZs7lFXXYmHw72q5/q6mFzEL0imAE5gdeTsgLj3+gxSavREZZ/D+sdNA6JxBpN
         BfJp3Px/RZlDOsiWqOI/WD0VcDV73NDu7uGxEF+sm0XThIGKuwwa6hom8kepJBvj0Ca0
         FFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwLKUldFhEz7Re33q5qEkyR8al21USeYpUbHBzYwj3CYi650msmKjdVewg/yTNoW9/TbiK47UfquPS7vtH5ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWlQFaBn0EOcJYcMh3UyNgzspE5QkUZeQrBiAvciAL3Bzpaxx
	C0Ut7A2IqdhtAFzUkfqx5cXMnIP4dtsdPR2MPfV+lZMjlyrvAleOkEZF9oOyRG4tZimGAw62+pt
	uIyH7EzI1100psMgbQZnsCnivjwebdBYMLjYHrqXroA==
X-Gm-Gg: ASbGncv4SpE+/59zvE5YJOZLiabEFtCThIX2CpZkG/6m06S3HKBEz2mJpG+VBFfV+2S
	O6mZugj/rsslXPT74enQa3ePi7toLX6TLjdBkhLL+wkY2hxRCbL7fIZTXF5F3ugf3teoTqOzIqy
	zeONJn/q5/4QG9sxWS77a0Io38xOCfgFdkEhrImgAZjbOg1ggV+2k8NAVppmWJjhtKnF1kt3dwE
	uBT00HAfKHi54eMyFQLAdM7Y8EkQ5RH6juDsTKvvWSucYOQ6DBUmnKp3Fs/+0A=
X-Google-Smtp-Source: AGHT+IFvEXq4IGvOkBEwLnkFzMNYQoqXWta+MRuNZ6zy5QIvEZlr/9df2gaJ9h0Z2yhh4+vKPvuKBvTOlCdfwhpYHf8=
X-Received: by 2002:a05:6512:3e2a:b0:55f:6fb4:e084 with SMTP id
 2adb3069b0e04-58cbc776474mr4804386e87.50.1759840153971; Tue, 07 Oct 2025
 05:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
 <zk4ea5cibrkp4vttuy4evrqybf76b3nop5lnyck4ws4nyf2yc4@ghj2eyswsoow>
 <CAMRc=MdWmO4wvX6zpzN0-LZF1pF5Y2=sS8fBwr=CKMGWHg+shA@mail.gmail.com> <rfr5cou6jr7wmtxixfgjxhnda6yywlsxsei7md7ne3qge7r3gk@xv6n5pvcjzrm>
In-Reply-To: <rfr5cou6jr7wmtxixfgjxhnda6yywlsxsei7md7ne3qge7r3gk@xv6n5pvcjzrm>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 7 Oct 2025 14:29:01 +0200
X-Gm-Features: AS18NWAtiT9xc4AHDK2XxNjFXsHbeG0TTtUUuLHamMaXYLyXs_iBH5F444RGyw8
Message-ID: <CAMRc=Me9Td5G9qZV8A98XkGROKw1D2UeQHpFzt8uApF8995MZw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 12:09=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> > >
> > > Not always... For something like shared reset line, consumers request=
 the line
> > > as GPIO and expect gpiolib to do resource manangement.
> > >
> >
> > They could use the reset API and it would implicitly create a virtual
> > device that requests the reset GPIO and controls its enable count.
> > Except that some devices also do a specific reset sequence with delays
> > etc. That would require some additional logic in reset-gpio.
> >
>
> I was referring to the PCIe PERST# line, for which the 'reset-gpios' prop=
erty
> already exist in the schema. Now, you want me to model this simple GPIO a=
s a
> fake reset controller and use it the PCIe Bridge nodes through 'resets'
> property?
>

No, not at all. It's just that a shared `reset-gpios` property is
pretty common and Krzysztof implemented the reset-gpio driver[1] to
address it. Drivers that request a reset control via the OF interface
will notice that there's no `resets` property but if there's a
`reset-gpios`, the reset core will create a virtual device binding to
the reset-gpio driver which requests the GPIO in question (once!) and
registers with the reset subsystem providing shared reset control to
users. Basically the abstraction Srini mentioned minus any reset
sequence.

That only happens if the driver uses the reset API. If you go with the
GPIOLIB then none of this matters. I definitely don't want to change
the existing DT sources either but I want to find out if the code in
this series is suitable (with some modifications) for supporting the
PERST# line or if the logic behind it is more complex and possibly
requires separate, more fine-grained handling.

Bartosz

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/reset/reset-gpio.c
