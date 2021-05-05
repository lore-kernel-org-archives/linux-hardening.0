Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FDCC433B4
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B634261157
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 11:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhEEL65 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhEEL65 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 07:58:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF149C061574;
        Wed,  5 May 2021 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FJVYW0nVvzqzV0WuVSs2TE+406TDgUZdxaAg4wu6QtQ=; b=nJLzibjO7NeYl3c8yjFLSafo+H
        nPW9d5mpe6/UtkdfbkiY8dlbuJiyUAJVhUDchJ0hrxMm6YWssSXl8nm8yx1w6e6SD8ASz+bx15rJX
        lNU2/cH5dLiCzBV/LtxSgGkrZeoL5kizOm5brfC1OOfnmvue+nHegEoUBa+gk3hKb1pRGZNob7b/H
        ECFF+QqD6WpyPg7PPCh3pPs70ro2wTZBa2OgYya5a0j4wDd/ue8jYhDtmZrpOQoUSP4PkFRDrds5m
        rU07lsDHCE3TGxxbc86eji6Ptn1c4tWQ/Vn2zzzOlRFOZIh+ar/V+ZaKq9VGyC2tigC9Vjs2c5pSy
        u5NjT/4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leG8X-000HUJ-AN; Wed, 05 May 2021 11:56:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 970023001CD;
        Wed,  5 May 2021 13:56:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 238D92B73EFF8; Wed,  5 May 2021 13:56:16 +0200 (CEST)
Date:   Wed, 5 May 2021 13:56:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <YJKH4HDuCGLArdmp@hirez.programming.kicks-ass.net>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <d01c7845-6f9c-6770-c861-e624c3e2bfc5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01c7845-6f9c-6770-c861-e624c3e2bfc5@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 05, 2021 at 01:08:35PM +0200, Vlastimil Babka wrote:
> On 5/5/21 2:30 AM, Rick Edgecombe wrote:

> > Why use PKS for this?
> > =====================
> > PKS is an upcoming CPU feature that allows supervisor virtual memory 
> > permissions to be changed without flushing the TLB, like PKU does for user 
> > memory. Protecting page tables would normally be really expensive because you 
> > would have to do it with paging itself. PKS helps by providing a way to toggle 
> > the writability of the page tables with just a per-cpu MSR.
> 
> I can see in patch 8/9 that you are flipping the MSR around individual
> operations on page table entries. In my patch I hooked making the page table
> writable to obtaining the page table lock (IIRC I had only the PTE level fully
> handled though). Wonder if that would be better tradeoff even for your MSR approach?

There's also the HIGHPTE code we could abuse to kmap an alias while
we're at it.
