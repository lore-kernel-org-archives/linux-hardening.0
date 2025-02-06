Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F51A5BB4
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852753; cv=none; b=Ohz62cUVK64j9x4V3j0R4+fP7q0YUtDyE0Tmze9W5o+rPoRVDEM4uWqVHppCgiviu8750UiQaMJqyBaN+UREJ3gc9PAEj3n76YazclvoTy5lze2RaJZXH4tj1dJ6YmYK4Rwov0H+JK/NdzZNI+p4/hlwSwDcBuja7dAff7PTRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852753; c=relaxed/simple;
	bh=ln7CduGbwmeps6xewZjODTeTSRHoiy3XnCU1Nuqmqw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ql2d/uibfIYCmyCD9xZy6rJXL0TEiCKNA1cO7VKki5Oyf3B4usRVYMhDGv+tL2BNs4FT+K5i+bw6JyOVUVxkglut+nwMmggQQD6U9FUraQWXdIkYkQWeqi+rH0O6FSxubYpVfzjDQhzofJYSHTjfvD2TYTwu3c7Wwn5ConovKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzI/NAIu; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzI/NAIu"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb98ad8caaso625920b6e.0
        for <linux-hardening@vger.kernel.org>; Thu, 06 Feb 2025 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738852751; x=1739457551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln7CduGbwmeps6xewZjODTeTSRHoiy3XnCU1Nuqmqw0=;
        b=FzI/NAIuM0rPDoM2nV5bdKQ8FHGdzFf4KFYNUP9aDh+fnnuKg3J61hlq8BQliRo3oN
         v4l1/cEmFNeLBnvp9p1RJq7b8jnPdHnjOztNMTGD/9ryKM5VeesNgpjFiG06cVNiSSWe
         927NxhsqCObYgyg7jF0AqPf7BLvHcYrO1GcE/7ZD+hIddH4rv5P3PNqzcwDbplwHsg19
         CvCh9GEG/LYRhjkpGLj/OLx+RN4ByxvSXU1FQzsptVm20yTgjV80TfjU7+xui52NlNUI
         AOJH8WcBK5IyTuNjClwbPQnXbkCcK2f5eQs5KvpvsQG2h5S8jcI2gF8/TL8hhW0aXviv
         Kotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852751; x=1739457551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln7CduGbwmeps6xewZjODTeTSRHoiy3XnCU1Nuqmqw0=;
        b=MIsXtjuZQgZOprd1Ha8Khi7a2TnnFl9yGIgOckoR0fkLOlqV/4uFX/hSK73JFGs/xg
         lngVwBm7e1m+QK21OFwLZQhbBZXwXRjSvA1dpGQa0u7QZd3UC/yHoZ9HQZX4C1OkKbSf
         3XNnsVIi2sjMiVKoFh5pLxT0KlV2D5cejnC4S++2D9lfbT8MNeSXCY2V06Viay4eQkkv
         t+iTgEqpIaenaF4yi1+HcYcIYqcOh2l72HqRz3N5ukPKrv9/XM0Mx1GqMmr/kqq4mVwb
         mkqbWDtBig2447R1wMqx/LKi1mRsrOXodtaMwknWg4k4/9YO6UGGiFulUuIOfJrKjs8n
         vOag==
X-Forwarded-Encrypted: i=1; AJvYcCVRB2GJL7YsdztaHG759Od65nPjqPNn8nqsPs0zMEJn2fK/r6aVTUK3yD/mdxolS9VA66BYNAAlxHTYSgq2h0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKQPT0xYWuP0ViVVFzHXKV+Us9PScgBi6oKrtbuWaXzjtlZPO
	4xlv7w3bjXJj3XSk95Axy9mddAKbJ9IUxOD0TLXwba55I6XrO1WOprXBtmpqdMgXCjclixp6TUo
	pwKSjF4AOnxiTytF+W7pew0h4t+Sg0bDymsjR
