Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0286C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B819D60F4F
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 09:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhKAJJX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Nov 2021 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhKAJJX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Nov 2021 05:09:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FDC061714;
        Mon,  1 Nov 2021 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8e2Zw1HhTX3FErHDM4Hv2jUGCHYSSUs72uIP19ebFBg=; b=O1NgmmcArlP/CVyTZedoMJoN+8
        lyvZ0PYu4u2unqztHfgbNIhvSpCwUbqAat2uSORK3lDJ0WGkUaAbocCsY9aifIktmwU2oWOnvmLIh
        n+dSmIJgXu/iTkWVLfZzbh9DsX7vTij+rue4uY0ftwyLm1hOjWR20yjQxljOIZhWcpS7bYwJRbG2i
        LB/xN10BH5LXBWXBDzGdlL9kYDtTtp7bAUAeyGdwmZgVtJZALa6N9tg1JBk54fGRb2ZCvXeBE3yls
        Xs+OUVYBD7WjSx+CJY1e0Zyw3GUgkpT68YefNSGmgvuIYnl9SQTcTL1VvC/f2jXtC1TEJbZ2Rnw/G
        d7habtoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhTCY-003duA-EH; Mon, 01 Nov 2021 09:02:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A41899822A3; Mon,  1 Nov 2021 10:01:55 +0100 (CET)
Date:   Mon, 1 Nov 2021 10:01:55 +0100
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
Message-ID: <20211101090155.GW174703@worktop.programming.kicks-ass.net>
References: <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net>
 <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 01, 2021 at 12:36:18AM +0100, Ard Biesheuvel wrote:
> On Sun, 31 Oct 2021 at 21:45, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Oct 31, 2021 at 09:21:56PM +0100, Ard Biesheuvel wrote:
> >
> > > That means we can support static calls on arm64 now without breaking
> > > Clang CFI, and work on a solution for the redundant jumps on a more
> > > relaxed schedule.
> >
> > Yes, arm64 has a 'problem' with having already merged the clang-cfi
> > stuff :/
> >
> > I'm hoping the x86 solution can be an alternative CFI scheme, I'm
> > starting to really hate this one. And I'm not at all convinced the
> > proposed scheme is the best possible scheme given the constraints of
> > kernel code. AFAICT it's a compromise made in userspace.
> 
> Your scheme only works with IBT: the value of %r11 is under the
> adversary's control so it could just point it at 'foo+0x10' if it
> wants to call foo indirectly, and circumvent the check. So without IBT
> (or BTI), I think the check fundamentally belongs in the caller, not
> in the callee.

How is that not true for the jump table approach? Like I showed earlier,
it is *trivial* to reconstruct the actual function pointer from a
jump-table entry pointer.

In any case, I really want the discussion to start at square one, and
show/explain why any chosen CFI scheme is actually good for the kernel.
Just because clang happened to have implemented it, doesn't make it the
most suitable scheme for the kernel.
