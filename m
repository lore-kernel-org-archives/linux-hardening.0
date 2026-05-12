Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400F4BC016
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579516; cv=pass; b=QdPzj0Chgxz15ol85Hd0mIF/zucdJJWmbGp5lwXnmjq6r348LW57l3pCxCUVtJ2SbaMEKfnHrjekZk2tAnMdvKeHlmEFKmaB7m+gA0IteGzQhjtjuE8Iy00KxtN2m6I4OSfirGycDiQeSdqtVIgQJMw6HjTuVM5leKq4z0HlJKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579516; c=relaxed/simple;
	bh=EIsIINGplKZJmp6KyNBZmIyWQAlnRy4EfCcfLd8VLHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtypT7Fi5F0MhHcR8xf5WmWTPlXgc+tAyQ2UKp+cc3SQD+MDxVBkzIKOjDaE0P3pcFkb3dEO4yRlK1lDK1JiIxxpx1ziW/xyYIyhEDyTyRw4Elpkz3A/nqmkB6R8xRn2vKHXK+rJRdk0yGQ0wObXkFvoDHqTIQZURsCg1YYSOjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4Domj8i; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4Domj8i"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1332772f6b3so2252684c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 02:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778579514; cv=none;
        d=google.com; s=arc-20240605;
        b=LUVR/HtZVd563U+AWrit3roZg7oI3/JmTRBn63wEPLF2BW6L2P1lKSIHL/vli1/iPh
         otLt1bx2GoSol/V1EKlbWAfD4QQxTzQzc4vWvRhbMCoyABPR3H+RfkmUEw0V6FXSug+x
         37CmdNZsakqRrtCoTIEYFSc4A0yohEOvSIGfMW0oXIIVYjZYovXB5Ti6MWF+/PVDalEO
         KcBnLWwsHqmP3mWrON+cXo8iKyDRhw66n0wgvtsDa70HHcnMp0LAlCA8vQUrk4gP3onZ
         iGE1Uwi/jHgfyGxHI8EWIrg0EZdjB56iSZHWf/T5drRZwPzUiv+dZh3rf6pTzQ1GQRq0
         qFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+ec8Gp9KIgloqxfI4Ah9RgcAxU70GC5qHU2EuM04KDM=;
        fh=WKDbT3Cl0MHFhGfq8GpNOGaJzVcuT2mn9z8zb1P8Kb4=;
        b=KW6n7CXwGCOCwNMSwNUP6lWAOA+w1vF6XbnYS7D21FGNrlnQeIi1GyjHvZbBWjj2Ky
         vU3NMgBIZZlBLy273MMg+E0sDqkh4RMDa4B9Nrxdby5VMoXQO7y82N5Y1ZilDrFzMMND
         IbqHUxJM/+SY4liCw30ymnnj+oFrbTVw3byQsHNIcMPX+2/TwDF7brBJ2sA5gpelgAX8
         MzourvnLip9ScU2HIYJKB21KFyqKpI2eNDijcbzjLh8DYCHIuFlpMx53MkPDRyyZFrPE
         jwjeFNPaarwcIDsGe9CxoO2DB9NFQvtVg9BLuj3cZHFTMLOmEQBtMfwQ+woKfSJZvcOs
         nIUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778579514; x=1779184314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ec8Gp9KIgloqxfI4Ah9RgcAxU70GC5qHU2EuM04KDM=;
        b=l4Domj8inxGVm5Bp7+5ucV8jYDuDKDIDjlyjS1jwCBey1DhmQq2KHip6/hbkWQ/TvO
         Q1MA5cX3zO77Ija8uWGiArMgJoYCjjso89pSTD1kwhwltdenAYfyAZij0e8LK8NqqsQ0
         2qFwADsdr3UR705KNj9wCq8ibpmjlhHADEtKJpjG7IOSdwVWCQSEPRZGxpwSFnix3dlk
         R5YozBg0f83Y54jpd2V5ey20pufnemPji+tSdtu4jwNAd0+ZHp+bd/pxvODVhI6uVFNR
         nKsrTns1tBYe8ONcSZPXNIdPfDIyDZrJwmuoMu1rDMVlvyhok+43Fv7262BYxbQgD4tS
         t2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579514; x=1779184314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ec8Gp9KIgloqxfI4Ah9RgcAxU70GC5qHU2EuM04KDM=;
        b=SP3klsGLdAb3Z+0c+3P4jwludS+wNd9tmxrLFgpezAQH6dn1KEGUDmnd/0M73OAt+v
         8AewIs4lafIGhI74pLCL6kehH/nHcMnTiRbARYESBIDcFbDGILEK6yf0jQk8PaHGUpqK
         RphfnmXuurUrDNMKM6OqKKUvSm33uT/HXjOOMGtMx1qvaHPtCi1sOnQP8aB9gSAs+Cmh
         lxtWtYAcWOpM4iXeAYEhEQOJ7XgLfY8xs+Te43hamkJ1ObbvnJrRG+lLg4WYaxphKN19
         GT6xmR1w+ZHTZ72HmUhLUOLn4rT6XfAk0CHHcEFdhViylAylL9Qrq5vUzjzXyDIV5Uza
         LTuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yjyj1LqVmibK10gNeH6w7QofT+GBIhfa6UR75AQP3B8XVF2uUsUEdBT3lD4zNxHvQSP1P7Ywf4+OcRt2XIVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2n+EmYFmrzEWKA0BP1FyBboNH6Z935cLsc9jFjlhJfqjZ6aL
	bBlSoHnKdGFRztgJaiA7yZBnWlLr7gad9xadnaz/nD8oUskUo0Uc0OSizsPRjDJ+xODeqZT6KGG
	K9Pq53wxrS0oAa8Spye+hHIDYy7TuQXbdzo9He9jY
