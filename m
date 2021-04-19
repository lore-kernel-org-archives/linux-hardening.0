Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF93C433B4
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1E061007
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 15:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhDSPOa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhDSPOa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Apr 2021 11:14:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C753C061761
        for <linux-hardening@vger.kernel.org>; Mon, 19 Apr 2021 08:13:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p3so18500777ybk.0
        for <linux-hardening@vger.kernel.org>; Mon, 19 Apr 2021 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36vwzvQKHGNtNCW2ZUnMCMtobdyASLNJa9tZKeMvkEQ=;
        b=czTjya+URdUiMwXGnHagZwTFuPInlRrTc3wRPHOQw5l93EMk3BWr3PTm6Qb2J+tiMc
         58cs6nPNphdDoVxv+Hkgbr21HhD3zEoZa4Xl7Mhd53JshzbevB0YxVeFFpSZHZ2mi7zO
         lER3lLDVLxfBRy9Ee0nGVzowhPXLnhRjRTKtZVjLCniQ5G80oGGtpVbVcp0LE1AVb/gN
         N3c1ewRFeTJh8qI3+8pGgAWjJQfQmh9X7HYlXYfvJ39RjjJrMXwtE0ljmLA5SkctCOfr
         M92Uh3HtEOaywf5vNGwsfIVeVmJQmTDYbKXPDnUaRwhMwUmMhby9KM4eFfaxLGcRowpL
         uFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36vwzvQKHGNtNCW2ZUnMCMtobdyASLNJa9tZKeMvkEQ=;
        b=bLZanufcrqvp/5fwOXSDd8izNYVmeeE5gJ+sAuF3/kwqeqNKXLxpLI16My8CdobTDj
         EBMAUppYkfs16coixvOsKZs3jDi3W35LSnSl+PhS4xtxBMRQ1xE0f3PVR4gboPGP0PUw
         kBcvwAI6O0Swgji7vPMa15vy2SvNAq/VW8REgdS8rIlq22rvhthaB67acJcjWc9+QjW9
         fKixJeNhZmvrto+dBevb/dTI+Nw0GomFnfGFt9gCSR0WRQooY2yKLT0KCUGT6drJ9lkV
         cijUKa867ibHThyOILb2FREK8ME1lRIDbSx87eMsss891YINJ5pNVREJDznAHz4lfeSn
         5V0g==
X-Gm-Message-State: AOAM5306N2dTcHzIE73bjQ2DEnCDW2oTauLzzc7UPGrV+f/YCLTKXi2R
        b7/F+z3Q3duATQAqDL14mlqhgZs0FXcSe3Vg5G31vA==
X-Google-Smtp-Source: ABdhPJxAU6EK+Ci3bFffn6VjCF6gBAVpg/AidJqINewRXOSkH344Bvq6EHCF/rHnRbglHa41rdgJiMpUL1ULY2xRrz8=
X-Received: by 2002:a5b:48c:: with SMTP id n12mr18798826ybp.273.1618845238403;
 Mon, 19 Apr 2021 08:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
 <20210416221414.GF22348@zn.tnic> <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com>
 <202104161529.D9F98DA994@keescook> <87fszpu92e.ffs@nanos.tec.linutronix.de> <875z0ltdv8.ffs@nanos.tec.linutronix.de>
In-Reply-To: <875z0ltdv8.ffs@nanos.tec.linutronix.de>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 19 Apr 2021 08:13:47 -0700
Message-ID: <CABCJKueKDX+6DJnoVns1K35B9htRXRHLdYUckJ25dDhbWUezFw@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Apr 17, 2021 at 3:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Apr 17 2021 at 01:02, Thomas Gleixner wrote:
> > On Fri, Apr 16 2021 at 15:37, Kees Cook wrote:
> >
> >> On Fri, Apr 16, 2021 at 03:20:17PM -0700, Andy Lutomirski wrote:
> >>> But obviously there is code that needs real function pointers.  How
> >>> about making this a first-class feature, or at least hacking around it
> >>> more cleanly.  For example, what does this do:
> >>>
> >>> char entry_whatever[];
> >>> wrmsrl(..., (unsigned long)entry_whatever);
> >>
> >> This is just casting. It'll still resolve to the jump table entry.
> >>
> >>> or, alternatively,
> >>>
> >>> extern void func() __attribute__((nocfi));
> >>
> >> __nocfi says func() should not perform checking of correct jump table
> >> membership for indirect calls.
> >>
> >> But we don't want a global marking for a function to be ignored by CFI;
> >> we don't want functions to escape CFI -- we want specific _users_ to
> >> either not check CFI for indirect calls (__nocfi) or we want specific
> >> passed addresses to avoid going through the jump table
> >> (function_nocfi()).
> >
> > And that's why you mark entire files to be exempt without any rationale
> > why it makes sense.
>
> The reason why you have to do that is because function_nocfi() is not
> provided by the compiler.
>
> So you need to hack around that with that macro which fails to work
> e.g. for the idt data arrays.
>
> Is there any fundamental reason why the compiler does not provide that
> in a form which allows to use it everywhere?

I'm not aware of a fundamental reason why the compiler couldn't
provide a built-in here. This series attempts to work with what's
available at the moment, and admittedly that's not quite ideal on x86.

> It's not too much asked from a tool which provides new functionality to
> provide it in a way which is usable.

Sure, that's reasonable. I'll talk to our compiler folks and see how
we can proceed here.

Sami
