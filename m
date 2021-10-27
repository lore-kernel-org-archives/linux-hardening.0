Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3FC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 21:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483F360E74
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 21:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhJ0Va2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhJ0VaO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 17:30:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F64C0431A5;
        Wed, 27 Oct 2021 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iWDPQMkv1s1xTppPm1XcYb/RudWJQlLVjq84y0Bf+Rs=; b=acmIOZ/piZRRDsrYUafLGBmR5J
        ORc4R1wNYDJpZUQFbiKh6qUAQM7IAIqs7aewyKgHqRXB2ok8u3QT2jFzlMiFquzTPoZzIc06y8n89
        984rxP1TyzxDrHVQ78uq4JsGBLWjWfgBmhugpVS36SNgRQfUsq8phtfv6H7hl4lBwiYCJJs2+vzKn
        ia2BPoR9bNJ/gqQppTbIgML/EoxazcP3u6b0flt2xK9RNk+gYpFQSJx5qAl153XPp1vwaMBfmBXlU
        HSk+eZyTpLBdQdrcjnmMTOFy7Eqvrpm19eN3xlSNZEnT4CMaHfYSQT3sAQ6CZeaGwd0ExJRagjzLM
        X9jMU8qA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfqMT-00Ccki-Hs; Wed, 27 Oct 2021 21:21:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83D1130031C;
        Wed, 27 Oct 2021 23:21:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 403AB2C90352E; Wed, 27 Oct 2021 23:21:26 +0200 (CEST)
Date:   Wed, 27 Oct 2021 23:21:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <YXnC1jqwR2ZKfMdk@hirez.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <202110270939.F5C79CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110270939.F5C79CC@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 10:11:28AM -0700, Kees Cook wrote:
> On Wed, Oct 27, 2021 at 03:04:55PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 27, 2021 at 02:48:52PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 27, 2021 at 02:22:27PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 27 Oct 2021 at 14:05, Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > > > Should not this jump-table thingy get converted to an actual function
> > > > > > address somewhere around arch_static_call_transform() ? This also seems
> > > > > > relevant for arm64 (which already has CLANG_CFI supported) given:
> > > > > >
> > > > > >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
> > > > >
> > > > > Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...
> > > > >
> > > > 
> > > > Sadly, that only works on symbol names, so we cannot use it to strip
> > > > CFI-ness from void *func arguments passed into the static call API,
> > > > unfortunately.
> > > 
> > > Right, and while mostly static_call_update() is used, whcih is a macro
> > > and could possibly be used to wrap this, we very much rely on
> > > __static_call_update() also working without that wrapper and then we're
> > > up a creek without no paddles.
> > 
> > Specifically, we support code like:
> > 
> > struct foo {
> > 	void (*func1)(args1);
> > 	void (*func2)(args2);
> > }
> > 
> > struct foo global_foo;
> 
> And global_foo is intentionally non-const?

Yep, since depending on the init function it can discover and stuff in
a wild variety of functions.

> > 
> > ...
> > 
> > DEFINE_STATIC_CALL_NULL(func1, *global_foo.func1);
> > 
> > ...
> > 
> > __init foo_init()
> > {
> > 	// whatever code that fills out foo
> > 
> > 	static_call_update(func1, global_foo.func1);
> > }
> > 
> > ...
> > 
> > hot_function()
> > {
> > 	...
> > 	static_cal(func1)(args1);
> > 	...
> > }
> > 
> > cold_function()
> > {
> > 	...
> > 	global_foo->func1(args1);
> > 	...
> > }
> 
> If global_foo is non-const, then the static call stuff is just an
> obfuscated indirect call.

It is not. The target is determined once, at boot time, depending on the
hardware, it then never changes. The static_call() results in a direct
call to that function.

> The attack CFI attempts to block is having
> a controlled write flaw turn into controlled execution. For example,
> in the above, an attacker would use a flaw that could aim a write to
> global_foo->func1, and then get the kernel to take an execution path
> that executes global_foo->func1 (i.e. through cold_function).

I know, and CFI works for cold_function.

> If static_call_update() accepts an arbitrary function argument, then it
> needs to perform the same validation that is currently being injected
> at indirect call sites to avoid having static calls weaken CFI.

static_call_update() is a macro and has compile time signature checks,
the actual function is __static_call_update() and someone can go add
extra validation in there if they so desire.

I did have this patch:

  https://lkml.kernel.org/r/20210904105529.GA5106@worktop.programming.kicks-ass.net

but I never did get around to finishing it. Although looking at it now,
I suppose static_call_seal() might be a better name.

And you're worried about __static_call_update() over text_poke_bp()
because?

> Getting a "jump table to actual function" primitive only avoids the added
> jump -- all the CFI checking remains bypassed.

Exactly, so the extra jump serves no purpose and needs to go. Doubly so
because people are looking at static_call() to undo some of the
performance damage introduced by CFI :-)

> If static call function
> address storage isn't const, for CFI to work as expected the update()
> routine will need to do the same checking that is done at indirect call
> sites when extracting the "real" function for writing into a direct call.

I've mentioned static_call like a hundred times in these CFI threads..
if you want to do CFI on them, go ahead. I'm just not sure the C type
system is up for that, you'll have to somehow frob the signature symbol
into __static_call_update(), something like __builtin_type_symbol().

> To avoid all of this, though, it'd be better if static calls only
> switched between one of a per-site const list of possible functions,
> which would make it a much tighter hand-rolled CFI system itself. :)
> (i.e. it would operate from a specific and short list of expected
> functions rather than the "best effort" approach of matching function
> prototypes as done by Clang CFI.)

That sounds like a ton of painful ugly.

