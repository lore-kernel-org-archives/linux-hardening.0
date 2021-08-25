Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF5C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74C4610A4
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 15:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbhHYPuf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbhHYPue (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 11:50:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A7C061757
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 08:49:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c10so25288180qko.11
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmSiaPcuPj0OC9Van/3kI9pixgS7KKx7iRvuRFfLqzs=;
        b=Peytc/M3TMIW68kU/Omye5ggz9Bylqxo7fyeD68yNutz2S+6ay5EYPu7yQ3JqOPsct
         v6PHrI6gnq21/DRdmRK1EjWGe2EAgpMQDgl0fZVcf2k6MZ3f26Td9rW8hylsGfYla+x3
         RaolUpZ7wE+vDOTZioGMJiqLlp28toWmx51FXkQKFUuIpXe9eJTWO/+V32MNvR8NyTDV
         z0vCxHETT8GlVOrFL9ktJCpnAT0e+yofwCKuBWy8VbK8BnUVegAH+xwYVbERlOeHjV8H
         Tc75arrREfM3h8vYwUt88DhQkgKezV2KMf9+UGBpezev0Zt8HP7Bs0nQSFDzAkqJQyuc
         sgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmSiaPcuPj0OC9Van/3kI9pixgS7KKx7iRvuRFfLqzs=;
        b=mUihzzrrTrm1IkY6p4xvqiUc4bfLBBssh/sk4xflqEbSea/6IHsEEhRgoufCcURvBs
         pa8iUv7iRD8t39qPqQm8NqEMAL9zBMpc0rhl7ymhs433Q8ttKT6bCvipCcmdcm8mDGob
         PcZv5TkduekeVdoLjl1fE2eYvHx0daF2wSKCi8G0FWwtOCnNMJ7Qld9GYzic4ci0IU8J
         ZGbFxSIE8/mh1+7c6lya9QJnJ6E47OedLHFSoqTGOEd4AHnTh7FhrZhM3/fAfTHrnZh0
         RrxQWS5KgZmypfSaeihc4mQXj4qmFZhqij1xFo1HLuimqeZzc+ll/L49Sti6HxL/LKLM
         3l8g==
X-Gm-Message-State: AOAM533wakUOgPxM1ZBJVif7QL8TgPmzBXlkTWY9lL6QGiYdSiOAhfg9
        Omd8kvWtVEHkGLQYuECotI3O6Q6Tr8ZTDd1TqCCSvg==
X-Google-Smtp-Source: ABdhPJwQVu63W9aHw3TO7zXAD18CuId8RDe6E2d9TXvBk4mp4GXO5wUOiyUvqupxM+yu3qibM810UjpEIpNOFtEEvdA=
X-Received: by 2002:a25:1c06:: with SMTP id c6mr10632452ybc.498.1629906587436;
 Wed, 25 Aug 2021 08:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com> <20210824194652.GB17784@worktop.programming.kicks-ass.net>
In-Reply-To: <20210824194652.GB17784@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 25 Aug 2021 08:49:36 -0700
Message-ID: <CABCJKud6JBk0QP0aSqM3ptRqbZLfKpfsHNF0RcTq4L-rbc7+uw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 24, 2021 at 12:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 23, 2021 at 10:13:04AM -0700, Sami Tolvanen wrote:
> > This series adds support for Clang's Control-Flow Integrity (CFI)
> > checking to x86_64. With CFI, the compiler injects a runtime
> > check before each indirect function call to ensure the target is
> > a valid function with the correct static type. This restricts
> > possible call targets and makes it more difficult for an attacker
> > to exploit bugs that allow the modification of stored function
> > pointers. For more details, see:
>
> If I understand this right; tp_stub_func() in kernel/tracepoint.c
> violates this (as would much of the HAVE_STATIC_CALL=n code, luckily
> that is not a valid x86_64 configuration).
>
> Specifically, we assign &tp_stub_func to tracepoint_func::func, but that
> function pointer is only ever indirectly called when cast to the
> tracepoint prototype:
>
>   ((void(*)(void *, proto))(it_func))(__data, args);
>
> (see DEFINE_TRACE_FN() in linux/tracepoint.h)
>
> This means the indirect function type and the target function type
> mismatch, resulting in that runtime check you added to trigger.

Thanks for pointing this out. Yes, that would clearly trip CFI.

Any concerns about just writing a magic value to the slot instead of
pointing it to a stub function, and checking for it before the call?

> Hitting tp_stub_func() at runtime is exceedingly rare, but possible.
>
> I realize this is strictly UB per C, but realistically any CDECL ABI
> requires that any function with arbitrary signature:
>
>   void foo(...)
>   {
>   }
>
> translates to the exact same code. Specifically on x86-64, the super
> impressive:
>
> foo:
>         RET
>
> And as such this works just fine. Except now you wrecked it.

Sure. Another option is to disable CFI for the functions that perform
the call, but I would rather avoid that whenever possible.

Sami
