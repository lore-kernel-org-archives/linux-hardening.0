Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C1C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 23:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiBHXZ2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiBHXZ2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 18:25:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3DCC061576
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 15:25:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f10so880583lfu.8
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ybyNtcdRyROTIcJwyZJbn1sv4gx5S92IIuJFLeS5wE=;
        b=KG6vrM5bdpvRtl2iMpgfqF0TpAP4hhLSinh9EXzm6Vyf38iVoLzQrKhnzTRqF3XO9G
         cp5jwaF7ak9/xU7IpdTRW/59RP8pKASg3qEYfsj9zmHFGqo+vHKTDh9C6m4ZjIAlqP23
         zuu89wXVmrnGvA/3I+Qi6BRvnFZZjQGFOOP03vpDfiMoi+401+pmVIsqT/iD9AuSUwFu
         a6IqJCExA3yqow1OPzgph62zpgMrHDftSyuRc6h5N3/bySsRGfxHz6m2oEKjAhaBPwFb
         61GK89d+z2hBg+6ETQRLMWZ2WWMP4cNPiFLDUuQ70w0nrY4xTVctPgyT8v3MqU4dINQW
         ucsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ybyNtcdRyROTIcJwyZJbn1sv4gx5S92IIuJFLeS5wE=;
        b=ZFqL7/Ljc0ogIC/vbYGOWpfFS20BjLHXsNVCXbsFP+Sh/taGoDMcz/8ZYTqvYcWjUm
         hZYD8EBxpwyj2vorz/zm36LoBjsmJ3b5slbogwv2aUV9f4Di6nvJR6QKsjZ8Au2ICVW1
         rKssIciCRRNi/ytTRcKBKD6/vMmXRYni1bZicb4TW2ovaNsa8kHbkyk5swMhFBN1CwpH
         Cog2d4slDnJ+Su9nWon795wdCljEFWtSFR5PdorTb25hIPvDMZSIT1nSDL5f2Fi1RB7j
         OS4O615csIRxhi/TtSDnWoyXC3rirCJauIpnC78Dr7juoLookmIhHcgkCFi20PORfla5
         y8tA==
X-Gm-Message-State: AOAM531iI1cLI0QkiUxKymgNR7BeJgCoS5bO7GFL9EhvdUkIriWCeqHC
        J70BsJ2JftAhhzjbX7y6GfZvh8ImM+Q/Rbfa2quoAw==
X-Google-Smtp-Source: ABdhPJwU6ArHQMfifMwI39CPeSZp3Yy2hdcF+jpnVLhoccKbOgmiYHA7ijFnR8dr6EEK8l9qcZ3AN8Kg54/OyBoeBeU=
X-Received: by 2002:a05:6512:3f97:: with SMTP id x23mr2091419lfa.550.1644362725282;
 Tue, 08 Feb 2022 15:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-9-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-9-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 15:25:13 -0800
Message-ID: <CAKwvOdkg=o8zz1B=zqpu_iapB6d1S0Q_PPBq_2JL+m6SnW_03w@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> Enable FORTIFY_SOURCE support for Clang:
>
> Use the new __pass_object_size and __overloadable attributes so that
> Clang will have appropriate visibility into argument sizes such that
> __builtin_object_size(p, 1) will behave correctly. Additional details
> available here:
>     https://github.com/llvm/llvm-project/issues/53516
>     https://github.com/ClangBuiltLinux/linux/issues/1401
>
> A bug with __builtin_constant_p() of globally defined variables was
> fixed in Clang 13 (and backported to 12.0.1), so FORTIFY support must
> depend on that version or later. Additional details here:
>     https://bugs.llvm.org/show_bug.cgi?id=41459
>     commit a52f8a59aef4 ("fortify: Explicitly disable Clang support")
>
> A bug with Clang's -mregparm=3 and -m32 makes some builtins unusable,
> so removing -ffreestanding (to gain the needed libcall optimizations
> with Clang) cannot be done. Without the libcall optimizations, Clang
> cannot provide appropriate FORTIFY coverage, so it must be disabled
> for CONFIG_X86_32. Additional details here;
>     https://github.com/llvm/llvm-project/issues/53645

