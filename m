Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34340C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2012660F56
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhJ0Oly (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbhJ0Olx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0315C061745;
        Wed, 27 Oct 2021 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Z1LSjjxATuKspxn0VwS+AddSpEQQEMWAwB+9QtWo/A=; b=OkNK9AR8pr9DWcIIViUg3PoK7z
        ZN0B2w5boSWWwN6Pv2E3KJDa3jJmRoBxmD5N2OHm+fh3nbYsSC4m5xq6i0lYRXIcmtlHdD74xMx8d
        zC+Cu707kT1SV28DvUjI8isbTV4AflPhaCA1TdxQEgEQSRMhao1X4IEpc8dlw56AGJaSQmL4SOl/N
        NDE5rQddQjZdBy47v/LRWuw+f+Si9QvLNbzXPbenigugnR4niiVstnAlVj/OMAyxZI7bNKSV1um7E
        GJwoV3OzVI5ahq+eM2nzdXE6spkSb60F8NqA1pm/rkkgmOwg2RmvwFg1LQLir/g/mY9FnGHGxeYnc
        V4XvcUNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfk2p-0006rV-7L; Wed, 27 Oct 2021 14:36:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D41BF30018E;
        Wed, 27 Oct 2021 16:36:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B7762BF47876; Wed, 27 Oct 2021 16:36:45 +0200 (CEST)
Date:   Wed, 27 Oct 2021 16:36:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 00/15] x86: Add support for Clang CFI
Message-ID: <YXlj/WaCIz4Nr/Fv@hirez.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211026201622.GG174703@worktop.programming.kicks-ass.net>
 <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 04:18:17PM +0200, Ard Biesheuvel wrote:
> On Wed, 27 Oct 2021 at 16:03, Peter Zijlstra <peterz@infradead.org> wrote:

> > /*
> >  * Turns a Clang CFI jump-table entry into an actual function pointer.
> >  * These jump-table entries are simply jmp.d32 instruction with their
> >  * relative offset pointing to the actual function, therefore decode the
> >  * instruction to find the real function.
> >  */
> > static __always_inline void *nocfi_ptr(void *func)
> > {
> >         union text_poke_insn insn = *(union text_poke_insn *)func;

also, probably, for the paranoid amongst us:

	if (WARN_ON_ONCE(insn.opcode != JMP32_INSN_OPCODE))
		return func;

> >         return func + sizeof(insn) + insn.disp;
> > }
> >
> > But really, that wants to be a compiler intrinsic.
> 
> Agreed. We could easily do something similar on arm64, but I'd prefer
> to avoid that too.

Right, because on x86 CET-IBT will force that entry to have a different
form (and size), similar on arm64 with BTI.

I was thinking the compiler really should implicitly do this conversion
when a function pointer is cast to an integer type. But barring that, we
really need an intrinsic to perform this.

Also, perhaps the compiler should admit it's doing dodgy crap and
introduce the notion of address spaces and use the type system to
separate these two forms.
