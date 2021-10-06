Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BCFC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54C6610E6
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 17:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhJFRrq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFRrp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 13:47:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B5C061746
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 10:45:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h2so7183210ybi.13
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymHLGH0Raq7ZmGFbhtXmAYW4w7KWD4EjLyVclCp4QNk=;
        b=FDtgJKC2yf2w+mH0oA+D57k3nx54eAv/j4VPf/geQ25vy2h5bs5gGf0Yl1iswCf1br
         twAlku9c9HaQSksJSdqaGILpkNO3VsxHP9T1pKiFZm1xd81utR7KiW1+TbdnVFM9dzpv
         8MoBpvwGcgoktnH8xTxKJKbmy6W3EpmN8/refTKp/q1c/VYBmgAmlELHwB6dYPrGl42f
         EK8d99G65Tdvk9Jmz13SG4Pw3nOYOepqAVXVBjNnwjzcGQfYX7qjEKWCQW1sl81JGpj/
         wPwKz8QCcOlukoAR89S4zRJYHYvhB8UdTQ37d5TO0bIL21axXkguID2Igqxbg/MNVIs/
         eROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymHLGH0Raq7ZmGFbhtXmAYW4w7KWD4EjLyVclCp4QNk=;
        b=md9QWdBwjWIfiNNmZud+nlSQq/E5deS6ZNY7z92CJbgE9LqOyITjsRv6H2jaAsnz7P
         qFOueAzDxYp8admrgpTvpQvGbN51GeK1xr8kRisXZlvpnyhdKBFZJLYGN+4zocbLxd5V
         8yQFd0IuCUujFIKo8VUH/liAZb1F3qj0gus8Pn2qQgTRkP+P9Xyn72J40V3LAh2nGTUu
         ajL048wTPB/BgJTsHiZJ6DFKHjlke93pB/3A/jQb8vqyBES3rFORQFB+X4HQnoF81AHM
         X43M2mtB0HHGB3U93PYq6TSxV0SP67QOb/TlgzVOHRhcA/zSV5Ng//itball5aDvEqby
         XEFQ==
X-Gm-Message-State: AOAM531mp9GUF2UiKrC0dveHT2uaoeP24g042FVvMvIywhyR8P8JlsIf
        /p6095d76gvf1L8XiS13KdXN7+DT7yqdWFrb6K66oQ==
X-Google-Smtp-Source: ABdhPJx/PRDppXa0Kq84b+6Rsz/D47+Ohg3rhbB34IFTWREHPFR3I/tnnF4mNhbpL2vllEq5+bhlJ18BTkRVcOXB5SQ=
X-Received: by 2002:a5b:286:: with SMTP id x6mr30426375ybl.59.1633542352526;
 Wed, 06 Oct 2021 10:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com> <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home> <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
 <20211006125809.5389b2a3@gandalf.local.home>
In-Reply-To: <20211006125809.5389b2a3@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 10:45:41 -0700
Message-ID: <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
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

On Wed, Oct 6, 2021 at 9:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 6 Oct 2021 09:31:04 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > > > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> > >
> > > "not called from C" is a bit confusing.
> >
> > Any thoughts on how to make this less confusing?
>
>  "Not called by C code, but injected by the compiler."
>
> ?

Sure, sounds good to me. I'll update this in v5.

Sami
