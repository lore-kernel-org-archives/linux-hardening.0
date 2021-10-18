Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A11AC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B1F610C8
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRRK7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbhJRRK6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 13:10:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D33C061745
        for <linux-hardening@vger.kernel.org>; Mon, 18 Oct 2021 10:08:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u32so6947722ybd.9
        for <linux-hardening@vger.kernel.org>; Mon, 18 Oct 2021 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3j7UqVjgTnmYPUxSgIR20gTOiacgwPLmKSZwLzYul8=;
        b=T5Pw+RiwBW0N+FA93+IrhIMG1kPW4MVVbfdu2jTP/u7c+g4dPXF8PfXCK9G6YMVjlg
         4WBEK7CbMJ2YpifOHQOiqexaMfkQqx0wrbMIwnP/zKXXJM3xygIpqyxUIbkOB7O8gYry
         Wghn2Lr/eW6HV2j1+W3nbouocFWV3SSefJYqOREZysmOknCOqwNOH7fubwK8+vbkK78n
         OAKy9rYiqfbz9X4BNQdjPKY+Y1J8q9a8fniKahUfSLNiZD+AGSOkz707Sml9IzDsonZM
         aHJcBfPFDQhe3miOudj9n1EAkgIs6nUDqTR2rOzUeQd4UZ/WJqEuHMIDWnhTm61VnoTb
         xyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3j7UqVjgTnmYPUxSgIR20gTOiacgwPLmKSZwLzYul8=;
        b=wU4i8wIOJSg0oOMltqKOufzvpz6bOjOKUnt23VBW6fLqdMAUSQ7ntoML1FQdOhtBwz
         +nOu8Pt1kRDcHFvKbY7NO0gfD/lacwXDXcz+pw853rPo8qZOdZGS+bvicIXerevp2ZuF
         dxBHHXJHkUl0R+Wvp07dDeSVVzZofj7HO3GdBz6xphvcd9ufaQkRJ91jMNMrUWr3lGxI
         eTd3GZqGAGE7w/YB0pT/DSzh+Zlckwse50m4hWGuCa9uSBvvWGb+EZM/5/pcN37BIPaT
         IFEAztG4wEfwm3nzZPs67GYIOGEZEr++7zDojN9jPZ3lfziAnKTSpBNgqyxEK89udcdT
         aDRw==
X-Gm-Message-State: AOAM531n6lds6JpRYjAXsYNtihJwzfVdU7YdfKbuLWISgN1V4DL2Pt0F
        mynxtdsQEzzibAR2SBUgdfOBVMFRx+XivPJcttgrcA==
X-Google-Smtp-Source: ABdhPJychZS1c4zhuCsT0UtT+C4l6qM+ZY4CmBXeM4lYI/sMnDtuR1ghwld8PShjuKs6rpu3+7PA3C4qIiDjV1EUidw=
X-Received: by 2002:a25:6908:: with SMTP id e8mr30172247ybc.289.1634576925983;
 Mon, 18 Oct 2021 10:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com> <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx> <87zgra41dh.ffs@tglx> <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
 <ecbe49c8-b30b-456c-931a-cc65647b0958@www.fastmail.com> <CABCJKucuun-n8w3=U6i43kVGkCgYL7kmz5wx8nYxsxUOCfzBFw@mail.gmail.com>
 <20211016211200.umf7okyvtet5ayrd@treble>
In-Reply-To: <20211016211200.umf7okyvtet5ayrd@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 18 Oct 2021 10:08:34 -0700
Message-ID: <CABCJKucVy3eKJbq8cnKZJDE-5L3xmo=S=1GUQVW+-QF3Hg=iWQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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

On Sat, Oct 16, 2021 at 2:12 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Oct 15, 2021 at 01:37:02PM -0700, Sami Tolvanen wrote:
> > > But we *also* have the read-the-address thing:
> > >
> > > void something(void)
> > > {
> > >   /* actual C body */
> > > }
> > > alternative_call(something, someotherthing, ...);
> > >
> > > That wants to expand to assembly code that does:
> > >
> > > CALL [target]
> > >
> > > where [target] is the actual first instruction of real code and not
> > > a CFI prologue.
> >
> > Yes, here we would ideally want to avoid the CFI stub for better
> > performance, but nothing actually breaks even if we don't.
>
> That's because there's no CFI involved in alternative_call().  It
> doesn't use function pointers.  It uses direct calls.

Ah, you're right. alternative_call() uses the function name instead of
the address, so it's not actually affected by CFI.

> > > I kind of thing we want the attributes and the builtin, along the lines of:
> > >
> > > asm("call %m", function_nocfi_address(something));
> > >
> > > or however else we wire it up.
> > >
> > > (And, of course, the things that aren't C functions at all, like
> > > exception entries, should be opaque.)
> >
> > I agree, there are cases where having a function attribute and/or a
> > built-in to stop the compiler from interfering would be useful. I'll
> > dust off my patch series and see how the LLVM folks feel about it.
>
> With all the talk about function attributes I still haven't heard a
> clear and specific case where one is needed.
>
> If you take out the things that don't actually need the
> DEFINE_NOT_CALLED_FROM_C() annotation then all you have left is the need
> for opaque structs as far as I can tell.

Correct.

Sami
