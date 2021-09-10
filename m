Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB53C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E96E611BF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 21:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhIJVR7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 17:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhIJVR7 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 17:17:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BB07600D4;
        Fri, 10 Sep 2021 21:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631308607;
        bh=pf81SXcWaCjZzcuiThhuTv2m8ko+HM+2Hb+5ew+QlqI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eXajeUkQgDiwDXVHBcaoEUNTia35jQVxw2Qslzdrp90Kih980R7ui+oQ1drtZvWCB
         5BwuwHe/UYtqLi0jX/7Ug4gVmf/HNX/1s6U452OuX63MVifBv7muZRBTZFNcbgvCSs
         CX1dfZEaP6XY7RuOwESNHKkfibQS8IPI50UnX+0Ig4x9oOGKeLD6KHj/xTmUFyBdNq
         UNitMl6iDdf+vJ7SABRcsGQmNCyGKerzF4j1FXCju7avyfzgC3A9VEiwdNoWXpPfJk
         oe8IfF6wb/X1r7FNCdWLASWjHSkEr6NXqSWwhIRrWJVL/Z0JUjjwsM6vpKgLfJzndg
         Td+VxgKyWnzEA==
Subject: Re: [PATCH v2] Compiler Attributes: Check GCC version for
 __alloc_size attribute
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
        Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210910201132.3809437-1-keescook@chromium.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <7e77cbc8-4aa9-9607-2b87-6a9ff27c468e@kernel.org>
Date:   Fri, 10 Sep 2021 14:16:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910201132.3809437-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/10/2021 1:11 PM, Kees Cook wrote:
> Unfortunately, just version checking the use of -Wno-alloc-size-larger-than
> is not sufficient to make the __alloc_size attribute behave correctly
> under older GCC versions. The attribute itself must be disabled in those
> situations too, as there appears to be no way to reliably silence the
> SIZE_MAX constant expression cases for GCC versions less than 9.1:
> 
> In file included from ./include/linux/resource_ext.h:11,
>                   from ./include/linux/pci.h:40,
>                   from drivers/net/ethernet/intel/ixgbe/ixgbe.h:9,
>                   from drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:4:
> In function 'kmalloc_node',
>      inlined from 'ixgbe_alloc_q_vector' at ./include/linux/slab.h:743:9:
> ./include/linux/slab.h:618:9: error: argument 1 value '18446744073709551615' exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
>    return __kmalloc_node(size, flags, node);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/slab.h: In function 'ixgbe_alloc_q_vector':
> ./include/linux/slab.h:455:7: note: in a call to allocation function '__kmalloc_node' declared here
>   void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
>         ^~~~~~~~~~~~~~
> 
> Specifically:
> -Wno-alloc-size-larger-than is not correctly handled by GCC < 9.1
>    https://godbolt.org/z/hqsfG7q84 (doesn't disable)
>    https://godbolt.org/z/P9jdrPTYh (doesn't admit to not knowing about option)
>    https://godbolt.org/z/465TPMWKb (only warns when other warnings appear)
> 
> -Walloc-size-larger-than=18446744073709551615 is not handled by GCC < 8.2
>    https://godbolt.org/z/73hh1EPxz (ignores numeric value)
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: llvm@lists.linux.dev
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One open-ended comment below.

> ---
> And now I've added GCC 4.9, 5, and 6 to my build configs... 4.9 is so
> old I have to turn off RETPOLIN in defconfig. :P
> 
> v2:
> - fix lack of VARARGS in fall-back macro
> - add reviewed-by
> ---
>   include/linux/compiler-gcc.h        | 9 +++++++++
>   include/linux/compiler_attributes.h | 6 ------
>   include/linux/compiler_types.h      | 5 +++++
>   3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 01985821944b..3f3efbb651e0 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -151,3 +151,12 @@
>   #else
>   #define __diag_GCC_8(s)
>   #endif
> +
> +/*
> + * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> + * However, prior to 9.1, -Wno-alloc-size-larger-than does not work,
> + * making this attribute unusable.
> + */
> +#if GCC_VERSION < 90100
> +#define __alloc_size(x, ...)	/**/
> +#endif
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 19f178e20e61..2487be0e7199 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -53,12 +53,6 @@
>   #define __aligned(x)                    __attribute__((__aligned__(x)))
>   #define __aligned_largest               __attribute__((__aligned__))
>   
> -/*
> - *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
> - * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size

It might be nice to keep a link to the clang documentation somewhere as 
I like the example a little bit more but I guess it does not make sense 
in compiler_types.h...

> - */
> -#define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
> -
>   /*
>    * Note: users of __always_inline currently do not write "inline" themselves,
>    * which seems to be required by gcc to apply the attribute according
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index c43308b0a9a9..91de9bead40d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -254,6 +254,11 @@ struct ftrace_likely_data {
>   #define asm_volatile_goto(x...) asm goto(x)
>   #endif
>   
> +/* If not specifically disabled, allow the use of __alloc_size attribute. */
> +#ifndef __alloc_size
> +# define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
> +#endif
> +
>   #ifdef CONFIG_CC_HAS_ASM_INLINE
>   #define asm_inline asm __inline
>   #else
> 
