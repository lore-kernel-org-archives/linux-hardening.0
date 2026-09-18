Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C453DC857
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710069; cv=none; b=LXLYSEID0SgNQMUApxpDqYej4hh2jdtOhTdD3/nma8Gw4toQVIKxbRzTcKiBINGG9i71OGyBivSHk9780y+Stsdo2njpjMD2s3QaLoAP4ZOVoJ3bZXzkbalKmIkyKyX6rQ2Odc0/+wvV17X4XBo0uh8h0GKWWAyfKn4/x+0HP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710069; c=relaxed/simple;
	bh=YWtsj5PwMQ955krUqoDWQFAs03JCE4/Tygeh9LobldA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujyVD/4Q+i5yRb/jBkZvtdX0/zc2EnvkWeYybvZCMIJiiK75MCuFP/sNSAYcqjN+0OvSEe0Qyr3Ch2aZXgDDfBA4cfMPiq8YH9DXmxZmB/Hl1zY8RMwan71xQVOktiHrglUApjd5TFzWHZ1LXurzPX6neNxMF2eQigbnoxUE16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzaquyAV; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzaquyAV"
Received: by mail-pz2-f27.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so189360a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789710066; x=1790314866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wMLB7uYEwZQyiM4yhnAgkXdLPxRhK0zajhh6qhWhw30=;
        b=YzaquyAV62wHAjGV7QRZ8JQpMjWBr3ln3++jUr5CJQhDWV1MLnFPfbwxkI5p7p5aGE
         XepNnSl+wXlEiyJjIprC5ysaWZ7gpN+CoC7KR+nVKvNivC8M9UXT1DrYJwpoZz7p0Xvj
         6PoxD3SVbA1Wazr4AwYAIKpBBNwVvjw36XVJBxKgaV53KlJEly1RUcW6dUp0qSrxj91S
         of2wB6UVxlPV018teT+O60W5oaQEanNSkFTYTKRbdj1g9DR8LjKE4h00UmP1ACd3jYEZ
         /Aa7+hMOBNfsRjoQG+/sFq3Jc4nu0tgXJj87iRsfDEGO3LF0r151N7eOIvxHHai8v09N
         slcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789710066; x=1790314866;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMLB7uYEwZQyiM4yhnAgkXdLPxRhK0zajhh6qhWhw30=;
        b=aouq/U1tPExGrhdPJlLF01CXtSRCQbvPVZD8+8m6/29HQBaBbaXzgErgieBT/23rov
         3VEx+G0anU1Eoekp4uzUysVw9cGmyslG26sA/GxEdjje8G4WGAMyUBJf7G57gMLADUbs
         9E4kHi2FWrQzgNTEBYLwYF/shD2LiyEgzgnDoqHkSle2EW7Tr99Tkp6H5NY4ekSfsUBY
         Bx9o4xCmVErBODE5uZAfqYoNtqArQVGtyJaltssnDu2d/Fq+kchMAWERanszh2qkje5p
         G9GtCQ2DHNLOFeEEx86G6yEYuh8vsbqjW2r7b8OUaM2C3m/uafHMqL4+OPN5z+InNLwS
         ol3w==
X-Forwarded-Encrypted: i=1; AKwUvByCMmXZ/HOX3Uu4rqunov4bjh8x8FExtCHVJnwtY8B9n+M9BtgOK3BDJuMPF8j31Lw+vz1t0k97ez9R+v7NFr8=@vger.kernel.org
X-Gm-Message-State: AFuF++nrEHdttAt5b1ChbBrcnNP6rXfrEhQEuhQVdrvzZrPbMmIKx0qL
	wGafIe8z0hOaHf9W87WKRg1hp9sTUJ4yB/hpNeMU1C2NM9bXi/mT5OZv
