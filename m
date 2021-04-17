Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3352C433ED
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 23:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B208F6121D
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 23:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhDQXT5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Apr 2021 19:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhDQXTy (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Apr 2021 19:19:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F47460FEF
        for <linux-hardening@vger.kernel.org>; Sat, 17 Apr 2021 23:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618701567;
        bh=wbpeHFstXghdORuec36q9wY79cgW73LxBcnaZ3Ao/bY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GFpv32NXVTGVK0XzUJMjF/SYKO6+t4+HJpPTPtcEJLW9ggxU7MJhsRPLkGGkNsS12
         NGzgrzMcFCgMVYO9XuldqrLPw9iVZVwiSVHTMAoB6mDdI1z6GeH724nrD3vc1UxalD
         +osBHCpePmTZJAGJOac+2vSK1rGt7r8I8oI/rUt0v2+wSyWCrTfEF2sf0GvkMDiqgg
         p5wi/aCKsDjXJrKhUj4a6Ap8gztneY2+5C3Qa2ouQ8R+7cDLel/SZvxjvY9Sc3TfxH
         d2YRouKRUr1PeVZXxy1zeBfbc0wjN4XxoZWPrKX0DtOfPhl4MCAXDuyZk4uuH/alxX
         c7XLhFPOUW1jQ==
Received: by mail-ej1-f48.google.com with SMTP id r9so47361658ejj.3
        for <linux-hardening@vger.kernel.org>; Sat, 17 Apr 2021 16:19:27 -0700 (PDT)
X-Gm-Message-State: AOAM533jZaeGWBhDrs3tPBsnxeDNJ33b7xvJ5MBaM37oppRLZ9hruxXd
        GPu0Hm5WglaU8rRAtQcfOVFIi0uxHT81sJYO9ql9Fw==
X-Google-Smtp-Source: ABdhPJyCju/ENHhOLYbSm0xjxP6udpuBOmnjQOCOs6DiiJMHKJS+NWtRkWIPl+6dgPgbfHxVS0ro+PT58YwRMGfaiZQ=
X-Received: by 2002:a17:906:7104:: with SMTP id x4mr14824074ejj.101.1618701565496;
 Sat, 17 Apr 2021 16:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook> <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
 <202104161601.CFB2CCF84F@keescook>
In-Reply-To: <202104161601.CFB2CCF84F@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 17 Apr 2021 16:19:14 -0700
X-Gmail-Original-Message-ID: <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
Message-ID: <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 4:40 PM Kees Cook <keescook@chromium.org> wrote:
>

> > 1. I defined a function in asm.  I want to tell clang that this
> > function is defined in asm, and for clang to behave accordingly:
> >
> > .globl func
> > func:
> >  ; do stuff
> >
> > later:
> >
> > extern void func(void) [something here];
> >
> > There really should be a way to write this correctly such that it
> > works regardless of the setting of
> > -fsanitize-cfi-canonical-jump-tables.  This should not bypass CFI.  It
> > should *work*, with CFI enforced.  If I read all the various things
> > you linked correctly, this would be something like __cfi_noncanonical,
> > and I reserve the right to think that this is a horrible name.
>
> Yes, I find the name confusing too. Without noncanonical, we'd need
> C call wrappers for every single .S function that had its address
> taken. This is very common in crypto, for example. That level of extra
> code seemed like a total non-starter. Instead, we just get a few places
> we have to mark.

The patch you linked doesn't have a noncanonical attribute, though.
So I'm not sure how to reliably call into asm from C.

(The more I think about it, the less I like "canonical".  What is
"canonical"?  The symbol?  The function body?  Something else?)

>
> > 2. I need a raw function pointer, thank you very much.  I would like
> > to be honest about it, and I don't really want to bypass CFI, but I
> > need the actual bits in the actual symbol.
> >
> > translation unit 1 defines func.  Maybe it's C with
> > -fsanitize-cfi-canonical-jump-tables, maybe it's C with
> > -fno-sanitize-cfi-canonical-jump-tables or however it's spelled, and
> > maybe it's plain asm.  Now translation unit 2 does:
> >
> > 2a. Uses a literal symbol, because it's going to modify function text
> > or poke an MSR or whatever:
> >
> > wrmsrl(MSR_WHATEVER, func);
> >
> > clang needs to give us *some* way to have a correct declaration of
> > func such that we can, without resorting to inline asm kludges, get
> > the actual bit pattern of the actual symbol.
>
> We don't want version of a global symbol alias of func that points to
> the function body, though; it's only very specific cases where this
> should be stripped (MSR, ftrace, etc).
>
> So, if there were some Clang-specific syntax for this, it would still be
> used on a case-by-case basis. It would still be something like:
>
> wrmsrl(MSR_WAT, __builtin_gimme_body_p(func));
>

> Okay, you're saying you want __builtin_gimme_body_p() to be a constant
> expression for the compiler, not inline asm?

Yes.

I admit that, in the trivial case where the asm code is *not* a
C-ABI-compliant function, giving a type that doesn't fool the compiler
into thinking that it might be is probably the best fix.  Maybe we
should standardize something, e.g.:

struct raw_symbol;  /* not defined anywhere */
#define DECLARE_RAW_SYMBOL(x) struct raw_symbol x[]

and then we write this:

DECLARE_RAW_SYMBOL(entry_SYSCALL_64);

wrmsrl(..., (unsigned long)entry_SYSCALL_64);

It would be a bit nifty if we didn't need a forward declaration, but
I'm not immediately seeing a way to do this without hacks that we'll
probably regret;

But this doesn't help the case in which the symbol is an actual
C-callable function and we want to be able to call it, too.
