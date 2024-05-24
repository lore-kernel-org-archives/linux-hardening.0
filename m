Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8E6D1A0
	for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716590630; cv=none; b=KdhN7VwOWBZDBy2r/KL5JVkbU252BhUloyTzZPc+EJvz9NTU6DtuqSXG2uKtEExEitXOn6OLmv6HFpNcnghYwGjNLXBKxs/u+yVe9GSuf5kb9qI4/vCoFmU1CytICf+fxVYDXdw2US6bEZSxrsEUavX/Vs5G9A29z3RT4LerfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716590630; c=relaxed/simple;
	bh=ucFbGWz6mMVoDnnPzwBRuL8Yb/nGgWE428XQaqRqtRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jck9tLUSlCc3ZBizeKGttbhLHxjPToZldYQTOn/Jl4OXm5jzUzAfKrBZgTcGKRFZghRC9/jD5S+CN73pgMzmLAWK3JJbDrzDqk4rzRpAYpaFKFd2gGgXfp7wUlwVYVfQRnOiHYobmNekBGUOdPObIoEuDvS17kMUdaRKhXf6FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiVdYy9C; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiVdYy9C"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80318a7e93dso1103378241.3
        for <linux-hardening@vger.kernel.org>; Fri, 24 May 2024 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716590627; x=1717195427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymFK2RObdNjzPsJxP220O5+71BNflb8CNq7Wj8mqDgk=;
        b=SiVdYy9C+Lh5VCRx2n2IsuyZB6xVlAX5N53nl8OgWDdhG2kjOQmGkqRYwQAFS+Mj67
         BTvPnCzPosLoYY3JZxtn0UB3lYFNvpiulvJdh5EPhkJwBej5LxL9lyPEvPlLIElOJ1Br
         aKdh1SBtCZsMC8V5ud0JRnWKIqlSSNFa/TW6l/yqcQHzwJnO6h9JsBPKjPOOthLHZEjV
         Sn35e4bIbVC8guq9wMiF5LNBFn+fbirTeWTO0U4CGstBZbFW4FfgIrOS0+XBxXBCUIrS
         T11bJKG9udlKifs6RssNbvSVHxRjAuXydkeU5td8ALr7EmB+12U37eNndB3R83uCrlfa
         gPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716590627; x=1717195427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymFK2RObdNjzPsJxP220O5+71BNflb8CNq7Wj8mqDgk=;
        b=WDXKd2oB2ya82H5D1ivJ/o9P7D5VMCNxqpct8BgSiWl+QbvTq/3aiefi1wBoeTyoqT
         NLiNdTdBRic0FE+X0CRu1k0O51EtD44VIgHan3zTU1Wf/hAlzmERbxTXITiLbmhTIvhh
         iZhOjDeOeRrEAU5RvzeHRSBAhEjhmZoIFeN2Qwll5JHYFoRcNpWKAZ0DBL+8P8mSPKAO
         fAzGhB6Nf8CRL35RTWiq5TyfW0YL+YG2Sq0dZtF4p9UjwyVKYe04MUnjpyaezEqkVOtt
         8FnbXtJRdyQsXTF865Um55V9wGUeYP/Rz3oV9UEvyvEURhxK/WMwrHNTPB9jNkxeXWYF
         10eg==
X-Forwarded-Encrypted: i=1; AJvYcCWPtaZ7KA4ovB5Db4sUwQkNwFnPVoBG5/ndhiKiIHo8mHKsWAALYWlzIBiWxhehYzp6Goq+gdZwGgMJQ357G2iRVbfUvV/2kk48hfvPtp7D
X-Gm-Message-State: AOJu0YzLT5LMDmIVVKwO6OAPF/B7t1gCQy3cFXa8KSDVJTzyTK+obNTV
	ylvAYojZEdHefe0lF5pv82GIQ6OzXcYkzRW8sMeZCizg93PKuSh1a1Vq6VOn21gaZathTpzHo9s
	9t4wjDDb5bSko1Fth6GPwOu+/1fqPH6WTpkam
X-Google-Smtp-Source: AGHT+IEUGTDNkD54qyJg80rQHwEyHmm7B9lB9DQteWkSaz9UWWF3L+6g5cloJy/CNjqKhEMoxrKZcnEAYLz5ilTnrYs=
X-Received: by 2002:a05:6102:2e7:b0:47b:f5ce:569d with SMTP id
 ada2fe7eead31-48a385134d2mr4040126137.3.1716590627119; Fri, 24 May 2024
 15:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com> <87ed9re7i4.ffs@tglx>
In-Reply-To: <87ed9re7i4.ffs@tglx>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 24 May 2024 15:43:35 -0700
Message-ID: <CAFhGd8o0eFh0sqXtOcw=E+WBaKCTatpv18fA1Pzr_M1aC9OQ=A@mail.gmail.com>
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas,

I appreciate you reviewing my patches.

On Fri, May 24, 2024 at 5:09=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, May 17 2024 at 20:22, Justin Stitt wrote:
> > time_maxerror is unconditionally incremented and the result is checked
> > against NTP_PHASE_LIMIT, but the increment itself can overflow,
> > resulting in wrap-around to negative space.
> >
> > The user can supply some crazy values which is causing the overflow. Ad=
d
> > an extra validation step checking that maxerror is reasonable.
>
> The user can supply any value which can cause an overflow as the input
> is unchecked. Add ...
>
> Hmm?
>
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index b58dffc58a8f..321f251c02aa 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -2388,6 +2388,11 @@ static int timekeeping_validate_timex(const stru=
ct __kernel_timex *txc)
> >               }
> >       }
> >
> > +     if (txc->modes & ADJ_MAXERROR) {
> > +             if (txc->maxerror < 0 || txc->maxerror > NTP_PHASE_LIMIT)
> > +                     return -EINVAL;
> > +     }
>
> I dug into history to find a Fixes tag. That unearthed something
> interesting.  Exactly this check used to be there until commit
> eea83d896e31 ("ntp: NTP4 user space bits update") which landed in
> 2.6.30. The change log says:

Thanks for doing the archaeology.

>
>     "If some values for adjtimex() are outside the acceptable range, they
>      are now simply normalized instead of letting the syscall fail."
>
> The problem with that commit is that it did not do any normalization at
> all and just relied on the actual time_maxerror handling in
> second_overflow(), which is both insufficient and also prone to that
> overflow issue.
>
> So instead of turning the clock back, we might be better off to actually
> put the normalization in place at the assignment:
>
>     time_maxerror =3D min(max(0, txc->maxerror), NTP_PHASE_LIMIT);

A saturating resolution strategy is one that I've taken with some of
my other overflow patches.

... but how about: clamp(txc->maxerror, 0, NTP_PHASE_LIMIT)

>
> or something like that.
>
> Miroslav: Any opinion on that?
>
> Thanks,
>
>         tglx

Anyways, I'm waiting to see how the whole overflow/wraparound
discussion in general evolves and, of course, how the local discussion
about this patch shapes up.

Thanks
Justin
