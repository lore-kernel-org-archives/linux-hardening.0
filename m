Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF4C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B99619EB
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhI3Skj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhI3Skj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:40:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99EC06176C
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:38:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so28754945lfa.9
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlIko8aPk3VVcvZPvZ8HxhCUc+6fNRzNwVLsaCQfzA0=;
        b=WAb7E5lqBsCk+wqY0InBUtLXN8Amgkchb7ntGxro9rqclov2ntOg/znlDZoAD3QpeJ
         PNJ2C5mQaoHOH2hwTzWp7QkO6T/GUCl5nqMT2FlkBRsahNaOnpQ052fPxodyIJF6QkGV
         VrHcCddBwZUCpM8lAmtxjaG+o+gr8FJTPWznJ5UsN+EHLqG3K5GZnDs5tlkoc27h8KSS
         e6ryLYzWlZ2f508f6M0DZRK3AwDDPJZl3Xhi15WGEU/b5CbpaRkdlsFto57lMNBp7q5X
         cSukOzIh5RDmX8RHj5FrG+jxumzraA+PSe+y5Dyv6TaU10IpsgIaCUUp4rIajc25hQ+n
         SUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlIko8aPk3VVcvZPvZ8HxhCUc+6fNRzNwVLsaCQfzA0=;
        b=sf2re86G7/KurD5qkei6ootR+L8wxRsJlYfwgmFyRzw4Gshb1Wr3BDv2GFagg5tEFe
         qBvXEJWEeGFvyDibuOa8YiDkj0GmjUasJuDasYJGORMBdQQPsipfknj3B47eBSozOqIx
         a27Vk8D6FbpGpxwoQPpj1kpAS7njED3fyq16KPOnuC3gUAq0UG3NCw+nC47vQnlBSTfw
         28zwH8fb5nGC0zqCwh0JK7uoMrXuKWeJfx3ajZvNMPEGyi7EwLAmzTVuUngTjGObFuZ+
         FB808r4ipVMjwT7HhDhwQ9D2UPd9n4iKkuAaz9EUM048bYub694PmsEucapyUZiMFEuq
         t+SQ==
X-Gm-Message-State: AOAM5322PUGw/Ee6htlHX+1RzUbqokWHN0BY/0z1XoGXmtL/CoAxHgqI
        f78VrLe+itaWac5N5pbWZji14T7lKNHrFvZcx6kLlg==
X-Google-Smtp-Source: ABdhPJy0gPE9CQiHSNP8VNq9U4LTVmnRr8cYd4pty4EITEWHI6OdV74ixxCAB4NExFgWixc8PnfPOQmC2BjjPEtugyU=
X-Received: by 2002:a2e:5059:: with SMTP id v25mr7504943ljd.128.1633027134353;
 Thu, 30 Sep 2021 11:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 11:38:43 -0700
Message-ID: <CAKwvOdkmbW9dUqDiziC3mwRiJ5bGXr+wuOkJjeCwTddq_F9TAw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] x86: Add support for Clang CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
>
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
>
> Note that v4 is based on tip/master. The first two patches contain
> objtool support for CFI, the remaining patches change function
> declarations to use opaque types, fix type mismatch issues that
> confuse the compiler, and disable CFI where it can't be used.
>
> You can also pull this series from
>
>   https://github.com/samitolvanen/linux.git x86-cfi-v4

