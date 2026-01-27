Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D557337B9C;
	Tue, 27 Jan 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508630; cv=none; b=C4dZ3IXb3gsJBWErWiQuDgwVmTj5ahI1IIIz7fmJaH9vzL8XkGTnxvhJDaVT+GyXeQ3rkfLPC118bAEzgpV8DsK2LQsWld2Ihq0zpTsK3TSFBkDZFG7IN4LcU779zHjVadW9GKDbcrcv1Cxh9+i1s2bqqt0158XrFIeu/k9/+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508630; c=relaxed/simple;
	bh=uvSGBm8LaahpIHTUn+AMYYNzc/DtlcLbnVBXs7pAMEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGWAn22XgYSfhCiOW8ky1l5Am8/UFHToEdT7ajICuJ1j3moP8R6D5BLGzFqvNPGeG19OaJokKQOEHlUo0ATa2Am3++viRP+jpIoboIpdIlhA0D+Vm2Q2tkHFTXYRQ7eKCbv0NARAfWxw95P2XrZRnNdxyIE6riT+VuAMzLOXNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A18521595;
	Tue, 27 Jan 2026 02:10:20 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6283F73F;
	Tue, 27 Jan 2026 02:10:25 -0800 (PST)
Message-ID: <49dfb613-3075-4b55-8873-9b72aa4de85c@arm.com>
Date: Tue, 27 Jan 2026 10:10:23 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] arm64: mm: Drop redundant pgd_t* argument from
 map_mem()
Content-Language: en-GB
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-19-ardb+git@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260126092630.1800589-19-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2026 09:26, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> __map_memblock() and map_mem() always operate on swapper_pg_dir, so
> there is no need to pass around a pgd_t pointer between them.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

nice simplification:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 25 ++++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 377bdc4d84a1..80587cd47ce7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1020,11 +1020,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  	flush_tlb_kernel_range(virt, virt + size);
>  }
>  
> -static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
> -				  phys_addr_t end, pgprot_t prot, int flags)
> +static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
> +				  pgprot_t prot, int flags)
>  {
> -	early_create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
> -				 prot, early_pgtable_alloc, flags);
> +	early_create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> +				 end - start, prot, early_pgtable_alloc, flags);
>  }
>  
>  void __init mark_linear_text_alias_ro(void)
> @@ -1072,13 +1072,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
>  	return kfence_pool;
>  }
>  
> -static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
> +static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
>  {
>  	if (!kfence_pool)
>  		return;
>  
>  	/* KFENCE pool needs page-level mapping. */
> -	__map_memblock(pgdp, kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
> +	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
>  			pgprot_tagged(PAGE_KERNEL),
>  			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
> @@ -1114,11 +1114,11 @@ bool arch_kfence_init_pool(void)
>  #else /* CONFIG_KFENCE */
>  
>  static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
> -static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) { }
> +static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
>  
>  #endif /* CONFIG_KFENCE */
>  
> -static void __init map_mem(pgd_t *pgdp)
> +static void __init map_mem(void)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>  	phys_addr_t kernel_start = __pa_symbol(_text);
> @@ -1163,7 +1163,7 @@ static void __init map_mem(pgd_t *pgdp)
>  		 * if MTE is present. Otherwise, it has the same attributes as
>  		 * PAGE_KERNEL.
>  		 */
> -		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
> +		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
>  
> @@ -1177,10 +1177,9 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * Note that contiguous mappings cannot be remapped in this way,
>  	 * so we should avoid them here.
>  	 */
> -	__map_memblock(pgdp, kernel_start, kernel_end,
> -		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> +	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> -	arm64_kfence_map_pool(early_kfence_pool, pgdp);
> +	arm64_kfence_map_pool(early_kfence_pool);
>  }
>  
>  void mark_rodata_ro(void)
> @@ -1402,7 +1401,7 @@ static void __init create_idmap(void)
>  
>  void __init paging_init(void)
>  {
> -	map_mem(swapper_pg_dir);
> +	map_mem();
>  
>  	memblock_allow_resize();
>  

