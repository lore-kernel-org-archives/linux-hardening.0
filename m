Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D4C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 22:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54316115C
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 22:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbhJOWUL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbhJOWTv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 18:19:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139DC061570;
        Fri, 15 Oct 2021 15:17:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634336261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GYaw9r3XwJHigQlTx9TPmuUJK0go4LDViScK7A+Dcl0=;
        b=RqZ72OBiPyLo1ca/1t9NFP9mA4cqqjUT7Xt3+zA29o50wA8Zh7OJDzVyO3B0gq3W32ml4W
        /ww7SavjZHXU2FQv951y5J4aOsLDhE4x3xmOUKLBR1uXAplmECmO8bgGdZXef9YTqM7T6b
        Bo3gLN+ft6Ib0BvIr19ynyI52Hsfq7IcHEzXnBEYyQIzZcG5mHJthdxi2UCHRciY15CLpK
        Kbf+HzoVfGtDu1wzbCWg0ktNCazV0r9dJHe5IVb8sC2gLabPlhhurFq5wWm6AU2SOR19P7
        ohRMghdThdWpgbUewLW+J8g4JVU5+fWmPkERDUJOFNeW6+5WoGdLOHYoSsTNTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634336261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GYaw9r3XwJHigQlTx9TPmuUJK0go4LDViScK7A+Dcl0=;
        b=2U4hG/FdpmEehOILJSJiHiJYZBfrKOo3ubGzaQmIufXFD5KC+QcfjBCydQhSqAwlaTkzGw
        nukWOJ1+f/nauOCA==
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
In-Reply-To: <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx> <87zgra41dh.ffs@tglx>
 <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
Date:   Sat, 16 Oct 2021 00:17:40 +0200
Message-ID: <87wnme3pbv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 15 2021 at 11:42, Sami Tolvanen wrote:
> On Fri, Oct 15, 2021 at 10:57 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Not beautiful, but it gives the information which is needed and it tells
>> me clearly what this is about. While the above lumps everything together
>> whatever it is.
>
> Sure, that makes sense. Ignoring the macro for a moment, how do you
> feel about using incomplete structs for the non-C functions as Andy
> suggested?

I think I agreed with that back then when he suggested it the first
time. That still allows me to do a classification:

struct asm_exception
struct asm_xen_hv_call
....

>> Having __bikeshedme would allow to do:
>>
>>    __hardware_call
>>    __xenhv_call
>>    __inline_asm_call
>>
>> or such, which clearly tells how the function should be used and it can
>> even be validated by tooling.
>
> Previously you suggested adding a built-in function to the compiler:
>
> https://lore.kernel.org/lkml/877dl0sc2m.ffs@nanos.tec.linutronix.de/
>
> I actually did implement this in Clang, but the feature wasn't
> necessary with opaque types, so I never moved forward with those
> patches. A built-in also won't make the code any cleaner, which was a
> concern last time.
>
> I do agree that a function attribute would look cleaner, but it won't
> stop anyone from mistakenly calling these functions from C code, which
> was something Andy wanted to address at the same time. Do you still
> prefer a function attribute over using an opaque type nevertheless?

For actually callable functions, by some definition of callable,
e.g. the clear_page_*() variants a proper attribute would be definitely
preferred.

That attribute should tell the compiler that the function is using the
register arguments correctly but is not suitable for direct invocation
because it clobbers registers.

So the compiler can just refuse to call such a function if used directly
without an inline asm wrapper which describes the clobbers, right?

But thinking more about clobbers. The only "annotation" of clobbers we
have today are the clobbers in the inline asm, which is fragile too.

Something like

 __attribute__ ((clobbers ("rcx", "rax")))

might be useful by itself because it allows validation of the clobbers
in the inline asm wrappers and also allows a analysis tool to look at
the ASM code and check whether the above list is correct.

Hmm?

Thanks,

        tglx
