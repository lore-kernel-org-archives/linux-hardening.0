Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985444FECF9
	for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566768; cv=none; b=Z3gbz3y4tFLn8sLPTN3KhfusvrozjSfrR8KRixR7toIjTMqTdlP0oTJXpMUf1s+XYwioyoLHe+jm88fW3pzuf1H9kgPaRiisDY2zbwBVzyV8rWuGmBP7L9uQAzHBzQFwOb8DvrlsCk3tx3yam9nyxxAhZapfxx/dPP5gfvzBTvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566768; c=relaxed/simple;
	bh=4ZrFxqswK0GLr7sFiFGGCCKkxP1RmuaZyr5GLskixPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eam0u3b7WdBNqaPdBEK5Qlk83VGeP5ZwoQSBnlxE4w1wDqBDAZSeuE5cvd/gEyLVtvLicm7NP/NRLV8qFPwuLR2JkXP8ylwylh81zFJSyijTlm8lLXcuVcZebA5XHyqovZqzNqXJ5DBPXbEJcO3s5qT1gL287B8FvDeg9bf8ukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt8xcqJI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt8xcqJI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52ff0eea420so18287951cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566762; x=1790171562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrXhm30p4Oapdc6/FVPPsH4AbsMAlVpIDcdh0Tr8GC4=;
        b=dt8xcqJIaJJO6FJYrr3/mK+s3ffV1Tt4bERR4qnZyWQdrlVODy6s2FIiH/0ryarXuh
         GfgUWLq19PnbNoepEfgCZ2DrZZrnEwHYs9ziKquJDCi3sGXNzSQej7cpwVHwUQFcermL
         APWO3WVufujAaT6PYVMy60IyKPADb5Vg/YDOX0V2ht0VWZj+BGgbZ0j+4ZnKd0lUn4Jz
         MHcSLuOk9EMdFachnsES7azAstFycoLuYHdHMDTVLxag9itDs8wnMU4v7Q0wmM6TwVGP
         9M3HV8rw+C8IxggIisFP/W6G5264HKjp6JRInxisGBn0ZkAp0Y441d7qhrm6sIQpUxjP
         HcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566762; x=1790171562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VrXhm30p4Oapdc6/FVPPsH4AbsMAlVpIDcdh0Tr8GC4=;
        b=rFQmwKlUluj9O6oKlByraBxmnmvRTe48JHJk4Sdhax/phzVpsFQyLxAk3w+5to5LDJ
         lhiJswTmrEcjJevLGPJbbd+FcjYc1lr+UIR1XKxOoxZ3r/MLhLVV9xnPZL17PMOCXNuK
         BBZHIY8PWM33rE5geqZRIyC0bP8krNha0gErKyS5Z2BazAp1tDpstvc9lO6pUkDVqcPd
         P+i7JvvAqQVIGH8Et/YgmU2SW4faVv0Lfrqc361Lq5mNh8o63cJkxoeLR7NjvMMRmkHG
         a4XorBCzzRLZuc2lOT78i04jH/CPIfEg2m6y6evvsawaXCTTCyhHLYLHITnaEvGax0Ph
         ABFg==
X-Forwarded-Encrypted: i=1; AKwUvBw3PWM8xdiE8JI2IBhYA2Kvi81/tX+kNgahF6uDuKh5sPOZ75m84Gn+7GEDDhgfFX2WSAwBK07PQpTRkRBRXIU=@vger.kernel.org
X-Gm-Message-State: AFuF++kq1f6YGUVJanQwSeg9vmeH8NMP9JrGlDyRRZdEAjnhFUWOedpu
	e+S2VR3rtix3fvuKUZdshQEsz4Scs1WlwaCDEu70xtxaM4pYqK0YmHI7
