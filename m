Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46F3B774B
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492133; cv=pass; b=pWThhruG3qTwAY79d/GEw4kD7ggxXRjgTvHpe1KHcnoPhVyzYAcoQOM9ZqDnwWMBLRNwSL0cMB+SwaXPks//YqlmAGXIpCdijc4cZFka2Z7RpBQGmk+Ol5qMEhxlKhkCGFc6tMhYTnaQ+LXV5qAU08iqL5Op/wWM0VL9fPsRyhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492133; c=relaxed/simple;
	bh=NRMFgXt/+8/VoEquamZsaZxYeYlqHmrVJp607sf0pRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+YIldNaOD5UNrYheN9Q8Ubn18BDPar9z7BF3ALCh4A/W1Be25D9ogzX6hgzO+30FYwyW/JH2voVn7QufRzvmMmlUR9rTMGjKCSSZtbsO6n+1aUOgvDW5b69rdRg57YBUDbs7uoC/Hl+biQev+hklXLB8TnHsGzvy5Ueh5fwyzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITVxMv3h; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITVxMv3h"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1332772f6b3so176957c88.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 02:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778492131; cv=none;
        d=google.com; s=arc-20240605;
        b=MbD8W0qs/mUtNC5/slP4r5H7loJxsEXWLNB4gOabNVn3zcA+Jv/atptTQczbxMQU2B
         UcwXbB+P3TUpoj93JtpXZDtd1+bx59XqSdrYNK+GGiqWH+G9iq7lW0DoFvAQ/OHFD6lH
         Wd5draWBGlk1Msk4RfgOereUPuHo/HMCwZzt5pL+0XDNom3nm0489jU0M7kdEzKIffCe
         PO9ZmGW5TLkfD/llK9YcLmndD8YuDfYPQaAZbBdVRRhcSTc/+LHeIAGU+TWt+/rWfkCN
         ZFeFuUJxqUnyflwzHCPdpaWcZLgQzY4Ds2nJxRmP7YL/+cNS8qJwZilhi/bRFr18wsB3
         j7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WufxmpQiwhOpJBofeZI+ZtjHioGWCbMxkve0DPKIOFk=;
        fh=xQZSDtgLuRvz9K0XcbxNTkqL02zGcb4SK+px+Qc40os=;
        b=VfV+K38uA+heMskkuTKkV9CBBIa/3pkLO3X5Rgm43s+e1muVqrtCiemlRMLUey00ts
         31ZGlnk4y2lnZZUrTFO+6y5iZrXY+Nsk1Jl5GS8Nu7TtkTpojymRrFlJ3vULUasA0B6f
         T125WWDJWjVAkopnQAXPGwDgh2Yi3iOLxOw1dajEk+c/fnP0wXTzQnr16E0nTfH4/A7r
         QqEgsvrYmp1RoOccmf9Is6L+2Km2tqsOd979HNex5FnZRrAaeemVpNBjKqD3N3GacycH
         qLpZcw/MuTzf8YJwg7P71BWf16J59FWUwoFhJn0zX2W9AMmZ4SSGoE46AH4mBXmOwGfu
         2BwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778492131; x=1779096931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WufxmpQiwhOpJBofeZI+ZtjHioGWCbMxkve0DPKIOFk=;
        b=ITVxMv3hFSAZRSttPQoavQwmAHtsm5g3UKh0QsvJuUNcKzTefrB8UBmodd4CAP9e5A
         tD+Ru8FKuEo0sE82QGmQq6nEpVruQNIZo4xMc1TX96SEzEfbdmezUAvuSqSWZMICQv/B
         eRQ3DBT8QNtVwppwGxuygm5M9pV2VR/Myfk8b7K0BpkhI9qUAF1wkT3fPN4yJTgD0zkG
         MI4ieywI8nGj0LlofybfDUPLtELCJKEDFtFSdNzxIR8Onm1/pzz5rC+gxa/reC4JR5QU
         Ue5w7tGyzNtEAe8qPVmMJtHS5HtOR9A8dMeDMZUnKLtsIgxMkoE2/VKF4pyaZHnLLB0f
         ygmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492131; x=1779096931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WufxmpQiwhOpJBofeZI+ZtjHioGWCbMxkve0DPKIOFk=;
        b=PrrP8X5515HP5VlPww/5PO2PoUGLwefIs1ViMeFKapMAy/+tT27Tr+HSR5waYRmZmT
         Tp+RNR7xETxCzR1mN6u4l1EY+9Xv1eREEvhYL6KU4OltNlE8L64kZQ5cMFGFFKV/LDYU
         qvUt1BAay+n78ONbxZ3g2FFU14TfI5MYoROyJV59APCjNfsxFPnXEVO+7xot/5lTRiIZ
         uHBuPLxnynmuzrf6uDlJ2BAzQbDJ6maascnEsyhUVfUrG4x3XAqVir2Fhy1/TD7oX1Gv
         qerAmD+xmyCqDzyU/K6i75Fko+HQ/E9kym6ar6zyqezDLBKwo2NZ/coorAsj+IqwezcN
         +/OQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HtUTWlgQrqvmYfKOZqR9DnxZeA5JmvZ9Y2l3uKtsmGhCu30hxmR+bbWGQA59q8jc0FKnpqWD75FJXPX+ohNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweyFEJCOBtUTsbDidrKEB9Fp6c06JSjElQJAYtTrFq79jFS5Ut
	MXVIKjXiBlMS9NrRtyUgkcBClOiujIEMSfoeoGYuAMv97PzM07IVQ2tNzLVRyNTGBd0HnqmLRex
	1BWB+lQkJOnJb3lUwwAhEtYbDmxAMp4sq2AoGjqQ8
