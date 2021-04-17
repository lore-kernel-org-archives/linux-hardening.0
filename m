Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_SECURITY,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6FDC433ED
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 00:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1B7611AB
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 00:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhDQARV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:17:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQARV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 20:17:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618618615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Awmw6FQX3kMFpHwcJJpDjpnUIkXDM9qU4F7z0EY9BOQ=;
        b=Toijv6EokYjVPVc/1pFzgXN0WFyWYwCwrbwbzRWE5BYFZMUlFC0Sr0Pw2AYPyT8Yq2Sifw
        JsK+Unb2LAzNTSOSCKoLaq5mp/SiEfh2B6vdTCnyEBF61XuCi1gP3pu4c21Xp8rIP2AyJv
        hFj5W4HjngRuEhvaay0ph1fe+g3cERmM30q650N6CTfAOFbCz+lm0rKvFy9XzZR3hzK9K1
        4ecB3qrJUUk7ARCgyf81SumSacJCGll91HCkUq7U4vAIY9vm9E24oAi0WAQzWCgjIN7o1l
        +iq7oWAB2oUeeYWsxTDDGp40k+tqOVUWrBHBQMQAPXi7bPflrrqYUP/6EDw3vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618618615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Awmw6FQX3kMFpHwcJJpDjpnUIkXDM9qU4F7z0EY9BOQ=;
        b=d7wOCppmjSFxjkVgDvZW6ZTaKM+McKzYUKFWqdFWmWCWmhPdZvFU12ALq+Vq34ZCi3qZZp
        QLr7itYlrlw36CDQ==
To:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 04/15] static_call: Use global functions for the self-test
In-Reply-To: <87v98lud0z.ffs@nanos.tec.linutronix.de>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-5-samitolvanen@google.com> <87v98lud0z.ffs@nanos.tec.linutronix.de>
Date:   Sat, 17 Apr 2021 02:16:54 +0200
Message-ID: <878s5hu5mx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16 2021 at 23:37, Thomas Gleixner wrote:
> On Fri, Apr 16 2021 at 13:38, Sami Tolvanen wrote:
>>  #ifdef CONFIG_STATIC_CALL_SELFTEST
>>  
>> -static int func_a(int x)
>> +int func_a(int x)
>>  {
>>  	return x+1;
>>  }
>>  
>> -static int func_b(int x)
>> +int func_b(int x)
>>  {
>>  	return x+2;
>>  }
>
> Did you even compile that?
>
> Global functions without a prototype are generating warnings, but we can
> ignore them just because of sekurity, right?
>
> Aside of that polluting the global namespace with func_a/b just to work
> around a tool shortcoming is beyond hillarious.
>
> Fix the tool not the perfectly correct code.

That said, I wouldn't mind a  __dont_dare_to_rename annotation to help
the compiler, but anything else is just wrong.

Thanks,

        tglx
