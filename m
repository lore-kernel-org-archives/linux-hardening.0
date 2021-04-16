Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B5C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 23:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCB3610CC
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 23:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhDPXDR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:03:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXDQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 19:03:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618614169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYsmczDUOwFiI2C1OqNRUIH5SZiNDmStN6eTeuq1zKQ=;
        b=unUul3QAQ0muFW7kvtT9Noo2VD3wluum0qlZXQtmRhJg8EhiZGpWVH4f09Tnga6lPKJeOK
        N1owE63QqorRqKKhR3IKyz8Sdjf0mtNR4lmzAMZLWE6DAKH0GfyXFfLiQ7a400h1nuFysM
        UBxwEeXvEX5JFWHmaFPAJ5g8Yytf20WLeLZVYabjAlCZnyeozYagC0d05kjh/G1WaBi8Wl
        5UPzx3vawkEQwr74v78kgLrP+5Dbch+hqkpBYPuvVnHAonSsvachHKnmRnRr869KyoGpGH
        dlP0V2hHkVEz6rx05WariVZC3XNyHIsJIX2MhoJ+t0FmANbGao5sGaiuDzo2ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618614169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYsmczDUOwFiI2C1OqNRUIH5SZiNDmStN6eTeuq1zKQ=;
        b=7henxW8UxJAPgENWbfxYcRSU76wF4NsVoNTZq9xprkuWjOv6OPIbRO2o05VCYhDWZygJwr
        pZsVaaSlXf4AKTCQ==
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
In-Reply-To: <202104161529.D9F98DA994@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic> <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com> <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com> <20210416221414.GF22348@zn.tnic> <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com> <202104161529.D9F98DA994@keescook>
Date:   Sat, 17 Apr 2021 01:02:49 +0200
Message-ID: <87fszpu92e.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16 2021 at 15:37, Kees Cook wrote:

> On Fri, Apr 16, 2021 at 03:20:17PM -0700, Andy Lutomirski wrote:
>> But obviously there is code that needs real function pointers.  How
>> about making this a first-class feature, or at least hacking around it
>> more cleanly.  For example, what does this do:
>> 
>> char entry_whatever[];
>> wrmsrl(..., (unsigned long)entry_whatever);
>
> This is just casting. It'll still resolve to the jump table entry.
>
>> or, alternatively,
>> 
>> extern void func() __attribute__((nocfi));
>
> __nocfi says func() should not perform checking of correct jump table
> membership for indirect calls.
>
> But we don't want a global marking for a function to be ignored by CFI;
> we don't want functions to escape CFI -- we want specific _users_ to
> either not check CFI for indirect calls (__nocfi) or we want specific
> passed addresses to avoid going through the jump table
> (function_nocfi()).

And that's why you mark entire files to be exempt without any rationale
why it makes sense.

Thanks,

        tglx
