Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E978C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiENWDA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiENWC6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 18:02:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61C1838E
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 15:02:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l11so10671868pgt.13
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zzwdQrYIZGbhuKxn6txtvucH/uZdk818++RBQ6GUaIw=;
        b=PxaWEdjbiW3JJXRUQ37LWZGFGOX28YHe5IpymM9E99ZFyLMgSvUA3NBHsZObvhXgFf
         2rSt5fPeIJL4ESJKx0qQpcgg/M9mCP/rqQ0EpVAzLrP45fXGzYzDvoJcilx+iH6k2PKL
         O9RY0oKUBzUCas2uurOWQcA3eKgqRAdDanq50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zzwdQrYIZGbhuKxn6txtvucH/uZdk818++RBQ6GUaIw=;
        b=jyTvk+UYvsh0bVjnyWrmdBvoeks4sQgzxiPgzIHpTfIbuF70DH3E9PWdbAR/a3WY6O
         rr47k3sn2gW6zJaqZd68q/KT2iAS29mrKqkFxE7/pr1aap6Rr39KJUCtFLBtYTMnAJHu
         nDw9Fnuy9qup8IigTNK9OuyiuZ4C5+/BNgH96yjT5iOhIYz8o2f6V0iJrzy0h4mxsMi5
         5gvuKJFql8tU2E9+xvuqTtxkLNcBItEYIYCkQecqmfrZtjZGhdG/eIOVL/8ankXN7Vgo
         TSXuxnp95w8ydyjk9x4oCfo711mFEBWT2zjqeOz2+DFLtAf5vUmoKNKg9o0kQF2cFMfC
         TARw==
X-Gm-Message-State: AOAM532inAmN7draFBOIEQxwf8dtqlcD2GzqBihQPJYaxlVXQ7qnFwub
        dmiy/wxCwNvxM8zl3OLW+BZk2SnM0rIc1w==
X-Google-Smtp-Source: ABdhPJyVRydg9q5jS2e39x/pb7g7MLyUIeUrS1+CgeSiKUxdoQuQFP8o17cuLiwbXArXOMToLiZy9A==
X-Received: by 2002:a63:561c:0:b0:3c1:42fb:cd81 with SMTP id k28-20020a63561c000000b003c142fbcd81mr9701649pgb.104.1652565777327;
        Sat, 14 May 2022 15:02:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p25-20020a62b819000000b0050dc7628182sm4169865pfe.92.2022.05.14.15.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 15:02:57 -0700 (PDT)
Date:   Sat, 14 May 2022 15:02:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <202205141501.92A22264B4@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513202159.1550547-21-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler injects a type preamble
> immediately before each function and a check to validate the target
> function type before indirect calls:
> 
>   ; type preamble
>   __cfi_function:
>     int3
>     int3
>     mov <id>, %eax
>     int3
>     int3
>   function:
>     ...
>   ; indirect call check
>     cmpl    <id>, -6(%r11)
>     je      .Ltmp1
>     ud2
>   .Ltmp1:
>     call    __x86_indirect_thunk_r11
> 
> Define the __CFI_TYPE helper macro for manual type annotations in
> assembly code, add error handling for the CFI ud2 traps, and allow
> CONFIG_CFI_CLANG to be selected on x86_64.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/Kconfig               |  2 ++
>  arch/x86/include/asm/linkage.h | 12 +++++++
>  arch/x86/kernel/traps.c        | 60 +++++++++++++++++++++++++++++++++-
>  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4bed3abf444d..2e73d0792d48 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -108,6 +108,8 @@ config X86
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
>  	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
>  	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
> +	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
> +	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
> index 85865f1645bd..0ee4a0af3974 100644
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -25,6 +25,18 @@
>  #define RET	ret
>  #endif
>  
> +#ifdef CONFIG_CFI_CLANG
> +#define __CFI_TYPE(name)					\
> +	.fill 7, 1, 0xCC ASM_NL					\
> +	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
> +	int3 ASM_NL						\
> +	int3 ASM_NL						\
> +	mov __kcfi_typeid_##name, %eax ASM_NL			\
> +	int3 ASM_NL						\
> +	int3 ASM_NL						\
> +	SYM_FUNC_END(__cfi_##name)
> +#endif
> +
>  #else /* __ASSEMBLY__ */
>  
>  #ifdef CONFIG_SLS
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 1563fb995005..320e257eb4be 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -40,6 +40,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/atomic.h>
>  #include <linux/ioasid.h>
> +#include <linux/cfi.h>
>  
>  #include <asm/stacktrace.h>
>  #include <asm/processor.h>
> @@ -295,6 +296,62 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>  		      ILL_ILLOPN, error_get_trap_addr(regs));
>  }
>  
> +#ifdef CONFIG_CFI_CLANG
> +static void decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
> +			    unsigned long *type)
> +{
> +	char buffer[MAX_INSN_SIZE];
> +	struct insn insn;
> +	int offset;
> +
> +	*target = *type = 0;

Should report_cfi_failure() have some additional hinting for the case
where target/type are zero? Like, "hey, got an inexplicable CFI failure
here, but preamble decode failed. Yikes!"

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
