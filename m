Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC91A0712
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470901; cv=none; b=SA2phz/aV3mZvsIMdqgHm38vOL8wPvdwRPayC/e85+wqR3GwYvvbxFr+Md3gE4NHQJTOlLMi9cbzZRIMqwyxJqq/nlxaM7dEgI0ce2CkQJogYrlWWBTAPrLhCmh6r4dH2XO3SdTI1/Lb2+4XzOX8p7V1J/62SzOsZt8MB7XJoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470901; c=relaxed/simple;
	bh=/zVQ3caVQJG3gQBJgK50MyXyKcMooS7fUfIbjJLVF6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RA+ZDOheM0fhUe/R9frjoPTeD84BBDiTyQoyLnzS5mZegt183uGRjnoM39uN3ANgW6uV1JIIEtAzjb90NKd+D6hlDNrJldsfcKGQEWi53x3akjgTIqrvDxCbNSxel9kHMsf31UzdLKsPAwNl8htBjOh2zIBV2154HTb0bJkUp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55b302b8369so1866748e0c.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 05:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470899; x=1764075699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XMYcwyn3PU+pOgxTORp/4U9I/0iJwsVP/bkqLPdjG54=;
        b=MsOkBMC/R9C3S9keRbgCILubQalpzGNhUsk6/+nClXJ35hLpwGdQB+2mKJ7RuFLbH9
         +BfU0gMLS1vbtvlu6brqf2n6AVUjVK0AQrcuYwFTOQ+/hfzH52FhJLIu5iy9Dr+fMY7/
         JsLCD0/xf4NwKUgQK/jdTzPy49Af54nMnEjCKK/V4UvagqSoKC8uaAc/bHx0thazOZD9
         sbHL3o0iLVBz4M/khE1hM6sjeT/u09gD4dhOJYxz23iYyIJKeyntzLJwHY0jokLb73RV
         yGhk7V3NIzMRaMPJ+LUIbEBGinnylsXvyMuEjT8ivXUXvFWkwTdI0REpbC+50SOaCk0K
         4kpA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ifqNR/MCIHGZLVU88vs8oMKTkMQPFvaouYi7ptZUzKngpzIYyZmXIMxgu5DIZFGv7uLuYVBqyI6q463nZfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXBWTKLAaZ+c6cIemM8yH0fGGZ5aBvjQb2+7tp3APDvScIVwp
	lUf6nycrEqHKJFyjYBmd4jn4TH4xbY/kXlcx5Vx8FXGgJ8ICJRrfx7Yan6RxCGo2
X-Gm-Gg: ASbGncufldAT+Qcst9M73P/MI5JnhXhNVebLrXltTjE6zhDf1ps04hmZpZcf/Q/RZUi
	Jtrnx/pkU/EfT9P9QYCwHvK2luXQVSSKbZ5D/en9hK45TvMuEI76AMbjxdZPZC6XfZkixiM8J7X
	aPW/Offh7bdMcSmxe95bljK9y5rbelYqxW+/+cO+NDuo5gZzqXwOi2ZR2IwcAkTPZIxmxKZ/Thx
	OtatekaDvyHf57gz+cfYMkAVzTAY3Yt0ucv7nmg6nDqYxT5FIp+IFAwCfrk4PcHEEUTF6KjJviL
	Sd21s/wqPmWaB6gRHPiz73ypTvsOMUo8LckYh00FHVbOl+Y4gDp2b93+GtQpL1/BfMSZgANRHOs
	dz6Lm/6Uq/kr1Dwp4v0HL4rvWCLuF/XRqzzwtwjV3yCb63/1bINNbHeSDSGUzzPvy6PhGdMNkk8
	0iUhNUvOMHjFMwqt9GakB67TN1Jt5mewVehBJbudJmZE+BUx5J/sGouYwQsoZmacY=
