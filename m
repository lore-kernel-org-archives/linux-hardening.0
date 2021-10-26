Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E26FC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E392860F9B
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 20:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhJZUWF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhJZUWE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 16:22:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C4C061570;
        Tue, 26 Oct 2021 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xU4JYW+SGd/Y95RQ0MeB5uV9SkZbr+ZK8+zY2SI0BPI=; b=gXHGEsybTuDuZ4f5Zi9d+7JLfV
        iks1F4dTG0BdQG4mJ3OhfCcHhf1H8wtTmpoV4FUjTUGjEKSlG06Yg1atCfre5w2lP3qWsHYvgph9G
        gdjDa4RhbPmPiNjYAng3fEyuA+UL2fxKHjSjho+C4PA7NvFY+UK+vz9l1D8Z0POLeKfHGGlC32ZX2
        aNXTY8qSlMfMr2bP6xL7rbT5yun+AsNKxGwyPEd6u8Bcd5k8SJRf7ZV1GroH5X85rW69fY2GnuQrf
        SgIB9tFhfeHsW2WVE6ptEjR6HhmwxbFRj2+QewRzyTtdMRnXbJ8IxK+YSGjobZqRN+pwwC1ZnsvJf
        NWGXANeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfSrt-00H8Ph-QF; Tue, 26 Oct 2021 20:16:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48E92981FD5; Tue, 26 Oct 2021 22:16:22 +0200 (CEST)
Date:   Tue, 26 Oct 2021 22:16:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ardb@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211026201622.GG174703@worktop.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:43AM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html

So, if I understand this right, the compiler emits, for every function
two things: 1) the actual funcion and 2) a jump-table entry.

Then, every time the address of a function is taken, 2) is given instead
of the expected 1), right?

But how does this work with things like static_call(), which we give a
function address (now a jump-table entry) and use that to write direct
call instructions?

Should not this jump-table thingy get converted to an actual function
address somewhere around arch_static_call_transform() ? This also seems
relevant for arm64 (which already has CLANG_CFI supported) given:

  https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org

Or am I still not understanding this CFI thing?
