Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F32BC433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22123613C1
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhDPWU4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhDPWUy (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF4F613C1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618611629;
        bh=cw+o8cfEuCo6PQdHXEsdN0LoqovEdVoWI1b2P0UF/Og=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jxKsP0Fr9kLKdD37KZFr2gu8uqJ4eMaAup4AizAaAIdv9BKvzqPDEgdgbRBqum7zC
         lWKQeigSIzxGjTJHEiwDs9xOo/IJUbEib4DA3B84aEQ5lLth2jUfE9lUj4h8QdAD1E
         9Z2obm0iE+pEWoFyv7etI8gGBQtinezT/unZfPuCAuFvRIfPS4bKZ7yN9BeXLOXjNl
         lVBK12qMeYLlfofHvBxBmpPC1+zZX59BpJkWseUTGLjyQuWLncZGNvRiMC4y2Qys4I
         lhxVTpq9Aa87Zkp9Jcnq1KIFqAcjpNd7gurH56WiNZd/0MotMjImyhskUQyILS3pOl
         CQiDJVampjCng==
Received: by mail-ed1-f49.google.com with SMTP id o20so7735460edc.7
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:20:29 -0700 (PDT)
X-Gm-Message-State: AOAM531K/++fDLKcGYhlCMkN3vRSJ9MAEEcT4TNca7Vx5hOyisNZjwqt
        QyiK3186UUO+INJi0dmn7ZBGEcw11YAAjhHX5bnhFw==
X-Google-Smtp-Source: ABdhPJwrhXiYlU+qO4b6VCJY/F1yFSIFXZAHioVtpExmGxj4TZL8vcEumj5aGB0McOtELfNfByc/+fwJgoYDXb5XsJs=
X-Received: by 2002:a50:f395:: with SMTP id g21mr12764633edm.238.1618611628139;
 Fri, 16 Apr 2021 15:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <20210416221414.GF22348@zn.tnic>
In-Reply-To: <20210416221414.GF22348@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 16 Apr 2021 15:20:17 -0700
X-Gmail-Original-Message-ID: <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com>
Message-ID: <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Fri, Apr 16, 2021 at 3:14 PM Borislav Petkov <bp@alien8.de> wrote:
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
>
> I'm just reading the patch:
>
> ... The function_nocfi macro always returns the address of the
> + * actual function instead.
> + */
> +#define function_nocfi(x) ({                                           \
> +       void *addr;                                                     \
> +       asm("leaq " __stringify(x) "(%%rip), %0\n\t" : "=r" (addr));    \
> +       addr;
>
> so it does a rip-relative load into a reg which ends up with the function
> address.

This is horrible.

We made a mistake adapting the kernel to GCC's nonsensical stack
protector ABI, especially on 32-bit, instead of making GCC fix it.
Let's not repeat this with clang please.

Sami, I'm assuming that:

extern void func(void);

results in anything that takes a pointer to func getting a pointer to
some special magic descriptor instead of to func, so that:

void (*ptr)(void);
ptr = func;
ptr();

does the right thing.  Then void (*)(void) is no longer a raw pointer.  Fine.

But obviously there is code that needs real function pointers.  How
about making this a first-class feature, or at least hacking around it
more cleanly.  For example, what does this do:

char entry_whatever[];
wrmsrl(..., (unsigned long)entry_whatever);

or, alternatively,

extern void func() __attribute__((nocfi));

void (*ptr)(void);
ptr = func;  /* probably fails to compile -- invalid conversion */

(unsigned long)func /* returns the actual pointer */

func();  /* works like normal */

And maybe allow this too:

void (*ptr)(void) __attribute__((nocfi);
ptr = func;
ptr();  /* emits an unchecked call.  maybe warns, too.  anyone who
does this needs to be extremely careful. */

--Andy
