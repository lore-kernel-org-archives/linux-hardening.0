Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC71C433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3817260EFF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 14:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhJFOSt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhJFOSt (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 10:18:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F526105A;
        Wed,  6 Oct 2021 14:16:55 +0000 (UTC)
Date:   Wed, 6 Oct 2021 10:16:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006101654.6a5be402@gandalf.local.home>
In-Reply-To: <20211006135417.tvdns3ykpgupi47q@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
        <20210930180531.1190642-7-samitolvanen@google.com>
        <20211006032945.axlqh3vehgar6adr@treble>
        <20211006090249.248c65b0@gandalf.local.home>
        <20211006135417.tvdns3ykpgupi47q@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 6 Oct 2021 06:54:17 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> But this macro is used in other places as well:
> 
>   https://lkml.kernel.org/r/20210930180531.1190642-10-samitolvanen@google.com
> 
> And many of them aren't internal to a function like the above symbols,
> they're actual functions that are called in other ways.
> 
> DECLARE_UNCALLED_FROM_C() ?

  DECLARE_NOT_CALLED_FROM_C() ;-)

Straight and to the point!

"uncalled" is a strange word.

-- Steve
