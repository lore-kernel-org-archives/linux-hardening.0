Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA1BC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 13:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F7161056
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 13:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbhJ0Nct (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236899AbhJ0Nct (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 09:32:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6FC610A6;
        Wed, 27 Oct 2021 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635341423;
        bh=zJuysV5Sykk7qxjtmigQLRJCeSgpOOIif4RUAeNe+jo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KhIzEXLwbzqQUX/ydVQ4Y2o6fTPf5FJ1xiLlkiq8ABKJv8CIa/z+G5jhb/ZskV4c7
         N0r8HBa3tIg5FEo36JH6fiYgUJpaUuGSkzQiRWARHUXDcWvKSoEkgccV7HGUMaGFqV
         fQxg6QrCGAR2yJTm8R2zyz+XNEWlk1XfkX91K0AtEer8eXnVoXn5OUS1mlRFExtHqg
         wCL8bYK6j1HnISNdZeaQ5G4CJjBbQn33+6rc/gT36Zn+pZYx10BYMSf/J452WZk9zL
         feZLdUQUJB5UtMKNCnIVrWvQX0TxSg1ZneD9dnRLoILV/LOsNoO1oW7EJk3arZZkGU
         8keDhOGRUq5UA==
Received: by mail-oi1-f178.google.com with SMTP id z126so3388032oiz.12;
        Wed, 27 Oct 2021 06:30:23 -0700 (PDT)
X-Gm-Message-State: AOAM532UIzqfO2A+xnRpoMwli3HqhLyBaeQ8JnKt/QA6RtBcFRkeTpWc
        geD2MDXpC/K/hJYY5liNFZ4ydxCpUGdDbf1J8p0=
X-Google-Smtp-Source: ABdhPJxHZhozJUMLwljcE4RIAcNo/hkLSuyVxmcc3zO47ndAYbxEfSfoW2ZEZ0SjrJf0FK/z3ZQktkd0f71LTmebfjQ=
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr3597702oie.33.1635341422835;
 Wed, 27 Oct 2021 06:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local> <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net> <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
In-Reply-To: <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Oct 2021 15:30:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
Message-ID: <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
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

On Wed, 27 Oct 2021 at 15:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 02:48:52PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 27, 2021 at 02:22:27PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 27 Oct 2021 at 14:05, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > > > > Should not this jump-table thingy get converted to an actual function
> > > > > address somewhere around arch_static_call_transform() ? This also seems
> > > > > relevant for arm64 (which already has CLANG_CFI supported) given:
> > > > >
> > > > >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
> > > >
> > > > Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...
> > > >
> > >
> > > Sadly, that only works on symbol names, so we cannot use it to strip
> > > CFI-ness from void *func arguments passed into the static call API,
> > > unfortunately.
> >
> > Right, and while mostly static_call_update() is used, whcih is a macro
> > and could possibly be used to wrap this, we very much rely on
> > __static_call_update() also working without that wrapper and then we're
> > up a creek without no paddles.
>
> Specifically, we support code like:
>
> struct foo {
>         void (*func1)(args1);
>         void (*func2)(args2);
> }
>
> struct foo global_foo;
>
> ...
>
> DEFINE_STATIC_CALL_NULL(func1, *global_foo.func1);
>
> ...
>
> __init foo_init()
> {
>         // whatever code that fills out foo
>
>         static_call_update(func1, global_foo.func1);
> }
>
> ...
>
> hot_function()
> {
>         ...
>         static_cal(func1)(args1);
>         ...
> }
>
> cold_function()
> {
>         ...
>         global_foo->func1(args1);
>         ...
> }
>
> And there is no way I can see this working sanely with CFI as presented.
>
> Even though the above uses static_call_update(), we can't no longer use
> function_nocfi() on the @func argument, because it's not a symbol, it's
> already a function pointer.
>
> Nor can we fill global_foo.func1 with function_nocfi() because then
> cold_function() goes sideways.
>

As far as I can tell from playing around with Clang, the stubs can
actually be executed directly, they just jumps to the actual function.
The compiler simply generates a jump table for each prototype that
appears in the code as the target of an indirect jump, and checks
whether the target appears in the list.

E.g., the code below

void foo(void) {}
void bar(int) {}
void baz(int) {}
void (* volatile fn1)(void) = foo;
void (* volatile fn2)(int) = bar;

int main(int argc, char *argv[])
{
  fn1();
  fn2 = baz;
  fn2(-1);
}

produces

0000000000400594 <foo.cfi>:
  400594: d65f03c0 ret

0000000000400598 <bar.cfi>:
  400598: d65f03c0 ret

000000000040059c <baz.cfi>:
  40059c: d65f03c0 ret

00000000004005a0 <main>:
  4005a0: a9bf7bfd stp x29, x30, [sp, #-16]!

// First indirect call
  4005a4: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
  4005a8: f9401508 ldr x8, [x8, #40]
  4005ac: 90000009 adrp x9, 400000 <__abi_tag-0x278>
  4005b0: 91182129 add x9, x9, #0x608
  4005b4: 910003fd mov x29, sp
  4005b8: eb09011f cmp x8, x9
  4005bc: 54000241 b.ne 400604 <main+0x64>  // b.any
  4005c0: d63f0100 blr x8

// Assignment of fn2
  4005c4: 90000009 adrp x9, 400000 <__abi_tag-0x278>
  4005c8: b0000088 adrp x8, 411000 <__libc_start_main@GLIBC_2.17>
  4005cc: 91184129 add x9, x9, #0x610
  4005d0: f9001909 str x9, [x8, #48]

// Second indirect call
  4005d4: f9401908 ldr x8, [x8, #48]
  4005d8: 90000009 adrp x9, 400000 <__abi_tag-0x278>
  4005dc: 91183129 add x9, x9, #0x60c
  4005e0: cb090109 sub x9, x8, x9
  4005e4: 93c90929 ror x9, x9, #2
  4005e8: f100053f cmp x9, #0x1
  4005ec: 540000c8 b.hi 400604 <main+0x64>  // b.pmore
  4005f0: 12800000 mov w0, #0xffffffff            // #-1
  4005f4: d63f0100 blr x8


  4005f8: 2a1f03e0 mov w0, wzr
  4005fc: a8c17bfd ldp x29, x30, [sp], #16
  400600: d65f03c0 ret
  400604: d4200020 brk #0x1

0000000000400608 <__typeid__ZTSFvvE_global_addr>:
  400608: 17ffffe3 b 400594 <foo.cfi>

000000000040060c <__typeid__ZTSFviE_global_addr>:
  40060c: 17ffffe3 b 400598 <bar.cfi>
  400610: 17ffffe3 b 40059c <baz.cfi>

So it looks like taking the address is fine, although not optimal due
to the additional jump. We could fudge around that by checking the
opcode at the target of the call, or token paste ".cfi" after the
symbol name in the static_call_update() macro, but it doesn't like
like anything is terminally broken tbh.
