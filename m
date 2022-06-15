Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CEDC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Jun 2022 04:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiFOEc6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiFOEc5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Jun 2022 00:32:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BD151FCC5
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 21:32:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8112F175A;
        Tue, 14 Jun 2022 21:32:54 -0700 (PDT)
Received: from [10.163.41.27] (unknown [10.163.41.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB4B3F792;
        Tue, 14 Jun 2022 21:32:50 -0700 (PDT)
Message-ID: <35a8be65-47d5-45b3-3917-44d559778d2a@arm.com>
Date:   Wed, 15 Jun 2022 10:02:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 08/26] arm64: kernel: drop unnecessary PoC cache
 clean+invalidate
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
 <20220613144550.3760857-9-ardb@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220613144550.3760857-9-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6/13/22 20:15, Ard Biesheuvel wrote:
> Some early boot code runs before the virtual placement of the kernel is
> finalized, and we used to go back to the very start and recreate the ID
> map along with the page tables describing the virtual kernel mapping,
> and this involved setting some global variables with the caches off.
> 
> In order to ensure that global state created by the KASLR code is not
> corrupted by the cache invalidation that occurs in that case, we needed
> to clean those global variables to the PoC explicitly.
> 
> This is no longer needed now that the ID map is created only once (and
> the associated global variable updates are no longer repeated). So drop
> the cache maintenance that is no longer necessary.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/kaslr.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 418b2bba1521..d5542666182f 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -13,7 +13,6 @@
>  #include <linux/pgtable.h>
>  #include <linux/random.h>
>  
> -#include <asm/cacheflush.h>
>  #include <asm/fixmap.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/memory.h>
> @@ -72,9 +71,6 @@ u64 __init kaslr_early_init(void)
>  	 * we end up running with module randomization disabled.
>  	 */
>  	module_alloc_base = (u64)_etext - MODULES_VSIZE;
> -	dcache_clean_inval_poc((unsigned long)&module_alloc_base,
> -			    (unsigned long)&module_alloc_base +
> -				    sizeof(module_alloc_base));
>  
>  	/*
>  	 * Try to map the FDT early. If this fails, we simply bail,
> @@ -174,13 +170,6 @@ u64 __init kaslr_early_init(void)
>  	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
>  	module_alloc_base &= PAGE_MASK;
>  
> -	dcache_clean_inval_poc((unsigned long)&module_alloc_base,
> -			    (unsigned long)&module_alloc_base +
> -				    sizeof(module_alloc_base));
> -	dcache_clean_inval_poc((unsigned long)&memstart_offset_seed,
> -			    (unsigned long)&memstart_offset_seed +
> -				    sizeof(memstart_offset_seed));
> -
>  	return offset;
>  }
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
