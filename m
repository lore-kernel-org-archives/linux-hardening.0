Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D56EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6FE6113E
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 11:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhJFLkn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:40:43 -0400
Received: from foss.arm.com ([217.140.110.172]:59664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238143AbhJFLkm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 07:40:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9DB1FB;
        Wed,  6 Oct 2021 04:38:50 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72033F70D;
        Wed,  6 Oct 2021 04:38:46 -0700 (PDT)
Date:   Wed, 6 Oct 2021 12:38:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kasan: test: Bypass __alloc_size checks
Message-ID: <20211006113732.GA14159@C02TD0UTHF1T.local>
References: <20211006035522.539346-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006035522.539346-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Tue, Oct 05, 2021 at 08:55:22PM -0700, Kees Cook wrote:
> Intentional overflows, as performed by the KASAN tests, are detected
> at compile time[1] (instead of only at run-time) with the addition of
> __alloc_size. Fix this by forcing the compiler into not being able to
> trust the size used following the kmalloc()s.

It might be better to use OPTIMIZER_HIDE_VAR(), since that's intended to
make the value opaque to the compiler, and volatile might not always do
that depending on how the compiler tracks the variable.

Thanks,
Mark.

> 
> [1] https://lore.kernel.org/lkml/20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/test_kasan.c        | 10 +++++-----
>  lib/test_kasan_module.c |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 8835e0784578..0e1f8d5281b4 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -435,7 +435,7 @@ static void kmalloc_uaf_16(struct kunit *test)
>  static void kmalloc_oob_memset_2(struct kunit *test)
>  {
>  	char *ptr;
> -	size_t size = 128 - KASAN_GRANULE_SIZE;
> +	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -447,7 +447,7 @@ static void kmalloc_oob_memset_2(struct kunit *test)
>  static void kmalloc_oob_memset_4(struct kunit *test)
>  {
>  	char *ptr;
> -	size_t size = 128 - KASAN_GRANULE_SIZE;
> +	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -459,7 +459,7 @@ static void kmalloc_oob_memset_4(struct kunit *test)
>  static void kmalloc_oob_memset_8(struct kunit *test)
>  {
>  	char *ptr;
> -	size_t size = 128 - KASAN_GRANULE_SIZE;
> +	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -471,7 +471,7 @@ static void kmalloc_oob_memset_8(struct kunit *test)
>  static void kmalloc_oob_memset_16(struct kunit *test)
>  {
>  	char *ptr;
> -	size_t size = 128 - KASAN_GRANULE_SIZE;
> +	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -483,7 +483,7 @@ static void kmalloc_oob_memset_16(struct kunit *test)
>  static void kmalloc_oob_in_memset(struct kunit *test)
>  {
>  	char *ptr;
> -	size_t size = 128 - KASAN_GRANULE_SIZE;
> +	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index 7ebf433edef3..c8cc77b1dcf3 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -19,7 +19,7 @@ static noinline void __init copy_user_test(void)
>  {
>  	char *kmem;
>  	char __user *usermem;
> -	size_t size = 128 - KASAN_GRANULE_SIZE;
> +	volatile size_t size = 128 - KASAN_GRANULE_SIZE;
>  	int __maybe_unused unused;
>  
>  	kmem = kmalloc(size, GFP_KERNEL);
> -- 
> 2.30.2
> 
