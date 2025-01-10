Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527A20E031;
	Fri, 10 Jan 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517926; cv=none; b=VOyfQTyzB2bIPnqvJlN+IbOHRPuT6T2DFxkD1Don8dOht61fxUV6pNQLcgz1Mk4ma0epB2Cx+KDObFyMpIRaTrFJcc+W2KqKhal99bLzwmeytYpgIzzCeE65rdHRIYmhYUQ3/EXPSMuyZRV9fFpsqs6afouNcKFbsIteZ21grko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517926; c=relaxed/simple;
	bh=HEGFvFEjeM3iTMV//DBspEI97aSXsu+WT+P2HkyrtWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTHNawCyVrzTpJxgs6uIzVfWtLxq1Ho80qonpaeDRzPA2QhwhWtGthT6lHUwUnlkUiH1+pm7u4IpNpDgwXgHQbbf7KAUXFi4yraCQIMb9cxH8HFBoflBjyW2h2b+/9OHgmj+u33MDo7KDrlLIcwSgmu29BwhrCDDRa9ZuIbT/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68537204C;
	Fri, 10 Jan 2025 06:05:52 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E17B63F59E;
	Fri, 10 Jan 2025 06:05:18 -0800 (PST)
Message-ID: <705c7fec-8e3c-4d4d-b3c2-c1f75d10db42@arm.com>
Date: Fri, 10 Jan 2025 15:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/15] arm64: mm: Guard page table writes with
 kpkeys
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org
References: <20250108103250.3188419-1-kevin.brodsky@arm.com>
 <20250108103250.3188419-14-kevin.brodsky@arm.com>
 <6b4c4abb-8d53-4b17-8a1c-1d28fb4d5f88@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <6b4c4abb-8d53-4b17-8a1c-1d28fb4d5f88@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/01/2025 08:17, Qi Zheng wrote:
> [...]
>
>> @@ -314,6 +315,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
>>     static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
>>   {
>> +    guard(kpkeys_hardened_pgtables)();
>>       WRITE_ONCE(*ptep, pte);
>>   }
>>   @@ -758,6 +760,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>       }
>>   #endif /* __PAGETABLE_PMD_FOLDED */
>>   +    guard(kpkeys_hardened_pgtables)();
>>       WRITE_ONCE(*pmdp, pmd);
>>         if (pmd_valid(pmd)) {
>
> I noticed a long time ago that set_pte/set_pmd/... was implemented
> separately by each architecture without a unified entry point. This
> makes it difficult to add some hooks for them.
>
> Taking set_pte() as an example, is it possible to do the following:
>
> 1) add a generic set_pte() in include/asm-generic/tlb.h (Or other more
>    appropriate files)
>
> static inline void set_pte(pte_t *ptep, pte_t pte)
> {
>     arch_set_pte(ptep, pte);
> }
>
> 2) let each architecture include this file and rename the original
>    set_pte() to arch_set_pte().
>
> 3) then we can add hooks for generic set_pte():
>
> static inline void set_pte(pte_t *ptep, pte_t pte)
> {
>     guard(kpkeys_hardened_pgtables)();
>     arch_set_pte(ptep, pte);
> }
>
> 4) in this way, the architecture that supports
>    ARCH_HAS_KPKEYS_HARDENED_PGTABLES only needs to implement
>    the kpkeys_hardened_pgtables(), otherwise it is no-op.

Thanks for chiming in, it is an interesting idea for sure. I think the
issue here might be the benefit/churn ratio, because this would simply
be adding a layer of (generic) function calls without unifying any
existing arch code. Unfortunately, unlike the pagetable_alloc/tlb stuff,
the majority of what happens in the page table modifiers is arch-specific.

For set_p*(), we could potentially have it call a generic __set_p*()
that does a WRITE_ONCE(), which is what most architectures do (in
addition to various other things, like DSB/ISB on arm64). Adding the
kpkeys_hardened_pgtables guard there would be better, as it reduces the
"privileged" window to just the write itself. However for the other
modifiers, say ptep_get_and_clear(), the implementation seems to vary
wildly between arch's, including the atomic operation itself. Any
unification of those seems therefore difficult.

That said, I'd be happy to look into adding that generic layer on top
(i.e. generic set_pte() calls arch_set_pte()) if there is enough
consensus that the churn is justified. We could potentially do a mix of
both as well (arch-defined set_pte() calls generic __set_pte(), while
generic ptep_get_and_clear() calls arch_ptep_get_and_clear()).

- Kevin
