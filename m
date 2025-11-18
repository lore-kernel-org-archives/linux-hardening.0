Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91532D0DA
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763472107; cv=none; b=CViVe7FuBmJCTKbycq2w6qAmWPPQhJVM+fcKK9yim72RFVzp82ls6T8ZUTZQcPNNJ+bBzltUFGawqu6H//4qT7ufIq5mUfKMHKIxIdt+4Suc2pqjzftpkAcuAXSQlU5c/jFnpOutU41HD3xX+UZzQFJQBsbSYNb0OXgI9r68HKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763472107; c=relaxed/simple;
	bh=E5V/vfphfgkZe38UOECGMAO1aduhoV4x1WIT54usrgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bidVbahWYsjaLdTTE6hyL3NDKhzpT9+QZWHgOZmdijf9cwckR6P/S4TadcKq1+J4TOY0mAhqI93qY+qyRP666eU2NCe4UTKiq1sqPe2/vj2kUPdr+g5S+IPVgKFWjvvmSMZFi5IlvNVs9T50faQjduMUVlfysZFm73WSqp7RZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sirWXktM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sirWXktM"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37902f130e1so43778681fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 05:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763472104; x=1764076904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7s5vmA5/2iLhUbg7qRyJfyqshig4Q/omIvZZt8dCY8=;
        b=sirWXktMVtgQNU3SVdAu2M8xXMHr4mig9i3qGeLV8GY0BNToy76ySxFhm3yKdaLqSL
         gL86zT62oT/rg6KhukZ/yWIiPIL3x8wxXH4hQ60sLHdog+t+aoYOdRFa+1lidlz48Lon
         /vzTD9/Yu+NDmFlRbtx3NQGAWKa/tfxaQJD85njAbU5trtKkIuLJ8kQ8CpNkYmQXX4sZ
         ML6czasORrbXN0BkyVBFc7je9lbxVCj17szuaitxB5QpL8nGddVyEhhqsUaOZvM6SxDS
         3x6+Y1SSEUL/xlUV0Uhiwb8SwBJ7g91vGVBBb89jU+tHxXA+SCEQh5NpHKCZoB4Q+dH8
         wyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763472104; x=1764076904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7s5vmA5/2iLhUbg7qRyJfyqshig4Q/omIvZZt8dCY8=;
        b=D65JLQs2OJ8KpDJI8n9WqMthphe5g/auf3p7MfEwKhfoL6pVrGFdQDQljoY2jDE6jL
         /vNxCJJna8d6OEsR85xQ38LoHeNqrxluIX99Dznhsk+KTM6hwUc+aG2AaWtb3GB24RRw
         i5i72FGWzj1NXQ+/Y28wlLatsHMua6DdgMeWaghEOJSPIBaVjZ4Naizu72ezt4H/PmDa
         N3EdMVVjJMPAm0Hj1QWFSCG4xzedinuiBgTRZ3gB6yUrGm0OMiKiAOS0gFSkNbyyJMBs
         DSY6sz+27ri5E9wwP2EJkADeALWj9kDgRUJTVvFJh90XHW0Km1PUHj2eBlcxgVRkZwNP
         BjIA==
X-Forwarded-Encrypted: i=1; AJvYcCXic/6VNZCBWkajvx09QxslpkzG4EouAA3qBX4XX0h4g6q8kMaUXIlGwVbx/j2Xxu2aOec6mZ6ywwFP4EKQ8ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCeHfUIzMU1jqr6XLu6jpOELLB/VQRU8J7TCaXlDUMqXwnSIh
	1rbBQxNn6O8kzZ9WxrSy0lkrzQTu9t/htoxRjHKYhjVNIupZlLrq8QycCsJUJZbhf3luainF9ET
	NQrJdHvcVK6Q4i6lB8T2KwQ2OF9cBs0m40UCtirm+9w==
