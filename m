Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0633B97B
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468772; cv=none; b=KroBtWJ/GUfFbYidle8CBJwxYK/hnRFdBWvf4kmgsWlM5yoqJ+6zLoTDxF8WsbUHhKsv3+8HaymzyISaXuPcbUbEp+04BTbH3wcju5bBC0KskaHnhyCU4jBq6S0HqOr6oR772Bjo0dO7YNWlelYSppAaTeK/Gxeoh8SL3hbL1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468772; c=relaxed/simple;
	bh=+Gr6FmHWkLjdap1UuMIr5k9ql3qFQI3++CVwNijPDgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gilg8mSPqB5fvuyr8zVWCCQut8w8UkQaHY7TivzQtd5TkrdWUZpRZ52ccMWe25hvvc0R5rY9nTRlUf0QYd9y/GeAnr4ekTM52vlryatR9nFLLWUkawmpZP3c5F8E9M6JlkJDqaO1d/Nw/5awceWX+/WlOzjW7HeIXtK4xRKIk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ImqRgnh2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ImqRgnh2"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5958232f806so5253699e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 04:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763468769; x=1764073569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLL6e8iJwMExQReIm6SFIGuUarrfVqjg15kTAK5l7Pg=;
        b=ImqRgnh2TjyrEIB0BnfGHyPjLs7k9b/f5EY7+7jQVoL3H2kBk0DUXlcJG5aCEyypg/
         djsnioAetzU6GkHTmk50qBogSo6oWJWipPUjUCgpBg8LgBhxtJ79nVFsR31oXesVvFnp
         qrMjTTKg+HVCenZnoldwda/xxsFmfiZONLJXchYuioqfEFg5irHU4LnUIgK1jO6xGPI8
         YQOI7/YOQlHQ3emJzuA8igLGr/H1fZtekCnkkpyUnobSVJKqJOh0qnzrFMBd4CxcWh8C
         sZuGYGk9e6F0XBXIKT8v5uAWcVenV+ZACqSRCIYFLkVb6m4HWPG1SJZ0/TwpSrhtGPQi
         KjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763468769; x=1764073569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLL6e8iJwMExQReIm6SFIGuUarrfVqjg15kTAK5l7Pg=;
        b=PZHVRc/M8XJzLQSD+9GxT+mQq/9RRBW1uNUTOapsgTf2xzfZ1ib91s9NX09iD2d8wS
         gtD4wqvjBulM7CcVod7NJiRYgRdBwgLoqz/mJkVlxjucNl1K73meiSbcX1jhJLjy9Ti0
         CI4SJ0IBgvljyWOtBJknpvep0AbFMlLPz+moyMU1Cub7V3DU+V+mNElAy88ztbRo8bxO
         HtAxNwdWVmBgTZCU5aNdLCIHwCmB9O+NB28Eb18uh7Kh1b28qqvk30bCpjcm6ydXwfla
         uHsmwZNgFiJoXvOco1P4+A60bR8g3Vv+e5vHLtxR2cVCB6pWjXjvo6MkA/m3D8cofl8m
         p8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWIIB8P+ULiZeke5rxus2zi7YwA8DUSNPTm774+kdHTgJH/HD2+NSGAbmQFx2EQC+JoFMgoNPTxakQWb2/XstM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XAnjBf6M2laig9m9bXN8a7yaey7rDOzmRF2tMplL6Fkg7iZa
	qT0Occ3Z7K+9rg2XZ51knj3GCfL1nK98nThP1iPS+jI7Z25cqSrUZGV3zgOLxhxGNNlU1paXKJ/
	EDqgz1c8HULG2/xoQTnp7wAqpf2XOxJ9bj1aKGKE7hA==
X-Gm-Gg: ASbGncsHKNjLNlWIyVum+ZgN6jBvvlFAIAuxkw64rBA2mXjgxPrpVNFXEbNQN6LF1NC
	416e3s4RTywyqIFXvwjSB4oSDsNVLthFgB7tQMJlsG90LAwTd5i2QTr5TSBqNfoGpUHfdR+LhqT
	Cpoylhuy5M2E2N8iR4Wqej0qMhdGF5kbQqX9SDvK3uGD8EEQh06rCoiWTCxB0yTuuylVfftmjzZ
	jMLiuMEX2XUmv6e3k2Qzfipf5sqIXdLbgXE1Z8A1SjS94q1+G1BSF6O6Wdw0MaUs7sD6a3uIUnh
	7n1+IEXAzkammCnxMqDGD9goIg==
