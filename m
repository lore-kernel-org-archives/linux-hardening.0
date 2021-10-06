Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B902AC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E90760EE5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhJFQdQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbhJFQdI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 12:33:08 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE40DC061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 09:31:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n65so6755718ybb.7
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1N3Etrc+IvlHyTpW7XkflFyYfrFk6rq2AqHGQBELZI=;
        b=do0VsLfLI2lEtXGQ1eVW8WxUCz+l5Lk4ygQl5n1FOf2jF3PCNgZ1wMObNtiIbTcf+e
         B40CeDdtVeIMVjl5dzsNcPlaZ6m8HdwJNLaxvu6gQobCuQXyqqQ+Kk5M3vK321l/ESD1
         KIaCA/RM8+7OKe5KEHOXwRIoWauGyx25EptJHukJY5bPGQbVjCCkM6WNZ4M6YAIut9Z6
         jPiwx0xBNmxc4GmTvsqedBpLvzX1bYX4USqwZhelY13DEIRDd8pbNfnQYAH3T2oHjQSK
         ocZ26P/QWYFDW5HzWK9VG1wwJ9ZymgHn+DPb973yudIMMSdYI5fUK50mwFWdPk9zAuu+
         VDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1N3Etrc+IvlHyTpW7XkflFyYfrFk6rq2AqHGQBELZI=;
        b=J7KG4lmhxaxB7xRhEOPESlIklVhqwuO+Cet5aX4lOBkUOvxtAZG1DbfR5Fn/sbr/WM
         H+C/TJ6xkZEGvsbFdx1ez23SW4++MtpRaPSpDJjvqWN83dkBPzlcv2DROCZM/75xUNBP
         xAAIbv1G+N0GowSfC8+pc3BMK81akb05e+ZPiCou7UWfYod5++163CgX8Ih4LvtE0PKF
         unpiNbkgoLatlS24rGKd1XG0Dgt3fe6i3QYvWG5z9db743EcQbmU5UgLlsjNs8nZPqZx
         d2jSLDt3Q6ldwZeSz8c5L1vak/pRbAT+3Eg4nWJZ7+LKea3pTg/9ayH5UvjJvCEyJOX1
         k25A==
X-Gm-Message-State: AOAM531lckPiRtY7yFCJ6iT/yh4iE1M1CMVFTRTmpA82ornvJlu6ShCJ
        KtBuPwIMjs9r+K9fPbiEgJTk+o9m9nt3zPAkcn+A1A==
X-Google-Smtp-Source: ABdhPJy8ZvP2+QO+CLs1N3WqFjTvJStSsRb5E6N64u3z88hwpMV+U4CySxFZZ2HW0mgzuvjTeBsNSu/GKHKGulEh6FM=
X-Received: by 2002:a25:aaec:: with SMTP id t99mr30955841ybi.456.1633537875696;
 Wed, 06 Oct 2021 09:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com> <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home>
In-Reply-To: <20211006090249.248c65b0@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 09:31:04 -0700
Message-ID: <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
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

On Wed, Oct 6, 2021 at 6:02 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 5 Oct 2021 20:29:45 -0700
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Thanks for Cc'ing me, as I should have been Cc'd on the original patch.

Sorry about that. I'll make sure you're cc'd on the next version.

> > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
>
> "not called from C" is a bit confusing.

Any thoughts on how to make this less confusing?

Sami
