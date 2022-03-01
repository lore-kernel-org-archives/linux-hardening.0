Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443CEC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Mar 2022 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiCAUMz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCAUMz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Mar 2022 15:12:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939115A0C
        for <linux-hardening@vger.kernel.org>; Tue,  1 Mar 2022 12:12:13 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e8so23417307ljj.2
        for <linux-hardening@vger.kernel.org>; Tue, 01 Mar 2022 12:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNDp5KXCKeop2yOo8l/8mrZzIPAvGyioW/V2tn2igq8=;
        b=EO9u4Ku7uUzMJhGxZnToQLWVHSB4bnEI2drfTxCzPLe+5ic0u1rMguA3h3bRxU3eoh
         cReVFeLfqv41v3lc3J6nFr4/J+1SwXrqJO18UMmVGOpbxSQmHTbbCyTGYJZ4YXf3+CHs
         6Q7ScdzXZfZmWBKeHWAN1Zbjq5xv2bsu4AH5cQ4cimtfCgojo1pUQQ5M7SgiGwsBydVB
         htmv4EdHl2zD6o3DLHcOUsoVrhimoKH+6sblZoGinbMC61wo3YF6n7Wl94kvm2SRe+Ri
         UwehA2XtceHZx+OtpmA9bfvtnAah569VEqFNIO9b8S3mNUPxDnikkXHpSJk+jSXWArcZ
         +FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNDp5KXCKeop2yOo8l/8mrZzIPAvGyioW/V2tn2igq8=;
        b=INjxp+dgnRooAs2myxmvvoVcU+ru2xX3lRZMSqmXphQrhyvPuWTzevdyzPwjuLPYZa
         cxFJjgyiSh74qVEcASMRx/SoG84ny5XHnmQGjNi1GD1JElnSA8QM4rtACT9/Rod6zVxh
         2hA/AdIPLfE05QTFEwoPxiRS4DrW66e2i/vZ5s75UcnMXOzA8+i5vNYoOXWeSEGf8gqW
         iC57a1tuoCULXlfV9sNXrKGZovtN003hbFCRcTSZLBC2a+0fm4pHjQzTvifpWH6hVHDH
         e8apCReXu4ru/hgnLXMErS+Yt1/xYFJyLWcN9CZttk5Ie0U7BVZC6AJZAijVDlzeUdyP
         yhcQ==
X-Gm-Message-State: AOAM530953RgbRNaP69h2ANZV/ZW0DdAERyd9cMAvjzDE89zHjre7YrS
        qKdsCOZ6RS4GCjNXgthLgXMb86Jg7fnSvUAnMAzZTA==
X-Google-Smtp-Source: ABdhPJxFT25RN4upV+eC9mqObTsE3rwkSU3a9SxEuU0pbBYsUXuPSAtJL86l5x1ByKd9eTwBOET3LqI2vtpo2CE6jm8=
X-Received: by 2002:a05:651c:1791:b0:243:94bd:d94c with SMTP id
 bn17-20020a05651c179100b0024394bdd94cmr17832518ljb.468.1646165531034; Tue, 01
 Mar 2022 12:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
 <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com> <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
 <bf34b523-8477-c18c-e076-e120051cb6a1@linux.alibaba.com>
In-Reply-To: <bf34b523-8477-c18c-e076-e120051cb6a1@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Mar 2022 12:11:59 -0800
Message-ID: <CAKwvOd=6atvH9fJk0jJcqksSQXZ6wFyAvZ1wsZ7UWsEN-soOTg@mail.gmail.com>
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

On Mon, Feb 28, 2022 at 4:32 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 2/28/22 14:35, Nick Desaulniers wrote:
> > On Sun, Feb 27, 2022 at 11:37 PM Dan Li <ashimida@linux.alibaba.com> wrote:
> >>>> +#ifdef CONFIG_SHADOW_CALL_STACK
> >>>> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> >>>> +#endif
> >>>
> >>> Since both compilers have it, and I guess the `#ifdef` condition would
> >>> work for both, could this be moved into `compiler_types.h` where the
> >>> empty `__noscs` definition is, and remove the one from
> >>> `compiler-clang.h`?
> >>>
> >> In the clang documentation I see __has_feature(shadow_call_stack) is
> >> used to check if -fsanitize=shadow-call-stack is enabled, so I think
> >> maybe it's fine to use "#ifdef CONFIG_SHADOW_CALL_STACK"
> >> instead of "#if __has_attribute(__no_sanitize_address__)" here, then
> >> move it to `compiler_types.h`.
> >
> > Or simply add a #define for __noscs to include/linux/compiler-gcc.h
> > with appropriate guard and leave the existing #ifndef in
> > include/linux/compiler_types.h as is.  I'd prefer that when the
> > compilers differ in terms of feature detection since it's as explicit
> > as possible.
> >
>
> To make sure I understand correctly, that means I should keep
> the current patch unchanged right?

Yes.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
