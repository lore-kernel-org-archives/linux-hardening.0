Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F6CC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Oct 2021 00:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A3761130
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Oct 2021 00:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhJGA6h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 20:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhJGA6h (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 20:58:37 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9386610FC;
        Thu,  7 Oct 2021 00:56:43 +0000 (UTC)
Date:   Wed, 6 Oct 2021 20:56:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006205642.48d822b5@rorschach.local.home>
In-Reply-To: <CABCJKufCaOXOUF43a-PQshO8aEsMNhZ2EiyGMSOp9ZGn57G=pg@mail.gmail.com>
References: <20210930180531.1190642-1-samitolvanen@google.com>
        <20210930180531.1190642-7-samitolvanen@google.com>
        <20211006032945.axlqh3vehgar6adr@treble>
        <20211006090249.248c65b0@gandalf.local.home>
        <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
        <20211006125809.5389b2a3@gandalf.local.home>
        <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
        <20211006204335.xtymxt6wk4akx6fc@treble>
        <20211006171016.07d90b59@gandalf.local.home>
        <20211006212355.mfuyci3pnsdlbp3w@treble>
        <CABCJKufCaOXOUF43a-PQshO8aEsMNhZ2EiyGMSOp9ZGn57G=pg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 6 Oct 2021 16:14:17 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> > I'm not quite sure what that means, but I'll allow it ;-)  
> 
> Alright, I'll go with the updated version then. I'll also rename
> DECLARE_ASM_FUNC_SYMBOL() to DECLARE_NOT_CALLED_FROM_C() unless
> someone has strong objections about that.

No objection from me. I like the purple color.

-- Steve
