Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9898EC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E8B6109F
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 17:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbhJ0RN4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbhJ0RNz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 13:13:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C86C061570
        for <linux-hardening@vger.kernel.org>; Wed, 27 Oct 2021 10:11:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso5278558pjf.3
        for <linux-hardening@vger.kernel.org>; Wed, 27 Oct 2021 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SPqzlmEweI7r1mGXnYdr5XuSqmGXW0SkyZAuxP8LyMQ=;
        b=TxzOqOdAm06wISQQDG9AUQtMp6CPyx+4EqB3sWwvACs6OPGjSg0kvIFotrs3f5Hr/g
         36y0FvkG5ulwsPM+LeYfBGcFyNbRXJWvHyVi0cqnMkMIdWKizVF1QhDWJMEjCdnBnbJu
         Qbar4HPvzJ08E92cM3uqXKFxfn33qSa2sqNMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPqzlmEweI7r1mGXnYdr5XuSqmGXW0SkyZAuxP8LyMQ=;
        b=ywvTpgpXSs6Tt9OCvnRVSAqXaFVxHZg9JDF1mPex4tbNE1izrGBdVJYoDqf1Fof7C9
         FjP/6Renp33vgaD7+quNC8kHlkk9EpcGyGKX9l8c2Q7C+jkRMwyBJZZh+birHi34sLai
         vCEgRH1U/1jpct60RtVRH2f8mxDqplfBLHlGrE6/T8oEh3Aikxa05LzV13j/erQwAKYl
         Y1J4N/4KLhW3yykIcQUrlhS1drQJhSBoE7l8AWvTHtcAZb7yOqhtE7H7c2FD8dnyrI2u
         wEN62U+uEznugF033LzpvRlqSx46OisDLkx6GKBch0CDxPEof4a4uapcrhg9Pk+y6f/E
         Ymfg==
X-Gm-Message-State: AOAM533dYnymrSWMwh1q4Q+eihVzgoxKJJOkdtCOADdbLFy2bHf7zYkG
        +X1ot+1nAdZHggkxjknWAp0qMw==
X-Google-Smtp-Source: ABdhPJwgWDIYDf0NpCmMyVHgq1qs37SgEq9KpumyZm5ASVCwSt/ixYZxeJ6+qsDmxHYqkOsI+ohUzg==
X-Received: by 2002:a17:90b:17d2:: with SMTP id me18mr6983821pjb.98.1635354689817;
        Wed, 27 Oct 2021 10:11:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb5sm315185pjb.11.2021.10.27.10.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:11:29 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:11:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <202110270939.F5C79CC@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 03:04:55PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 27, 2021 at 02:48:52PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 27, 2021 at 02:22:27PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 27 Oct 2021 at 14:05, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > > > Should not this jump-table thingy get converted to an actual function
> > > > > address somewhere around arch_static_call_transform() ? This also seems
> > > > > relevant for arm64 (which already has CLANG_CFI supported) given:
> > > > >
> > > > >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
> > > >
> > > > Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...
> > > >
> > > 
> > > Sadly, that only works on symbol names, so we cannot use it to strip
> > > CFI-ness from void *func arguments passed into the static call API,
> > > unfortunately.
> > 
> > Right, and while mostly static_call_update() is used, whcih is a macro
> > and could possibly be used to wrap this, we very much rely on
> > __static_call_update() also working without that wrapper and then we're
> > up a creek without no paddles.
> 
> Specifically, we support code like:
> 
> struct foo {
> 	void (*func1)(args1);
> 	void (*func2)(args2);
> }
> 
> struct foo global_foo;

And global_foo is intentionally non-const?

> 
> ...
> 
> DEFINE_STATIC_CALL_NULL(func1, *global_foo.func1);
> 
> ...
> 
> __init foo_init()
> {
> 	// whatever code that fills out foo
> 
> 	static_call_update(func1, global_foo.func1);
> }
> 
> ...
> 
> hot_function()
> {
> 	...
> 	static_cal(func1)(args1);
> 	...
> }
> 
> cold_function()
> {
> 	...
> 	global_foo->func1(args1);
> 	...
> }

If global_foo is non-const, then the static call stuff is just an
obfuscated indirect call. The attack CFI attempts to block is having
a controlled write flaw turn into controlled execution. For example,
in the above, an attacker would use a flaw that could aim a write to
global_foo->func1, and then get the kernel to take an execution path
that executes global_foo->func1 (i.e. through cold_function).

If static_call_update() accepts an arbitrary function argument, then it
needs to perform the same validation that is currently being injected
at indirect call sites to avoid having static calls weaken CFI. If
things are left alone, static calls will just insert a direct call to
the jump table, and things "work" (with an extra jump), but nothing
is actually protected (it just requires the attacker locate a more
narrow set of kernel call flows that includes static_call_update). Any
attacker write to global_foo->func1, followed by a static_call_update(),
will create a direct call (with no CFI checking) to the attacker's
destination. (It's likely harder to find the needed execution path to
induce a static_call_update(), but that shouldn't stop us from trying
to protect it.)

Getting a "jump table to actual function" primitive only avoids the added
jump -- all the CFI checking remains bypassed. If static call function
address storage isn't const, for CFI to work as expected the update()
routine will need to do the same checking that is done at indirect call
sites when extracting the "real" function for writing into a direct call.
(i.e. it will need to be function prototype aware, be able to find the
real matching jump table and size, and verify the given function is
actually in the table. Just dereferencing the jump table to find the
address isn't a protection: the attacker just has to write to func1 with
a pointer to an attacker-constructed jump table.)

I think it's not unreasonable to solve this in phases, though. Given that
static calls work with CFI as-is (albeit with an extra jump), and that
static calls do offer some hardening of existing indirect call targets (by
narrowing the execution path needed to actually bring the func1 value into
the kernel execution flow), I don't see either feature blocking the other.

Adding proper CFI function prototype checking to static calls seems
like a security improvement with or without CFI, and a minor performance
improvement under CFI.

To avoid all of this, though, it'd be better if static calls only
switched between one of a per-site const list of possible functions,
which would make it a much tighter hand-rolled CFI system itself. :)
(i.e. it would operate from a specific and short list of expected
functions rather than the "best effort" approach of matching function
prototypes as done by Clang CFI.)

-- 
Kees Cook
