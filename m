Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215DBC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DAB611CE
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 19:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhIJTG2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhIJTG2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 15:06:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2CC061757
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 12:05:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n2so6126354lfk.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=au3UJuAXsOBp2QIfYfO6rQxcEPY/9XDh+TQuvn9TJlE=;
        b=l6V0pRLB2h9Kyk9ZJGvZ1RhTj/V8OT617C35ohsJy8pAh9CoggGNiTetZTPuWPKNeH
         IhFZjkhYhpYEE/FQCPr4q5EQ9qB0QaqqLSlTOlHnPHB8TJmRK8vCtIEHn2Dr1US5aGAO
         K7sMIapzFKThAzrrT9GHey5auyrMmK9ziWjoupgnWNP1P4nWwRYz2WwPXOLP3yjP+hoG
         InhgmclhVFMzNwyaQ2n+qM5cpdk5nfk1Wp0CAvrrgLt7BvDHVSH19f6VRzWQPLBUWPnY
         Cl8Kik9k1jF/90Pth1pOquYmoO1hqgRZinzoeXklnqnhgpgeWtaDhlq0gGE4PhtSii++
         PqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=au3UJuAXsOBp2QIfYfO6rQxcEPY/9XDh+TQuvn9TJlE=;
        b=T1b1ZMxB0xJrfBCC5/OLWqfEqyN8kpvOfQyaYdfp3CEtW2FD+W1b+G3pKIclPtRfnw
         oWvHAhTK7qNWCmxWcv4B8Elb8MswA1sI+zTvgFoAPk74zjhWIVziM5b75XgswLtF8CsZ
         gybka7TGS7Vsw4QWvi/GsqdZQOA+pbwXytLH9CzZbuzCJi5kg1fBV+PxwuJ2SeP+mdtZ
         a0hvBxlczGrnT5JxB6EWOw3mCP076Tu3eSr6gNCOZSgy44l1r7qQY4msJDp9UvDVibwC
         cp2Ty+x3r/4qAMiOlQJ3TVu3a8rNi5eiZTUMsJwubWt2a5LdXklJhQ9SQsiqE8WZbfcK
         pgyQ==
X-Gm-Message-State: AOAM531wwNay8mn6Ct/pp05zOHJwxPKAEaVCmmdaY5qopWnwWeiZ4+FE
        9RWI65ATRLZbS24HwmLowkozjG2zFK5+JWp4qfFd2g==
X-Google-Smtp-Source: ABdhPJyHRLl11RnOuvc4WYrL69wHXY7G2D7NJ2kTDF21tHIMS83OwgEpKI0M3LFvWWV3BxJtFDRJieOEUwun8sHg03Y=
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mr5182680lfg.550.1631300714719;
 Fri, 10 Sep 2021 12:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210910165851.3296624-1-keescook@chromium.org>
In-Reply-To: <20210910165851.3296624-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Sep 2021 12:05:03 -0700
Message-ID: <CAKwvOdngxD7P=qEvGcFZXB7mZp+Ub8_Rp3V3nXq5uMEcsrUsGA@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Check GCC version for __alloc_size attribute
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 10, 2021 at 9:58 AM Kees Cook <keescook@chromium.org> wrote:
>
> Unfortunately, just version checking the use of -Wno-alloc-size-larger-than
> is not sufficient to make the __alloc_size attribute behave correctly
> under older GCC versions. The attribute itself must be disabled in those
> situations too, as there appears to be no way to reliably silence the
> SIZE_MAX constant expression cases for GCC versions less than 9.1:
>
> In file included from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/pci.h:40,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe.h:9,
>                  from drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:4:
> In function 'kmalloc_node',
>     inlined from 'ixgbe_alloc_q_vector' at ./include/linux/slab.h:743:9:
> ./include/linux/slab.h:618:9: error: argument 1 value '18446744073709551615' exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
>   return __kmalloc_node(size, flags, node);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/slab.h: In function 'ixgbe_alloc_q_vector':
> ./include/linux/slab.h:455:7: note: in a call to allocation function '__kmalloc_node' declared here
>  void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
>        ^~~~~~~~~~~~~~
>
> Specifically:
> -Wno-alloc-size-larger-than is not correctly handled by GCC < 9.1
>   https://godbolt.org/z/hqsfG7q84 (doesn't disable)

(heh, clang has had similar bugs with command line flags with `=` seperators)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Though some of the below examples don't make sense to me (the one
above is fine).

>   https://godbolt.org/z/P9jdrPTYh (doesn't admit to not knowing about option)

^ technically your first link demonstrates that. This link doesn't add
anything new and makes it look like there are more issues that there
are.

>   https://godbolt.org/z/465TPMWKb (only warns when other warnings appear)

^ this example doesn't make sense to me.  I couldn't reproduce what
you're describing.

>
> -Walloc-size-larger-than=18446744073709551615 is not handled by GCC < 8
>   https://godbolt.org/z/73hh1EPxz (ignores numeric value)

Should this be GCC < 8.2?


Some other feedback on the general use of godbolt.  Under Output,
please always disable Intel Asm Syntax; it causes me physical pain.
Also under output, usually disabling Execute the Output is what you
want, too.

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I've been digging through older GCC build logs and found this needed to
> be fixed even harder than prior attempts from what Randy had been seeing.
> ---
>  include/linux/compiler-gcc.h        | 9 +++++++++
>  include/linux/compiler_attributes.h | 6 ------
>  include/linux/compiler_types.h      | 5 +++++
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 01985821944b..ffe0a7570d66 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -151,3 +151,12 @@
>  #else
>  #define __diag_GCC_8(s)
>  #endif
> +
> +/*
> + * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> + * However, prior to 9.1, -Wno-alloc-size-larger-than does not work,
> + * making this attribute unusable.
> + */
> +#if GCC_VERSION < 90100
> +#define __alloc_size           /**/
> +#endif
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 19f178e20e61..2487be0e7199 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -53,12 +53,6 @@
>  #define __aligned(x)                    __attribute__((__aligned__(x)))
>  #define __aligned_largest               __attribute__((__aligned__))
>
> -/*
> - *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> - * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
> - */
> -#define __alloc_size(x, ...)           __attribute__((__alloc_size__(x, ## __VA_ARGS__)))
> -
>  /*
>   * Note: users of __always_inline currently do not write "inline" themselves,
>   * which seems to be required by gcc to apply the attribute according
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index c43308b0a9a9..91de9bead40d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -254,6 +254,11 @@ struct ftrace_likely_data {
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
>
> +/* If not specifically disabled, allow the use of __alloc_size attribute. */
> +#ifndef __alloc_size
> +# define __alloc_size(x, ...)          __attribute__((__alloc_size__(x, ## __VA_ARGS__)))
> +#endif
> +
>  #ifdef CONFIG_CC_HAS_ASM_INLINE
>  #define asm_inline asm __inline
>  #else
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
