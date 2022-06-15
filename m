Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B08C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Jun 2022 04:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiFOEHs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiFOEHp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Jun 2022 00:07:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80B3D11A24
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 21:07:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5889B175A;
        Tue, 14 Jun 2022 21:07:44 -0700 (PDT)
Received: from [10.163.41.27] (unknown [10.163.41.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FD2D3F792;
        Tue, 14 Jun 2022 21:07:40 -0700 (PDT)
Message-ID: <fe24e552-f0fe-a470-7363-3d8c00a6a49d@arm.com>
Date:   Wed, 15 Jun 2022 09:37:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 04/26] arm64: head: drop idmap_ptrs_per_pgd
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-5-ardb@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220613144550.3760857-5-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6/13/22 20:15, Ard Biesheuvel wrote:
> The assignment of idmap_ptrs_per_pgd lacks any cache invalidation, even
> though it is updated with the MMU and caches disabled. However, we never

Right, seems like an omission.

> bother to read the value again except in the very next instruction, and
> so we can just drop the variable entirely.

Right.

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/mmu_context.h | 1 -
>  arch/arm64/kernel/head.S             | 7 +++----
>  arch/arm64/mm/mmu.c                  | 1 -
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 6ac0086ebb1a..7b387c3b312a 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -61,7 +61,6 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
>   * physical memory, in which case it will be smaller.
>   */
>  extern int idmap_t0sz;
> -extern u64 idmap_ptrs_per_pgd;
>  
>  /*
>   * Ensure TCR.T0SZ is set to the provided value.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 7f361bc72d12..53126a35d73c 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -300,6 +300,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	 * range in that case, and configure an additional translation level
>  	 * if needed.
>  	 */
> +	mov	x4, #PTRS_PER_PGD
>  	idmap_get_t0sz x5
>  	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
>  	b.ge	1f			// .. then skip VA range extension
> @@ -319,18 +320,16 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  #error "Mismatch between VA_BITS and page size/number of translation levels"
>  #endif
>  
> -	mov	x4, EXTRA_PTRS
> -	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
> +	mov	x2, EXTRA_PTRS
> +	create_table_entry x0, x3, EXTRA_SHIFT, x2, x5, x6

AFAICS should be safe to use 'x2' here instead of 'x4'.

>  #else
>  	/*
>  	 * If VA_BITS == 48, we don't have to configure an additional
>  	 * translation level, but the top-level table has more entries.
>  	 */
>  	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
> -	str_l	x4, idmap_ptrs_per_pgd, x5
>  #endif
>  1:
> -	ldr_l	x4, idmap_ptrs_per_pgd

'x4' will contain default PTRS_PER_PGD if (VA_BITS = EXTRA_SHIFT), otherwise
it will have  #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT), but without going via
erstwhile 'idmap_ptrs_per_pgd' variable.

>  	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
>  
>  	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 103bf4ae408d..0f95c91e5a8e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -44,7 +44,6 @@
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>  
>  int idmap_t0sz __ro_after_init;
> -u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>  
>  #if VA_BITS > 48
>  u64 vabits_actual __ro_after_init = VA_BITS_MIN;

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
