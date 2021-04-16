Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF5C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 23:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C07610F7
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 23:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhDPXkt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhDPXkt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 19:40:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5AFC061756
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 16:40:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 31so4742917pgn.13
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/HF9zm2yknbU18v/xjP0mndiiqfo5zeMGWyKBs/FEE=;
        b=fNj3+t9w3E+YI9R5i+zh3vgQb1Yd7iapqnHNXcCA0i7WTaYZmHrTxoQTlBPQaercfd
         5HzIP//6mgyndqbsT96Gce1X5395v5R5m/ZIBfw8xdYrxJ7INMN4FriE4EytCWD71Nu4
         Lc5CjJKSHtLIBtFZdJ7pd4PMetZlLdCNuOvlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/HF9zm2yknbU18v/xjP0mndiiqfo5zeMGWyKBs/FEE=;
        b=qnRjqi1H8O2W0+Jv715VHMLTySC+NND/h7bV7tZJ3tvPh7Fl6ysb6MkdalqgJ4iOC9
         3Wxbs+HOYp5qsrb/GaP/RoIdNhC4uAcpElSSe3TxixgVzkiO8Bl0xUQfynN6Y52azWS2
         yHPH9/OQnAfCqQd5iW9bdHAf3b3WwbUBDTzPV0H754M6aOrl2K2qKS+O27nAWEJ2qMmx
         CyXAdBR8VZbJqQ8XK5otOU+R3vF/VAXh7JuxxV8bIqYlLTC/rgZQ6mJgB8B6YExfvPV7
         9uCSEWLDUqWlaQM109NugO28PaSIfpgnEbEw0UYavncW+GMZnixWGbFJQbJ+RjPrXDMk
         4qdw==
X-Gm-Message-State: AOAM532c5JkWDWErsVqBM7aAczufG0Th3l1VMj9BVEw4aqbg3SxbzaCA
        +A3V78fcEyE3bPtSPxf81cIjig==
X-Google-Smtp-Source: ABdhPJyzFpaJrTjb1cqBDkZaZsdoSF16uWy/e/fhmZg0qJlOYqRqTmLqfquB+GRLxih03wSyie1WSQ==
X-Received: by 2002:a63:ee49:: with SMTP id n9mr1293583pgk.3.1618616423721;
        Fri, 16 Apr 2021 16:40:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o18sm6435771pji.10.2021.04.16.16.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:40:23 -0700 (PDT)
Date:   Fri, 16 Apr 2021 16:40:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Message-ID: <202104161601.CFB2CCF84F@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
 <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 03:52:44PM -0700, Andy Lutomirski wrote:
> Maybe ABI is the wrong word, or maybe I'm not fully clued in.  But, if I do:
> 
> extern void call_it(void (*ptr)(void));
> 
> and I define call_it in one translation unit and call it from another,
> the ABI effectively changed, right?  Because ptr is (depending on the
> "canonical" mode) no longer a regular function pointer.

Right, I was thinking maybe "calling convention", or really, "the
ability to still use 'ptr' as if it were a function". Which is true,
yes. It's just that 'ptr' is aimed at a jump table that jumps to the
"true" function body.

> 1. I defined a function in asm.  I want to tell clang that this
> function is defined in asm, and for clang to behave accordingly:
> 
> .globl func
> func:
>  ; do stuff
> 
> later:
> 
> extern void func(void) [something here];
> 
> There really should be a way to write this correctly such that it
> works regardless of the setting of
> -fsanitize-cfi-canonical-jump-tables.  This should not bypass CFI.  It
> should *work*, with CFI enforced.  If I read all the various things
> you linked correctly, this would be something like __cfi_noncanonical,
> and I reserve the right to think that this is a horrible name.

Yes, I find the name confusing too. Without noncanonical, we'd need
C call wrappers for every single .S function that had its address
taken. This is very common in crypto, for example. That level of extra
code seemed like a total non-starter. Instead, we just get a few places
we have to mark.

> 2. I need a raw function pointer, thank you very much.  I would like
> to be honest about it, and I don't really want to bypass CFI, but I
> need the actual bits in the actual symbol.
> 
> translation unit 1 defines func.  Maybe it's C with
> -fsanitize-cfi-canonical-jump-tables, maybe it's C with
> -fno-sanitize-cfi-canonical-jump-tables or however it's spelled, and
> maybe it's plain asm.  Now translation unit 2 does:
> 
> 2a. Uses a literal symbol, because it's going to modify function text
> or poke an MSR or whatever:
> 
> wrmsrl(MSR_WHATEVER, func);
> 
> clang needs to give us *some* way to have a correct declaration of
> func such that we can, without resorting to inline asm kludges, get
> the actual bit pattern of the actual symbol.

We don't want version of a global symbol alias of func that points to
the function body, though; it's only very specific cases where this
should be stripped (MSR, ftrace, etc).

So, if there were some Clang-specific syntax for this, it would still be
used on a case-by-case basis. It would still be something like:

wrmsrl(MSR_WAT, __builtin_gimme_body_p(func));

Which is basically what already exists, just with a different name.

> 2b. Maybe optional: convert from function pointer to bit pattern of
> actual symbol.
> 
> If someone gives me a real, correctly typed C pointer representing a
> function pointer, I want a way to find the address of the body of the
> function.  Then we can use it for things that aren't *calling* it per
> se, e.g. disassembling it.  This is not necessarily a fully formed
> thought right now, but I think something along these lines might be
> needed.
> 
> The reverse of 2b (converting from actual symbol to function pointer)
> might be equivalent to 1, or it might not.  I suppose there are some
> subtleties here.
> 
> Be that as it may, it sounds like right now clang has some issues
> interoperating with asm when CFI is enabled.  If so, clang needs to be
> improved.
> 
> (The unsigned long hack is not necessarily good enough.  I should be able to do:
> 
> .global func
> func:
>  ; C ABI compliant code here
> 
> extern void func(void) [attribute as in 1]
> 
> unsigned long actual_address = [something clang actually understands](func);
> 
> If this thing refuses to work when fed a nonconstant function pointer
> because of some genuinely good reason, fine.  But, if 'func' is an
> actual literal symbol name, this thing needs to be compile-time
> constant expression.

Okay, you're saying you want __builtin_gimme_body_p() to be a constant
expression for the compiler, not inline asm?

Given the very few places this is expected to be used, and the fact that
it works as-is already, why is this additional requirement useful?

> > So, instead of a cast, a wrapper is used to bypass instrumentation in
> > the very few cases its needed.
> 
> NAK.  The compiler needs to cooperate IMO.

It's trying very hard. ;)

> > But note that this shouldn't turn into a discussion of "maybe Clang could
> > do CFI differently"; this is what Clang has.
> >
> > https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> If this is what Clang has, and Clang won't improve, then we can just
> not apply these patches...

I'm not saying Clang can't change -- I'm saying redesigning the entire
implementation of Clang's CFI isn't feasible, and I want to avoid having
that become the requirement because that's unreasonable. Clang's current
CFI works for many other projects, it's supported, it's what Android
has been using on its kernels 3 years now. The twist, obviously, is that
other projects don't use asm the way the kernel does, so that's where
things get weird, and where we've already been getting help from LLVM
folks to improve the situation.

If the solution is a new Clang builtin, okay, but I'd just like to
understand why that's justified compared to the existing solution
(especially since the resulting machine code is likely to be nearly
identical in the current uses).

-Kees

-- 
Kees Cook
