Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CF4CEE4F
	for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575461; cv=pass; b=XhFtfNYRbCP4WM2xY3jZkw2F3/WpnzLs0TLED5iaIpBNTmFGFjM4xA6ySNWRRMcLlLokjuDBmPvIqPGHGYpQ1m5t5xmoH3f74R/ssPSFY6Ai3lmZ5yXc+S9b5/r1Usax4Sny/i+y/jtlwxyZm7I4ebfZpOeCHndq5Yl44ynSofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575461; c=relaxed/simple;
	bh=P3FI2yhIbLhga0GBj/FeMmJG1Ss0EXeIvT5iRieNDS0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ9ymZmG3fpPEQR6+Cu2rCjfvuneobJauYsJr2xmq5WWD8Soz91cBhZvZStJr9/Bzij5nB4iQtuPdNFQ75j4fbizrOPzHlB64YG58cSsc5CqOIueEDc3j8NAP2pJ8XQtcGBqgOFnwncXewzfnK1gHR99Whi1VMQs6XK0GgvA/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp3ZaW/8; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp3ZaW/8"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66fb6b22cf3so200220d50.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 09:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575457; cv=none;
        d=google.com; s=arc-20260327;
        b=nJwjtlUL5w/uBYRlZuURaQWoWt8OSYtH0XXSI1kWRtbnj+x088do+z3JRPbHcOnL8/
         Kp3FFjkb3uG1S+tCuV/+ZQ0a3PxD2Fni1G1rYrdzZT9/aRpzHd5Z4YKDv3v7DDhnJyjv
         oOgadqBVrncMMC9Sbg+pkk1e+EHUTqORupSuqO4Y8+kLLgBUP0gVRszzhC6BNdmppWo2
         nmvWe52/X3i0Wit6fR0/vMEQslgItNLU94Ud4d03WQ6ZcayOs8fK8suSzEfplinfnOyv
         Nm2FLYMvz7L2oWyC0ebVR+VMwPInQI1U9oVs2i+AdZqmQE4q3jVJb7dm/f31yqgK1u4q
         FOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6Zu+rp2wCwzsomTmeAznU3Xcy8b37OGWL83J8MuNrIk=;
        fh=3j0hKJDXpHInd9v06g9iPBFJfogXGMCSqODNzeKRXzI=;
        b=mJs154S1n4QlVWLPtB+dMf4ZcRkLOfD9psgn2sXwFmACG5jmrXqu+3f7Xjpv2Fs9MD
         WL75n+MMY5k2pzU9akRKW+Dj0uO3HJECUlDSzTMNmv0RTIbuJcv05Nl1RLW098Wp8e1X
         b0SWQPgvUotoj3VH8v2pu6O0mTkJIGUxurww0RObNbxDSbgpF9V/3xfGqKCWIO4jilOW
         GsbWuzbkVC5ywMxfzm7iUWNvCujWZkWa9JdQwjs9/9kNsmq5ZG/EiWYBwREu33NDASCk
         ubNWFBR08+lR+7mnyz0NeMr4gSegx1QT3Y6B+Ehq+5R/Rkde7D0DmhJaUiqM2mD5y2YV
         3o6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575457; x=1790180257; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Zu+rp2wCwzsomTmeAznU3Xcy8b37OGWL83J8MuNrIk=;
        b=Dp3ZaW/8QEad4OSbVdy2sChID5TaFM+je1iV6md+5x0cpdIlnzypeuZjIhhvjN38ZM
         7RWZhgyFDojeiQgSorRlq8CbPuuecLP9x/rbAYtiFBYOeOzTz8TZT/6n42Tbve3/Pex9
         JLSYMkXfGzoEldubpG2g15pIvfILJ8AJ7mTqP87PZAQ2R07vR5HtKR3IFR5nsAJMOw2n
         tNQveYrn7pySdnEpxcTPz3FFHtKTN0z5qmcJmh15NpN38WMGKwNCJif5mWMdmGL7Dlbr
         5kidsfirHxIDmhIZ7Oosjha82MLDWdAFhoQXpNCAKaziI5J0i19cTyHoO/dfk03GmzUk
         rgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575457; x=1790180257;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Zu+rp2wCwzsomTmeAznU3Xcy8b37OGWL83J8MuNrIk=;
        b=ksoSa6WT/PHO31YaGI0SkQEoarRMp0gL79KffltQ/wmVQyVftXa18QJZCHV+ZmdkWe
         tkE3P12dNXEbK3u4YgJaC93ZRy7SeYL4M0x6EFoYKnaMQDS2coObotA6q/BZLYLHPSjY
         2y8ZQLNUZ9ZM1P1V5bqJ4A5IASr4UtvsMcc9YnmBR0PGSK/1Je+a2jL0dsNA3hy2EEgR
         dj/17P18e7ZsKtasu2XsVcNH8IF7lhIGurwEi/xJJ0DNZ0yAdQWPBKjC3FzzO0ZZ826a
         MeOgMt5F0ZGpQkDoMAXIhApXP40uApMWMIdRrHk19D2lNtyiJFxN5BcC+Ngx3WVw87gT
         gANw==
