Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E6DC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD26260EB9
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhKBSYF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhKBSYE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 14:24:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C0C061714;
        Tue,  2 Nov 2021 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K0rz7LT+kgomD5KRNtzJy6G/J+BhWbgnVLi0ic650I0=; b=dJ9VibV9ZrIwDjTaMbTXmZwZJX
        bQdjfemLebGdpEQOacA+0IGSYwxaZ2EEsxlDJoBA/7WGVPPvXM28251CmPRdMYAXDntAQNHhHO0qV
        v/AZ3mS1k2WDG6fuSg4lrISg4c/IUw87Hr9DHet8l6dnXtycetIdmRuQ3dbe7aG2MIJsAKg8Ln/wf
        Du1BBQbjLlOkUWucCwT04KkXyBGzzx/FlqeOdprJT4oNWi1klCNgmOcCmpXjuv6DpERZKM5fcoUJt
        3oWDqrb1qRK9nZQLnZGbk05TaWcsdWVfoTW1vBCysM9Zo3gH79uPwio2TEtFo2kUGosnxE9/JPTiS
        k3is7y+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhyKF-004g3M-IV; Tue, 02 Nov 2021 18:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7A2630022C;
        Tue,  2 Nov 2021 19:15:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B704E2D53269D; Tue,  2 Nov 2021 19:15:58 +0100 (CET)
Date:   Tue, 2 Nov 2021 19:15:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, joao@overdrivepizza.com
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <YYGAXtequQDQeP0R@hirez.programming.kicks-ass.net>
References: <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <20211030081631.GF174730@worktop.programming.kicks-ass.net>
 <202111021029.79D81E590@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111021029.79D81E590@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 02, 2021 at 10:35:30AM -0700, Kees Cook wrote:
> On Sat, Oct 30, 2021 at 10:16:31AM +0200, Peter Zijlstra wrote:
> > foo.cfi:
> > 	endbr
> > 	xorl $0xdeadbeef, %r10d
> > 	jz foo
> > 	ud2
> > 	nop	# make it an even 16 bytes
> > foo:
> > 	# actual function text
> > 
> > 
> > Then have the address of foo, be the address of foo, like any normal
> > sane person would expect. Have direct calls to foo, go to foo, again, as
> > expected.
> > 
> > When doing an indirect call (to r11, as clang does), then, and only
> > then, do:
> > 
> > 	movl $0xdeadbeef, %r10d
> > 	subq $0x10, %r11
> > 	call *%r11
> > 
> > 	# if the r11 lives, add:
> > 	addq $0x10, %r11
> > 
> > 
> > Then only when caller and callee agree 0xdeadbeef is the password, does
> > the indirect call go through.
> > 
> > Why isn't this a suitable CFI scheme even without IBT?
> 
> The trouble is that the callee is doing the verification. There's no
> protection against calling into a callee that doesn't perform a check
> (e.g. BPF JIT, or otherwise constructed executable memory, etc). The
> caller needs to do the verification that what they're calling into is
> safe before it makes the call.

Right, Ard said the same, see new crackpot scheme here:

  https://lkml.kernel.org/r/YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net
