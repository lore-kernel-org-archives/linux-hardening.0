Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C295C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A72C6136F
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJUQgd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhJUQgd (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 12:36:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 577786136F
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634834057;
        bh=LZ+uA5pCSUMB6dfDokrurAzOju3Xz27QuVlhjKz9SDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pf309XVsO/Bn77QsnXcg0iwIl8s3c1Ix6/hNCNjPgKFhfTKj591L//gTMhbFHAjJO
         4gHDcqzdk73fYVWrkvF2pcdARPM+eJ4njckaWFwrlZPq7UM8fIk8RLCdUAGr12R9/x
         5CLK42603/w7IlDgTdhegPjoer1JIiONOHVDRc35U8aPNYQYBFFTgqXnqCmlLVPLyu
         U7oa84AV8kGgntH7qMPz4vJkJ8vkvlQ6Ur0wpiLnVtO+Tkr13AQzOyL/wZqLWrEaq4
         +M7ein+VtfyYJ8k66dgRaObzXQf4X+l6NyUilT6tegvpvEkX6XyLxYc6jcP1ooZEAX
         ulydPe6iGEUbA==
Received: by mail-ot1-f50.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so1057223otq.12
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 09:34:17 -0700 (PDT)
X-Gm-Message-State: AOAM532sjI9paCZnCp70FoTCmWPWtK56F9qIkIyp4NwGlA00Er6AXSFX
        kPYG2TuvKKHrYP6U57rqV2WiJTuiLruY+XRM5xY=
X-Google-Smtp-Source: ABdhPJyzuP5vmpBAMoF9zy3hfhWYj3Xo7Zsema1tmEXJJ9yYTkvx7X3hCRITmGheo/6mKdnUUUi4kMF71IwBSEamJCQ=
X-Received: by 2002:a05:6830:1018:: with SMTP id a24mr5840484otp.112.1634834056662;
 Thu, 21 Oct 2021 09:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211021102327.1415789-1-ardb@kernel.org>
In-Reply-To: <20211021102327.1415789-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Oct 2021 18:34:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEPRro8LeLhX46VHhbhoytzhu5tpW3T4Tjq5ya1GPOB4g@mail.gmail.com>
Message-ID: <CAMj1kXEPRro8LeLhX46VHhbhoytzhu5tpW3T4Tjq5ya1GPOB4g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] implement TLS register based stack canary for ARM
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, thomas.preudhomme@celest.fr,
        adhemerval.zanella@linaro.org, Qing Zhao <qing.zhao@oracle.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 21 Oct 2021 at 12:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102352
>
> In the Linux kernel, user processes calling into the kernel are
> essentially threads running in the same address space, of a program that
> never terminates. This means that using a global variable for the stack
> protector canary value is problematic on SMP systems, as we can never
> change it unless we reboot the system. (Processes that sleep for any
> reason will do so on a call into the kernel, which means that there will
> always be live kernel stack frames carrying copies of the canary taken
> when the function was entered)
>
> AArch64 implements -mstack-protector-guard=sysreg for this purpose, as
> this permits the kernel to use different memory addresses for the stack
> canary for each CPU, and context switch the chosen system register with
> the rest of the process, allowing each process to use its own unique
> value for the stack canary.
>
> This patch implements something similar, but for the 32-bit ARM kernel,
> which will start using the user space TLS register TPIDRURO to index
> per-process metadata while running in the kernel. This means we can just
> add an offset to TPIDRURO to obtain the address from which to load the
> canary value.
>
> The patch is a bit rough around the edges, but produces the correct
> results as far as I can tell.

This is a lie

> However, I couldn't quite figure out how
> to modify the patterns so that the offset will be moved into the
> immediate offset field of the LDR instructions, so currently, the ADD of
> the offset is always a distinct instruction.
>

... and this is no longer true now that I fixed the correctness
problem. I will be sending out a v2 shortly, so please disregard this
one for now.


> As for the spilling issues that have been fixed in this code in the
> past: I suppose a register carrying the TLS register value will never
> get spilled to begin with? How about a register that carries TLS+<n>?
>
> Comments/suggestions welcome.
>
> Cc: thomas.preudhomme@celest.fr
> Cc: adhemerval.zanella@linaro.org
> Cc: Qing Zhao <qing.zhao@oracle.com>
> Cc: Richard Sandiford <richard.sandiford@arm.com>
> Cc: gcc-patches@gcc.gnu.org
>
> Ard Biesheuvel (1):
>   [ARM] Add support for TLS register based stack protector canary access
>
>  gcc/config/arm/arm-opts.h |  6 +++
>  gcc/config/arm/arm.c      | 39 +++++++++++++++++
>  gcc/config/arm/arm.md     | 44 ++++++++++++++++++--
>  gcc/config/arm/arm.opt    | 22 ++++++++++
>  gcc/doc/invoke.texi       |  9 ++++
>  5 files changed, 116 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>
> $ cat |arm-linux-gnueabihf-gcc -march=armv7-a -mstack-protector-guard=tls -mstack-protector-guard-offset=10 -mtp=cp15 -S -o - -xc - -fstack-protector-all -O3
> int foo(void *);
> int bar(void)
> {
>
>         return foo(__builtin_thread_pointer()) + 1;
> }
>         .arch armv7-a
>         .fpu softvfp
>         .eabi_attribute 20, 1
>         .eabi_attribute 21, 1
>         .eabi_attribute 23, 3
>         .eabi_attribute 24, 1
>         .eabi_attribute 25, 1
>         .eabi_attribute 26, 2
>         .eabi_attribute 30, 2
>         .eabi_attribute 34, 1
>         .eabi_attribute 18, 4
>         .file   "<stdin>"
>         .text
>         .align  2
>         .global bar
>         .syntax unified
>         .arm
>         .type   bar, %function
> bar:
>         @ args = 0, pretend = 0, frame = 8
>         @ frame_needed = 0, uses_anonymous_args = 0
>         push    {r4, lr}
>         mrc     p15, 0, r4, c13, c0, 3  @ load_tp_hard
>         add     r3, r4, #10
>         sub     sp, sp, #8
>         mov     r0, r4
>         add     r4, r4, #10
>         ldr     r3, [r3]
>         str     r3, [sp, #4]
>         mov     r3, #0
>         bl      foo
>         ldr     r3, [r4]
>         ldr     r4, [sp, #4]
>         eors    r3, r4, r3
>         mov     r4, #0
>         bne     .L5
>         add     r0, r0, #1
>         add     sp, sp, #8
>         @ sp needed
>         pop     {r4, pc}
> .L5:
>         bl      __stack_chk_fail
>         .size   bar, .-bar
>         .ident  "GCC: (GNU) 12.0.0 20211019 (experimental)"
>         .section        .note.GNU-stack,"",%progbits
>
