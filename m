Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69D1D07BF
	for <linux-hardening@vger.kernel.org>; Wed,  2 Oct 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882090; cv=none; b=DgQma2Q3ie0Or3X/Z1ldnx80S4O1dWLJlU8sVMHImwFsd1ZpoLh/j+oD/KQkwi5fJYCbg4I67Hz7/NklpkxD6rQiUueXXZfhclLmg9ZTGWV7Si1mfaHzFD8t8/gFnoaafH423dALCD+r3sixaLCnQXQS8zZvEhlRNl1JMwmuPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882090; c=relaxed/simple;
	bh=QUDhjg2BB1fAQvC+jY5ECEnUXOJHYoEWYS+9Oj9rdEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1/vaUwEZGaCn98VI4+WASOxuGuxVRCKE+fa7wmWRWlWYkQjjqFBg3nbWTljzri9PILedAeUYWGk7Eor9KhMTKViIKoGhYrzNj6R7FYuWfbh25XJ9JfB1pt61JffdzkGVCoiXPnCd5fRkhBwL3qRHRxJFPkLZxzDtUFJ6Q0pH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0GuXQjf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0GuXQjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727882087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vDfvl8sq0hjV+/ccjH8f99YPMDb9k3uRc8ixspRqpE=;
	b=D0GuXQjfdr7wy4w8djKv4qhu6D1Q1Im1M2FQI/cLfgDQL7xszH7GBLYu5fuqquXB6Y7WQK
	bZ+pXUtVB5rYjcwlvI1rVbP1M1DZkw6tXf49vNuA6P+z7MyaOjsbqUSx0QU8H0pJOonZfe
	pwDhUr3FZMHBDslS4H+3jWpVgsUxFQA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-HwGf6aG7O5i4uZNnziOF-w-1; Wed, 02 Oct 2024 11:14:46 -0400
X-MC-Unique: HwGf6aG7O5i4uZNnziOF-w-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7d904fe9731so6122236a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 02 Oct 2024 08:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882085; x=1728486885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vDfvl8sq0hjV+/ccjH8f99YPMDb9k3uRc8ixspRqpE=;
        b=L4sWDxO3udG9nrETRc3DNxOjzixCbyy1YVb7dCNGh8juDUr0+Lz+EfORVEvix58YF1
         3zLyZiOBokO/Os++Tg+wQPdw5/IS4CAA5MCi2n62b0yn+Pra+u42P8pn5GazgJUXRaQ0
         5c2PVoyTfZ6inzQP6lhwvR/vqNhmeb6YVKfw1m3hu+0SvWTdgIS3xg+P74CtyDcvYdXY
         EqsyXxVzbslr57X99JNyBLwkhlnhMFjKBij9EaR7nA11oofq1Qeb2y2jIQPmYw0zyhFu
         PJbUiuEhgLhVkNjwJM1BMLg7RztxF76WoSt9ZHDzBnxAAi6csc1IDXI4xf3i53JC6cV5
         og2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkyMlqpBbAF6dC+KM2+eovlZiciq2eOPV6emsJBVrPiXMVxFlrzLyUbTbcf31y+C8lBHAQI3EfTjY7C8xwBhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBFx7Utwu17nHd24mt9aMHbuiOTSBquLk1E1YfFqQLGr6B730
	1DFkxlOhq9YOwg8lNOKy5f78eWV8Po90QOx+scTLe+RzHQy1ln0sdNJAQdjvqfhGCdyYv0MQ7Cf
	We+geCc45/2ELlU1SOOK8625Hzc7wXP8Va/EYpKloFFhsXcNDG9ktHeEO9lmR6siYXO+VlGC1Zk
	S/8gnIA6CzJvY8BhzcvWoTDZJ0rVrQuTVd1RGbj9n1av6hhfkU2+E=
X-Received: by 2002:a17:90a:8f03:b0:2d3:d68e:e8d8 with SMTP id 98e67ed59e1d1-2e1849e48bemr3374003a91.40.1727882085321;
        Wed, 02 Oct 2024 08:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFi58lvd+1ylmMny4MXsv0GeGbXQggxrNrlp5663034F31N80QJIO125EWfMpu9MJQevIIP3BmA1iyUJmzsLA=
X-Received: by 2002:a17:90a:8f03:b0:2d3:d68e:e8d8 with SMTP id
 98e67ed59e1d1-2e1849e48bemr3373981a91.40.1727882084868; Wed, 02 Oct 2024
 08:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
 <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org> <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
 <202409221511.9AF49BD@keescook> <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
 <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org> <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
 <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