X-Gm-Gg: AYBFou3CfNjWLAkcx/bNGFAERalwpYsdm8kHRRl3uJoUDoyexW/MrbrL9j7YfuFsddg
	vTUTpSMOaV6uuBcEM3hSD5TY3TnNOc+qtk2EtxjC7T+oCoVcHXaHgjBMkNZEWZczjJWth6P4EVy
	LGiLTTvYc9G5wrthBVhrlL2B8wAisCuuXEqaNXLjCpYVWuJ2guneqZq2gkFiZOQWwQssmCS/Arf
	fQMIW6vmnimHrS5mKjTI3CudZwJfrFeu5ydAoh8KiP3k4UyYisKF/U3ucAOAW+ZntdZ5rKtACHr
	08JndF2qJmUI5BGlKZRowMbLvRxXnBV+niJ9KGXcX2JdpZhYxEKCy+AY9rqG7kfePHZpcty2oSl
	dz/pKiZL5sZaU1YQYBxgi5SiA7KzWlwc1gCngWZEkEjERJAHcFux1S4dNc0kbX/G9llJHLWncQ7
	pXp+1Ny0V5MPvESkXAslKFgqOqyCcpExt7ziuonEUaA+aS03Dja6fWcrKAcgpUuWJU39CHmUCN0
	ET/xxhZglnStnlni0gQVh1Vd7QdXN1CXzDJElZHDVRrM0P2/vF32lc=
X-Received: by 2002:a17:90b:3b85:b0:39e:4c7f:7305 with SMTP id 98e67ed59e1d1-39e5504d3d9mr3117840a91.28.1789710066299;
        Thu, 17 Sep 2026 22:41:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144cdfc3caasm1667596c88.3.2026.09.17.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:41:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:10:57 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com, 
	nikhilks@linux.ibm.com, mahesh@linux.ibm.com, robh@kernel.org, sayalip@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V3] powerpc/kasan: require memintrinsic prefix support
 for KASAN
Message-ID: <aqzJ_rv-lOU2Exhv@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260915100938.1337401-1-mkchauras@gmail.com>
 <CAPAsAGwUnRncpGr47Pq2y7+7AOiGUu4d1FQNnXow4b78kYGMHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPAsAGwUnRncpGr47Pq2y7+7AOiGUu4d1FQNnXow4b78kYGMHg@mail.gmail.com>

On Wed, Sep 16, 2026 at 11:17:36AM -0500, Andrey Ryabinin wrote:
> "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> writes:
> 
> Hi,
> I fed this patch to an AI for review, and the review results are included below.
> Please take a look. From my side, I agree with all of the points
> raised by AI in the
> review, and I think they all need to be addressed. There is also a diff with
> the suggested changes at the very end of this mail.
> 
> 
Hey Andrey,

