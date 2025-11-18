Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B52D0C89
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467125; cv=none; b=N6eUwuUEtSE0qE2bpp52wootjWGpJbuJUDWtcro8mGMIMHXEkIGo6kktjvmU+Q2mXWkFppNuiBX5wcUSM7ilamUdxp7Z3EFA+Zr61X3Ue3xjRKMOW3OnrJgb6dA7AD22sJW53Rdsmygz6qRp43QRQ9M3iipHgj5ruqqMlHgqvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467125; c=relaxed/simple;
	bh=sgeeFhtAo+U7F51ccfZ8I6/jQVZuROt6zoTUsv2zeTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfNeY+Yu4DMopLYR2pBKsfFtR0XmT98TCmci9s+wt9eaxI7tl2Jblbum04YuPOEe5YWOBeIqrwZdUDaU4PFgXFWSbeJjXXl5Ap7h7XI2jo4+CVMlyGyyQdmj8HKFZoHWaakZlK2+mAI6dWeW7nKv+DkzGp7Fddco2mbTNmFI2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQsv6lBG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQsv6lBG"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so1473392a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 03:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763467122; x=1764071922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LQ1qllqnuyBEWgBWNn/GXh98npBI88Ju7xMajM099s=;
        b=aQsv6lBGFMjG5sHKv5NDuHaty9nBRkhCOXCosCH7EYYgYIjvHnX3DRO0hqlNVVlVSz
         A9B4b+XqMz1C98WkH5APsWXc17mEXw6cUXZQkqjG/Ge9yfd3ttf+w9GlXI2CR7ML6o6d
         MfzNUV94m0CUid2RIITfAAyk4ntbmqnL/t4pG57kloV6cLKxWo6udjbRSrwT9+lK4tTJ
         VxHHKyzGzC8zUEgl7EhxwdA9vj0SMrJhCFZ5MOrflh06slNs1lW7toI5QUFGdsLtWhqK
         GQTXaA3px4kdSRezat+42n5VXSsyztXnWh9l8rQiWN4N5akCpNcWImTj51zP+vBByrgv
         Gp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763467122; x=1764071922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LQ1qllqnuyBEWgBWNn/GXh98npBI88Ju7xMajM099s=;
        b=F15cWEpQ8z9Axu2soGykl1P4Nzk4+MNOPfFPfq8ukP44QakUkK+9EqyyhVSRy8FzR0
         GbtZr+3F8t4HJGz+HuHRVqOawa6Edvdt78UUIwFw+yTG7MwbA91LDawTjGwg7ElG5zT4
         IdFszUu+uou7ddPDsRrdDaE75sad2Nju7ZCvUCEo6rZ3ZgVRp9Aq4Kr9ZUfB2mtzIdZs
         wxqm/YKckycv1f1wEkx4d+2Os87lklEX0/iQm9fEczJTjSSzeRvzSOM+LvSRhQz5T4GZ
         Fyp2yIr193nzzW/j17vXqFuKzj71rV8510iPGuNhnWJU7Pp2CZ3LrAyp/FWfgfV7qyKn
         WzfA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jzGf6pnDHhsdf4oDNFS5B58xPu/ej/gwGRC4/yCzabIckEJ197aMTAfQNtevcarScAdugYbm2fEcnLxOEoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUWsJoC3hOZ9kP2BnOHVrHDftitKY8JdpgBiYTgacaRqqpKDu
	OkDGXlUOQGikL7Z3NdRzsmTtAGWi4dV52FavsGdNuvaPPXbBnQfnNJNIKJ1beLlUy8Xd8t4Ssuk
	GbSVIB8T98cM1z8UNzAiJ68o2hDjKe1g=
X-Gm-Gg: ASbGncuU08hg7ZGeMLG8NjXQbCBNwjj5Om5pT92eEEutuRvKeEjeWo9e65Gei1rZKiQ
	F9+jfJmZagoK9spHV3Y4LkCkXjV7zwUHxmt3CofmPAUbtpvdrSPemCxyq1vn0cjm7loUmk+Cxlk
	RTSbklrNOM5d/9twtfhUZkaNpRSkICPaJv3v0muJfDzTGcYOrtIYXbS/xlrgtkt3OTAShAKYHUZ
	r5JaF7S/yz5vhX2YzjxorLkutV1uvZPhTzUylJYWNM6uX64Fyhd7iraHtguvrvZ2yhV6Ro5X5OB
	1Ns29RCn4AIN4/YfktEP7aJQXzfzXKQvgA6Bcb5KjRBHRo60c6ArcAnd6DON