I tested this series with near ToT clang with CONFIG_LTO_CLANG_THIN=y
and our small buildroot-based userspace image in QEMU, then again with
CONFIG_LTO_CLANG_FULL=y. No new warnings from objtool, everything
seemed fine.  FWIW,

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> ---
> Changes in v4:
> - Dropped the extable patch after the code was refactored in -tip.
>
> - Switched to __section() instead of open-coding the attribute.
>
> - Added an explicit ifdef for filtering out CC_FLAGS_CFI in
>   purgatory for readability.
>
> - Added a comment to arch_cfi_jump_reloc_offset() in objtool.
>
> Changes in v3:
> - Dropped Clang requirement to >= 13 after the missing compiler
>   fix was backported there.
>
> - Added DEFINE_CFI_IMMEDIATE_RETURN_STUB to address the issue
>   with tp_stub_func in kernel/tracepoint.c.
>
> - Renamed asm_func_t to asm_func_ptr.
>
> - Changed extable handlers to use __cficanonical instead of
>   disabling CFI for fixup_exception.
>
> Changes in v2:
> - Dropped the first objtool patch as the warnings were fixed in
>   separate patches.
>
> - Changed fix_cfi_relocs() in objtool to not rely on jump table
>   symbols, and to return an error if it can't find a relocation.
>
> - Fixed a build issue with ASM_STACK_FRAME_NON_STANDARD().
>
> - Dropped workarounds for inline assembly references to
>   address-taken static functions with CFI as this was fixed in
>   the compiler.
>
> - Changed the C declarations of non-callable functions to use
>   opaque types and dropped the function_nocfi() patches.
>
> - Changed ARCH_SUPPORTS_CFI_CLANG to depend on Clang >=14 for
>   the compiler fixes.
>
>
> Kees Cook (1):
>   x86, relocs: Ignore __typeid__ relocations
>
> Sami Tolvanen (14):
>   objtool: Add CONFIG_CFI_CLANG support
>   objtool: Add ASM_STACK_FRAME_NON_STANDARD
>   linkage: Add DECLARE_ASM_FUNC_SYMBOL
>   cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
>   tracepoint: Exclude tp_stub_func from CFI checking
>   ftrace: Use an opaque type for functions not callable from C
>   lkdtm: Disable UNSET_SMEP with CFI
>   lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
>   x86: Use an opaque type for functions not callable from C
>   x86/purgatory: Disable CFI
>   x86, module: Ignore __typeid__ relocations
>   x86, cpu: Use LTO for cpu.c with CFI
>   x86, kprobes: Fix optprobe_template_func type mismatch
>   x86, build: Allow CONFIG_CFI_CLANG to be selected
>
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/include/asm/ftrace.h         |  2 +-
>  arch/x86/include/asm/idtentry.h       | 10 +++---
>  arch/x86/include/asm/page_64.h        |  7 ++--
>  arch/x86/include/asm/paravirt_types.h |  3 +-
>  arch/x86/include/asm/processor.h      |  2 +-
>  arch/x86/include/asm/proto.h          | 25 ++++++-------
>  arch/x86/include/asm/uaccess_64.h     |  9 ++---
>  arch/x86/kernel/alternative.c         |  2 +-
>  arch/x86/kernel/ftrace.c              |  2 +-
>  arch/x86/kernel/kprobes/opt.c         |  4 +--
>  arch/x86/kernel/module.c              |  4 +++
>  arch/x86/kernel/paravirt.c            |  4 +--
>  arch/x86/kvm/emulate.c                |  4 +--
>  arch/x86/kvm/kvm_emulate.h            |  9 ++---
>  arch/x86/power/Makefile               |  2 ++
>  arch/x86/purgatory/Makefile           |  4 +++
>  arch/x86/tools/relocs.c               |  7 ++++
>  arch/x86/xen/enlighten_pv.c           |  6 ++--
>  arch/x86/xen/xen-ops.h                | 10 +++---
>  drivers/misc/lkdtm/bugs.c             |  2 +-
>  drivers/misc/lkdtm/lkdtm.h            |  2 +-
>  drivers/misc/lkdtm/perms.c            |  2 +-
>  drivers/misc/lkdtm/rodata.c           |  2 +-
>  include/asm-generic/vmlinux.lds.h     | 11 ++++++
>  include/linux/cfi.h                   | 13 +++++++
>  include/linux/ftrace.h                |  7 ++--
>  include/linux/linkage.h               | 13 +++++++
>  include/linux/objtool.h               |  6 ++++
>  kernel/cfi.c                          | 24 ++++++++++++-
>  kernel/tracepoint.c                   |  5 +--
>  tools/include/linux/objtool.h         |  6 ++++
>  tools/objtool/arch/x86/decode.c       | 17 +++++++++
>  tools/objtool/elf.c                   | 51 +++++++++++++++++++++++++++
>  tools/objtool/include/objtool/arch.h  |  3 ++
>  tools/objtool/include/objtool/elf.h   |  2 +-
>  36 files changed, 217 insertions(+), 66 deletions(-)
>
>
> base-commit: d4bfebd9ef497ee0afb498f6028a5074a6ccf307
> --
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
