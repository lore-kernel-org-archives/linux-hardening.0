Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66111A4E88
	for <linux-hardening@vger.kernel.org>; Thu,  3 Oct 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975601; cv=none; b=XT+QQYmIbwTDAUAMJUE7Rrvz+mgjTvM2Q2NeaFe9iMyRb6PouZ+0JIZMcYx11gjL8Q8/WoZlIDNuspj2I6M9nfybRXHsMCmcxAu6L/Q2Fqde+oEyeP9RW+4VevLhNokostecJav8njt3bg6uoVu6TwB0P10Bh2NAdS+3FOXw62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975601; c=relaxed/simple;
	bh=aUPtaJNEKDwYCa0c+acC7FfD6B91bzgvhtxp/+v5/rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gW/J03Y5AdcFXg4iff2OW6zMMpftKmcYJ1a/BoSj3XUKWAFZmpkHXWBJvoov6ws4MaRjz2NioQ8yso4T/qKmRwESuv2OQr5j854ATbbQONCE6dazjgXfN3YURF4ugtkLofAcwIct6QH374ZtoEqyG0z6xj5Ymis0QEoWwkUPQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLxh0mJo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLxh0mJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727975598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+BZEqZ0bhpJ/TwtbVPrMlqgWs0a/FkEz2+Vhn0aniQ=;
	b=ZLxh0mJoZjPoe73J07uXmYDirmKzUijXbhDa9OiyWlmhRFJVRm99EOp5mV4mLhFAqMU4+g
	cb5jZ0GzR4JNsNUyCM8Z3FPjo7Lzb93azczMGMnV3tf/dshEOH44GdsbXEuhbb0vJv454c
	FKmrD4H66GgpkilYlu6KCo4qzwGG1SU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-2Fu9pY62MyafH-wyw1rRiQ-1; Thu, 03 Oct 2024 13:13:12 -0400
X-MC-Unique: 2Fu9pY62MyafH-wyw1rRiQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e0aceab142so1292161a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 03 Oct 2024 10:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975591; x=1728580391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+BZEqZ0bhpJ/TwtbVPrMlqgWs0a/FkEz2+Vhn0aniQ=;
        b=q8lFdyiU35lfD0oP4CrhllIiuPIIBXZTNg0vrQuzrCCI+3tJsl7Gt9gRdQcVBZm/Ct
         QPxHQLgPg7CX+XYmxVoamLUddf/15DIbKv0oBTJu0ePgZDhGGK3UrEo4dZfb2NnQm2dB
         JoKAMGi3EwyUcU96085ttH6X8RkzJ6VlkgNfN9SIoBS2vDv0/aRkmB6U6kM5oDtlB1cL
         Ce/JqDTN1AdFubGw5mDgrJ7LzX+8hN+5AnJdnotMYbrkH0G7eJIc9FlRjglL2njQVMka
         wyTtyF18JMn8YH5pYRnAkU0F3ErSI+fSzY5vS52O+3AERqGHXxsumCLzIUxsfL+BxhgP
         +nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpvPpohaXiIGWwEw/HwbHvgOKeUKMrjB7pojeMpeU+iZrGDT9GjZqauYo4q0lftOxyGYNtdRoIDOGKXMuK0fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCYYWhT3a9ekI9D5cWcgjq5pCXBFlXAIQbYwFRUeMRhH+iPJS
	qt9Aeh9uE0iLmFodJR2puR1ZOGQax4XamSJ9uCh5hZKGpC7NL0GOs4w852ehtKlJWn+ZpAMQgc0
	3K4oiDQyu6uu8zJPWYLAzJNGIUktGV1gYCKQkD2v3ynrnoXG7s7u60qoAd26bzpC5KSXjvfWmrw
	d5BizfnZ2Kw+nYfPpfztfup8/ARVKQf84twYWF0/Nt
X-Received: by 2002:a17:90a:be05:b0:2e0:b02e:d1de with SMTP id 98e67ed59e1d1-2e18466e057mr9145982a91.13.1727975591406;
        Thu, 03 Oct 2024 10:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxC2ihQr/G1IaLcVXCpZ9w8Xl2vfhFIL4G+/rRInMMEe6GLnmvvV338qpOU0t3Jdmwj+4amGz582ZvMKwZq/E=
X-Received: by 2002:a17:90a:be05:b0:2e0:b02e:d1de with SMTP id
 98e67ed59e1d1-2e18466e057mr9145946a91.13.1727975590949; Thu, 03 Oct 2024
 10:13:10 -0700 (PDT)
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
 <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr> <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
 <f9d17698-0c74-42b7-acc8-3ca3adf3ba4d@ghiti.fr>
