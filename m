Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7925C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 12:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BEC60FC2
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 12:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhKBNAw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKBNAv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 09:00:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B56C061714;
        Tue,  2 Nov 2021 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bGKSmCTDpFoLP1JJLQXqMm0zWZVdp9goOESdYBnNV2s=; b=p0lMGiJdFK4mTiRAYVcEK1G2JK
        YEbC6rEB5RywDf91bgqWy4Y83973HIJ+Jz5Xu5rt6nJt0hmaFs1hkgzEWR7apTOgcsMiLUsifBSYb
        tMcUVV8vlvgPp0i4+mgrT/2nQdcaEArOiGjQbLa/k/shnHoY4WkrHaEAxn8134aF/2wlb3kpordKv
        6woGBkyova35sHK+e9dYSkuq8qS9S/3ciikOGSbBIedmtSG6PdCizOB8uY4bL1oQ+SLsoHN/kcVix
        3ogE4BhlwnevwpJU09OALRUhFgN3P59PTVTC/uWaL6+EWlXWa9T6D5EZtBS0Ka7JtSZorJzuNSi20
        MxjTw0zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhtMH-00Dkn7-Vb; Tue, 02 Nov 2021 12:57:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EF783005F4;
        Tue,  2 Nov 2021 13:57:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DB0D2C8D22FD; Tue,  2 Nov 2021 13:57:44 +0100 (CET)
Date:   Tue, 2 Nov 2021 13:57:44 +0100
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
Message-ID: <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
References: <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 01, 2021 at 03:14:41PM +0100, Ard Biesheuvel wrote:
> On Mon, 1 Nov 2021 at 10:05, Peter Zijlstra <peterz@infradead.org> wrote:

> > How is that not true for the jump table approach? Like I showed earlier,
> > it is *trivial* to reconstruct the actual function pointer from a
> > jump-table entry pointer.
> >
> 
> That is not the point. The point is that Clang instruments every
> indirect call that it emits, to check whether the type of the jump
> table entry it is about to call matches the type of the caller. IOW,
> the indirect calls can only branch into jump tables, and all jump
> table entries in a table each branch to the start of some function of
> the same type.
> 
> So the only thing you could achieve by adding or subtracting a
> constant value from the indirect call address is either calling
> another function of the same type (if you are hitting another entry in
> the same table), or failing the CFI type check.

Ah, I see, so the call-site needs to have a branch around the indirect
call instruction.

> Instrumenting the callee only needs something like BTI, and a
> consistent use of the landing pads to ensure that you cannot trivially
> omit the check by landing right after it.

That does bring up another point tho; how are we going to do a kernel
that's optimal for both software CFI and hardware aided CFI?

All questions that need answering I think.


So how insane is something like this, have each function:

foo.cfi:
	endbr64
	xorl $0xdeadbeef, %r10d
	jz foo
	ud2
	nop	# make it 16 bytes
foo:
	# actual function text goes here


And for each hash have two thunks:


	# arg: r11
	# clobbers: r10, r11
__x86_indirect_cfi_deadbeef:
	movl -9(%r11), %r10		# immediate in foo.cfi
	xorl $0xdeadbeef, %r10		# our immediate
	jz 1f
	ud2
1:	ALTERNATIVE_2	"jmp *%r11",
			"jmp __x86_indirect_thunk_r11", X86_FEATURE_RETPOLINE
			"lfence; jmp *%r11", X86_FEATURE_RETPOLINE_AMD



	# arg: r11
	# clobbers: r10, r11
__x86_indirect_ibt_deadbeef:
	movl $0xdeadbeef, %r10
	subq $0x10, %r11
	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE
	jmp *%r11



And have the actual indirect callsite look like:

	# r11 - &foo
	ALTERNATIVE_2	"cs call __x86_indirect_thunk_r11",
			"cs call __x86_indirect_cfi_deadbeef", X86_FEATURE_CFI
			"cs call __x86_indirect_ibt_deadbeef", X86_FEATURE_IBT

Although if the compiler were to emit:

	cs call __x86_indirect_cfi_deadbeef

we could probaly fix it up from there.


Then we can at runtime decide between:

  {!cfi, cfi, ibt} x {!retpoline, retpoline, retpoline-amd}

