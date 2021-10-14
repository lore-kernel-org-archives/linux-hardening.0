Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9468C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A657C610E8
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 08:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJNIOk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:14:40 -0400
Received: from foss.arm.com ([217.140.110.172]:50984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhJNIOk (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 04:14:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 145C61063;
        Thu, 14 Oct 2021 01:12:35 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7A43F66F;
        Thu, 14 Oct 2021 01:12:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
To:     Arnd Bergmann <arnd@kernel.org>, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        linux-kernel@vger.kernel.org
References: <20211013150025.2875883-1-arnd@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b35768f5-8e06-ebe6-1cdd-65f7fe67ff7a@arm.com>
Date:   Thu, 14 Oct 2021 10:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211013150025.2875883-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 10/13/21 5:00 PM, Arnd Bergmann wrote:
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
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

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
> 

-- 
Regards,
Vincenzo
