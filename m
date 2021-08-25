Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0542C432BE
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD2561052
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhHYWAZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhHYWAY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 18:00:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32595C061757
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:59:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i28so2054841lfl.2
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEQgN0abaaOBlYJk9+kTEjTwkKHPtenNKxBXd/YeuFg=;
        b=Rwvd09BGu0W8Bf09NgU+o2Bhog1Y+Zu32OYjoMlTXlKtJOJpBecMKuNcLFx0s5W7zz
         FWDa7ok2PVOhFdJAD1DyBQubxC14BThq1k8VSvpEHgQcajP6D2JWi2VR/S6f1tC5qCaP
         zp2FbvuX7BaGvNggZvh7H9eqq/vJlBv1KhDDwKYnxaLfZGqewEdyShnaUE2zN5DLrMqX
         CYqN9boBMs/RWWLoTUz5GhkIf2NOetMelzo7SGFamyxqU5ur8ttDinQeYkLMEY7WCT2E
         Gp5uljdWnrSP6kH0alI2rMOOUthWb0yeZjebCxQ5rOiJxlNCH+6UYHoxeOqRrdNacdS4
         gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEQgN0abaaOBlYJk9+kTEjTwkKHPtenNKxBXd/YeuFg=;
        b=lMaj9yZHWFRTpHNn2LdIqlFT2ltjZhJIkPnr96M0xEWdf4zPhIcfWi6Y/hhv/9gmmO
         TOBRHFOc1aM2M0CrG3RbtwSkw2NOS9o5/VBp//H+w5p1wwaM3Qo7qLPeA4lz/ADCMpiD
         0V1KBhWm8AkN0773Z5YMSM66bkuVadn/LRs9SNEk10lH2Vighq6m8l8LIja3V9lAJkIg
         tuUJHvA3LAg+UufeYP/kU+fHkDYIxjJjVVyvyfyJVWN6ARhGqCNyri5usVoTmaCcp+aS
         HZV87PJU1b7Fz80aBZ6YbKretB/Bgj6cULjEfGFa/rd6xHTTW+b0cW9iRGYeQ7omnO2q
         4tGg==
X-Gm-Message-State: AOAM531u32tlNyygvSVLjGeNMUsvcaDg1m6EVUt5p1yxP+CVEGbPq2Wr
        +SA7xldCxILwMrJ+5AHQGfKHC56YNc/NbXbAcIvD6lc8peDcAw==
X-Google-Smtp-Source: ABdhPJz9BCwQUFjJgLdRD5l3u4YQ8EIUW07UxVlm6mESNVvXmANgn+AFntEG3u0Htqnn0D3wdFdwXNLGy5zAGtGhUvo=
X-Received: by 2002:a05:6512:3a84:: with SMTP id q4mr182701lfu.543.1629928776388;
 Wed, 25 Aug 2021 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-16-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-16-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:59:24 -0700
Message-ID: <CAKwvOdk0TC_D3ZOQF38=hqH3JRJ608HfzcnczmDunEF5_t0Buw@mail.gmail.com>
Subject: Re: [PATCH for-next 15/25] fortify: Move remaining fortify helpers
 into fortify-string.h
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> When commit a28a6e860c6c ("string.h: move fortified functions definitions
> in a dedicated header.") moved the fortify-specific code, some helpers
> were left behind. Move the remaining fortify-specific helpers into
> fortify-string.h so they're together where they're used. This requires
> that any FORTIFY helper function prototypes be conditionally built to
> avoid "no prototype" warnings. Additionally removes unused helpers.
>
> Acked-by: Francis Laniel <laniel_francis@privacyrequired.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/fortify-string.h | 7 +++++++
>  include/linux/string.h         | 9 ---------
>  lib/string_helpers.c           | 2 ++
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index c1be37437e77..7e67d02764db 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,6 +2,13 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> +#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> +#define __RENAME(x) __asm__(#x)
> +
> +void fortify_panic(const char *name) __noreturn __cold;
> +void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
> +void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
> +void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b48d2d28e0b1..9473f81b9db2 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -249,15 +249,6 @@ static inline const char *kbasename(const char *path)
>         return tail ? tail + 1 : path;
>  }
>
> -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> -#define __RENAME(x) __asm__(#x)
> -
> -void fortify_panic(const char *name) __noreturn __cold;
> -void __read_overflow(void) __compiletime_error("detected read beyond size of object passed as 1st parameter");
> -void __read_overflow2(void) __compiletime_error("detected read beyond size of object passed as 2nd parameter");
> -void __read_overflow3(void) __compiletime_error("detected read beyond size of object passed as 3rd parameter");
> -void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
> -
>  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
>  #include <linux/fortify-string.h>
>  #endif
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index e9433caab217..1274f45ffaf4 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -879,9 +879,11 @@ char *strreplace(char *s, char old, char new)
>  }
>  EXPORT_SYMBOL(strreplace);
>
> +#ifdef CONFIG_FORTIFY_SOURCE
>  void fortify_panic(const char *name)
>  {
>         pr_emerg("detected buffer overflow in %s\n", name);
>         BUG();
>  }
>  EXPORT_SYMBOL(fortify_panic);
> +#endif /* CONFIG_FORTIFY_SOURCE */
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-16-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
