Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02A355027
	for <linux-hardening@vger.kernel.org>; Tue, 21 Oct 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048409; cv=none; b=QEcsZqTb9ImnFcgD3Ks2A1vwpn1CPvUtDcd9XZ1pl4nsAr8AaXxUe6jLDDBTRHCyNmO+stKDYWlQkfGfB50Qy1My8ghoS74FFWevBn23TXAHnbMx3D/x/qFyncKEhkyCOx0+NuLqejgpqYnCWecuPVAy0GlJ1D4kHYyVl0OMH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048409; c=relaxed/simple;
	bh=t2LFO3Id5PU7ftFHyhtH9UbJzb29dd0urW6inqON3e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVtbxV5HpkkQ2Im/0pNGalHMxL3pkLAhw6PIUWGP3cho22j/jp1aHKDxDfv6caIibLVFsqKiZCpgPE2KBZhRGcng9ljXMEslG45kgIUVrzL8pXBGFtRgSiywWEnTFHgWTRwkGsv0j+M28eHJQnx0Rs/61oD+In2Sv49rTeL+I3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kodxfLPW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kodxfLPW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-586883eb9fbso6813899e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Oct 2025 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761048404; x=1761653204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2LFO3Id5PU7ftFHyhtH9UbJzb29dd0urW6inqON3e4=;
        b=kodxfLPWCvn60ANlu6wEwYBuLNqOWU0vRD7zbL/zG8/twxJs7dvVJ6ya2nco6xkNdB
         Yp0Wk5pxuH4HoaZLJFFsqYimZho7fgeEOuLTxv4/Mhb416Rgvw8eGlk4xZuqJgMHLHnC
         84+MbTK/xxpGLglEcEzCtb4dy1c8NN5v2QcSup8kzsvAUlBYQfbZCv/YzpVZ93u2gsTr
         uPYsRkFNuJisnxCZQzsr6HmzQpZ3AmIpQXUm7f4NanIlWdmyHfF1jE59xCeNtTXmaCc+
         luPm/hk1Uoo4dEi1TLysEavhwo7u6gMSTdoRaesRGQe71kHoEc9e+J4Uv/r1jl8aaoY8
         5M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048404; x=1761653204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2LFO3Id5PU7ftFHyhtH9UbJzb29dd0urW6inqON3e4=;
        b=JFxgJvelT5B1JOzseuroi8ZLA1el0fcgqKbtVoNFiFcSer2QTnuhW4Gqbz/uYIDNRC
         Cz0diDvRN57lUaxS2/p3575mc/U0tWT1et6ddBvGvOL7Wl1x202XZeHsvc/eNozc2ode
         smOVK75oAX3VGJyvYLMwNcDZAftfouzjfvN0zYorfc0/5PPiA4nNBOkgrnICUZuXZEcb
         ZGaqgo70cO4iVU8XPWWX+VWxbE/J8SxZVopQlE7xBj15j1ZSqEN8kX13l12Fzar/NMdE
         wsCrsa7npoc8pFOyYtICyUnAPVfkAgehRFKWEJf9FD1y1P7SKwOQKmEPeX5jRfvYkm+8
         r6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXIf1/ufmAYcO3r4Cwz6EOtV/bfUuhTnQThOwoI/AEzluGaMyx2pM2o7Tm+uNK4WGNwkxmaO9CivcLajZfe5u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpOOSczWEiPsXLZ5wWxWoL0eIp0uW4Ydv0EEO+8MhL3KPKRj7
	LYF8qrvJm7Yx+pYcXsqZzJ+Ray8srn5mpvEFM65cL+iTr9mQDCA3scOB4rQIGP3ZTEvJppnhyz6
	TQel/3ya64ekCxhuhDXzMIIfu35m69ghYkB2Qrrg72g==
