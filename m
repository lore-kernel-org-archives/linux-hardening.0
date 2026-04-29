Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215331326B;
	Wed, 29 Apr 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470932; cv=none; b=f5s2/6WHEKgznjNBs2oUgwCHR+retEgnVgh7bHga1tUzMTJNBOwq4417a2tVcTjMzTAUPvLewdvlqI0N2eRFCY23b33kZ66mvwE3I9uUpHeKxJhKx3evT2mZKaBlpmN6lWXw8NIIFDcAEo8j4pZTZTbIVWoCBoLXWNH2+zjIEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470932; c=relaxed/simple;
	bh=ehd9yGlOl8LsUGnM+WAez4P4lcrk3w5tIJe9Kpk+AvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzDEI5Bp+8V7pmxrs5Jzhs0yuhfMJxXS9z9zPD27fxM0So5pBiwAQ7ms5FdOSWWauZ83xXtEun83EQLBNOwfnv64YUNROkzHLmv57ObO0PkzgCOixbYLQG8XfNEE33gwdkNvjJDXU5ODuRH3ts9nSmSnnicbII6fOpVblZdA4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pDgqQH2l; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pDgqQH2l"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1778B1C01;
	Wed, 29 Apr 2026 06:55:25 -0700 (PDT)
Received: from [10.57.62.76] (unknown [10.57.62.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 974983F62B;
	Wed, 29 Apr 2026 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777470930; bh=ehd9yGlOl8LsUGnM+WAez4P4lcrk3w5tIJe9Kpk+AvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pDgqQH2lzWITgRoVEmuoGdabiAmMhLaT1ZMfM7SIK+Rh2M+sx+YhDLMb9+m8i+pq7
	 BFgHX04N0H1Pv832jzce4+t3UqetyKWkvzrjmPbNE0p5uIRsOlTJvPBunsdzPKcuNg
	 t05wSL1xU4xlMdtgk5TP3EQUW4y2jooZdRDRcbsg=
Message-ID: <15555e9f-65ab-4811-b20c-8ada90bdc9d0@arm.com>
Date: Wed, 29 Apr 2026 15:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-30-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-30-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The linear aliases of the kernel text and rodata are mapped read-only in
> the linear map as well. Given that the contents of these regions are
> mostly identical to the version in the loadable image, mapping them
> read-only and leaving their contents visible is a reasonable hardening
> measure.
>
> Data and bss, however, are now also mapped read-only but the contents of
> these regions are more likely to contain data that we'd rather not leak.

That sounds like a good rationale but I wonder, is there anything
stopping us from unmapping text/rodata as well?

> So let's unmap these entirely in the linear map when the kernel is
> running normally.
>
> When going into hibernation or waking up from it, these regions need to
> be mapped, so map the region initially, and toggle the valid bit so
> map/unmap the region as needed.

Doesn't safe_copy_page() already handle that? I suppose this is an
optimisation to avoid modifying the linear map for every page, but if so
it would be good to spell it out.

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 44 ++++++++++++++++----
>  1 file changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9361b7efb848..a464f3d2d2df 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -24,6 +24,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/suspend.h>
>  #include <linux/kfence.h>
>  #include <linux/pkeys.h>
>  #include <linux/mm_inline.h>
> @@ -1040,6 +1041,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
>  				 end - start, prot, early_pgtable_alloc, flags);
>  }
>  
> +static void remap_linear_data_alias(bool unmap)
> +{
> +	set_memory_valid((unsigned long)lm_alias(__init_end),
> +			 (unsigned long)(__fixmap_pgdir_start - __init_end) / PAGE_SIZE,
> +			 !unmap);
> +}
> +
> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
> +				     unsigned long mode, void *unused)
> +{
> +	switch (mode) {
> +	default:
> +		break;
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +		remap_linear_data_alias(true);
> +		break;
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +		remap_linear_data_alias(false);
> +		break;
> +	}
> +	return 0;
> +}
> +
>  void __init mark_linear_text_alias_ro(void)
>  {
>  	/*
> @@ -1048,6 +1074,16 @@ void __init mark_linear_text_alias_ro(void)
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    pgprot_tagged(PAGE_KERNEL_RO));
> +
> +	remap_linear_data_alias(true);

It's really hard to know what this does without looking at the function.
How about mark_linear_data_alias_valid(false)?

> +
> +	if (IS_ENABLED(CONFIG_HIBERNATION)) {
> +		static struct notifier_block nb = {
> +			.notifier_call = arm64_hibernate_pm_notify
> +		};
> +
> +		register_pm_notifier(&nb);
> +	}
>  }
>  
>  #ifdef CONFIG_KFENCE
> @@ -1162,7 +1198,7 @@ static void __init map_mem(void)
>  
>  	/* Map the kernel data/bss so it can be remapped later */
>  	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
> -		       flags);
> +		       flags | NO_BLOCK_MAPPINGS);

Might be an obvious question but why do we need this?

- Kevin

>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> @@ -1174,12 +1210,6 @@ static void __init map_mem(void)
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
> -
> -	/* Map the kernel data/bss read-only in the linear map */
> -	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL_RO),
> -		       flags);
> -	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
> -			       (unsigned long)lm_alias(__fixmap_pgdir_start));
>  }
>  
>  void mark_rodata_ro(void)
