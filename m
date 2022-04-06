Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A01C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Apr 2022 20:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiDFUdw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiDFUdb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Apr 2022 16:33:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460DE369395
        for <linux-hardening@vger.kernel.org>; Wed,  6 Apr 2022 11:55:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m16so2780776plx.3
        for <linux-hardening@vger.kernel.org>; Wed, 06 Apr 2022 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dQMyBdrJI0TKqS6iJJZhTQ6K9ZLVlK71bX36qsCyaOc=;
        b=XSHD7Rr+AHKSeq3C9olRSWGO+rDcFjM5qx3pbQd10xyj4JC4dTQTtAkjBViXdvkrmK
         rq4zPR2lloAkd/XLzgm0GqKjIwwxwAJBJAXzk6uXrP3+aCoO5MlBp/SakON+NFdIPwgH
         H6xX1CLQiO5xRg753Qq1NncjUsZX1WuFyMisk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dQMyBdrJI0TKqS6iJJZhTQ6K9ZLVlK71bX36qsCyaOc=;
        b=j3A/UJGbtSmoHHl9oQ9t5Ut3w/Q5Ob8zj4eWa3GBSKzlZf7OjXPUWGJJD0Nf/wI27k
         BUX0IXZAFbmms40VfKkwF7QqtDfozkf36IezhBiC66KYgy1VvUqax4z9kA+ZY5U9IYOf
         /xptmo50m8CBxFU7iMKCPfdASYsWY2PPHzf2idBMZ/9nUIieEaR7V2s2plDW1ovrSuhl
         AWIdUlY6zDbXoQSBw+nYlfjju1v4OAd4YY9yrmwBFGwJM9Cct+q2cq3WZ9IjJM96OGBL
         L+5/vaxiMHvcy9kM3IQJwmUqNLodhsUaZCd9GG1eU3ZXqs9+t/JsQRRRzT2NSi8leY3d
         y47w==
X-Gm-Message-State: AOAM533+OfAOaDrotxMCPh3/BQM4Y6eawTn+fXaxA8R1hl5WrhTErAGx
        Wdw1HlGBWlau1kZKyvTEqwuGXg==
X-Google-Smtp-Source: ABdhPJwShpXOnPbCB31pSiDlliiYiOpD6jplXs80WT404Afay0P/HhCi4TaRShIn/ulCCbHYmicOuw==
X-Received: by 2002:a17:902:f0ca:b0:156:caa9:4221 with SMTP id v10-20020a170902f0ca00b00156caa94221mr9790838pla.107.1649271328349;
        Wed, 06 Apr 2022 11:55:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b003810782e0cdsm16871427pga.56.2022.04.06.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:55:27 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:55:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Russell Currey <ruscur@russell.cc>
Cc:     linuxppc-dev@lists.ozlabs.org, ajd@linux.ibm.com,
        linux-hardening@vger.kernel.org, jniethe5@gmail.com,
        npiggin@gmail.com, joel@jms.id.au, dja@axtens.net
Subject: Re: [PATCH v5 3/8] powerpc/mm/ptdump: debugfs handler for W+X checks
 at runtime
Message-ID: <202204061154.5A685C10D@keescook>
References: <20200226063551.65363-1-ruscur@russell.cc>
 <20200226063551.65363-4-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226063551.65363-4-ruscur@russell.cc>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

*thread necromancy*

Is this patch still something folks are working on? It'd be nice to be
able to trigger this check at runtime.

-Kees

On Wed, Feb 26, 2020 at 05:35:46PM +1100, Russell Currey wrote:
> Very rudimentary, just
> 
> 	echo 1 > [debugfs]/check_wx_pages
> 
> and check the kernel log.  Useful for testing strict module RWX.
> 
> Updated the Kconfig entry to reflect this.
> 
> Also fixed a typo.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/Kconfig.debug      |  6 ++++--
>  arch/powerpc/mm/ptdump/ptdump.c | 21 ++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 0b063830eea8..e37960ef68c6 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -370,7 +370,7 @@ config PPC_PTDUMP
>  	  If you are unsure, say N.
>  
>  config PPC_DEBUG_WX
> -	bool "Warn on W+X mappings at boot"
> +	bool "Warn on W+X mappings at boot & enable manual checks at runtime"
>  	depends on PPC_PTDUMP && STRICT_KERNEL_RWX
>  	help
>  	  Generate a warning if any W+X mappings are found at boot.
> @@ -384,7 +384,9 @@ config PPC_DEBUG_WX
>  	  of other unfixed kernel bugs easier.
>  
>  	  There is no runtime or memory usage effect of this option
> -	  once the kernel has booted up - it's a one time check.
> +	  once the kernel has booted up, it only automatically checks once.
> +
> +	  Enables the "check_wx_pages" debugfs entry for checking at runtime.
>  
>  	  If in doubt, say "Y".
>  
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index 206156255247..a15e19a3b14e 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -4,7 +4,7 @@
>   *
>   * This traverses the kernel pagetables and dumps the
>   * information about the used sections of memory to
> - * /sys/kernel/debug/kernel_pagetables.
> + * /sys/kernel/debug/kernel_page_tables.
>   *
>   * Derived from the arm64 implementation:
>   * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
> @@ -413,6 +413,25 @@ void ptdump_check_wx(void)
>  	else
>  		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
>  }
> +
> +static int check_wx_debugfs_set(void *data, u64 val)
> +{
> +	if (val != 1ULL)
> +		return -EINVAL;
> +
> +	ptdump_check_wx();
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
> +
> +static int ptdump_check_wx_init(void)
> +{
> +	return debugfs_create_file("check_wx_pages", 0200, NULL,
> +				   NULL, &check_wx_fops) ? 0 : -ENOMEM;
> +}
> +device_initcall(ptdump_check_wx_init);
>  #endif
>  
>  static int ptdump_init(void)
> -- 
> 2.25.1
> 

-- 
Kees Cook
