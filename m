Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E334C149
	for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741589; cv=none; b=U6+AV/37HL+snYPwwU37riGXl6l6kWq/BTE4dL4tXacPGpx5WiHPmo6jaghPCt+uBGYNbH/6i8srWnURsI3jnl/qtWHQjMD9d55OqKOXOh4hX8KFTQQsNof7rjA6mIM8ZvL1UjRRZF0JJoxLCg7O7bjmE/MHGH9qgThWk4vFgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741589; c=relaxed/simple;
	bh=vepLqSyPiapW1CscUULDIr1ukJTRIyuoFYsiHMuP74c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeZHHJ7zq9Vq0e1324rgbLcZJXy/DRxg4Dkzk0NjDR26Jz0R/RCyr++ws/GFVFhYvpW3k6K7dFHB12Q1VsSj7tp7pVmI3TDyfa5rkoXYnZdYq2ulxFdRguxv6D1AZlmfgjwi0MCwLapqMPQ1ISXc6UsiygM1roiKE4rBrzuFvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zLaB1x6e; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zLaB1x6e"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592fa38fe60so8726722e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761741586; x=1762346386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vepLqSyPiapW1CscUULDIr1ukJTRIyuoFYsiHMuP74c=;
        b=zLaB1x6eVAZ9zfhQy6mSs3ecSMXcJ+JVEo1zGzm3hfwCYi/HQPwtjF72mbfH497Zos
         xLTx+if13zunBkqctues7h4Vq6i8shg9uN1pakRywLuKUZer555LgPwgdcYeWKSo9Nmb
         KDTgh0KR/tgB2EXzcoD0VHK1j8VR9nzrc3nG699wYLtd3oinPDd6FTFfJX10mLL4od5p
         MqyNXtgOeAXut5OzP+7XwcQ0h+PaBKbGOH42g2TdWx3tkQB+YCqi8ddMEiH6MFK3jLjW
         jutS4B1dSTvCuVY7MPgEAShWU3b0dnc4EG7I5u9Z744+QV9cYocrSEJhIhgvzQ/uBOAQ
         nlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741586; x=1762346386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vepLqSyPiapW1CscUULDIr1ukJTRIyuoFYsiHMuP74c=;
        b=U/iT9VZ/atP5thXlAcMs1WY+Gp6+KwoHqjiC67akf/xggLgD+DoryMWQdZphKHmbst
         68eldqScGmffK76ZFeH4phxPFqWTI+Ucx9pjaZLcmIP5YlA0T1t5cT+3XTEYc6RAYvKU
         LSjsHKR6DuM18f5WGELToC44gGZ1taLkZdM+GdILMX7YraHBwh+PuQFxpSu2rZbwaMe2
         116o2pW+c/IzOpyEz2/NCwdiJHLebNirhE00uH9wiXOB6I+e+tM2p95Ov0CGO2DZaSxI
         zgLA4PNX3t6OxYcknXRo9bh46tQnnf7ZTWUGrnd7G6xA4xZtOC5XHHONWSQATtwHECbJ
         6hPg==
X-Forwarded-Encrypted: i=1; AJvYcCV074/Z4Dc75Rfe+1x9cFckPNz/POR0Xm+QEJRMG9dz/B2KPP5zPaUHDcqfvnHn8/70ynWK7ISIvITe5W9+QPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJ3Q61hvinveFulRap0Saflk8w5hsrtgJdpxihAFNFBF4KCWJ
	LbnheuMU2UFjd01lo8j/q9saUQRxRpnE+x2TZdctDBZ5TubMLQ8escICQPZv20KR82u1GI4a7pC
	TFP39mrb2BktxJJgvJwFMdw7Z0Aq8/z/uoEPqUZtYqA==
X-Gm-Gg: ASbGnctKHfvJpJ4LxT9YX2WEG/wk0K9X1srx4C0b0JAToqSRqJP3aKi5utX5A30+ghJ
	JETGdX3qL771KKwcgt7h3paUoUCxcOTqp3hmFOvZcpekYMpXCSEEqcb1Cf/Jlh2t12uSSmEByn/
	WkXvJPym3KBAVWvLZcvjgPsJTWbI4ygn1voqKI7CcDYWijm/RxN1mn/Mawzo4scqvM8HF687R8x
	WYEI8PUw2i+djyxiQV4i/pm6r1odpPUaagWJ7Ffe3SURkZJP4ay8cpdxgNNWUAk0R+jGAw8EYn2
	nQMzH+ubolKRjlLbEHjjDSVyojg=
X-Google-Smtp-Source: AGHT+IEhlmDPn2tgHOCgKXhItr9HaCh2am9KNpwJ0IjxOJ3YFVumxgTyoy/YlwjIRIN8akgjhohEFSM52fM0JyvB8BA=
X-Received: by 2002:a05:6512:1383:b0:592:f315:843 with SMTP id
 2adb3069b0e04-594128f53f0mr1119595e87.50.1761741585982; Wed, 29 Oct 2025
 05:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
 <20251029-gpio-shared-v3-3-71c568acf47c@linaro.org> <aQH-NcXry6_IlqXQ@smile.fi.intel.com>
In-Reply-To: <aQH-NcXry6_IlqXQ@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:39:34 +0100
X-Gm-Features: AWmQ_bmg8NCddAGmpteBxJYDcYFplccsm6nERfQwYpmUT3SY-Zt_nlxAn9CZjjE
Message-ID: <CAMRc=Me5qPS2PhLK5hpK8BbTS8b9q3T-+86mq6rVDpyKZZUfoA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] gpiolib: implement low-level, shared GPIO support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:45=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 12:20:39PM +0100, Bartosz Golaszewski wrote:
> >
> > This module scans the device tree (for now only OF nodes are supported
> > but care is taken to make other fwnode implementations easy to
> > integrate) and determines which GPIO lines are shared by multiple users=
.
> > It stores that information in memory. When the GPIO chip exposing share=
d
> > lines is registered, the shared GPIO descriptors it exposes are marked
> > as shared and virtual "proxy" devices that mediate access to the shared
> > lines are created. When a consumer of a shared GPIO looks it up, its
> > fwnode lookup is redirected to a just-in-time machine lookup that point=
s
> > to this proxy device.
> >
> > This code can be compiled out on platforms which don't use shared GPIOs=
.
>
> Besides strcmp_suffix() that already exists in OF core, there are also so=
me
> existing pieces that seems being repeated here (again). Can we reduce amo=
unt
> of duplication?
>

I'm afraid you need to be more specific here.

> ...
>
> > +#if IS_ENABLED(CONFIG_OF)
> > +static int gpio_shared_of_traverse(struct device_node *curr)
> > +{
>
> I believe parts of this code may be resided somewhere in drivers/of/prope=
rty.c
> or nearby as it has the similar parsing routines.
>

I don't think this is a good idea, I want to keep it within the
confines of drivers/gpio/ and the use-case is so specific, there's
really no point in putting parts of it under drivers/of/.

If I could only iterate over all properties of an fwnode, I'd have
skipped using OF-specific routines altogether.

Bart
