Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60ECC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73C560F6F
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 13:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbhJ0NUE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:20:04 -0400
Received: from foss.arm.com ([217.140.110.172]:43176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236464AbhJ0NUD (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 09:20:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACB2ED1;
        Wed, 27 Oct 2021 06:17:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.72.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407D63F73D;
        Wed, 27 Oct 2021 06:17:34 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:17:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211027131730.GF54628@C02TD0UTHF1T.local>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <456321a9fc5245408fc0d2798e497fe0@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456321a9fc5245408fc0d2798e497fe0@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 12:55:17PM +0000, David Laight wrote:
> From: Mark Rutland
> > Sent: 27 October 2021 13:05
> ...
> > Taking a step back, it'd be nicer if we didn't have the jump-table shim
> > at all, and had some SW landing pad (e.g. a NOP with some magic bytes)
> > in the callees that the caller could check for. Then function pointers
> > would remain callable in call cases, and we could explcitly add landing
> > pads to asm to protect those. I *think* that's what the grsecurity folk
> > do, but I could be mistaken.
> 
> It doesn't need to be a 'landing pad'.
> The 'magic value' could be at 'label - 8'.

Sure; I'd intended to mean the general case of something at some fixed
offset from the entrypoint, either before or after, potentially but not
necessarily inline in the executed instruction stream.

Mark.