Thanks for the effort.
> > powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
> > infrastructure relies on the compiler emitting __asan_mem*() calls at
> > instrumented mem*() sites rather than plain memset/memcpy/memmove, so
> > that entry/exit paths calling those functions are not instrumented.
> >
> > [ ... ]
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
> > [ ... ]
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> 
> The thread in the Closes: link is about an early boot hang, but the
> commit message only describes mem*() calls bypassing the shadow check.
> Bypassed checks would lose coverage, not hang the machine.  Is the
> mechanism of the hang understood?
> 
> Looking at the state before this commit, the !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> macros that bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") added to
> asm/kasan.h emit two ELFv2 global entry points back to back:
> 
>   #define _GLOBAL_TOC_KASAN(fn)
>           _GLOBAL_TOC(fn);
>           _GLOBAL_TOC(__##fn)
> 
> With the _GLOBAL_TOC() definition from asm/ppc_asm.h that expands, for
> memcpy_64.S, to:
> 
>   memcpy:
>   0:      addis r2,r12,(.TOC.-0b)@ha
>           addi  r2,r2,(.TOC.-0b)@l
>           .localentry memcpy,.-memcpy       <- local entry is memcpy+8
>   __memcpy:
>   0:      addis r2,r12,(.TOC.-0b)@ha        <- this is memcpy+8
>           addi  r2,r2,(.TOC.-0b)@l
>           .localentry __memcpy,.-__memcpy
> 
> Assembling exactly that for powerpc64le gives memcpy st_other 0x60
> (local entry offset 8), and memcpy+8 is the __memcpy TOC prologue.
> 
> Every same-TOC caller of memcpy() or memmove() is resolved by the
> linker to the local entry, so it lands on that second prologue with r12
> holding whatever the caller left there, and returns with r2 pointing
> at garbage.  Same-TOC callers do not reload r2 after the call.  With
> GENERIC_ENTRY, mm/kasan/shadow.c no longer provides memcpy(), so on a
> toolchain without the prefix parameter every instrumented file calls
> the memcpy symbol directly and hits this.  That matches an early hang
> that only shows up with GCC 9.
> 
> This commit makes the hang go away because the dual-entry macro is
> deleted, but the commit message attributes the fix to something else.
> Could the message describe the r2 corruption, and since this repairs a
> regression from the GENERIC_ENTRY conversion, should it carry:
> 
>   Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Yeah the commit message needs to clearly specify the corruption of r2,
and the Fixes tag should be there.
> 
> On the claim that other GENERIC_ENTRY architectures "do not hit this
> because their CI toolchains are always new enough": x86, s390, riscv
> and loongarch with GCC 8 to 12 build exactly the same configuration,
> CONFIG_KASAN=y without CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, and
> run with mem*() unchecked.  scripts/Makefile.kasan documents that as
> the intended behaviour:
> 
>   # Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
>   # instead. With compilers that don't support this option, compiler-inserted
>   # memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
> 
> and mm/kasan/kasan_test_c.c skips the affected tests with "Test
> requires checked mem*()".  So the situation the message describes is
> the accepted upstream state for old toolchains, not something specific
> to powerpc.
> 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 2580e27e4328..b27ed9739eea 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -7,6 +7,10 @@ config CC_HAS_ELFV2
> >  config CC_HAS_PREFIXED
> >  	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
> >
> > +config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> > +		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
> > +
> >  config CC_HAS_PCREL
> >  	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
> >  	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
> 
> [ ... ]
> 
> > @@ -220,9 +224,9 @@ config PPC
> >  	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
> >  	select HAVE_ARCH_JUMP_LABEL
> >  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> > -	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
> > -	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
> > -	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
> > +	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> >  	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
> >  	select HAVE_ARCH_KCSAN
> >  	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
> 
> This drops KASAN from powerpc entirely for GCC 8 through 12, which are
> inside the supported range in Documentation/process/changes.rst (GNU C
> 8.1 minimum).  An existing .config with CONFIG_KASAN=y silently loses
> it on olddefconfig once HAVE_ARCH_KASAN is no longer selected.
> 
> Given that the actual breakage is the broken memcpy/memmove entry
> points, is it necessary to go this far?  Keeping one _GLOBAL_TOC()
> prologue for __memcpy and making memcpy a plain alias of it (a second
> label plus a matching .localentry, or a global entry that branches to
> __memcpy) would restore the pre-GENERIC_ENTRY behaviour, with mem*()
> unchecked on old compilers exactly like the other GENERIC_ENTRY
> architectures.  That also keeps a Fixes-tagged backport candidate from
> removing a feature on stable kernels.
> 
Ok, yeah this is too aggressive. I will rectify this in next revision.
> 
> > diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> > index a690e7da53c2..d62756b87ba4 100644
> > --- a/arch/powerpc/include/asm/kasan.h
> > +++ b/arch/powerpc/include/asm/kasan.h
> > @@ -2,20 +2,9 @@
> >  #ifndef __ASM_KASAN_H
> >  #define __ASM_KASAN_H
> >
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
> >  #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
> >  #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
> >  #define EXPORT_SYMBOL_KASAN(fn)
> > -#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> >
> >  #ifndef __ASSEMBLER__
> >
> 
> this isn't a bug, but after this change _GLOBAL_KASAN(), _GLOBAL_TOC_KASAN()
> and EXPORT_SYMBOL_KASAN() are unconditional identity macros with a single
> empty one.  Should the five users in mem_64.S, memcpy_64.S and copy_32.S
> switch to _GLOBAL()/_GLOBAL_TOC() and the macros go away?
> 
> Related leftover: arch/powerpc/kernel/prom_init_check.sh still has
> 
>   has_renamed_memintrinsics()
>   {
>           grep -q "^CONFIG_KASAN=y$" "${KCONFIG_CONFIG}" && \
>                   ! grep -q
> "^CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y" "${KCONFIG_CONFIG}"
>   }
> 
>   if has_renamed_memintrinsics
>   then
>           MEM_FUNCS="__memcpy __memset"
> 
> which can no longer be true on powerpc after this commit.  Should that
> branch be removed in the same cleanup?
> 
Yes it should be. It's a dead code now.
> > diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> > index 1981bd4036b5..72b5c93a2b84 100644
> > --- a/arch/powerpc/include/asm/string.h
> > +++ b/arch/powerpc/include/asm/string.h
> > @@ -29,29 +29,10 @@ extern void * memchr(const void *,int,__kernel_size_t);
> >  void memcpy_flushcache(void *dest, const void *src, size_t size);
> >
> >  #ifdef CONFIG_KASAN
> > -/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
> > -#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > +/* Used by mm/kasan/shadow.c as raw backends to bypass KASAN checking. */
> >  #define __memset memset
> 
> this isn't a bug, but the new comment names only mm/kasan/shadow.c.
> The same __memset()/__memcpy() names are used by mm/kasan/generic.c as
> well (DEFINE_ASAN_SET_SHADOW() and release_alloc_meta()), so would
> "used by mm/kasan as raw backends" be more accurate?
> 
> 
> ---
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b27ed9739eea..2580e27e4328 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -7,10 +7,6 @@ config CC_HAS_ELFV2
>  config CC_HAS_PREFIXED
>  	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
> 
> -config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> -	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address
> -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> -		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param
> asan-kernel-mem-intrinsic-prefix=1))
> -
>  config CC_HAS_PCREL
>  	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
>  	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
> @@ -224,9 +220,9 @@ config PPC
>  	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> -	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 &&
> PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> -	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU &&
> PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> -	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 &&
> PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
> +	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
>  	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KCSAN
>  	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index d62756b87ba4..599a9e02af02 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -2,10 +2,6 @@
>  #ifndef __ASM_KASAN_H
>  #define __ASM_KASAN_H
> 
> -#define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
> -#define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
> -#define EXPORT_SYMBOL_KASAN(fn)
> -
>  #ifndef __ASSEMBLER__
> 
>  #include <asm/page.h>
> diff --git a/arch/powerpc/kernel/prom_init_check.sh
> b/arch/powerpc/kernel/prom_init_check.sh
> index 3090b97258ae..3155cc722e48 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -13,21 +13,8 @@
>  # If you really need to reference something from prom_init.o add
>  # it to the list below:
> 
> -has_renamed_memintrinsics()
> -{
> -	grep -q "^CONFIG_KASAN=y$" "${KCONFIG_CONFIG}" && \
> -		! grep -q "^CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y" "${KCONFIG_CONFIG}"
> -}
> -
> -if has_renamed_memintrinsics
> -then
> -	MEM_FUNCS="__memcpy __memset"
> -else
> -	MEM_FUNCS="memcpy memset"
> -fi
> -
>  WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
> -_end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
> +_end enter_prom memcpy memset reloc_offset __secondary_hold
>  __secondary_hold_acknowledge __secondary_hold_spinloop __start
>  logo_linux_clut224 btext_prepare_BAT
>  reloc_got2 kernstart_addr memstart_addr linux_banner _stext
> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
> index 933b685e7ab6..97eb9ca0cc23 100644
> --- a/arch/powerpc/lib/copy_32.S
> +++ b/arch/powerpc/lib/copy_32.S
> @@ -10,7 +10,6 @@
>  #include <asm/errno.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/code-patching-asm.h>
> -#include <asm/kasan.h>
> 
>  #define COPY_16_BYTES		\
>  	lwz	r7,4(r4);	\
> @@ -87,7 +86,7 @@ EXPORT_SYMBOL(memset16)
>   * We therefore skip the optimised bloc that uses dcbz. This jump is
>   * replaced by a nop once cache is active. This is done in machine_init()
>   */
> -_GLOBAL_KASAN(memset)
> +_GLOBAL(memset)
>  	cmplwi	0,r5,4
>  	blt	7f
> 
> @@ -147,7 +146,6 @@ _GLOBAL_KASAN(memset)
>  	bdnz	9b
>  	blr
>  EXPORT_SYMBOL(memset)
> -EXPORT_SYMBOL_KASAN(memset)
> 
>  /*
>   * This version uses dcbz on the complete cache lines in the
> @@ -160,12 +158,12 @@ EXPORT_SYMBOL_KASAN(memset)
>   * We therefore jump to generic_memcpy which doesn't use dcbz. This jump is
>   * replaced by a nop once cache is active. This is done in machine_init()
>   */
> -_GLOBAL_KASAN(memmove)
> +_GLOBAL(memmove)
>  	cmplw	0,r3,r4
>  	bgt	backwards_memcpy
>  	/* fall through */
> 
> -_GLOBAL_KASAN(memcpy)
> +_GLOBAL(memcpy)
>  1:	b	generic_memcpy
>  	patch_site	1b, patch__memcpy_nocache
> 
> @@ -241,8 +239,6 @@ _GLOBAL_KASAN(memcpy)
>  65:	blr
>  EXPORT_SYMBOL(memcpy)
>  EXPORT_SYMBOL(memmove)
> -EXPORT_SYMBOL_KASAN(memcpy)
> -EXPORT_SYMBOL_KASAN(memmove)
> 
>  generic_memcpy:
>  	srwi.	r7,r5,3
> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> index 6fd06cd20faa..40eaedd31486 100644
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -8,7 +8,6 @@
>  #include <asm/processor.h>
>  #include <asm/errno.h>
>  #include <asm/ppc_asm.h>
> -#include <asm/kasan.h>
> 
>  #ifndef CONFIG_KASAN
>  _GLOBAL(__memset16)
> @@ -29,7 +28,7 @@ EXPORT_SYMBOL(__memset32)
>  EXPORT_SYMBOL(__memset64)
>  #endif
> 
> -_GLOBAL_KASAN(memset)
> +_GLOBAL(memset)
>  	neg	r0,r3
>  	rlwimi	r4,r4,8,16,23
>  	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
> @@ -95,9 +94,8 @@ _GLOBAL_KASAN(memset)
>  	stb	r4,0(r6)
>  	blr
>  EXPORT_SYMBOL(memset)
> -EXPORT_SYMBOL_KASAN(memset)
> 
> -_GLOBAL_TOC_KASAN(memmove)
> +_GLOBAL_TOC(memmove)
>  	cmplw	0,r3,r4
>  	bgt	backwards_memcpy
>  	b	memcpy
> @@ -139,4 +137,3 @@ _GLOBAL(backwards_memcpy)
>  	mtctr	r7
>  	b	1b
>  EXPORT_SYMBOL(memmove)
> -EXPORT_SYMBOL_KASAN(memmove)
> diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
> index b5a67e20143f..0cedd455231a 100644
> --- a/arch/powerpc/lib/memcpy_64.S
> +++ b/arch/powerpc/lib/memcpy_64.S
> @@ -7,7 +7,6 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-compat.h>
>  #include <asm/feature-fixups.h>
> -#include <asm/kasan.h>
> 
>  #ifndef SELFTEST_CASE
>  /* For big-endian, 0 == most CPUs, 1 == POWER6, 2 == Cell */
> @@ -15,7 +14,7 @@
>  #endif
> 
>  	.align	7
> -_GLOBAL_TOC_KASAN(memcpy)
> +_GLOBAL_TOC(memcpy)
>  BEGIN_FTR_SECTION
>  #ifdef __LITTLE_ENDIAN__
>  	cmpdi	cr7,r5,0
> @@ -227,4 +226,3 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
>  	blr
>  #endif
>  EXPORT_SYMBOL(memcpy)
> -EXPORT_SYMBOL_KASAN(memcpy)

Yeah this seems like it could work. Letme try this.


Thanks,
Mukesh
