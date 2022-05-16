Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C650BC433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 17:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbiEPRPj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbiEPRPi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 13:15:38 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9333337A
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 10:15:37 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fee9fe48c2so39422747b3.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGf6wjrvSBA9+5luKWtA8S1TB1Ho/iykZkRoevKUR/M=;
        b=sG0LBzcw6X5gtPxGyrwzWMTlfNPOaO9928SvntnUZYb9/aTe8ETQvXR+oTGM+2Q01E
         FT27+UEachU8nZ1/6NE6iFT0H7w2Z3yA+Xt2mScQcVbGHTAWTIC7oC4Ow2OaFjZ9yRPC
         zsYacU5leVMUJP7q08JQQ5kO8v4LF8Y18NuJOV1FQrJzkb1Q6HVJDb2aR5qUZZ4fxb8L
         j83sHlqEvTkYQHwcihaYzN7Qej80njRn7ld+NLQm+PvbJhpZV4rhRz6XHZUrjQV7dE19
         0b1Wx+2l3Noy/e5cucVImILRyz95RaT9Ba/0fxbWcc15VZWfUSGKEh7MDJ5UgWmgO8Wm
         Fp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGf6wjrvSBA9+5luKWtA8S1TB1Ho/iykZkRoevKUR/M=;
        b=0QO3c05ZzsuIyngyqAPk3nDNlUvAUa0tfErHZv8wrsHhs58DmMdjfAqBR6tMNaLBnU
         r7zbT+Eq/zujYO12ee/pTTmyDVqBkE3CzpjsOaDhZLXCfNNhBAa01s3gJOqi7mZ2VaK4
         lIhYSPMf7XBCVGdamDZqn5yE1VXEpRJFOJU1coz5JKqC6yWVopqP1BnSDKJTzj7XWq25
         rGeArhp7vuE5ZYcn0t55Mg4NNuSmcfKLKfwxOuS2wRhOBKhvkfCuCljUqBadlNb4i2SI
         +jz1HQI8HXoeqYvCniOgTgiQk1+z7rpPqRmW3yBNNjDePMUjh07mpR1mG3Y6cbBaB/Sd
         6GGw==
X-Gm-Message-State: AOAM532HTcjscN09wiqmW65aAd/UdXqUWOI/y9Nn1KUUOH94ZGSG9xHU
        gZjnA0gtdoOSh2seFXH5NJUzpnIMZi4P/ltN3YEEPg==
X-Google-Smtp-Source: ABdhPJwVJxOR6miZJ4+xQc2WHDZMKppmkvrGNnjVqxWGG/tKcoV/VdOV2r77ffndCOhGZP+04/DkGyU0orcJhTS4elU=
X-Received: by 2002:a0d:d747:0:b0:2ff:22b9:9281 with SMTP id
 z68-20020a0dd747000000b002ff22b99281mr186733ywd.305.1652721336717; Mon, 16
 May 2022 10:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
In-Reply-To: <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 10:15:00 -0700
Message-ID: <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 2:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler injects a type preamble
> > immediately before each function and a check to validate the target
> > function type before indirect calls:
> >
> >   ; type preamble
> >   __cfi_function:
> >     int3
> >     int3
> >     mov <id>, %eax
> >     int3
> >     int3
> >   function:
> >     ...
>
> When I enable CFI_CLANG and X86_KERNEL_IBT I get:
>
> 0000000000000c80 <__cfi_io_schedule_timeout>:
> c80:   cc                      int3
> c81:   cc                      int3
> c82:   b8 b5 b1 39 b3          mov    $0xb339b1b5,%eax
> c87:   cc                      int3
> c88:   cc                      int3
>
> 0000000000000c89 <io_schedule_timeout>:
> c89:   f3 0f 1e fa             endbr64
>
>
> That seems unfortunate. Would it be possible to get an additional
> compiler option to suppress the endbr for all symbols that get a __cfi_
> preaamble?

What's the concern with the endbr? Dropping it would currently break
the CFI+IBT combination on newer hardware, no?

> Also, perhaps s/CFI_CLANG/KERNEL_CFI/ or somesuch, so that GCC might
> also implement this same scheme (in time)?

I'm fine with renaming the config.

> >   ; indirect call check
> >     cmpl    <id>, -6(%r11)
> >     je      .Ltmp1
> >     ud2
> >   .Ltmp1:
> >     call    __x86_indirect_thunk_r11
>
> The first one I try and find looks like:
>
> 26:       41 81 7b fa a6 96 9e 38         cmpl   $0x389e96a6,-0x6(%r11)
> 2e:       74 02                   je     32 <__traceiter_sched_kthread_stop+0x29>
> 30:       0f 0b                   ud2
> 32:       4c 89 f6                mov    %r14,%rsi
> 35:       e8 00 00 00 00          call   3a <__traceiter_sched_kthread_stop+0x31> 36: R_X86_64_PLT32      __x86_indirect_thunk_r11-0x4
>
> This must not be. If I'm to rewrite that lot to:
>
>   movl  $\hash, %r10d
>   sub   $9, %r11
>   call  *%r11
>   .nop  4
>
> Then there must not be spurious instruction in between the ud2 and the
> indirect call/retpoline thing.

With the current compiler patch, LLVM sets up function arguments after
the CFI check. if it's a problem, we can look into changing that.

Sami
