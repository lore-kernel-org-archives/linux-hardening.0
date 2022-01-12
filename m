Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A6CC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jan 2022 23:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiALXJn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jan 2022 18:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiALXI5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jan 2022 18:08:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC74C061748
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jan 2022 15:08:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o3so8088309pjs.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jan 2022 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jJzahq+HPzX/abuwJWvinR+DS76x14ce5ZSXd6cNEYE=;
        b=E9iLXzrcm7o1xcsO8pvfhfYnYrjB2FzW9LgBFU9t3KlEGJDV0pg3F+Fp9G5xBILuAA
         x5joBChWFQC8bDg2/jkRVXOZZNLnUUPbQY7ueXiER6+SrXHiMudPUZ8sVcZSVtvsnIq4
         fMo+pvQKRK0KiZjHzXzNOpz/4flD8m6X+Y4R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJzahq+HPzX/abuwJWvinR+DS76x14ce5ZSXd6cNEYE=;
        b=umzJTThvqWxdMTE/VtevDYZ1VIuTGK60x1L+Y2bGpZxvhW97H61FmYDAHEfg7SRB1u
         rLMpKw5NIrvPZq2o1/MvjbeKlG5VNJGN/nAxx971cSBaIQeSdkfvjRCUoUKJJZ4nn9FS
         VPYZVOdnPUdVZ1t/+iY8ueNlFVt7t4QbKCczs+ruVOnqQYw54tYvJz5elm3oBfiDncnd
         ry9qZzNt6BtfK07prtgIs0qCBS3rIoedEuDY+RzlpIbu752b/kx+SQsYCrDXtwD1yFSj
         DTq/aZVAq+F7aY7hs3bUbwAey3ASGS+DZhtGThbe7YwyCKVPtFhFDA/ywMX/yVBWXv6H
         UJeQ==
X-Gm-Message-State: AOAM533nNgYRZtk2+axMOUyB9rKo6h+gpKheKhdPGLywJzr1+XdQJc9L
        wFgB14PbYl+ad3ah3ajjhI2YcA==
X-Google-Smtp-Source: ABdhPJz7MEpgx/LSUyvQMh757t0bn4rWS2glxQz6eus1r7MhmMDlH4+p+I8M4Y+vt1QYbyww+pE8jw==
X-Received: by 2002:a63:9712:: with SMTP id n18mr1615797pge.594.1642028936695;
        Wed, 12 Jan 2022 15:08:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm626536pfu.2.2022.01.12.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:08:56 -0800 (PST)
Date:   Wed, 12 Jan 2022 15:08:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/4] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <202201121508.2646AB2@keescook>
References: <20220110231530.665970-1-willy@infradead.org>
 <20220110231530.665970-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110231530.665970-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 10, 2022 at 11:15:30PM +0000, Matthew Wilcox (Oracle) wrote:
> There isn't enough information to make this a useful check any more;
> the useful parts of it were moved in earlier patches, so remove this
> set of checks now.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thank you!

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  mm/usercopy.c    | 61 ------------------------------------------------
>  security/Kconfig | 13 +----------
>  2 files changed, 1 insertion(+), 73 deletions(-)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index e1cb98087a05..94831945d9e7 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -158,64 +158,6 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>  		usercopy_abort("null address", NULL, to_user, ptr, n);
>  }
>  
> -/* Checks for allocs that are marked in some way as spanning multiple pages. */
> -static inline void check_page_span(const void *ptr, unsigned long n,
> -				   struct page *page, bool to_user)
> -{
> -#ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
> -	const void *end = ptr + n - 1;
> -	bool is_reserved, is_cma;
> -
> -	/*
> -	 * Sometimes the kernel data regions are not marked Reserved (see
> -	 * check below). And sometimes [_sdata,_edata) does not cover
> -	 * rodata and/or bss, so check each range explicitly.
> -	 */
> -
> -	/* Allow reads of kernel rodata region (if not marked as Reserved). */
> -	if (ptr >= (const void *)__start_rodata &&
> -	    end <= (const void *)__end_rodata) {
> -		if (!to_user)
> -			usercopy_abort("rodata", NULL, to_user, 0, n);
> -		return;
> -	}
> -
> -	/* Allow kernel data region (if not marked as Reserved). */
> -	if (ptr >= (const void *)_sdata && end <= (const void *)_edata)
> -		return;
> -
> -	/* Allow kernel bss region (if not marked as Reserved). */
> -	if (ptr >= (const void *)__bss_start &&
> -	    end <= (const void *)__bss_stop)
> -		return;
> -
> -	/* Is the object wholly within one base page? */
> -	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
> -		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
> -		return;
> -
> -	/*
> -	 * Reject if range is entirely either Reserved (i.e. special or
> -	 * device memory), or CMA. Otherwise, reject since the object spans
> -	 * several independently allocated pages.
> -	 */
> -	is_reserved = PageReserved(page);
> -	is_cma = is_migrate_cma_page(page);
> -	if (!is_reserved && !is_cma)
> -		usercopy_abort("spans multiple pages", NULL, to_user, 0, n);
> -
> -	for (ptr += PAGE_SIZE; ptr <= end; ptr += PAGE_SIZE) {
> -		page = virt_to_head_page(ptr);
> -		if (is_reserved && !PageReserved(page))
> -			usercopy_abort("spans Reserved and non-Reserved pages",
> -				       NULL, to_user, 0, n);
> -		if (is_cma && !is_migrate_cma_page(page))
> -			usercopy_abort("spans CMA and non-CMA pages", NULL,
> -				       to_user, 0, n);
> -	}
> -#endif
> -}
> -
>  static inline void check_heap_object(const void *ptr, unsigned long n,
>  				     bool to_user)
>  {
> @@ -257,9 +199,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  		unsigned long offset = ptr - folio_address(folio);
>  		if (offset + n > folio_size(folio))
>  			usercopy_abort("page alloc", NULL, to_user, offset, n);
> -	} else {
> -		/* Verify object does not incorrectly span multiple pages. */
> -		check_page_span(ptr, n, folio_page(folio, 0), to_user);
>  	}
>  }
>  
> diff --git a/security/Kconfig b/security/Kconfig
> index 0b847f435beb..5b289b329a51 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -160,20 +160,9 @@ config HARDENED_USERCOPY
>  	  copy_from_user() functions) by rejecting memory ranges that
>  	  are larger than the specified heap object, span multiple
>  	  separately allocated pages, are not on the process stack,
> -	  or are part of the kernel text. This kills entire classes
> +	  or are part of the kernel text. This prevents entire classes
>  	  of heap overflow exploits and similar kernel memory exposures.
>  
> -config HARDENED_USERCOPY_PAGESPAN
> -	bool "Refuse to copy allocations that span multiple pages"
> -	depends on HARDENED_USERCOPY
> -	depends on EXPERT
> -	help
> -	  When a multi-page allocation is done without __GFP_COMP,
> -	  hardened usercopy will reject attempts to copy it. There are,
> -	  however, several cases of this in the kernel that have not all
> -	  been removed. This config is intended to be used only while
> -	  trying to find such users.
> -
>  config FORTIFY_SOURCE
>  	bool "Harden common str/mem functions against buffer overflows"
>  	depends on ARCH_HAS_FORTIFY_SOURCE
> -- 
> 2.33.0
> 

-- 
Kees Cook
