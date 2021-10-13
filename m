Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6140C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F526113D
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhJMRzO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhJMRzN (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 13:55:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C8CE61139
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634147590;
        bh=bg4eQMSYTVjgOi7gDOpvfbv+2tkdNKMHGQe8r5tgt2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ltz07qEP3MWnq/VS415PtXV7zM+Hdgb6MU7/99qiYS9vKhGE9lDcGxHmx9n/Y4QX1
         qW+elox7pXCPJ4xL/iuYgdGkMtJkJJ7zbDY1e7xNdB7UsXlcwLiU44vS7uAWeL6oXn
         8bddrBy/TxEcYNmJFTFrjyO/PSr/vQRNtw6WS9ivEOTY7m1rgKioOAguPm/Unryaud
         A00+0yRQLVTWT2+BT4iCHfB/UYVf5P1ujQCryyvdMkVLrbtj/7BMB40NEyzJScQx8q
         dQES+nfnGau9/Xzow9LJKh3NK9M2/OPFprBJAmPpfB2KEpS75JCbfkn9mm9HoK6DOr
         xsk0h+AJ01FZg==
Received: by mail-oi1-f174.google.com with SMTP id o204so4840423oih.13
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:53:10 -0700 (PDT)
X-Gm-Message-State: AOAM530qy3oma85HmPc7sltSRX8sHHz2kYwKcQp/dlRgaNj1uLGyco7A
        JIzJlsQvdlcbiD5HZ6v70vdz0DvMK71izjrHzaA=
X-Google-Smtp-Source: ABdhPJzim2NCcO+mHPgELqoNVBsCPSNa0JcBsYXpMGjp5agu5hAFKcQ0tflxFfNNj3dna+jXZnI4/z8kGnehxQcV/AA=
X-Received: by 2002:aca:32c2:: with SMTP id y185mr9282719oiy.47.1634147589469;
 Wed, 13 Oct 2021 10:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211013152243.2216899-1-ardb@kernel.org>
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Oct 2021 19:52:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuKStReBFT46w4UUmW2vK8C3VHTQnrUJRRa4SdPLtuyQ@mail.gmail.com>
Message-ID: <CAMj1kXEuKStReBFT46w4UUmW2vK8C3VHTQnrUJRRa4SdPLtuyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] arm64: use unwind data on GCC for shadow call stack
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dan Li <ashimida@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 13 Oct 2021 at 17:22, Ard Biesheuvel <ardb@kernel.org> wrote:
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

Apologies - i failed to pass --cc-cover so the cc'ees above have only
received this cover letter.

The lore thread is here:
https://lore.kernel.org/r/20211013152243.2216899-1-ardb@kernel.org/


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
