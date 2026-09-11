Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124744A68A0
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150011; cv=none; b=UJ8v0tpRCdU/oGaZCGHWlaOlv2/6hYHZRZI8qtR8wS2/DUni5nqqTsrY9lMNjkWllNBOfXxpezqwkedsweNTIN6UhWt9+ERXU7dryVz5pVqbwVgeM3AHGl1jbCA+FR4TWQP8d6/W4nUIEFIyW4AtBUxkfLXhvY56AxFnagtZTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150011; c=relaxed/simple;
	bh=kQwNoRuIOj+YwvTIht2Su2OdhcJfIrI4pdY7rp+2EK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnDbW/+vb9QenBQXdgmUH5R5V5DATFpeQNJ3z/aVgL95NnKdQZPsrq9LtYBGRcwFfXjUyKOFqT5EaH+3bpIBG3bvaWNDyE/x6U8rYu8RfYmztk2YKXxbMQPhwl2dYsCITZfO1vprP9CUwM1Z/DRztUsggsrLCBg/ZaFdmkALs9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shIv3mvh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shIv3mvh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so67702a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150007; x=1789754807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jo2uzj/N171DScFnL7iq1Y1nF9wLs6WiaF8JUd+T4Ro=;
        b=shIv3mvh3JGbML4jYnVT6ljh57om36s7YmC1/OmoaEDNjm07JCo3SzfCctxIlfnDKe
         t7U3V0DiMRuczNgPg90SkehpgbTXY+w58aue8QENJnQ8d94ZeEJxwcyrg83YXsGGgx6I
         D4wj+PUp/HwfNi5KbGlRaaHSZJdI1RF1kdXTQHlalrX5MMTKp5eIRgIDnkp8F19cOScj
         TWzXT9nSc1CNKTBhHTOaN3L6wG95aHaA3ZduiyV2hZZJJL1UcUzJ57Ul+RWapBrIKY2t
         jKM6/nxbWxMWdRYf67NK9iCz4ieEjVnCo7214brlJnxje0VBj2vfv6NKj4KI7sz7JQXm
         bPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150007; x=1789754807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jo2uzj/N171DScFnL7iq1Y1nF9wLs6WiaF8JUd+T4Ro=;
        b=Jw3/V1f2dYXvhIPtm4dRXgSuMN3zmpyXR9Er/U8q9zwa7ZLGMP02fmAwGUL9mv/6K9
         Tszk2GegsydcyS1ZIEVzj/QKVFjhoANpDCdY7UF7vf8dCmlcJU35mu++OKKImcGDPUbm
         SrGiZA766rEfm7cKfsygjT0o3hxkUH9nBN6N1i1edhjWUpOlNcOnUbAxbg4Z86PhPclw
         MD72A9vSvMaMoYSt8ug5BxQC72kCdg3TzodxqPIW37WXxupiGiXeOGB8Bt2iW4DePJ/+
         0r5VNr0uRSwmkNtCdgqNugWE0VIDMvM6IIjcS95Rn/eR9RBT39CqBvuPVKiOVzE82YcY
         8STQ==
X-Forwarded-Encrypted: i=1; AKwUvBwg7ZQPFfZpUfccZh0bBm9fj6gu04rTjjPPymFWlWLi80JzIt7eZE1Vw5kUDA86TtvM3cIDkGrIF1I8IXZkN58=@vger.kernel.org
X-Gm-Message-State: AFuF++kD9B/+LbFVdAcUjuS2QdU9txbbQIOQH2Omau5qWhSHtdmEtC1D
	Vf5feUVD5BnBQOLCs+9AtCQMgvwWoosaMa+79XPkPhTwWlaPMzcJWGfg
X-Gm-Gg: AYBFou2feWR5bVxbAtL5V3Wn/P5jhVtZnNiOzuyl6WmH8PMsHGKGYq8ewEbQkiifkGl
	ZqD/rS80oJ/4fkUkuTUzsgiyyqTp1ckpYlwFmuxHKwAxUUwkNDKM2bwsw2mC9NDJBys/FWpTrRe
	z9sA1U14RLQF3raD1mtomZvXo13LgNcIYsDxBFINa28G7yOdKXWLcNjTKQeBSiVJD+DM0VEXJ6M
	2SfngFvUQYalNTv5nXeyP1dbLqjVNlrADwh4yjNYM8a5vpKNvS//vfQu6X6eSRD5QNO/0nUCITy
	SwGx21VBbSXJUi1D5yicWHCEoDjR/aJyCnfJKGokhUEEwUC762x/Nowt2+H23sm9xakVpDn6s7j
	WYosu7keG0ZiX+ByH2D0o4YQIFFP8YDRWiP7e4mUfUPRai1IMqLsihftEvKnRIBlf6x2lgPknle
	j7gTMHdB+cVc0mJQEK6TMIQrLX//Hv+IfWeTZgCnZ+CYubnxP6lLOgVnhEjDgEWJsA06t6INYVO
	i6KwjMYC49WL27Xu33ccL9GrWdW3/5u8N6KgYTtZXeVVARsQFA=
