Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486393FC5AE;
	Tue,  8 Sep 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856770; cv=none; b=o8a7GHu+vUNIsltAbd8VtHi73amO1m06SQW5Rbgo/Gi4Hua1DJ6N+HXqSKOszZz5TuI14/4jcwztZB99Xxy/nRYCR5UDBvJCld/Zzkyhqcicfo5u4WVl2EC6helKzkiANQznQKMAAludA0z9dBt+qLXonGXilmbv1FPF8qTil9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856770; c=relaxed/simple;
	bh=zVLRKeBH7K7wGgAIZyS+pr6gbJVwFHDI/n54RSmSJNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CQpqmz50++bfe183ScDQPGnAzwac0XeApIx1jv+HAZHtdNKgxCyw2SF6BvGAIbT14aR9syPtwDOW/Ze+4EUReBU4shRZVWocr3V93mk00Ax4Yaoz/j8mgz65mWazr5tKffrapS7EPPA/Sd1eLbQDL1v0ixOUNrQ8cCpaiZu+CZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sF5VX0hN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sF5VX0hN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VV4Q059071;
	Tue, 8 Sep 2026 08:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qmk/uF
	xG6UZsoN3YHewjB0wTeXEwa2laKfVPw6Owh68=; b=sF5VX0hNsojdO0SOLQYN9I
	stdcRuSb2YrNybzTaFnRffgcxi7IsK2yKkHEg2Uc/6f/GgB2r5OcSreT8J8oPAuZ
	xQ+3aN0S4CEOV1O1ZFVUWthYvPeAKrLRbT9R4IKnrbOEGY9EQ6+S1af7eEsRsXTD
	cxA7j7Zs9m9rJR0dBU5mvbS/ogJ/DQDbryA+WtdHhBbtkw3OpfazoLDLmPmTsPDA
	dhM8Ct0kHCDRQOond14ZMJnTmlIj4mhku0yBGJWh/IODjb97OdjyWgv5AZu9z4S/
	3k9LFFjfEzEMq6vFaGl/BC3TqEitUukXOIH3RBuz48v1EdayQS8CI4W/2rMYUQSQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhknp8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:39:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6888QP7o008932;
	Tue, 8 Sep 2026 08:39:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjtq05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:39:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6888d15n3605128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 08:39:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D548658059;
	Tue,  8 Sep 2026 08:39:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B7A558053;
	Tue,  8 Sep 2026 08:38:54 +0000 (GMT)
Received: from [9.123.0.173] (unknown [9.123.0.173])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 08:38:54 +0000 (GMT)
Message-ID: <cc627675-5965-4b44-a8d9-f1a1ba573ce8@linux.ibm.com>
Date: Tue, 8 Sep 2026 14:08:52 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kasan: require memintrinsic prefix support for
 KASAN
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com,
        robh@kernel.org, sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260908064948.999530-1-mkchauras@gmail.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260908064948.999530-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfX6DJahdYbhYPQ
 bQv+UpCDjO5hbLgBesQZ1mvaxdButDyXooOQG6vNVWWX8HnI6dbxAQGj/xO9L5AiRQRAh33ISy9
 HKL9NXwJPtxqYkyARS9dqZIOM+2AxOc=
X-Proofpoint-ORIG-GUID: FapW2mBzYGIG6AZTOu0d6SaG1BDAn1uw
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9fc9a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=_8Nosw70jV9MYaWHQ6gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfX3p+NsDdDZJil
 uY9LCCyWguOIsKHuql3c1356cEyrK21U8K2uk/ua9Nn0uwgb9GSydIvOOY1Uu0LULV/V37uZQJs
 qQ0iB1antTMLssRhpchGg++vsewsKzRF8PmATB24AkN0PkuD9UNOKHXfEpAGCRhMcF1mMrcrRi5
 LYR+gjbYf9VUyAr7szWyPifcCUUNw5ZrAzaMFB4DfqhbG54A3C6KofHo/6qGy5vUhxg2mKc8Ehk
 /Wei5qA3S6OlDVVvBvDdcJ0lfYj+8SyN2SY0TW4GiHtGkjZGoqBD04f2Yp3mpX5N4AN48Z7EPhU
 wbeksVpoNf7x18xm5DzbXqqXj3RY8qx2sYxWb0sa994SWUuUb+ZoXzfwEuGgLpPTP0G7UkAaQvR
 NDPU5SWKkMC+5epC3V1D0v0PNbthLmuqamPKYl6V2LhRWn5TXfG1g/IUBY5O2d/qFSQ3BA+Bzkd
 XeKQ1tG3Rdw9+w69G0g==