X-Gm-Gg: Acq92OFs6tB3EJgy1qs6oCTGonMtwKjjNeP1zWn/cRyKL4Jrf8yAwvrsHyvxLs/788b
	8vCLMg/zlfcBb0SXQFvE89UQcNseY3AWpYOIKvA5BNfcjt0PNH8MHAQQ/jjJMJr+9jj3h1QeHsS
	xMWLRoeGGsEbNhknUeM1H5xZXROahNMupZWcmWBUGqzRbKxaSrT+dmQnvkXWXrSAWq1ZzqK7ZUW
	mpqCRjZk3qzEdLRi9UfT2wn6fwboHpXEi6SAdoGrL7WT7j3/jm0yKAgDFfx57JHLieHlgKIwvBo
	0UUd6vA9FFyDBpNfEFJ6ohpj6cOsSFwW1lr1U6HECs8yHaLrAQ==
X-Received: by 2002:a05:7022:6184:b0:130:ac5d:8f69 with SMTP id
 a92af1059eb24-1318ea1fdd6mr9371056c88.30.1778492129711; Mon, 11 May 2026
 02:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132427.2703076-1-elver@google.com> <6f2bd63a-dc02-4631-a3a5-7ec8e58a4a4e@kernel.org>
 <afkOMIPu1WNFE9MS@elver.google.com> <CANpmjNM261J5qefMvmUXWZGBVz-KBs7GkbpdNMfTOvNJ-=LiZQ@mail.gmail.com>
 <afz7pZADZPD4mKJr@MacBook-Air.tail10959e.ts.net> <af3xcFjrZSZFG846@elver.google.com>
 <rz7dt4wghum6beghfgm6suqje6jeivrensojjalfis5zeuyen7@6bj7kfpqb4q5>
In-Reply-To: <rz7dt4wghum6beghfgm6suqje6jeivrensojjalfis5zeuyen7@6bj7kfpqb4q5>
From: Marco Elver <elver@google.com>
Date: Mon, 11 May 2026 11:34:53 +0200
X-Gm-Features: AVHnY4Kqj_o0gwegpds4LdAczqxNps8c5-uDjsqJAwkE704552pC9-_A9oEAMnQ
Message-ID: <CANpmjNNevjTo0uwo3DJdDc=PpQpyzj301kFT39OBoCNLW0A8VQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] slab: support for compiler-assisted type-based
 slab cache partitioning
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Hao Li <hao.li@linux.dev>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 10:31, 'Harry Yoo (Oracle)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Fri, May 08, 2026 at 04:21:36PM +0200, Marco Elver wrote:
> > I think I have a solution for this mess, see below.
> >
> > I would not send it as 1 series, but only include the slab changes (+
> > instruction_pointer.h change to introduce _CODE_LOCATION_) as one
> > series, to go through the slab tree. The rest of the patches would go to
> > respective arch maintainers.
>
> I'm assuming this will be a follow-up and reviewing patch 1
> (and waiting for Jon's thuoghts on patch 2)

I'll be sending v4 shortly.

> > diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
> > index aa0b3ffea935..dfe73aafddb8 100644
> > --- a/include/linux/instruction_pointer.h
> > +++ b/include/linux/instruction_pointer.h
> > @@ -8,6 +8,30 @@
> >
> >  #ifndef _THIS_IP_
> >  #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> > +/*
> > + * The current generic definition of _THIS_IP_ is considered broken by GCC [1]
> > + * and Clang [2]. In particular, the address of a label is only expected to be
> > + * used with a computed goto.
> > + *
> > + *   [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071
> > + *   [2] https://github.com/llvm/llvm-project/issues/138272
> > + *
> > + * Mark it as broken, so that appropriate fallback options can be implemented
> > + * for architectures that do not define their won _THIS_IP_.
> > + */
> > +#define HAS_BROKEN_THIS_IP
> > +#endif
>
> As long as _THIS_IP_ is broken on some arches, it cannot be used anyway
> when in a general API that can be used by arbitrary users?

It more or less works today, and for debugging or tracing it's "good
enough" in most cases.

The plan would be to phase out the generic _THIS_IP_ once all
architectures have a correct _THIS_IP_ implementation.

> Is it something that can be fixed in all arches over time?

Yes, I have patches for that.

> > +/*
> > + * _CODE_LOCATION_ provides a unique identifier for the current code location.
> > + * When _THIS_IP_ is broken (generic version), we fall back to a static marker
> > + * which guarantees uniqueness and resolves to a constant address at link time,
> > + * avoiding runtime overhead and compiler optimizations breaking it.
> > + */
> > +#ifdef HAS_BROKEN_THIS_IP
> > +#define _CODE_LOCATION_ ({ static const char __here; (unsigned long)&__here; })
>
> Nice!
>
> Yes, we don't really need the exact code location
> for partitioning kmalloc caches.
>
> IIRC lockdep does a similar thing to define lock classes (unique for
> each lock init location)
>
> > +#else
> > +#define _CODE_LOCATION_ _THIS_IP_
> >  #endif
>
> Probably we don't need this fallback?

x86-64 is the only arch that has working fast _THIS_IP_, and adding
static __here markers to bss is rather wasteful.

More architectures will be supporting _THIS_IP_ properly once I get to
send the patches. The mainstream architectures all have a reasonable
and fast way to get the current IP, so we don't need to waste bss
space there.