X-Received: by 2002:a17:90b:4fc9:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-39d9bbfc338mr9687313a91.4.1789150006816;
        Fri, 11 Sep 2026 11:06:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm8806721c88.7.2026.09.11.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:06:46 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kees@kernel.org,
	mkchauras@gmail.com,
	ritesh.list@gmail.com,
	amachhiw@linux.ibm.com,
	mahesh@linux.ibm.com,
	nikhilks@linux.ibm.com,
	robh@kernel.org,
	sayalip@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V2] powerpc/kasan: require memintrinsic prefix support for KASAN
Date: Fri, 11 Sep 2026 23:35:37 +0530
Message-ID: <20260911180536.3234640-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
infrastructure relies on the compiler emitting __asan_mem*() calls at
instrumented mem*() sites rather than plain memset/memcpy/memmove, so
that entry/exit paths calling those functions are not instrumented.

This assumption is encoded in two places:

  mm/kasan/shadow.c:
    #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
        !defined(CONFIG_GENERIC_ENTRY)

  include/linux/fortify-string.h:
    #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
        !defined(CONFIG_GENERIC_ENTRY)

When GENERIC_ENTRY is set, both guards suppress the C wrappers for
memset/memcpy/memmove and the __underlying_mem*() redirections. This
is only safe when the compiler supports the prefixed __asan_mem*()
intrinsics. On older toolchains (e.g. GCC 9) that lack this support,
plain mem*() calls from instrumented code fall through to the raw
assembly implementations in mem_64.S / copy_32.S, completely bypassing
the KASAN shadow check.

Other arches with GENERIC_ENTRY (x86, s390, loongarch, riscv) do not
hit this because their CI toolchains are always new enough to support
the prefix flag.

Background: the !GENERIC_ENTRY guard was introduced by commit 69d4c0d32186
("entry, kasan, x86: Disallow overriding mem*() functions", Peter Zijlstra,
Jan 2023). The root problem is that the KASAN C wrappers override the
linker symbol memset/memcpy/memmove globally, so any call from noinstr or
__no_sanitize_address code (e.g. irqentry_enter/irqentry_exit) would still
reach the KASAN shadow-check wrapper -- at a point where KASAN invariants
may not hold. The compiler prefix approach (Marco Elver, Feb 2023,
commit 51287dcb00cc) solves this by having the compiler emit __asan_memset
at instrumented call sites and bare memset inside __no_sanitize_address
functions, splitting the decision at code-generation time rather than at
link time.

A manual C-level override cannot replicate this split: a single linker
symbol cannot be made to resolve differently depending on the caller.

x86 also placed its raw memset/memcpy/memmove implementations in
.noinstr.text (same commit, 69d4c0d32186), which is the other half of
the fix: noinstr callers hit the raw assembly directly, safely bypassing
KASAN. PowerPC has not done this. Placing mem_64.S / memcpy_64.S /
copy_32.S implementations in .noinstr.text would be the complementary
long-term fix that could re-enable KASAN on older toolchains, but it
requires care around linker stub overflow on large PPC64 kernels (the
same reason powerpc uses NOKPROBE_SYMBOL rather than noinstr for its
interrupt handlers -- see the comment in asm/interrupt.h). That work
is left as a follow-up.

For now, introduce PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, an arch-local
compiler probe that mirrors the same check as CC_HAS_KASAN_MEMINTRINSIC_PREFIX
in lib/Kconfig.kasan but lives outside the 'if KASAN' block to avoid a
recursive dependency (CC_HAS_KASAN_MEMINTRINSIC_PREFIX depends on KASAN
which depends on HAVE_ARCH_KASAN). Gate the three HAVE_ARCH_KASAN selects
on this new symbol so that KASAN is not offered as a config option on
toolchains that cannot support it correctly with GENERIC_ENTRY.

Since KASAN on powerpc now unconditionally implies
CC_HAS_KASAN_MEMINTRINSIC_PREFIX, the old !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
code paths in asm/kasan.h and asm/string.h are dead. Clean them up:

- asm/kasan.h: remove the dual-entry-point variant of _GLOBAL_KASAN /
  _GLOBAL_TOC_KASAN / EXPORT_SYMBOL_KASAN that emitted both memset and
  __memset as entry points to the same assembly. These aliases were only
  needed so the C KASAN wrappers in shadow.c could call __memset() to
  reach raw memory ops; with the compiler prefix approach those wrappers
  are not used for mem* on powerpc.

- asm/string.h: remove the separate __memset/__memcpy/__memmove symbol
  declarations and the memset/memcpy/memmove macro redirections for
  uninstrumented files that were needed on old toolchains. Simplify the
  CONFIG_KASAN block to just the three #define aliases (still used by
  shadow.c as raw backends to bypass KASAN checking).

