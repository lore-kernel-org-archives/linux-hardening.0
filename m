Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC2C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7378B61076
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 21:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhKBVWq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKBVWp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 17:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897BC061714;
        Tue,  2 Nov 2021 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FY9GWn+7lMSMdwfBpzLCtCeO76LLNEo5Zfs/hiHZS3I=; b=L3LD/gFmRIFEVOj5isWwE8Er8u
        z6P3bjMjsqvBKUIcVpTg1xWa5Wqp4a/EKjC5io1gGTxQy/owd8giXoi1LQksYqUeYEEZhItXRgCOM
        Ehrg6FSZhvEo/z2QnUuuFEgC5HXCQfO7WgEz6CcF45sgWD4owU0cy16uLM4XEVTmTSEuRDKchaaC4
        9ZZBHtYm5DjkIaX1AOAtLR+v7b9BRkY2VGpylXAhftbtlCU/e3C0aKQBEZoFM4Dptqyy6QHYFaKTC
        5udL3P2LD9/6lERIR/kWn2uyegYEc5J+00unGOgy5UzTdt2dlqwBkgGAuUwPAxOJVgmZ9abBU/kSb
        DGlOojaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mi1C3-00Dozc-JJ; Tue, 02 Nov 2021 21:19:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DB6E984CD2; Tue,  2 Nov 2021 22:19:42 +0100 (CET)
Date:   Tue, 2 Nov 2021 22:19:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
Message-ID: <20211102211942.GY174703@worktop.programming.kicks-ass.net>
References: <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
 <202111021040.6570189A5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111021040.6570189A5@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 02, 2021 at 11:10:10AM -0700, Kees Cook wrote:
> On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:

> > All questions that need answering I think.
> 
> I'm totally fine with designing a new CFI for a future option,
> but blocking the existing (working) one does not best serve our end
> users.

Accepting a half arsed CFI now, just because it is what we have, will
only make it ever so much more difficuly to get new/better
things implemented in the toolchains, because the pressure is off.

Also, it will make enabling IBT more difficult, or we'll end up having
CFI and IBT mutually exclusive, which is a crap position to be in.

> There are already people waiting on x86 CFI because having the
> extra layer of defense is valuable for them. No, it's not perfect,
> but it works right now, and evidence from Android shows that it has
> significant real-world defensive value. Some of the more adventurous
> are actually patching their kernels with the CFI support already, and
> happily running their workloads, etc.

It works by accident, not design. Which is a giant red flag in my book.

> Supporting Clang CFI means we actually have something to evolve
> from,

I don't want to evolve from a place that's crazy and we shouldn't have
been in to begin with. Redefining what a function pointer is is insane,
and the required work-arounds are ugly at best.

The ARM64 folks have expressed regret from having merged it. Why should
x86 do something that's known to cause regret?

> where as starting completely over means (likely significant)
> delays leaving folks without the option available at all.

See above. Maybe some of those folks will get motivated to make it
happen faster.

> I think the various compiler and kernel tweaks needed to improve
> kernel support are reasonable, but building a totally new CFI
> implementation is not: it _does_ work today on x86. 

By sodding accident; see that one static call patch that makes it burn.

If someone were to use the jump-table entry after we'd scribbled it,
thing will go sideways bad.

> Yes, it's weird, but not outrageously so.

Clearly we disagree.

> Regardless, speaking to a new CFI design below:
> 
> > So how insane is something like this, have each function:
> > 
> > foo.cfi:
> > 	endbr64
> > 	xorl $0xdeadbeef, %r10d
> > 	jz foo
> > 	ud2
> > 	nop	# make it 16 bytes
> > foo:
> > 	# actual function text goes here
> > 
> > 
> > And for each hash have two thunks:
> > 
> > 
> > 	# arg: r11
> > 	# clobbers: r10, r11
> > __x86_indirect_cfi_deadbeef:
> > 	movl -9(%r11), %r10		# immediate in foo.cfi
> 
> This requires the text be readable. I have been hoping to avoid this for
> a CFI implementation so we could gain the benefit of execute-only
> memory (available soon on arm64, and possible today on x86 under a
> hypervisor).

It's only needed for the 'legacy' case of software only CFI if that
makes you feel better. BTI/IBT based CFI doesn't need this.

(also, I'm very much a bare metal kinda guy)

> > 	xorl $0xdeadbeef, %r10		# our immediate
> > 	jz 1f
> > 	ud2
> > 1:	ALTERNATIVE_2	"jmp *%r11",
> > 			"jmp __x86_indirect_thunk_r11", X86_FEATURE_RETPOLINE
> > 			"lfence; jmp *%r11", X86_FEATURE_RETPOLINE_AMD
> > 
> > 
> > 
> > 	# arg: r11
> > 	# clobbers: r10, r11
> > __x86_indirect_ibt_deadbeef:
> > 	movl $0xdeadbeef, %r10
> > 	subq $0x10, %r11
> > 	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE
> > 	jmp *%r11
> > 

IBT case ^ doesn't actually read from the code. It simply jumps in front
of the real function by a set amount to get the extra cruft /
landing-pad required for indirect calls.

Also note that direct calls never make use of that pad, which means it
can be stripped from all symbols that never have their address taken,
which means less indirect targets.

(Or poison the thing with UD2 and write 0 in the immediate)

> > And have the actual indirect callsite look like:
> > 
> > 	# r11 - &foo
> > 	ALTERNATIVE_2	"cs call __x86_indirect_thunk_r11",
> > 			"cs call __x86_indirect_cfi_deadbeef", X86_FEATURE_CFI
> > 			"cs call __x86_indirect_ibt_deadbeef", X86_FEATURE_IBT
> > 
> > Although if the compiler were to emit:
> > 
> > 	cs call __x86_indirect_cfi_deadbeef
> > 
> > we could probaly fix it up from there.
> 
> It seems like this could work for any CFI implementation, though, if

The strong suggestion is that function pointers are sane, and there's a
few other considerations, but yes.

> the CFI implementation always performed a call, or if the bounds of the
> inline checking were known? i.e. objtool could also find the inline
> checks just as well as the call, though?

Somewhat hard, it's much easier to find a single instruction than a
pattern. Also, footprint. Smaller really is better.

> > Then we can at runtime decide between:
> > 
> >   {!cfi, cfi, ibt} x {!retpoline, retpoline, retpoline-amd}
> 
> This does look pretty powerful, but I still don't think it precludes
> using the existing Clang CFI. I don't want perfect to be the enemy of
> good. :)

As stated above, we're in violent disagreement that the proposed scheme
comes anywhere near good. I utterly hate the redefintion of function
pointers and I also think the range compare goes sideways in the face of
modules. That's two marks against jump-tables.

(Also, in the !CFI case, you can't actually free the jump-tables, since
you're uncondtionally s(t)uck with them because of how &func is
wrecked.)

