Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED6C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BE560C41
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhJRTtT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRTtS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 15:49:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E66C06161C
        for <linux-hardening@vger.kernel.org>; Mon, 18 Oct 2021 12:47:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s1so10197386plg.12
        for <linux-hardening@vger.kernel.org>; Mon, 18 Oct 2021 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N/UkEqZsUw28dgpf+wkDefjIGznCOnGAPbrDklw8cgA=;
        b=fuCYcYo2n82pYTF+DVXCIH4nE3CtGx+HswPWG0KsiHpVTzjKFTYzPkcT6QfijE2gwa
         Zu2go9G/Y0e8y4ZWf3NCWh7HMPgTbhR1PLein6lGvTB8q6+4m/QAV03lMSaFAacS8EjW
         0JQUa1nv0yvXLNKSt/M2Hylr/p2ymVxA7ZWCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/UkEqZsUw28dgpf+wkDefjIGznCOnGAPbrDklw8cgA=;
        b=jKjHtzC9c8BJAfnZwrEBJ4CMe9mrd99TUKO5kwMFwzxVoGdyoKbu4nyWhecbC3+aH7
         QTWAYuwzo9MHfY9Jx06NZwPaRXq3OOve55sFF46eKlt0DUfBMf8RzJJ9YtYPri4Gfz+4
         eujvrUglI1ctVm5zh1YbCwJiMiAyfQQtDFXt73OjKAX54N6SECLWJ8ktIHRxFQJKY+0E
         OXqBXUL0UfRSl0nKSHMNOMtsSoH6lmidosa7gO9JIvGS6770QPDNEEqwSivSY6UB8yL4
         W/j0zBB/+7bNVzvyfKbOUk+C/K5sUHEUIEzlVpanbNTBBjXTx7gWbGevdvXmY09xNQCH
         HRmg==
X-Gm-Message-State: AOAM531HpaIKN61JxnHcXcp3EyuzsupoBYdqeDQ2Zu6DGV/UpaTST6B3
        D+/0p8epmep1qowh55Z+T25KTg==
X-Google-Smtp-Source: ABdhPJzX8CQAwD/mJwgjVQdV6Mg7IJJYAARp4Rvgh95u1dpIgNI9xmthkbybS6i4kyeu0jA9JgRTGQ==
X-Received: by 2002:a17:903:2287:b0:13e:5d9f:1ebf with SMTP id b7-20020a170903228700b0013e5d9f1ebfmr28807432plh.75.1634586426677;
        Mon, 18 Oct 2021 12:47:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8sm13500519pfh.186.2021.10.18.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:47:06 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:47:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
Message-ID: <202110181245.499CB7594B@keescook>
References: <20211013150025.2875883-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013150025.2875883-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 05:00:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calling memcmp() and memchr() with an intentional buffer overflow
> is now caught at compile time:
> 
> In function 'memcmp',
>     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
> include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   263 |                         __read_overflow();
>       |                         ^~~~~~~~~~~~~~~~~
> In function 'memchr',
>     inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
> include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   277 |                 __read_overflow();
>       |                 ^~~~~~~~~~~~~~~~~
> 
> Change the kasan tests to wrap those inside of a noinline function
> to prevent the compiler from noticing the bug and let kasan find
> it at runtime.

Is this with W=1 ? I had explicitly disabled the read overflows for
"phase 1" of the overflow restriction tightening...

(And what do you think of using OPTIMIZER_HIDE_VAR() instead[1]?

-Kees

[1] https://lore.kernel.org/linux-hardening/20211006181544.1670992-1-keescook@chromium.org/T/#u

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/test_kasan.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 67ed689a0b1b..903215e944f1 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -852,6 +852,21 @@ static void kmem_cache_invalid_free(struct kunit *test)
>  	kmem_cache_destroy(cache);
>  }
>  
> +/*
> + * noinline wrappers to prevent the compiler from noticing the overflow
> + * at compile time rather than having kasan catch it.
> + * */
> +static noinline void *__kasan_memchr(const void *s, int c, size_t n)
> +{
> +	return memchr(s, c, n);
> +}
> +
> +static noinline int __kasan_memcmp(const void *s1, const void *s2, size_t n)
> +{
> +	return memcmp(s1, s2, n);
> +}
> +
> +
>  static void kasan_memchr(struct kunit *test)
>  {
>  	char *ptr;
> @@ -870,7 +885,7 @@ static void kasan_memchr(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
>  	KUNIT_EXPECT_KASAN_FAIL(test,
> -		kasan_ptr_result = memchr(ptr, '1', size + 1));
> +		kasan_ptr_result = __kasan_memchr(ptr, '1', size + 1));
>  
>  	kfree(ptr);
>  }
> @@ -895,7 +910,7 @@ static void kasan_memcmp(struct kunit *test)
>  	memset(arr, 0, sizeof(arr));
>  
>  	KUNIT_EXPECT_KASAN_FAIL(test,
> -		kasan_int_result = memcmp(ptr, arr, size+1));
> +		kasan_int_result = __kasan_memcmp(ptr, arr, size+1));
>  	kfree(ptr);
>  }
>  
> -- 
> 2.29.2
> 

-- 
Kees Cook
