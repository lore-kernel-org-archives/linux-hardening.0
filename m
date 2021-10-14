Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39FC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B528860F36
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 18:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJNSyU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhJNSyT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 14:54:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF6761027;
        Thu, 14 Oct 2021 18:52:13 +0000 (UTC)
Date:   Thu, 14 Oct 2021 14:52:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
Message-ID: <20211014145211.573579e6@gandalf.local.home>
In-Reply-To: <202110141141.870A67E@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
        <20211013181658.1020262-10-samitolvanen@google.com>
        <YWgSwmzPFrRbMC1P@zn.tnic>
        <202110140904.41B5183E@keescook>
        <YWhpbu/Y6V2p/zlY@zn.tnic>
        <202110141141.870A67E@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 14 Oct 2021 11:47:01 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Thu, Oct 14, 2021 at 07:31:26PM +0200, Borislav Petkov wrote:
> > On Thu, Oct 14, 2021 at 09:07:57AM -0700, Kees Cook wrote:
> > Looking at the changelog, DECLARE_ASM_FUNC_SYMBOL, makes a lot more
> > sense to me even if it doesn't specify the aspect that it is not called
> > by C but who cares - it is generic enough.  
> 
> Around we go. :) Josh[1] and Steven[2] explicitly disagreed with
> that name, leading to the current name[3]. Do you want it to be
> DECLARE_ASM_FUNC_SYMBOL() over those objections?

Just note, that I was fine with the original name, but was against the
version Josh suggested ;-)

> 
> I'd really like to finish this shed -- I need to take the bikes in from
> the rain. :P

Back to black it is!

-- Steve