X-Google-Smtp-Source: AGHT+IH75GcKB+kwrEY6ut2f2Yd7x1+9e+gXSX5PxDos0MCwlQkNOACNL3YrWObRllBaNeXTAxTa8x+2fRDAMdoVldE=
X-Received: by 2002:a05:6512:239d:b0:595:7ed0:9c7e with SMTP id
 2adb3069b0e04-595841a8136mr5858462e87.3.1763468768609; Tue, 18 Nov 2025
 04:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
 <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com>
 <CAMRc=MecMJDNA=ry6YnyFxq_EeTDG6hfx2+wg+OTPBfdzXKFeA@mail.gmail.com>
 <CAHp75Vd962ASEjeiJpv_CcQALK=dayzSQRCN3b5Cyp5GmdjdVw@mail.gmail.com>
 <CAMRc=MeXQgkO80i3wnC1ogs6U8ZV8FzH13n8emaG63eznwey6g@mail.gmail.com> <CAHp75VeXsGFanSxc6=msKU_1HMUgPdharh-npYJnS1kAxDbAfA@mail.gmail.com>
In-Reply-To: <CAHp75VeXsGFanSxc6=msKU_1HMUgPdharh-npYJnS1kAxDbAfA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 13:25:56 +0100
X-Gm-Features: AWmQ_bmc6H0PpxRObtQmaUmi2hPfgiF2IH56_ODEAdIGmEBSpt5HcsQHV3q582E
Message-ID: <CAMRc=McFmcFVyVE+b1EPASdQAuuBrXds11o+=QVXY+HocXOGBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] string: strends() follow-ups
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 12:58=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 12:43=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Tue, Nov 18, 2025 at 11:32=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Nov 18, 2025 at 12:14=E2=80=AFPM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> > > > On Tue, Nov 18, 2025 at 11:09=E2=80=AFAM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Tue, Nov 18, 2025 at 12:04=E2=80=AFPM Bartosz Golaszewski <brg=
l@bgdev.pl> wrote:
>
> ...
>
> > > > > > A couple follow-up changes to the new strends() string helper. =
This
> > > > > > needs to go through the GPIO tree as this is where the strends(=
)
> > > > > > currently is.
> > >
> > > > > For the
> > > > > strends() I proposed to get rid of strlen() calls by
> > > > >
> > > > >   char *p;
> > > > >
> > > > >   p =3D strrchr(str, suffix[0[);
> > > > >   if (!p)
> > > > >     return false;
> > > > >
> > > > >   return strcmp(p, suffix) =3D=3D 0;
> > > >
> > > > IMO that's a bit less readable. Unless you benchmark it and show it=
's
> > > > faster than the current version, I'd say: let's keep the current
> > > > implementation.
> > >
> > > For the static suffixes the second strlen() becomes a hardcoded value=
,
> > > and I expect the benchmark will be closer to the variant I propose.
> > > Otherwise it will be definitely faster as the strrchr() implies
> > > partial strlen() and strcmp() is the same or even faster in my case a=
s
> > > here we don't do the additional calculations with the pointers. Do yo=
u
> > > really need a benchmark for this?
> >
> > Ok, I don't want to load too much string-related stuff into my tree.
> > I'm adding it to my TODO list for the next release where I already
> > have an item to replace the OF-specific implementation of suffix
> > comparator with strends().
>
> Okay, I have done a little benchmark (but on GLibC, a.k.a. in user
> space) for both.
>
> TL;DR: if the suffix is known (string literal) ahead, yours beats
> mine, and vice versa. Since I suppose that most of the time the suffix
> will be known, I think your current implementation is fine. And I
> assume that the kernel implementations of the respective C functions
> are on par with GLibC.
>

Thanks for taking the time to measure it. Ok, I will keep my
implementation for now then.

Bart

> RUN 1
> // static to compare with '-0c' out of 24 strings with different
> endings, 23 do not match
> strends1 took 0.919427 seconds to execute. (last 00-45-76-09-01-02-03-0c)
> strends2 took 1.100318 seconds to execute. (last 00-45-76-09-01-02-03-0c)
>
> // same, but the (random) suffix came from a variable, so the compiler
> can't optimise that
> strends1 took 1.398531 seconds to execute. (last 10-f5-06-08-04-02-03-0d)
> strends2 took 1.055180 seconds to execute. (last 10-f5-06-08-04-02-03-0d)
>
> RUN2
> strends1 took 0.945234 seconds to execute. (last 00-45-76-09-01-02-03-0c)
> strends2 took 1.012759 seconds to execute. (last 00-45-76-09-01-02-03-0c)
> strends1 took 1.210770 seconds to execute. (last 00-45-76-09-01-02-03-04)
> strends2 took 0.933389 seconds to execute. (last 00-45-76-09-01-02-03-04)
>
> RUN3
> strends1 took 0.858516 seconds to execute. (last 00-45-76-09-01-02-03-0c)
> strends2 took 1.011493 seconds to execute. (last 00-45-76-09-01-02-03-0c)
> strends1 took 1.221119 seconds to execute. (last 00-45-76-09-01-02-03-14)
> strends2 took 0.953013 seconds to execute. (last 00-45-76-09-01-02-03-14)
>
> Each run is 10mil over an array of 24 strings each of 24 bytes, so, I
> assume cache lines are drained properly.
>
> So, if you can see my algo beats the dynamic case well (bigger time
> delta for the static comparison). If you want, it can be done both
> ways (each algo for its own cases).
>