In-Reply-To: <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
From: Jason Montleon <jmontleo@redhat.com>
Date: Wed, 2 Oct 2024 11:14:33 -0400
Message-ID: <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-riscv@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:53=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Jason,
>
> On 25/09/2024 16:32, Jason Montleon wrote:
> > On Tue, Sep 24, 2024 at 1:36=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> >>
> >>
> >> On September 24, 2024 8:58:57 AM PDT, Jason Montleon <jmontleo@redhat.=
com> wrote:
> >>> On Sun, Sep 22, 2024 at 6:38=E2=80=AFPM Kees Cook <kees@kernel.org> w=
rote:
> >>>> Can you try this patch? It should avoid using the "WARN" infrastruct=
ure
> >>>> (if that is the source of blocking boot), but should still provide s=
ome
> >>>> detail about what tripped it up (via the "regular" pr_*() logging). =
And
> >>>> if it boots, can you look at the log to find what it reports for the
> >>>> "Wanted to write ..." line(s)?
> >>>>
> >>>> Thanks!
> >>>>
> >>>> -Kees
> >>>>
> >>>>
> >>>> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-=
string.h
> >>>> index 0d99bf11d260..469a3439959d 100644
> >>>> --- a/include/linux/fortify-string.h
> >>>> +++ b/include/linux/fortify-string.h
> >>>> @@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kerne=
l_size_t size,
> >>>>                                           const size_t q_size,
> >>>>                                           const size_t p_size_field,
> >>>>                                           const size_t q_size_field,
> >>>> -                                        const u8 func)
> >>>> +                                        const u8 func,
> >>>> +                                        const char *field)
> >>>>   {
> >>>>          if (__builtin_constant_p(size)) {
> >>>>                  /*
> >>>> @@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kern=
el_size_t size,
> >>>>           * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101832
> >>>>           */
> >>>>          if (p_size_field !=3D SIZE_MAX &&
> >>>> -           p_size !=3D p_size_field && p_size_field < size)
> >>>> -               return true;
> >>>> +           p_size !=3D p_size_field && p_size_field < size) {
> >>>> +               if (p_size_field =3D=3D 0)
> >>>> +                       pr_warn("Wanted to write %zu to a 0-sized de=
stination: %s\n",
> >>>> +                               size, field);
> >>>> +               else
> >>>> +                       return true;
> >>>> +       }
> >>>>
> >>>>          return false;
> >>>>   }
> >>>> @@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kerne=
l_size_t size,
> >>>>          const size_t __q_size_field =3D (q_size_field);            =
       \
> >>>>          fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_si=
ze,  \
> >>>>                                       __q_size, __p_size_field,     =
     \
> >>>> -                                    __q_size_field, FORTIFY_FUNC_ #=
#op), \
> >>>> +                                    __q_size_field, FORTIFY_FUNC_ #=
#op,\
> >>>> +                                    #p " at " FILE_LINE), \
> >>>>                    #op ": detected field-spanning write (size %zu) o=
f single %s (size %zu)\n", \
> >>>>                    __fortify_size,                                  =
     \
> >>>>                    "field \"" #p "\" at " FILE_LINE,                =
     \
> >>>>
> >>>>
> >>>> --
> >>>> Kees Cook
> >>>>
> >>> Hi Kees,
> >>> Sorry for the delay in responding. Your patch also caused the system
> >>> to hang booting, but I took it as inspiration to try some things.
> >>> TL;DR I see these two print several times:
> >>>
> >>> Wanted to write 8 to a 0-sized destination: oldptr at
> >>> arch/riscv/errata/thead/errata.c:185
> >>> Wanted to write 28 to a 0-sized destination: oldptr at
> >>> arch/riscv/errata/thead/errata.c:185
> >>>
> >>> Since I suspected CONFIG_ERRATA_THEAD_MAE which relies on
> >>> CONFIG_RISCV_ALTERNATIVE_EARLY I suspected it is just too early for
> >>> pr_*, etc. I tried trace_printk but that didn't produce any traces,
> >>> and then I found a comment which makes me think we're too early for
> >>> that too.
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/riscv/kernel/alternative.c?h=3Dv6.11#n214
> >>>
> >>> I didn't want to give up so I wrote a simple module to figure out how
> >>> to use sbi_ecall and then incorporated that idea into your patch,
> >>> although even that was not straightforward:
> >>> https://gist.github.com/jmontleon/f3536ad70dc92bed992139ad5b266d5c
> >> Oh nice work! Probably something riscv-specific needs to be wired up t=
o the printk routines to do what you have there until printk is fully avail=
able  But that's a separate issue, I guess.
> >>
> >>> Full output: https://gist.github.com/jmontleon/823facff38e28b717f153e=
38adcfd7fe
> >> Does the system boot with your patch?
> > Yes. It boots fully. It also booted with trace_printk, it just didn't
> > produce a trace, which again I think is expected at that stage. It
> > seems as long as there are no 'normal' print attempts, pr_()*, etc. it
> > works.
>
>
> Hmmm I don't see what in your patch would fix your issue.
>
> I sent a patch
> (https://lore.kernel.org/linux-riscv/20240829165048.49756-1-alexghiti@riv=
osinc.com/)
> that was merged in v6.11-rc7 which fixes something similar, could that
> be what fixed your problem?
>

Hi Alex, Thank you for having a look.

Although I narrowed it down to starting with 6.11-rc1, the first time
I encountered this was actually with an rc7 Fedora build.
http://riscv.rocks/koji/buildinfo?buildID=3D338433

I also did a build from upstream 6.11.1 last night and still see the
problem trying to boot with it this morning.

> The problem with this early code is that the MMU is not enabled yet and
> if your kernel is relocatable, the relocations are set "virtually" and
> then without the MMU, a call to an external function results in a
> trap...Which happens way too often, I have a few ideas to fix that, I
> need to find time to tackle this though.
>
> I don't know FORTIFY_SOURCE, but I guess this could cause a call to an
> external function and then cause the issue I describe above right? We
> already remove all instrumentations from this early code so maybe we
> should remove FORTIFY_SOURCE too?
>
What you are describing here does not seem unreasonable to me, but I
simply do not know enough to say one way or the other.
Is there something I can do to collect more information to determine
if this is the cause?

Thank you again for having a look,
Jason

> Thanks for digging into this,
>
> Alex
>
>
> >
> >> I would guess that this line at arch/riscv/errata/thead/errata.c:168:
> >>
> >> void *oldptr, *altptr;
> >>
> >> Should be:
> >>
> >> u8 *oldptr, *altptr;
> > I tried this, but it didn't appear to make a difference, I will try
> > some more today, though I admit to being out of my element.
> >
> >
> >
> >> But maybe __ALT_PTR needs adjustment too? Hmm. I would have expected v=
oid * to have a size of SIZE_MAX here, though, so something else might be c=
onfusing the check.
> >>
> >>
> >> --
> >> Kees Cook
> >>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

