Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F587C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64786108F
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Nov 2021 14:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhKAOR2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAOR2 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Nov 2021 10:17:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E288E610E5;
        Mon,  1 Nov 2021 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635776094;
        bh=i69vRlYEfIEqtrl+56kW0o4fiFskwEwT/Wm556pV/oM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KY+EWlyJv/vVXqDNhN/kO3kGeR0AIHeiX0GgJa/ZlHHgoYYGtepeC0na+9ZWluf6P
         terwAgaFzocp1oDEiKvAA9xLMrUHfCBlrl2InIh/Jle8eqd0IF63ZQb3fIQF2phyxJ
         KVTQ3145KyJedZjHA/+GJix4sIiKh+2VYuuc9jL4Fi4738JHF/AKsBjIlsYW40C52e
         L0/jrZvTiBo7tU/vzZlacMjQ93EdJCliG9Hab2Ch/5JZIBangOsx5nAmTFHAKfcXVj
         FKtGApiEzUn3lB3w3aBgAxcaSlxwP82c+9r9LZSbvnnkqRDlI5yJaPRBMtmg5t3cVC
         ibWpldhmUc1qA==
Received: by mail-oi1-f172.google.com with SMTP id q124so25079821oig.3;
        Mon, 01 Nov 2021 07:14:54 -0700 (PDT)
X-Gm-Message-State: AOAM532hIdljLIkUptXxKvtXFRYv04do8cQ2L6EqJ6waSEFcRvopK/MY
        dkSGsvyvWMKqXvmbEcZH/feg7TezRn4hpWWqmAs=
X-Google-Smtp-Source: ABdhPJxLSJB/un808SgMnVnJc+5bVkIQUQ+PSw3wZX+rrDmm+PvlkbTWYeIRvgMkWXBM1JO4yDptbD0iYxlm6iOZZzw=
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr19986405oie.33.1635776094081;
 Mon, 01 Nov 2021 07:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net>
 <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net> <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net> <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
 <20211101090155.GW174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211101090155.GW174703@worktop.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Nov 2021 15:14:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
Message-ID: <CAMj1kXGhRmdM3om289Q2-s1Pzfob3D2iSDMorzggfhSk1oj53A@mail.gmail.com>
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 1 Nov 2021 at 10:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 01, 2021 at 12:36:18AM +0100, Ard Biesheuvel wrote:
> > On Sun, 31 Oct 2021 at 21:45, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sun, Oct 31, 2021 at 09:21:56PM +0100, Ard Biesheuvel wrote:
> > >
> > > > That means we can support static calls on arm64 now without breaking
> > > > Clang CFI, and work on a solution for the redundant jumps on a more
> > > > relaxed schedule.
> > >
> > > Yes, arm64 has a 'problem' with having already merged the clang-cfi
> > > stuff :/
> > >
> > > I'm hoping the x86 solution can be an alternative CFI scheme, I'm
> > > starting to really hate this one. And I'm not at all convinced the
> > > proposed scheme is the best possible scheme given the constraints of
> > > kernel code. AFAICT it's a compromise made in userspace.
> >
> > Your scheme only works with IBT: the value of %r11 is under the
> > adversary's control so it could just point it at 'foo+0x10' if it
> > wants to call foo indirectly, and circumvent the check. So without IBT
> > (or BTI), I think the check fundamentally belongs in the caller, not
> > in the callee.
>
> How is that not true for the jump table approach? Like I showed earlier,
> it is *trivial* to reconstruct the actual function pointer from a
> jump-table entry pointer.
>

That is not the point. The point is that Clang instruments every
indirect call that it emits, to check whether the type of the jump
table entry it is about to call matches the type of the caller. IOW,
the indirect calls can only branch into jump tables, and all jump
table entries in a table each branch to the start of some function of
the same type.

So the only thing you could achieve by adding or subtracting a
constant value from the indirect call address is either calling
another function of the same type (if you are hitting another entry in
the same table), or failing the CFI type check.

Instrumenting the callee only needs something like BTI, and a
consistent use of the landing pads to ensure that you cannot trivially
omit the check by landing right after it.

> In any case, I really want the discussion to start at square one, and
> show/explain why any chosen CFI scheme is actually good for the kernel.
> Just because clang happened to have implemented it, doesn't make it the
> most suitable scheme for the kernel.

Not disagreeing with that for x86, but again, we're already past that for arm64.
