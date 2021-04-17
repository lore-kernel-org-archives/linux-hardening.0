Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAD3C433B4
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 10:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FADD6023F
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 10:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhDQKRL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Apr 2021 06:17:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhDQKRL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Apr 2021 06:17:11 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618654603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NXWguBIdanTM1mMJm6zQ6PV0EHjgoeyGYbzR/j6ivk=;
        b=Jk4XNHYpy88REhvfVJBJTQZwLtk3ad6VYFjs4t36LgPAPkDBrCQaJEE3Bj2aIRcKLzSKIF
        3VDHM41LJIE+9abFbCrx70IN3nO539IhTBsUcaBmeS8633jicpz2XDk8Mia42lK5lgty7h
        IURc71glQcBezs3dDPK2Nvp24T/NlP8zGfjmHxPBq1tyAq5gDguHmTEchEop5SSoiO4aAF
        FiW/kzDxMu1n2f9vTOp2zhIyBzLzQsHCWTqswc3agwIEWGCkCt+0h9MR0BHoFylHLxq37N
        FAGL+zHtaSfF+i61Jgmdqk631Sjg0q1h4tmzrGY7i8+oOhDzbpMqZ3yiV4UeLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618654603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NXWguBIdanTM1mMJm6zQ6PV0EHjgoeyGYbzR/j6ivk=;
        b=f0HCme8IUTL9Jls6iUuXsmcFqhPwp+8/RCkxl7beGPROqivH1L7nOWx8/V8XsonAxdJlrq
        7pjDQZnbJcdWFBCA==
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
In-Reply-To: <87fszpu92e.ffs@nanos.tec.linutronix.de>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic> <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com> <20210416220251.GE22348@zn.tnic> <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com> <20210416221414.GF22348@zn.tnic> <CALCETrUo+tR+YmfoBPWV9z_7QhU74=7tmCBD_zsfa24ZxNvfxg@mail.gmail.com> <202104161529.D9F98DA994@keescook> <87fszpu92e.ffs@nanos.tec.linutronix.de>
Date:   Sat, 17 Apr 2021 12:16:43 +0200
Message-ID: <875z0ltdv8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Apr 17 2021 at 01:02, Thomas Gleixner wrote:
> On Fri, Apr 16 2021 at 15:37, Kees Cook wrote:
>
>> On Fri, Apr 16, 2021 at 03:20:17PM -0700, Andy Lutomirski wrote:
>>> But obviously there is code that needs real function pointers.  How
>>> about making this a first-class feature, or at least hacking around it
>>> more cleanly.  For example, what does this do:
>>> 
>>> char entry_whatever[];
>>> wrmsrl(..., (unsigned long)entry_whatever);
>>
>> This is just casting. It'll still resolve to the jump table entry.
>>
>>> or, alternatively,
>>> 
>>> extern void func() __attribute__((nocfi));
>>
>> __nocfi says func() should not perform checking of correct jump table
>> membership for indirect calls.
>>
>> But we don't want a global marking for a function to be ignored by CFI;
>> we don't want functions to escape CFI -- we want specific _users_ to
>> either not check CFI for indirect calls (__nocfi) or we want specific
>> passed addresses to avoid going through the jump table
>> (function_nocfi()).
>
> And that's why you mark entire files to be exempt without any rationale
> why it makes sense.

The reason why you have to do that is because function_nocfi() is not
provided by the compiler.

So you need to hack around that with that macro which fails to work
e.g. for the idt data arrays.

Is there any fundamental reason why the compiler does not provide that
in a form which allows to use it everywhere?

It's not too much asked from a tool which provides new functionality to
provide it in a way which is usable.

Thanks,

        tglx
