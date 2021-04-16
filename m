Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AE5C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8055613B0
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhDPWxX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhDPWxW (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B45613CD
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 22:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618613577;
        bh=Z82q1BpPPjb/4+mIJ2BwX5XB1pq+e///2Kil21+66OE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fslg4x88dgjvn5+aUKFtTvfE91E7eFDrSNke+y7kGUBhxCs/24D2TSpYYiK9shHkq
         J5IlTcHp3puivOto80kYcaUDwXXQnvKUwdV7tgcVS98dpC/Xq1WvtkDX9Z1+CJpM78
         +o3wPx/l5q4OwhRGOteBLITcZw4eLqvYARAZk2yAFYFz89tQxpE3N0lib26s7VLYGp
         q++U6noVR8YEgEZhs5vLfcdMSnb6qHAewsggpy+ix/jVq5BpZ0EbhG8Rh25CMXX6d3
         G9EtP9wONnnjuMHWm1J5dGUMOEjJZG41uxOJl8iiV/H2DzdJxti+VXu/3feK3BHFoU
         8LifSWZqesy7Q==
Received: by mail-ej1-f42.google.com with SMTP id n2so44273159ejy.7
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:52:57 -0700 (PDT)
X-Gm-Message-State: AOAM533nsAHh5RD1am6dc1G0AezOm6DXK179+q0Zrq7up9tVy6WenkCe
        lo5nwyu6HrFdIeVAd/pKs+bhRvlJxl2oWecdvAKXYw==
X-Google-Smtp-Source: ABdhPJw0NuDyLHXoeBW6gELw5DA1U600swfEnA9u8U3JvpVcSMgudboWpO7EcQnrfU+cGQBASKlPK8SlF1/ZzfFDxgw=
X-Received: by 2002:a17:906:35ca:: with SMTP id p10mr10739772ejb.199.1618613576049;
 Fri, 16 Apr 2021 15:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <202104161519.1D37B6D26@keescook>
In-Reply-To: <202104161519.1D37B6D26@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 16 Apr 2021 15:52:44 -0700
X-Gmail-Original-Message-ID: <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
Message-ID: <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Kees Cook <keescook@chromium.org>
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

On Fri, Apr 16, 2021 at 3:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:
> > On Fri, Apr 16, 2021 at 3:03 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
> > > > __nocfi only disables CFI checking in a function, the compiler still
> > > > changes function addresses to point to the CFI jump table, which is
> > > > why we need function_nocfi().
> > >
> > > So call it __func_addr() or get_function_addr() or so, so that at least
> > > it is clear what this does.
> > >
> >
> > This seems backwards to me.  If I do:
> >
> > extern void foo(some signature);
> >
> > then I would, perhaps naively, expect foo to be the actual symbol that
> > gets called
>
> Yes.
>
> > and for the ABI to be changed to do the CFI checks.
>
> Uh, no? There's no ABI change -- indirect calls are changed to do the
> checking.

Maybe ABI is the wrong word, or maybe I'm not fully clued in.  But, if I do:

extern void call_it(void (*ptr)(void));

and I define call_it in one translation unit and call it from another,
the ABI effectively changed, right?  Because ptr is (depending on the
"canonical" mode) no longer a regular function pointer.

> > char entry_whatever[];
> > wrmsrl(..., (unsigned long)entry_whatever);
>
> This is just casting. It'll still resolve to the jump table entry.

How?  As far as clang is concerned, entry_whatever isn't a function at
all.  What jump table entry?

>
> > or, alternatively,
> >
> > extern void func() __attribute__((nocfi));
>
> __nocfi says func() should not perform checking of correct jump table
> membership for indirect calls.
>
> But we don't want a global marking for a function to be ignored by CFI;
> we don't want functions to escape CFI -- we want specific _users_ to
> either not check CFI for indirect calls (__nocfi) or we want specific
> passed addresses to avoid going through the jump table
> (function_nocfi()).

Maybe I spelled it badly, and I maybe I requested the wrong thing.
Here are actual required use cases.

1. I defined a function in asm.  I want to tell clang that this
function is defined in asm, and for clang to behave accordingly:

.globl func
func:
 ; do stuff

later:

extern void func(void) [something here];

There really should be a way to write this correctly such that it
works regardless of the setting of
-fsanitize-cfi-canonical-jump-tables.  This should not bypass CFI.  It
should *work*, with CFI enforced.  If I read all the various things
you linked correctly, this would be something like __cfi_noncanonical,
and I reserve the right to think that this is a horrible name.

2. I need a raw function pointer, thank you very much.  I would like
to be honest about it, and I don't really want to bypass CFI, but I
need the actual bits in the actual symbol.

translation unit 1 defines func.  Maybe it's C with
-fsanitize-cfi-canonical-jump-tables, maybe it's C with
-fno-sanitize-cfi-canonical-jump-tables or however it's spelled, and
maybe it's plain asm.  Now translation unit 2 does:

2a. Uses a literal symbol, because it's going to modify function text
or poke an MSR or whatever:

wrmsrl(MSR_WHATEVER, func);

clang needs to give us *some* way to have a correct declaration of
func such that we can, without resorting to inline asm kludges, get
the actual bit pattern of the actual symbol.

2b. Maybe optional: convert from function pointer to bit pattern of
actual symbol.

If someone gives me a real, correctly typed C pointer representing a
function pointer, I want a way to find the address of the body of the
function.  Then we can use it for things that aren't *calling* it per
se, e.g. disassembling it.  This is not necessarily a fully formed
thought right now, but I think something along these lines might be
needed.

The reverse of 2b (converting from actual symbol to function pointer)
might be equivalent to 1, or it might not.  I suppose there are some
subtleties here.

Be that as it may, it sounds like right now clang has some issues
interoperating with asm when CFI is enabled.  If so, clang needs to be
improved.

(The unsigned long hack is not necessarily good enough.  I should be able to do:

.global func
func:
 ; C ABI compliant code here

extern void func(void) [attribute as in 1]

unsigned long actual_address = [something clang actually understands](func);

If this thing refuses to work when fed a nonconstant function pointer
because of some genuinely good reason, fine.  But, if 'func' is an
actual literal symbol name, this thing needs to be compile-time
constant expression.

>
> So, instead of a cast, a wrapper is used to bypass instrumentation in
> the very few cases its needed.

NAK.  The compiler needs to cooperate IMO.

>
> (Note that such a wrapper is no-op without CFI enabled.)

> But note that this shouldn't turn into a discussion of "maybe Clang could
> do CFI differently"; this is what Clang has.
>
> https://clang.llvm.org/docs/ControlFlowIntegrity.html

If this is what Clang has, and Clang won't improve, then we can just
not apply these patches...
