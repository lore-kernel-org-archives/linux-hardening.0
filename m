Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17CA2EFDBA
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539306; cv=none; b=AwxsnIM2SASjCUASw8o4wjVt4+/W8aXoXfSRr2zWHYSzfboQjI7l2sV1tL86loUhMaoWiplhNGhV1AoZ2KUv792jiQ1mYD40QDjNHM94x5RTnov1aCoNYTVLF27gXv6u+Z+2csc6UFH9zQeDu66ypxTTd5Fs7mfly3DZ6RzoTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539306; c=relaxed/simple;
	bh=z5K1y6faf5b2+1zAlrcaMcsQVzqujnONb2bvp8XlHlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFM1xnXRN+cvaT1m5QNL4cyt7qqmDumPKBF5Db8gbM2v4fL7nv/eaFvbtGg+TOpgbnGLeRa81w9M+9xlxzexbD1db3YwBj1OOEnccqAa0BcTbkn8IBNOOkme7ApaxOHSmkSoUI8iNlif5dMmYTskalSm03Rr+pmt0t1MT+d7aLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygix6mE0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygix6mE0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b72cbc24637so1089395766b.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 00:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763539303; x=1764144103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AheCr9rr/sxkXy+oeczaUi7thIoHaJwOb9+DkTPHTDg=;
        b=Ygix6mE0t+lL9vVChi+j0aakCDJHrlG0vtP0LfLCxiMDI8cka2ystTXErlWmqFuvex
         DdjALhxDQYW0o3zjsP08QJB9W5LmaLPBvVcO2LNFGGv08vhND9Q6BnYME/rJPuU4RKUd
         2lp7IEyS1eo/yac4OYzpo9GTJ/h4k9MlCtWKFYDeCnRrz49R19dSV7+pTmOTXlToGDGm
         h2TxPOgdWfY8P4/f7QEJQTjVjmnF25azg2feGV3qcseMfOZdOjYwlgnTe5RiVsGnwj3L
         jL87/gTDwaKuGalT1Abb55cDuGn5pns1OKf3jK6orxZ80g6o0uQvrfEZzLh/+eYCvu0F
         fZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539303; x=1764144103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AheCr9rr/sxkXy+oeczaUi7thIoHaJwOb9+DkTPHTDg=;
        b=TjUxkMM+XpjgxMPkVltrVA3E5ryFItt3owbgH5y4FQz6ronBeRPv3Gfmux4QfP7UHX
         MmRIiUOu5jV4EQZGHyuqzRTbSYbxqqzWERAzGelAgpD4QjJpZNOwLXjZjq+A0ddgTW1n
         CH7W8aNqRuOk7MpUqfRkA1/95wEzIdOe3YZH4Wr33vCY6YBE/cQ/FGJVzXQGV6Q70+TV
         sSS65o5b4SsPBWw6P0yFnCQWJ5/JO4E3/dRz2acF2cdgHfTjsNVFd+ys63NdpGfBWJ+a
         ggDDHEaWM/COfJLmeQgTZJ1pNReK/w7G2DtrAnLuhr1qGth0ckJhzIM7zw/7OiaFvceX
         1ToQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMaWBNFm6pcGhGSIaNePYfKTx8bztNz+3vdct/Ow/0/fxxVjHwIZU6koiVeYOkB/ceRPSqcpkDl6Tm31DcvBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJAE7ZFmcZPhCUWGcW26khmFbOFgdlGEseo2pgpYDlDHaUl5r
	LtcrEfHZfqBPNKgNLNPDxqtdwP2pPgTvL2NgqQDQBYPRQxywti1gS2TtKPL7D+cR6sbdEsCzpJ9
	y80oksn5Q8dvt2aT6XhjzsGtsCuwKDZE=
