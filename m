Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD9C433E7
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC02320708
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qarES/+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgJHRlZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgJHRlZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 13:41:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E18C061755;
        Thu,  8 Oct 2020 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rhut7fqpaoq3MhbllV5fKKQkrXAlHWXe1jVhLgupsFg=; b=qarES/+1XNKcQx3evKHbUX/o/2
        pEemqwzwsLRa6tFhQuoQetXxyM8+ojno0EFBK4RD5V6GfxK6J9NFHuhYpKdrHuAZ3Qs9nSIms4vQD
        z9vcXOezBzjGYCkyfH3XAMVD7gvpjRUeCmXGNntP4tCFaYvcGyH6YLj5+1pAPB4u/Of+1oGDT94vF
        ZGbRTjwNiJ8Lh4Qe0zpYblKI5Q7Dek1Zd4riizFumCC+cJm+Fk0SjuizMXUojXt0giMYyxJ4EmMeN
        LSV/eXglJL72XqxplGsbGLyiy3+4duNvqgOR1RZcj/2vQZmpVbaiyzil14ExISXZSJdD6hfXeaECr
        CeZ+PHdg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQZus-00015k-VS; Thu, 08 Oct 2020 17:41:23 +0000
Date:   Thu, 8 Oct 2020 18:41:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201008174122.GM20115@casper.infradead.org>
References: <20201008165408.38228-1-toiwoton@gmail.com>
 <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
 <20201008172300.GL20115@casper.infradead.org>
 <CAG48ez3-uvDXL7-WBapEJMHrkXYpnAw=AgbP2evOZgNMFWKy-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3-uvDXL7-WBapEJMHrkXYpnAw=AgbP2evOZgNMFWKy-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 08, 2020 at 07:26:31PM +0200, Jann Horn wrote:
> On Thu, Oct 8, 2020 at 7:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Thu, Oct 08, 2020 at 07:13:51PM +0200, Jann Horn wrote:
> > > And for expanding stacks, it might be a good idea for other
> > > reasons as well (locking consistency) to refactor them such that the
> > > size in the VMA tree corresponds to the maximum expansion of the stack
> > > (and if an allocation is about to fail, shrink such stack mappings).
> >
> > We're doing that as part of the B-tree ;-)  Although not the shrink
> > stack mappings part ...
> 
> Wheee, thanks! Finally no more data races on ->vm_start?

Ah, maybe still that.  The B-tree records the start of the mapping in
the tree, but we still keep vma->vm_start as pointing to the current top
of the stack (it's still the top if it grows down ... right?)  The key is
that these numbers may now be different, so from the tree's point of view,
the vm addresses for 1MB below the stack appear to be occupied.  From the
VMA's point of view, the stack finishes where it was last accessed.

We also get rid of the insanity of "return the next VMA if there's no
VMA at this address" which most of the callers don't want and have to
check for.  Again, from the tree's point of view, there is a VMA at this
address, but from the VMA's point of view, it'll need to expand to reach
that address.

I don't think this piece is implemented yet, but it's definitely planned.
