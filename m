Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F68C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E04610C8
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 15:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhJ0P5y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhJ0P5x (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 11:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58CC4610CF;
        Wed, 27 Oct 2021 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635350128;
        bh=YrSJF1WLDzUs07MzocSeTB/P/c338AvA4f+uEBWnzm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3GI4v+mpdUhDOdlZ3OzazrcsmocuekxnOyLxea0AAgkWfjzAckM65ybR4PzJ7pt/
         2wl+h4hPjSmb71nhxomgjoC5h8cP8eEBPw8pFsUu/ILjd7yOnlpSfvqmsg8MBm2G3/
         nXOl7ZO+QRFssGSmWxknWEMy7SFDI98kVF0kKdxKH5EfaPDj7yfQ5HTh4H2Wn5WIaG
         3Lu4rMKuTP5qHXAkQ3qM8JReVjl+2NjqOmm9NUdl0Gng7nAmaEy5uBv/RMtkaoamVV
         vPAkbOI/PjsG5VOYkC5KXkiR0eH1t5zr3PQKdWrkj3yoWDxXfx3OFWAFC828JLsG9i
         VfmiaTk+SBVzw==
Received: by mail-oi1-f179.google.com with SMTP id y207so3987061oia.11;
        Wed, 27 Oct 2021 08:55:28 -0700 (PDT)
X-Gm-Message-State: AOAM531oiwcdMAmHZ64Fxi1i69JCCE+vpWcELYbYabNGmdpc2C2FAQW4
        3WnV5uqMM12uNr5mWsZMQVJ5iUtuK0Q/IIR1ZXA=
X-Google-Smtp-Source: ABdhPJy5pxg2RG1gpaABKEWnbWb7nWAhPccOt7NoJx2cikQcP6OLAos300DWPqdqZRhS8Yh5WIAd/jN4uISVdShcuuo=
X-Received: by 2002:a54:448e:: with SMTP id v14mr4352588oiv.174.1635350127547;
 Wed, 27 Oct 2021 08:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local> <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net> <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net> <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
In-Reply-To: <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Oct 2021 17:55:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEojTj_5_wSfS+qJZycgKG8i8qK2uWRaHM3B0T4VQnDkQ@mail.gmail.com>
Message-ID: <CAMj1kXEojTj_5_wSfS+qJZycgKG8i8qK2uWRaHM3B0T4VQnDkQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
To:     Sami Tolvanen <samitolvanen@google.com>
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

On Wed, 27 Oct 2021 at 17:50, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Wed, Oct 27, 2021 at 7:18 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 27 Oct 2021 at 16:03, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Oct 27, 2021 at 03:30:11PM +0200, Ard Biesheuvel wrote:
> > >
> > > > As far as I can tell from playing around with Clang, the stubs can
> > > > actually be executed directly,
> > >
> > > I had just finished reading the clang docs which suggest as much and was
> > > about to try what the compiler actually generates.
> > >
> > > > they just jumps to the actual function.
> > > > The compiler simply generates a jump table for each prototype that
> > > > appears in the code as the target of an indirect jump, and checks
> > > > whether the target appears in the list.
> > > >
> > > > E.g., the code below
> > > >
> > > > void foo(void) {}
> > > > void bar(int) {}
> > > > void baz(int) {}
> > > > void (* volatile fn1)(void) = foo;
> > > > void (* volatile fn2)(int) = bar;
> > > >
> > > > int main(int argc, char *argv[])
> > > > {
> > > >   fn1();
> > > >   fn2 = baz;
> > > >   fn2(-1);
> > > > }
> > > >
> > > > produces
> > > >
> > > > 0000000000400594 <foo.cfi>:
> > > >   400594: d65f03c0 ret
> > > >
> > > > 0000000000400598 <bar.cfi>:
> > > >   400598: d65f03c0 ret
> > > >
> > > > 000000000040059c <baz.cfi>:
> > > >   40059c: d65f03c0 ret
> > >
> > > Right, so these are the actual functions ^.
> > >
> > > > 00000000004005a0 <main>:
> > > >   4005a0: a9bf7bfd stp x29, x30, [sp, #-16]!
> > > >
> > > > // First indirect call
> > > >   4005a4: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
> > > >   4005a8: f9401508 ldr x8, [x8, #40]
> > > >   4005ac: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> > > >   4005b0: 91182129 add x9, x9, #0x608
> > > >   4005b4: 910003fd mov x29, sp
> > > >   4005b8: eb09011f cmp x8, x9
> > > >   4005bc: 54000241 b.ne 400604 <main+0x64>  // b.any
> > > >   4005c0: d63f0100 blr x8
> > >
> > > That's impenetrable to me, sorry.
> > >
> >
> > This loads the value of fn1 in x8, and takes the address of the jump
> > table in x9. Since it is only one entry long, it does a simple compare
> > to check whether x8 appears in the jump table, and branches to the BRK
> > at the end if they are different.
> >
> > > > // Assignment of fn2
> > > >   4005c4: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> > > >   4005c8: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
> > > >   4005cc: 91184129 add x9, x9, #0x610
> > > >   4005d0: f9001909 str x9, [x8, #48]
> > >
> > > I'm struggling here, x9 points to the branch at 400610, but then what?
> > >
> > > x8 is in .data somewhere?
> > >
> >
> > This takes the address of the jump table entry of 'baz' in x9, and
> > stores it in fn2 whose address is taken in x8.
> >
> >
> > > > // Second indirect call
> > > >   4005d4: f9401908 ldr x8, [x8, #48]
> > > >   4005d8: 90000009 adrp x9, 400000 <__abi_tag-0x278>
> > > >   4005dc: 91183129 add x9, x9, #0x60c
> > > >   4005e0: cb090109 sub x9, x8, x9
> > > >   4005e4: 93c90929 ror x9, x9, #2
> > > >   4005e8: f100053f cmp x9, #0x1
> > > >   4005ec: 540000c8 b.hi 400604 <main+0x64>  // b.pmore
> > > >   4005f0: 12800000 mov w0, #0xffffffff            // #-1
> > > >   4005f4: d63f0100 blr x8
> > > >
> > > >
> > > >   4005f8: 2a1f03e0 mov w0, wzr
> > > >   4005fc: a8c17bfd ldp x29, x30, [sp], #16
> > > >   400600: d65f03c0 ret
> > > >   400604: d4200020 brk #0x1
> > >
> > >
> > > > 0000000000400608 <__typeid__ZTSFvvE_global_addr>:
> > > >   400608: 17ffffe3 b 400594 <foo.cfi>
> > > >
> > > > 000000000040060c <__typeid__ZTSFviE_global_addr>:
> > > >   40060c: 17ffffe3 b 400598 <bar.cfi>
> > > >   400610: 17ffffe3 b 40059c <baz.cfi>
> > >
> > > And these are the stubs per type.
> > >
> > > > So it looks like taking the address is fine, although not optimal due
> > > > to the additional jump.
> > >
> > > Right.
> > >
> >
> > ... although it does seem that function_nocfi() doesn't actually work
> > as expected, given that we want the address of <func>.cfi and not the
> > address of the stub.
>
> This is because the example wasn't compiled with
> -fno-sanitize-cfi-canonical-jump-tables, which we use in the kernel.
> With non-canonical jump tables, <func> continues to point to the
> function and <func>.cfi_jt points to the jump table, and therefore,
> function_nocfi() returns the raw function address.
>

Ah excellent. So that means that we don't need function_nocfi() at
all, given that
- statically allocated references (i.e., DEFINE_STATIC_CALL()) will
refer to the function directly;
- runtime assignments can decode the target of the *func pointer and
strip off the initial branch.

It would still be nice to have an intrinsic for that, or some variable
attribute that signifies that assigning the address of a function to
it will produce the actual function rather than the jump table entry.

> > > > We could fudge around that by checking the
> > > > opcode at the target of the call, or token paste ".cfi" after the
> > > > symbol name in the static_call_update() macro, but it doesn't like
> > > > like anything is terminally broken tbh.
> > >
> > > Agreed, since the jump table entries are actually executable it 'works'.
> > >
> > > I really don't like that extra jump though, so I think I really do want
> > > that nocfi_ptr() thing. And going by:
> > >
> > >   https://clang.llvm.org/docs/ControlFlowIntegrityDesign.html#forward-edge-cfi-for-indirect-function-calls
> > >
> > > and the above, that might be possible (on x86) with something like:
> > >
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
>
> Sami