X-Gm-Gg: ASbGncu+gkQ9dYFLZZMCweMIe1PB4OPyRqS5pMeILSeuzfKLxtrGkC3BItoM+ere4r9
	t4+FWtY7DcIiSOC3iFX2AxsRKALsQtI8TskTrM7f/jaEAChFS/JbTzh7uHndAzcmSCNeysLKYiR
	9jt+p4o5fml/bYmI6I7yfu9Q8EB1NTATX/X77aGryVVtgF5C1n7BU6eXmwv7soQTzh9dwbKWGJv
	nYzW6gG+zqGPxg/vfzMePMLACpg8GFvyQQC7umylIyK4P1Aw79VaYvPT6ASeQ8QSFYGZrafpmMO
	nDe+QJi6RQRHwuhSnYuOSk+Rm1zN846kwH+i6qlgqAqBOsc9G9p8WveeIhCwsCv+0kZFQU6pxHh
	Y9tgiHuDuGYfGzt0y8A==
X-Google-Smtp-Source: AGHT+IH9RLmrudJYiFQxGBpWdalp0RNvdPE1jKRqx1L9zjBC+zs6TZNN0Aq/tWyMeDQCJfcJOrE+KpnLw+AjClRbY58=
X-Received: by 2002:a17:907:d09:b0:b73:4816:7494 with SMTP id
 a640c23a62f3a-b7367868812mr1750251666b.8.1763539302927; Wed, 19 Nov 2025
 00:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com> <CACRpkdZioOu9AEBdaNWX1njsVvFYR8SP8yJrY8MFMbJtL6YLJA@mail.gmail.com>
In-Reply-To: <CACRpkdZioOu9AEBdaNWX1njsVvFYR8SP8yJrY8MFMbJtL6YLJA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Nov 2025 10:01:06 +0200
X-Gm-Features: AWmQ_bnZWE45z8dq-W-vFJmONbGs-165GBHB7vG7G8yZKHS0TzpNGV8dz1PBcfU
Message-ID: <CAHp75Vd56XYo6PgoJWeUcH328uD2svUCBX7SWT_WUZEH2AvoDw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:24=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Tue, Nov 18, 2025 at 12:15=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:

...

> > We have a long-standing use-case on various Renesas R-Car Gen3 boards
> > (e.g. Salvator-X(S) and ULCB[1]), where GPIOs are shared by LEDs and
> > key switches.  Basically, the GPIO is connected to:
> >   1. A key switch connecting to GND when closed, with pull-up.
> >   2. The gate of an N-channel MOSFET, turning on an LED when driven
> >      high.
> >
> > Hence:
> >   - In output mode, the LED can be controlled freely,
> >   - In input mode, the LED is on, unless the key is pressed,
> >   - Hence the switch state can only be read when the LED is turned on.
>
> Fantastic solution to a lack of GPIO lines.

I feel a poster "SARCASM" behind this line :-)
That's what happened when old-school (in a bad term) HW engineers who
try to enforce their experience on the modern SoC-based platforms that
run GP OSes in multi-tasking, multi-user manner.

> This reminds me of the Amiga 500 power LED which was connected
> to a GPIO which was cleverly also reused to control the audio filter,
> with the effect that when you turned off the audio filter the power LED
> went out and music toggling the filter off/on for effects would also
> give you an incidental stroboscope.
>
> > If you have any idea how to handle this, feel free to reply ;-)
>
> Isn't it pretty clear from the system-level DTS how the line
> is used?
>
> If it is connected to a gpio key it gets assigned for that usecase
> and handled by that driver and if it is connected to a gpio LED
> it is handled by that driver.
>
> For the input usecase the status of the LED is a byproduct and
> should not reflect in software I think. It surely should not be
> controllable and possible to set into output mode because
> that sounds like a recipe for HW damage if you drive it
> actively high and press the key at the same time.
>
> gpio_keys {
>     compatible =3D "gpio-keys";
>
>     button-ok {
>         gpios =3D <&gpio 0 GPIO_OPEN_DRAIN | GPIO_PULL_UP>;
>     };
> };

This is my understanding as well.

--=20
With Best Regards,
Andy Shevchenko
