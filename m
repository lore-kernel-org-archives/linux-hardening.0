Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A6C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15ED604AC
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 21:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKBVvU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKBVvT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 17:51:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF7C061714;
        Tue,  2 Nov 2021 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y4e5G7N0rSCI/bB/4KF9vQwtKks3I0Qizmban8wLh88=; b=deg62C+MyuBRwQgACHwdkh+TpH
        rLxXHgp2kCN5sxwJAwtlpaMXRzaIEXFSfax93Azl8g+nUE4eW4As40ibGij99hMe3M+VHiZxLfWoZ
        jQwZB/FHQPaDO1mTBz6jKM435wHVvQrUauh9YmdsLjQOVVhs1j1z39SyLEU1yJbO6dwmi+5UaHl9N
        kkYd+La1bPtsk3Pb9/xEJ+Ud5JLYk+yTmNGSJaxwnNCFwGnVGvla6t74ZbQkukKoQYvfyRmvutpYW
        uZSXv5PaA5Xl0FabbBzC3gA0tGodLB8BPLaHvcy8vufb+wnozGDTg9xTrdvIgLqIZcyusXKDRbIGZ
        XUK5AWIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mi1dj-00DpCo-PG; Tue, 02 Nov 2021 21:48:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68039984CD2; Tue,  2 Nov 2021 22:48:19 +0100 (CET)
Date:   Tue, 2 Nov 2021 22:48:19 +0100
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
        llvm@lists.linux.dev, joao@overdrivepizza.com
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <20211102214819.GZ174703@worktop.programming.kicks-ass.net>
References: <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <YYFWEnBb/UaZKGzz@hirez.programming.kicks-ass.net>
 <CAMj1kXFQSitDY5WT246YEXXFphUv_HSjBrgvGzQGiCr4jLrM+g@mail.gmail.com>
 <YYGAAVG5aRDKRHso@hirez.programming.kicks-ass.net>
 <CAMj1kXHm99QNdHXUUAAJFD+M5VC-xFqjUoEVyg+oGkiJM51daA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHm99QNdHXUUAAJFD+M5VC-xFqjUoEVyg+oGkiJM51daA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 02, 2021 at 07:18:53PM +0100, Ard Biesheuvel wrote:

> > The range check isn't fundamental to CFI, having a check is the
> > important thing AFAIU.
> 
> Agreed. If the call site has a direct branch, it doesn't need the range check.

That, from the earlier email:

 | And have the actual indirect callsite look like:
 |
 |        # r11 - &foo
 |        ALTERNATIVE_2   "cs call __x86_indirect_thunk_r11",
 |                        "cs call __x86_indirect_cfi_deadbeef", X86_FEATURE_CFI
 |                        "cs call __x86_indirect_ibt_deadbeef", X86_FEATURE_IBT

So the callsite has a direct call to the hash-specific and cfi-type
specific thunk, which then does an (indirect) tail-call.

The CFI one does the hash check in the thunk and jumps to the function
proper, the IBT one on does it in the landing-pad.

The !CFI one ignore it all and simply does an indirect call (retpoline
aided or otherwise) to the function proper -- in which case we can free
all the thunks.
