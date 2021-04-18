Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB55FC433B4
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Apr 2021 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE831610EA
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Apr 2021 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhDRQRi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 18 Apr 2021 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhDRQRh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 18 Apr 2021 12:17:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC0C06174A;
        Sun, 18 Apr 2021 09:17:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618762627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ei/Yss7OFKyCWpzQUujDkbmPdYqeOzmRTpmtbyzHOFs=;
        b=rjgvKYr9h78j1MuB5D/+W6idRHFi77UwZew2dozCKWJV2YAydjXGvLWoCYijq05UxWD19D
        q8xszVkvx1JZAE6F1EAvVkoBkq8m6aMft64Mu/4gG2lVCi/dsNKINs20W/RnFgPs+g+YxP
        e7tImWSrNQfXo4BNdY6fH5q8J5/CzbyhmfcAJOckU+can1rXgB4gGKKsRutqAiAzFwC52l
        wLXeIvKZa475luTNjDoAyD7RQj4+b4J51A3rCvGpd8MSA/jOCvhRFjqz8V3Q2u7j1GjLI8
        zzb3ReAs3zoCfBgnKZA5g+mZtKRwFKGZvvMRY3Fxp4CO4NCEM3u/E+eajoM2YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618762627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ei/Yss7OFKyCWpzQUujDkbmPdYqeOzmRTpmtbyzHOFs=;
        b=ZHc1LZMdaSerWD1GG9gYwNALAQtKzJ47jKGIhNNW3iT/6ExK7HuXCCLi5M4MDn6MukLt7w
        K4QBzPu1Ykvgy0Dg==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
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
In-Reply-To: <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic> <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com> <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com> <202104161519.1D37B6D26@keescook> <CALCETrV6WYx7dt56aCuUYsrrFya==zYR+p-YZnaATptnaO7w2A@mail.gmail.com> <202104161601.CFB2CCF84F@keescook> <CALCETrWUS52tzLNiWL5sAVVB5-ko1EW73-TEiO=eZ5jF_QyGPQ@mail.gmail.com> <877dl0sc2m.ffs@nanos.tec.linutronix.de> <CALCETrVEhL9N_DEM8=rbAzp8Nb2pDitRCZGRAVcE288MBrJ4ug@mail.gmail.com>
Date:   Sun, 18 Apr 2021 18:17:06 +0200
Message-ID: <871rb7sh31.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Apr 17 2021 at 17:11, Andy Lutomirski wrote:
> On Sat, Apr 17, 2021 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> which works for
>>
>>       foo = function_nocfi(bar);
>
> I agree in general.  But right now, we have, in asm/proto.h:
>
> void entry_SYSCALL_64(void);
>
> and that's pure nonsense.  Depending on your point of view,
> entry_SYSCALL_64 is a symbol that resolves to an integer or it's an
> array of bytes containing instructions, but it is most definitely not
> a function void (void).  So, regardless of any CFI stuff, I propose
> that we standardize our handling of prototypes of symbols that are
> opaque to the C compiler.  Here are a couple of choices:
>
> Easy one:
>
> extern u8 entry_SYSCALL_64[];
>
> Slightly more complicated:
>
> struct opaque_symbol;
> extern struct opaque_symbol entry_SYSCALL_64;
>
> The opaque_symbol variant avoids any possible confusion over the weird
> status of arrays in C, and it's hard to misuse, since struct
> opaque_symbol is an incomplete type.

Makes sense.