X-Google-Smtp-Source: AGHT+IEWF7yJn/9q1w3dFQlotNCcyCstK/VwwJLONE/u3KKMnXtFmT2UbvWKm4jBAAGWXg9z58OrKIY4TOKIIO8DhlY=
X-Received: by 2002:a17:907:3c93:b0:b70:c190:62e1 with SMTP id
 a640c23a62f3a-b736793d2eamr1672680366b.35.1763467121363; Tue, 18 Nov 2025
 03:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
 <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com>
 <CAMRc=MecMJDNA=ry6YnyFxq_EeTDG6hfx2+wg+OTPBfdzXKFeA@mail.gmail.com>
 <CAHp75Vd962ASEjeiJpv_CcQALK=dayzSQRCN3b5Cyp5GmdjdVw@mail.gmail.com> <CAMRc=MeXQgkO80i3wnC1ogs6U8ZV8FzH13n8emaG63eznwey6g@mail.gmail.com>
In-Reply-To: <CAMRc=MeXQgkO80i3wnC1ogs6U8ZV8FzH13n8emaG63eznwey6g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 13:58:05 +0200
X-Gm-Features: AWmQ_bmwH6QYG5XRVzsw9omZLrh05x6fSNXRijQN_JVzyX2iKV5mQ1K48b0YMqQ
Message-ID: <CAHp75VeXsGFanSxc6=msKU_1HMUgPdharh-npYJnS1kAxDbAfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] string: strends() follow-ups
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:43=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Tue, Nov 18, 2025 at 11:32=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Nov 18, 2025 at 12:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > > On Tue, Nov 18, 2025 at 11:09=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Nov 18, 2025 at 12:04=E2=80=AFPM Bartosz Golaszewski <brgl@=
bgdev.pl> wrote:

...

> > > > > A couple follow-up changes to the new strends() string helper. Th=
is
> > > > > needs to go through the GPIO tree as this is where the strends()
> > > > > currently is.
> >
> > > > For the
> > > > strends() I proposed to get rid of strlen() calls by
> > > >
> > > >   char *p;
> > > >
> > > >   p =3D strrchr(str, suffix[0[);
> > > >   if (!p)
> > > >     return false;
> > > >
> > > >   return strcmp(p, suffix) =3D=3D 0;
> > >
> > > IMO that's a bit less readable. Unless you benchmark it and show it's
> > > faster than the current version, I'd say: let's keep the current
> > > implementation.
> >
> > For the static suffixes the second strlen() becomes a hardcoded value,
> > and I expect the benchmark will be closer to the variant I propose.
> > Otherwise it will be definitely faster as the strrchr() implies
> > partial strlen() and strcmp() is the same or even faster in my case as
> > here we don't do the additional calculations with the pointers. Do you
> > really need a benchmark for this?
>
> Ok, I don't want to load too much string-related stuff into my tree.
> I'm adding it to my TODO list for the next release where I already
> have an item to replace the OF-specific implementation of suffix
> comparator with strends().

Okay, I have done a little benchmark (but on GLibC, a.k.a. in user
space) for both.

TL;DR: if the suffix is known (string literal) ahead, yours beats
mine, and vice versa. Since I suppose that most of the time the suffix
will be known, I think your current implementation is fine. And I
assume that the kernel implementations of the respective C functions
are on par with GLibC.

RUN 1
// static to compare with '-0c' out of 24 strings with different
endings, 23 do not match
strends1 took 0.919427 seconds to execute. (last 00-45-76-09-01-02-03-0c)
strends2 took 1.100318 seconds to execute. (last 00-45-76-09-01-02-03-0c)

// same, but the (random) suffix came from a variable, so the compiler
can't optimise that
strends1 took 1.398531 seconds to execute. (last 10-f5-06-08-04-02-03-0d)
strends2 took 1.055180 seconds to execute. (last 10-f5-06-08-04-02-03-0d)

RUN2
strends1 took 0.945234 seconds to execute. (last 00-45-76-09-01-02-03-0c)
strends2 took 1.012759 seconds to execute. (last 00-45-76-09-01-02-03-0c)
strends1 took 1.210770 seconds to execute. (last 00-45-76-09-01-02-03-04)
strends2 took 0.933389 seconds to execute. (last 00-45-76-09-01-02-03-04)

RUN3
strends1 took 0.858516 seconds to execute. (last 00-45-76-09-01-02-03-0c)
strends2 took 1.011493 seconds to execute. (last 00-45-76-09-01-02-03-0c)
strends1 took 1.221119 seconds to execute. (last 00-45-76-09-01-02-03-14)
strends2 took 0.953013 seconds to execute. (last 00-45-76-09-01-02-03-14)

Each run is 10mil over an array of 24 strings each of 24 bytes, so, I
assume cache lines are drained properly.

So, if you can see my algo beats the dynamic case well (bigger time
delta for the static comparison). If you want, it can be done both
ways (each algo for its own cases).

--=20
With Best Regards,
Andy Shevchenko