X-Forwarded-Encrypted: i=1; AKwUvBz7z91l3WiE6/kIq7e14o3RlEWTdD6KewQZZB+p0ILrF9XrIZ8SJQN2PnwNFr5n4ZTIGTZAm2sS/z+7vR+IuIw=@vger.kernel.org
X-Gm-Message-State: AFuF++lJmQcairG+drbkTT5Q+x+FU9swA5rA8MKjeiz7Ki++VdEr3KLu
	dGWIom7OC/bgg40LhXisUey2vA20gZ2eIdouUF1W2X5BdbvgHtdYDdoFYMJ+XkMX2/loe8L6A9L
	2IuXKmnwFSJ2ZVeb1beCDZO3Kxt9lsHY=
X-Gm-Gg: AYBFou3Xe8Qoe2ASuW9sL5VJz0xmpsNo2onn1xqsNAEGSiMDH0TvJHa4UDk5mVgRlW6
	PK4qcfMNjpnbrcLa6K7USDRBAo+4QVRzukyW9m7mvyhMGB3JZR3lv+kAlEJjf60S7aCbTwSyc86
	3JIxIH2yDpzlm4sJitxKP28NYUBVEmx2xZWYMfxAN1xdkB3NzfUP+MqfU3xCs/ppexqwbqiU+9w
	2PMwZFuHF+92VM/vDpj28nHKzHUqFcynwKRJn2pAjBmEnE8S9Ou3Z22GzneEFKofLFqmvNJTCtb
	kND0ydSrZuGfcxm6vuF0SCzKSJyg6KvXBp7RLoOLkpeyuYOcUS2rcoxCaF/9BcYy
X-Received: by 2002:a05:690e:4248:b0:668:3d3e:17ce with SMTP id
 956f58d0204a3-6716330d09cmr1083975d50.4.1789575457085; Wed, 16 Sep 2026
 09:17:37 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 16 Sep 2026 11:17:36 -0500
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 16 Sep 2026 11:17:36 -0500
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20260915100938.1337401-1-mkchauras@gmail.com>
References: <20260915100938.1337401-1-mkchauras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Sep 2026 11:17:36 -0500
X-Gm-Features: AcwNN1Vix9N3Wt5oSO53Rrr7xZRS3mS3LSXn__U97oCPVBZRtBhbEn6_Ltb1Tek
Message-ID: <CAPAsAGwUnRncpGr47Pq2y7+7AOiGUu4d1FQNnXow4b78kYGMHg@mail.gmail.com>
Subject: Re: [PATCH V3] powerpc/kasan: require memintrinsic prefix support for KASAN
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com, 
	nikhilks@linux.ibm.com, mahesh@linux.ibm.com, robh@kernel.org, 
	sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> writes:

Hi,
I fed this patch to an AI for review, and the review results are included below.
Please take a look. From my side, I agree with all of the points
raised by AI in the
review, and I think they all need to be addressed. There is also a diff with
the suggested changes at the very end of this mail.


> powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
> infrastructure relies on the compiler emitting __asan_mem*() calls at
> instrumented mem*() sites rather than plain memset/memcpy/memmove, so
> that entry/exit paths calling those functions are not instrumented.
>
> [ ... ]
>
> When GENERIC_ENTRY is set, both guards suppress the C wrappers for
> memset/memcpy/memmove and the __underlying_mem*() redirections. This
> is only safe when the compiler supports the prefixed __asan_mem*()
> intrinsics. On older toolchains (e.g. GCC 9) that lack this support,
> plain mem*() calls from instrumented code fall through to the raw
> assembly implementations in mem_64.S / copy_32.S, completely bypassing
> the KASAN shadow check.
>
> Other arches with GENERIC_ENTRY (x86, s390, loongarch, riscv) do not
> hit this because their CI toolchains are always new enough to support
> the prefix flag.
>
> [ ... ]
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

The thread in the Closes: link is about an early boot hang, but the
commit message only describes mem*() calls bypassing the shadow check.
Bypassed checks would lose coverage, not hang the machine.  Is the
mechanism of the hang understood?

Looking at the state before this commit, the !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
macros that bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") added to
asm/kasan.h emit two ELFv2 global entry points back to back:

  #define _GLOBAL_TOC_KASAN(fn)
          _GLOBAL_TOC(fn);
          _GLOBAL_TOC(__##fn)

With the _GLOBAL_TOC() definition from asm/ppc_asm.h that expands, for
memcpy_64.S, to:

  memcpy:
  0:      addis r2,r12,(.TOC.-0b)@ha
          addi  r2,r2,(.TOC.-0b)@l
          .localentry memcpy,.-memcpy       <- local entry is memcpy+8
  __memcpy:
  0:      addis r2,r12,(.TOC.-0b)@ha        <- this is memcpy+8
          addi  r2,r2,(.TOC.-0b)@l
          .localentry __memcpy,.-__memcpy

Assembling exactly that for powerpc64le gives memcpy st_other 0x60
(local entry offset 8), and memcpy+8 is the __memcpy TOC prologue.

Every same-TOC caller of memcpy() or memmove() is resolved by the
linker to the local entry, so it lands on that second prologue with r12
holding whatever the caller left there, and returns with r2 pointing
at garbage.  Same-TOC callers do not reload r2 after the call.  With
GENERIC_ENTRY, mm/kasan/shadow.c no longer provides memcpy(), so on a
toolchain without the prefix parameter every instrumented file calls
the memcpy symbol directly and hits this.  That matches an early hang
that only shows up with GCC 9.

This commit makes the hang go away because the dual-entry macro is
deleted, but the commit message attributes the fix to something else.
Could the message describe the r2 corruption, and since this repairs a
regression from the GENERIC_ENTRY conversion, should it carry:

  Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")

On the claim that other GENERIC_ENTRY architectures "do not hit this
because their CI toolchains are always new enough": x86, s390, riscv
and loongarch with GCC 8 to 12 build exactly the same configuration,
CONFIG_KASAN=y without CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, and
run with mem*() unchecked.  scripts/Makefile.kasan documents that as
the intended behaviour:

  # Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
  # instead. With compilers that don't support this option, compiler-inserted
  # memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.

and mm/kasan/kasan_test_c.c skips the affected tests with "Test
requires checked mem*()".  So the situation the message describes is
the accepted upstream state for old toolchains, not something specific
to powerpc.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..b27ed9739eea 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -7,6 +7,10 @@ config CC_HAS_ELFV2
>  config CC_HAS_PREFIXED
>  	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
>
> +config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> +		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
> +
>  config CC_HAS_PCREL
>  	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
>  	# where pcrel code is not generated if -msoft-float, -mno-altivec, or

[ ... ]

> @@ -220,9 +224,9 @@ config PPC
>  	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> -	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
> -	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
> -	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
> +	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>  	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KCSAN
>  	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC

This drops KASAN from powerpc entirely for GCC 8 through 12, which are
inside the supported range in Documentation/process/changes.rst (GNU C
8.1 minimum).  An existing .config with CONFIG_KASAN=y silently loses
it on olddefconfig once HAVE_ARCH_KASAN is no longer selected.

Given that the actual breakage is the broken memcpy/memmove entry
points, is it necessary to go this far?  Keeping one _GLOBAL_TOC()
prologue for __memcpy and making memcpy a plain alias of it (a second
label plus a matching .localentry, or a global entry that branches to
__memcpy) would restore the pre-GENERIC_ENTRY behaviour, with mem*()
unchecked on old compilers exactly like the other GENERIC_ENTRY
architectures.  That also keeps a Fixes-tagged backport candidate from
removing a feature on stable kernels.


> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index a690e7da53c2..d62756b87ba4 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -2,20 +2,9 @@
>  #ifndef __ASM_KASAN_H
>  #define __ASM_KASAN_H
>
> -#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
> -#define _GLOBAL_KASAN(fn)			\
> -	_GLOBAL(fn);				\
> -	_GLOBAL(__##fn)
> -#define _GLOBAL_TOC_KASAN(fn)			\
> -	_GLOBAL_TOC(fn);			\
> -	_GLOBAL_TOC(__##fn)
> -#define EXPORT_SYMBOL_KASAN(fn)			\
> -	EXPORT_SYMBOL(__##fn)
> -#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>  #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
>  #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
>  #define EXPORT_SYMBOL_KASAN(fn)
> -#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>
>  #ifndef __ASSEMBLER__
>

this isn't a bug, but after this change _GLOBAL_KASAN(), _GLOBAL_TOC_KASAN()
and EXPORT_SYMBOL_KASAN() are unconditional identity macros with a single
empty one.  Should the five users in mem_64.S, memcpy_64.S and copy_32.S
switch to _GLOBAL()/_GLOBAL_TOC() and the macros go away?

Related leftover: arch/powerpc/kernel/prom_init_check.sh still has

  has_renamed_memintrinsics()
  {
          grep -q "^CONFIG_KASAN=y$" "${KCONFIG_CONFIG}" && \
                  ! grep -q
"^CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y" "${KCONFIG_CONFIG}"
  }

  if has_renamed_memintrinsics
  then
          MEM_FUNCS="__memcpy __memset"

which can no longer be true on powerpc after this commit.  Should that
branch be removed in the same cleanup?

> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 1981bd4036b5..72b5c93a2b84 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -29,29 +29,10 @@ extern void * memchr(const void *,int,__kernel_size_t);
>  void memcpy_flushcache(void *dest, const void *src, size_t size);
>
>  #ifdef CONFIG_KASAN
> -/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
> -#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +/* Used by mm/kasan/shadow.c as raw backends to bypass KASAN checking. */
>  #define __memset memset

this isn't a bug, but the new comment names only mm/kasan/shadow.c.
The same __memset()/__memcpy() names are used by mm/kasan/generic.c as
well (DEFINE_ASAN_SET_SHADOW() and release_alloc_meta()), so would
"used by mm/kasan as raw backends" be more accurate?


---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b27ed9739eea..2580e27e4328 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -7,10 +7,6 @@ config CC_HAS_ELFV2
 config CC_HAS_PREFIXED
 	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)

-config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
-	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address
-mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
-		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param
asan-kernel-mem-intrinsic-prefix=1))
-
 config CC_HAS_PCREL
 	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
 	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
@@ -224,9 +220,9 @@ config PPC
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
-	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 &&
PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
-	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU &&
PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
-	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 &&
PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
+	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
+	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
 	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index d62756b87ba4..599a9e02af02 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -2,10 +2,6 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H

-#define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
-#define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
-#define EXPORT_SYMBOL_KASAN(fn)
-
 #ifndef __ASSEMBLER__

 #include <asm/page.h>
diff --git a/arch/powerpc/kernel/prom_init_check.sh
b/arch/powerpc/kernel/prom_init_check.sh
index 3090b97258ae..3155cc722e48 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -13,21 +13,8 @@
 # If you really need to reference something from prom_init.o add
 # it to the list below:

-has_renamed_memintrinsics()
-{
-	grep -q "^CONFIG_KASAN=y$" "${KCONFIG_CONFIG}" && \
-		! grep -q "^CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y" "${KCONFIG_CONFIG}"
-}
-
-if has_renamed_memintrinsics
-then
-	MEM_FUNCS="__memcpy __memset"
-else
-	MEM_FUNCS="memcpy memset"
-fi
-
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
-_end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
+_end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 logo_linux_clut224 btext_prepare_BAT
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 933b685e7ab6..97eb9ca0cc23 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -10,7 +10,6 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/code-patching-asm.h>
-#include <asm/kasan.h>

 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -87,7 +86,7 @@ EXPORT_SYMBOL(memset16)
  * We therefore skip the optimised bloc that uses dcbz. This jump is
  * replaced by a nop once cache is active. This is done in machine_init()
  */
-_GLOBAL_KASAN(memset)
+_GLOBAL(memset)
 	cmplwi	0,r5,4
 	blt	7f

@@ -147,7 +146,6 @@ _GLOBAL_KASAN(memset)
 	bdnz	9b
 	blr
 EXPORT_SYMBOL(memset)
-EXPORT_SYMBOL_KASAN(memset)

 /*
  * This version uses dcbz on the complete cache lines in the
@@ -160,12 +158,12 @@ EXPORT_SYMBOL_KASAN(memset)
  * We therefore jump to generic_memcpy which doesn't use dcbz. This jump is
  * replaced by a nop once cache is active. This is done in machine_init()
  */
-_GLOBAL_KASAN(memmove)
+_GLOBAL(memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	/* fall through */

-_GLOBAL_KASAN(memcpy)
+_GLOBAL(memcpy)
 1:	b	generic_memcpy
 	patch_site	1b, patch__memcpy_nocache

@@ -241,8 +239,6 @@ _GLOBAL_KASAN(memcpy)
 65:	blr
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(memmove)
-EXPORT_SYMBOL_KASAN(memcpy)
-EXPORT_SYMBOL_KASAN(memmove)

 generic_memcpy:
 	srwi.	r7,r5,3
diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index 6fd06cd20faa..40eaedd31486 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -8,7 +8,6 @@
 #include <asm/processor.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
-#include <asm/kasan.h>

 #ifndef CONFIG_KASAN
 _GLOBAL(__memset16)
@@ -29,7 +28,7 @@ EXPORT_SYMBOL(__memset32)
 EXPORT_SYMBOL(__memset64)
 #endif

-_GLOBAL_KASAN(memset)
+_GLOBAL(memset)
 	neg	r0,r3
 	rlwimi	r4,r4,8,16,23
 	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
@@ -95,9 +94,8 @@ _GLOBAL_KASAN(memset)
 	stb	r4,0(r6)
 	blr
 EXPORT_SYMBOL(memset)
-EXPORT_SYMBOL_KASAN(memset)

-_GLOBAL_TOC_KASAN(memmove)
+_GLOBAL_TOC(memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	b	memcpy
@@ -139,4 +137,3 @@ _GLOBAL(backwards_memcpy)
 	mtctr	r7
 	b	1b
 EXPORT_SYMBOL(memmove)
-EXPORT_SYMBOL_KASAN(memmove)
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index b5a67e20143f..0cedd455231a 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -7,7 +7,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
-#include <asm/kasan.h>

 #ifndef SELFTEST_CASE
 /* For big-endian, 0 == most CPUs, 1 == POWER6, 2 == Cell */
@@ -15,7 +14,7 @@
 #endif

 	.align	7
-_GLOBAL_TOC_KASAN(memcpy)
+_GLOBAL_TOC(memcpy)
 BEGIN_FTR_SECTION
 #ifdef __LITTLE_ENDIAN__
 	cmpdi	cr7,r5,0
@@ -227,4 +226,3 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	blr
 #endif
 EXPORT_SYMBOL(memcpy)
-EXPORT_SYMBOL_KASAN(memcpy)
