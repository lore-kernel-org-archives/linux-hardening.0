Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CEAC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 14:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610D560D42
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 14:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhJ0OVD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242437AbhJ0OUz (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 10:20:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58F2D60F9D;
        Wed, 27 Oct 2021 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635344310;
        bh=Ci0lo29N8P5kyUfw16N1daeiwbEtGaYvfxpqWpHCONk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kPx7lW7H5ZT2/17cstsUGQuXbbGHVXvQ/bpdLYt0a0sMpaHMLEIYT4NCxgNe0Y2eP
         6nhfUt5zAKC54gh326+pA4nrg0XG/rYnlVSwnlOd2OFHWKIqPs7gNoABolbkuYEJUI
         0GN/XoUoVdJD+8Rz52gAGH02DEHXg2MFoIeL+DHQAmStebLsFhZXry1x/XRlZ/FyTm
         3Z5UbeB/yQkLu4Db6GKCLdCRiMmz5WByWXoeLfYfMqxaObuxmTvuk9rb04eBbl7dfZ
         UBTyEGJAdP76AoH5A55xEKLLvAT8SMES+8oLbv/ub7E/WFAmV8BITiegOgJjceYI6E
         djrSvewbY8hPQ==
Received: by mail-ot1-f45.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so3865356otg.0;
        Wed, 27 Oct 2021 07:18:30 -0700 (PDT)
X-Gm-Message-State: AOAM532DAPoIjgZrBUTLCiMksOK3b1RtQ9+UbiuPteybVJO8A639YheK
        j+SWQuOfSRTT3Y5z3ySOnMJOK8GvvvQr4qmQjxM=
X-Google-Smtp-Source: ABdhPJx4tQtaDau6R3fvO+InG6marcYPTepOAy7CXoyb9NdCVPXTAYirMAEZ5+HPZk/wOk7DcCMrv5/blLlAPjb6s1s=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr25145832oth.30.1635344309561;
 Wed, 27 Oct 2021 07:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local> <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
In-Reply-To: <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Oct 2021 16:18:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
Message-ID: <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
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

On Wed, 27 Oct 2021 at 16:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 03:30:11PM +0200, Ard Biesheuvel wrote:
>
> > As far as I can tell from playing around with Clang, the stubs can
> > actually be executed directly,
>
> I had just finished reading the clang docs which suggest as much and was
> about to try what the compiler actually generates.
>
> > they just jumps to the actual function.
> > The compiler simply generates a jump table for each prototype that
> > appears in the code as the target of an indirect jump, and checks
> > whether the target appears in the list.
> >
> > E.g., the code below
> >
> > void foo(void) {}
> > void bar(int) {}
> > void baz(int) {}
> > void (* volatile fn1)(void) = foo;
> > void (* volatile fn2)(int) = bar;
> >
> > int main(int argc, char *argv[])
> > {
> >   fn1();
> >   fn2 = baz;
> >   fn2(-1);
> > }
> >
> > produces
> >
> > 0000000000400594 <foo.cfi>:
> >   400594: d65f03c0 ret
> >
> > 0000000000400598 <bar.cfi>:
> >   400598: d65f03c0 ret
> >
> > 000000000040059c <baz.cfi>:
> >   40059c: d65f03c0 ret
>
> Right, so these are the actual functions ^.
>
> > 00000000004005a0 <main>:
> >   4005a0: a9bf7bfd stp x29, x30, [sp, #-16]!
> >
> > // First indirect call
> >   4005a4: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
> >   4005a8: f9401508 ldr x8, [x8, #40]
> >   4005ac: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> >   4005b0: 91182129 add x9, x9, #0x608
> >   4005b4: 910003fd mov x29, sp
> >   4005b8: eb09011f cmp x8, x9
> >   4005bc: 54000241 b.ne 400604 <main+0x64>  // b.any
> >   4005c0: d63f0100 blr x8
>
> That's impenetrable to me, sorry.
>

This loads the value of fn1 in x8, and takes the address of the jump
table in x9. Since it is only one entry long, it does a simple compare
to check whether x8 appears in the jump table, and branches to the BRK
at the end if they are different.

> > // Assignment of fn2
> >   4005c4: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> >   4005c8: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
> >   4005cc: 91184129 add x9, x9, #0x610
> >   4005d0: f9001909 str x9, [x8, #48]
>
> I'm struggling here, x9 points to the branch at 400610, but then what?
>
> x8 is in .data somewhere?
>

This takes the address of the jump table entry of 'baz' in x9, and
stores it in fn2 whose address is taken in x8.


> > // Second indirect call
> >   4005d4: f9401908 ldr x8, [x8, #48]
> >   4005d8: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> >   4005dc: 91183129 add x9, x9, #0x60c
> >   4005e0: cb090109 sub x9, x8, x9
> >   4005e4: 93c90929 ror x9, x9, #2
> >   4005e8: f100053f cmp x9, #0x1
> >   4005ec: 540000c8 b.hi 400604 <main+0x64>  // b.pmore
> >   4005f0: 12800000 mov w0, #0xffffffff            // #-1
> >   4005f4: d63f0100 blr x8
> >
> >
> >   4005f8: 2a1f03e0 mov w0, wzr
> >   4005fc: a8c17bfd ldp x29, x30, [sp], #16
> >   400600: d65f03c0 ret
> >   400604: d4200020 brk #0x1
>
>
> > 0000000000400608 <__typeid__ZTSFvvE_global_addr>:
> >   400608: 17ffffe3 b 400594 <foo.cfi>
> >
> > 000000000040060c <__typeid__ZTSFviE_global_addr>:
> >   40060c: 17ffffe3 b 400598 <bar.cfi>
> >   400610: 17ffffe3 b 40059c <baz.cfi>
>
> And these are the stubs per type.
>
> > So it looks like taking the address is fine, although not optimal due
> > to the additional jump.
>
> Right.
>

... although it does seem that function_nocfi() doesn't actually work
as expected, given that we want the address of <func>.cfi and not the
address of the stub.

> > We could fudge around that by checking the
> > opcode at the target of the call, or token paste ".cfi" after the
> > symbol name in the static_call_update() macro, but it doesn't like
> > like anything is terminally broken tbh.
>
> Agreed, since the jump table entries are actually executable it 'works'.
>
> I really don't like that extra jump though, so I think I really do want
> that nocfi_ptr() thing. And going by:
>
>   https://clang.llvm.org/docs/ControlFlowIntegrityDesign.html#forward-edge-cfi-for-indirect-function-calls
>
> and the above, that might be possible (on x86) with something like:
>
> /*
>  * Turns a Clang CFI jump-table entry into an actual function pointer.
>  * These jump-table entries are simply jmp.d32 instruction with their
>  * relative offset pointing to the actual function, therefore decode the
>  * instruction to find the real function.
>  */
> static __always_inline void *nocfi_ptr(void *func)
> {
>         union text_poke_insn insn = *(union text_poke_insn *)func;
>
>         return func + sizeof(insn) + insn.disp;
> }
>
> But really, that wants to be a compiler intrinsic.

Agreed. We could easily do something similar on arm64, but I'd prefer
to avoid that too.
