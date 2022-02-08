Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7926C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiBHXE2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiBHXE1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 18:04:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A8DC06157A
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 15:04:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t14so967325ljh.8
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 15:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzIha971yQLAyJxRSkUf/hABp2vPytSC8H1yQIf41M4=;
        b=YGW9z4jPHGEGB7AelMTYwtJgbPRFRhbuibumAkUcs2kET7uSzj0LFBI25AXPW+xNc6
         HczGoJGlDK4ursC38hCqf9s+rZO6Y1zdPccy02agz/BQaOnMg6CQgPmxNmSD8tn7wrct
         EB8XCyQFkWo4Azox2+rGnJ1SPDhnaRy78ijqXbB34xLcK5n2S0oInGOb8rk/55KwF+mo
         9sJ/oG3eKAasIhPSicxbZS3mbtLbwzO5f5BLTSNj155I5Yqy7Vjz2omOt1tyc8if7c7q
         4HV1j9jX7vssStw5LLeTXcJiZhkcF9AR4shHC1B4oB7Ht77nbfdw7H0ieDgBRQzms/RO
         VYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzIha971yQLAyJxRSkUf/hABp2vPytSC8H1yQIf41M4=;
        b=6f7wLws6ixvG+Gw6PRs8JhfnZJcSedERfcRV6G+CR+NdO7OZcEf+V88X5Gtp2Y4xSU
         AOJMAu05K1KDbmLRylVH6k5bb4yKZUbDpd3F5qymv9oKtxugCRvGAENPbCOtVQtzWVCw
         GX2SCY16PXM5MF2MmQXrh1CNFv4WnclUAC/mwhTzbiebCvn02hIw/Pm4rYN1NdVlesEC
         1eHLOQHl4VmZKyMxZLAPNSr6DBreBV5C4jw8Pybjkh5mbGlQQ4wZwMXo8vPkANvEksc7
         nF3w2ChPOaPdUfOYv+yXxXldyJIVun5JjCwzLjHB8w+8ZuXIHViVZVmHA3OWMTOXZrZb
         XNQQ==
X-Gm-Message-State: AOAM531nGwmV4fqkqGHm4AvTBmFi0yfrOBsxbOkRwDXWnmAQ28C5np2v
        AY3AuuS04MseYn/+pbEeqfCp2qEsCHYT9jzDXNP0fA==
X-Google-Smtp-Source: ABdhPJxP5RnTeIivtuPxdGjyUFL4anyqlXhyUsssJcaDCNV+jLzk/FxRspMMf+Y6WdUndcOZ8hOIZy/bqTlM7xi+l4Q=
X-Received: by 2002:a2e:954:: with SMTP id 81mr4120299ljj.198.1644361463072;
 Tue, 08 Feb 2022 15:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20220208225350.1331628-1-keescook@chromium.org> <20220208225350.1331628-7-keescook@chromium.org>
In-Reply-To: <20220208225350.1331628-7-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 15:04:11 -0800
Message-ID: <CAKwvOdnY9kOfmGEusrA9Sgjv5oL0WuTxMpQA9bWDaEPtj90ngA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] fortify: Use __diagnose_as() for better diagnostic coverage
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 8, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for using Clang's __pass_object_size, add __diagnose_as()
> attributes to mark the functions as being the same as the indicated
> builtins. When __daignose_as() is available, Clang will have a more
> complete ability to apply its own diagnostic analysis to callers of these
> functions, as if they were the builtins themselves. Without __diagnose_as,
> Clang's compile time diagnostic messages won't be as precise as they
> could be, but at least users of older toolchains will still benefit from
> having fortified routines.

Yes, much easier to review split up. Thanks for taking the time to do so!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index f874ada4b9af..db1ad1c1c79a 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -50,7 +50,8 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>  #define __underlying_strncpy   __builtin_strncpy
>  #endif
>
> -__FORTIFY_INLINE char *strncpy(char * const p, const char *q, __kernel_size_t size)
> +__FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
> +char *strncpy(char * const p, const char *q, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>
> @@ -61,7 +62,8 @@ __FORTIFY_INLINE char *strncpy(char * const p, const char *q, __kernel_size_t si
>         return __underlying_strncpy(p, q, size);
>  }
>
> -__FORTIFY_INLINE char *strcat(char * const p, const char *q)
> +__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
> +char *strcat(char * const p, const char *q)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>
> @@ -94,7 +96,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
>  }
>
>  /* defined after fortified strnlen to reuse it. */
> -__FORTIFY_INLINE __kernel_size_t strlen(const char * const p)
> +__FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
> +__kernel_size_t strlen(const char * const p)
>  {
>         __kernel_size_t ret;
>         size_t p_size = __builtin_object_size(p, 1);
> @@ -183,7 +186,8 @@ __FORTIFY_INLINE ssize_t strscpy(char * const p, const char * const q, size_t si
>  }
>
>  /* defined after fortified strlen and strnlen to reuse them */
> -__FORTIFY_INLINE char *strncat(char * const p, const char * const q, __kernel_size_t count)
> +__FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
> +char *strncat(char * const p, const char * const q, __kernel_size_t count)
>  {
>         size_t p_len, copy_len;
>         size_t p_size = __builtin_object_size(p, 1);
> @@ -365,7 +369,8 @@ __FORTIFY_INLINE void *memscan(void * const p, int c, __kernel_size_t size)
>         return __real_memscan(p, c, size);
>  }
>
> -__FORTIFY_INLINE int memcmp(const void * const p, const void * const q, __kernel_size_t size)
> +__FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
> +int memcmp(const void * const p, const void * const q, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>         size_t q_size = __builtin_object_size(q, 0);
> @@ -381,7 +386,8 @@ __FORTIFY_INLINE int memcmp(const void * const p, const void * const q, __kernel
>         return __underlying_memcmp(p, q, size);
>  }
>
> -__FORTIFY_INLINE void *memchr(const void * const p, int c, __kernel_size_t size)
> +__FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
> +void *memchr(const void * const p, int c, __kernel_size_t size)
>  {
>         size_t p_size = __builtin_object_size(p, 0);
>
> @@ -417,7 +423,8 @@ __FORTIFY_INLINE void *kmemdup(const void * const p, size_t size, gfp_t gfp)
>  }
>
>  /* Defined after fortified strlen to reuse it. */
> -__FORTIFY_INLINE char *strcpy(char * const p, const char * const q)
> +__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
> +char *strcpy(char * const p, const char * const q)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
>         size_t q_size = __builtin_object_size(q, 1);
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
