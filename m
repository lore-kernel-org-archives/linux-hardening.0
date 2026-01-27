Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71A33D6C2;
	Tue, 27 Jan 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509303; cv=none; b=Cflozb76kU6DCS5nSaC7AzR3avi+Stne5d+w121xtMMHKc0g120unR4UxQQO5QPszJapDtZQqaUk5fodM+FPaSbrQyLDT4dxOxBAlkhppa7u2fN2I9u38UZY7mwDpkQbyQGGd82t8EbEkrFFNrD6lkB6z4L7ns4WXvNfAST5UDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509303; c=relaxed/simple;
	bh=EEcJXnP3zDwQ3a8qOgGW/QVSJrshfyMjOangRaVLVpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnWQBcSCRD8xwaWGL1LYDuVc/8tGHcVHbu3k4LB2kl9rsHZ9eSRGWLMmA+i0cQtB6rsnvwtujyTzTZ/UpWdnEnUBASEODtUa+N0f5tPYbBHCMoIXAG2tu33JcgVK2R/N17BLc0uZ0A1D5zFJ0b4t8g1CBe55PoB9hC5wXiCAe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADD31595;
	Tue, 27 Jan 2026 02:21:33 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E4C03F73F;
	Tue, 27 Jan 2026 02:21:38 -0800 (PST)
Message-ID: <d0f2df03-21da-473f-ab89-64a964c18f08@arm.com>
Date: Tue, 27 Jan 2026 10:21:36 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-20-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-20-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Now that the DRAM mapping routines respect existing table mappings and
> contiguous block and page mappings, it is no longer needed to fiddle
> with the memblock tables to set and clear the NOMAP attribute. Instead,
> map the kernel text and rodata alias first, avoiding contiguous
> mappings, so that they will not be added later when mapping the
> memblocks.

Should we do something similar for kfence? Currently we have
arm64_kfence_alloc_pool() which marks some memory NOMAP then
arm64_kfence_map_pool() which PTE-maps it and clears NOMAP. Presumably we could
rationalize into a single function that does it all, prior to mapping the bulk
of the linear map?

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 27 ++++++++------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 80587cd47ce7..18415d4743bf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1149,12 +1149,17 @@ static void __init map_mem(void)
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	/*
> -	 * Take care not to create a writable alias for the
> -	 * read-only text and rodata sections of the kernel image.
> -	 * So temporarily mark them as NOMAP to skip mappings in
> -	 * the following for-loop
> +	 * Map the linear alias of the [_text, __init_begin) interval
> +	 * as non-executable now, and remove the write permission in
> +	 * mark_linear_text_alias_ro() above (which will be called after
> +	 * alternative patching has completed). This makes the contents
> +	 * of the region accessible to subsystems such as hibernate,
> +	 * but protects it from inadvertent modification or execution.
> +	 * Note that contiguous mappings cannot be remapped in this way,
> +	 * so we should avoid them here.
>  	 */
> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> +	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
> +		       flags | NO_CONT_MAPPINGS);

So the reason to disallow cont mappings is because we need to modify the
permissions later? It _is_ safe to change permissions on a live contiguous
mapping in this way. That was clarified in the architecture a couple of years
back and we rely on it for contpte_wrprotect_ptes(); see comment there.

I think we could relax this?

Thanks,
Ryan

>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> @@ -1167,18 +1172,6 @@ static void __init map_mem(void)
>  			       flags);
>  	}
>  
> -	/*
> -	 * Map the linear alias of the [_text, __init_begin) interval
> -	 * as non-executable now, and remove the write permission in
> -	 * mark_linear_text_alias_ro() below (which will be called after
> -	 * alternative patching has completed). This makes the contents
> -	 * of the region accessible to subsystems such as hibernate,
> -	 * but protects it from inadvertent modification or execution.
> -	 * Note that contiguous mappings cannot be remapped in this way,
> -	 * so we should avoid them here.
> -	 */
> -	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  	arm64_kfence_map_pool(early_kfence_pool);
>  }
>  

