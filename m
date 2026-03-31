Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD6342C88
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977476; cv=pass; b=utLsL+THRjqsYzBctH4qtAKUDhYOWhpKJzu9KhnTb6FA0Wc1NtK6mrf0wV9lAfpRJTf4CElSgcwzJgnayHEwqwMcAxErzkIGKv3Uglwjvzs9I0Sa3696r52/qyVXhE3sFWZx9ihrFwrlRACNTcDwh4xWT3Rvx+7WFtNkpqT59yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977476; c=relaxed/simple;
	bh=XfvO/nNrfp6wJ8ltBre7ekP/xZ/Y79d2E/5o49cgJb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPCcgrAitsij8lQrNG4HXEkRAnTSDq9z/fAWlbGfYkHMZR6R2xINOr5ssGUD6z4iBB3eRN3H2Y2eFVA0H/5EFfJkGoRqHpMF1CyFKUxfyPphonP8NDFk1WsGl/dMZ4tqeG24lk/ospIGmL2Ah/Phk3GzF7M+2pxzh4IlRIrjeFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4GSVzlP; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4GSVzlP"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-953b15c764dso1450992241.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977474; cv=none;
        d=google.com; s=arc-20240605;
        b=JPgwxhiNWkE1rYsewwRQJt0xXZZDD09Ab7DvzXWhGBbN9NM/Ay3nagxd4YF1VBfhIN
         SPIehjtokKLbnL8p5NKQfFYyLwxbIRnH+bC5RsNnnskB1BuZ5G9An/zBP9VHt0EPjZXq
         tL2HDmuBQ/NNCzSTB1qQ9MYUsjTcgNCgO/kR84ZMa9VwHhOf9FKCGKlNOVcpCdz2RCX5
         y2rY7fZ5Ih85sVr04zPiWGZ5e3pEf76vK8ZHxPpAK5J8xrvQGhb31CCSTZXwJUX/3BAB
         m/+7ptw5Z5VYb5Nh1M7Ei2u0fggiCIlBKTrRd981iRPcroE52Lf9t/+Dk/zgc5ZdOtNT
         K+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XfvO/nNrfp6wJ8ltBre7ekP/xZ/Y79d2E/5o49cgJb8=;
        fh=ku9yXoXsat+u2X79Lffxj1g+VuP/laWnoeRac/Mo9W0=;
        b=YImY5qRou4lNPDtz7IVRjQzGrYKXHjSNwzJRuYNJyvIV+Mob3ABDmYk1LdDmiClrD7
         mogIv0Nx7E8yfIfiRJ5138p9oKzYwyZfWF0+DEF45vMyvakJBpxSMneu12pKHV5TFQQT
         JqMtnjg7dnWROVvEdezzGSxD4VjfgKa9zkaX3OEA9ZKxf6V1T8PKJqcQN1kmSYxUtZB6
         Rw+CANORi/Q9VV9JM8Ncw8oL/oOT+l2kP3vFPTQaDQ7VAobxIe9oondTqA2pec+GZNl6
         KKH6+IT8oYlKYxMKk3VH/vDg5b2QT28ReDr12hz3QxQB6bJwvehueQe1IDJAItikRub5
         /UNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774977474; x=1775582274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfvO/nNrfp6wJ8ltBre7ekP/xZ/Y79d2E/5o49cgJb8=;
        b=g4GSVzlPvZyTxCdQRik9r58eeT3v3a/iTwQpqVjcArg3oZq/1wkwpys2I1Cf/kxCFH
         6djOmhHrT7fomF/WgtcNZDLzyYQG7WnV6dNM9A7kHloTjNwFhbvPNBwNiPJCGMFgJvIv
         nrhzSa9HTdWbe2JaOROrd9RyBsYf5ETfj7+f1cYQgn9sjWCJ6+9OaafpGTm7j+7zglNw
         f/qze2XNhWiUM6J9/gfNoCCvR6g2PRwDDfs22f4RpveOsgfYG+5tEw0DLmTfMu8kRX1Y
         BnOZP+h6/0JJ7yqPuJjm6+pnI+7oVbmcSmdZUcSCKm5Loyc7/zq8j0IZ99OVMY+olF7G
         Jz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977474; x=1775582274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfvO/nNrfp6wJ8ltBre7ekP/xZ/Y79d2E/5o49cgJb8=;
        b=kfbsqfiSjhgS3UF6lC8ghTkCI3pkrRj48oxe4qsD0XZiZDR7IRVFFpeRO+BHYimZhs
         XwP+5Yh+uXup7TqC2JoH+/bu2UyqvnkYEDy+etWasNZtneZWlxzqK6SJ6GeVNSRWRPYr
         tA0mZafpLXEo/V3TBJ5Nlev8EYQsxspBYActIdKQV9zu+0NbYZ02lMXiO2ce2J0RJrx4
         p7i+MLw+cmXqW+PASqDgZrauaT9QvbqDxP9uehUDYiWTfsp7NePfYicVP21ieCWrWheO
         E7fl1JSToZQNpt3vb7K1/1Txe60+aUUArZbzFKL/GG8tqAs8UXdmff3KeeqrFnLPNsUB
         PzNw==
