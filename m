Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D5C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18AD60EBD
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 10:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhJ0KUP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhJ0KUO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 06:20:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06956C061570;
        Wed, 27 Oct 2021 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kjEt7cLdB7cPY697Uxk7dOM1bUF1hgkDJORd+L3Zemw=; b=EjvrI8xmrCQvizKIITT1kd5sfX
        Cwh5JtTCAqtPJJENlQ9U04/4v8GsIXNQvHTW3qFvxwiccJAMJV50vqxuAjtELdXSD/BWkC9DGCeQu
        5GjyaEsphuI6PG2zbE4fI3p0JZHAYsehpR2XfgzX5HIduZLhYsGphLQs+z1XPKTIouDXUfXfIx2LZ
        hhIVSi1Sc8xcJMHcl9b5hxp6B7FpSzmYhUvJ8p9FDyLaI3AeWuO6j+To0Y2ZHLEYzEXZWhxI91SRU
        KwSD/LJ1/7N1s4cBUGMFzrntaq83hbtPtk7PsBSszHjxg/j4Q1EY+iYYZd00cz7nxC0QpdGsgdR/A
        xJxXMVlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mffzm-00CX9d-Lr; Wed, 27 Oct 2021 10:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50F2D30031A;
        Wed, 27 Oct 2021 12:17:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 355282B41AF5C; Wed, 27 Oct 2021 12:17:21 +0200 (CEST)
Date:   Wed, 27 Oct 2021 12:17:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
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
        "ardb@kernel.org" <ardb@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <YXknMVcB1tWaPtoU@hirez.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <7ebed28b73bb48cd9b69e9097f0aa613@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ebed28b73bb48cd9b69e9097f0aa613@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 10:02:56AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 26 October 2021 21:16
> > 
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
> > 
> > But how does this work with things like static_call(), which we give a
> > function address (now a jump-table entry) and use that to write direct
> > call instructions?
> > 
> > Should not this jump-table thingy get converted to an actual function
> > address somewhere around arch_static_call_transform() ? This also seems
> > relevant for arm64 (which already has CLANG_CFI supported) given:
> > 
> >   https://lkml.kernel.org/r/20211025122102.46089-3-frederic@kernel.org
> > 
> > Or am I still not understanding this CFI thing?
> 
> From what I remember the compiler adds code prior to every jump indirect
> to check that the function address is in the list of valid functions
> (with a suitable prototype - or some similar check).

It definitely mucks about with the address too; see here:

  https://lkml.kernel.org/r/YW6a67fGzM2AyHot@hirez.programming.kicks-ass.net

I'm thinking static_call() wants the real actual function address before
it writes instructions.
