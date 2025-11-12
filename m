Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878952D97B5
	for <linux-hardening@vger.kernel.org>; Wed, 12 Nov 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934789; cv=none; b=VObsLcfKhs5rkJiocRyE0NOZMnIBRg5TPBXAMyOx57WiZJArYkGOGM+d7ea64jpEGoF71Nw6DUaEnbRpH/4WnQZ256UbhYLOJ7pheRD31cDdmBvmdJnAKekyyUiVhlBoKB+OMuIebr/9ld2wwqKOJlFbsLOViFUMYzR+GRjc5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934789; c=relaxed/simple;
	bh=CsuCzn99HhVaXWmVpBege6OrJ/pMPiZ2yYvkZ7pOFR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBHj50i+NrX9kcB/Ut3V0PXUCIP+6cd7T7BXqAIM6V/0NP/08Bp9xlLFaa3BaDG/Mk3sTG4kIUqPJ46tZ9v2yCGwRv2ixdtXaHgdXNQujmS2NFfLqw8iQBaBRdhas6/YBRGVJciDTXOL+EAik7lOiOp0eZQO4zqnIavsYkvSjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xDKk4dHE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xDKk4dHE"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592ff1d80feso592198e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Nov 2025 00:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762934786; x=1763539586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsuCzn99HhVaXWmVpBege6OrJ/pMPiZ2yYvkZ7pOFR0=;
        b=xDKk4dHEe1YiZnUKxUz2ru/zaNKC8evp/f/YqNWi7rusRi1mfcv0LRunxxJoUfOmpI
         rGFuvyz8x20C+U02FpQHSPX0RxxbyuJWUuupKuuWy/F6OFsUY1qjQwOrMvXUGnp68Fan
         gMaOxY8N4kj+bRxxkTnQCRC6p8emi3Lgsf1lV0Rox1BBIIbr+5TOEjImrQbqwPyn7/4f
         15JYsZyhdDMBe1JGNhwgHHmwqgbfvKkN5PKoVMNku1MpoA6c51ITcA9JtRR1Ua7xTvoB
         ougtYVY2+tdxRtMfUZ+9MgunsHx3PFYBV/4MByM4hxmcRRQWKjbuSbW2gCe5QkXthoe2
         19Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762934786; x=1763539586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CsuCzn99HhVaXWmVpBege6OrJ/pMPiZ2yYvkZ7pOFR0=;
        b=Hnezu+vW9dUr/L5Bmr1wkLIT80063C8Ysd3WXP0J4cL0a9w40svkxRyvvWdEY4nJBV
         JBsPdP4gTuW785GcWsZqbI3MVOk5Vs/FndkV0MxJRZqfXHCWdsdKM3slNKEaMGzSq3Ku
         tPWiLQT6jKhHqgx0AYPikBq8nvepiL4NC8PZ7nASzuFhM4u+V+uXBwpWTnYBEMKxgOLt
         bCGah3ilXyF+/z1iPKX5P0nAXT28tUhLhkjE6hGOlvLu1OsQ2e9hcvHywYufF/BbUhX6
         Wun6YjcimyHlIxhIzE1H1bXuzVwgLOoX134WH6CkoZpSrBWtwG4IeT8saAM5+h05jj/n
         kcmA==
X-Forwarded-Encrypted: i=1; AJvYcCV7YB6qA9AQV/1Q03hBz6PkcdgE+CU6GJEorbzfXwtMaI8+mBZnp8ZJMxr2WsieW8FGFUx+w4vO3s3QL8tJGMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOHvWjyK8g40LpV7TjwfX6QWPvqWZClM+7IOap25cVLnTA1Ba
	CPCmcNQLrTDKdq1MAMHbQWDt8BA/exvKn6aPNuV62rEopVLDqZRThqDq868fP82tegMXuAsQIEG
	oRHSW11x8mVrHQfF7S3LskQXutqQvBCB3u3Xaz6dtFQ==
X-Gm-Gg: ASbGnctiogu+rgRl3Irykc1NiC+2bD32POBPkj+MmE5JgTs5ZeENL26QDZElJhs+1rZ
	oJW8/KIZ3cE5SDLLAH4Wo9SEZSfBOelA2AkbYM/vc8yLnTIRIJLknHPISLUD8VGrkDPg5Ds4nH2
	6GD6KZF2X4U0AAuzbrFoLIWH+P6ROdlNFFZOi0qEcLj3AYdquXAxxgdSzMnkxnMf5Yv+z4Auf64
	orKBHjl4mqwg+3qbqLbwwUPMalUaclHVp4pgnFFxMEBJqHvP3P2ZmKVuEFUapEIoCeE2CWyvr/M
	bv0rT24MTcdDxg4=
X-Google-Smtp-Source: AGHT+IFGOvlOzvk9piywId0UEm/LoEe92kaATxaPyyaUwvvWEVZS+cjBT7dXjw6jb/DtZt422ITz+COnEZi1kuHwxHY=
X-Received: by 2002:a05:6512:3e1a:b0:594:3039:2d16 with SMTP id
 2adb3069b0e04-59576e2ca55mr736184e87.32.1762934785669; Wed, 12 Nov 2025
 00:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-6-d34aa1fbdf06@linaro.org> <CACRpkdbqLyeaZx37yrKjDFWb=C5c=vK6aPgnW8cMQvwi_6Jiug@mail.gmail.com>
In-Reply-To: <CACRpkdbqLyeaZx37yrKjDFWb=C5c=vK6aPgnW8cMQvwi_6Jiug@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 09:06:13 +0100
X-Gm-Features: AWmQ_bnmO8YFH80sSD6rPVFUgANGxGc1BYRZ0qoygt-PZMj9Pyi0gMYkuFaH7pA
Message-ID: <CAMRc=McySdUtj4foEf5a2db8jUEa=CnPmVVms2nwHoO2UYChSg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gpio: provide gpiod_is_shared()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
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

On Tue, Nov 11, 2025 at 11:44=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Wed, Oct 22, 2025 at 3:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Provide an interface allowing consumers to check if a GPIO descriptor
> > represents a GPIO that can potentially be shared by multiple consumers
> > at the same time. This is exposed to allow subsystems that already
> > work around the limitations of the current non-exclusive GPIO handling
> > in some ways, to gradually convert to relying on the new shared GPIO
> > feature of GPIOLIB.
> >
> > Extend the gpiolib-shared module to mark the GPIO shared proxy
> > descriptors with a flag checked by the new interface.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

I think you wanted to leave this under v3?

Bart
