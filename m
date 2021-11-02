Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C93FC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760BE61075
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhKBRro (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234183AbhKBRro (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 13:47:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45BE460E78;
        Tue,  2 Nov 2021 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635875109;
        bh=yWjcLlrvgIGtTAiG1zZiA6MB6dlr4uGs44gsa0DhfcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrTNH7KtDSdoJkcNTJywHXN25W0vuQJMdUtC4NjMV13YC/sSZDjs8+ySNzelWwpOK
         K8hb6VLzvZxqlYZZWJ3U3Vb6HkeTHqQQ09CaxYSTL9X6T9jFKiDxXeL9ePopdUmSIA
         Rrfe95VE9NAjURH+08rFNaEGYIt6slNtIXGpFPAmD5lMsPOHHo+07d64LFNCMkuL1y
         KVaj+owdcC4LhI9diyB059pfRR4acfoqNUL7LjqeBl2655ladKAG/75ff4Xx9K8fkB
         VAY8fUIJERKM3AULK6fsIyjykDEiZdapq34o0MPczEN80mSkOlzQVN8VSuxiNOz9Et
         EmxIM5qrsDdmA==
Received: by mail-ot1-f48.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso1998459otv.7;
        Tue, 02 Nov 2021 10:45:09 -0700 (PDT)
X-Gm-Message-State: AOAM530QleEtDYVhQ5HClUYCzRsytOAIqdsGcnxehwsu2cc9Sv2Xtp34
        06TIygVgdbnfWEZ0mShhuSaDAZht7EVDHw5yV7s=
X-Google-Smtp-Source: ABdhPJzxLOJ2cc+e9NgVcmRHiYnrlNE12fRZQPe+twczdnkd8UkrVfBwA7sTBVs4xZ328qHu6QbzkkDLrpBnsoFY+nI=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr27846692oti.147.1635875108561;
 Tue, 02 Nov 2021 10:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net> <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net> <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net> <YYFWEnBb/UaZKGzz@hirez.programming.kicks-ass.net>
In-Reply-To: <YYFWEnBb/UaZKGzz@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 Nov 2021 18:44:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFQSitDY5WT246YEXXFphUv_HSjBrgvGzQGiCr4jLrM+g@mail.gmail.com>
Message-ID: <CAMj1kXFQSitDY5WT246YEXXFphUv_HSjBrgvGzQGiCr4jLrM+g@mail.gmail.com>
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

On Tue, 2 Nov 2021 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
>
> > So how insane is something like this, have each function:
> >
> > foo.cfi:
> >       endbr64
> >       xorl $0xdeadbeef, %r10d
> >       jz foo
> >       ud2
> >       nop     # make it 16 bytes
> > foo:
> >       # actual function text goes here
> >
> >
> > And for each hash have two thunks:
> >
> >
> >       # arg: r11
> >       # clobbers: r10, r11
> > __x86_indirect_cfi_deadbeef:
> >       movl -9(%r11), %r10             # immediate in foo.cfi
> >       xorl $0xdeadbeef, %r10          # our immediate
> >       jz 1f
> >       ud2
> > 1:    ALTERNATIVE_2   "jmp *%r11",
> >                       "jmp __x86_indirect_thunk_r11", X86_FEATURE_RETPOLINE
> >                       "lfence; jmp *%r11", X86_FEATURE_RETPOLINE_AMD
> >

So are these supposed to go into the jump tables? If so, there still
needs to be a check against the boundary of the table at the call
site, to ensure that we are not calling something that we shouldn't.

If they are not going into the jump tables, I don't see the point of
having them, as only happy flow/uncomprised code would bother to use
them.


> >
> >
> >       # arg: r11
> >       # clobbers: r10, r11
> > __x86_indirect_ibt_deadbeef:
> >       movl $0xdeadbeef, %r10
> >       subq $0x10, %r11
> >       ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE
> >       jmp *%r11
> >
>
> These two thunks could of course be one big alternative.
>
> > And have the actual indirect callsite look like:
> >
> >       # r11 - &foo
> >       ALTERNATIVE_2   "cs call __x86_indirect_thunk_r11",
> >                       "cs call __x86_indirect_cfi_deadbeef", X86_FEATURE_CFI
> >                       "cs call __x86_indirect_ibt_deadbeef", X86_FEATURE_IBT
>
> Also simplifying this.
>
> > Although if the compiler were to emit:
> >
> >       cs call __x86_indirect_cfi_deadbeef
> >
> > we could probaly fix it up from there.
> >
> >
> > Then we can at runtime decide between:
> >
> >   {!cfi, cfi, ibt} x {!retpoline, retpoline, retpoline-amd}
> >