X-Gm-Gg: ASbGncuoO7ApkwmypZvtWZJKSlc5U+gmRY7DYEi3eR5IRlGCxelgpJjpGYEgZp3hLb2
	aFpG/jzd7kBeLykRUH3j0d5CMEHYIWb8NtsBOMsnJDj2LmZKZsBhiO+0FjJSrbS1PUI6sIQ==
X-Google-Smtp-Source: AGHT+IEiPzusdtphZUreBnjsbY0+PMt66E5dhy1spQtF9N92lQKBk9LL4fqd8V6EFSCa0caZ8WuX8ysfWKJ9JRlntZ8=
X-Received: by 2002:a05:6870:eca9:b0:29e:630d:bab8 with SMTP id
 586e51a60fabf-2b804f903d3mr4612630fac.17.1738852750772; Thu, 06 Feb 2025
 06:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
 <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local> <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
 <7071878c-7857-4acd-ac27-f049cbc84de2@lucifer.local> <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com> <20250206135150-6c770e7d-9af8-4924-b760-82cff5092586@linutronix.de>
In-Reply-To: <20250206135150-6c770e7d-9af8-4924-b760-82cff5092586@linutronix.de>
From: enh <enh@google.com>
Date: Thu, 6 Feb 2025 09:38:59 -0500
X-Gm-Features: AWEUYZnz0jxlopnKdi7ztUNgOKau8bLEUw1_NjCXJu4QWfY5ioWB_j3DZMscb1w
Message-ID: <CAJgzZoq4UOYXaOh=mdUxsNUug9uYWzPX56AtUDL0RgKOx_VnQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:20=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Fri, Jan 17, 2025 at 02:35:18PM -0500, enh wrote:
> > On Fri, Jan 17, 2025 at 1:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
>
> <snip>
>
> > > There are technical difficulties to seal vdso/vvar from the glibc
> > > side. The dynamic linker lacks vdso/vvar mapping size information, an=
d
> > > architectural variations for vdso/vvar also means sealing from the
> > > kernel side is a simpler solution. Adhemerval has more details in cas=
e
> > > clarification is needed from the glibc side.
> >
> > as a maintainer of a different linux libc, i've long wanted a "tell me
> > everything there is to know about this vma" syscall rather than having
> > to parse /proc/maps...
> >
> > ...but in this special case, is the vdso/vvar size ever anything other
> > than "one page" in practice?
>
> x86 has two additional vvar pages for virtual clocks.
> (Since v6.13 even split into their own mapping)
> Loongarch has per-cpu vvar data which is larger than one page.
> The vdso mapping is however many pages the code ends up being compiled as=
,
> for example on my current x86_64 distro kernel it's two pages.
> In the near future, probably v6.14, vvars will be split over multiple
> pages in general [0].

/me checks the nearest arm64 phone ... yeah, vdso is still only one
page there but vvars is already more than one.

is there a TL;DR (or RTFM link) for why this is so big? a quick look
at the x86 suggests there should only be 640 bytes of various things
plus a handful of bytes for the rng, and while arm64 looks very
different, that looks like it's explicitly asking for a page (with the
vdso_data_store stuff)? (i've never had any reason to look at vvars
before, only vdso.)

> Figuring out the start and size from /proc/maps, or the new
> PROCMAP_QUERY ioctl, is not trivial, due to architectural variations.

(obviously it's unsatisfying as a general interface, but in practice
the VMAs i see asked about about directly -- rather than just rounded
up in a diagnostic dump -- are either stacks ["what are the bounds of
this stack, and does it have guard pages already?"] or code ["what
file was the code at this pc mapped in from?"]. so while the vdso
would come up, we'd never notice if vvars didn't work. if your sp/pc
point there, we were already just going to bail anyway :-) )

> Trying to construct the size from the ELF header is also problematic as
> that only contains information about the vdso code.
> The vvars are mapped before the code in memory independently.
>
> A dedicated interface like a prctl() would be actually reliable.
> Or theoretically a function from the vdso itself.
>
> <snip>
>
> [0] https://lore.kernel.org/lkml/20250204-vdso-store-rng-v3-0-13a4669dfc8=
c@linutronix.de/
