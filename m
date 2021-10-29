Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42630C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 20:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210CD60FED
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 20:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJ2UHO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhJ2UG6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Oct 2021 16:06:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9F8C061766;
        Fri, 29 Oct 2021 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4j1wDZ0zukO0G9+hbxn/at8w/H0Z3/+jS5ZxjuH+1Qg=; b=fiT549T1mubjtFNw5r3p2n91Ii
        hHZyUob1SzEvIg7BwzruzF/HJn8MYclNVRKfKPls5tVgyzD/pAlV5PdDMQGZTy3LEL0eMZj54Jg84
        X0Hqfioer7oWU/pBF2ez2UZ3154c421X2VCViXylBcvwvrogXyEJRv5rCOkiR/u9xIGUvZ4qagi2a
        GU/WOGztXiRGYLn0ieghPtE0j3JZNcpwT/effPmBb6A+1aDaVzsMChAc5FIHxO4YBlLxImPKiWSYJ
        9ihZccR3tGQRd7WIm4bjFMfASeEzOx/16fo6l9bUDu/JxfSA6ksUC2fIg0cCljyqkmJxjaVJz7Eow
        VwEc90rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgY61-00D8nD-Jz; Fri, 29 Oct 2021 20:03:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D10F9821D0; Fri, 29 Oct 2021 22:03:24 +0200 (CEST)
Date:   Fri, 29 Oct 2021 22:03:24 +0200
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
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211029200324.GR174703@worktop.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 08:50:17AM -0700, Sami Tolvanen wrote:
> On Wed, Oct 27, 2021 at 7:18 AM Ard Biesheuvel <ardb@kernel.org> wrote:

> > > /*
> > >  * Turns a Clang CFI jump-table entry into an actual function pointer.
> > >  * These jump-table entries are simply jmp.d32 instruction with their
> > >  * relative offset pointing to the actual function, therefore decode the
> > >  * instruction to find the real function.
> > >  */
> > > static __always_inline void *nocfi_ptr(void *func)
> > > {
> > >         union text_poke_insn insn = *(union text_poke_insn *)func;
> > >
> > >         return func + sizeof(insn) + insn.disp;
> > > }
> > >
> > > But really, that wants to be a compiler intrinsic.
> >
> > Agreed. We could easily do something similar on arm64, but I'd prefer
> > to avoid that too.
> 
> I'll see what we can do. Note that the compiler built-in we previously
> discussed would have semantics similar to function_nocfi(). It would
> return the raw function address from a symbol name, but it wouldn't
> decode the address from an arbitrary pointer, so this would require
> something different.

So I had a bit of a peek at what clang generates:

    3fa4:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        3fa7: R_X86_64_32S      __SCK__x86_pmu_handle_irq
    3fab:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi        3fae: R_X86_64_32S      __SCT__x86_pmu_handle_irq.cfi_jt
    3fb2:       e8 00 00 00 00          call   3fb7 <init_hw_perf_events+0x1dc> 3fb3: R_X86_64_PLT32    __static_call_update-0x4

So this then gives the trampoline jump table entry to
__static_call_update(), with the result that it will rewrite the
jump-table entry, not the trampoline!

Now it so happens that the trampoline looks *exactly* like the
jump-table entry (one jmp.d32 instruction), so in that regards it'll
again 'work'.

But this is all really, as in *really*, wrong. And I'm really sad I'm
the one to have to discover this, even though I've mentioned
static_call()s being tricky in previous reviews.


