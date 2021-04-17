Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE1FC433B4
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862BB610CE
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 23:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhDQXxd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Apr 2021 19:53:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhDQXxd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Apr 2021 19:53:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618703585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7Maz4mAaNbdh6Ve2gjfbQ91hhlq7K86k/cKBnBKj+o=;
        b=JL1VKzqbrIa3SYfPGHkP301KVkKx9iseYHaE147CV1T99SWZRu9M2xrlejpo+7+id7X6hE
        xU994hSS7pS+5vaHzabhxnBSzi7WeTDUgvKifckC5vOh8gVZ8cHvo/xkx6hhDDfUnHcl5S
        bm3TQp5BrtEExphqWcvcHiWnyyRl9Le5qxGPwy5mjNNd5obEbatAvU9AwHi/jlipgGFl7O
        DvEYZ3870Mp6klLWpcw80tcGKJgS+tZYC0wSdbhj4o83cmf4bGeTWZfhgskZQkUx8SfxOa
        MLWQzOuIDEZCdKl9d8A8RpkVZMF2XmSNjeE2j+G9kEKivmnWSa498TktT31zKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618703585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7Maz4mAaNbdh6Ve2gjfbQ91hhlq7K86k/cKBnBKj+o=;
        b=2k5HzHcHvjwxNHzQGyVxfekEzoHigrWN6JBN2/crbtZzWYKhTbil2dKtjrfLjpP8XiVd6Y
        ShR7AaM9h8O6iEBA==
To:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
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
In-Reply-To: <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic> <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com> <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com> <202104161519.1D37B6D26@keescook> <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com> <202104161601.CFB2CCF84F@keescook> <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com>
Date:   Sun, 18 Apr 2021 01:53:05 +0200
Message-ID: <877dl0sc2m.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Apr 17 2021 at 16:19, Andy Lutomirski wrote:
> On Fri, Apr 16, 2021 at 4:40 PM Kees Cook <keescook@chromium.org> wrote:
>> Okay, you're saying you want __builtin_gimme_body_p() to be a constant
>> expression for the compiler, not inline asm?
>
> Yes.
>
> I admit that, in the trivial case where the asm code is *not* a
> C-ABI-compliant function, giving a type that doesn't fool the compiler
> into thinking that it might be is probably the best fix.  Maybe we
> should standardize something, e.g.:
>
> struct raw_symbol;  /* not defined anywhere */
> #define DECLARE_RAW_SYMBOL(x) struct raw_symbol x[]
>
> and then we write this:
>
> DECLARE_RAW_SYMBOL(entry_SYSCALL_64);
>
> wrmsrl(..., (unsigned long)entry_SYSCALL_64);
>
> It would be a bit nifty if we didn't need a forward declaration, but
> I'm not immediately seeing a way to do this without hacks that we'll
> probably regret;
>
> But this doesn't help the case in which the symbol is an actual
> C-callable function and we want to be able to call it, too.

The right way to solve this is that the compiler provides a builtin

 function_nocfi() +/- the naming bikeshed

which works for

      foo = function_nocfi(bar);

and

static unsigned long foo[] = {
       function_nocfi(bar1),
       function_nocfi(bar2),
};

which are pretty much the only possible 2 usecases. If the compiler
wants to have function_nocfi_in_code() and function_nocfi_const()
because it can't figure it out on it's own, then I can live with that,
but that's still several orders of magnitudes better than having to work
around it by whatever nasty macro/struct magic.

I don't care about the slightly more unreadable code, but if that
builtin has a descriptive name, then it's even useful for documentary
purposes. And it can be easily grepped for which makes it subject to
static code analysers which can help to detect abuse.

Anything which requires to come up with half baken constructs to work
around the shortcomings of the compiler are wrong to begin with.

Thanks,

        tglx
