Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF92C43334
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 12:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiFXMgN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXMgL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 08:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483964CD4E
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 05:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABC161C36
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 12:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1FC34114;
        Fri, 24 Jun 2022 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656074169;
        bh=qS0WvydUMGkzxUfEfVLbi+q0Czzas7ZoRxwNwstvl2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vz2hrivxRLtV5aOLeMf7nLWH9z5Ory1F2dGbA+WErCEe/9rIkqhxA4DFW+8RBC+Ej
         786B0J4v4yXPifTTp8P0bWBY2704+x6WmLy1ZDhx2OjlW9cCrtNv6I/xwL8fOiY3j8
         sors15SBdgFgx2b3bfOZ/yCXz8kYh5bq4ofy0/dAhKbPeAj8kkZN+eYkoZiqhJoHZA
         l0VcknsX8tupA52F+X3Kz0p6hRp0b1T8SE4yjOJNh1YXi+Lh3biovEiTywI8Clkp4E
         FZJlWk0XRGIROGmpRwl5VQoNASn8w2wVaKNyl9te0ZzKYDZ81SrjWZQfsTUCCf93CB
         Cm4tZURApJ7vQ==
Date:   Fri, 24 Jun 2022 13:36:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 03/26] arm64: head: move assignment of idmap_t0sz to C
 code
Message-ID: <20220624123602.GC18561@willie-the-truck>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-4-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:27PM +0200, Ard Biesheuvel wrote:
> Setting idmap_t0sz involves fiddling with the caches if done with the
> MMU off. Since we will be creating an initial ID map with the MMU and
> caches off, and the permanent ID map with the MMU and caches on, let's
> move this assignment of idmap_t0sz out of the startup code, and replace
> it with a macro that simply issues the three instructions needed to
> calculate the value wherever it is needed before the MMU is turned on.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/assembler.h   | 14 ++++++++++++++
>  arch/arm64/include/asm/mmu_context.h |  2 +-
>  arch/arm64/kernel/head.S             | 13 +------------
>  arch/arm64/mm/mmu.c                  |  5 ++++-
>  arch/arm64/mm/proc.S                 |  2 +-
>  5 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 8c5a61aeaf8e..9468f45c07a6 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -359,6 +359,20 @@ alternative_cb_end
>  	bfi	\valreg, \t1sz, #TCR_T1SZ_OFFSET, #TCR_TxSZ_WIDTH
>  	.endm
>  
> +/*
> + * idmap_get_t0sz - get the T0SZ value needed to cover the ID map
> + *
> + * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
> + * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
> + * this number conveniently equals the number of leading zeroes in
> + * the physical address of _end.
> + */
> +	.macro	idmap_get_t0sz, reg
> +	adrp	\reg, _end
> +	orr	\reg, \reg, #(1 << VA_BITS_MIN) - 1
> +	clz	\reg, \reg
> +	.endm
> +
>  /*
>   * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
>   * ID_AA64MMFR0_EL1.PARange value
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 6770667b34a3..6ac0086ebb1a 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -60,7 +60,7 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
>   * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
>   * physical memory, in which case it will be smaller.
>   */
> -extern u64 idmap_t0sz;
> +extern int idmap_t0sz;
>  extern u64 idmap_ptrs_per_pgd;
>  
>  /*
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index dc07858eb673..7f361bc72d12 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -299,22 +299,11 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	 * physical address space. So for the ID map, use an extended virtual
>  	 * range in that case, and configure an additional translation level
>  	 * if needed.
> -	 *
> -	 * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
> -	 * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
> -	 * this number conveniently equals the number of leading zeroes in
> -	 * the physical address of __idmap_text_end.
>  	 */
> -	adrp	x5, __idmap_text_end
> -	clz	x5, x5
> +	idmap_get_t0sz x5
>  	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
>  	b.ge	1f			// .. then skip VA range extension
>  
> -	adr_l	x6, idmap_t0sz
> -	str	x5, [x6]
> -	dmb	sy
> -	dc	ivac, x6		// Invalidate potentially stale cache line
> -
>  #if (VA_BITS < 48)
>  #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
>  #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17b339c1a326..103bf4ae408d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -43,7 +43,7 @@
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>  
> -u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
> +int idmap_t0sz __ro_after_init;
>  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>  
>  #if VA_BITS > 48
> @@ -785,6 +785,9 @@ void __init paging_init(void)
>  			       (u64)&vabits_actual + sizeof(vabits_actual));
>  #endif
>  
> +	idmap_t0sz = min(63UL - __fls(__pa_symbol(_end)),
> +			 TCR_T0SZ(VA_BITS_MIN));

nit: TCR_T0SZ shifts by TCR_T0SZ_OFFSET, so this is a bit confusing and
works out because the register offset happens to be zero. Maybe it would
be clearer to calculate the maximum of fls(__pa_symbol(_end)) and
VA_BITS_MIN, then subtract that from 64?

Will
