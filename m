Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D43CFF7E;
	Wed,  8 Apr 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655817; cv=none; b=P0dFODUU3UhpOpCP/56aHmqgGyzhOpf7ewFNsNuihP+Ii9FW0hYlUi2AG9G5FkufMTECrjxDHKRGyRzONzPV0kd3es69Er/WgKhxtZehiXOgBYl4vmsCYfX6283C97/QALUNxkD/aM1q66+cIGhfMCe4CEqn9fmpR9HWkyyA+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655817; c=relaxed/simple;
	bh=APSRIzYq127UdDGuSl50AgJ/vrTdGsi6czgv23BVJwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wnhi0AUnundalmfshKYVku0Cz+EoDWLF/GfKojuiXcktmnNAtMRYPnSfdvDf5EIE2gVioBtpV4d6FArLLQHmI/7mrEHZR7rdWzWijMBagqdYug+DLCxYv9tnKyBYJW/2+7O1hJR1MNVGtl6eBZkowE05nledFKYkKDXtnzTCLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UEJQ9anJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UEJQ9anJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FE82BC4;
	Wed,  8 Apr 2026 06:43:28 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5E783F641;
	Wed,  8 Apr 2026 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775655814; bh=APSRIzYq127UdDGuSl50AgJ/vrTdGsi6czgv23BVJwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEJQ9anJgeUmtd8DTENXwcmCoXpPyLdKpcr/YAU0Jj6mkWVKnIiODmF+dex/3TNNX
	 wXQXaAwwFlush8K52iPu6GFVM4CkkwKpiNgpRLOQx2OIs8g/EL3pDJU/rnhQCBsD8t
	 SH0tpbksaZzJcLxe/QBKj/YnOcLLGCHXw5l0N6u0=
Date: Wed, 8 Apr 2026 14:43:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 01/13] arm64: Move the zero page to rodata
Message-ID: <adZbgYJqY6bisaoZ@arm.com>
References: <20260320145934.2349881-15-ardb+git@google.com>
 <20260320145934.2349881-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320145934.2349881-16-ardb+git@google.com>

Hi Ard,

On Fri, Mar 20, 2026 at 03:59:36PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 2964aad0362e..2d021a576e50 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -229,6 +229,7 @@ SECTIONS
>  #endif
>  
>  	reserved_pg_dir = .;
> +	empty_zero_page = .;
>  	. += PAGE_SIZE;
>  
>  	swapper_pg_dir = .;
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a6a00accf4f9..795743913ce5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
>  
>  /*
>   * Empty_zero_page is a special page that is used for zero-initialized data
> - * and COW.
> + * and COW. Defined in the linker script.
>   */
> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);

I looked at Sashiko's reports
(https://sashiko.dev/#/patchset/20260320145934.2349881-15-ardb+git@google.com)
and it has a point here that with MTE, map_mem() doesn't map the
empty_zero_page as Tagged in the for_each_mem_range() loop. The
subsequent cpu_enable_mte() will fail to initialise the tags. I think
this problem disappears with patch 11 where all the linear map is now
Tagged.

We either ignore it or we temporarily map the kernel as Tagged until the
linear alias is removed later:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 795743913ce5..5290f7537074 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1175,7 +1175,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * so we should avoid them here.
 	 */
 	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+		       pgprot_tagged(PAGE_KERNEL), NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 	arm64_kfence_map_pool(early_kfence_pool, pgdp);
 }

-- 
Catalin
