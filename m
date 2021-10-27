Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC95C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 15:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2178360F5A
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 15:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhJ0Pwz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbhJ0Pwy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 11:52:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AAEC061570
        for <linux-hardening@vger.kernel.org>; Wed, 27 Oct 2021 08:50:29 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t127so7364251ybf.13
        for <linux-hardening@vger.kernel.org>; Wed, 27 Oct 2021 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xT3+nmu87OUZUlUqDOD62awQnojwMPGi3jG6yVIYB20=;
        b=Q5LslJIP1WUECn+19rRJj5nPB6Bw+vkyE5RDu6YMSkOWj1yqa/r0xmS3A1hkwuQW4o
         N0rir4ytbQGNZrYwQ8olQ86SR9M3AjkZavvc7zfuvQjyj46lk4YV/pmrZNHcSVzsh6kp
         15QYxWKGONAT6kEVnPluF5lEzyZiXcI8dlV1CXqciS+NG+iTJxOnD3gPrOULCFVzQvDk
         11Ew+fnTS1X6vbrkw9x1Dt4iwf5ZG5xXv7fUfn8iR7udBLczkl3G6KvjRAv0/9ajYEDG
         zfYTawSOgY+RRpWN6rkRcFHmeqb59QVbejF6wxvI5dVBAQ3XJf+8uwqnYVSZR4aIzf7q
         yiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xT3+nmu87OUZUlUqDOD62awQnojwMPGi3jG6yVIYB20=;
        b=kHpH24tNdmLbc9lbdB7KpPWdv+/nyOXK5u6w+zvY+SYazP32P0myfpXy5TyDAj/zCY
         v2kphBJt0K2DV3uoMnsKvlM4pS+N6NG4q1+8IjzKmgwlgXgYnhcj7ws9UmiBQJMl+UE5
         PQ6TxKD7O2BfwunRtTOuIMYSdChMCx3aWJYF9+saQ5r7F7900rO6OeGodZRwlzcVbKnv
         tY5DWZVyaSLAdwbDvnROQ/dCPF1eM2ToVyXPx6kEnpo60ojekS7v80YMJNfTD6hmO0m7
         3LemPZI0G5KZEJp+sj+IR7Z63Pl7N2BOAPTkKpxrdmzuImo6rM/HcHZ1VhKzkBygFjDX
         tVow==
X-Gm-Message-State: AOAM533l07Otz+bfIT6PiM4IY4TAfJGSFDqHzzT0TLAny+RTS/Ptfqzt
        qMNE+g37qqkT/9h/1fIrxPEphPJT1ySNgVh+fg929Q==
X-Google-Smtp-Source: ABdhPJwncYgYFBIOkxUnviwTtsfI9zj7enKWmTCleclo8t3495Q8kck0zJ2FZXeomTaXwjvQvdIiWEbHg5VhZsjTwFY=
X-Received: by 2002:a25:bf81:: with SMTP id l1mr984264ybk.289.1635349828212;
 Wed, 27 Oct 2021 08:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local> <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net> <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