X-Gm-Gg: ASbGncuI1Bbh7oXu1WyXWfHXDdeELz4U7CJ6UzHcv+ongSnSBu7Z3suC1lhCV+d9D3u
	rXAhUyuXPW6PWbCpxPRjG+8XiXWy4BKYx8i4n19FAgA0Ph3pSyEvBfv67k2l1Mf8UfSN1g8tes2
	GSJ8hqAz7ebRobupsrp9/UpDVrWSoH7JgLFJslxF42f5hTrk3SPG1Y6DQAqsaKpzrK5zvgFe1GT
	ssIjBnE0vmKt5AaEDQakbpg3sqB6G6Z+WOk34HU4f/VRh7W649mQRZNkop4EJ+yM2CtUaBUj6I2
	A7axIj1feLX2pgjMLMfQ0J7pbQ==
X-Google-Smtp-Source: AGHT+IFLx4rEab/wbUDo4EkSCUHDw6GWYiJjtIbCHDB1xl+ZlXv5nLLQYI54hMzgwVsRu8daEpH3NSYMy9pTQDZmbZ8=
X-Received: by 2002:a05:6512:3c9e:b0:55f:4633:7b2 with SMTP id
 2adb3069b0e04-595841f842bmr5089204e87.46.1763472103404; Tue, 18 Nov 2025
 05:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com>
 <CAMRc=Mdo__Yzigqoy4xKt0LWSvES5Jse1HeXkePfhiWyiz6tBQ@mail.gmail.com> <CAMuHMdXpySSvjgju2LXr6puVXzHMR4ckpaKEWK_S4spTWz6B-A@mail.gmail.com>
In-Reply-To: <CAMuHMdXpySSvjgju2LXr6puVXzHMR4ckpaKEWK_S4spTWz6B-A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 14:21:29 +0100
X-Gm-Features: AWmQ_bmgN3bhvSn3FjfwQqs5x52sLWvM37dbNjtnEqn6scQIfee74Ky62f9fPdU
Message-ID: <CAMRc=Mf_j8jNMrJrnGp_bVmYQPLheE55AN4gXCtRrCDkF5CXsw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Nov 18, 2025 at 1:56=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> > >
> > > Thanks for your series, part of which is now present linux-next.
> > > IIUIC, this requires the direction of the GPIO to be fixed?
> > >
> > > We have a long-standing use-case on various Renesas R-Car Gen3 boards
> > > (e.g. Salvator-X(S) and ULCB[1]), where GPIOs are shared by LEDs and
> > > key switches.  Basically, the GPIO is connected to:
> > >   1. A key switch connecting to GND when closed, with pull-up.
> > >   2. The gate of an N-channel MOSFET, turning on an LED when driven
> > >      high.
> > >
> > > Hence:
> > >   - In output mode, the LED can be controlled freely,
> > >   - In input mode, the LED is on, unless the key is pressed,
> > >   - Hence the switch state can only be read when the LED is turned on=
.
> > > If you have any idea how to handle this, feel free to reply ;-)
> >
> > How is this done currently? Even without this series and using the
> > GPIOD_FLAGS_BIT_NONEXCLUSIVE, the descriptor has a well-defined
> > direction so it's not possible for two drivers to request it as input
> > and output simultaneously. The second requester will override the
> > previous settings.
>
> We do not handle it yet:
>   - arch/arm64/boot/dts/renesas/salvator-common.dtsi describes only
>     the keys (key-[a-c]),
>   - arch/arm64/boot/dts/renesas/ulcb.dtsi describes the first key
>     (key-1), and the others as LEDs (led[56]).
>

I see. This series cannot possibly address this. Off the top of my
head: I would create an auxiliary device binding to a dedicated driver
that would be a consumer of this pin and register a LED and an input
key. By default it would set the direction to input and if the user
decided to configure the LED, it would change direction to output.

Obviously, there would be a DR quirk to handle as we already have this
described in DT as gpio-keys on salvator.

Bartosz