X-Proofpoint-GUID: ifOrqrXjTX6v1iKB3mkWnWdt2-feMegD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080089


On 08/09/26 12:19 pm, Mukesh Kumar Chaurasiya (IBM) wrote:
> powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
> infrastructure relies on the compiler emitting __asan_mem*() calls at
> instrumented mem*() sites rather than plain memset/memcpy/memmove, so
> that entry/exit paths calling those functions are not instrumented.
>
> This assumption is encoded in two places:
>
>    mm/kasan/shadow.c:
>      #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
>          !defined(CONFIG_GENERIC_ENTRY)
>
>    include/linux/fortify-string.h:
>      #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
>          !defined(CONFIG_GENERIC_ENTRY)
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
> Background: the !GENERIC_ENTRY guard was introduced by commit 69d4c0d32186
> ("entry, kasan, x86: Disallow overriding mem*() functions", Peter Zijlstra,
> Jan 2023). The root problem is that the KASAN C wrappers override the
> linker symbol memset/memcpy/memmove globally, so any call from noinstr or
> __no_sanitize_address code (e.g. irqentry_enter/irqentry_exit) would still
> reach the KASAN shadow-check wrapper -- at a point where KASAN invariants
> may not hold. The compiler prefix approach (Marco Elver, Feb 2023,
> commit 51287dcb00cc) solves this by having the compiler emit __asan_memset
> at instrumented call sites and bare memset inside __no_sanitize_address
> functions, splitting the decision at code-generation time rather than at
> link time.
>
> A manual C-level override cannot replicate this split: a single linker
> symbol cannot be made to resolve differently depending on the caller.
>
> x86 also placed its raw memset/memcpy/memmove implementations in
> .noinstr.text (same commit, 69d4c0d32186), which is the other half of
> the fix: noinstr callers hit the raw assembly directly, safely bypassing
> KASAN. PowerPC has not done this. Placing mem_64.S / memcpy_64.S /
> copy_32.S implementations in .noinstr.text would be the complementary
> long-term fix that could re-enable KASAN on older toolchains, but it
> requires care around linker stub overflow on large PPC64 kernels (the
> same reason powerpc uses NOKPROBE_SYMBOL rather than noinstr for its
> interrupt handlers -- see the comment in asm/interrupt.h). That work
> is left as a follow-up.
>
> For now, introduce PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, an arch-local
> compiler probe that mirrors the same check as CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> in lib/Kconfig.kasan but lives outside the 'if KASAN' block to avoid a
> recursive dependency (CC_HAS_KASAN_MEMINTRINSIC_PREFIX depends on KASAN
> which depends on HAVE_ARCH_KASAN). Gate the three HAVE_ARCH_KASAN selects
> on this new symbol so that KASAN is not offered as a config option on
> toolchains that cannot support it correctly with GENERIC_ENTRY.
>
> Since KASAN on powerpc now unconditionally implies
> CC_HAS_KASAN_MEMINTRINSIC_PREFIX, the old !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> code paths in asm/kasan.h and asm/string.h are dead. Clean them up:
>
> - asm/kasan.h: remove the dual-entry-point variant of _GLOBAL_KASAN /
>    _GLOBAL_TOC_KASAN / EXPORT_SYMBOL_KASAN that emitted both memset and
>    __memset as entry points to the same assembly.  These aliases were only
>    needed so the C KASAN wrappers in shadow.c could call __memset() to
>    reach raw memory ops; with the compiler prefix approach the wrappers are
>    not used at all for mem* on powerpc.
>
> - asm/string.h: remove the separate __memset/__memcpy/__memmove symbol
>    declarations and the memset/memcpy/memmove macro redirections for
>    uninstrumented files that were needed on old toolchains.  Simplify the
>    CONFIG_KASAN block to just the three #define aliases (which are still
>    used by shadow.c as raw backends).
>
> - cputable.c, prom_init.c: update stale comments that said GCC replaces
>    memcpy() with __memcpy() under KASAN; with the prefix flag it emits
>    __asan_memcpy() instead.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


