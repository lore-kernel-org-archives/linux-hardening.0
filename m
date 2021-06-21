Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DFC48BE5
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 03:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2677C61164
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 03:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUDVa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFUDVa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 20 Jun 2021 23:21:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27FC061574
        for <linux-hardening@vger.kernel.org>; Sun, 20 Jun 2021 20:19:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso814016pjv.4
        for <linux-hardening@vger.kernel.org>; Sun, 20 Jun 2021 20:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TIejsIF9hmrt8dkbegPQKYcgq6Tdf3AVNugwUeH1ttQ=;
        b=NRC/fzCRfpjQp1qI+nqPJKAkvXcS+xHwPFERHYZ096qATPcMT29Sn7sNuLC9v0ur/D
         ZI91wtT5jN8Ft7utW/iL5llOGsIPylBKIJ4EfW9mYaDLnZxt9Smi4k+J4SzrVrVNcgOR
         1b0AqLX5XE4NmtXOMKPzeLHR8VxO+CH+5QLmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TIejsIF9hmrt8dkbegPQKYcgq6Tdf3AVNugwUeH1ttQ=;
        b=cOf3qGTAwAb93glSrp2psM7QZYpiV5BX+JHxPrDrtcebZGbaZ6xfC8TYzbMmm3XRcj
         ugXH0cfWJcpBHnWyZJ1eGpzYspbQDvSGGBbUCFSP5mS+J/JB+Axk7PPf+02Snk4X+Bpk
         1MR9hB8rmgy/FQzltSOe2V7p7cLO3IR8aTYTZWO19g0DFC0z/rcaHiMVfTGgWB1VQORb
         KlLRl1VtG2gpEAbou1abD7k+fHbZlomjXjh/wxwNCvacEwTCEBuTENbm1QzhQ68iRVYs
         Rg0prrSiLmxrQP/iNXxOylXG04RxdZA+gc2DHGkLcIpkcOximy3JLssPJc8b/H5Ibkzq
         71rQ==
X-Gm-Message-State: AOAM531AaIM6ziggPUG8QRgZAgxGkf8BNSlVWfh+gQDrsNumnmK7DqsC
        A61ZvnXqkS1NFoNMEhQZg3Sjpw==
X-Google-Smtp-Source: ABdhPJyhMVprA7LNSX+dPSa0z07+LT8QCOJ/gQGGEou7StHIiEQ5Fr7dSCWiQH7XT6cutt/nrJjAMQ==
X-Received: by 2002:a17:90a:4491:: with SMTP id t17mr21732313pjg.30.1624245554543;
        Sun, 20 Jun 2021 20:19:14 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id 18sm16957096pje.22.2021.06.20.20.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 20:19:14 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: Re: [RESEND PATCH v4 08/11] powerpc: Initialize and use a temporary
 mm for patching
In-Reply-To: <20210506043452.9674-9-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
 <20210506043452.9674-9-cmr@linux.ibm.com>
Date:   Mon, 21 Jun 2021 13:19:10 +1000
Message-ID: <87r1gvj45t.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Chris,

> +	/*
> +	 * Choose a randomized, page-aligned address from the range:
> +	 * [PAGE_SIZE, DEFAULT_MAP_WINDOW - PAGE_SIZE]
> +	 * The lower address bound is PAGE_SIZE to avoid the zero-page.
> +	 * The upper address bound is DEFAULT_MAP_WINDOW - PAGE_SIZE to stay
> +	 * under DEFAULT_MAP_WINDOW with the Book3s64 Hash MMU.
> +	 */
> +	patching_addr = PAGE_SIZE + ((get_random_long() & PAGE_MASK)
> +			% (DEFAULT_MAP_WINDOW - 2 * PAGE_SIZE));

I checked and poking_init() comes after the functions that init the RNG,
so this should be fine. The maths - while a bit fiddly to reason about -
does check out.

> +
> +	/*
> +	 * PTE allocation uses GFP_KERNEL which means we need to pre-allocate
> +	 * the PTE here. We cannot do the allocation during patching with IRQs
> +	 * disabled (ie. "atomic" context).
> +	 */
> +	ptep = get_locked_pte(patching_mm, patching_addr, &ptl);
> +	BUG_ON(!ptep);
> +	pte_unmap_unlock(ptep, ptl);
> +}
>  
>  #if IS_BUILTIN(CONFIG_LKDTM)
>  unsigned long read_cpu_patching_addr(unsigned int cpu)
>  {
> -	return (unsigned long)(per_cpu(text_poke_area, cpu))->addr;
> +	return patching_addr;
>  }
>  #endif
>  
> -static int text_area_cpu_up(unsigned int cpu)
> +struct patch_mapping {
> +	spinlock_t *ptl; /* for protecting pte table */
> +	pte_t *ptep;
> +	struct temp_mm temp_mm;
> +};
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
> +
> +static inline int hash_prefault_mapping(pgprot_t pgprot)
>  {
> -	struct vm_struct *area;
> +	int err;
>  
> -	area = get_vm_area(PAGE_SIZE, VM_ALLOC);
> -	if (!area) {
> -		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
> -			cpu);
> -		return -1;
> -	}
> -	this_cpu_write(text_poke_area, area);
> +	if (radix_enabled())
> +		return 0;
>  
> -	return 0;
> -}
> +	err = slb_allocate_user(patching_mm, patching_addr);
> +	if (err)
> +		pr_warn("map patch: failed to allocate slb entry\n");
>  

Here if slb_allocate_user() fails, you'll print a warning and then fall
through to the rest of the function. You do return err, but there's a
later call to hash_page_mm() that also sets err. Can slb_allocate_user()
fail while hash_page_mm() succeeds, and would that be a problem?

> -static int text_area_cpu_down(unsigned int cpu)
> -{
> -	free_vm_area(this_cpu_read(text_poke_area));
> -	return 0;
> +	err = hash_page_mm(patching_mm, patching_addr, pgprot_val(pgprot), 0,
> +			   HPTE_USE_KERNEL_KEY);
> +	if (err)
> +		pr_warn("map patch: failed to insert hashed page\n");
> +
> +	/* See comment in switch_slb() in mm/book3s64/slb.c */
> +	isync();
> +

The comment reads:

	/*
	 * Synchronize slbmte preloads with possible subsequent user memory
	 * address accesses by the kernel (user mode won't happen until
	 * rfid, which is safe).
	 */
         isync();

I have to say having read the description of isync I'm not 100% sure why
that's enough (don't we also need stores to complete?) but I'm happy to
take commit 5434ae74629a ("powerpc/64s/hash: Add a SLB preload cache")
on trust here!

I think it does make sense for you to have that barrier here: you are
potentially about to start poking at the memory mapped through that SLB
entry so you should make sure you're fully synchronised.

> +	return err;
>  }
>  

> +	init_temp_mm(&patch_mapping->temp_mm, patching_mm);
> +	use_temporary_mm(&patch_mapping->temp_mm);
>  
> -	pmdp = pmd_offset(pudp, addr);
> -	if (unlikely(!pmdp))
> -		return -EINVAL;
> +	/*
> +	 * On Book3s64 with the Hash MMU we have to manually insert the SLB
> +	 * entry and HPTE to prevent taking faults on the patching_addr later.
> +	 */
> +	return(hash_prefault_mapping(pgprot));

hmm, `return hash_prefault_mapping(pgprot);` or
`return (hash_prefault_mapping((pgprot));` maybe?

Kind regards,
Daniel
