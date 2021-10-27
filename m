Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70335C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 22:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465D9610CA
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 22:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhJ0Wa2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Wa1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 18:30:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283FFC061570
        for <linux-hardening@vger.kernel.org>; Wed, 27 Oct 2021 15:28:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v20so3017329plo.7
        for <linux-hardening@vger.kernel.org>; Wed, 27 Oct 2021 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jae7JHz3fsHp1np2WTzig06OqkVGhD1se7e/YK5ZIMg=;
        b=M4YCj3mJPGwDGQ4dlWbp4ni9Fgf/V609Qbgn18EPyaS9OQRYcNswWhUsjGvFr0a8rx
         CWu9xHpM8rsTl8idzIzCG/kQqqdwfRIY3f+F1zX7MIx91AmGSosqBI6ta6YI1TACtKIv
         UMq8Fsn1BCDnGd0LwXMpZ7sWuB2iHsHNYQWVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jae7JHz3fsHp1np2WTzig06OqkVGhD1se7e/YK5ZIMg=;
        b=KJNGdAl7+elq7V+97D7fUw843kTzXNbCKWK84Hr/8d1rerGDxPexK+f8dbNByeoDhZ
         Kvb7ySEftLOYJEZwtZUagbt7J1ledPjuqgQNGFjRaKxZ8BlajH+8JjCY90WINkVY+Wve
         y+Na236KvgyfsVb+1ZCqQvpYku2A+ahDEs/NJhrRC6J91clWJxbKetzQ9ndxF1Msho7U
         p/opMHEg0ASNBqjkn1fpAB8Mb/D7z+tNQN8o/yYNmULtyBNl+XJaKSwBz7scU25zv/Pa
         Q3eWaqa0NM5UOjr/GwH9Zx/oThUEZB17LJVzoBJjdpsOCaGiaqomUUeYxWSwm25NvZcu
         dsrg==
X-Gm-Message-State: AOAM533lE3Grx/zdE8mLTEUcUuUFTCqn4hfnZjRzlrouLE+Ry2Fo0XzZ
        JQmey8ItrbOMero3fqZJes6nNg==
X-Google-Smtp-Source: ABdhPJxjdNhgB24uT6ZvfhBd0yRjrsH9/d13XTDrvTSAEYHq8dBa1bDDmgC6szG/BwnCAAPj7PrMYA==
X-Received: by 2002:a17:90b:3141:: with SMTP id ip1mr8680700pjb.234.1635373680579;
        Wed, 27 Oct 2021 15:28:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14sm674321pgt.64.2021.10.27.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:28:00 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:27:59 -0700
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
Message-ID: <202110271430.2A3980217@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
 <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 11:21:26PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 27, 2021 at 10:11:28AM -0700, Kees Cook wrote:
> > On Wed, Oct 27, 2021 at 03:04:55PM +0200, Peter Zijlstra wrote:
> > > [...]
> > > cold_function()
> > > {
> > > 	...
> > > 	global_foo->func1(args1);
> > > 	...
> > > }
> > 
> > If global_foo is non-const, then the static call stuff is just an
> > obfuscated indirect call.
> 
> It is not. The target is determined once, at boot time, depending on the
> hardware, it then never changes. The static_call() results in a direct
> call to that function.

Right, I mean it is _effectively_ an indirect call in the sense that the
call destination is under the control of a writable memory location.
Yes, static_call_update() must be called to make the change, hence why I
didn't wave my arms around when static_call was originally added. It's a
net benefit for the kernel: actual indirect calls now become updatable
direct calls. This means reachability becomes much harder for attackers;
I'm totally a fan. :)

> > If static_call_update() accepts an arbitrary function argument, then it
> > needs to perform the same validation that is currently being injected
> > at indirect call sites to avoid having static calls weaken CFI.
> 
> static_call_update() is a macro and has compile time signature checks,
> the actual function is __static_call_update() and someone can go add
> extra validation in there if they so desire.
> 
> I did have this patch:
> 
>   https://lkml.kernel.org/r/20210904105529.GA5106@worktop.programming.kicks-ass.net
> 
> but I never did get around to finishing it. Although looking at it now,
> I suppose static_call_seal() might be a better name.

