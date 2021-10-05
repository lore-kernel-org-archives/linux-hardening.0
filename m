Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A284C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 21:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116BC6117A
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 21:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhJEVyu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhJEVyt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 17:54:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89AEC06174E
        for <linux-hardening@vger.kernel.org>; Tue,  5 Oct 2021 14:52:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v195so1024695ybb.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQtlBBIPZObKHN+lNZw0C0NHNJrPJ+vWBF05MCFzQCw=;
        b=LUJELitQvR0ASUqZDeLPHd6EeIjewr8j34lumYwl63jydLdUCTobiZfx73mo4tJ8eb
         mMM7oEGL3CE8WmtRSYlVexjdyIrmm3ESWhxlqHqS2OkG5kckTodJmAMMZ4YM55xGrOvq
         xvlUG6pc636UEy0M+LE/LC7vf5kUNRwD9dz9ZC++z0gFcDEvBzZZPb2ZzcPZzszl6ymG
         IQ88kMeH4C8egJSpJWM1QmkExXemTYfEaHIJAnfUX2aHkI9AS0cJWzWSGg/993uSw5MF
         +9h2ERT86NhRWEEMV8lk3QywxYnER0XMmA0RcmwnreHrLjxMg1g3wqtXINrz7q/PknCv
         EAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQtlBBIPZObKHN+lNZw0C0NHNJrPJ+vWBF05MCFzQCw=;
        b=PVqb8aS+2Q0nhl+J//vbXx/DSeJjiCveuvimY0od5zNLLZjR+JFT2EfIHEfYvgM4lX
         wglBpD81ClEYaoIz+yn2PL1b46VTtKeXp7Z7Jwx9B98vY8wFK2cQLdfhOXhB1x70RyHf
         fLy60lpcOmaQkQ1aDWiiFiofRvTXP0ojcsUOXL7zY8wDTz5dyUgS4IgeIHZW8BfKn65A
         16UcIrA4ONx+OMO92gEpowLDvHFCutXXNvm3mFU1TgET3wnva87UkHvdkAZmAn00kyVY
         MFUBFFh01i5E12hh3o1Vqw9endjvwHAeSmlVe0U8tSIeV5+zkoW0iwLU37F5wDHsgjkP
         uXJQ==
X-Gm-Message-State: AOAM531PwnWL3gy9gr/fJPRXU7QQO76TOMynlNisRJFQPykHU6b2IsC6
        NMh/MSK2YVchdiT3B7+LAEUnsm1Q7XQFl7ChJwIBxQ==
X-Google-Smtp-Source: ABdhPJzMRjj95cYHvJHSQH6TN1TXNpYMz+ZYfBKYPepdsrk2UX9VUEOBH8g4LYhNekCjS11LC1W+ncUNyRItfZnI/RA=
X-Received: by 2002:a25:8881:: with SMTP id d1mr25120363ybl.289.1633470777756;
 Tue, 05 Oct 2021 14:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20211005203655.cvjfxmjvgx2knkuk@treble>
In-Reply-To: <20211005203655.cvjfxmjvgx2knkuk@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 5 Oct 2021 14:52:46 -0700
Message-ID: <CABCJKucbbFKHRnisu_yLiHkTfcm9Z+haP0CBNg-pLeO6iFxivg@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] x86: Add support for Clang CFI
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 5, 2021 at 1:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 11:05:16AM -0700, Sami Tolvanen wrote:
> > This series adds support for Clang's Control-Flow Integrity (CFI)
> > checking to x86_64. With CFI, the compiler injects a runtime
> > check before each indirect function call to ensure the target is
> > a valid function with the correct static type. This restricts
> > possible call targets and makes it more difficult for an attacker
> > to exploit bugs that allow the modification of stored function
> > pointers. For more details, see:
> >
> >   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> >
> > Note that v4 is based on tip/master. The first two patches contain
> > objtool support for CFI, the remaining patches change function
> > declarations to use opaque types, fix type mismatch issues that
> > confuse the compiler, and disable CFI where it can't be used.
> >
> > You can also pull this series from
> >
> >   https://github.com/samitolvanen/linux.git x86-cfi-v4
>
> Does this work for indirect calls made from alternatives?

It works in the sense that indirect calls made from alternatives won't
trip CFI. The compiler doesn't instrument inline assembly.

> I'm also wondering whether this works on CONFIG_RETPOLINE systems which
> disable retpolines at runtime, combined with Peter's patch to use
> objtool to replace retpoline thunk calls with indirect branches:
>
>   9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
>
> Since presumably objtool runs after the CFI stuff is inserted.

The indirect call checking is before the retpoline thunk call, so
replacing the call with an indirect call isn't a problem.

Sami
