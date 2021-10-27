Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954DC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8708660E09
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 12:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbhJ0Mtl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhJ0Mtk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 08:49:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CCC061570;
        Wed, 27 Oct 2021 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=07scw71Qfs4SI4ir9McWtaQKp2wLsiaRGVZmK2PzJ8k=; b=K7i9raGDP7DMyO3RzzHOftf1y7
        tfwaocRSisRWhzUVRSLRUdSlMyJEP9lCWDhEGEvWHzDqW68jgKutVNhzQFXv6nxMbI/bxGqCI9bZg
        xRZxDbETguyVyOxmQBD/CbAychhPQf9HRTwrWky+5erfju+jTp1JPBlConAJlBcFUQzJngYIjyWNJ
        aPbzg+buloRgfGWGUWUonZZeJXMGNZBJFYThPJsxa8vghmoi+M2MGC3LEtCEcS3vRbbXznJB59ot0
        vSAyLdKZAZRI17yQCnLx2Ht+66HkapompInFKqzLGI0QOqATCn6iAf6PIQfszE7kGWMvmRHNZDPZS
        HbMMmLyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfiKQ-00CYVg-IL; Wed, 27 Oct 2021 12:46:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 695C298629C; Wed, 27 Oct 2021 14:46:49 +0200 (CEST)
Date:   Wed, 27 Oct 2021 14:46:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ardb@kernel.org
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <20211027124649.GJ174703@worktop.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027120515.GC54628@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 01:05:15PM +0100, Mark Rutland wrote:
> On Tue, Oct 26, 2021 at 10:16:22PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 13, 2021 at 11:16:43AM -0700, Sami Tolvanen wrote:
> > > This series adds support for Clang's Control-Flow Integrity (CFI)
> > > checking to x86_64. With CFI, the compiler injects a runtime
> > > check before each indirect function call to ensure the target is
> > > a valid function with the correct static type. This restricts
> > > possible call targets and makes it more difficult for an attacker
> > > to exploit bugs that allow the modification of stored function
> > > pointers. For more details, see:
> > > 
> > >   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> > 
> > So, if I understand this right, the compiler emits, for every function
> > two things: 1) the actual funcion and 2) a jump-table entry.
> > 
> > Then, every time the address of a function is taken, 2) is given instead
> > of the expected 1), right?
> 
> Yes, and we had to bodge around this with function_nocfi() to get the
> actual function address.

The patch set under consideration seems to have forgotten to provide one
for x86 :/

> Really there should be a compiler intrinsic or attribute for this, given
> the compiler has all the releveant information available. On arm64 we
> had to us inine asm to generate the addres...

Agreed, this *really* shouldn't be an arch asm hack trying to undo
something the compiler did.

