Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5EAC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2257E610A4
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbhJ0MZF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237408AbhJ0MZF (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 08:25:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 027F0610A5;
        Wed, 27 Oct 2021 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635337360;
        bh=KrKaQqKbbs7fp0tX/5B2QBFkr3zbaPH6N//I03icq24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ao9WbRSQAymJBRKUQbYazQ5RSOSI2vIb6XrGwWk0hPl4q51jMvh7TQ9cqCasKBzV/
         9xUtimn4Qz30W69d96vo+tln64ib8+OHRfWEadE0ZsUn5x7DEaQqKMpLpGmf3xZdKI
         7GYvEydp4YbyNWCdeJgWG3MNYCY4zRfJeX9NPBEdpBzYmGWHAItssW2FENkz0TnQoh
         cJ4+YSoxsgc7Gwfb2dz84CMXKN+9Zxyr/s9z5z0EDdNaDhheCc8w1Gw4mNAhUaIsk8
         e6F/nhIExzQt/4keODrgRI9kLEOA7GbDNLiXWQdtuMilGbaWhOQ8Qz4NSGWnGSk+9F
         hhoJ4bN0PzA1w==
Received: by mail-ot1-f51.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso3320964otl.4;
        Wed, 27 Oct 2021 05:22:39 -0700 (PDT)
X-Gm-Message-State: AOAM530K7kAYMGoMFLYISekb1QzCVe24E18vvq9B1gf9QkA/5sPy7tBS
        71CY6bcsvBs/ucNeFd4I+2qezT4mXkBqxMxAGB0=
X-Google-Smtp-Source: ABdhPJzVX/seCAE8zMFUTrmcCl1ksiUWfoUg3beE0jMfsnuGwfY2cGApv5OTKHT/FXGbFtKlxXNBzniBhk1jb7R49p4=
X-Received: by 2002:a05:6830:1018:: with SMTP id a24mr25527047otp.112.1635337359227;
 Wed, 27 Oct 2021 05:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net> <20211027120515.GC54628@C02TD0UTHF1T.local>
In-Reply-To: <20211027120515.GC54628@C02TD0UTHF1T.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Oct 2021 14:22:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
Message-ID: <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 27 Oct 2021 at 14:05, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 26, 2021 at 10:16:22PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 13, 2021 at 11:16:43AM -0700, Sami Tolvanen wrote:
> > > This series adds support for Clang's Control-Flow Integrity (CFI)
> > > checking to x86_64. With CFI, the compiler injects a runtime
> > > check before each indirect function call to ensure the target is
> > > a valid function with the correct static type. This restricts
> > > possible call targets and makes it more difficult for an attacker
> > > to exploit bugs that allow the modification of stored function
> > > pointers. For more details, see:
> > >
> > >   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> >
> > So, if I understand this right, the compiler emits, for every function
> > two things: 1) the actual funcion and 2) a jump-table entry.
> >
> > Then, every time the address of a function is taken, 2) is given instead
> > of the expected 1), right?
>
> Yes, and we had to bodge around this with function_nocfi() to get the
> actual function address.
>
> Really there should be a compiler intrinsic or attribute for this, given
> the compiler has all the releveant information available. On arm64 we
> had to us inine asm to generate the addres...
>
> Taking a step back, it'd be nicer if we didn't have the jump-table shim
> at all, and had some SW landing pad (e.g. a NOP with some magic bytes)
> in the callees that the caller could check for. Then function pointers
> would remain callable in call cases, and we could explcitly add landing
> pads to asm to protect those. I *think* that's what the grsecurity folk
> do, but I could be mistaken.
>
> > But how does this work with things like static_call(), which we give a
> > function address (now a jump-table entry) and use that to write direct
> > call instructions?
> >
> > Should not this jump-table thingy get converted to an actual function
> > address somewhere around arch_static_call_transform() ? This also seems
> > relevant for arm64 (which already has CLANG_CFI supported) given:
> >
> >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
>
> Ugh, yeah, we'll need to do the function_nocfi() dance somewhere...
>

Sadly, that only works on symbol names, so we cannot use it to strip
CFI-ness from void *func arguments passed into the static call API,
unfortunately.

Also, function_nocfi() seems broken in the sense that it relies on the
symbol existing in the global namespace, which may not be true for
function symbols with static linkage, as they can be optimized away
entirely. I think the same might apply to function symbols with
external linkage under LTO.
