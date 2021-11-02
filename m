Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94285C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705F060EBB
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhKBSMr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBSMr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 14:12:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5FC061203
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 11:10:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t11so19083plq.11
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kgD6YYbeofGJLBI9l1G71OKrQRNv5pZP6nuKYTSL9kc=;
        b=Vt24ScdTjW5lCKq9Nq2BKvZX+xTvcMf8gNvw0urACzABmE/S8n5BEgBg+DviNBjxgI
         LhFHz/tItrvep184fWXpioxVa/8PEJ55IE6j+Ar+B2P9mOp36YN5lm7CJDu2isGY9lRN
         9Zde9MfFGleSGuzEjM50MLDId7fVhGv1ROPjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kgD6YYbeofGJLBI9l1G71OKrQRNv5pZP6nuKYTSL9kc=;
        b=BX6jNuWa2kIQI5E9US0sv+trI3gI1C6X1lBSU4aMu7Lwy9OpHz0JIAnWInCq/KaeHI
         1fSIN3uzboJ3PbfM2JORllzfb8eV6tkoOWVSXDddYtIGT0fZkqpR2yl2WYb1UvwA4OrO
         swxqaE35H8kkr69bkO2tJqYLWBgpHMtcGEuWjBKF8mtKLwIk5s++yfu5+YgNzPwLkRnu
         5l+8YGAfVNcLhvoLCYSzI5cCFwN9ZjHCUixf2okqzrz2+HxErYRZCNy7RBqUj4Q58Z2y
         VDqDrkk8seKLrYz+9bNn47awNCC89EjsoDZq3ZwOqcH/pK7sk0Y7yEAx1tcuqsfFxdac
         uaKQ==
X-Gm-Message-State: AOAM530xEzQRUYoGGF8jKgyyeMOe9dH3DzmW42J+bTQwDwuzt+XBOT5K
        /6PA0KuPVHpon37+YEKZ43HPrQ==
X-Google-Smtp-Source: ABdhPJy98rNUi715EvkItX/2WMuC5P/4ku+DTasoty5eH2XbJLQ+qXpuaPyrbZaTxK+TWKWPDDpS8g==
X-Received: by 2002:a17:903:1c5:b0:141:fbe2:56c1 with SMTP id e5-20020a17090301c500b00141fbe256c1mr9943924plh.52.1635876611992;
        Tue, 02 Nov 2021 11:10:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9sm16184594pga.28.2021.11.02.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 11:10:11 -0700 (PDT)
Date:   Tue, 2 Nov 2021 11:10:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202111021040.6570189A5@keescook>
References: <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net>
 <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
 <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
 <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
 <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYE1yPClPMHvyvIt@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 02, 2021 at 01:57:44PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 01, 2021 at 03:14:41PM +0100, Ard Biesheuvel wrote:
> > On Mon, 1 Nov 2021 at 10:05, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > How is that not true for the jump table approach? Like I showed earlier,
> > > it is *trivial* to reconstruct the actual function pointer from a
> > > jump-table entry pointer.
> > >
> > 
> > That is not the point. The point is that Clang instruments every
> > indirect call that it emits, to check whether the type of the jump
> > table entry it is about to call matches the type of the caller. IOW,
> > the indirect calls can only branch into jump tables, and all jump
> > table entries in a table each branch to the start of some function of
> > the same type.
> > 
> > So the only thing you could achieve by adding or subtracting a
> > constant value from the indirect call address is either calling
> > another function of the same type (if you are hitting another entry in
> > the same table), or failing the CFI type check.
> 
> Ah, I see, so the call-site needs to have a branch around the indirect
> call instruction.
> 
> > Instrumenting the callee only needs something like BTI, and a
> > consistent use of the landing pads to ensure that you cannot trivially
> > omit the check by landing right after it.
> 
> That does bring up another point tho; how are we going to do a kernel
> that's optimal for both software CFI and hardware aided CFI?
> 
> All questions that need answering I think.

I'm totally fine with designing a new CFI for a future option,
but blocking the existing (working) one does not best serve our end
users. There are already people waiting on x86 CFI because having the
extra layer of defense is valuable for them. No, it's not perfect,
but it works right now, and evidence from Android shows that it has
significant real-world defensive value. Some of the more adventurous
are actually patching their kernels with the CFI support already, and
happily running their workloads, etc.

Supporting Clang CFI means we actually have something to evolve
from, where as starting completely over means (likely significant)
delays leaving folks without the option available at all. I think the
various compiler and kernel tweaks needed to improve kernel support
are reasonable, but building a totally new CFI implementation is not:
it _does_ work today on x86. Yes, it's weird, but not outrageously so.
(And just to state the obvious, CFI is an _optional_ CONFIG: not
everyone wants CFI, so it's okay if there are some sharp edges under
some CONFIG combinations.)

Regardless, speaking to a new CFI design below:

> So how insane is something like this, have each function:
> 
> foo.cfi:
> 	endbr64
> 	xorl $0xdeadbeef, %r10d
> 	jz foo
> 	ud2
> 	nop	# make it 16 bytes
> foo:
> 	# actual function text goes here
> 
> 
> And for each hash have two thunks:
> 
> 
> 	# arg: r11
> 	# clobbers: r10, r11
> __x86_indirect_cfi_deadbeef:
> 	movl -9(%r11), %r10		# immediate in foo.cfi

This requires the text be readable. I have been hoping to avoid this for
a CFI implementation so we could gain the benefit of execute-only
memory (available soon on arm64, and possible today on x86 under a
hypervisor).

But, yes, FWIW, this is very similar to what PaX RAP CFI does: the
caller reads "$dest - offset" for a hash, and compares it against the
hard-coded hash at the call site, before "call $dest".

> 	xorl $0xdeadbeef, %r10		# our immediate
> 	jz 1f
> 	ud2
> 1:	ALTERNATIVE_2	"jmp *%r11",
> 			"jmp __x86_indirect_thunk_r11", X86_FEATURE_RETPOLINE
> 			"lfence; jmp *%r11", X86_FEATURE_RETPOLINE_AMD
> 
> 
> 
> 	# arg: r11
> 	# clobbers: r10, r11
> __x86_indirect_ibt_deadbeef:
> 	movl $0xdeadbeef, %r10
> 	subq $0x10, %r11
> 	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE
> 	jmp *%r11
> 
> 
> 
> And have the actual indirect callsite look like:
> 
> 	# r11 - &foo
> 	ALTERNATIVE_2	"cs call __x86_indirect_thunk_r11",
> 			"cs call __x86_indirect_cfi_deadbeef", X86_FEATURE_CFI
> 			"cs call __x86_indirect_ibt_deadbeef", X86_FEATURE_IBT
> 
> Although if the compiler were to emit:
> 
> 	cs call __x86_indirect_cfi_deadbeef
> 
> we could probaly fix it up from there.

It seems like this could work for any CFI implementation, though, if
the CFI implementation always performed a call, or if the bounds of the
inline checking were known? i.e. objtool could also find the inline
checks just as well as the call, though?

> Then we can at runtime decide between:
> 
>   {!cfi, cfi, ibt} x {!retpoline, retpoline, retpoline-amd}

This does look pretty powerful, but I still don't think it precludes
using the existing Clang CFI. I don't want perfect to be the enemy of
good. :)

-- 
Kees Cook
