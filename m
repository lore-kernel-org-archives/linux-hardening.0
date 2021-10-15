Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E0FC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 17:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E61D60E96
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Oct 2021 17:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbhJOR7j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:59:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbhJOR7i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Oct 2021 13:59:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634320650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJ0THKXxd/Bt+ZOJhojuTzHMSTcdTYp1X+BGRWm6h4g=;
        b=AmJt9r5Wubqb7bqcK7HDmhMVd2IlIBGgmSCKDUp5K/5o5V6Uh/oRsuJPA9R+z3eKwJTuPj
        cbr/jHp9zoRYrsH05O2ABxTbz/ygz9YHb2Ldy4/xiuCYkD+9/BpE48QjLMHEKjTbby/gXr
        ZDqzXr8mnDn6+yf7dkpBrdEPRBzHpg7szyQL+VEwzWdV0kfMfeXLPZDPkW1xYDQLiXrT1k
        g4ExYzVi/cyrGEcMw3QAErKB2sAdsdLUaKkra411yZ+B30sEqcRuaXEojh1k7wzOT1Ke/L
        RM+BzrACLxY9/aN7DICkUA94TM70plzX4NiUXtv5+l6k8hn8gn25dzTbQ3DcwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634320650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJ0THKXxd/Bt+ZOJhojuTzHMSTcdTYp1X+BGRWm6h4g=;
        b=Av/zrPQ98wmRxY7Yh8H4q2ZJOvvECSItHXiAM1Did8Vc8w8w8mFy8UkB5thu3zMMUloM0h
        6LVOlDPSdTb2C4Dg==
To:     Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
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
In-Reply-To: <8735p25llh.ffs@tglx>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx>
Date:   Fri, 15 Oct 2021 19:57:30 +0200
Message-ID: <87zgra41dh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 15 2021 at 17:55, Thomas Gleixner wrote:
> On Thu, Oct 14 2021 at 19:51, Andy Lutomirski wrote:
>> On Wed, Oct 13, 2021, at 11:16 AM, Sami Tolvanen wrote:
> That still tells me:
>
>     1) This is a function
>     
>     2) It has a regular argument which is expected to be in RDI
>
> which even allows to do analyis of e.g. the alternative call which
> invokes that function.
>
> DECLARE_NOT_CALLED_FROM_C(clear_page_erms);
>
> loses these properties and IMO it's a tasteless hack.

Look:

SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
                size_t, len)

Not beautiful, but it gives the information which is needed and it tells
me clearly what this is about. While the above lumps everything together
whatever it is.

Having __bikeshedme would allow to do:

   __hardware_call
   __xenhv_call
   __inline_asm_call

or such, which clearly tells how the function should be used and it can
even be validated by tooling.

You could to that with macros as well, but thats not what you offered.

Seriously, if you want to sell me that stuff, then you really should
offer me something which has a value on its own and makes it palatable
to me. That's not something new. See:

  https://lore.kernel.org/lkml/alpine.LFD.2.00.1001251002430.3574@localhost.localdomain/

That said, I still want to have a coherent technical explanation why the
compiler people cannot come up with a sensible annotation for these
things.

I'm tired of this attitude, that they add features and then ask us to
make our code more ugly.

It's not a well hidden secret that the kernel uses these kind of
constructs. So why on earth can't they be bothered to think about these
things upfront and offer us something nice and useful?

Thanks,

        tglx







