Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14993C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Feb 2022 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiBYU6r (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiBYU6q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Feb 2022 15:58:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307565F5E
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 12:58:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m22so5868576pja.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 12:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4r5yQQaSHNhtmOiBULctLq+3TeXcmpwOyIGMdk0I96I=;
        b=Taz3yppnrjcQHhPnHEl7UUdtlx0jgYMFpWbKd+tV3RrrnvBwT1xoa10u3bcbY+aw6q
         DwKzJ2JGkJVhIloPapc+ROf5KCBXULCCXVMqBcS+KCN+55QjqkU+vJfFfdAboD0o3awb
         jdklXyAZBt17BLW+MYDdAmepIa20+pAuiKyak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4r5yQQaSHNhtmOiBULctLq+3TeXcmpwOyIGMdk0I96I=;
        b=YeCMYV8dhgQy41WjnioVqBK4yz+3ExkAM9hC7Ly45L5shiulFekkmplWGfnomVqqGB
         gML6mNRvaZ+9YlaxY++mMCMbq6+NREvAEeW/iKdK6wxGAgPoN16TjjY8AK70OuQbK74Q
         Bai9fd+xgogj+RcND9q892GeQrHKAWX+wX116sW8S5vRmi1cCR2sV8ViLIfbg28jXZHw
         QF8Exfit3rcJJRO2A7jdh2Hg7JGLdJWJuxx5VeaIoEd1Fw1L48wH4ezdBXooQbwCs5lp
         Edw2qPpY8Gp7F/oKkSsoN+uRz9eTC1/i5S8XdLiNF70unxBYb5+x4HGCQfqMZFtD0FXq
         8o4w==
X-Gm-Message-State: AOAM532SWHPbAU5zUIoGov5SuVH5L3BRbRUNh6dMPwIL6KJrTH7r3STo
        jY4stII2jBHzyYLRT3cENO+i5Q==
X-Google-Smtp-Source: ABdhPJxqsr/Hfxg8zFmOiWbGBJkTmn5pZSsYzzwU1SR6HN2kfda0SoNg5f0h4TsxbKYcDYo+pyky+Q==
X-Received: by 2002:a17:902:bf07:b0:150:9b8a:a14f with SMTP id bi7-20020a170902bf0700b001509b8aa14fmr4558946plb.127.1645822692580;
        Fri, 25 Feb 2022 12:58:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c19-20020a17090ab29300b001bc13b4bf91sm10093180pjr.43.2022.02.25.12.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:58:12 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:58:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, masahiroy@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        samitolvanen@google.com, npiggin@gmail.com, linux@roeck-us.net,
        mhiramat@kernel.org, ojeda@kernel.org, luc.vanoostenryck@gmail.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Message-ID: <202202251243.1E38256F9@keescook>
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225032410.25622-1-ashimida@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 24, 2022 at 07:24:10PM -0800, Dan Li wrote:
> Shadow call stacks will be available in GCC >= 12, this patch makes
> the corresponding kernel configuration available when compiling
> the kernel with the gcc.
> 
> Note that the implementation in GCC is slightly different from Clang.
> With SCS enabled, functions will only pop x30 once in the epilogue,
> like:
> 
>    str     x30, [x18], #8
>    stp     x29, x30, [sp, #-16]!
>    ......
> -  ldp     x29, x30, [sp], #16	  //clang
> +  ldr     x29, [sp], #16	  //GCC
>    ldr     x30, [x18, #-8]!
> 
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ce09ab17ddd21f73ff2caf6eec3b0ee9b0e1a11e
> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>

Thanks for the tweaks!

> ---
> FYI:
> This function can be used to test if the shadow call stack works:
> //noinline void __noscs scs_test(void)
> noinline void scs_test(void)
> {
>     unsigned long * lr = (unsigned long *)__builtin_frame_address(0) + 1;
> 
>     asm volatile("str xzr, [%0]\n\t": : "r"(lr) : "x30");
> }                                                         

Not a big deal, but just FYI, there's a lot of whitespace trailing the
"}" above...

> 
> ffff800008012770 <scs_test>:
> ffff800008012770:       d503245f        bti     c
> ffff800008012774:       d503233f        paciasp
> ffff800008012778:       f800865e        str     x30, [x18], #8
> ffff80000801277c:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
> ffff800008012780:       910003fd        mov     x29, sp
> ffff800008012784:       910023a0        add     x0, x29, #0x8
> ffff800008012788:       f900001f        str     xzr, [x0]
> ffff80000801278c:       f85f8e5e        ldr     x30, [x18, #-8]!
> ffff800008012790:       f84107fd        ldr     x29, [sp], #16
> ffff800008012794:       d50323bf        autiasp
> ffff800008012798:       d65f03c0        ret
> 
> If SCS protection is enabled, this function will return normally.
> If the function has __noscs attribute (scs disabled), it will crash due to 0
> address access.

It would be cool to turn this into an LKDTM test... (see things like the
CFI_FORWARD_PROTO test). I imagine this should be CFI_BACKWARD_SHADOW or
something...

Also, I assume you're using real hardware to test this? It'd be nice to
see if qemu can be convinced to run with the needed features. Whenever
I've tried this it becomes impossibly slow. :)

> 
>  arch/Kconfig                 | 19 ++++++++++---------
>  arch/arm64/Kconfig           |  2 +-
>  include/linux/compiler-gcc.h |  4 ++++
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..c92683362ac2 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -599,21 +599,22 @@ config STACKPROTECTOR_STRONG
>  config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	bool
>  	help
> -	  An architecture should select this if it supports Clang's Shadow
> -	  Call Stack and implements runtime support for shadow stack
> +	  An architecture should select this if it supports the compiler's
> +	  Shadow Call Stack and implements runtime support for shadow stack
>  	  switching.
>  
>  config SHADOW_CALL_STACK
> -	bool "Clang Shadow Call Stack"
> -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
> +	bool "Shadow Call Stack"
> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>  	help
> -	  This option enables Clang's Shadow Call Stack, which uses a
> -	  shadow stack to protect function return addresses from being
> -	  overwritten by an attacker. More information can be found in
> -	  Clang's documentation:
> +	  This option enables the compiler's Shadow Call Stack, which
> +	  uses a shadow stack to protect function return addresses from
> +	  being overwritten by an attacker. More information can be found
> +	  in the compiler's documentation:
>  
> -	    https://clang.llvm.org/docs/ShadowCallStack.html
> +	  - Clang (https://clang.llvm.org/docs/ShadowCallStack.html)
> +	  - GCC (https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options)
>  
>  	  Note that security guarantees in the kernel differ from the
>  	  ones documented for user space. The kernel must store addresses
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 09b885cc4db5..b7145337efae 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1255,7 +1255,7 @@ config HW_PERF_EVENTS
>  config ARCH_HAS_FILTER_PGPROT
>  	def_bool y
>  
> -# Supported by clang >= 7.0
> +# Supported by clang >= 7.0 or GCC >= 12.0.0
>  config CC_HAVE_SHADOW_CALL_STACK
>  	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
>  
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index ccbbd31b3aae..deff5b308470 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -97,6 +97,10 @@
>  #define KASAN_ABI_VERSION 4
>  #endif
>  
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> +#endif

I initially wondered if we need a separate __no_sanitize(STUFF) patch to
make the compiler-clang.h macros easier, but I see there are places
where we do multiple ("address", "hwaddress") and have specialized
macros, so I think this is fine. And since GCC doesn't support
"__has_feature", I think this is the correct location for this.

> +
>  #if __has_attribute(__no_sanitize_address__)
>  #define __no_sanitize_address __attribute__((no_sanitize_address))
>  #else
> -- 
> 2.17.1
> 

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
