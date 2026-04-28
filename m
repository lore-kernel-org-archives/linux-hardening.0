Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDEF37DEB7;
	Tue, 28 Apr 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386811; cv=none; b=YGCYYU7WiadWif8NsKZeoQ6Fe+I/lkm5XjcFKZBPsZsfztGGR1P5OhWLvhjR1uT2+OAgHa8PG7MJY6zHETeFY2F8RQd55camY4IgZBq01qaF35gJ+bY/iggxGGG8sggbPl9qAzSBXt91G5lzgYsI23gDh1M0MX0mCddMBCVnZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386811; c=relaxed/simple;
	bh=3Tjsh0Mi9ttoZCdrFqo6Hf9TG+BdK8gmbIDZCKmHfgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfjP0rRe57JvQ83Osp8TkmR41ND1XdpaaQz3y7NX3rBXweqmyWItSqpUvQLLwQxKi7zgSsYLCpuZkpVeLdLq/qVhz6qevW0qlkJLQV7jC7Sad5nlpgahB7aDG4TCLSKTc/LxQIKh2vLo/95sr5gwJ1xTKPlZJ01z0qNfq+zCjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=czB/0boF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="czB/0boF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A58DC1C2B;
	Tue, 28 Apr 2026 07:33:23 -0700 (PDT)
Received: from [10.57.63.26] (unknown [10.57.63.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA91D3F763;
	Tue, 28 Apr 2026 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777386809; bh=3Tjsh0Mi9ttoZCdrFqo6Hf9TG+BdK8gmbIDZCKmHfgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=czB/0boF7tK8yvbH/uwt6i6voyaRFSIx9N4QyPaWFgVEyb2orx+Vk61PNatG0TFgm
	 ogtob/NZKbg0T6W56P7AkgMXiOjJEJk2WgzMT7ZfaSimH7G7SbXx6uQWVbXLqpg89p
	 a5zADVDui8oYggRNAMTOAwua68gAwueUcc+dzheM=
Message-ID: <666f0251-773b-4c71-9c68-5d0791297e31@arm.com>
Date: Tue, 28 Apr 2026 16:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] arm64: mm: Drop redundant pgd_t* argument from
 map_mem()
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
 <20260427153416.2103979-23-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427153416.2103979-23-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 17:34, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> __map_memblock() and map_mem() always operate on swapper_pg_dir, so
> there is no need to pass around a pgd_t pointer between them.
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 25 ++++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index bfbf3fe0d1be..9610dd2d7bd9 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1039,11 +1039,11 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
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
> @@ -1091,13 +1091,13 @@ static phys_addr_t __init arm64_kfence_alloc_pool(void)
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
> @@ -1133,11 +1133,11 @@ bool arch_kfence_init_pool(void)
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
> @@ -1182,7 +1182,7 @@ static void __init map_mem(pgd_t *pgdp)
>  		 * if MTE is present. Otherwise, it has the same attributes as
>  		 * PAGE_KERNEL.
>  		 */
> -		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
> +		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
>  
> @@ -1196,10 +1196,9 @@ static void __init map_mem(pgd_t *pgdp)
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
> @@ -1421,7 +1420,7 @@ static void __init create_idmap(void)
>  
>  void __init paging_init(void)
>  {
> -	map_mem(swapper_pg_dir);
> +	map_mem();
>  
>  	memblock_allow_resize();
>  