X-Gm-Gg: Acq92OHFzMH7pBhbEW8nB4RzXKj/P9fXMDqS+RvojunuxLbYw1XqZ29x4unibsbQrzx
	Qw3opVhK5V2ibhxRKm4Ot3/LwhcXP91bFYP4483VZON42XbHpL+KyMnKSuGszJ5mSsZSgWLqTXn
	Eji8mfGW+iM6D5BOVBTgbe8MFwqWXLFUyzhIkYtNXighrI8q4v3IXVhDCJx6VbUpqOlc8/4R1iI
	qW18PM9M2aaPGXKqdhTOsWvtKsL2+uBCPdrHsNp96MeSw5tqIgMdskayVku0JQigm4OdPcRwEWF
	7vimeAesE4W6giJ2euvoY68DONT2/LMFLMBvNyQXbRWB9A4H
X-Received: by 2002:a05:7022:38c:b0:128:d20a:2f40 with SMTP id
 a92af1059eb24-13344c4307bmr1461470c88.8.1778579513098; Tue, 12 May 2026
 02:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511200136.3201646-1-elver@google.com> <20260511200136.3201646-2-elver@google.com>
 <3z5unwqxty4qq2siingxdijbk642te7kf26ba4ff2xsmyptgq5@i6bxrvkfbve4>
In-Reply-To: <3z5unwqxty4qq2siingxdijbk642te7kf26ba4ff2xsmyptgq5@i6bxrvkfbve4>
From: Marco Elver <elver@google.com>
Date: Tue, 12 May 2026 11:51:15 +0200
X-Gm-Features: AVHnY4J9rWhb6ZrnXllLEE_U0YQh3r6D8w8ra1G0CJOzHs8wrDs9DHipy-uAw-w
Message-ID: <CANpmjNN-rPHMOGxyfcAGiJKDdDixiB70uYOa0UVCs92QgMNGYQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] slab: improve KMALLOC_PARTITION_RANDOM randomness
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Bill Wendling <morbo@google.com>, 
	David Hildenbrand <david@kernel.org>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, linux-hardening@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Hao Li <hao.li@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, 
	Alexander Potapenko <glider@google.com>, Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 07:13, 'Harry Yoo (Oracle)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Mon, May 11, 2026 at 10:00:49PM +0200, Marco Elver wrote:
> > When using CONFIG_KMALLOC_PARTITION_RANDOM, _RET_IP_ was previously used
> > to identify the allocation site. _RET_IP_, however, evaluates to the
> > caller's parent's instruction pointer rather than the actual allocation
> > site; this would lead to collisions where a function performs multiple
> > allocations.
> >
> > With the generalization to kmalloc_token_t, we now generate the token at
> > the outermost macro, and using _THIS_IP_ would fix this for all cases.
> >
> > Unfortunately, the generic implementation of _THIS_IP_ relies on taking
> > the address of a local label, which is considered broken by both GCC [1]
> > and Clang [2] because label addresses are only expected to be used with
> > computed gotos. While the generic version more or less works today, it
> > is known to be brittle. For example, Clang -O2 always returns 1 when
> > this function is inlined:
> >
> >         static inline unsigned long get_ip(void)
> >         { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }
> >
> > To provide a reliable unique identifier without breaking architectures
> > relying on the generic _THIS_IP_, introduce _CODE_LOCATION_: it resolves
> > to _THIS_IP_ where architectures provide a safe implementation, and
> > falls back to a zero-cost static marker where _THIS_IP_ is broken.
> >
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
> > Link: https://github.com/llvm/llvm-project/issues/138272 [2]
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks!

> with one suggestion below.
>
> > ---
> >  include/linux/instruction_pointer.h | 24 ++++++++++++++++++++++++
> >  include/linux/slab.h                |  2 +-
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
> > index aa0b3ffea935..ea5bc756bd99 100644
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
> > + * for architectures that do not define their own _THIS_IP_.
> > + */
> > +#define HAS_BROKEN_THIS_IP
> > +#endif
> > +
> > +/*
> > + * _CODE_LOCATION_ provides a unique identifier for the current code location.
> > + * When _THIS_IP_ is broken (generic version), we fall back to a static marker
> > + * which guarantees uniqueness and resolves to a constant address at link time,
> > + * avoiding runtime overhead and compiler optimizations breaking it.
> > + */
> > +#ifdef HAS_BROKEN_THIS_IP
> > +#define _CODE_LOCATION_ ({ static const char __here; (unsigned long)&__here; })
>
> nit: perhaps it can be __initdata to free these after boot?
> ... if we want to save actual memory allocated rather than the
> vmlinux size.
>
> apparently ".init.bss" is a not thing :(

Not sure - it might cause CONFIG_DEBUG_SECTION_MISMATCH warnings.
Also, if this memory is reclaimed, it may be reused for kernel
modules, at which point there's a chance for collisions.
