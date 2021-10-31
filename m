Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F95C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3499D60F58
	for <linux-hardening@archiver.kernel.org>; Sun, 31 Oct 2021 23:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJaXjD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 31 Oct 2021 19:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhJaXjD (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 31 Oct 2021 19:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9534360F58;
        Sun, 31 Oct 2021 23:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635723390;
        bh=g0TKIn1SOhrkVD8q2CMYalRegdqbG3lBrJQqv31LIkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fzUgvHNWX0djoMW5fRqQMgZtWXqn42cvF3D45sF2MG+afqYNmEyihOqMFDRsldVw/
         GO7FaopjSWMqSpx0fLsjNGyzOXiAmnZ3gaZe0gnkyMxVYzRngQ6h6gYnBpx+B5KsPf
         T055rJTxO8q3kTE4BjZ3Si7to6UKU8pdmJ8wgJHEhTHRHoo063wjWm+RW1P+xq2d7Q
         FDuM79Uv2rX+XptPAiav2tvNlPcI4640ug/BvDDzkXHRTmRB/kZE6Tyw8ByEBCDHzA
         Dfe+/0cooB3nwiaX35baoMJ2KPLqENuDCdSqpDX6iExXWrDKQkmuw31g60PDTU5Eq8
         mqmD6d6x0p/Dw==
Received: by mail-ot1-f42.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so17064465otj.11;
        Sun, 31 Oct 2021 16:36:30 -0700 (PDT)
X-Gm-Message-State: AOAM532Aw+B45EABdBRYY9tlq99cubbmLR75TgmckzytYbkYceO4z8qf
        Pha1ospTsC0HCxrp7cF/Q0ujyE1j0FS3kQprBY8=
X-Google-Smtp-Source: ABdhPJxGnHoazV1OCaq9GHBZpXQkOPgaDA13tUdZb5rhSKeMAD8IAPYGPWgkGNJoRtkSh8skEujKT9dldjMFiIzPp/c=
X-Received: by 2002:a9d:6e8:: with SMTP id 95mr12669686otx.112.1635723389889;
 Sun, 31 Oct 2021 16:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <CAMj1kXEJd5=3A_6Jhd4UU-TBGarnHo5+U76Zxxt7SzXsWp4CcA@mail.gmail.com>
 <20211030180249.GU174703@worktop.programming.kicks-ass.net>
 <CAMj1kXF4ZNAvdC8tP_H=v1Dn_Zcv=La11Ok43ceQOyb1Xo1jXQ@mail.gmail.com>
 <CAMj1kXEvemVOWf4M_0vsduN_kiCsGVmM92cE7KPMoNKViKp=RQ@mail.gmail.com>
 <20211031163920.GV174703@worktop.programming.kicks-ass.net>
 <CAMj1kXHk5vbrT49yRCivX3phrEkN6Xbb+g8WEmavL_d1iE0OxQ@mail.gmail.com>
 <YX74Ch9/DtvYxzh/@hirez.programming.kicks-ass.net> <CAMj1kXG+MuGaG3BHk8pnE1MKVmRf5E+nRNoFMHxOA1y84eGikg@mail.gmail.com>
 <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
In-Reply-To: <YX8AQJqyB+H3PF1d@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Nov 2021 00:36:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
Message-ID: <CAMj1kXF3n-oQ1WP8=asb60K6UjSYOtz5RVhrcoCoNq3v7mZdQg@mail.gmail.com>
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

On Sun, 31 Oct 2021 at 21:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Oct 31, 2021 at 09:21:56PM +0100, Ard Biesheuvel wrote:
>
> > That means we can support static calls on arm64 now without breaking
> > Clang CFI, and work on a solution for the redundant jumps on a more
> > relaxed schedule.
>
> Yes, arm64 has a 'problem' with having already merged the clang-cfi
> stuff :/
>
> I'm hoping the x86 solution can be an alternative CFI scheme, I'm
> starting to really hate this one. And I'm not at all convinced the
> proposed scheme is the best possible scheme given the constraints of
> kernel code. AFAICT it's a compromise made in userspace.

Your scheme only works with IBT: the value of %r11 is under the
adversary's control so it could just point it at 'foo+0x10' if it
wants to call foo indirectly, and circumvent the check. So without IBT
(or BTI), I think the check fundamentally belongs in the caller, not
in the callee.
