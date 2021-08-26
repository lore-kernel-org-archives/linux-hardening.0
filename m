Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D4C432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 21:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1E960F92
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 21:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhHZVxw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhHZVxw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 17:53:52 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EDAC0613C1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 14:53:04 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k78so5440711ybf.10
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfy9phaIWoHBE3uI65EYNKDvQCtWXxOpvN3CFJWIW2k=;
        b=ZrNg7Bo4CBMBohTQbM9SubeZd7bWhiRy6Fc2BDFZBBilj9wt1pnwxLu3QfhS9Uus6z
         HRIQVo3xCIRB/vLp3Q2hkLcooMG+NPWITRMvK6QWxbsewGBdpRizLiroVQ7PEvtRijDQ
         AsVdkLmsdc+wguQHEJyIWvpUbKtQBsWOSBp/xmCt3Mb9vyZGmTmKkcjzpYU/NDrx9O8X
         JNmCPm31DV78hQBnQznBc4whtATotM3nggctGWYKNPExTpleMK93tbmAQIuSb28P0C3z
         zRDtZUtEi9osEpp8ufPeO4OwooZPRkrxzzGia/AYa/elqKdGnTMNvZTW8lz3QVa4880M
         3hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfy9phaIWoHBE3uI65EYNKDvQCtWXxOpvN3CFJWIW2k=;
        b=nrYpFBwn1m2FJzOBgfp6LLLsnh1TzObVE6TAZ+cxS+ynp9kJR2h3KfPdmTWd3lJNw7
         F2AME4Wc83gjld4M130f9MEy9rL4VOzUakcHESyt3SqQe0pAMHxfeVVoI6dO/s97YKIC
         S/D1sJvMylfhi2VUfWLAeeS6Oyz+C4UX8Uta0CF55Ag8Za95FU5qghjCYX4ceiz8Ot4F
         wR3d8iNxXSzqE1bhM1yGD3nUlXDaPqi7YmQ5ek838pmE9ozNsxYLSRmQJx+mmvdOlJUT
         heMpCqgdCrHkBcey7f77fcO39/+hsgOkjmpliu2nQdUpZeZ4JSH9gJhM2NRojAOyhapI
         w3zQ==
X-Gm-Message-State: AOAM530tPIGvhJL7sdUDTc/Im+e0QTY1rDXyJzJPSCSUEOr508tZrud2
        RlTteDPwkkYaCfkz5lbabaU+e9xZGaK76TDYYwP6Jg==
X-Google-Smtp-Source: ABdhPJzjIyEFfzCtODms1BnP9iEzQ/TVuVIssJ/znZ2sSN8lW42/8jcYYHHVoKcO7KViePIWG8OqCmFIDXVHeC9p7Ts=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr1113798ybb.476.1630014783182;
 Thu, 26 Aug 2021 14:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210824194652.GB17784@worktop.programming.kicks-ass.net>
 <CABCJKud6JBk0QP0aSqM3ptRqbZLfKpfsHNF0RcTq4L-rbc7+uw@mail.gmail.com> <YSd+f9aY3kpdUo4r@hirez.programming.kicks-ass.net>
In-Reply-To: <YSd+f9aY3kpdUo4r@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 26 Aug 2021 14:52:51 -0700
Message-ID: <CABCJKufTnno7nydrf_eKHUgGrEdxxA_JOpRaDMkdYCHdK2F+UA@mail.gmail.com>
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

On Thu, Aug 26, 2021 at 4:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 25, 2021 at 08:49:36AM -0700, Sami Tolvanen wrote:
> > On Tue, Aug 24, 2021 at 12:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Aug 23, 2021 at 10:13:04AM -0700, Sami Tolvanen wrote:
> > > > This series adds support for Clang's Control-Flow Integrity (CFI)
> > > > checking to x86_64. With CFI, the compiler injects a runtime
> > > > check before each indirect function call to ensure the target is
> > > > a valid function with the correct static type. This restricts
> > > > possible call targets and makes it more difficult for an attacker
> > > > to exploit bugs that allow the modification of stored function
> > > > pointers. For more details, see:
> > >
> > > If I understand this right; tp_stub_func() in kernel/tracepoint.c
> > > violates this (as would much of the HAVE_STATIC_CALL=n code, luckily
> > > that is not a valid x86_64 configuration).
> > >
> > > Specifically, we assign &tp_stub_func to tracepoint_func::func, but that
> > > function pointer is only ever indirectly called when cast to the
> > > tracepoint prototype:
> > >
> > >   ((void(*)(void *, proto))(it_func))(__data, args);
> > >
> > > (see DEFINE_TRACE_FN() in linux/tracepoint.h)
> > >
> > > This means the indirect function type and the target function type
> > > mismatch, resulting in that runtime check you added to trigger.
> >
> > Thanks for pointing this out. Yes, that would clearly trip CFI.
> >
> > Any concerns about just writing a magic value to the slot instead of
> > pointing it to a stub function, and checking for it before the call?
>
> Performance :-) that compare is going to be useless roughly 100% of the
> time.

Makes sense. I suppose we could move the call into a macro and do the
comparison only when CFI is enabled to avoid a performance hit with
other configs.

> > > Hitting tp_stub_func() at runtime is exceedingly rare, but possible.
> > >
> > > I realize this is strictly UB per C, but realistically any CDECL ABI
> > > requires that any function with arbitrary signature:
> > >
> > >   void foo(...)
> > >   {
> > >   }
> > >
> > > translates to the exact same code. Specifically on x86-64, the super
> > > impressive:
> > >
> > > foo:
> > >         RET
> > >
> > > And as such this works just fine. Except now you wrecked it.
> >
> > Sure. Another option is to disable CFI for the functions that perform
> > the call, but I would rather avoid that whenever possible.
>
> Is there no means of teaching the compiler about these magical
> functions? There's only two possible stubs:
>
>   void foo(...)
>   {
>   }
>
> and
>
>   unsigned long bar(...)
>   {
>         return 0;
>   }
>
> Both exist in the kernel. We can easily give them a special function
> attribute to call them out.

Clang doesn't have a way to always allow calls to specific functions,
but it might be feasible to implement this in the slowpath handler
without explicit compiler support. I'll see if I can come up with
something reasonable for v3.

Sami
