Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90DC5519F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1033422252
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rChRZ6rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgKTP1X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 10:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgKTP1W (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 10:27:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7872C0613CF;
        Fri, 20 Nov 2020 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WEGRqWmAaVy7NsoIgHt+1Yd4blVL6IRZKs2HGIg6ebw=; b=rChRZ6rYw5dnnnfCx5P2rQeK61
        z05bLEUKhf/N3NeViJv7tyX8iAya9+vyPV3l2Qa3Sh5QEVOcVajxXR8Zp4B/nknmK0S8w7cJuA5uf
        REwzt6Lqzn4QWf65uEstb7u3fNYqx2a7CbRUHTnFvLQAXl/lE7v3Tk6ebbAm80VIvQuRPqk91TYC1
        Hvo7i3mExMmA6aMHLWjajjst78z6pJEN9z+TA1I3xwdBOgwy4Reu/UVNQeJ8IwuZtRUc8p+8zRD8+
        hXZ23YThH8lUVM7uL/JKadikbjVrUd6MtfTrb1LGyrnLEPBJOMcBLClbBHMHZVJl27SDeWkKisaMF
        7G7GB7Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg8Jg-0003E7-JU; Fri, 20 Nov 2020 15:27:17 +0000
Date:   Fri, 20 Nov 2020 15:27:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Mike Rapoport <rppt@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201120152716.GA4327@casper.infradead.org>
References: <20201026160518.9212-1-toiwoton@gmail.com>
 <20201117165455.GN29991@casper.infradead.org>
 <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com>
 <6810b874c8df456b890d1092273b354a@pexch011a.vu.local>
 <CANWxqZ=fSi15fi6n-Ei4KJ8MtPcfiU8j=cQS-DycMig6s1oQBA@mail.gmail.com>
 <0da9cb0a4d1a494d9ec15404f8decf01@pexch011a.vu.local>
 <CANWxqZkdSMFM4T2J-KNK_K-SHfbRnk3EUcgHAF9Xj+SRqDxXHw@mail.gmail.com>
 <74fd6d3b-936f-94f5-c183-a2e6bc7a9e35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fd6d3b-936f-94f5-c183-a2e6bc7a9e35@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 10:38:21AM +0200, Topi Miettinen wrote:
> On 20.11.2020 0.20, Cristiano Giuffrida wrote:
> > Indeed it's nontrivial to get similar randomization guarantees for the
> > kernel. I mentioned TagBleed because similar combined AnC + TLB
> > attacks should also be possible in the browser. We just happened to
> > focus on the kernel with TagBleed.
> 
> Perhaps kernel objects could be also compiled as relocatable shared objects,
> like shared libraries for user applications, so that a they could be
> relocated independently away from the base address of main kernel. Also
> compiling the kernel with -mcmodel=large could allow various segments (code,
> rodata, data) to be located more freely. These would make the attacker to do
> more probing. Again, pointers between the objects may make these less
> useful.

They are relocatable shared objects.  They're loaded into the vmalloc
area on some architectures but x86 has a special MODULES_VADDR region.
Maybe just jumbling them into the general vmalloc address range would be
beneficial from a security point of view?  I suspect it's not all
that useful because most modules are loaded early on.

We seem to have randomness mixed into the vmalloc allocations with
DEBUG_AUGMENT_LOWEST_MATCH_CHECK, but there doesn't seem to be an
ASLR option to vmalloc ... Uladzislau?

