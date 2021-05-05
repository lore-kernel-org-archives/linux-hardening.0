Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D39CC433B4
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 13:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9D61078
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 13:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEENLW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhEENLV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 09:11:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A86C061574;
        Wed,  5 May 2021 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RCnOPkMC/G1Vcdql+vcGlBPx7y6AVxksEchUg4RxzkQ=; b=HfZvW5qU94p4oR2x4wqzGUPz2C
        oUXMRaZvZIiKUS0yu7zzm9G8JgWZKmdwbOIuReAcoiBJNS2SeFYoosJWcnydI27HD4ZLYn9SYeL+W
        BXZkVVtX1MN8k7232jA7Vj7pPv3nuhhdRuDgOeHiiLjJL1JXEbaWaNfMo7MjFV2tnhF5jbwLGzGt2
        wmR6p75zHIsBDQ6GkXyT+tVRkvbmuibjXvIdM08ySYeuUagX9MzvqKuyg3r5tV41aIUFmF2iBKqPj
        xYjLfvxZhXqEqjKGsPw88JEHUSK7oFKjoAGuz41FoVzkFAnbsvnonAkNYrS0LgisF2C8ubNhwx4pz
        s5bxp44g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leHHB-000LZH-U8; Wed, 05 May 2021 13:09:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAC99300103;
        Wed,  5 May 2021 15:09:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B8FB203E67C5; Wed,  5 May 2021 15:09:12 +0200 (CEST)
Date:   Wed, 5 May 2021 15:09:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/9] x86/mm/cpa: Add grouped page allocations
Message-ID: <YJKY+Ccxfe9wD0iP@hirez.programming.kicks-ass.net>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <20210505003032.489164-4-rick.p.edgecombe@intel.com>
 <YJKKu7kMCtCuel2L@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKKu7kMCtCuel2L@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 05, 2021 at 03:08:27PM +0300, Mike Rapoport wrote:
> On Tue, May 04, 2021 at 05:30:26PM -0700, Rick Edgecombe wrote:
> > For x86, setting memory permissions on the direct map results in fracturing
> > large pages. Direct map fracturing can be reduced by locating pages that
> > will have their permissions set close together.
> > 
> > Create a simple page cache that allocates pages from huge page size
> > blocks. Don't guarantee that a page will come from a huge page grouping,
> > instead fallback to non-grouped pages to fulfill the allocation if
> > needed. Also, register a shrinker such that the system can ask for the
> > pages back if needed. Since this is only needed when there is a direct
> > map, compile it out on highmem systems.
> 
> I only had time to skim through the patches, I like the idea of having a
> simple cache that allocates larger pages with a fallback to basic page
> size.
> 
> I just think it should be more generic and closer to the page allocator.
> I was thinking about adding a GFP flag that will tell that the allocated
> pages should be removed from the direct map. Then alloc_pages() could use
> such cache whenever this GFP flag is specified with a fallback for lower
> order allocations.

That doesn't provide enough information I think. Removing from direct
map isn't the only consideration, you also want to group them by the
target protection bits such that we don't get to use 4k pages quite so
much.
