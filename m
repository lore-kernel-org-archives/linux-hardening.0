Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0CC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61CB60EB9
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKBSVp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234908AbhKBSVm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 14:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D93C261050;
        Tue,  2 Nov 2021 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635877146;
        bh=h3FsxzoZsN4ni/4lI/yEk7+MdpyXKG1ci08/Ok2la5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hWPt9XW3nVDGVvqzjQYUqgfumWPiYtangbEBaE3Px55WQTYw+sG9+3lqDRZvtAtkd
         cMztv0svVeIGV3boaaIBY7KkKd8Ur7AvJgZZBH//s5ck2FRxU9/2FzVPk61908Ub/o
         UbNm1lHX+/K03QzDQ9ta14+AjBh82tESzPS8oYU0mc4tl6D38z60esOoLSRzmf99k0
         KnDVvRu2u0lviEd4yKUz9KUUOPJNmXprVe5P+/tPHQi7zkh+lOJ7HrdqXMNxZzrS9n
         CXf/M6djB7IPiGhmsYQQ8ERUM/HCn9wM05WDNguMIoqidIKbg8qyk0Dws9LM/BzN+j
         Ewnh7sIYbkuZA==
Received: by mail-ot1-f48.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso60024otj.10;
        Tue, 02 Nov 2021 11:19:06 -0700 (PDT)
X-Gm-Message-State: AOAM5315cHEqGln/AOwgRWUjAgl2m6RW9KPyeI/+sufjVThJu9WI+WKu
        +N9GTavUD2DwAAtrXEFtVSpQFGoWRJz3RxN0oXM=
X-Google-Smtp-Source: ABdhPJxrWULj7AK5fSXolNdR3bzb7riOJO8zZJ4Vmi6cbfk/UgM4PodTzpd9r0hc5QUTvTb2q4BmPq+wwUCTkAi9VFY=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr28007931oti.147.1635877146217;
 Tue, 02 Nov 2021 11:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net> <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net> <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net> <YYFWEnBb/UaZKGzz@hirez.programming.kicks-ass.net>
 <CAMj1kXFQSitDY5WT246YEXXFphUv_HSjBrgvGzQGiCr4jLrM+g@mail.gmail.com> <YYGAAVG5aRDKRHso@hirez.programming.kicks-ass.net>
In-Reply-To: <YYGAAVG5aRDKRHso@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 Nov 2021 19:18:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHm99QNdHXUUAAJFD+M5VC-xFqjUoEVyg+oGkiJM51daA@mail.gmail.com>
Message-ID: <CAMj1kXHm99QNdHXUUAAJFD+M5VC-xFqjUoEVyg+oGkiJM51daA@mail.gmail.com>
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
        llvm@lists.linux.dev, joao@overdrivepizza.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 2 Nov 2021 at 19:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 02, 2021 at 06:44:56PM +0100, Ard Biesheuvel wrote:
> > On Tue, 2 Nov 2021 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
> > >
> > > > So how insane is something like this, have each function:
> > > >
> > > > foo.cfi:
> > > >       endbr64
> > > >       xorl $0xdeadbeef, %r10d
> > > >       jz foo
> > > >       ud2
> > > >       nop     # make it 16 bytes
> > > > foo:
> > > >       # actual function text goes here
> > > >
> > > >
> > > > And for each hash have two thunks:
> > > >
> > > >
> > > >       # arg: r11
> > > >       # clobbers: r10, r11
> > > > __x86_indirect_cfi_deadbeef:
> > > >       movl -9(%r11), %r10             # immediate in foo.cfi
> > > >       xorl $0xdeadbeef, %r10          # our immediate
> > > >       jz 1f
> > > >       ud2
> > > > 1:    ALTERNATIVE_2   "jmp *%r11",
> > > >                       "jmp __x86_indirect_thunk_r11", X86_FEATURE_RETPOLINE
> > > >                       "lfence; jmp *%r11", X86_FEATURE_RETPOLINE_AMD
> > > >
> >
> > So are these supposed to go into the jump tables? If so, there still
> > needs to be a check against the boundary of the table at the call
> > site, to ensure that we are not calling something that we shouldn't.
> >
> > If they are not going into the jump tables, I don't see the point of
> > having them, as only happy flow/uncomprised code would bother to use
> > them.
>
> I don't understand. If you can scribble your own code, you can
> circumvent pretty much any range check anyway.

A function pointer is data not code.

> But if you can't scribble
> your own code, you get to use the branch here and that checks the
> callsite and callee signature.
>

OK, so the call site has a direct branch to this trampoline then? That
wasn't clear to me.

> The range check isn't fundamental to CFI, having a check is the
> important thing AFAIU.

Agreed. If the call site has a direct branch, it doesn't need the range check.
