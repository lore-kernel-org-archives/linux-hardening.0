Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A48601FF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhJMSEG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbhJMSEF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:04:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A90C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:02:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i24so14914579lfj.13
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXEMF9jddBl4hhPgEztfWgI/5rbtT2E/0qOGe0WIz2o=;
        b=LZM+FXsHA++ZuE1QesalkGBD5qQiNQhRqcE5eL3h5lzpj+VfVop+WkzA1fpkZLbJG2
         eRDHfA4z2qUQapbX4Ns3GdO4h/Y+oPmLO3uQ30X2tKzITY/OmqqAeDJkRTi2r4h4vFG+
         dAnZQ85jlLRCshR3vs8rZu05ve4oclIkzbAPPudCJuBrdH4psPZsbUkJ/awu967Mgslc
         3aqY8/ic9Bfi2YhLU+HcZt9kpBE6UNorS/9JquA3+oWJfVXkAaIhCMO3JVIjXhlifRGM
         Mn5/IW2LeHiQ/wuEbKK0vBr+e65zSpi/gs8+VVJeOFt9L8fxg7ckmnb6VZMH/qT35UVy
         vlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXEMF9jddBl4hhPgEztfWgI/5rbtT2E/0qOGe0WIz2o=;
        b=FMMa6i0kqdcdWZ6rwtNPhiltxf6i5YqXXTRi3iopaBFnugA+0R2wPcUWDXkdNk+wbq
         ifR9bgidON/Y++w76kdNTd6dRY/boc/OeHL5mYkf/WnIGACQoNwFukK/vrFhxpfOxq3A
         2H9km7820ykFjqdAUC7k/Qe7aEu1lcJi6AgwkPP1pk2/FqQKxBq0qsWGg2OH8MfTklNL
         ZIum6NI3T+ugj5aDtt1gGYgkD9lEfW2wYtq5Z7ORyiyd2U9NIHBJ0J1aIMhSODI/sPqG
         aMFVpCigLvvyxRfnDd/7rrls7yKoPEdfNS7gTV5sfJ1bSqw1yPR5g3z8DfpBdhBqP9/T
         TzBQ==
X-Gm-Message-State: AOAM533dcc98yw55J3nDdDvx6ptYHS1R+qgHDhjyX2fLHLFm32D+3le2
        E8jkMmpbYLg7fUnL3HdfcDmfHmZE5k61vPBtbL6OxA==
X-Google-Smtp-Source: ABdhPJylMON5l5bseh8pbsCQX9tadNqTljkobwM6wU0TX7nvQNE5ggOFSnvpO1pC0mpx+7ZDygMwwmHOIRygZF/t61I=
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr885886ljo.220.1634148115061;
 Wed, 13 Oct 2021 11:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211013152243.2216899-1-ardb@kernel.org>
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Oct 2021 11:01:43 -0700
Message-ID: <CAKwvOdkS1LuEEXOAUCDNBWJBbo-GPisf0s-BtL119Kfi7084kA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] arm64: use unwind data on GCC for shadow call stack
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 8:22 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This series is a proof of concept implementation of using unwind tables
> to locate PACIASP/AUTIASP instructions in the code, and patching them
> into shadow call stack pushes/pops at boot time if the platform in
> question does not support pointer authentication in hardware. This way,
> the overhead of the shadow call stack is only imposed if it actually
> gives any benefit. It also means that the compiler does not need to
> generate the code, so this works with GCC as well.
>
> In fact, it only works with GCC at the moment, as Clang does not seem to
> implement the DW_CFA_negate_ra_state correctly, which is emitted after
> each PACIASP or AUTIASP instruction (Clang only does the former).
> However, GCC does not appear to get it quite right either, as it emits
> the directive in the wrong place in some cases (but in a way that can be
> worked around).

Can we work on getting bug reports to the compiler vendors? Then we
can have something free of workarounds, and more toolchain portable.

>
> Note that this only implements it for the core kernel. Modules should be
> straight-forward, and most of the code can be reused. Also, the
> transformation is applied unconditionally, even if the hardware does
> implement PAC, but this does not really matter for a PoC.
>
> One obvious downside is the size of the unwind tables (3 MiB for
> defconfig), although there are plenty of use cases where this does not
> really matters (and I haven't checked the compressed size). However,
> there may be other reasons why we'd want to have access to these unwind
> tables (reliable stack traces), so this will need to be discussed before
> I intend to take this any further.
>
> Cc: Kees Cook <keescook@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Dan Li <ashimida@linux.alibaba.com>
>
> Ard Biesheuvel (9):
>   arm64: assembler: enable PAC for non-leaf assembler routines
>   arm64: cache: use ALIAS version of linkage macros for local aliases
>   arm64: crypto: avoid overlapping linkage definitions for AES-CBC
>   arm64: aes-neonbs: move frame pop to end of function
>   arm64: chacha-neon: move frame pop forward
>   arm64: smccc: create proper stack frames for HVC/SMC calls
>   arm64: assembler: add unwind annotations to frame push/pop macros
>   arm64: unwind: add asynchronous unwind tables to the kernel proper
>   arm64: implement dynamic shadow call stack for GCC
>
>  Makefile                              |   4 +-
>  arch/Kconfig                          |   4 +-
>  arch/arm64/Kconfig                    |  11 +-
>  arch/arm64/Makefile                   |   7 +-
>  arch/arm64/crypto/aes-modes.S         |   4 +-
>  arch/arm64/crypto/aes-neonbs-core.S   |   8 +-
>  arch/arm64/crypto/chacha-neon-core.S  |   9 +-
>  arch/arm64/include/asm/assembler.h    |  32 ++-
>  arch/arm64/include/asm/linkage.h      |  16 +-
>  arch/arm64/kernel/Makefile            |   2 +
>  arch/arm64/kernel/head.S              |   3 +
>  arch/arm64/kernel/patch-scs.c         | 223 ++++++++++++++++++++
>  arch/arm64/kernel/smccc-call.S        |  40 ++--
>  arch/arm64/kernel/vmlinux.lds.S       |  20 ++
>  arch/arm64/mm/cache.S                 |   8 +-
>  drivers/firmware/efi/libstub/Makefile |   1 +
>  16 files changed, 347 insertions(+), 45 deletions(-)
>  create mode 100644 arch/arm64/kernel/patch-scs.c
>
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
