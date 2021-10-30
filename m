Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8643BC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D2C60F9B
	for <linux-hardening@archiver.kernel.org>; Sat, 30 Oct 2021 17:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhJ3RWk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ3RWg (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 30 Oct 2021 13:22:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFAFE60FC3;
        Sat, 30 Oct 2021 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635614405;
        bh=jisY5HPhWX9iNQ9+wevVVLZjayadNPZuYlW5MoiG98Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VLS2F/hwY4ACE8G5VxNmv/ZcNE4TA3tOCJ0WRP67bfs7a4X2VeNTtQkM7s4AOR0ea
         Ko2XuDREhsx/cCNW1glbdhgSLHjsbrBnQ51MdsgM4X7kEP670ufn+xyM5jwBtiBVZp
         v06gsaBb4DaAKNQWRDBhXk1F5ctd39dDC6H4uTrfTHOqGZIbE9WtsVIajxMt7MR8Wu
         i3gmZtTVDVOYmhEWrxlQMTNvyMkulPPGwB8BHHa9w7FfEFNRHrQpKHvmlVinC30GXW
         TUVLhGOmmsT0KAf42i2GuxatgrrsrSXdOalstr4fVNjwx7lQsYJgCIQD+CEX9tiidm
         XnetkDBCG5fFg==
Received: by mail-oi1-f173.google.com with SMTP id bm39so7767536oib.0;
        Sat, 30 Oct 2021 10:20:05 -0700 (PDT)
X-Gm-Message-State: AOAM5301FuB1iL96bCfzVsGOQoAXCXmv5/PKdbYG+s0yzPqLUWGU0NiG
        3LzXkK8DuOtvvgdKPD4UA+uXXL7gS4kO2t1Ymic=
X-Google-Smtp-Source: ABdhPJwtZmpRz7pXyzJlCu/rri6Dp4A9lMCXKN4um74twhwjGnzq1+v5jg1jRuWO09pxQ/9qsDQsE4K7HQd9AX55F2E=
X-Received: by 2002:a05:6808:1805:: with SMTP id bh5mr18589992oib.47.1635614404947;
 Sat, 30 Oct 2021 10:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local> <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net> <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net> <20211030074758.GT174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211030074758.GT174703@worktop.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 30 Oct 2021 19:19:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
Message-ID: <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 30 Oct 2021 at 09:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
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
>
> ---
> Subject: static_call,x86: Robustify trampoline patching
>
> Add a few signature bytes after the static call trampoline and verify
> those bytes match before patching the trampoline. This avoids patching
> random other JMPs (such as CFI jump-table entries) instead.
>
> These bytes decode as:
>
>    d:   53                      push   %rbx
>    e:   43 54                   rex.XB push %r12
>
> And happen to spell "SCT".
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I just realized that arm64 has the exact same problem, which is not
being addressed by my v5 of the static call support patch.

As it turns out, the v11 Clang that I have been testing with is broken
wrt BTI landing pads, and omits them from the jump table entries.
Clang 12+ adds them properly, which means that both the jump table
entry and the static call trampoline may start with BTI C + direct
branch, and we also need additional checks to disambiguate.
