Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD3C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F64760E9B
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhKCIlx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhKCIlx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Nov 2021 04:41:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B2C061714;
        Wed,  3 Nov 2021 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JsSCd4BUHuy7v+Nl/hcJhjaRwZ5I4g7Y8Z+ohPTpfsQ=; b=sOFEALajwKbrh4NJXZglhMjojt
        sslQXZ6An3xS/C5R4ixgCsmtppAP2XYyjf6b+umCO0YCJ4Q9vocClZkgKgu767KW7hmBIWoCiwqH/
        SJem8ZBkFM3C0RhR4e8SmS5GwsFSdX0VQUpf5vyP6aH8thGxQw4HwE58snW4k97RxqQuHhOLKP7Xq
        lWJTy4x6UO20nW2URnTbs2k5GMR87vi5jrbWcdHPnWESyp3ZaVAcYoCsDo0mRGojnkOCgKGeKgxUF
        15kUPASdSFIG+XRyerIRFVGDKbdmKvWSfNZMG/6idh2SoXYBar2S7Rn9tuCjRQ1EDUaiETM21lcgV
        D/95v6Tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miBkW-00550p-6T; Wed, 03 Nov 2021 08:36:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C745F986378; Wed,  3 Nov 2021 09:35:59 +0100 (CET)
Date:   Wed, 3 Nov 2021 09:35:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <20211103083559.GB174703@worktop.programming.kicks-ass.net>
References: <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
 <90a14299-ce56-41d5-9df9-f625aae1ac70@www.fastmail.com>
 <202111021603.EDE5780FE@keescook>
 <bbde172b-2dae-fdc0-fbb5-edec6752c740@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbde172b-2dae-fdc0-fbb5-edec6752c740@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 02, 2021 at 05:20:05PM -0700, Andy Lutomirski wrote:
> I think that's a big mistake -- any sane ENDBR-using scheme would
> really prefer that ENDBR to be right next to the actual function body,
> and really any scheme would benefit due to better cache locality. 

Agreed, IBT/BTI want the landing pad in front of the actual function.

> But, more importantly, IMO any sane ENDBR-using scheme wants to
> generate the indirect stub as part of code gen for the actual
> function.

Sorta, I really want to be able to not have a landing pad for functions
whose address is never taken. At that point it doesn't matter if it gets
generated along with the function and then stripped/poisoned later, or
generated later.

As such, the landing pad should not be part of the function proper,
direct calls should never observe it.

Less landing pads is more better.
