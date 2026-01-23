Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700530DD10;
	Fri, 23 Jan 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149966; cv=none; b=YuvZs9/X/8BH6B4MsZMprD+UEVMvTTZXgT2qQhudp/NWLGR4n4S1vzd5bwZSFf0euJKzEoDp8goaMvXcLHaD6WtVmsF1oHNU2+Gqhx8f6QIKSwk6llf6M6ohHE9Hj7+yBGvzOrDBHYcWvX7w2iwOi7tStllDiVjOqGRFFZqDSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149966; c=relaxed/simple;
	bh=Xzq1TC59PCeIz1WSmStbCTi4rfKvFaLCVEWteU9HUmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GL1IapeULhR9oNXruMgvUNVQNXrrFl5bV4AtOrHrHUTonQP0VQGYsPFSxi9tfurjoWtI91oabFH3dQzhmUAOS9dkAHw1pchEZNO8Qrv+NjuQYFZpAUZl/WF7GL+4TlDlz+7+8g+65l9iAnwQnyzIfdDX1fZGSt20efKxPFTGOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D8C1476;
	Thu, 22 Jan 2026 22:32:33 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA243F740;
	Thu, 22 Jan 2026 22:32:36 -0800 (PST)
Message-ID: <ac6d150d-69b6-45b0-aed8-445ca846bda8@arm.com>
Date: Fri, 23 Jan 2026 12:02:33 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: Map the kernel data/bss read-only in the
 linear map
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260119164747.1402434-6-ardb+git@google.com>
 <20260119164747.1402434-8-ardb+git@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260119164747.1402434-8-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> On systems where the bootloader adheres to the original arm64 boot
> protocol, the placement of the kernel in the physical address space is
> highly predictable, and this makes the placement of its linear alias in
> the kernel virtual address space equally predictable, given the lack of
> randomization of the linear map.
> 
> The linear aliases of the kernel text and rodata regions are already
> mapped read-only, but the kernel data and bss are mapped read-write in
> this region in this region. This is not needed, so map them read-only as
> well.
> 
> Note that the statically allocated kernel page tables do need to be
> modifiable via the linear map, so leave these mapped read-write.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/mmu.h |  2 +-
>  arch/arm64/kernel/smp.c      |  2 +-
>  arch/arm64/mm/mmu.c          | 14 ++++++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 137a173df1ff..8b64d2fcb228 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -77,7 +77,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  			       unsigned long virt, phys_addr_t size,
>  			       pgprot_t prot, bool page_mappings_only);
>  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
> -extern void mark_linear_text_alias_ro(void);
> +extern void remap_linear_kernel_alias(void);
>  extern int split_kernel_leaf_mapping(unsigned long start, unsigned long end);
>  extern void linear_map_maybe_split_to_ptes(void);
>  
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1aa324104afb..b5f888ab5d17 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -441,7 +441,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  	hyp_mode_check();
>  	setup_system_features();
>  	setup_user_features();
> -	mark_linear_text_alias_ro();
> +	remap_linear_kernel_alias();

Both kernel text/rodat and now the bss segment are mapped via PAGE_KERNEL_RO.
Hence the new name here should still have __ro at the end as well.

>  }
>  
>  void __init smp_prepare_boot_cpu(void)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8e1d80a7033e..2a18637ecc15 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1023,14 +1023,24 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>  				 prot, early_pgtable_alloc, flags);
>  }
>  
> -void __init mark_linear_text_alias_ro(void)
> +static void remap_linear_data_alias(void)
> +{
> +	extern const u8 __pgdir_start[];
> +
> +	update_mapping_prot(__pa_symbol(__init_end), (unsigned long)lm_alias(__init_end),
> +			    (unsigned long)__pgdir_start - (unsigned long)__init_end,
> +			    PAGE_KERNEL_RO);
> +}

BSS segment mapping update is split into its own helper here because it gets
used later in the series. Probably would be helpful to just mention that in
the commit message here.

> +
> +void __init remap_linear_kernel_alias(void)
>  {
>  	/*
> -	 * Remove the write permissions from the linear alias of .text/.rodata
> +	 * Remove the write permissions from the linear alias of the kernel
>  	 */
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    PAGE_KERNEL_RO);
> +	remap_linear_data_alias();
>  }
>  
>  #ifdef CONFIG_KFENCE

