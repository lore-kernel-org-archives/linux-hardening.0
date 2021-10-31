Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA3C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C9860F4A
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJaUOt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 31 Oct 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhJaUOt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 31 Oct 2021 16:14:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0654C061570;
        Sun, 31 Oct 2021 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OW5ANKTELS4/Aqv77rAWcip0XRuLRuzAugVfabAVKQc=; b=eNFWK3G4bwmB14XaQrXIvSMW1f
        PdSYpdhYYUuAc84UDg5jz3ejRlnl1XNm8wfgH4eT8vgg/f736jKT8ghTEodQXsj0TLEuCTYvCgOPG
        +bnnwxP9zYkrUheSfcKwtKZFRhrTb2FbR77abGWs1QSa8Nnef0cnGx7d5BnlKw86ohUudlPwTrtF1
        Evmcz7DRAUvFkWB3Lm0TRX+ljtIuHxLH4CB5KdLiJciuCEUwDnj7CQUCNTUocE2uOOTPcuB48RNJA
        zgS4tg7oJ+T62KeegFL34bkODuNiPuiqD04eSkhfGpyOvwApV6BFHR51QjsIgcL0taMyu9Smqkvh7
        BN3597nA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhH9I-003HDw-Cz; Sun, 31 Oct 2021 20:10:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 712FA300243;
        Sun, 31 Oct 2021 21:09:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5250625F3BD9C; Sun, 31 Oct 2021 21:09:46 +0100 (CET)
Date:   Sun, 31 Oct 2021 21:09:46 +0100
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
Message-ID: <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
References: <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net>
 <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 31, 2021 at 05:44:04PM +0100, Ard Biesheuvel wrote:

> > Is is also a terriblly gross hack. I really want the clang-cfi stuff to
> > improve, not add layers of hacks on top of it.
> 
> I'm just as annoyed as you are about the apparent need for this.
> However, emitting an alias at build time is far better IMHO than
> adding a magic byte sequence and having to check it at runtime.

Oh, I'm keeping that magic sequence :-) That's hardening in general, and
I don't want to ever want to debug a wrong poke like that again.

Adding an extra label fixes this thing, but there's still the other
cases where we need/want/desire a *real* function pointer.

I'm very close to saying that anything that mucks up function pointers
like this is a complete non-starter. Let's start re-start this whole CFI
endeavour from the start.
