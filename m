Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1617AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiFXNIT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiFXNIS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:08:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CC81115F
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3260BB828C8
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35035C34114;
        Fri, 24 Jun 2022 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656076095;
        bh=4AmdDL01Va7refTwJZlCJ9hIGQV9z/YdSCEuRy7bdwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zpk0wHz6h+9/IWrRuIX1pMGHtQ+r4Bd6dCwZOc4BUP/wJjg46oDhJV5jFTPrCabKt
         FXuoljEYl08LrhUbzF0vV3jcmhwnwcue4SH/t9Cb82zbhhvSgCP8r4vNPz9F/sV8Ca
         P8BLNkJMMxWuTMEHtuXNUTp/e8RO3M/SFPzUGo6qV/e3WxUp3yFSzUmZitBGqd3emA
         m8ciu1ZtPyKg1FeACTTjRjHmCsmszYDgroU3FH+lg+DuhDrPsFrOJcQgiXJXCP2Lmr
         vdMvm+Pkx6wTYuObax8UDfSnEZVcyU26tmv8ltO3O7ZCUpXiUC8nxZA2G3Za95ITXA
         70oCme6I97ILw==
Date:   Fri, 24 Jun 2022 14:08:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 19/26] arm64: kaslr: defer initialization to late
 initcall where permitted
Message-ID: <20220624130808.GE18561@willie-the-truck>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-20-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-20-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:43PM +0200, Ard Biesheuvel wrote:
> The early KASLR init code runs extremely early, and anything that could
> be deferred until later should be. So let's defer the randomization of
> the module region until much later - this also simplifies the
> arithmetic, given that we no longer have to reason about the link time
> vs load time placement of the core kernel explicitly. Also get rid of
> the global status variable, and infer the status reported by the
> diagnostic print from other KASLR related context.
> 
> While at it, get rid of the special case for KASAN without
> KASAN_VMALLOC, which never occurs in practice.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/kaslr.c | 95 +++++++++-----------
>  1 file changed, 40 insertions(+), 55 deletions(-)

[...]

> @@ -163,33 +169,12 @@ u64 __init kaslr_early_init(void)
>  		 * when ARM64_MODULE_PLTS is enabled.
>  		 */
>  		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
> -		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
>  	}
>  
>  	/* use the lower 21 bits to randomize the base of the module region */
>  	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
>  	module_alloc_base &= PAGE_MASK;
>  
> -	return offset;
> -}
> -
> -static int __init kaslr_init(void)
> -{
> -	switch (kaslr_status) {
> -	case KASLR_ENABLED:
> -		pr_info("KASLR enabled\n");
> -		break;
> -	case KASLR_DISABLED_CMDLINE:
> -		pr_info("KASLR disabled on command line\n");
> -		break;
> -	case KASLR_DISABLED_NO_SEED:
> -		pr_warn("KASLR disabled due to lack of seed\n");
> -		break;
> -	case KASLR_DISABLED_FDT_REMAP:
> -		pr_warn("KASLR disabled due to FDT remapping failure\n");
> -		break;
> -	}
> -
>  	return 0;
>  }
> -core_initcall(kaslr_init)
> +late_initcall(kaslr_init)

Are you sure this isn't too late? I'm nervous that we might have called
request_module() off the back of all the other initcalls that we've run by
this point.

Will