>   arch/powerpc/Kconfig              | 10 +++++++---
>   arch/powerpc/include/asm/kasan.h  | 19 ++++++++-----------
>   arch/powerpc/include/asm/string.h | 25 +++++--------------------
>   arch/powerpc/kernel/cputable.c    |  6 +++---
>   arch/powerpc/kernel/prom_init.c   |  4 ++--
>   5 files changed, 25 insertions(+), 39 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..b27ed9739eea 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -7,6 +7,10 @@ config CC_HAS_ELFV2
>   config CC_HAS_PREFIXED
>   	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
>   
> +config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> +		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
> +
>   config CC_HAS_PCREL
>   	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
>   	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
> @@ -220,9 +224,9 @@ config PPC
>   	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> -	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
> -	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
> -	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
> +	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>   	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
>   	select HAVE_ARCH_KCSAN
>   	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index a690e7da53c2..ffada5f51b2b 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -2,20 +2,17 @@
>   #ifndef __ASM_KASAN_H
>   #define __ASM_KASAN_H
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
> +/*
> + * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
> + * enabled (see PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX in arch/powerpc/Kconfig),
> + * so the compiler always emits __asan_mem*() at instrumented call sites and
> + * bare mem*() inside __no_sanitize_address / noinstr code.  The old dual
> + * entry-point trick (_GLOBAL_KASAN emitting both memset and __memset) is
> + * therefore never needed.
> + */
>   #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
>   #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
>   #define EXPORT_SYMBOL_KASAN(fn)
> -#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>   
>   #ifndef __ASSEMBLER__
>   
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 1981bd4036b5..743126e3dcc1 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -29,29 +29,14 @@ extern void * memchr(const void *,int,__kernel_size_t);
>   void memcpy_flushcache(void *dest, const void *src, size_t size);
>   
>   #ifdef CONFIG_KASAN
> -/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
> -#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +/*
> + * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
> + * enabled, so the compiler emits __asan_mem*() at instrumented sites.
> + * The raw mem* symbols are always safe to call directly.
> + */
>   #define __memset memset
>   #define __memcpy memcpy
>   #define __memmove memmove
> -#else /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> -void *__memset(void *s, int c, __kernel_size_t count);
> -void *__memcpy(void *to, const void *from, __kernel_size_t n);
> -void *__memmove(void *to, const void *from, __kernel_size_t n);
> -#ifndef __SANITIZE_ADDRESS__
> -/*
> - * For files that are not instrumented (e.g. mm/slub.c) we
> - * should use not instrumented version of mem* functions.
> - */
> -#define memcpy(dst, src, len) __memcpy(dst, src, len)
> -#define memmove(dst, src, len) __memmove(dst, src, len)
> -#define memset(s, c, n) __memset(s, c, n)
> -
> -#ifndef __NO_FORTIFY
> -#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> -#endif
> -#endif /* !__SANITIZE_ADDRESS__ */
> -#endif /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>   #endif /* CONFIG_KASAN */
>   
>   #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6f6801da9dc1..44115f904c2c 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>   
>   	t = PTRRELOC(t);
>   	/*
> -	 * use memcpy() instead of *t = *s so that GCC replaces it
> -	 * by __memcpy() when KASAN is active
> +	 * use memcpy() instead of *t = *s so that the compiler replaces it
> +	 * by __asan_memcpy() when KASAN is active
>   	 */
>   	memcpy(t, s, sizeof(*t));
>   
> @@ -55,7 +55,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>   
>   	/*
>   	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
> -	 * so that GCC replaces it by __memcpy() when KASAN is active
> +	 * so that the compiler replaces it by __asan_memcpy() when KASAN is active
>   	 */
>   	memcpy(t, s, sizeof(*t));
>   
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index eb9f556b0937..b763720c68b6 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1365,8 +1365,8 @@ static void __init prom_check_platform_support(void)
>   	/*
>   	 * First copy the architecture vec template
>   	 *
> -	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
> -	 * by __memcpy() when KASAN is active
> +	 * use memcpy() instead of *vec = *vec_template so that the compiler
> +	 * replaces it by __asan_memcpy() when KASAN is active
>   	 */
>   	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
>   	       sizeof(ibm_architecture_vec));
