Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57699C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3865260EBB
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhKBSRY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBSRY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 14:17:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B773C061714;
        Tue,  2 Nov 2021 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=apcnU7ismDMGqhT244nxT/5OUNxzvS18BDxORL1RIIY=; b=UG4CE4sK5Ph3+yQomBR8Ofbygx
        eJa7ofiHw6NzIXdD4e6gpwxgKNuX+K8zMLnbBSwNvYv7Drxs69Pi6IJSGBvTzwoYPDMiYxVLX7q+V
        ZbEitT0HDCnIBbrhgtuIaGeBlVdHCqQZJFPuxwAYfaRBeF9tuHz5eMMds4TJI3C1o0WpSOIizc6+j
        /qrDzfCuj4GBmgzQNxirtD+fCwTIlPTCePR8lz5CCCQSCET4LLLQyraaVhd5LNobwCA2G9ZOKnRiU
        mtJrBT/t4ldrqDZ2JNpRvInKHzqe4pNQygTuOI6FJ3p9n6GXGNdATh98C0jxFwu0/U6n0o0ARB7QG
        TsRm3gzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhyIl-00DnQw-75; Tue, 02 Nov 2021 18:14:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EA0C3000D5;
        Tue,  2 Nov 2021 19:14:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33DF22D53269E; Tue,  2 Nov 2021 19:14:25 +0100 (CET)
Date:   Tue, 2 Nov 2021 19:14:25 +0100
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
Message-ID: <YYGAAVG5aRDKRHso@hirez.programming.kicks-ass.net>
References: <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <YYFWEnBb/UaZKGzz@hirez.programming.kicks-ass.net>
 <CAMj1kXFQSitDY5WT246YEXXFphUv_HSjBrgvGzQGiCr4jLrM+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFQSitDY5WT246YEXXFphUv_HSjBrgvGzQGiCr4jLrM+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 02, 2021 at 06:44:56PM +0100, Ard Biesheuvel wrote:
> On Tue, 2 Nov 2021 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
> >
> > > So how insane is something like this, have each function:
> > >
> > > foo.cfi:
> > >       endbr64
> > >       xorl $0xdeadbeef, %r10d
> > >       jz foo
> > >       ud2
> > >       nop     # make it 16 bytes
> > > foo:
> > >       # actual function text goes here
> > >
> > >
> > > And for each hash have two thunks:
> > >
> > >
> > >       # arg: r11
> > >       # clobbers: r10, r11
> > > __x86_indirect_cfi_deadbeef:
> > >       movl -9(%r11), %r10             # immediate in foo.cfi
> > >       xorl $0xdeadbeef, %r10          # our immediate
> > >       jz 1f
> > >       ud2
> > > 1:    ALTERNATIVE_2   "jmp *%r11",
> > >                       "jmp __x86_indirect_thunk_r11", X86_FEATURE_RETPOLINE
> > >                       "lfence; jmp *%r11", X86_FEATURE_RETPOLINE_AMD
> > >
> 
> So are these supposed to go into the jump tables? If so, there still
> needs to be a check against the boundary of the table at the call
> site, to ensure that we are not calling something that we shouldn't.
> 
> If they are not going into the jump tables, I don't see the point of
> having them, as only happy flow/uncomprised code would bother to use
> them.

I don't understand. If you can scribble your own code, you can
circumvent pretty much any range check anyway. But if you can't scribble
your own code, you get to use the branch here and that checks the
callsite and callee signature.

The range check isn't fundamental to CFI, having a check is the
important thing AFAIU.
