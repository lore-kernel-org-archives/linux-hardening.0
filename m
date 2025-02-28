Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50096276D08
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704121; cv=none; b=IMeVhf35r5Vu3FUTW7Ijkf2WOHB+hK5o/t0ypHo0Bc//OSlM4wHxO50OZ8OI6AYpXzqWz274sIqXHEogpHbMuE2S6pM7kWG9mIHIRW0Oaa2K79vcEFMYJM5TNOMEXHspGpJXNp5SOYeMPjm/B5oqwN1OdcOxNdlnvMmY+HcUaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704121; c=relaxed/simple;
	bh=i5NT1VeGTEbGaE4F5Qvom40arOq2xVQJIa1NJGDG98M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p25eFrW4ijrkJ+ba7Utl6uGmTrOpcRR4rQcfw2ds8t3RLBMzPxkqqJi9asGVurnxwYiZd8XnbcLXQFkCWHNNj6Kc6VrUuMJDt3Uhe/VVYUH7J5YY+itWSn5fhPXDzeXemzU7RS8y4ilnJe9zt7wr2QGpvNheaXu8V/Ah89UYwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cGPQw5KE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cGPQw5KE"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f411a225a2so24502b6e.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 16:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740704119; x=1741308919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XdIbSK97U2bcx4CS9xaVietnaFUPHThbia6b1sB6bY=;
        b=cGPQw5KEe052xcijI7mn07ZnRQ7V7SNeSD6XSljwV5NpJfieK74s2v4KIzWXR8kWcv
         pt/NU8VYTooK/KrMhasxeRnzzS3RLQtfHb6y3jd/PrxODcNmQnJNXAD5l0h8xzVBowCV
         i3184J02H4kWRXGMmFLLxzmRcHmSqkhIPklZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740704119; x=1741308919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XdIbSK97U2bcx4CS9xaVietnaFUPHThbia6b1sB6bY=;
        b=Ad37J5yrYYJs/YseD3jjdwMwAraEj1ma/aHeB9uptYu0zu82TpvsA6nviwAQJVP3wO
         KkyX3tzox0OPiOA9Fl3SxAlnFU3uVkeuskrdATMAA9wYNtj0x0P6INgBY0B++IoYVx38
         j4oWHANZhz2C1anOtEz0ALXs4jbRNpvFNQPvhJbwL/l9E5XC4H2HuzaU0PcSn2xG8Gsw
         O8QeIYvqM7seJ5EH9I52fteRH9raQmEQi1NH5Lky/kkEBrkbgzrZtD5mzo6bvwjbvv0k
         1gB+lhCpIRHcMWsi8Qu3KfDAmEECRvYDCZ1rRYL6ZsMAdYOmRwXZ7jwtS3B8Iqj5Z42j
         tSvw==
X-Forwarded-Encrypted: i=1; AJvYcCVjOdGVzqqKFeop0ywTAGEjbfEX97pZ/ptA1GSBq3u531LFWsdu9HeDgVmyg2zG4SxIEBfgiA5ycj6TMNEF4P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Nb2EYZvdS24vvz75q+1+L2M5O4dr9tkSBqnO1U42kJyw07mp
	5FFk/hhnSQ09cFP5IzbkNZs8ZorWiVayYJBSaaepz7zD3hzKDyojb9eQyW4huzs3zDRVbZFGr57
	xVklhV6AFteLe61BK6nwQjJ2r3GL0GJQGN6rc
X-Gm-Gg: ASbGncu+q8qp86HQ0sfwMsEoMCciDlLnxmc3j+GmJVwl4PAO7lygq1J8K177esyz5VV
	oqWcqLTP7ZKZYY8yLF3YdJU5kCPTGnevEUkivF7BC788R9/RN3/DVHC630hBK5pbk+0hhto406c
	DI2viSAd2oNR4Lw3r3Y1Oc0KoxFdDusMsari4vdrYB
X-Google-Smtp-Source: AGHT+IEE2Zd0YzlD1eKMXngbEqBUP4PcSWI2iH/mCQwG/4t9rw5I6pMzSFtNyw80iCn/K5sXKW6A8N4md+Tsh7pLQmA=
X-Received: by 2002:a05:6808:bcb:b0:3f4:ad6:519c with SMTP id
 5614622812f47-3f5584f047bmr344626b6e.2.1740704119270; Thu, 27 Feb 2025
 16:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
 <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com> <f65bd1bf-4e81-454a-afaa-f84c13cc6227@lucifer.local>
