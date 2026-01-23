Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4329D277;
	Fri, 23 Jan 2026 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148777; cv=none; b=HC9l+mUkwOIAlaOcfFm3VHuh3VCXYlz4L27hQneWgoMN3lEQVOYPs1fzHljaJIjKu010cvolnr/aim/B8yNLmSTO0a6gWBg0B0J8h1OlJr1Mo3zZg9XwrmJM/jMXreOjMTHanCfP9znzDZKGlA3FF1B5+RKUYZ7DP5R8KnAYewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148777; c=relaxed/simple;
	bh=j60cKGkR12WcqAH+VcNuKAbzGYakrLM1AIkHs3/dVAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi3wd838KxP7+S5E+RHgqao8vuo8RJpK6zK4brWqCgboQ+Pd3mZe5EYWrDOBJHsUT88rtH1UyC+bGQe2iVQzHOh/g67clS+TgqtHTsG3c98xBrj/WOBlvtDMaxjL+Pl+a/lKpx2XwhN2e3jpOnsxlN5iNOmYJZHgL7UrvU6ywYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC821476;
	Thu, 22 Jan 2026 22:12:41 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60603F740;
	Thu, 22 Jan 2026 22:12:44 -0800 (PST)
Message-ID: <d5c7ed76-2b54-4c6e-961f-6ba1e4011467@arm.com>
Date: Fri, 23 Jan 2026 11:42:42 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: Move fixmap page tables to end of kernel image
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260119164747.1402434-6-ardb+git@google.com>
 <20260119164747.1402434-7-ardb+git@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260119164747.1402434-7-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Move the fixmap page tables out of the BSS section, and place them at
> the end of the image, right before the init_pg_dir section where some of
> the other statically allocated page tables live.
> 
> These page tables are currently the only data objects in vmlinux that
> are meant to be accessed via the kernel image's linear alias, and so
> placing them together allows the remainder of the data/bss section to be
> remapped read-only or unmapped entirely.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 5 +++++
>  arch/arm64/mm/fixmap.c          | 7 ++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index ad6133b89e7a..df530e6f3e53 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -334,6 +334,11 @@ SECTIONS
>  	__pi___bss_start = __bss_start;
>  
>  	. = ALIGN(PAGE_SIZE);
> +	.pgdir : {
> +		__pgdir_start = .;

Does __fixmap_pgdir_start with an end marker __fixmap_pgdir_end sound better ?

> +		*(.fixmap_bss)
> +	}
> +
>  	__pi_init_pg_dir = .;
>  	. += INIT_DIR_SIZE;
>  	__pi_init_pg_end = .;
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index c5c5425791da..b649ea1a46e4 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -31,9 +31,10 @@ static_assert(NR_BM_PMD_TABLES == 1);
>  
>  #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
>  
> -static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
> -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> +#define __fixmap_bss	__section(".fixmap_bss") __aligned(PAGE_SIZE)
> +static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __fixmap_bss;
> +static pmd_t bm_pmd[PTRS_PER_PMD] __fixmap_bss __maybe_unused;
> +static pud_t bm_pud[PTRS_PER_PUD] __fixmap_bss __maybe_unused;
>  
>  static inline pte_t *fixmap_pte(unsigned long addr)
>  {

