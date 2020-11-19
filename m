Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911DBC388F9
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DC2224E
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Nov 2020 22:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKSWVR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:21:17 -0500
Received: from mailin.vu.nl ([130.37.164.19]:26546 "EHLO mailin.vu.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgKSWVR (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Nov 2020 17:21:17 -0500
Received: from pexch011a.vu.local (130.37.237.88) by mailin.vu.nl
 (130.37.164.19) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 19 Nov
 2020 23:21:06 +0100
Received: from mail-lf1-f46.google.com (130.37.253.6) by PEXCH011a.vu.local
 (130.37.237.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 19 Nov
 2020 23:21:07 +0100
Received: by mail-lf1-f46.google.com with SMTP id e139so10620373lfd.1;
        Thu, 19 Nov 2020 14:21:07 -0800 (PST)
X-Gm-Message-State: AOAM5325C8Y0rKzRRlBehqeBuGx/pvCqAA4azwImnyBoTm0mx+nouArT
        RMKJ328uQB8X6KKAHIW4/pH8A6wkQWiyXLpyEYs=
X-Google-Smtp-Source: ABdhPJw07T4Hsc6Ds+8WYQ+RDWzX+UPTn4qJH+Xtew2oGk2QSNUNGGpUdeMw3yaKTBvJh+VnJPjfxAnd7YOWL3W3CZ4=
X-Received: by 2002:a19:4193:: with SMTP id o141mr6336750lfa.119.1605824466299;
 Thu, 19 Nov 2020 14:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20201026160518.9212-1-toiwoton@gmail.com> <20201117165455.GN29991@casper.infradead.org>
 <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com> <6810b874c8df456b890d1092273b354a@pexch011a.vu.local>
 <CANWxqZ=fSi15fi6n-Ei4KJ8MtPcfiU8j=cQS-DycMig6s1oQBA@mail.gmail.com> <0da9cb0a4d1a494d9ec15404f8decf01@pexch011a.vu.local>
In-Reply-To: <0da9cb0a4d1a494d9ec15404f8decf01@pexch011a.vu.local>
From:   Cristiano Giuffrida <c.giuffrida@vu.nl>
Date:   Thu, 19 Nov 2020 23:20:54 +0100
X-Gmail-Original-Message-ID: <CANWxqZkdSMFM4T2J-KNK_K-SHfbRnk3EUcgHAF9Xj+SRqDxXHw@mail.gmail.com>
Message-ID: <CANWxqZkdSMFM4T2J-KNK_K-SHfbRnk3EUcgHAF9Xj+SRqDxXHw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Topi Miettinen <toiwoton@gmail.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [130.37.253.6]
X-ClientProxiedBy: pexch014b.vu.local (130.37.237.91) To PEXCH011a.vu.local
 (130.37.237.105)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 19, 2020 at 10:59 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 18.11.2020 20.49, Cristiano Giuffrida wrote:
> > Interesting mitigation and discussion!
> >
> > Regarding the impact on the AnC attack, indeed fine-grained (or full)
> > mmap() randomization affects AnC in two ways: (i) it breaks the
> > contiguity of the mmap() region, crippling the sliding primitive AnC
> > relies on; (ii) it ensures an attacker leaking an address in a
> > particular VMA can't easily infer addresses in other VMAs. So, in
> > short, the mitigation does raise the bar against AnC-like attacks and
> > I see this as a useful addition.
>
> In your paper the timing for Chrome attacks were not presented, which
> would be interesting if they are comparable to the effect of
> randomize_va_space=3 for Firefox. What's your estimate, how much slower
> it was to break Chrome ASLR vs. Firefox/randomize_va_space=2?
We did present entropy reduction over time for Chrome (see Fig. 8).
But without a proper sliding primitive due to mmap() randomization, we
stopped at 2 bits of residual entropy. Getting the last 2 bits is not
impossible, but indeed slower. Not sure by how much without actually
trying (as mentioned, you might also be able to use other side
channels to compensate).

I forgot to mention that mmap() randomization actually makes attacks
easier in cases where VMAs are not demand paged (see Section VI.B of
the AnC paper), since proper sliding with nonrandomized mmap() would
otherwise need to allocate too much memory.

>
> > Indeed, we're aware some vendors implemented a similar randomization
> > strategy in the browser as a mitigation against AnC.
> >
> > Nonetheless, some additional notes on the two points I raised above:
> >
> > - (i) [Sliding] Note that an attacker can do away with sliding
> > depending on the randomization entropy and other available side
> > channels. For instance, with the recent TagBleed, we show how to
> > combine a TLB side channel with AnC to exhaust the KASLR entropy.
> > However, similar attacks should be possible in userland, again
> > depending on the randomization entropy used. See
> > https://download.vusec.net/papers/tagbleed_eurosp20.pdf. Combining
> > side channels with transient/speculative execution attacks can further
> > lower the bar.
>
> I think the equivalent of randomize_va_space=3 for KASLR would be that
> various kernel structures could be placed randomly with full use of all
> bits in the hardware, instead of low numbers like 9, 10 or 15 bits.
> Maybe also each module could be placed in individual random address
> instead of stuffing all modules together and likewise, instead of single
> page_offset_base, vmalloc_base and vmemmap_base, kernel would use the
> full address space to place various internal structures. I suppose this
> is not trivial.
Indeed it's nontrivial to get similar randomization guarantees for the
kernel. I mentioned TagBleed because similar combined AnC + TLB
attacks should also be possible in the browser. We just happened to
focus on the kernel with TagBleed.

>
> > - (ii) [Leaks] Depending on the software vulnerability used for
> > exploitation, it might not be difficult for an attacker to break
> > fine-grained randomization across VMAs. That is, leak an address from
> > VMA 1, use the vulnerability to trigger a normally illegal access to
> > VMA 2, leak an address from VMA 2, repeat. Of course, the exploit
> > might take much longer depending on how far on the pointer chasing
> > chain the target is.
>
> Pointers between VMAs may also exist, for example libz.so needs to call
> open(), close(), malloc(), free() etc. from libc.so.
Indeed my example above assumed pointers between VMAs. At each step,
you would use a vulnerability to craft a counterfeit object around
existing pointers to other VMAs and move from there.

Note that without existing pointers between VMAs, you can still mount
similar attacks by crafting your own pointers to probe for other VMAs.
Since you'd be blindly probing the address space, you'd need some page
fault suppression mechanism to keep going. But branch misprediction a
la Spectre and similar can do the trick. See our recent BlindSide for
an example of such an attack against the kernel:
https://download.vusec.net/papers/blindside_ccs20.pdf.

>
> -Topi
>
> > Best,
> > Cristiano
> >
> > On Wed, Nov 18, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
> >>
> >> (added one of the AnC paper authors)
> >>
> >> On Tue, Nov 17, 2020 at 10:21:30PM +0200, Topi Miettinen wrote:
> >>> On 17.11.2020 18.54, Matthew Wilcox wrote:
> >>>> On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
> >>>>> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> >>>>> enables full randomization of memory mappings created with mmap(NULL,
> >>>>> ...). With 2, the base of the VMA used for such mappings is random,
> >>>>> but the mappings are created in predictable places within the VMA and
> >>>>> in sequential order. With 3, new VMAs are created to fully randomize
> >>>>> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> >>>>> even if not necessary.
> >>>>
> >>>> Is this worth it?
> >>>>
> >>>> https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
> >>>
> >>> Thanks, very interesting. The paper presents an attack (AnC) which can break
> >>> ASLR even from JavaScript in browsers. In the process it compares the memory
> >>> allocators of Firefox and Chrome. Firefox relies on Linux mmap() to
> >>> randomize the memory location, but Chrome internally chooses the randomized
> >>> address. The paper doesn't present exact numbers to break ASLR for Chrome
> >>> case, but it seems to require more effort. Chrome also aggressively
> >>> randomizes the memory on each allocation, which seems to enable further
> >>> possibilities for AnC to probe the MMU tables.
> >>>
> >>> Disregarding the difference in aggressiveness of memory allocators, I think
> >>> with sysctl.kernel.randomize_va_space=3, the effort for breaking ASLR with
> >>> Firefox should be increased closer to Chrome case since mmap() will use the
> >>> address space more randomly.
> >>>
> >>> I have used this setting now for a month without any visible performance
> >>> issues, so I think the extra bits (for some additional effort to attackers)
> >>> are definitely worth the low cost.
> >>>
> >>> Furthermore, the paper does not describe in detail how the attack would
> >>> continue after breaking ASLR. Perhaps there are assumptions which are not
> >>> valid when the different memory areas are no longer sequential. For example,
> >>> if ASLR is initially broken wrt. the JIT buffer but continuing the attack
> >>> would require other locations to be determined (like stack, data segment for
> >>> main exe or libc etc), further efforts may be needed to resolve these
> >>> locations. With randomize_va_space=2, resolving any address (JIT buffer) can
> >>> reveal the addresses of many other memory areas but this is not the case
> >>> with 3.
> >>>
> >>> -Topi
> >>
> >> --
> >> Sincerely yours,
> >> Mike.
>