In-Reply-To: <f9d17698-0c74-42b7-acc8-3ca3adf3ba4d@ghiti.fr>
From: Jason Montleon <jmontleo@redhat.com>
Date: Thu, 3 Oct 2024 13:12:59 -0400
Message-ID: <CAJD_bP+ZYKFaeZ2hQXjAZda=RhLkfnXfGLW-ZYTrOV4GfNRzpA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-riscv@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:41=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Jason,
>
> On 02/10/2024 17:14, Jason Montleon wrote:
> > On Tue, Oct 1, 2024 at 10:53=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> >> Hi Jason,
> >>
> >> On 25/09/2024 16:32, Jason Montleon wrote:
> >>> On Tue, Sep 24, 2024 at 1:36=E2=80=AFPM Kees Cook <kees@kernel.org> w=
rote:
> >>>>
> >>>> On September 24, 2024 8:58:57 AM PDT, Jason Montleon <jmontleo@redha=
t.com> wrote:
> >>>>> On Sun, Sep 22, 2024 at 6:38=E2=80=AFPM Kees Cook <kees@kernel.org>=
 wrote:
> >>>>>> Can you try this patch? It should avoid using the "WARN" infrastru=
cture
> >>>>>> (if that is the source of blocking boot), but should still provide=
 some
> >>>>>> detail about what tripped it up (via the "regular" pr_*() logging)=
. And
> >>>>>> if it boots, can you look at the log to find what it reports for t=
he
> >>>>>> "Wanted to write ..." line(s)?
> >>>>>>
> >>>>>> Thanks!
> >>>>>>
> >>>>>> -Kees
> >>>>>>
> >>>>>>
> >>>>>> diff --git a/include/linux/fortify-string.h b/include/linux/fortif=
y-string.h
> >>>>>> index 0d99bf11d260..469a3439959d 100644
> >>>>>> --- a/include/linux/fortify-string.h
> >>>>>> +++ b/include/linux/fortify-string.h
> >>>>>> @@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__ker=
nel_size_t size,
> >>>>>>                                            const size_t q_size,
> >>>>>>                                            const size_t p_size_fie=
ld,
> >>>>>>                                            const size_t q_size_fie=
ld,
> >>>>>> -                                        const u8 func)
> >>>>>> +                                        const u8 func,
> >>>>>> +                                        const char *field)
> >>>>>>    {
> >>>>>>           if (__builtin_constant_p(size)) {
> >>>>>>                   /*
> >>>>>> @@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__ke=
rnel_size_t size,
> >>>>>>            * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101832
> >>>>>>            */
> >>>>>>           if (p_size_field !=3D SIZE_MAX &&
> >>>>>> -           p_size !=3D p_size_field && p_size_field < size)
> >>>>>> -               return true;
> >>>>>> +           p_size !=3D p_size_field && p_size_field < size) {
> >>>>>> +               if (p_size_field =3D=3D 0)
> >>>>>> +                       pr_warn("Wanted to write %zu to a 0-sized =
destination: %s\n",
> >>>>>> +                               size, field);
> >>>>>> +               else
> >>>>>> +                       return true;
> >>>>>> +       }
> >>>>>>
> >>>>>>           return false;
> >>>>>>    }
> >>>>>> @@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__ker=
nel_size_t size,
> >>>>>>           const size_t __q_size_field =3D (q_size_field);         =
          \
> >>>>>>           fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p=
_size,  \
> >>>>>>                                        __q_size, __p_size_field,  =
        \
> >>>>>> -                                    __q_size_field, FORTIFY_FUNC_=
 ##op), \
> >>>>>> +                                    __q_size_field, FORTIFY_FUNC_=
 ##op,\
> >>>>>> +                                    #p " at " FILE_LINE), \
> >>>>>>                     #op ": detected field-spanning write (size %zu=
) of single %s (size %zu)\n", \
> >>>>>>                     __fortify_size,                               =
        \