In-Reply-To: <f65bd1bf-4e81-454a-afaa-f84c13cc6227@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 16:55:06 -0800
X-Gm-Features: AQ5f1JrkAFHfI5uVGX9oxsAvwNBUue9qkGMdRly8ZF6iNxbuavzAsApzVHFK-rU
Message-ID: <CABi2SkV2_-LYGjROm3cs8nHrzBiw7pjpe0i7QGNPsPKHSeajog@mail.gmail.com>
Subject: Re: your mail
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrei Vagin <avagin@gmail.com>, Benjamin Berg <benjamin@sipsolutions.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, linux-mm@kvack.org, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	"hch@lst.de" <hch@lst.de>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"adobriyan@gmail.com" <adobriyan@gmail.com>, 
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Pedro Falcato <pedro.falcato@gmail.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, 
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	Peter Xu <peterx@redhat.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"gerg@kernel.org" <gerg@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	"ardb@kernel.org" <ardb@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, 
	"42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"ardb@google.com" <ardb@google.com>, Elliott Hughes <enh@google.com>, 
	"rientjes@google.com" <rientjes@google.com>, Guenter Roeck <groeck@chromium.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Tue, Feb 25, 2025, 9:43=E2=80=AFPM Lorenzo Stoakes
>
> > > 2. Tests - could you please add some tests to assert that mremap() fa=
ils
> > >    for VDSO for instance? You've edited an existing test for VDSO in =
x86 to
> > >    skip the test should this be enabled, but this is not the same as =
a self
> > >    test. And obviously doesn't cover arm64.
> > >
> > >    This should be relatively strightforward right? You already have c=
ode
> > >    for finding out whether VDSO is msealed, so just use that to see i=
f you
> > >    skip, then attempt mremap(), mmap() over etc. + assert it fails.
> > >
> > >    Ideally these tests would cover all the cases you've changed.
> > >
> > It is not as easy.
> >
> > The config is disabled by default. And I don't know a way to detect
> > KCONFIG  from selftest itself. Without this, I can't reasonably
> > determine the test result.
>
> Please in future let's try to get this kind of response at the point of t=
he
> request being made :) makes life much easier.
>
There might be miscommunication ?
This version is the first time you ask about adding a self test.

IIRC, you had comments about providing the details of what tests I did, in =
V4.
As a follow-up, I added a test-info section in the cover letter of V5

Though I have thought about adding a selftest since the beginning,
there are two problems:
1> This config is by default disabled,
2> No good pattern to check KCONFIG from selftest.

>
> So I think it is easy actually. As I say here (perhaps you missed it?) yo=
u
> literally already have code you added to the x86 test to prevent test
> failure.
>
> So you essentially look for [vdso] or whatever, then you look up to see i=
f
> it is sealed, ensure an mremap() fails.
>
This suggestion doesn't test the core change of this series, which is
to enable mseal for vdso.

When the vdso is marked with "sl", mremap() will fail, that's part of
the mseal() business logic and belongs in mseal_test. The mseal_test
already covers the mseal, and this series doesn't change mseal.

As for the "sl", as I responded in the "refactor mseal_test" [1] , it
will be part of the verifying step:

[1] https://lore.kernel.org/all/CABi2SkUv_1gsuGh86AON-xRLAggCvDqJMHxT17mGy-=
XutSTAwg@mail.gmail.com/

> Of course this doesn't check to see if it _should_ be enabled or not. I'm
> being nice by not _insisting_ we export a way for you to determine whethe=
r
> this config option is enabled or not for the sake of a test (since I don'=
t
> want to hold up this series).
>
> But that'd be nice! Maybe in a
> /sys/kernel/security endpoint...
>
>
> ...but I think we can potentially add this later on so we don't hold thin=
gs
> up here/add yet more to the series. I suspect you and Kees alike would
> prioritise getting _this series_ in at this point :)
>
> You could, if you wanted to, check to see if /proc/config.gz exists and
> zgrep it (only there if CONFIG_IKCONFIG_PROC is set) and assert based on
> that, but you know kinda hacky.

Ya, it is hacky. None of the existing selftest uses this pattern, and
I'm not sure /proc/config.gz is enabled in the default kernel config.

One option is to have ChromeOS or Android to maintain an out-of-tree
test, since the configuration will be enabled there.

Option two is to create a new path:
tools/testing/selftests/sealsysmap. Then, add
CONFIG_SEAL_SYSTEM_MAPPING=3Dy to the config file and add a selftest to
this path. This seems to be the preferred way by selftest, but we need
a new dir for that.

Option three is to add a self-test when we have a process-level opt-in
solution. This would allow the test to deterministically know whether
the vdso should be sealed or not.

>
> But anyway, FWIW I think it'd be useful to assert that mremap() or munmap=
()
> fails here for system mappings for the sake of it. I guess this is, in
> effect, only checking mseal-ing works right? But it at least asserts the
> existence of the thing, and that it behaves.
>
> Later on, when you add some way of observing that it's enabled or not, yo=
u
> can extend the test to check this.

I think it is best that we don't add a test that doesn't actually
check the code change. Do you think one of the above three options
works ? maybe the second option (with a new path) ?

In any case, I think the risk is low, and the code changes are quite
simple, and fully tested.

Thanks.
-Jeff.