X-Forwarded-Encrypted: i=1; AJvYcCUUKSCbr9Fl8NiRW8jkOSluIFrnDZ+gVW+287vMz2WzVHw6YWHVYz4kC/3+6x6XLAkOU+xlgtzPRq8FfZzZrlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAPBka8A2aZQGFhalde1aWepomAd/6FRe9X/JDNJ6BvK2jOQG
	t32visGs7LGKHKCjEamf0x+DcxC+iJtk7Gz/y9cJsQKPYBhWzOiIH9jAJQHBYBlocP7RjcjB/IF
	varGIVYl6FikYjB8WEMrcA15D3R8S0AGmJR3+r08s
X-Gm-Gg: ATEYQzzd6V1OMbR4ZvF7fcQPwJdnc24pMHPJg2OhrE2CztKJX0Xk/3sodSdhD+Pt8BU
	C1eqskkiN/rLKSIBB9LhzwwcXL7acytFUKeDSOBDBYNcKdviSMTrfaRd+fmAz8DX7qidprnVWAT
	dFPnJgv2Ke8g1PvcOJ3PfD4/aREleLObSZzRJWCYk1Wl1Ouk+kj187JIfsdaCM4ar2Kru7A1QNj
	q0ZOiP7tquSCQHHpNmzdJe1PxXC9Ps0zPTdFg5vspSmYhGo6oBuIk2srO607z8UFmYr/V79cB+b
	o2X33EQ=
X-Received: by 2002:a05:6102:c94:b0:602:ace8:f20e with SMTP id
 ada2fe7eead31-60567e8d127mr40188137.14.1774977473726; Tue, 31 Mar 2026
 10:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
 <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
 <CAFhGd8paijFboDVr8rJDjScob047q+zgYAs038WuVozOG0aYaQ@mail.gmail.com> <CANiq72mQPU2Uyz27mBtfT6UF4Zgoq_osodALs21kJ4qOFLVhUQ@mail.gmail.com>
In-Reply-To: <CANiq72mQPU2Uyz27mBtfT6UF4Zgoq_osodALs21kJ4qOFLVhUQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 31 Mar 2026 10:17:41 -0700
X-Gm-Features: AQROBzDziq6Gf2V5ut4O-Crb8XfwsiZEe1mK1jC7L_WO2ZUVxZo1u0OLGaY1nqw
Message-ID: <CAFhGd8o2C5T4_-p3zsSbygwi=yDPOdpDBPC69X=R8qoefbVXew@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 31, 2026 at 10:14=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 7:09=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > __ob_trap and __ob_wrap are defined by the compiler.
> >
> > There are some examples within the documentation additions of this patc=
h.
> >
> > Kees, is it possible to make it more clear about what we expect of
> > kernel developers in terms of style? Should they use keyword
> > spellings? attribute spellings? only use custom types?
>
> Yeah, I noticed that right after sending the email, sorry.
>
> So I tried to use a macro even if happens to have the same name as the
> keyword, since that form is a bit more flexible, but it is fine either
> way.
>
> What I would suggest is adding to the comment that these were decided
> to be used as keywords, and thus we only need to define them as empty
> in the disabled case.

Agreed.

>
> Thanks!
>
> Cheers,
> Miguel

Justin
