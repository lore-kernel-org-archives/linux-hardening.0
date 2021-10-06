Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF6AC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AF461165
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 13:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhJFN4Y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhJFN4P (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 09:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633528463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SUoxOb//3TH/xMoqrFKXCtQoVmxHUsUFva7/RQKSUug=;
        b=Y0VUEWuepPfF1M0yHhwJqOf5lUsihZ0tMPj4+yXLq7B0lLPJXsf+UlwlGc3R8dh/w1qTf7
        RDYDxCrSdQAO1uO5suvCgNOHxfAaQj9Onk+/4yFlBq8ZgRBNJXRCKSQ8Bqq91uiKl6IWTm
        ofnwfRGONGqUq/0wFDRtz1G7b6SFOn0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Q8dJmrRXOba0WljNabxG3g-1; Wed, 06 Oct 2021 09:54:21 -0400
X-MC-Unique: Q8dJmrRXOba0WljNabxG3g-1
Received: by mail-oo1-f70.google.com with SMTP id x24-20020a4a6218000000b002b68776919cso1722420ooc.19
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUoxOb//3TH/xMoqrFKXCtQoVmxHUsUFva7/RQKSUug=;
        b=uGaFrEeuKBGPSJEHOAXJC6qgP5wfmAiAdgv1v7BJRKDctl5l5Ojt+2vCW5gb8TbLtE
         0eMcyO7BGRy1wH28S8CXOq2pQaRBJSkD/z9x3AWKjeugemdaixB5hJ9rX6zIZsFU8a5k
         XzMuPF4Q6t4DM8wH6PVEM5kNfChJai5dW2U0Hsrjt+Npvkrpwf+T35JjEZnQ4ovRw9/j
         kT2TWV9rHxFIk1uK3YXsoNy5qe+3NMhHXHdJx7hMg9Y+b5IR2EdYTlSrNmbeQS9+Sv8b
         heE62342t/b/IysHlyWjPbWFKWxQqNU3x9+NZEJhQRswj0Hw7pAUF/a6P5t6t3Vy7rzW
         ZQyg==
X-Gm-Message-State: AOAM530mlBRD7dKyEAQ4+jDiGMt15x4VY5Va8YkmPuFCP0LLHJSF8wxP
        JbYPQaaziS/p5HyRWpXxdW4aRn6dvdRJdA1ta0a9FHpyXTBqCDc7BbDEUTaOTmE/6SEcKd51h4F
        hX3/5EycqBLILGQOMf5oxC9uQupeo
X-Received: by 2002:a54:4f0e:: with SMTP id e14mr7500174oiy.73.1633528461112;
        Wed, 06 Oct 2021 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDO4di3VOt+xJP1xAbbGCbGjPY6Am+ulVkpZnWgsgHk16Sl/FM4xHh8vjh8enqfYZsYV6nfQ==
X-Received: by 2002:a54:4f0e:: with SMTP id e14mr7500157oiy.73.1633528460868;
        Wed, 06 Oct 2021 06:54:20 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id l8sm3980645oii.57.2021.10.06.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:54:20 -0700 (PDT)
Date:   Wed, 6 Oct 2021 06:54:17 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20211006135417.tvdns3ykpgupi47q@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com>
 <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20211006090249.248c65b0@gandalf.local.home>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 06, 2021 at 09:02:49AM -0400, Steven Rostedt wrote:
> On Tue, 5 Oct 2021 20:29:45 -0700
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> Thanks for Cc'ing me, as I should have been Cc'd on the original patch.
> 
> > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> 
> "not called from C" is a bit confusing.
> 
> > > 
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > ---
> > >  include/linux/ftrace.h | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 832e65f06754..67de28464aeb 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
> > >  extern int ftrace_update_ftrace_func(ftrace_func_t func);
> > >  extern void ftrace_caller(void);
> > >  extern void ftrace_regs_caller(void);
> > > -extern void ftrace_call(void);
> > > -extern void ftrace_regs_call(void);
> > > -extern void mcount_call(void);
> > > +
> > > +DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
> > > +DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
> > > +DECLARE_ASM_FUNC_SYMBOL(mcount_call);  
> > 
> > I'm thinking DECLARE_ASM_FUNC_SYMBOL needs a better name. It's not clear
> > from reading it why some asm symbols need the macro and others don't.
> > 
> > I guess it means "an asm text symbol which isn't callable from C code
> > (not including alternatives)"?
> > 
> > DECLARE_UNCALLED_SYMBOL() maybe?
> > 
> 
> That's even worse ;-) Because "called" is an assembler command in x86, and
> it is "called" from assembly (when you look at an objdump, it is most
> definitely "called").
> 
> Perhaps DECLARE_ASM_INTERNAL_SYMBOL() ?
> 
> Or call it "DECLARE_ASM_MCOUNT_SYMBOL()" as "mcount" is the original name
> of what a compiler does when passed the -pg option, and that's exactly what
> those functions are.

But this macro is used in other places as well:

  https://lkml.kernel.org/r/20210930180531.1190642-10-samitolvanen@google.com

And many of them aren't internal to a function like the above symbols,
they're actual functions that are called in other ways.

DECLARE_UNCALLED_FROM_C() ?

-- 
Josh

