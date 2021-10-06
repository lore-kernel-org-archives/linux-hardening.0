Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB9C433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03029610A1
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 13:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhJFNEo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhJFNEn (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 09:04:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF71E61039;
        Wed,  6 Oct 2021 13:02:50 +0000 (UTC)
Date:   Wed, 6 Oct 2021 09:02:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006090249.248c65b0@gandalf.local.home>
In-Reply-To: <20211006032945.axlqh3vehgar6adr@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
        <20210930180531.1190642-7-samitolvanen@google.com>
        <20211006032945.axlqh3vehgar6adr@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 5 Oct 2021 20:29:45 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

Thanks for Cc'ing me, as I should have been Cc'd on the original patch.

> On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.

"not called from C" is a bit confusing.

> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  include/linux/ftrace.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 832e65f06754..67de28464aeb 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
> >  extern int ftrace_update_ftrace_func(ftrace_func_t func);
> >  extern void ftrace_caller(void);
> >  extern void ftrace_regs_caller(void);
> > -extern void ftrace_call(void);
> > -extern void ftrace_regs_call(void);
> > -extern void mcount_call(void);
> > +
> > +DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
> > +DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
> > +DECLARE_ASM_FUNC_SYMBOL(mcount_call);  
> 
> I'm thinking DECLARE_ASM_FUNC_SYMBOL needs a better name. It's not clear
> from reading it why some asm symbols need the macro and others don't.
> 
> I guess it means "an asm text symbol which isn't callable from C code
> (not including alternatives)"?
> 
> DECLARE_UNCALLED_SYMBOL() maybe?
> 

That's even worse ;-) Because "called" is an assembler command in x86, and
it is "called" from assembly (when you look at an objdump, it is most
definitely "called").

Perhaps DECLARE_ASM_INTERNAL_SYMBOL() ?

Or call it "DECLARE_ASM_MCOUNT_SYMBOL()" as "mcount" is the original name
of what a compiler does when passed the -pg option, and that's exactly what
those functions are.

-- Steve


