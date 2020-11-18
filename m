Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C3C5519F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EB120870
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 18:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgKRSzQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:55:16 -0500
Received: from mailin.vu.nl ([130.37.164.17]:19204 "EHLO mailin.vu.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRSzQ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Nov 2020 13:55:16 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 13:55:10 EST
Received: from pexch011a.vu.local (130.37.237.88) by mailin.vu.nl
 (130.37.164.17) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 18 Nov
 2020 19:49:40 +0100
Received: from mail-lf1-f41.google.com (130.37.253.6) by PEXCH011a.vu.local
 (130.37.237.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 18 Nov
 2020 19:49:39 +0100
Received: by mail-lf1-f41.google.com with SMTP id j205so4464157lfj.6;
        Wed, 18 Nov 2020 10:49:39 -0800 (PST)
X-Gm-Message-State: AOAM532Mv3u/MdPvtn30HBrsBebeQsPonALyjoSwZmzDIMt/gCVyP4lz
        KoIbohE1PnmlpqAntjsOuO+epw75L6g9ZorFcEg=
X-Google-Smtp-Source: ABdhPJyDUlwyvkHirCxPHLPbwAUoG+HfF/4HNr/3zTrROrM4M1HbUTO3Irf9zigPwEVffFlMHOVluYkNsrbRo3r7Loo=
X-Received: by 2002:a19:cb93:: with SMTP id b141mr4539094lfg.519.1605725379270;
 Wed, 18 Nov 2020 10:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20201026160518.9212-1-toiwoton@gmail.com> <20201117165455.GN29991@casper.infradead.org>
 <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com> <6810b874c8df456b890d1092273b354a@pexch011a.vu.local>
In-Reply-To: <6810b874c8df456b890d1092273b354a@pexch011a.vu.local>
From:   Cristiano Giuffrida <c.giuffrida@vu.nl>
Date:   Wed, 18 Nov 2020 19:49:26 +0100
X-Gmail-Original-Message-ID: <CANWxqZ=fSi15fi6n-Ei4KJ8MtPcfiU8j=cQS-DycMig6s1oQBA@mail.gmail.com>
Message-ID: <CANWxqZ=fSi15fi6n-Ei4KJ8MtPcfiU8j=cQS-DycMig6s1oQBA@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Mike Rapoport <rppt@kernel.org>
CC:     Topi Miettinen <toiwoton@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [130.37.253.6]
X-ClientProxiedBy: pexch011a.vu.local (130.37.237.105) To PEXCH011a.vu.local
 (130.37.237.105)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Interesting mitigation and discussion!

Regarding the impact on the AnC attack, indeed fine-grained (or full)
mmap() randomization affects AnC in two ways: (i) it breaks the
contiguity of the mmap() region, crippling the sliding primitive AnC
relies on; (ii) it ensures an attacker leaking an address in a
particular VMA can't easily infer addresses in other VMAs. So, in
short, the mitigation does raise the bar against AnC-like attacks and
I see this as a useful addition.

Indeed, we're aware some vendors implemented a similar randomization
strategy in the browser as a mitigation against AnC.

Nonetheless, some additional notes on the two points I raised above:

- (i) [Sliding] Note that an attacker can do away with sliding
depending on the randomization entropy and other available side
channels. For instance, with the recent TagBleed, we show how to
combine a TLB side channel with AnC to exhaust the KASLR entropy.
However, similar attacks should be possible in userland, again
depending on the randomization entropy used. See
https://download.vusec.net/papers/tagbleed_eurosp20.pdf. Combining
side channels with transient/speculative execution attacks can further
lower the bar.

- (ii) [Leaks] Depending on the software vulnerability used for
exploitation, it might not be difficult for an attacker to break
fine-grained randomization across VMAs. That is, leak an address from
VMA 1, use the vulnerability to trigger a normally illegal access to
VMA 2, leak an address from VMA 2, repeat. Of course, the exploit
might take much longer depending on how far on the pointer chasing
chain the target is.

Best,
Cristiano

On Wed, Nov 18, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> (added one of the AnC paper authors)
>
> On Tue, Nov 17, 2020 at 10:21:30PM +0200, Topi Miettinen wrote:
> > On 17.11.2020 18.54, Matthew Wilcox wrote:
> > > On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
> > > > Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> > > > enables full randomization of memory mappings created with mmap(NULL,
> > > > ...). With 2, the base of the VMA used for such mappings is random,
> > > > but the mappings are created in predictable places within the VMA and
> > > > in sequential order. With 3, new VMAs are created to fully randomize
> > > > the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> > > > even if not necessary.
> > >
> > > Is this worth it?
> > >
> > > https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
> >
> > Thanks, very interesting. The paper presents an attack (AnC) which can break
> > ASLR even from JavaScript in browsers. In the process it compares the memory
> > allocators of Firefox and Chrome. Firefox relies on Linux mmap() to
> > randomize the memory location, but Chrome internally chooses the randomized
> > address. The paper doesn't present exact numbers to break ASLR for Chrome
> > case, but it seems to require more effort. Chrome also aggressively
> > randomizes the memory on each allocation, which seems to enable further
> > possibilities for AnC to probe the MMU tables.
> >
> > Disregarding the difference in aggressiveness of memory allocators, I think
> > with sysctl.kernel.randomize_va_space=3, the effort for breaking ASLR with
> > Firefox should be increased closer to Chrome case since mmap() will use the
> > address space more randomly.
> >
> > I have used this setting now for a month without any visible performance
> > issues, so I think the extra bits (for some additional effort to attackers)
> > are definitely worth the low cost.
> >
> > Furthermore, the paper does not describe in detail how the attack would
> > continue after breaking ASLR. Perhaps there are assumptions which are not
> > valid when the different memory areas are no longer sequential. For example,
> > if ASLR is initially broken wrt. the JIT buffer but continuing the attack
> > would require other locations to be determined (like stack, data segment for
> > main exe or libc etc), further efforts may be needed to resolve these
> > locations. With randomize_va_space=2, resolving any address (JIT buffer) can
> > reveal the addresses of many other memory areas but this is not the case
> > with 3.
> >
> > -Topi
>
> --
> Sincerely yours,
> Mike.
