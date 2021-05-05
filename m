Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20447C43460
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 18:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0232F613C3
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 18:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhEESqf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 14:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234475AbhEESqe (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 14:46:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74B9F6105A;
        Wed,  5 May 2021 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620240337;
        bh=tr9FqTMNy8Aj06BcquW7hrOWHRk5sO0oNB/v3F7fSGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4h+XW2JoDzusBFB9PItP8owvyEeRbEBjS7C+MbTIM0pm8gW1/7Sgm3uiTnhr4l0q
         YkH7+NKvTuQC45/hUyhq5biEIbq09EV+IPth0gS+98hzzwncgLiZHExMu8vukCqhY3
         PNztdmE9l2g3ophWibUn6lvKlOJe/C/11NDC6/DcaH6qcq3PN4eQP12imHVas1+rXJ
         gj0NfbuQ99F/T76cFFCGYkgDWsv7R4T6SZYqCncokXbBtSfHkxCpgq8repwdM9lSF8
         TJJw3WF5R5H594VU3jmwl3NLWXutN9y1bHlSMTi+09MYV1ciHXSB8vuy7FJnvX+PPq
         LdPR40kMTc13A==
Date:   Wed, 5 May 2021 21:45:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/9] x86/mm/cpa: Add grouped page allocations
Message-ID: <YJLnyJP755XAPZNX@kernel.org>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <20210505003032.489164-4-rick.p.edgecombe@intel.com>
 <YJKKu7kMCtCuel2L@kernel.org>
 <YJKY+Ccxfe9wD0iP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKY+Ccxfe9wD0iP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 05, 2021 at 03:09:12PM +0200, Peter Zijlstra wrote:
> On Wed, May 05, 2021 at 03:08:27PM +0300, Mike Rapoport wrote:
> > On Tue, May 04, 2021 at 05:30:26PM -0700, Rick Edgecombe wrote:
> > > For x86, setting memory permissions on the direct map results in fracturing
> > > large pages. Direct map fracturing can be reduced by locating pages that
> > > will have their permissions set close together.
> > > 
> > > Create a simple page cache that allocates pages from huge page size
> > > blocks. Don't guarantee that a page will come from a huge page grouping,
> > > instead fallback to non-grouped pages to fulfill the allocation if
> > > needed. Also, register a shrinker such that the system can ask for the
> > > pages back if needed. Since this is only needed when there is a direct
> > > map, compile it out on highmem systems.
> > 
> > I only had time to skim through the patches, I like the idea of having a
> > simple cache that allocates larger pages with a fallback to basic page
> > size.
> > 
> > I just think it should be more generic and closer to the page allocator.
> > I was thinking about adding a GFP flag that will tell that the allocated
> > pages should be removed from the direct map. Then alloc_pages() could use
> > such cache whenever this GFP flag is specified with a fallback for lower
> > order allocations.
> 
> That doesn't provide enough information I think. Removing from direct
> map isn't the only consideration, you also want to group them by the
> target protection bits such that we don't get to use 4k pages quite so
> much.

Unless I'm missing something we anyway hand out 4k pages from the cache and
the neighbouring 4k may end up with different protections.

This is also similar to what happens in the set Rick posted a while ago to
support grouped vmalloc allocations:

[1] https://lore.kernel.org/lkml/20210405203711.1095940-1-rick.p.edgecombe@intel.com/

-- 
Sincerely yours,
Mike.
