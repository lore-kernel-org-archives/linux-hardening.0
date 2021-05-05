Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBDC433B4
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0609613BE
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhEENUe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhEENUd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 09:20:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA8C061574;
        Wed,  5 May 2021 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=098DjoJGnAPT9eohEm8f+BcKiqTmmyQ4t8gfr7TicWI=; b=W/WiWgFI7/UtyDk6pyHlsqYp4K
        tYY8VbPIiaG2BWw5+Vw/D6CqfT8qaPGMRiSsLCW9RhfQIdPcdRbpLGtWXAufrZDubMi/1ZjoU1Cl1
        qlEF64APhf9cI9xQJ7mHF64do+531IRURlEmwtEIRT590CGh6fNyOi78tmtxv8zU/Hys5Ve7fEv4U
        sXaG7AzMeCHPmy3XV3h1yOYGIgvgL8cLVkkWZKxqeyUtXdS4kujL19WYnqA421aSy4AD7xxt3G89S
        LE/IeGEMKQvnznVqRd72pPp1OJSIELgz6zT8K/HRNelZfqXRikgLOkef6YPUlnlA95kTyqckm7KQ3
        rkRg0P+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leHQt-001HmQ-NC; Wed, 05 May 2021 13:19:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C2143001CD;
        Wed,  5 May 2021 15:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 085D3203E67F7; Wed,  5 May 2021 15:19:19 +0200 (CEST)
Date:   Wed, 5 May 2021 15:19:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/9] x86, mm: Use cache of page tables
Message-ID: <YJKbVueq3nqXwnip@hirez.programming.kicks-ass.net>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <20210505003032.489164-6-rick.p.edgecombe@intel.com>
 <YJJcqyrMEJipbevT@hirez.programming.kicks-ass.net>
 <YJKK5RUMOzv488DO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKK5RUMOzv488DO@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 05, 2021 at 03:09:09PM +0300, Mike Rapoport wrote:
> On Wed, May 05, 2021 at 10:51:55AM +0200, Peter Zijlstra wrote:
> > On Tue, May 04, 2021 at 05:30:28PM -0700, Rick Edgecombe wrote:
> > > @@ -54,6 +98,8 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
> > >  {
> > >  	pgtable_pte_page_dtor(pte);
> > >  	paravirt_release_pte(page_to_pfn(pte));
> > > +	/* Set Page Table so swap knows how to free it */
> > > +	__SetPageTable(pte);
> > >  	paravirt_tlb_remove_table(tlb, pte);
> > >  }
> > >  
> > > @@ -70,12 +116,16 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
> > >  	tlb->need_flush_all = 1;
> > >  #endif
> > >  	pgtable_pmd_page_dtor(page);
> > > +	/* Set Page Table so swap nows how to free it */
> > > +	__SetPageTable(virt_to_page(pmd));
> > >  	paravirt_tlb_remove_table(tlb, page);
> > >  }
> > >  
> > >  #if CONFIG_PGTABLE_LEVELS > 3
> > >  void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
> > >  {
> > > +	/* Set Page Table so swap nows how to free it */
> > > +	__SetPageTable(virt_to_page(pud));
> > >  	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
> > >  	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
> > >  }
> > > @@ -83,6 +133,8 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
> > >  #if CONFIG_PGTABLE_LEVELS > 4
> > >  void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
> > >  {
> > > +	/* Set Page Table so swap nows how to free it */
> > > +	__SetPageTable(virt_to_page(p4d));
> > >  	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
> > >  	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
> > >  }
> > 
> > This, to me, seems like a really weird place to __SetPageTable(), why
> > can't we do that on allocation?
> 
> We call __ClearPageTable() at pgtable_pxy_page_dtor(), so at least for pte
> and pmd we need to somehow tell release_pages() what kind of page it was.

Hurph, right, but then the added comment is misleading; s/Set/Reset/g.
Still I'm thinking that if we do these allocators, moving the set/clear
to the allocator would be the most natural place, perhaps we can remove
them from the {c,d}tor.