> >>>>>>                     "field \"" #p "\" at " FILE_LINE,             =
        \
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Kees Cook
> >>>>>>
> >>>>> Hi Kees,
> >>>>> Sorry for the delay in responding. Your patch also caused the syste=
m
> >>>>> to hang booting, but I took it as inspiration to try some things.
> >>>>> TL;DR I see these two print several times:
> >>>>>
> >>>>> Wanted to write 8 to a 0-sized destination: oldptr at
> >>>>> arch/riscv/errata/thead/errata.c:185
> >>>>> Wanted to write 28 to a 0-sized destination: oldptr at
> >>>>> arch/riscv/errata/thead/errata.c:185
> >>>>>
> >>>>> Since I suspected CONFIG_ERRATA_THEAD_MAE which relies on
> >>>>> CONFIG_RISCV_ALTERNATIVE_EARLY I suspected it is just too early for
> >>>>> pr_*, etc. I tried trace_printk but that didn't produce any traces,
> >>>>> and then I found a comment which makes me think we're too early for
> >>>>> that too.
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/arch/riscv/kernel/alternative.c?h=3Dv6.11#n214
> >>>>>
> >>>>> I didn't want to give up so I wrote a simple module to figure out h=
ow
> >>>>> to use sbi_ecall and then incorporated that idea into your patch,
> >>>>> although even that was not straightforward:
> >>>>> https://gist.github.com/jmontleon/f3536ad70dc92bed992139ad5b266d5c
> >>>> Oh nice work! Probably something riscv-specific needs to be wired up=
 to the printk routines to do what you have there until printk is fully ava=
ilable  But that's a separate issue, I guess.
> >>>>
> >>>>> Full output: https://gist.github.com/jmontleon/823facff38e28b717f15=
3e38adcfd7fe
> >>>> Does the system boot with your patch?
> >>> Yes. It boots fully. It also booted with trace_printk, it just didn't
> >>> produce a trace, which again I think is expected at that stage. It
> >>> seems as long as there are no 'normal' print attempts, pr_()*, etc. i=
t
> >>> works.
> >>
> >> Hmmm I don't see what in your patch would fix your issue.
> >>
> >> I sent a patch
> >> (https://lore.kernel.org/linux-riscv/20240829165048.49756-1-alexghiti@=
rivosinc.com/)
> >> that was merged in v6.11-rc7 which fixes something similar, could that
> >> be what fixed your problem?
> >>
> > Hi Alex, Thank you for having a look.
> >
> > Although I narrowed it down to starting with 6.11-rc1, the first time
> > I encountered this was actually with an rc7 Fedora build.
> > http://riscv.rocks/koji/buildinfo?buildID=3D338433
> >
> > I also did a build from upstream 6.11.1 last night and still see the
> > problem trying to boot with it this morning.
> >
> >> The problem with this early code is that the MMU is not enabled yet an=
d
> >> if your kernel is relocatable, the relocations are set "virtually" and
> >> then without the MMU, a call to an external function results in a
> >> trap...Which happens way too often, I have a few ideas to fix that, I
> >> need to find time to tackle this though.
> >>
> >> I don't know FORTIFY_SOURCE, but I guess this could cause a call to an
> >> external function and then cause the issue I describe above right? We
> >> already remove all instrumentations from this early code so maybe we
> >> should remove FORTIFY_SOURCE too?
>
>
> So I was able to reproduce the issue on qemu by adding a few tweaks, and
> indeed we trap in __warn_printk() on a virtual address but MMU is not
> enabled yet.
>
> The following diff though allows me to pass this failure but I can't get
> much further in the boot since the tweaks I added won't allow it, can
> you give the following a try?
>
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index 8a27394851233..4913f3b3f198c 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -2,6 +2,10 @@ ifdef CONFIG_RELOCATABLE
>   KBUILD_CFLAGS +=3D -fno-pie
>   endif
>
> +ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
> +KBUILD_CFLAGS +=3D -D__NO_FORTIFY
> +endif
> +
>   obj-$(CONFIG_ERRATA_ANDES) +=3D andes/
>   obj-$(CONFIG_ERRATA_SIFIVE) +=3D sifive/
>   obj-$(CONFIG_ERRATA_THEAD) +=3D thead/

Yes, this worked.

Thank you,
Jason

> Thanks,
>
> Alex
>
>
> >>
> > What you are describing here does not seem unreasonable to me, but I
> > simply do not know enough to say one way or the other.
> > Is there something I can do to collect more information to determine
> > if this is the cause?
> >
> > Thank you again for having a look,
> > Jason
> >
> >> Thanks for digging into this,
> >>
> >> Alex
> >>
> >>
> >>>> I would guess that this line at arch/riscv/errata/thead/errata.c:168=
:
> >>>>
> >>>> void *oldptr, *altptr;
> >>>>
> >>>> Should be:
> >>>>
> >>>> u8 *oldptr, *altptr;
> >>> I tried this, but it didn't appear to make a difference, I will try
> >>> some more today, though I admit to being out of my element.
> >>>
> >>>
> >>>
> >>>> But maybe __ALT_PTR needs adjustment too? Hmm. I would have expected=
 void * to have a size of SIZE_MAX here, though, so something else might be=
 confusing the check.
> >>>>
> >>>>
> >>>> --
> >>>> Kees Cook
> >>>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

