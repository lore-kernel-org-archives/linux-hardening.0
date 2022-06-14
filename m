Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177A8C43334
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Jun 2022 08:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiFNI0W (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352811AbiFNI0T (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Jun 2022 04:26:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDB9B41F93
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jun 2022 01:26:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D479623A;
        Tue, 14 Jun 2022 01:26:17 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3213F66F;
        Tue, 14 Jun 2022 01:26:14 -0700 (PDT)
Message-ID: <6e8f4341-6ee5-c2b4-1965-6132927f76a1@arm.com>
Date:   Tue, 14 Jun 2022 13:56:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 01/26] arm64: head: move kimage_vaddr variable into C
 file
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-2-ardb@kernel.org>
Content-Language: en-US
In-Reply-To: <20220613144550.3760857-2-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 6/13/22 20:15, Ard Biesheuvel wrote:
> This variable definition does not need to be in head.S so move it out.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/kernel/head.S | 7 -------
>  arch/arm64/mm/mmu.c      | 3 +++
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6a98f1a38c29..1cdecce552bb 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -469,13 +469,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  	ASM_BUG()
>  SYM_FUNC_END(__primary_switched)
>  
> -	.pushsection ".rodata", "a"
> -SYM_DATA_START(kimage_vaddr)
> -	.quad		_text
> -SYM_DATA_END(kimage_vaddr)
> -EXPORT_SYMBOL(kimage_vaddr)
> -	.popsection
> -
>  /*
>   * end early head section, begin head code that is also used for
>   * hotplug and needs to have the same protections as the text region
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c5563ff990da..7148928e3932 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -49,6 +49,9 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>  u64 __section(".mmuoff.data.write") vabits_actual;
>  EXPORT_SYMBOL(vabits_actual);
>  
> +u64 kimage_vaddr __ro_after_init = (u64)&_text;
> +EXPORT_SYMBOL(kimage_vaddr);
> +
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
>  