Nice job on this series Kees! Hopefully we can get i386 support working next!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: George Burgess IV <gbiv@google.com>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 40 ++++++++++++++++++++++------------
>  security/Kconfig               |  5 +++--
>  2 files changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index f77cf22e2d60..295637a66c46 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -4,7 +4,7 @@
>
>  #include <linux/const.h>
>
> -#define __FORTIFY_INLINE extern __always_inline __gnu_inline
> +#define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
>  #define __RENAME(x) __asm__(#x)
>
>  void fortify_panic(const char *name) __noreturn __cold;
> @@ -52,8 +52,17 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>  #define __underlying_strncpy   __builtin_strncpy
>  #endif
>
> +/*
> + * Clang's use of __builtin_object_size() within inlines needs hinting via
> + * __pass_object_size(). The preference is to only ever use type 1 (member
> + * size, rather than struct size), but there remain some stragglers using
> + * type 0 that will be converted in the future.
> + */
> +#define POS    __pass_object_size(1)
> +#define POS0   __pass_object_size(0)
> +
>  __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
> -char *strncpy(char * const p, const char *q, __kernel_size_t size)
> +char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>
> @@ -65,7 +74,7 @@ char *strncpy(char * const p, const char *q, __kernel_size_t size)
>  }
>
>  __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
> -char *strcat(char * const p, const char *q)
> +char *strcat(char * const POS p, const char *q)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>
> @@ -77,7 +86,7 @@ char *strcat(char * const p, const char *q)
>  }
>
>  extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
> -__FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t maxlen)
> +__FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size_t maxlen)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>         size_t p_len = __compiletime_strlen(p);
> @@ -106,7 +115,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
>         __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \
>                 __builtin_strlen(p), __fortify_strlen(p))
>  __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
> -__kernel_size_t __fortify_strlen(const char * const p)
> +__kernel_size_t __fortify_strlen(const char * const POS p)
>  {
>         __kernel_size_t ret;
>         size_t p_size = __builtin_object_size(p, 1);
> @@ -122,7 +131,7 @@ __kernel_size_t __fortify_strlen(const char * const p)
>
>  /* defined after fortified strlen to reuse it */
>  extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
> -__FORTIFY_INLINE size_t strlcpy(char * const p, const char * const q, size_t size)
> +__FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>         size_t q_size = __builtin_object_size(q, 1);
> @@ -149,7 +158,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const p, const char * const q, size_t siz
>
>  /* defined after fortified strnlen to reuse it */
>  extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
> -__FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t size)
> +__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
>  {
>         size_t len;
>         /* Use string size rather than possible enclosing struct size. */
> @@ -196,7 +205,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t si
>
>  /* defined after fortified strlen and strnlen to reuse them */
>  __FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
> -char *strncat(char * const p, const char * const q, __kernel_size_t count)
> +char *strncat(char * const POS p, const char * const POS q, __kernel_size_t count)
>  {
>         size_t p_len, copy_len;
>         size_t p_size = __builtin_object_size(p, 1);
> @@ -367,7 +376,7 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
>                 memmove)
>
>  extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
> -__FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
> +__FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>
> @@ -379,7 +388,7 @@ __FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
>  }
>
>  __FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
> -int memcmp(const void * const p, const void * const q, __kernel_size_t size)
> +int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>         size_t q_size = __builtin_object_size(q, 0);
> @@ -396,7 +405,7 @@ int memcmp(const void * const p, const void * const q, __kernel_size_t size)
>  }
>
>  __FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
> -void *memchr(const void * const p, int c, __kernel_size_t size)
> +void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>
> @@ -408,7 +417,7 @@ void *memchr(const void * const p, int c, __kernel_size_t size)
>  }
>
>  void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
> -__FORTIFY_INLINE void *memchr_inv(const void * const p, int c, size_t size)
> +__FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>
> @@ -420,7 +429,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const p, int c, size_t size)
>  }
>
>  extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
> -__FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
> +__FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>
> @@ -433,7 +442,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
>
>  /* Defined after fortified strlen to reuse it. */
>  __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
> -char *strcpy(char * const p, const char * const q)
> +char *strcpy(char * const POS p, const char * const POS q)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>         size_t q_size = __builtin_object_size(q, 1);
> @@ -462,4 +471,7 @@ char *strcpy(char * const p, const char * const q)
>  #undef __underlying_strncat
>  #undef __underlying_strncpy
>
> +#undef POS
> +#undef POS0
> +
>  #endif /* _LINUX_FORTIFY_STRING_H_ */
> diff --git a/security/Kconfig b/security/Kconfig
> index 0b847f435beb..1d2d71cc1f36 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -177,9 +177,10 @@ config HARDENED_USERCOPY_PAGESPAN
>  config FORTIFY_SOURCE
>         bool "Harden common str/mem functions against buffer overflows"
>         depends on ARCH_HAS_FORTIFY_SOURCE
> -       # https://bugs.llvm.org/show_bug.cgi?id=50322
>         # https://bugs.llvm.org/show_bug.cgi?id=41459
> -       depends on !CC_IS_CLANG
> +       depends on !CC_IS_CLANG || CLANG_VERSION >= 120001
> +       # https://github.com/llvm/llvm-project/issues/53645
> +       depends on !CC_IS_CLANG || !X86_32
>         help
>           Detect overflows of buffers in common string and memory functions
>           where the compiler can determine and validate the buffer sizes.
> --
> 2.30.2
>
>


-- 
Thanks,
~Nick Desaulniers