- cputable.c, prom_init.c: the original comments said "use memcpy() so
  GCC emits __memcpy() under KASAN". The real reason is that these run
  pre-relocation: the destination pointer is PTRRELOC-adjusted to its
  current physical address, and the kernel is loaded at a different
  address than it was linked at. A struct assignment (*t = *s) may cause
  the compiler to emit an implicit memcpy() call that resolves through
  the unrelocated virtual symbol address -- before the MMU mapping is set
  up -- jumping to garbage. An explicit memcpy(t, ...) uses the already-
  corrected pointer and is safe. Update the comments accordingly.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
Changelog:

V1 -> V2:
	- Comments reworded
	- Commit message reworded
V1: https://lore.kernel.org/all/20260908064948.999530-1-mkchauras@gmail.com

 arch/powerpc/Kconfig              | 10 +++++++---
 arch/powerpc/include/asm/kasan.h  | 11 -----------
 arch/powerpc/include/asm/string.h | 21 +--------------------
 arch/powerpc/kernel/cputable.c    | 14 +++++++++++---
 arch/powerpc/kernel/prom_init.c   | 10 ++++++----
 5 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..b27ed9739eea 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -7,6 +7,10 @@ config CC_HAS_ELFV2
 config CC_HAS_PREFIXED
 	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
 
+config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
+
 config CC_HAS_PCREL
 	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
 	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
@@ -220,9 +224,9 @@ config PPC
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
-	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
-	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
-	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
+	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
 	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index a690e7da53c2..d62756b87ba4 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -2,20 +2,9 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
-#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
-#define _GLOBAL_KASAN(fn)			\
-	_GLOBAL(fn);				\
-	_GLOBAL(__##fn)
-#define _GLOBAL_TOC_KASAN(fn)			\
-	_GLOBAL_TOC(fn);			\
-	_GLOBAL_TOC(__##fn)
-#define EXPORT_SYMBOL_KASAN(fn)			\
-	EXPORT_SYMBOL(__##fn)
-#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
 #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
 #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
 #define EXPORT_SYMBOL_KASAN(fn)
-#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 1981bd4036b5..72b5c93a2b84 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -29,29 +29,10 @@ extern void * memchr(const void *,int,__kernel_size_t);
 void memcpy_flushcache(void *dest, const void *src, size_t size);
 
 #ifdef CONFIG_KASAN
-/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
-#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+/* Used by mm/kasan/shadow.c as raw backends to bypass KASAN checking. */
 #define __memset memset
 #define __memcpy memcpy
 #define __memmove memmove
-#else /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
-void *__memset(void *s, int c, __kernel_size_t count);
-void *__memcpy(void *to, const void *from, __kernel_size_t n);
-void *__memmove(void *to, const void *from, __kernel_size_t n);
-#ifndef __SANITIZE_ADDRESS__
-/*
- * For files that are not instrumented (e.g. mm/slub.c) we
- * should use not instrumented version of mem* functions.
- */
-#define memcpy(dst, src, len) __memcpy(dst, src, len)
-#define memmove(dst, src, len) __memmove(dst, src, len)
-#define memset(s, c, n) __memset(s, c, n)
-
-#ifndef __NO_FORTIFY
-#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
-#endif
-#endif /* !__SANITIZE_ADDRESS__ */
-#endif /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
 #endif /* CONFIG_KASAN */
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6f6801da9dc1..233b5c650d1e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -36,8 +36,12 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
 
 	t = PTRRELOC(t);
 	/*
-	 * use memcpy() instead of *t = *s so that GCC replaces it
-	 * by __memcpy() when KASAN is active
+	 * Use memcpy() instead of *t = *s because t is a PTRRELOC-adjusted
+	 * pointer and this code runs before the MMU mapping is established.
+	 * A struct assignment is a compiler-generated aggregate copy whose
+	 * implementation is not under our control in relocation-sensitive code;
+	 * memcpy() ensures the adjusted pointer is explicitly passed to the
+	 * copy routine.
 	 */
 	memcpy(t, s, sizeof(*t));
 
@@ -55,7 +59,11 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 
 	/*
 	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
-	 * so that GCC replaces it by __memcpy() when KASAN is active
+	 * because t is a PTRRELOC-adjusted pointer and this code runs before
+	 * the MMU mapping is established. A struct assignment is a
+	 * compiler-generated aggregate copy whose implementation is not under
+	 * our control in relocation-sensitive code; memcpy() ensures the
+	 * adjusted pointer is explicitly passed to the copy routine.
 	 */
 	memcpy(t, s, sizeof(*t));
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eb9f556b0937..d6d7f1ede319 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1363,10 +1363,12 @@ static void __init prom_check_platform_support(void)
 				       "ibm,arch-vec-5-platform-support");
 
 	/*
-	 * First copy the architecture vec template
-	 *
-	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
-	 * by __memcpy() when KASAN is active
+	 * First copy the architecture vec template. Use memcpy() instead of
+	 * a struct assignment because this code runs before the MMU mapping
+	 * is established. A struct assignment is a compiler-generated
+	 * aggregate copy whose implementation is not under our control in
+	 * relocation-sensitive code; memcpy() ensures the adjusted pointer
+	 * is explicitly passed to the copy routine.
 	 */
 	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
 	       sizeof(ibm_architecture_vec));
-- 
2.55.0

