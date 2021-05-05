Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA07C433ED
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A652861157
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 08:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhEEIxt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 04:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhEEIxt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 04:53:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D2C061574;
        Wed,  5 May 2021 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pc4TJTtsaYg+JC4EqRb6ZF36MrGpcI2IanfOOcR4rOU=; b=TtiWTgZUIkFhG5iIAJUPK8AZN+
        mupza1SFIiMyuink4uyHg4DZHOZ/sIj7qjsjUICjmsurEzqTtAKaFfpBtqwhUAdifNb6yip1+xYB8
        3U8SCOreh4IU/YBlHQG5q4TBPXKYdRr9mRvc409WytIQB1Q/2o4IMFzQXljj87we9Jn8kwMNVLilD
        ZlHv0FRRO2z/d5ueAxKFMGoUyYewE3ZxyH6gCUGcsAjCjrv5ECwlBTyocFdq+zV5mqz77A+UFeK4A
        MExTgSrIYYfztQgCd5BPEjxisT0yORHWq3Zd0m+OSUDFvQyczSxiI7Z4dpoDahsmbB6wcPT0pNM/X
        rzCMKjcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leDG8-0006lB-HE; Wed, 05 May 2021 08:52:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E53A2300103;
        Wed,  5 May 2021 10:51:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4A472D74E1CF; Wed,  5 May 2021 10:51:55 +0200 (CEST)
Date:   Wed, 5 May 2021 10:51:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, luto@kernel.org, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/9] x86, mm: Use cache of page tables
Message-ID: <YJJcqyrMEJipbevT@hirez.programming.kicks-ass.net>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <20210505003032.489164-6-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505003032.489164-6-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 04, 2021 at 05:30:28PM -0700, Rick Edgecombe wrote:
> @@ -54,6 +98,8 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>  {
>  	pgtable_pte_page_dtor(pte);
>  	paravirt_release_pte(page_to_pfn(pte));
> +	/* Set Page Table so swap knows how to free it */
> +	__SetPageTable(pte);
>  	paravirt_tlb_remove_table(tlb, pte);
>  }
>  
> @@ -70,12 +116,16 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>  	tlb->need_flush_all = 1;
>  #endif
>  	pgtable_pmd_page_dtor(page);
> +	/* Set Page Table so swap nows how to free it */
> +	__SetPageTable(virt_to_page(pmd));
>  	paravirt_tlb_remove_table(tlb, page);
>  }
>  
>  #if CONFIG_PGTABLE_LEVELS > 3
>  void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>  {
> +	/* Set Page Table so swap nows how to free it */
> +	__SetPageTable(virt_to_page(pud));
>  	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
>  	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
>  }
> @@ -83,6 +133,8 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>  #if CONFIG_PGTABLE_LEVELS > 4
>  void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
>  {
> +	/* Set Page Table so swap nows how to free it */
> +	__SetPageTable(virt_to_page(p4d));
>  	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
>  	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
>  }

This, to me, seems like a really weird place to __SetPageTable(), why
can't we do that on allocation?

> @@ -888,6 +889,12 @@ void release_pages(struct page **pages, int nr)
>  			continue;
>  		}
>  
> +		if (PageTable(page)) {
> +			__ClearPageTable(page);
> +			free_table(page);
> +			continue;
> +		}
> +
>  		if (!put_page_testzero(page))
>  			continue;
>  
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3cdee7b11da9..a60ec3d4ab21 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -22,6 +22,7 @@
>  #include <linux/swap_slots.h>
>  #include <linux/huge_mm.h>
>  #include <linux/shmem_fs.h>
> +#include <asm/pgalloc.h>
>  #include "internal.h"
>  
>  /*
> @@ -310,6 +311,11 @@ static inline void free_swap_cache(struct page *page)
>  void free_page_and_swap_cache(struct page *page)
>  {
>  	free_swap_cache(page);
> +	if (PageTable(page)) {
> +		__ClearPageTable(page);
> +		free_table(page);
> +		return;
> +	}
>  	if (!is_huge_zero_page(page))
>  		put_page(page);
>  }

And then free_table() can __ClearPageTable() and all is nice and
symmetric and all this weirdness goes away, no?
