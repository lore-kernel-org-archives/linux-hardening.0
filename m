Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05247337688;
	Tue, 27 Jan 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507927; cv=none; b=Tm8MoztCh4fHr6wFVpyzbUE2Np9dJswCo49HNthukyLZx94c9v7phx+Yi8QgC79fAA6bhet730IFHyiZTWy4YTzOvfyUY8YQYaDslFUtWyNjQj6bWDrQrk8iC+TKisr1jQfVitbqHBMYBA5fLqHknp8xotkzMVDdeo2DJgDNov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507927; c=relaxed/simple;
	bh=S1jzh6zwKSY0EnUb6CU8WJEFF2xmgXSfLhemWcGgQ6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNATWkJA9nkdl1P+KpeDfNBHLP1QcXAg+a3u5iv2NvTvu86NzQ8pK5zN9+QKqLM53gh2JnHcSPocDGLg6iErIV+eG1DBygUOMB561JoCpQ2kjIlCw54FoE8/PbLySLLqOiO9TJfCD9JX6xqY/QC9+066x2UI0eJn5PxdHDWlWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D921595;
	Tue, 27 Jan 2026 01:58:39 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8DA33F73F;
	Tue, 27 Jan 2026 01:58:43 -0800 (PST)
Message-ID: <1f4fcb81-7b29-4e7d-b2af-5fb06f4faaa2@arm.com>
Date: Tue, 27 Jan 2026 09:58:42 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] arm64: mm: Preserve non-contiguous descriptors
 when mapping DRAM
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-17-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-17-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Instead of blindly overwriting existing live entries with the contiguous
> bit cleared when mapping DRAM regions, check whether the contiguous
> region in question starts with a descriptor that has the valid bit set
> and the contiguous bit cleared, and in that case, leave the contiguous
> bit unset on the entire region. This permits the logic of mapping the
> kernel's linear alias to be simplified in a subsequent patch.
> 
> Note that not setting the contiguous bit on any of the descriptors in
> the contiguous region can only result in an invalid configuration if it
> was already invalid to begin with.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/pgtable.h | 4 ++++
>  arch/arm64/mm/mmu.c              | 6 ++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 64d5f1d9cce9..cb2c4525e49a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -224,6 +224,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   * Returns true if the pte is valid and has the contiguous bit set.
>   */
>  #define pte_valid_cont(pte)	(pte_valid(pte) && pte_cont(pte))
> +/*
> + * Returns true if the pte is valid and has the contiguous bit cleared.
> + */
> +#define pte_valid_noncont(pte)	(pte_valid(pte) && !pte_cont(pte))
>  /*
>   * Could the pte be present in the TLB? We must check mm_tlb_flush_pending
>   * so that we don't erroneously return false for pages that have been
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 28cc3cda042c..d7faa98f427c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -230,7 +230,8 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  
>  		/* use a contiguous mapping if the range is suitably aligned */
>  		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		    (flags & NO_CONT_MAPPINGS) == 0 &&
> +		    !pte_valid_noncont(__ptep_get(ptep)))
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
>  		init_pte(ptep, addr, next, phys, __prot);
> @@ -330,7 +331,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  
>  		/* use a contiguous mapping if the range is suitably aligned */
>  		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		    (flags & NO_CONT_MAPPINGS) == 0 &&
> +		    !pte_valid_noncont(pmd_pte(READ_ONCE(*pmdp))))
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
>  		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);

