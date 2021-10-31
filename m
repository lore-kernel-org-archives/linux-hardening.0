Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BEC433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E4660F45
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 16:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJaQmT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 31 Oct 2021 12:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJaQmS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 31 Oct 2021 12:42:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B7C061570;
        Sun, 31 Oct 2021 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rp8yNDT9JB3LRMzfJfNEleH+RHkEoWlw4lzlXDzKQ2Q=; b=UNp+S5lm+9UO/WwnKsquJL5VaW
        o1wjfKIigJwTbq/CJO1kPGEPcQq7Xr0g78T8w2aRUazqhwlewYudyFJRQiZRBRsnCD7Ff5YtQA0fH
        LmMXzNjOq0Erd2Fon1jLSDE0y+J8Vh1c/xwFsI1dKIQeBCRNcieZfM/hqH+OwoE6uv3Pt8ASQGlpt
        UwAkeHrXcpydWkCB4CQr3MN9uQX70AhHfNqM2nWJjck7DfndNX/LfLg/4heeY1phv/k6vSiskfpni
        QAIfQydKMvg5+E3b1rqEKrIs7/J0OT0gEUNa2znRPqFIPhrFE+VSHp7P6wbFw9OclAE6unWdwaT3W
        motZbuxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhDre-00DQF6-8i; Sun, 31 Oct 2021 16:39:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1476984CD2; Sun, 31 Oct 2021 17:39:20 +0100 (CET)
Date:   Sun, 31 Oct 2021 17:39:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
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
        llvm@lists.linux.dev
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <20211031163920.GV174703@worktop.programming.kicks-ass.net>
References: <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net>
 <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 31, 2021 at 05:24:13PM +0100, Ard Biesheuvel wrote:
> On Sat, 30 Oct 2021 at 20:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sat, 30 Oct 2021 at 20:03, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sat, Oct 30, 2021 at 07:19:53PM +0200, Ard Biesheuvel wrote:
> > > > I just realized that arm64 has the exact same problem, which is not
> > > > being addressed by my v5 of the static call support patch.
> > >
> > > Yeah, it would.
> > >
> > > > As it turns out, the v11 Clang that I have been testing with is broken
> > > > wrt BTI landing pads, and omits them from the jump table entries.
> > > > Clang 12+ adds them properly, which means that both the jump table
> > > > entry and the static call trampoline may start with BTI C + direct
> > > > branch, and we also need additional checks to disambiguate.
> > >
> > > I'm not sure, why would the static_call trampoline need a BTI C ? The
> > > whole point of static_call() is to be a direct call, we should never
> > > have an indirect call to the trampoline, that would defeat the whole
> > > purpose.
> >
> > This might happen when the distance between the caller and the
> > trampoline is more than 128 MB, in which case we emit a veneer that
> > uses an indirect call as well. So we definitely need the landing pad
> > in the trampoline.
> 
> Something like the below seems to work to prevent getting the wrong
> trampoline address into arch_static_call_transform:

Is is also a terriblly gross hack. I really want the clang-cfi stuff to
improve, not add layers of hacks on top of it.