Right -- though wouldn't just adding __ro_after_init do the same?

DEFINE_STATIC_CALL(static_call_name, func_a) __ro_after_init;

If you wanted the clean WARN_ON, __static_call_update() could check if
the struct static_call_key is in a non-writable region.

> And you're worried about __static_call_update() over text_poke_bp()
> because?

Both have a meaningful lack of exposure to common attacker-reachable
code paths (e.g., it's likely rare that there are ways attackers can
control the target/content of a text_poke_bp(): alternatives and ftrace,
both of which tend to use read-only content).

static_call_update() is limited per-site with a fixed set of hardcoded
targets (i.e. any place static_call() is used), but the content
is effectively arbitrary (coming from writable memory). AIUI, it's
intended to be used more widely than text_poke_bp(), and it seems like
call sites using static_call_update() will become less rare in future
kernels. (Currently it seems mostly focused on sched and pmu, which
don't traditionally have much userspace control).

So, they're kind of opposite, but for me the question is for examining
the changes to reachability and what kind of primitives their existence
provides an attacker. IMO, static_calls are a net gain over indirect
calls (from some usually writable function pointer) because it becomes
a direct call. It's risk doesn't match a "real" direct call, though,
since they do still have the (much more narrow) risk of having something
call static_call_update() from a writable function pointer as in your
example, but that's still a defensively better position than an regular
indirect call.

What I'm hoping to see from static_calls is maybe defaulting to being
ro_after_init, and explicitly marking those that can't be, which makes
auditing easier and put things into a default-safe state (i.e. both
fixed targets and fixed content).

> > Getting a "jump table to actual function" primitive only avoids the added
> > jump -- all the CFI checking remains bypassed.
> 
> Exactly, so the extra jump serves no purpose and needs to go. Doubly so
> because people are looking at static_call() to undo some of the
> performance damage introduced by CFI :-)

Well, sure, it's inefficient, not _broken_. :) And can you point to the
"use static_calls because CFI is slow" discussion? I'd be curious to read
through that; the past performance testing had shown that CFI performance
overhead tends to be less than the gains of LTO. So compared to a "stock"
kernel, things should be about the same if not faster.

That said, I understand I'm talking to you, and you're paying very close
attention to the scheduler, etc. :) I'm sure there are specific
workloads that look terrible under CFI!

> > If static call function
> > address storage isn't const, for CFI to work as expected the update()
> > routine will need to do the same checking that is done at indirect call
> > sites when extracting the "real" function for writing into a direct call.
> 
> I've mentioned static_call like a hundred times in these CFI threads..
> if you want to do CFI on them, go ahead. I'm just not sure the C type
> system is up for that, you'll have to somehow frob the signature symbol
> into __static_call_update(), something like __builtin_type_symbol().
> 
> > To avoid all of this, though, it'd be better if static calls only
> > switched between one of a per-site const list of possible functions,
> > which would make it a much tighter hand-rolled CFI system itself. :)
> > (i.e. it would operate from a specific and short list of expected
> > functions rather than the "best effort" approach of matching function
> > prototypes as done by Clang CFI.)
> 
> That sounds like a ton of painful ugly.

Right, I know. That's why I'm saying that I see these features as
certainly related, but not at odds with each other. CFI doesn't protect
static_call sites, but static_call sites are already more well protected
than their earlier indirect calls.

The only note I had was that if static_call wants to dig into the jump
table, it likely needs to static_call-specific: we don't want a general
way to do that without knowing we have some reasonable bounds on the
behavior of the code using it. I think it's fine to have static_calls
do this, though it'd be nice if they could be a little more defensive
(generally) at the same time.

-- 
Kees Cook
