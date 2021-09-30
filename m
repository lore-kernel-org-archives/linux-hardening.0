Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EE1C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1A61216
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbhI3SwJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbhI3SwJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:52:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C0C06176A
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:50:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b20so29596187lfv.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWitM0oBtgSbSNuh7FbCHTwd99GX2nX2dA9XhUdlU74=;
        b=ZLG63FktyWv+RybYSzSL2qFeCGnsmrIHsRTZUACIK8vDatq78aNZkLrK+f9NlgqAvS
         Jx9Za1sjvTL049HkZU/eK3R5OupW5tioTG5LZtB8py2mcA8e3c3sj0T3ikB6HDK3gIYL
         8SDHIAqURPBfbgjh+tLWK3oECM35mmTggEOr4tBGKzzmVEYcjFUZWNk/dyYD05qD15bz
         c4bEx6J9ZVanUQLA1BeWCIbR8lu8JO2HOnxpU9lj9ZGwhpRKDJTBEPr80gkQrIbb1rM4
         IMYCDsmv9rde7lC5agMhnn3P+uCT4njA59H3Sg1TNHxl0CLMHpF8Ef8LbpW8/kUS3xA3
         lyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWitM0oBtgSbSNuh7FbCHTwd99GX2nX2dA9XhUdlU74=;
        b=cPc7JheFUyxAjjrAV82ACtJcTVGOD4XnH2ybWfJe1HH9cDOnTnNkjUK+KlYrKPbPL6
         utVFHu/dloFU2FH3G60JbosjncZ1P5lP5grWwedaDoXXJrinpst2kxsluWYjzic7fPnW
         Vnp8vY9/8Jo6CKmcleplw5GNWUDQdjRr77nX+n3AeZBPXM9591b87fRBYlEwQ0YyblZL
         NcAq1O3rHOgAKmX79TKeLuy5hyCvmvyg5d7eqZqRxMobTT930aAdY+OMBcIizbGTjZkc
         xv3uGAatItbFmn5Olx+MYanpHdG28dCKI/xRbFf3LDz+ePZAWUKUKdYsAMHhfDJxyHeM
         O7Vg==
X-Gm-Message-State: AOAM533IIto6/VpBdePFE6k0VseDTc53cNAvL8RrhOmva42liNW09qXC
        teTmsEvOrlOVS2N3wz5sxL2z2PORgBScn3Z0AD0MlA==
X-Google-Smtp-Source: ABdhPJz3Bn8rJGaOZV5Vj0101XSEKUvm4JuxzRUyshaM+ETq3KaK35bLzMTRK/Wg2lD/B2CKh+0M11TwPBvY7oDPV4c=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr692891lfv.651.1633027824058;
 Thu, 30 Sep 2021 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20210930180531.1190642-5-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-5-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 11:50:13 -0700
Message-ID: <CAKwvOdnN-5PBnegEpb4eq3uPWezmAO6Zrvy3O7zyCNEBFvYt4A@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
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
> This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> which defines a stub function that immediately returns and when
> defined in the core kernel, always passes indirect call checking
> with CONFIG_CFI_CLANG. Note that this macro should only be used when
> a stub cannot be called using the correct function type.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Seems like the only use is in patch 5/15. Probably could be squashed...

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>  include/linux/cfi.h               | 13 +++++++++++++
>  kernel/cfi.c                      | 24 +++++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f2984af2b85b..5b77284f7221 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -407,6 +407,16 @@
>         KEEP(*(.static_call_tramp_key))                                 \
>         __stop_static_call_tramp_key = .;
>
> +#ifdef CONFIG_CFI_CLANG
> +#define CFI_EXCLUDED_DATA                                              \
> +       . = ALIGN(8);                                                   \
> +       __start_cfi_excluded = .;                                       \
> +       KEEP(*(.cfi_excluded_stubs))                                    \
> +       __stop_cfi_excluded = .;
> +#else
> +#define CFI_EXCLUDED_DATA
> +#endif
> +
>  /*
>   * Allow architectures to handle ro_after_init data on their
>   * own by defining an empty RO_AFTER_INIT_DATA.
> @@ -430,6 +440,7 @@
>                 __start_rodata = .;                                     \
>                 *(.rodata) *(.rodata.*)                                 \
>                 SCHED_DATA                                              \
> +               CFI_EXCLUDED_DATA                                       \
>                 RO_AFTER_INIT_DATA      /* Read only after init */      \
>                 . = ALIGN(8);                                           \
>                 __start___tracepoints_ptrs = .;                         \
> diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> index 879744aaa6e0..19f74af8eac2 100644
> --- a/include/linux/cfi.h
> +++ b/include/linux/cfi.h
> @@ -20,6 +20,17 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
>  #define __CFI_ADDRESSABLE(fn, __attr) \
>         const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
>
> +/*
> + * Defines a stub function that returns immediately, and when defined and
> + * referenced in the core kernel, always passes CFI checking. This should
> + * be used only for stubs that cannot be called using the correct function
> + * pointer type, which should be rare.
> + */
> +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> +       void fn(void) { return; } \
> +       const void *__cfi_excl_ ## fn __visible \
> +               __section(".cfi_excluded_stubs") = (void *)&fn
> +
>  #ifdef CONFIG_CFI_CLANG_SHADOW
>
>  extern void cfi_module_add(struct module *mod, unsigned long base_addr);
> @@ -35,6 +46,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
>  #else /* !CONFIG_CFI_CLANG */
>
>  #define __CFI_ADDRESSABLE(fn, __attr)
> +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> +       void fn(void) { return; }
>
>  #endif /* CONFIG_CFI_CLANG */
>
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 9594cfd1cf2c..8d931089141b 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -278,12 +278,34 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
>         return fn;
>  }
>
> +extern unsigned long __start_cfi_excluded[];
> +extern unsigned long __stop_cfi_excluded[];
> +
> +static inline bool is_cfi_excluded(unsigned long ptr)
> +{
> +       unsigned long *p = __start_cfi_excluded;
> +
> +       for ( ; p < __stop_cfi_excluded; ++p)
> +               if (*p == ptr)
> +                       return true;
> +
> +       return false;
> +}
> +
> +static void __cfi_pass(uint64_t id, void *ptr, void *diag)
> +{
> +}
> +
>  static inline cfi_check_fn find_check_fn(unsigned long ptr)
>  {
>         cfi_check_fn fn = NULL;
>
> -       if (is_kernel_text(ptr))
> +       if (is_kernel_text(ptr)) {
> +               if (unlikely(is_cfi_excluded(ptr)))
> +                       return __cfi_pass;
> +
>                 return __cfi_check;
> +       }
>
>         /*
>          * Indirect call checks can happen when RCU is not watching. Both
> --
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
