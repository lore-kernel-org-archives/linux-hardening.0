Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA4A2FD1B3;
	Wed, 29 Apr 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470860; cv=none; b=tgJEhRAL3kY0543ngx3Lg19d5oxF8x6oauoI9Ux23WOuCcev7/ARQ8bLVB3JfTYoXrCqv7m1pldKV8GKLCy65rM+ZdBOsochH8TFl+8kNQECjc9Oep+ZS1kNoI+cVfrYM+mAxXdvK/42Dk4QRDlZQYVtfZOq97mG4QPEw88SdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470860; c=relaxed/simple;
	bh=op0PGB2RSdfIzNdbBTKjY7j2TmI/0VCoEC8J4z/6BVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWkda+A2WlE3vbG3jv9LXL2XovibyPrHlU9lhzOnBO3ZK3jOkeXZug70vji57az+rIPV/giRHPa+Q0QeRL7v9RR+gUN3RaH61BxkFGYh019GhMMTqmTz8INd0IrKosQfxvEnD8NkWbIdGMJU9+kyE8GPr2Tiw3TDhzBnkNBj7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lLNh2XYt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lLNh2XYt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52FA11C01;
	Wed, 29 Apr 2026 06:54:13 -0700 (PDT)
Received: from [10.57.62.76] (unknown [10.57.62.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2ECF3F62B;
	Wed, 29 Apr 2026 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777470858; bh=op0PGB2RSdfIzNdbBTKjY7j2TmI/0VCoEC8J4z/6BVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lLNh2XYt3BMVorNa0t/pHJR9WnAZJGdKKJRuZrRL2Jw8zDzv5mKfd13eRZgUo18bE
	 tqtHwaRW1y1Rq98Fcuu7NWuGV5fJNqwm1VBkGihwLn/V3T5pbJSZ3ik7FdjZyT+94f
	 jNf+YT+GlUAHbAAaM5w0hBAoSnAbx/LjM9mIo84I=
Message-ID: <a8740f95-e167-48ae-ae65-97c6701d9c94@arm.com>
Date: Wed, 29 Apr 2026 15:54:12 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] arm64: mm: Map the kernel data/bss read-only in
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
 <20260427153416.2103979-29-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-29-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
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
> this region. This is not needed, so map them read-only as well.
>
> Note that the statically allocated kernel page tables do need to be
> modifiable via the linear map, so leave these mapped read-write.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/sections.h |  1 +
>  arch/arm64/mm/mmu.c               | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> index 51b0d594239e..32ec21af0823 100644
> --- a/arch/arm64/include/asm/sections.h
> +++ b/arch/arm64/include/asm/sections.h
> @@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
>  extern char __mmuoff_data_start[], __mmuoff_data_end[];
>  extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
>  extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
> +extern char __fixmap_pgdir_start[];
>  
>  static inline size_t entry_tramp_text_size(void)
>  {
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1a4b4337d29a..9361b7efb848 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1122,7 +1122,9 @@ static void __init map_mem(void)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>  	phys_addr_t kernel_start = __pa_symbol(_text);
> -	phys_addr_t kernel_end = __pa_symbol(__init_begin);
> +	phys_addr_t init_begin = __pa_symbol(__init_begin);
> +	phys_addr_t init_end = __pa_symbol(__init_end);
> +	phys_addr_t kernel_end = __pa_symbol(__fixmap_pgdir_start);

Using fixmap_pgdir as an anchor seems a bit arbitrary... Couldn't we use
__bss_end instead?

It could also be helpful to add comments in vmlinux.lds.S clarifying
which sections are RO/RW in the linear map, it's getting pretty
difficult to follow.

>  	phys_addr_t start, end;
>  	int flags = NO_EXEC_MAPPINGS;
>  	u64 i;
> @@ -1155,7 +1157,11 @@ static void __init map_mem(void)
>  	 * of the region accessible to subsystems such as hibernate,
>  	 * but protects it from inadvertent modification or execution.
>  	 */
> -	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
> +	__map_memblock(kernel_start, init_begin, pgprot_tagged(PAGE_KERNEL),
> +		       flags);
> +
> +	/* Map the kernel data/bss so it can be remapped later */
> +	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),

Maybe I'm missing something obvious, but considering patch 3/4 couldn't
we directly map the range RO here?

- Kevin

>  		       flags);
>  
>  	/* map all the memory banks */
> @@ -1168,6 +1174,12 @@ static void __init map_mem(void)
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
> +
> +	/* Map the kernel data/bss read-only in the linear map */
> +	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL_RO),
> +		       flags);
> +	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
> +			       (unsigned long)lm_alias(__fixmap_pgdir_start));
>  }
>  
>  void mark_rodata_ro(void)
