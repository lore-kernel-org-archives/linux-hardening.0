Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312020E307
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501874; cv=none; b=MdzVx/oQXVzFsZ59BqUyBZvY9e5vR++b/OxIgQnx387zel/4Q4z6mT53/nclRZ4IC7LAz5PPplrh9621owXXYWE6dG3GCm9lA+XW3AMC2m6jn+PfLyfr0m5d7ZjsJUkUndUa1o1W6ccAMNPPa0tmx7C5MbPkP4T69GcsVrRhhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501874; c=relaxed/simple;
	bh=e3BpOzvQSXPwHE2thKuh8Tl5jqUuAPK9fRZ9MgRnjQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzFy+RYz/+pwsJSi1a4k2cAR1S5Be0hv+Diaw0OntuA8b/QpqUKGwGzWX0HOmv9qTkBLsj1mvAkSZk1oSlVld7KcG/pAl8OQ3y0eqRZooV048HEpjfrb+sHNtJ/cls0WyQmzueIook/ezC5wu9SApw0JQaJk+x5eylGTrPprTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ifG1aZYp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifG1aZYp"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d4bb568b6so296069a34.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733501872; x=1734106672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYNgFZy/4/b6RmhVrXOEIxOyzv8j9mBXffJS69QvJeY=;
        b=ifG1aZYpPk+MWWCYmZht4+g0CicuBCuyfgegfiVnMtry3AFYwq7U+CJx1cTwGiHm5a
         SmI6ZMbA+z3BVZomTkQSSuamRnHQ06X7yDMcLGNeYtDaQuRzBqwOPD6pH4bsrPJMJSKH
         fIorH20sVepB2p6+xKsqAgxatPnsqAYASIyCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501872; x=1734106672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYNgFZy/4/b6RmhVrXOEIxOyzv8j9mBXffJS69QvJeY=;
        b=Vm621t1oilBrXWLBWbKGm1j5nK15LABpDnEKfub65LEGJ9hP20Lm2WeU8KOZwkR10Z
         oIIK1AS94pgmj065MbxHNsp+d6PBesLFBkw2GU8u435i3BBZxcZkVTNNPhP3Lo2fyxtb
         sQ0JoxPqaPnBQxGefFJwBHU/zlxcRSHnuBAiPPzz5Mi9CgPFnTqwIs9thI94OMu7Nblm
         lej8rD3yqUDCZHpIVwZySxBJWGiXweKWLsOI3xK4P1DIoo7q1APM3Jef8mPuhhKt8b2+
         L7Ea5KbX8jsRLu+36FYqMRg0YR7u+SmWjL5Zff9KJkqVYOjixQnnDcnNzwf+nvcHJccm
         z50A==
X-Forwarded-Encrypted: i=1; AJvYcCXSpSZ2feqV+yvoZALSm/9T7TRz3tYjE6rzA7TywrkxcZMJ5N5MNFddTbKLfzZat3YUz78Eowf5ZDcUQcYCN34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNfds2ux8K6vuUwnLMtoSNVbYT93rLtiJPA34oj1K7f6VhLIF
	ufpEMJgHDF3k6PHogtRrfOhzAnXPH6GSPoq78tEW//0h3Dqq8ywu1LiBJmwY2Wb9ajeAlM/5WEi
	CTXi3SWwygX7+ymtjFKIUJ8nIRw3KTo/ntvJD
X-Gm-Gg: ASbGncs/C9p47X+Z4GQ/HF3qw/OA0m1q61RoQEjB1D80XI8AcxqncHTV6goHC3OiXNq
	QIFqZANt6LfitQGmZXxLgLHWH2+F3m5eBKZSN8Cf5iDlF49YJvnvC/CYkNnAHppr6
X-Google-Smtp-Source: AGHT+IHRb8erTdDUQTrHJbU0fhtYuKrytZ0PMTCzeH2gffX33C2JMd95VcEBOKpmWKnjXeUJ/vtlcF6fm2BIbgdb3Fs=
X-Received: by 2002:a05:6830:d0b:b0:71a:20da:f85f with SMTP id
 46e09a7af769-71dcf5c2a07mr815871a34.7.1733501872216; Fri, 06 Dec 2024
 08:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013934.2782793-1-jeffxu@google.com> <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
 <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
In-Reply-To: <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 08:17:40 -0800
Message-ID: <CABi2SkWkUmBdsUYhr-cE181oh=medLG0iXgHk6TYEuPgztxqOw@mail.gmail.com>
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:13=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Dec 05, 2024 at 11:25:43PM -0500, Liam R. Howlett wrote:
> > * jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > No code logic change.
> > >
> > > can_do_mseal is called exclusively by mseal.c,
> > > and mseal.c is compiled only when CONFIG_64BIT flag is
> > > set in makefile. Therefore, it is unnecessary to have
> > > 32 bit stub function in the header file.
> >
> > There is no reason to keep this function at all; it is used in one
> > place, and that place uses three lines of code as well.
> >
> > In fact, having it separate from the comment about flags being reserved
> > makes the function very puzzling.
>
> I entirely agree. Jeff - please just make this inline to do_mseal():
>
Sure.

>         ...
>
>         /* Flags are reserved. */
>         if (flags)
>                 retrun -EINVAL;
>
>         ...
>
> If you do that then cool I'm happy for this patch to be taken.
>
> An aside - I actually think we need to move the bulk of this code to
> mm/vma.c - it makes absolutely no sense to keep the internals in this fil=
e,
> and that way we can userland test mseal functionality.
>
Is there a past discussion to read ? That will help me understand your
strategy of unit testing mm code.
Moving everything to vma.c, will lose log history, e.g. blame no
longer helps, did we consider alternatives ?


> I may submit a patch to this effect at some point.
>
> Thanks, Lorenzo
>
> >
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  mm/internal.h | 16 ----------------
> > >  mm/mseal.c    |  8 ++++++++
> > >  2 files changed, 8 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 74dc1c48fa31..5e4ef5ce9c0a 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page =
*page, unsigned long pfn,
> > >  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup=
 *memcg,
> > >                       int priority);
> > >
> > > -#ifdef CONFIG_64BIT
> > > -static inline int can_do_mseal(unsigned long flags)
> > > -{
> > > -   if (flags)
> > > -           return -EINVAL;
> > > -
> > > -   return 0;
> > > -}
> > > -
> > > -#else
> > > -static inline int can_do_mseal(unsigned long flags)
> > > -{
> > > -   return -EPERM;
> > > -}
> > > -#endif
> > > -
> > >  #ifdef CONFIG_SHRINKER_DEBUG
> > >  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> > >                     struct shrinker *shrinker, const char *fmt, va_li=
st ap)
> > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > index 81d6e980e8a9..e167220a0bf0 100644
> > > --- a/mm/mseal.c
> > > +++ b/mm/mseal.c
> > > @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, un=
signed long end)
> > >     return 0;
> > >  }
> > >
> > > +static inline int can_do_mseal(unsigned long flags)
>
> It makes no sense for this to be inline.
>
> > > +{
> > > +   if (flags)
> > > +           return -EINVAL;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  /*
> > >   * mseal(2) seals the VM's meta data from
> > >   * selected syscalls.
> > > --
> > > 2.47.0.338.g60cca15819-goog
> > >
