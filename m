Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15052C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 28 Feb 2022 22:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiB1WgI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiB1WgH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 28 Feb 2022 17:36:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4F120E93
        for <linux-hardening@vger.kernel.org>; Mon, 28 Feb 2022 14:35:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id l12so7558866ljh.12
        for <linux-hardening@vger.kernel.org>; Mon, 28 Feb 2022 14:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYlTdB/zH2zblgmoJbVMlgCNjIMCACNfbfxIFy7zCbg=;
        b=YffGxEV3fEqsY9GWBppaPKRNBrzynzAbY4wbDhUWFOco26tpAhO0IuRkhq7R7kVeGy
         kCGrfkmtISOexCpSwD56tAqw/AgM/E4KcPGmW07tdJ8L7KV9gUJ5loOsfwzPzx4rL0ff
         cDYHSDoIMX0sKc/h1HNr8rms3/UCLLdxaGBGd9OeWf0ChoSiL3vBeXsk8eFWuBftDU/a
         tP6qLXNC7TQPjB0FwnoMgHIzJtGjjBMHmv+TRyXjAHe2aDuPsMDDre44MqC1PK1dHv8X
         Xsj8hrFOHzN0ZmXDvsA1dh0jx7fSDdb/YL2BnjlgcDV9DxoY/cQJ3kyd2y/5n3Lfne1V
         V0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYlTdB/zH2zblgmoJbVMlgCNjIMCACNfbfxIFy7zCbg=;
        b=qk3ENcRSSYf0TdMJLYzpXNjyqX41+PFWj0PoER4AIVX8QVl0BuERqFS8r6NvaM9Du7
         RZIa8KxHQoxCBMdhC73m28vR5ykXU6WMQQ9umJCaMcQZur6lTnMhLXryFOtsTMWpUrWN
         DCOvda3bew1TnCpMh0CYp76qyLJcigGlQx5+jz1sWwvaieZmfToWc8E3tf6kZX4LB49z
         aWIUB4VFO9B2Y4JPWKY00vmpErL6TktQ3ujtJ3sVKIROKg3lVo5xD1h6J5WBe0XOlUwI
         LwnadKUZ6GbetJZ/HQjTVOcdMahFZ1Ew+0ckc2EV6hsosK0ALqDog7y4lqZ4QaZ2cVq2
         rgwQ==
X-Gm-Message-State: AOAM532PLgikkmjMadrfaGo2HhmRRdQVyiK169eQewflygJqyqjZmUF4
        x9xhEmK8wocX7cvkIbU5AN/eXUUp/5v1ATLZuCzf0Q==
X-Google-Smtp-Source: ABdhPJwVHTz2zvTK0ayUxuiGwOqs9pIIC/w5dCvcb2CQUe352hz3nLfzoOWf5Dg7DKvOI2mQE9DiR//yb8ERcSUxlS4=
X-Received: by 2002:a2e:bf24:0:b0:246:801e:39d3 with SMTP id
 c36-20020a2ebf24000000b00246801e39d3mr8691548ljr.472.1646087723877; Mon, 28
 Feb 2022 14:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com> <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com>
In-Reply-To: <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Feb 2022 14:35:11 -0800
Message-ID: <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 27, 2022 at 11:37 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 2/25/22 12:47, Miguel Ojeda wrote:
> > On Fri, Feb 25, 2022 at 4:24 AM Dan Li <ashimida@linux.alibaba.com> wrote:
> >>
> >> +         - Clang (https://clang.llvm.org/docs/ShadowCallStack.html)
> >> +         - GCC (https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options)
> >
> > Maybe Clang: and GCC: instead of the parenthesis?
> >
> Got it.
>
> >> +#ifdef CONFIG_SHADOW_CALL_STACK
> >> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> >> +#endif
> >
> > Since both compilers have it, and I guess the `#ifdef` condition would
> > work for both, could this be moved into `compiler_types.h` where the
> > empty `__noscs` definition is, and remove the one from
> > `compiler-clang.h`?
> >
> In the clang documentation I see __has_feature(shadow_call_stack) is
> used to check if -fsanitize=shadow-call-stack is enabled, so I think
> maybe it's fine to use "#ifdef CONFIG_SHADOW_CALL_STACK"
> instead of "#if __has_attribute(__no_sanitize_address__)" here, then
> move it to `compiler_types.h`.

Or simply add a #define for __noscs to include/linux/compiler-gcc.h
with appropriate guard and leave the existing #ifndef in
include/linux/compiler_types.h as is.  I'd prefer that when the
compilers differ in terms of feature detection since it's as explicit
as possible.

>
> And from the results of my local clang 12 compilation, this doesn't
> seem to be a problem.
>
> Link: https://clang.llvm.org/docs/ShadowCallStack.html#has-feature-shadow-call-stack



-- 
Thanks,
~Nick Desaulniers