X-Gm-Gg: AYBFou2iXfljxDRXWUAz8rMTYBuvwHgBXeB/hBEpNGLKk78ehnUSv/31wS309UGbGxy
	YPLC1xPzAD5S3LWqIVZdK40Z1l8eHdYghyH0T20a/iLDOySBw1p6RpPGZ6gB0XoX6DGZJdC11Ob
	FGNvXfK3g0pU1MzjbE8AL4RY+Bydqa+8DzKSUYG+0CSsBGykkdk/j59Q5fTibXaFFgCMZo7kbhS
	wXBQucQlMsqi0748x3KCorCicIQRBR3Z6e3DPs9GFRC0oCyx4osFud2FiZoBasLGd9gFwCkli+D
	xqBScJvtVV5h4nF24ECrXW9wJiEybDwoP3h5nB9yJtkHjBfPSsXBg1TT1jJ6o6kYUf6UBb7XnzC
	tbesOAEMS27xMPzDXp6qp8EBdYzOiVfaTK8l2E30q30Xve/STsawULLeb7du1P4Krb7B+BbYZur
	sd+hEvetLhWKrUL+YjdAU8zSMEXQa781Mz7y0zkK0ooQizBrkK3d3TQDljBGWFMUCErEtYPrp8n
	OGhZIPo21aiMUTzdQCGkNRk5DUdrK6T4/c3UQt1KYZjYUrPto0oQg15
X-Received: by 2002:ac8:5e0e:0:b0:530:f45b:4372 with SMTP id d75a77b69052e-53119f01f7fmr112879611cf.29.1789566761864;
        Wed, 16 Sep 2026 06:52:41 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53259aed4b0sm23229691cf.2.2026.09.16.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:52:41 -0700 (PDT)
Date: Wed, 16 Sep 2026 19:22:28 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com, 
	nikhilks@linux.ibm.com, mahesh@linux.ibm.com, robh@kernel.org, sayalip@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V3] powerpc/kasan: require memintrinsic prefix support
 for KASAN
Message-ID: <aqqej0mnRbfsD9EP@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260915100938.1337401-1-mkchauras@gmail.com>
 <15808e6e-a6c0-49ae-b23e-daa3785a1be0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15808e6e-a6c0-49ae-b23e-daa3785a1be0@kernel.org>

