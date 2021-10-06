Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 23:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B217D610CE
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 23:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhJFXQX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 19:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhJFXQW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 19:16:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B70C061746
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 16:14:29 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i84so9015376ybc.12
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lULMGd5GZW1y8ndmaEvAhKZ0JUKBUzKO4h28P5jqIJs=;
        b=qO9dik5FfbA0dX2gNzLU+kw9CbaiNDSII55EN/1wxycoUK/480TZFUVnwl3abuua3U
         QFO7GQE2jXUdcipFtc0kFZF5+dH46i3YBGkmBXFa8EZEryjMZ3NIasnPQx3m5WyF76WX
         QLfuDBU8WsN5EWfq4RZs+n1Vz25wU2kvLYcDCV1FCJNx7T3HLDY2OIoOtTmvRwVx6/Xd
         T7iWXv9piqUPNLhyaTtDq8DU1ve9XVF2N40M6QZWYxIpKKpgdjSoCxHgG899a2+1RHms
         Tety22sCDPNC4lnk2KwS61fuxZfC1W2Or9k1AWkfIpU9DPLI/JeZMA/HDfx2krJgTdfe
         dd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lULMGd5GZW1y8ndmaEvAhKZ0JUKBUzKO4h28P5jqIJs=;
        b=ze0l8o9vPgKMAFvE0D1qnTEJxYaXal69v34JdxTMAT5kxVgGXilwMhskzzhANwK397
         /WMW02bjeU56B2gcM0pscN8bdtkZzzGfiImrASx9zPEWa30UYiGXnzIBbxJ+HOD2tjnR
         GscsaL5i4kZjoVDfg470pRSZTdGO11acEa4m058gLwZsxTzbrpXt7GbwTrdfTEi4IHR4
         J6eMTYsfc6iLlsOjNIVBxNJ8zz53IaPoU8Y30ZG4lUFp+QJzLSDiwZu/4cXyJUub+Ny+
         YubCdnJ23iPVPDt4BBWWuk3D5PXGbs05ovzoH+GYPTohctzzFcCLtILOiHFZOnTD6iXV
         gy+g==
X-Gm-Message-State: AOAM533ZT5EVF0pfGvJTnB0pGWW/EB6GXueyWCy0uvy+QwQQ0zdmGI+G
        FrHjcA/xs+EgbG5GdkMIkUekQNo6xOjsCPw/z3MW2Q==
X-Google-Smtp-Source: ABdhPJz6dus+mwN033rB5yGF/Z1PlDqJbDyipNTdsGY0Nzy8NGkrS8nLbhrVxXZuAvMIaajFhypqm8P9bVngwYXedbs=
X-Received: by 2002:a25:8881:: with SMTP id d1mr1016177ybl.289.1633562068292;
 Wed, 06 Oct 2021 16:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com> <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home> <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
 <20211006125809.5389b2a3@gandalf.local.home> <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
 <20211006204335.xtymxt6wk4akx6fc@treble> <20211006171016.07d90b59@gandalf.local.home>
 <20211006212355.mfuyci3pnsdlbp3w@treble>
In-Reply-To: <20211006212355.mfuyci3pnsdlbp3w@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 16:14:17 -0700
Message-ID: <CABCJKufCaOXOUF43a-PQshO8aEsMNhZ2EiyGMSOp9ZGn57G=pg@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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

On Wed, Oct 6, 2021 at 2:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Oct 06, 2021 at 05:10:16PM -0400, Steven Rostedt wrote:
> > On Wed, 6 Oct 2021 13:43:35 -0700
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > On Wed, Oct 06, 2021 at 10:45:41AM -0700, Sami Tolvanen wrote:
> > > > On Wed, Oct 6, 2021 at 9:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > >
> > > > > On Wed, 6 Oct 2021 09:31:04 -0700
> > > > > Sami Tolvanen <samitolvanen@google.com> wrote:
> > > > >
> > > > > > > > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > > > > > > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > > > > > > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > > > > > > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> > > > > > >
> > > > > > > "not called from C" is a bit confusing.
> > > > > >
> > > > > > Any thoughts on how to make this less confusing?
> > > > >
> > > > >  "Not called by C code, but injected by the compiler."
> > > > >
> > > > > ?
> > > >
> > > > Sure, sounds good to me. I'll update this in v5.
> > >
> > > "injected by the compiler" sounds even more confusing.  It almost sounds
> > > like those functions are generated by GCC, which they are most
> > > definitely not.
> > >
> >
> > Heh, I was thinking of the locations that are injected (mcount / fentry) as
> > these are just replacements for them. Those injections are added by GCC.
> >
> > So, continuing the bikeshedding, what about "not called by C code, but are
> > trampolines injected as calls replacing the nops at the start of
> > functions added by the compiler." ?
>
> I'm not quite sure what that means, but I'll allow it ;-)

Alright, I'll go with the updated version then. I'll also rename
DECLARE_ASM_FUNC_SYMBOL() to DECLARE_NOT_CALLED_FROM_C() unless
someone has strong objections about that.

Sami
