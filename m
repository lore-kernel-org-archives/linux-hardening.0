Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1442DC433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A5A60E8B
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 08:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhJ3IVf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 30 Oct 2021 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3IVe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 30 Oct 2021 04:21:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0628C061570;
        Sat, 30 Oct 2021 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OsAU1X/ym1O2wGNMWXfa64U4N11rGKkMYQvMe3I0gUI=; b=Znk8T7HkbjMxUm+OAnv03Ub4Fs
        uevcDyelW6+m+1hwPFX+kz/FfOEvcvO/R1s6hxVQr6hbHCyinV2PKAIOphy2XUuGCGYCpBt04olIN
        Mso9Ny7kq9tx6YRKpydNqUIz/nZyPu/TmdzWyXJmc2eveFDhQ/A/8K06JknYDtlrLcSQf35la5uVq
        vo6ndIaYmMSzngZxwqKTb4PZPtcN6A5F2Zupxc2jDjn5urpfosjhlmd1J7ctewQBBTR1UFbZ076BY
        ysTw/pnYu194JxL5IImt8C1uN6BR2MRWMTxtWFYjV1uRrNcXifNZv594C3SlGHNHEaPxq+QRyIhAR
        DTNWbjLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgjXT-002JF8-L4; Sat, 30 Oct 2021 08:16:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10A1B986244; Sat, 30 Oct 2021 10:16:31 +0200 (CEST)
Date:   Sat, 30 Oct 2021 10:16:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, joao@overdrivepizza.com
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <20211030081631.GF174730@worktop.programming.kicks-ass.net>
References: <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030074758.GT174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 30, 2021 at 09:47:58AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 29, 2021 at 10:03:24PM +0200, Peter Zijlstra wrote:
> 
> > So I had a bit of a peek at what clang generates:
> > 
> >     3fa4:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        3fa7: R_X86_64_32S      __SCK__x86_pmu_handle_irq
> >     3fab:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi        3fae: R_X86_64_32S      __SCT__x86_pmu_handle_irq.cfi_jt
> >     3fb2:       e8 00 00 00 00          call   3fb7 <init_hw_perf_events+0x1dc> 3fb3: R_X86_64_PLT32    __static_call_update-0x4
> > 
> > So this then gives the trampoline jump table entry to
> > __static_call_update(), with the result that it will rewrite the
> > jump-table entry, not the trampoline!
> > 
> > Now it so happens that the trampoline looks *exactly* like the
> > jump-table entry (one jmp.d32 instruction), so in that regards it'll
> > again 'work'.
> > 
> > But this is all really, as in *really*, wrong. And I'm really sad I'm
> > the one to have to discover this, even though I've mentioned
> > static_call()s being tricky in previous reviews.
> 
> The below makes the clang-cfi build properly sick:
> 
> [    0.000000] trampoline signature fail
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/x86/kernel/static_call.c:65!

So fundamentally I think the whole notion that the address of a function
is something different than 'the address of that function' is an *utter*
fail.

So things like FineIBT use a scheme where they pass a hash value along
with the indirect call, which is veryfied at the other end. Can't we
adjust it like:


foo.cfi:
	endbr
	xorl $0xdeadbeef, %r10d
	jz foo
	ud2
	nop	# make it an even 16 bytes
foo:
	# actual function text


Then have the address of foo, be the address of foo, like any normal
sane person would expect. Have direct calls to foo, go to foo, again, as
expected.

When doing an indirect call (to r11, as clang does), then, and only
then, do:

	movl $0xdeadbeef, %r10d
	subq $0x10, %r11
	call *%r11

	# if the r11 lives, add:
	addq $0x10, %r11


Then only when caller and callee agree 0xdeadbeef is the password, does
the indirect call go through.

Why isn't this a suitable CFI scheme even without IBT?