X-Google-Smtp-Source: AGHT+IGuPjWtH/t0VqrOpl46FR/1U5fqfzewmrT+eWfPkH3eUZ2LOokOxBRln/roFjOLRccU0VRLhw==
X-Received: by 2002:a05:6122:3114:b0:554:b32c:6f76 with SMTP id 71dfb90a1353d-55b1bf40b82mr4957975e0c.15.1763470897697;
        Tue, 18 Nov 2025 05:01:37 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f32e47asm5301638e0c.1.2025.11.18.05.01.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 05:01:37 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b6a642a4cso35968e0c.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 05:01:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqdCZKZABAI97ofXh2Szo/J4SarQR+ApRbEuM33OKDA2+7l69p5ZDdprXPNIlXPSfqr6RXgFZwHQMGhtEifhQ=@vger.kernel.org
X-Received: by 2002:a05:6102:441e:b0:5db:e0fe:985c with SMTP id
 ada2fe7eead31-5dfc54fcc32mr4842088137.10.1763470566608; Tue, 18 Nov 2025
 04:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com> <CAMRc=Mdo__Yzigqoy4xKt0LWSvES5Jse1HeXkePfhiWyiz6tBQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mdo__Yzigqoy4xKt0LWSvES5Jse1HeXkePfhiWyiz6tBQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Nov 2025 13:55:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpySSvjgju2LXr6puVXzHMR4ckpaKEWK_S4spTWz6B-A@mail.gmail.com>
X-Gm-Features: AWmQ_bkC98gq3Hx-nk9zI-w6kSG9BC0TZLZ6VioIzu7f0ulaeAjNY59_KJ5q6hs
Message-ID: <CAMuHMdXpySSvjgju2LXr6puVXzHMR4ckpaKEWK_S4spTWz6B-A@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
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

Hi Bartosz,

On Tue, 18 Nov 2025 at 12:55, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Tue, Nov 18, 2025 at 12:16=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, 12 Nov 2025 at 15:05, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > > Bjorn, Konrad: I should have Cc'ed you on v1 but I just went with wha=
t
> > > came out of b4 --auto-to-cc. It only gave me arm-msm. :( Patch 7 from
> > > this series however impacts Qualcomm platforms. It's a runtime depend=
ency
> > > of patches 8 and 9. Would you mind Acking it so that I can take it in=
to
> > > an immutable branch that I'll make available to Mark Brown for him to
> > > take patches 8-10 through the ASoC and regulator trees for v6.19?
> > >
> > > Problem statement: GPIOs are implemented as a strictly exclusive
> > > resource in the kernel but there are lots of platforms on which singl=
e
> > > pin is shared by multiple devices which don't communicate so need som=
e
> > > way of properly sharing access to a GPIO. What we have now is the
> > > GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> > > doesn't do any locking or arbitration of access - it literally just h=
and
> > > the same GPIO descriptor to all interested users.
> > >
> > > The proposed solution is composed of three major parts: the high-leve=
l,
> > > shared GPIO proxy driver that arbitrates access to the shared pin and
> > > exposes a regular GPIO chip interface to consumers, a low-level share=
d
> > > GPIOLIB module that scans firmware nodes and creates auxiliary device=
s
> > > that attach to the proxy driver and finally a set of core GPIOLIB
> > > changes that plug the former into the GPIO lookup path.
> > >
> > > The changes are implemented in a way that allows to seamlessly compil=
e
> > > out any code related to sharing GPIOs for systems that don't need it.
> > >
> > > The practical use-case for this are the powerdown GPIOs shared by
> > > speakers on Qualcomm db845c platform, however I have also extensively
> > > tested it using gpio-virtuser on arm64 qemu with various DT
> > > configurations.
> >
> > Thanks for your series, part of which is now present linux-next.
> > IIUIC, this requires the direction of the GPIO to be fixed?
> >
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
> > If you have any idea how to handle this, feel free to reply ;-)
>
> How is this done currently? Even without this series and using the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE, the descriptor has a well-defined
> direction so it's not possible for two drivers to request it as input
> and output simultaneously. The second requester will override the
> previous settings.

We do not handle it yet:
  - arch/arm64/boot/dts/renesas/salvator-common.dtsi describes only
    the keys (key-[a-c]),
  - arch/arm64/boot/dts/renesas/ulcb.dtsi describes the first key
    (key-1), and the others as LEDs (led[56]).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