In-Reply-To: <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 27 Oct 2021 08:50:17 -0700
Message-ID: <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Wed, Oct 27, 2021 at 7:18 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 27 Oct 2021 at 16:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 27, 2021 at 03:30:11PM +0200, Ard Biesheuvel wrote:
> >
> > > As far as I can tell from playing around with Clang, the stubs can
> > > actually be executed directly,
> >
> > I had just finished reading the clang docs which suggest as much and was
> > about to try what the compiler actually generates.
> >
> > > they just jumps to the actual function.
> > > The compiler simply generates a jump table for each prototype that
> > > appears in the code as the target of an indirect jump, and checks
> > > whether the target appears in the list.
> > >
> > > E.g., the code below
> > >
> > > void foo(void) {}
> > > void bar(int) {}
> > > void baz(int) {}
> > > void (* volatile fn1)(void) = foo;
> > > void (* volatile fn2)(int) = bar;
> > >
> > > int main(int argc, char *argv[])
> > > {
> > >   fn1();
> > >   fn2 = baz;
> > >   fn2(-1);
> > > }
> > >
> > > produces
> > >
> > > 0000000000400594 <foo.cfi>:
> > >   400594: d65f03c0 ret
> > >
> > > 0000000000400598 <bar.cfi>:
> > >   400598: d65f03c0 ret
> > >
> > > 000000000040059c <baz.cfi>:
> > >   40059c: d65f03c0 ret
> >
> > Right, so these are the actual functions ^.
> >
> > > 00000000004005a0 <main>:
> > >   4005a0: a9bf7bfd stp x29, x30, [sp, #-16]!
> > >
> > > // First indirect call
> > >   4005a4: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
> > >   4005a8: f9401508 ldr x8, [x8, #40]
> > >   4005ac: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> > >   4005b0: 91182129 add x9, x9, #0x608
> > >   4005b4: 910003fd mov x29, sp
> > >   4005b8: eb09011f cmp x8, x9
> > >   4005bc: 54000241 b.ne 400604 <main+0x64>  // b.any
> > >   4005c0: d63f0100 blr x8
> >
> > That's impenetrable to me, sorry.
> >
>
> This loads the value of fn1 in x8, and takes the address of the jump
> table in x9. Since it is only one entry long, it does a simple compare
> to check whether x8 appears in the jump table, and branches to the BRK
> at the end if they are different.
>
> > > // Assignment of fn2
> > >   4005c4: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> > >   4005c8: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
> > >   4005cc: 91184129 add x9, x9, #0x610
> > >   4005d0: f9001909 str x9, [x8, #48]
> >
> > I'm struggling here, x9 points to the branch at 400610, but then what?
> >
> > x8 is in .data somewhere?
> >
>
> This takes the address of the jump table entry of 'baz' in x9, and
> stores it in fn2 whose address is taken in x8.
>
>
> > > // Second indirect call
> > >   4005d4: f9401908 ldr x8, [x8, #48]
> > >   4005d8: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> > >   4005dc: 91183129 add x9, x9, #0x60c
> > >   4005e0: cb090109 sub x9, x8, x9
> > >   4005e4: 93c90929 ror x9, x9, #2
> > >   4005e8: f100053f cmp x9, #0x1
> > >   4005ec: 540000c8 b.hi 400604 <main+0x64>  // b.pmore
> > >   4005f0: 12800000 mov w0, #0xffffffff            // #-1
> > >   4005f4: d63f0100 blr x8
> > >
> > >
> > >   4005f8: 2a1f03e0 mov w0, wzr
> > >   4005fc: a8c17bfd ldp x29, x30, [sp], #16
> > >   400600: d65f03c0 ret
> > >   400604: d4200020 brk #0x1
> >
> >
> > > 0000000000400608 <__typeid__ZTSFvvE_global_addr>:
> > >   400608: 17ffffe3 b 400594 <foo.cfi>
> > >
> > > 000000000040060c <__typeid__ZTSFviE_global_addr>:
> > >   40060c: 17ffffe3 b 400598 <bar.cfi>
> > >   400610: 17ffffe3 b 40059c <baz.cfi>
> >
> > And these are the stubs per type.
> >
> > > So it looks like taking the address is fine, although not optimal due
> > > to the additional jump.
> >
> > Right.
> >
>
> ... although it does seem that function_nocfi() doesn't actually work
> as expected, given that we want the address of <func>.cfi and not the
> address of the stub.

This is because the example wasn't compiled with
-fno-sanitize-cfi-canonical-jump-tables, which we use in the kernel.
With non-canonical jump tables, <func> continues to point to the
function and <func>.cfi_jt points to the jump table, and therefore,
function_nocfi() returns the raw function address.

> > > We could fudge around that by checking the
> > > opcode at the target of the call, or token paste ".cfi" after the
> > > symbol name in the static_call_update() macro, but it doesn't like
> > > like anything is terminally broken tbh.
> >
> > Agreed, since the jump table entries are actually executable it 'works'.
> >
> > I really don't like that extra jump though, so I think I really do want
> > that nocfi_ptr() thing. And going by:
> >
> >   https://clang.llvm.org/docs/ControlFlowIntegrityDesign.html#forward-edge-cfi-for-indirect-function-calls
> >
> > and the above, that might be possible (on x86) with something like:
> >
> > /*
> >  * Turns a Clang CFI jump-table entry into an actual function pointer.
> >  * These jump-table entries are simply jmp.d32 instruction with their
> >  * relative offset pointing to the actual function, therefore decode the
> >  * instruction to find the real function.
> >  */
> > static __always_inline void *nocfi_ptr(void *func)
> > {
> >         union text_poke_insn insn = *(union text_poke_insn *)func;
> >
> >         return func + sizeof(insn) + insn.disp;
> > }
> >
> > But really, that wants to be a compiler intrinsic.
>
> Agreed. We could easily do something similar on arm64, but I'd prefer
> to avoid that too.

I'll see what we can do. Note that the compiler built-in we previously
discussed would have semantics similar to function_nocfi(). It would
return the raw function address from a symbol name, but it wouldn't
decode the address from an arbitrary pointer, so this would require
something different.

Sami
