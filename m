Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C8C43457
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49107221FF
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHwEU8Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgJHRXF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgJHRXD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 13:23:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4922BC061755;
        Thu,  8 Oct 2020 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sTFqyXVXgvDGuEMygTQMR9pwPBQV4VgkgBJfdzUfbV4=; b=bHwEU8Vz+pghcLW/H8eaawNm4L
        mNdF8DL6q6KNYq153P8q0+z0dvaoQaXaPIjMj5+UehW9JUuju3vbmphUKjM61AphQN7/6idJbcTGy
        K3/98yOUGuLn1dlgHM350zkZjVX37/hlVdHfx11Tq02xql0ir0uT2s8PvjQAEooQ5oc/9EGrmFRJN
        w8t7eydC7myVfzozSkaDz2/NYGTt/c856AiB/5msvBmVp36Bds3yosoGrkqeZD3kf4lETAl8kNlNZ
        iB6lmcByFuLDVKnCIBPmJAwJU32S+5wMNO2WgnZW/3UImWCAW56LVTWPexeFCWgGO0a3Ukvfo5NAO
        fqAvaJ8A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQZd6-0008Kh-Jj; Thu, 08 Oct 2020 17:23:00 +0000
Date:   Thu, 8 Oct 2020 18:23:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201008172300.GL20115@casper.infradead.org>
References: <20201008165408.38228-1-toiwoton@gmail.com>
 <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 08, 2020 at 07:13:51PM +0200, Jann Horn wrote:
> You may want to consider whether it would be better to store
> information about free memory per subtree in the VMA tree, together
> with the maximum gap size that is already stored in each node, and
> then walk down the tree randomly, with the randomness weighted by free
> memory in the subtrees, but ignoring subtrees whose gaps are too
> small.

Please, no.  We're trying to get rid of the rbtree, not enhance it
further.  The new data structure is a B-tree and we'd rather not burden
it with extra per-node information (... although if we have to, we could)

> And for expanding stacks, it might be a good idea for other
> reasons as well (locking consistency) to refactor them such that the
> size in the VMA tree corresponds to the maximum expansion of the stack
> (and if an allocation is about to fail, shrink such stack mappings).

We're doing that as part of the B-tree ;-)  Although not the shrink
stack mappings part ...
