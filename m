Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34868C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 17:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1412661152
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 17:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJNRdd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:33:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhJNRdd (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 13:33:33 -0400
Received: from zn.tnic (p200300ec2f0c720076278dcac58b4415.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:7627:8dca:c58b:4415])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 827361EC0136;
        Thu, 14 Oct 2021 19:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634232686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DQftSPqAxAWNjuaFkjQxzK/R7rLUcHBb68ob6y37uAY=;
        b=oAjh5oIbWL4Qps5tii3z9bWeNfIXuMC0QHYFueKGxd59UyW/fZ8YnGzPXV4s72lU0LuPcF
        1PeAlpl6o1Qg0UBR1hXBa+cATJP38cNKvjDL+XUUMJOkaq5qJP97/+Zz+vko9NQ7yU26OS
        82fmwfUbc+Fr1ZAeTMRvYwVSV6OwzZY=
Date:   Thu, 14 Oct 2021 19:31:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
Message-ID: <YWhpbu/Y6V2p/zlY@zn.tnic>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-10-samitolvanen@google.com>
 <YWgSwmzPFrRbMC1P@zn.tnic>
 <202110140904.41B5183E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110140904.41B5183E@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 14, 2021 at 09:07:57AM -0700, Kees Cook wrote:
> I don't think it's a super common thing to add, so in this case, yes,
> I think doing it on a case-by-case basis will be fine. 

You don't have a choice - if there's no automation which verifies
whether all the CFI annotation needed is there, people won't know what
to wrap in what macro.

> I'd _much_ prefer keeping the macro, as it explains what's going on,
> which doesn't require a comment at every "extern const u8 foo[]" usage.

You don't have to - it is just an extern.

> It serves as an annotation, etc.

Oh, that I figured.

> And, there's been a lot of discussion on the best way to do this, what
> to name it, etc.

Looking at the changelog, DECLARE_ASM_FUNC_SYMBOL, makes a lot more
sense to me even if it doesn't specify the aspect that it is not called
by C but who cares - it is generic enough.

> This looks to be the best option currently.

Maybe because wrapping some random symbols in a obfuscating macro to
make the next tool happy, is simply the wrong thing to do. I know, I
know, clang CFI needs it because of magical reason X but that doesn't
make it any better. Someday soon we'll have to write a tutorial for
people submitting kernel patches explaining what annotation to add where
and why.

Why can't clang be taught to ignore those symbols:

clang -fsanitize=cfi -fsanitize-cfi-ignore-symbols=<list>

?

Hmm, looking at https://clang.llvm.org/docs/ControlFlowIntegrity.html

there *is* an ignore list:

"Ignorelist

A Sanitizer special case list can be used to relax CFI checks for
certain source files, functions and types using the src, fun and type
entity types. Specific CFI modes can be be specified using [section]
headers.

...

# Ignore all functions with names containing MyFooBar.
fun:*MyFooBar*
..."


So why aren't we doing that instead of those macros?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