X-Gm-Gg: ASbGncvcT305h1hljTy/RTHZkSxKcfM3RUEXMXqKTN0iJZlXASrxp+7GeG5KwJWvqCv
	ExZn5Z1TIFR4n7POUC7RkvMfrkWETbXPRfyQRsNImTkKwCjcyLWZYVvMQTCugfeNn7DWyKOGtaR
	/t8/bpOzKhNI0ouWdP710Oxp1qNukDLu9Zug22C6y0+yENrct2/Hserv4nPKNtgy8+xsB4qGMKR
	N9KF/XRLHakkltOmi2vi+fe2TRwDOhnZhoz7gScRGMURO/QhFl79VWnfGlky/i/wZHzU0pSKZ3h
	K/hYF+g1xTuECX4G
X-Google-Smtp-Source: AGHT+IEeA2p1C9mduUxezytlThTWwIAafPtXXWLk0U+AE68AlD8B/b+fLCobL77uAw7zXcaVlFRH47WXQcM6fRGa51M=
X-Received: by 2002:a05:6512:130c:b0:578:f613:ed9c with SMTP id
 2adb3069b0e04-591d85516cdmr5498056e87.43.1761048404206; Tue, 21 Oct 2025
 05:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
 <zk4ea5cibrkp4vttuy4evrqybf76b3nop5lnyck4ws4nyf2yc4@ghj2eyswsoow>
 <CAMRc=MdWmO4wvX6zpzN0-LZF1pF5Y2=sS8fBwr=CKMGWHg+shA@mail.gmail.com>
 <rfr5cou6jr7wmtxixfgjxhnda6yywlsxsei7md7ne3qge7r3gk@xv6n5pvcjzrm>
 <CAMRc=Me9Td5G9qZV8A98XkGROKw1D2UeQHpFzt8uApF8995MZw@mail.gmail.com> <rvsyll4u6v4tpaxs4z3k4pbusoktkaocq4o3g6rjt6d2zrzqst@raiuch3hu3ce>
In-Reply-To: <rvsyll4u6v4tpaxs4z3k4pbusoktkaocq4o3g6rjt6d2zrzqst@raiuch3hu3ce>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 14:06:30 +0200
X-Gm-Features: AS18NWCS0bDo5asDO54GB6xpnkDJCZdNkOPsf7p5f8WdpHmgmskO8LgWJsfISW8
Message-ID: <CAMRc=Me+4H6G+-Qj_Gz2cv2MgRHOmrjMyNwJr+ardDR1ndYHvQ@mail.gmail.com>
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

On Tue, Oct 21, 2025 at 3:53=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
> >
> > That only happens if the driver uses the reset API. If you go with the
> > GPIOLIB then none of this matters. I definitely don't want to change
> > the existing DT sources either but I want to find out if the code in
> > this series is suitable (with some modifications) for supporting the
> > PERST# line or if the logic behind it is more complex and possibly
> > requires separate, more fine-grained handling.
> >
>
> All PCI controllers relied on '{reset/perst}-gpios' property for handling=
 the
> PERST# signal. Now if we change it to a reset line, then the drivers have=
 to
> first detect it as a reset line and use the reset APIs, if not fallback t=
o gpiod
> APIs (for DT backwards compatibility), which will add unncessary churn IM=
O.
>

Ok so some platforms define perst-gpios while others use reset-gpios,
I see now. Yeah, it's better to go with explicit GPIOs then.

> But if there is no way the GPIO subsystem is going to support shared GPIO=
s, then
> we have to live with it.
>

Well, there is going to be. We already de-facto have it but it doesn't
work very well and is fragile (I'm talking about the non-exclusive
flag). I very much intend to bring this upstream.

My question wrt PCI PERST# was whether this is useful for it because
IIRC all endpoints sharing the signal will assert it (or rather their
pwrctl drivers will) and then only deassert it once all endpoints are
powered up. This would translate to the pwrctl driver doing the
following for each endpoint:

perst =3D gpiod_get(dev, "perst");
gpiod_set_value_cansleep(perst, 1);

Do the power up.

gpiod_set_value_cansleep(perst, 0);

And with the implementation this series proposes it would mean that
the perst signal will go high after the first endpoint pwrctl driver
sets it to high and only go down once the last driver sets it to low.
The only thing I'm not sure about is the synchronization between the
endpoints - how do we wait for all of them to be powered-up before
calling the last gpiod_set_value()?

Bartosz
