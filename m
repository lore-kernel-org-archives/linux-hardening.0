Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4883B19B0
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318440; cv=none; b=Tm5Hm25HZhe/2cJ3NUnZQ4BJD2Pmtmh8mWsHBnwWzjgWyprNCgchFbUwvHi7Vz7qy/s/t2NPAmDbuQoxDMcQXutYJVsLdAOJAERK2G/jIn54XxWL05AcVCzDXjoR88KMIjvkl5//y3JXLBGeKcOOYvqCazDEWvll4c4D2Qc4/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318440; c=relaxed/simple;
	bh=2OeUaNMPu+bZ4hOVGmb2LFwuUA0hs71atyCF4/CFKQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZQsxZhnZ3kw16NRtnQDOz0rrLId950XFWez7kKDZkMW+0AGG88EZXahgjA9TDCFtEpRrLBBb3EHUCidjS9/IEUJpS7aYpS/g7U678Q6T+b6p59mcRSei2860gYEC9lpO8PTs1sxsvExlg2Q+WTXnG6LWTghzD3REzryWIG7BRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hza4Dkuj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hza4Dkuj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08CDD1476;
	Fri, 21 Aug 2026 06:20:25 -0700 (PDT)
Received: from [10.43.18.12] (unknown [10.43.18.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 662123F763;
	Fri, 21 Aug 2026 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787318428; bh=2OeUaNMPu+bZ4hOVGmb2LFwuUA0hs71atyCF4/CFKQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hza4DkujC7/DIpSTKMt+tG/p7p5i5Klwn99TIX85W/13RztKsk6CbPkZDhFuXn017
	 hcSu/fYfsj7Gc6azfpkOns3TY3W1mtn8qwSb7ne4tE2LCezmbSJMAyNwVXUaMh0zfk
	 t5HJeljpPTNDNGSe3MZKxoGw50Hw+Aq1XIbFdj8k=
Message-ID: <5a3b89a6-bc42-42c3-82e8-25d6f1a2c5d2@arm.com>
Date: Fri, 21 Aug 2026 15:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: mm: Map fixmap PTE tables r/o in the linear
 map
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
 linux-hardening@vger.kernel.org
References: <20260805104042.1107678-2-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260805104042.1107678-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2026 12:40, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Without physical KASLR, the fixmap page tables will appear at an a
> priori known offset in the physical address space, and due to the lack
> of randomization, the linear map carries a writeable alias of the fixmap
> PTE pages, which appears at an offset in the kernel VA space that is
> also predictable.
>
> Given that the placement of the fixmap area is never randomized either,
> a single store to this linear alias region is sufficient to map any
> physical page with any permissions at a known offset in the kernel VA
> space, including on top of the PTI trampoline.
>
> Avoid this, by remapping the fixmap PTE pages read-only in the linear
> map.

Sounds good, logical next step after unmapping the rest of data/BSS from
the linear map :)

> This is possible because all updates to bm_pte[] occur via the
> mapping of the kernel image in the vmap area. A read-only mapping is
> still needed for things like ptdump that walk the page tables.
>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Liz Prucka <lizprucka@google.com>
> Cc: Seth Jenkins <sethjenkins@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/set_memory.h |  2 ++
>  arch/arm64/mm/fixmap.c              |  7 +++++++
>  arch/arm64/mm/pageattr.c            | 10 ++++++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
> index 90f61b17275e..a685fb534c3e 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -11,6 +11,8 @@ bool can_set_direct_map(void);
>  
>  int set_memory_valid(unsigned long addr, int numpages, int enable);
>  
> +int set_direct_map_ro(unsigned long addr, int numpages);
> +
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index f66a0016dd02..fcb571dffe82 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -14,6 +14,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/pgalloc.h>
> +#include <asm/set_memory.h>
>  #include <asm/tlbflush.h>
>  
>  /* ensure that the fixmap region does not grow down into the PCI I/O region */
> @@ -173,3 +174,9 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>  
>  	return dt_virt;
>  }
> +
> +static int __init fixmap_remap_ro(void)
> +{
> +	return set_direct_map_ro((unsigned long)lm_alias(&bm_pte), NR_BM_PTE_TABLES);

Should we not also remap bm_pmd and bm_pud?

For that matter, do we need RW access via the linear map for any page
annotated with __bss_pgtbl? I suppose that might be the case for
kasan_early_shadow_* but I don't know enough about KASAN to tell for sure.

> +}
> +late_initcall(fixmap_remap_ro);

Is mark_rodata_ro() definitely too early to remap these pages RO?

- Kevin

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index bbe98ac9ad8c..5072b14d4f9d 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -251,6 +251,16 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>  					__pgprot(PTE_PRESENT_VALID_KERNEL));
>  }
>  
> +int set_direct_map_ro(unsigned long addr, int numpages)
> +{
> +	if (!can_set_direct_map())
> +		return 0;
> +
> +	return __change_memory_common(addr, PAGE_SIZE * numpages,
> +				      __pgprot(PTE_RDONLY),
> +				      __pgprot(PTE_WRITE));
> +}
> +
>  int set_direct_map_invalid_noflush(struct page *page)
>  {
>  	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
