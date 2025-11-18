Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58599309DDD
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506705; cv=none; b=r/AQ1n8OhVbwVzcwdxqCkQiP3W4Tom3VQ+Wubtw0hQ9Gj8GEw0en+uFGAEGIScb73bWZZWl77otXkVQyzSCMZjOJ8ZFWVHuDo9vnaec7NTZSW0FmlPTL0vKmxeayQ2nph/DkbKs9/D3QFL4ZXmsmWLBZTUObzIVYS1V0BVTEoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506705; c=relaxed/simple;
	bh=w+61w5T6iw2L+z7yyBk2vWNFdM7DOlMNfukQs3rBBhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svlPhPA2CfX1KpZ6Cm7rNbvXiKCPP92JPpRyVgdgSzpYo3ccs6JQuKG60RCZNlw+5oCwkKjCkxEkZau9vmkzoMB9IhA66wNlhXKZJUcxbEkD7xoms+mYuyHKnq4bTIJwiFL+oy8cGLB58pAaF1p5iG4ES3m4hIi6IXiraQaGWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I999fFip; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I999fFip"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957753e0efso6429145e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763506701; x=1764111501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+61w5T6iw2L+z7yyBk2vWNFdM7DOlMNfukQs3rBBhU=;
        b=I999fFipZH0VMJs1NWl2Y2P+lyilTmSjlh8soGhqclYfpREVuHV9251IqgmuDrp931
         vliDmAVxF46vufxmK3SYHtaHsWW4GseQB58lh5Enx7qEoXiHTyIlDlUmtz98L3NgP9QX
         bEbDyhkTVeaFnZUdkTQcUwpIJtjCLAZHR1m8U7rmTJj1ANjMY+8DSXT6oCtzjYFIY0i2
         9FCP0HsG96HWD4Mcc1dLvdrgMN6Ux2r9ZYnjjpFW3X+5VzYiMetGONFJcQn1OlAQFnZP
         V25T6k/1OI881/GNv/ojfnDPDGK9lHVRZd3NRW6YgrNMDwyDTTbA8JioDFDdd9OgX2FV
         6ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763506701; x=1764111501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+61w5T6iw2L+z7yyBk2vWNFdM7DOlMNfukQs3rBBhU=;
        b=ZJC0utL5Du0vzSax6r86hIW06II3ISNzNga6owfkb8bUGkzYYgbdsWzMiCkcE1Oq6d
         qF8w6EcJqSpe0D9OCLixcJkoct3nqQrqtmFwKgLfBJNz4GuXCeu7xmu6Yg4Ct3LZPO1m
         wavd1XdsfadXgeaBFbhumP33JFKUySnvT58mpdWi0+2uGCNPch8QMiJdSZpEdKOX+chH
         lSv7melmy9snEB3hH9ZsUw+Wuqs+BY/q0pzVwbTEnIUyITNQq9RmF6PZmjnqirbrTuPH
         LBaugorG6UAdw165hbE2mI2Wm4kNOzEHFSZhxeD0NeeyAymEPiop2E6UxHmHnn2UHjRH
         qBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWan4outQknmcAVnZcGjO7s2ukUEmWKEDlMdBZ3yjFQE7QsEotF8s18OtlQplG4pAJEEbAHjQf1XhIHCFOYOJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtigEp1EbOspnzuHW5hYmIBmABBe4Wuq4/fwyQTVN0RKyjuLbn
	JoNOU3omKsfCYWMtM3F9MiHyPwhnB1Jvb1VTGYFEdYjlmFklKBZzM06oN3CjdRWuLyCYpGysDyq
	6GHl+nYMZp9ijhPMmF5RDo1rmJBYkTF7G8Gb3C5mVZw==
X-Gm-Gg: ASbGnctw4v6zESn0L2GAc9eMp92jldGOx1m5nNu4DcAtCsUJqIo47UssnyWa0OAJyzn
	asUl/cC+KGHRk4patFJ7gVHolKZhagXVb9S1ZWyjHOsSwPMEfb/+/6afE9Q6ukxIPAFHE7nDaMH
	GRGwifVTrz/B00p36nltb6JisjGopXMKJQbAqNFcBRcby3769cdib13o+Qe/x64DRbYkEnY1iue
	PuCKhdW80bE8kHcGTCbP/OgGVl8huHgbscsu30RM/8YeQdXP2pEdxHoQrOqUjxlrxWf6+8=
X-Google-Smtp-Source: AGHT+IEgaegsgmXSR9c8Hx3M4QpdDNUJIc1KFnkqGODlEyosq51AmUd5jf6mWflPCoaxnA933h/YZYR/OFhWE8sa4io=
X-Received: by 2002:a05:6512:33d0:b0:592:f48e:c725 with SMTP id
 2adb3069b0e04-595841f9725mr5921930e87.34.1763506700860; Tue, 18 Nov 2025
 14:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-6-d34aa1fbdf06@linaro.org> <CACRpkdbqLyeaZx37yrKjDFWb=C5c=vK6aPgnW8cMQvwi_6Jiug@mail.gmail.com>
 <CAMRc=McySdUtj4foEf5a2db8jUEa=CnPmVVms2nwHoO2UYChSg@mail.gmail.com>
In-Reply-To: <CAMRc=McySdUtj4foEf5a2db8jUEa=CnPmVVms2nwHoO2UYChSg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Nov 2025 23:58:08 +0100
X-Gm-Features: AWmQ_bkpyyk7f39_4wc6746I8bnl6C3ILvHa9yZ2lrW5div8cVmrRRgtpGXas6k
Message-ID: <CACRpkdYjL3u2UyD8A9uLWf1wU6jQXvAOhU5+Y6+8QXeTAe1ksg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gpio: provide gpiod_is_shared()
To: Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Nov 12, 2025 at 9:06=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Nov 11, 2025 at 11:44=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> >
> > On Wed, Oct 22, 2025 at 3:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Provide an interface allowing consumers to check if a GPIO descriptor
> > > represents a GPIO that can potentially be shared by multiple consumer=
s
> > > at the same time. This is exposed to allow subsystems that already
> > > work around the limitations of the current non-exclusive GPIO handlin=
g
> > > in some ways, to gradually convert to relying on the new shared GPIO
> > > feature of GPIOLIB.
> > >
> > > Extend the gpiolib-shared module to mark the GPIO shared proxy
> > > descriptors with a flag checked by the new interface.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
>
> I think you wanted to leave this under v3?

Yeah probably, a bit messy in my inbox!

Yours,
Linus Walleij
