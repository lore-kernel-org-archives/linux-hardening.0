Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983635A95B
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562600; cv=none; b=QFVFP/Qn7e6jE+KhuRcLui41rCHLfDPWWWPd+amcLR8SGmCgUcCwKVthcF4axh7wMnV+jY7uV1FR3y64YyTvenmFJh5WFxv3LLRnLwF9xvLsN5Kcgh+nTjpzQbc12mTeoEDzYNBn28Ound+ZPsFXvOi0X9KGtJog7IMYXyuGp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562600; c=relaxed/simple;
	bh=QYkJ+KAJptP8x+/Lo+OPyvZfeeVlUCQUdUVwwHK0tdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdPxu9F4I9v8ab6Rj/SsOuY/t5DBC5FjuB1DN4qxak5OvX1NizRq0M1kSSTUAsjdUvp9j3YpGfHwh1wuzBPisJyOZpWh6bjKNPRFt/pPlPjgiZjlf9afdagKoFOcfbc6LAarDaYRiU5NsTvebwtVTGe/EvjyJtyf50RQt8Wakk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s18TSfPU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s18TSfPU"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957e017378so7692508e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 06:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763562595; x=1764167395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRrGjHpQFMPuOkiL8GvRDSi18sR5m2GVcnU67ItY1DU=;
        b=s18TSfPUarVrfVD9Q289QlNx1XEDTfcU8bi5GXrz3W+DSMQoea3Lv3herjQOmTFxWf
         RnCJCTg1nmGcgFlw4R2OxLtmInTDyHf5IZhwpwNhJxOsxEN/gjUh5N96v0rM4nXMsgHj
         3/ZFfkBTBzj/4pRjkvMtZmZIbjctGR8/BGbLbGmewCcwCUrg36LgPbevDP2cNPjovcfk
         eME/KNWlNnmFtlL4BNoV2wwmA8rwPnCeI0jJUXxeHWqN3rrElCznudkbcVbYx8FLHJ6+
         gpqHIvcybbH5PGjn7hX4wZRttrc6/Bpj/4/qlsbYFUAQiDGbBGd2KwHR7vsxt5H1MEVi
         RsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562595; x=1764167395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRrGjHpQFMPuOkiL8GvRDSi18sR5m2GVcnU67ItY1DU=;
        b=vzYHKjWWVEhwm/eIGeZmyparrsEbQ5ByD9VmBY4XlfVdm3n8C0gNoQf8uLQZgck5xX
         sAQyKnw3QMERZxuiJi9B98JQs/Zc0u1IJ3PSX5+JwDzCSDmsE7kYhrlgtrNzAmvtMxas
         IYdS6DqO+mKZhlfi2C5wcKYsBMIi0iZycK+4cKBrkXN3+wR3JXAG1UgZdWPPzw5hdqOF
         SyuujputdUNwmSWr2ytKN6L4iX0TDxgDDbNuVD3kN5RnAr2ogaSialOImrRC6CErTsvI
         +ZrYuZcSYCShrNAtbu9mTz5T/oyBZ55V6t9KRzkfbmR/Cu2PF3sOQ+FS6KorCKa5ul+F
         MxUg==
X-Forwarded-Encrypted: i=1; AJvYcCUNB//T2GqJ0BfjRbHd0/NPk1xhWVzwhCGJzrcj6j8cOcZUPHnGRXshga9S8WxIjCctgxQ5/VZ3tSwzcC1DAdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIb3kFx/xj+JTx53ukkRK+ypH1BzBQrsCvoVVeizmvdt8Qs24v
	h5LQsoIX8N7RDh+gk7I75hoOU9/1U4Kxjimiu3xBZnVr0epdQs4tMJSoOzqa9lZ47XtgvguHsjP
	NthRyAOuwmWW8Kvr51awnFR50W8NdsxSReYowXE2kKg==
X-Gm-Gg: ASbGncs0NaW1LOKXTGtQj2eTXSinLMncpQRGBnSN0I+K9zgGSm/RvLMPblsQp9E+nVl
	9qEoN/7jJc5oi81qJ3MrJYzyZJ8/GQG//wd4spj32sPh8BLzUqm3p0/lQubp/a2D0tcqdPWS9MN
	LdHOnWsjHV3nhI5hNApEVgeAC+sDfRPK0spBNoh7WWOl5QR9K2C0rG0QeE0lwGudt0kSFvytc0R
	T9m0TpuOxYKA5RuuzsKyw2L5ToAqzi75+HuAvqo8ydxzP8x2UC28h7LDkZHKTg8lPgM0TQ=
X-Google-Smtp-Source: AGHT+IGp7GKe1RKdp3EifTfSeaou18jsyywYSKyMxPvf6+wpNti41ngxOAgDWBsE8YIo1EJMFQbA1mHAun4y/oak87Q=
X-Received: by 2002:a05:6512:138a:b0:57d:b8a1:832b with SMTP id
 2adb3069b0e04-595841af20bmr6916107e87.24.1763562594938; Wed, 19 Nov 2025
 06:29:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com>
 <CACRpkdZioOu9AEBdaNWX1njsVvFYR8SP8yJrY8MFMbJtL6YLJA@mail.gmail.com> <CAMuHMdUe64MdRL1qPRX3q_OGj287nK=MQTb7HUta51iJ+vP9Hw@mail.gmail.com>
In-Reply-To: <CAMuHMdUe64MdRL1qPRX3q_OGj287nK=MQTb7HUta51iJ+vP9Hw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Nov 2025 15:29:43 +0100
X-Gm-Features: AWmQ_bmc-n1cuVY24_yDbxt_0pYfljkKCrIONDdezzzLDg_EEB1-VOCfHUUS2FA
Message-ID: <CACRpkdZp3zKVCeJPXJP4UCAbXz-j=81zYfXntxuBp5BK5ettzw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Wed, Nov 19, 2025 at 9:38=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:

> > For the input usecase the status of the LED is a byproduct and
> > should not reflect in software I think. It surely should not be
> > controllable and possible to set into output mode because
> > that sounds like a recipe for HW damage if you drive it
> > actively high and press the key at the same time.
>
> Suitable resistors are present to prevent hardware damage.

Aha, clever.

> > gpio_keys {
> >     compatible =3D "gpio-keys";
> >
> >     button-ok {
> >         gpios =3D <&gpio 0 GPIO_OPEN_DRAIN | GPIO_PULL_UP>;
> >     };
> > };
>
> But only one of the gpio-keys and gpio-leds drivers can bind to the
> GPIO, or am I missing something?
> So I do think I need a new combined key-and-led driver, like Bartosz
> suggested:
>   - When the user turns the LED on, the GPIO is switched to input mode,
>     and the switch works,
>   - When the user turns the LED off, the GPIO is switched to output
>     and driven low, and the switch does not work.

You will also have the byproduct that the LED being "on" in software
does not necessarily reflect the actual LED status, someone
may be pressing the key and then the LED is off even though
in sysfs it is clearly "on".

So the status in the LED classdevice also has to be forced to "off"
(brightness 0) anytime the input subsystem detects that the switch
is pressed.

It's going to be a lot of work I think, but I guess it can be done,
with a lot of special-casing and custom APIs.

Yours,
Linus Walleij