On Wed, Sep 16, 2026 at 01:09:41PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 15/09/2026 à 12:09, Mukesh Kumar Chaurasiya (IBM) a écrit :
> > powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
> > infrastructure relies on the compiler emitting __asan_mem*() calls at
> > instrumented mem*() sites rather than plain memset/memcpy/memmove, so
> > that entry/exit paths calling those functions are not instrumented.
> > 
> > This assumption is encoded in two places:
> > 
> >    mm/kasan/shadow.c:
> >      #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
> >          !defined(CONFIG_GENERIC_ENTRY)
> > 
> >    include/linux/fortify-string.h:
> >      #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
> >          !defined(CONFIG_GENERIC_ENTRY)
> > 
> > When GENERIC_ENTRY is set, both guards suppress the C wrappers for
> > memset/memcpy/memmove and the __underlying_mem*() redirections. This
> > is only safe when the compiler supports the prefixed __asan_mem*()
> > intrinsics. On older toolchains (e.g. GCC 9) that lack this support,
> > plain mem*() calls from instrumented code fall through to the raw
> > assembly implementations in mem_64.S / copy_32.S, completely bypassing
> > the KASAN shadow check.
> > 
> > Other arches with GENERIC_ENTRY (x86, s390, loongarch, riscv) do not
> > hit this because their CI toolchains are always new enough to support
> > the prefix flag.
> > 
> > Background: the !GENERIC_ENTRY guard was introduced by commit 69d4c0d32186
> > ("entry, kasan, x86: Disallow overriding mem*() functions", Peter Zijlstra,
> > Jan 2023). The root problem is that the KASAN C wrappers override the
> > linker symbol memset/memcpy/memmove globally, so any call from noinstr or
> > __no_sanitize_address code (e.g. irqentry_enter/irqentry_exit) would still
> > reach the KASAN shadow-check wrapper -- at a point where KASAN invariants
> > may not hold. The compiler prefix approach (Marco Elver, Feb 2023,
> > commit 51287dcb00cc) solves this by having the compiler emit __asan_memset
> > at instrumented call sites and bare memset inside __no_sanitize_address
> > functions, splitting the decision at code-generation time rather than at
> > link time.
> > 
> > A manual C-level override cannot replicate this split: a single linker
> > symbol cannot be made to resolve differently depending on the caller.
> > 
> > x86 also placed its raw memset/memcpy/memmove implementations in
> > .noinstr.text (same commit, 69d4c0d32186), which is the other half of
> > the fix: noinstr callers hit the raw assembly directly, safely bypassing
> > KASAN. PowerPC has not done this. Placing mem_64.S / memcpy_64.S /
> > copy_32.S implementations in .noinstr.text would be the complementary
> > long-term fix that could re-enable KASAN on older toolchains, but it
> > requires care around linker stub overflow on large PPC64 kernels (the
> > same reason powerpc uses NOKPROBE_SYMBOL rather than noinstr for its
> > interrupt handlers -- see the comment in asm/interrupt.h). That work
> > is left as a follow-up.
> > 
> > For now, introduce PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, an arch-local
> > compiler probe that mirrors the same check as CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > in lib/Kconfig.kasan but lives outside the 'if KASAN' block to avoid a
> > recursive dependency (CC_HAS_KASAN_MEMINTRINSIC_PREFIX depends on KASAN
> > which depends on HAVE_ARCH_KASAN). Gate the three HAVE_ARCH_KASAN selects
> > on this new symbol so that KASAN is not offered as a config option on
> > toolchains that cannot support it correctly with GENERIC_ENTRY.
> > 
> > Since KASAN on powerpc now unconditionally implies
> > CC_HAS_KASAN_MEMINTRINSIC_PREFIX, the old !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > code paths in asm/kasan.h and asm/string.h are dead. Clean them up:
> > 
> > - asm/kasan.h: remove the dual-entry-point variant of _GLOBAL_KASAN /
> >    _GLOBAL_TOC_KASAN / EXPORT_SYMBOL_KASAN that emitted both memset and
> >    __memset as entry points to the same assembly. These aliases were only
> >    needed so the C KASAN wrappers in shadow.c could call __memset() to
> >    reach raw memory ops; with the compiler prefix approach those wrappers
> >    are not used for mem* on powerpc.
> > 
> > - asm/string.h: remove the separate __memset/__memcpy/__memmove symbol
> >    declarations and the memset/memcpy/memmove macro redirections for
> >    uninstrumented files that were needed on old toolchains. Simplify the
> >    CONFIG_KASAN block to just the three #define aliases (still used by
> >    shadow.c as raw backends to bypass KASAN checking).
> > 
> > - cputable.c, prom_init.c: the memcpy is not required now as the manual
> >    instrumentation of memcpy is removed. Hence directly use *dest = *src
> >    for this.
> > 
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> 
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> 
> > ---
> > Changelog:
> > V2 -> V3:
> > - *dest = *src used instead of memcpy in cputable.c and prom_init.c
> 
> We could have left the memcpy() there but I'm fine either way. What was
> important was to remove the comment as it was valid only for the
> non-CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX case.
>
I thought this would make the code look simpler.
> If for some reason you have to send a new version, it would be good to
> mention it is a revert of commit adcf59187e27 ("powerpc: don't use direct
> assignation during early boot.") as it is not necessary anymore with
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> 
I can send out a new version, it's just a commit message change.
> Christophe
> 
Thanks for all the effort in review and explanation.

Regards,
Mukesh

> > V2: https://lore.kernel.org/all/20260911180536.3234640-2-mkchauras@gmail.com
> > 
> > V1 -> V2:
> > - Comments reworded
> > - Commit message reworded
> > V1: https://lore.kernel.org/all/20260908064948.999530-1-mkchauras@gmail.com
> > 
> >   arch/powerpc/Kconfig              | 10 +++++++---
> >   arch/powerpc/include/asm/kasan.h  | 11 -----------
> >   arch/powerpc/include/asm/string.h | 21 +--------------------
> >   arch/powerpc/kernel/cputable.c    | 14 ++------------
> >   arch/powerpc/kernel/prom_init.c   | 10 ++--------
> >   5 files changed, 12 insertions(+), 54 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 2580e27e4328..b27ed9739eea 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -7,6 +7,10 @@ config CC_HAS_ELFV2
> >   config CC_HAS_PREFIXED
> >   	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
> > +config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> > +		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
> > +
> >   config CC_HAS_PCREL
> >   	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
> >   	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
> > @@ -220,9 +224,9 @@ config PPC
> >   	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
> >   	select HAVE_ARCH_JUMP_LABEL
> >   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> > -	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
> > -	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
> > -	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
> > +	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> >   	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
> >   	select HAVE_ARCH_KCSAN
> >   	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> > index a690e7da53c2..d62756b87ba4 100644
> > --- a/arch/powerpc/include/asm/kasan.h
> > +++ b/arch/powerpc/include/asm/kasan.h
> > @@ -2,20 +2,9 @@
> >   #ifndef __ASM_KASAN_H
> >   #define __ASM_KASAN_H
> > -#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
> > -#define _GLOBAL_KASAN(fn)			\
> > -	_GLOBAL(fn);				\
> > -	_GLOBAL(__##fn)
> > -#define _GLOBAL_TOC_KASAN(fn)			\
> > -	_GLOBAL_TOC(fn);			\
> > -	_GLOBAL_TOC(__##fn)
> > -#define EXPORT_SYMBOL_KASAN(fn)			\
> > -	EXPORT_SYMBOL(__##fn)
> > -#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> >   #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
> >   #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
> >   #define EXPORT_SYMBOL_KASAN(fn)
> > -#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> >   #ifndef __ASSEMBLER__
> > diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> > index 1981bd4036b5..72b5c93a2b84 100644
> > --- a/arch/powerpc/include/asm/string.h
> > +++ b/arch/powerpc/include/asm/string.h
> > @@ -29,29 +29,10 @@ extern void * memchr(const void *,int,__kernel_size_t);
> >   void memcpy_flushcache(void *dest, const void *src, size_t size);
> >   #ifdef CONFIG_KASAN
> > -/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
> > -#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +/* Used by mm/kasan/shadow.c as raw backends to bypass KASAN checking. */
> >   #define __memset memset
> >   #define __memcpy memcpy
> >   #define __memmove memmove
> > -#else /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> > -void *__memset(void *s, int c, __kernel_size_t count);
> > -void *__memcpy(void *to, const void *from, __kernel_size_t n);
> > -void *__memmove(void *to, const void *from, __kernel_size_t n);
> > -#ifndef __SANITIZE_ADDRESS__
> > -/*
> > - * For files that are not instrumented (e.g. mm/slub.c) we
> > - * should use not instrumented version of mem* functions.
> > - */
> > -#define memcpy(dst, src, len) __memcpy(dst, src, len)
> > -#define memmove(dst, src, len) __memmove(dst, src, len)
> > -#define memset(s, c, n) __memset(s, c, n)
> > -
> > -#ifndef __NO_FORTIFY
> > -#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> > -#endif
> > -#endif /* !__SANITIZE_ADDRESS__ */
> > -#endif /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> >   #endif /* CONFIG_KASAN */
> >   #ifdef CONFIG_PPC64
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6f6801da9dc1..6356b5c6be7b 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -35,12 +35,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> >   	struct cpu_spec *t = &the_cpu_spec;
> >   	t = PTRRELOC(t);
> > -	/*
> > -	 * use memcpy() instead of *t = *s so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > -	 */
> > -	memcpy(t, s, sizeof(*t));
> > -
> > +	*t = *s;
> >   	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
> >   }
> > @@ -52,12 +47,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
> >   	t = PTRRELOC(t);
> >   	old = *t;
> > -
> > -	/*
> > -	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
> > -	 * so that GCC replaces it by __memcpy() when KASAN is active
> > -	 */
> > -	memcpy(t, s, sizeof(*t));
> > +	*t = *s;
> >   	/*
> >   	 * If we are overriding a previous value derived from the real
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index eb9f556b0937..e8e071024da5 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -1362,14 +1362,8 @@ static void __init prom_check_platform_support(void)
> >   	int prop_len = prom_getproplen(prom.chosen,
> >   				       "ibm,arch-vec-5-platform-support");
> > -	/*
> > -	 * First copy the architecture vec template
> > -	 *
> > -	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > -	 */
> > -	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
> > -	       sizeof(ibm_architecture_vec));
> > +	/* First copy the architecture vec template */
> > +	ibm_architecture_vec = ibm_architecture_vec_template;
> >   	prom_strscpy_pad(ibm_architecture_vec.vec7.os_id, linux_banner, 256);
> 
