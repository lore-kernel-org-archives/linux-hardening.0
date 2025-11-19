Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44F235C01
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541656; cv=none; b=fnm3a2u6pYtCqFRAYsvuhb+KmoXMvRfekF/WghsT8FkWgeFJFiC04h9MUnBgF3hGpinoYtla/UC3F+lCxHiQnG/kYbhSW+pLc7fmHh6jQ5f2UOWzXuQGUXXyK6FF1IloOnyE5dU8QmFR9dpLXBuirMdeOLGJq85x+apPWhwLwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541656; c=relaxed/simple;
	bh=Dz2RNjo2Pw0XOcm+SGn1fEPdASUKESrZTRijPS7lbP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSCBocZ16bSFQHqjsLtQKoWBhyB4VkepGM6j3pB3y4uAzvdqRcnNarypBIDmJfdIQ1SWpvwoWAphp2AZEzpr2MMkUkqRymWfs6Cd9p1bUgVWhsBpptHuD9UM2vSjQFXQYXFNtoXQ8xexgSnFV/M6jZ9bYgxOVY3hL+i1oa6TQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfae681ff8so4132236137.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 00:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763541653; x=1764146453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKBmRJ4RypI8GAVhhXpGdOuKGmWr/ovhm00lN6IEqrs=;
        b=vll8nQ4p6AG8asX1N29xNOd6Co5AlAglKOGnbz0tnLq3S4kHY9enVr0x7NFX5/pnoA
         1941gorXHq/7CGqauUFH/UPppA+LlMHgShKRo8GMlWnEOV1zrzDtlyJTBtNl3FEKKV0k
         27Mq/Fc8J5QJBaT/NaCEEn5yIuRr4Lch8ETBbq1gXtXeUJhyLodK/xBQD8vU6AXxRpi+
         jZHsEcM4c+6txAaD/PLTDArOxZeWRsPbao/nPVEYWXoP6ZwjxNdkTCKMTpWPHLYltQ8q
         /r+lmVdVsgsVPoVFBaW0CG7LWSlKOHww42E6+gbztXhgitsTcy/3PvtT/1JH3cNi36oi
         sOxA==
X-Forwarded-Encrypted: i=1; AJvYcCXHd5ePvnwaQeD8qUrBKOS5tFhrxtZZt+cZlrVZnNN3l87pUCOweyRz3P8Yr2ZfBE6rkUD0adFJPFxtm9yctuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+l+ArO1AyEq1kjOw5gKrY+/cqPbHTuiY7XK8Ps8m+jZYMDyL
	R7q8m2eRMn5WTRibsMJkH8a/SIrvt+tZFitlycbYxYbpCIq6QX2ffmkOesOWvfd7
X-Gm-Gg: ASbGncveLBhO6IxQ1aT4xG7qigvB+fcB7cGtNREXAON0l1Z8B79O4xkA8f6oroM6fvW
	kkA8yTaeidySmZV4vVzm9RrhBIw9ayScQqWWeEorbWlZjBe37q81kJmxylZUR38YpBvt2negF7G
	TrXdmxbKrXvt1oZg4wFZqN61+OGvckoxSIUSfQg28mzalPt/O59fEVVPyDR4V2ocGcDwnp8/Yag
	d/czPngqX6/egbtDz7HQ0FoJMVG85Dy1uujLp5aRwfacpYbfpyjg8Bkxi8qeADX8r5LVBpTCRjJ
	+vga0k2smHK3Q2ESAvQjqdJuzK+U9JBkfRF+pVy0MOLN7yXqEFw0TVrP6YG1+1MoFaMUoG1w8aT
	5clgL1TptJjySY4GjKzxeVz8zs59SpMJ3ctno0aOZF85oJnMncZ0v3ihvR85piGRB9zxFxa7FbS
	g2YL0MlqcUO3tQIYiiiXDHxtS0PNJ7+Dga5+Am869TwoMV9TnExRf2
X-Google-Smtp-Source: AGHT+IES2t8kMAsV8wpZbqbpUS58lSPxk1yx8jRW9KM8ykt+ztEyfxZXXqj65lAw28BSAl6evYlwfQ==
X-Received: by 2002:a05:6102:6442:b0:51c:77b:297c with SMTP id ada2fe7eead31-5dfc5b94071mr8112163137.27.1763541653229;
        Wed, 19 Nov 2025 00:40:53 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb726ff96sm6466340137.14.2025.11.19.00.40.53
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 00:40:53 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b24eedd37so3081453e0c.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 00:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgxWqL7yi4o1pOwRyIMFpAlAqGFESS/NldOj2mqx7XfztIkcrzjv7bhuB3OTDVf90jU8lPRXBfwRRfRPQdas8=@vger.kernel.org
X-Received: by 2002:a05:6102:c47:b0:5db:e179:1c21 with SMTP id
 ada2fe7eead31-5dfc5c0488dmr6881252137.41.1763541207113; Wed, 19 Nov 2025
 00:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com> <CACRpkdZioOu9AEBdaNWX1njsVvFYR8SP8yJrY8MFMbJtL6YLJA@mail.gmail.com>
In-Reply-To: <CACRpkdZioOu9AEBdaNWX1njsVvFYR8SP8yJrY8MFMbJtL6YLJA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Nov 2025 09:33:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUe64MdRL1qPRX3q_OGj287nK=MQTb7HUta51iJ+vP9Hw@mail.gmail.com>
X-Gm-Features: AWmQ_bnsTpUUScnL6xOjY4S7f_b3_VnG_mVkF87eF8BY7eFC84gNc7MAR704Al0
Message-ID: <CAMuHMdUe64MdRL1qPRX3q_OGj287nK=MQTb7HUta51iJ+vP9Hw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

Hi Linus,

On Wed, 19 Nov 2025 at 00:24, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Tue, Nov 18, 2025 at 12:15=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
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

Suitable resistors are present to prevent hardware damage.

> gpio_keys {
>     compatible =3D "gpio-keys";
>
>     button-ok {
>         gpios =3D <&gpio 0 GPIO_OPEN_DRAIN | GPIO_PULL_UP>;
>     };
> };

But only one of the gpio-keys and gpio-leds drivers can bind to the
GPIO, or am I missing something?
So I do think I need a new combined key-and-led driver, like Bartosz
suggested:
  - When the user turns the LED on, the GPIO is switched to input mode,
    and the switch works,
  - When the user turns the LED off, the GPIO is switched to output
    and driven low, and the switch does not work.

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
