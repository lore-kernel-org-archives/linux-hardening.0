Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E1C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36AC60F70
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhJ0MHs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:48 -0400
Received: from foss.arm.com ([217.140.110.172]:42596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237257AbhJ0MHr (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892C31FB;
        Wed, 27 Oct 2021 05:05:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.72.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71BEA3F73D;
        Wed, 27 Oct 2021 05:05:18 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:05:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ardb@kernel.org
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211027120515.GC54628@C02TD0UTHF1T.local>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026201622.GG174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 26, 2021 at 10:16:22PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 11:16:43AM -0700, Sami Tolvanen wrote:
> > This series adds support for Clang's Control-Flow Integrity (CFI)
> > checking to x86_64. With CFI, the compiler injects a runtime
> > check before each indirect function call to ensure the target is
> > a valid function with the correct static type. This restricts
> > possible call targets and makes it more difficult for an attacker
> > to exploit bugs that allow the modification of stored function
> > pointers. For more details, see:
> > 
> >   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> So, if I understand this right, the compiler emits, for every function
> two things: 1) the actual funcion and 2) a jump-table entry.
> 
> Then, every time the address of a function is taken, 2) is given instead
> of the expected 1), right?

Yes, and we had to bodge around this with function_nocfi() to get the
actual function address.

Really there should be a compiler intrinsic or attribute for this, given
the compiler has all the releveant information available. On arm64 we
had to us inine asm to generate the addres...

Taking a step back, it'd be nicer if we didn't have the jump-table shim
at all, and had some SW landing pad (e.g. a NOP with some magic bytes)
in the callees that the caller could check for. Then function pointers
would remain callable in call cases, and we could explcitly add landing
pads to asm to protect those. I *think* that's what the grsecurity folk
do, but I could be mistaken.

> But how does this work with things like static_call(), which we give a
> function address (now a jump-table entry) and use that to write direct
> call instructions?
> 
> Should not this jump-table thingy get converted to an actual function
> address somewhere around arch_static_call_transform() ? This also seems
> relevant for arm64 (which already has CLANG_CFI supported) given:
> 
>   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org

Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...

Thanks,
Mark.
