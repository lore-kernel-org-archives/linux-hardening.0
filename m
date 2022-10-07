Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155E8C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Oct 2022 20:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJGUol (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJGUog (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Oct 2022 16:44:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC4139553
        for <linux-hardening@vger.kernel.org>; Fri,  7 Oct 2022 13:44:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so5678957pjl.3
        for <linux-hardening@vger.kernel.org>; Fri, 07 Oct 2022 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1NQpYe+rizQ5Ab+ZRs17Za6tnD7OfyvsVmBDjKriLg=;
        b=FlW98FG7Tf4wPIgYq+kE2MLeLLB8+hzJIgv7ZFTtJeTpZ2KwaLhWjeppyceKEeDofo
         eNSUhAxXvjglRfhYPgDxGBbsRA0CW7MWig1ikSPWH0hNAZJ/QKFDY056SN5kRHpvZtbt
         l1RLwL/g7o1YjTYXTQ2KFM5idwre/gwwg2ZPgrwqAkWwo32zL4mFNIpEtqsIt8zkLpBO
         hrJJWq+uVmuqSqb/QsDtA7Ob7OlVFmeisIoGGs1XkxssItDCLBgFcT+1yHKOpie/l/Dr
         faopCEoIeyGeIKZs95S14gmrvjiIkUUn7/cRXKqXGLJ9psik3POA01q3+CPbfuz9FfjX
         NhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1NQpYe+rizQ5Ab+ZRs17Za6tnD7OfyvsVmBDjKriLg=;
        b=BG5H0PHHsNTbl2w05af2/N7t13XC1eNqTs0pQU4Gt3ZOiCAuxRqhcAAmI5sfeWiF9J
         OALrK0vGiM1Bm0n9E+8XgK0nm8QEw5wptvqS3JxWJcXruKIEq23Zx4OffnPBt74u4Ic8
         +BgdeiXEyj9ANDW/YT6j4QruCfWxbY7Eu+kCtwLZcH/We4eyFfSaFibESSSptN3L+KGp
         geHkhfNGntniDBNIHPdzO7O4oN+MBmdU6OkTQFO8eLIiL+cxIzcxwwyX0cTLtQsb4zWh
         /jW4Kf377mvHmgpzoNL+Gt/j/DD2lXdLX23QLpn8Jbssu/VoXNM6ILasmovbdNf4ekyi
         4K2A==
X-Gm-Message-State: ACrzQf1UDH2IsUBWsOMtt0E3v+ZaxrQYB3uSFlX60/EBHKJGkPtQXA6e
        65Jym3HoJcAJOUK+fTDo75M6GowZEfrbWZeSjIYO8A==
X-Google-Smtp-Source: AMsMyM51FkdHCVqiZbsc2kegAmfl95oHhXUFPyTY3jX+A27YKyLG+BckMn6XyT/Fikdt54cNpecc0XQLc0ZMq249v4w=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr18301725pjb.102.1665175471430; Fri, 07
 Oct 2022 13:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221006230017.1833458-1-keescook@chromium.org>
In-Reply-To: <20221006230017.1833458-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Oct 2022 13:44:19 -0700
Message-ID: <CAKwvOdkhAQx3gxbRFfd3jU0G9Dox+0McDyOcr=174Mv4c7Y8rA@mail.gmail.com>
Subject: Re: [PATCH] overflow: Refactor test skips for Clang-specific issues
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        llvm@lists.linux.dev, Vitor Massaru Iha <vitor@massaru.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 6, 2022 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert test exclusion into test skipping. This brings the logic for
> why a test is being skipped into the test itself, instead of having to
> spread ifdefs around the code. This will make cleanup easier as minimum
> tests get raised. Drop __maybe_unused so missed tests will be noticed
> again and clean up whitespace.
>
> For example, clang-11 on i386:
>
> [15:52:32] ================== overflow (18 subtests) ==================
> [15:52:32] [PASSED] u8_u8__u8_overflow_test
> [15:52:32] [PASSED] s8_s8__s8_overflow_test
> [15:52:32] [PASSED] u16_u16__u16_overflow_test
> [15:52:32] [PASSED] s16_s16__s16_overflow_test
> [15:52:32] [PASSED] u32_u32__u32_overflow_test
> [15:52:32] [PASSED] s32_s32__s32_overflow_test
> [15:52:32] [SKIPPED] u64_u64__u64_overflow_test
> [15:52:32] [SKIPPED] s64_s64__s64_overflow_test
> [15:52:32] [SKIPPED] u32_u32__int_overflow_test
> [15:52:32] [PASSED] u32_u32__u8_overflow_test
> [15:52:32] [PASSED] u8_u8__int_overflow_test
> [15:52:32] [PASSED] int_int__u8_overflow_test
> [15:52:32] [PASSED] shift_sane_test
> [15:52:32] [PASSED] shift_overflow_test
> [15:52:32] [PASSED] shift_truncate_test
> [15:52:32] [PASSED] shift_nonsense_test
> [15:52:32] [PASSED] overflow_allocation_test
> [15:52:32] [PASSED] overflow_size_helpers_test
> [15:52:32] ==================== [PASSED] overflow =====================
> [15:52:32] ============================================================
> [15:52:32] Testing complete. Ran 18 tests: passed: 15, skipped: 3
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks; much nicer!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I ran the following tests:
$ ./tools/testing/kunit/kunit.py run --arch=i386 --make_options LLVM=1 overflow
$ ./tools/testing/kunit/kunit.py run --arch=arm --make_options LLVM=1 overflow
$ make LLVM=1 -j128 defconfig
$ ./scripts/config -e KUNIT -e KUNIT_ALL_TESTS
$ make LLVM=1 -j128 olddefconfig lib/overflow_kunit.o W=1

> ---
>  lib/overflow_kunit.c | 52 +++++++++++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 2914c9d36b0f..3062b33e4bb1 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -16,6 +16,34 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
>
> +#define SKIP(cond, reason)             do {                    \
> +       if (cond) {                                             \
> +               kunit_skip(test, reason);                       \
> +               return;                                         \
> +       }                                                       \
> +} while (0)
> +
> +/*
> + * Clang 11 and earlier generate unwanted libcalls for signed output
> + * on unsigned input.
> + */
> +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11
> +# define SKIP_SIGN_MISMATCH(t) SKIP(t, "Clang 11 unwanted libcalls")
> +#else
> +# define SKIP_SIGN_MISMATCH(t) do { } while (0)
> +#endif
> +
> +/*
> + * Clang 13 and earlier generate unwanted libcalls for 64-bit tests on
> + * 32-bit hosts.
> + */
> +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 13 &&    \
> +    BITS_PER_LONG != 64
> +# define SKIP_64_ON_32(t)      SKIP(t, "Clang 13 unwanted libcalls")
> +#else
> +# define SKIP_64_ON_32(t)      do { } while (0)
> +#endif
> +
>  #define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)                     \
>         static const struct test_ ## t1 ## _ ## t2 ## __ ## t { \
>                 t1 a;                                           \
> @@ -94,7 +122,6 @@ DEFINE_TEST_ARRAY(u32) = {
>         {-4U, 5U, 1U, -9U, -20U, true, false, true},
>  };
>
> -#if BITS_PER_LONG == 64
>  DEFINE_TEST_ARRAY(u64) = {
>         {0, 0, 0, 0, 0, false, false, false},
>         {1, 1, 2, 0, 1, false, false, false},
> @@ -118,7 +145,6 @@ DEFINE_TEST_ARRAY(u64) = {
>          false, true, false},
>         {-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
>  };
> -#endif
>
>  DEFINE_TEST_ARRAY(s8) = {
>         {0, 0, 0, 0, 0, false, false, false},
> @@ -194,7 +220,6 @@ DEFINE_TEST_ARRAY(s32) = {
>         {S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
>  };
>
> -#if BITS_PER_LONG == 64
>  DEFINE_TEST_ARRAY(s64) = {
>         {0, 0, 0, 0, 0, false, false, false},
>
> @@ -223,7 +248,6 @@ DEFINE_TEST_ARRAY(s64) = {
>         {-128, -1, -129, -127, 128, false, false, false},
>         {0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
>  };
> -#endif
>
>  #define check_one_op(t, fmt, op, sym, a, b, r, of) do {                        \
>         int _a_orig = a, _a_bump = a + 1;                               \
> @@ -246,7 +270,7 @@ DEFINE_TEST_ARRAY(s64) = {
>
>  #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)                              \
>  static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
> -{                                                                      \
> +{                                                                      \
>         check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);    \
>         check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);    \
>         check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);   \
> @@ -254,10 +278,15 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>         check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);   \
>  }                                                                      \
>                                                                         \
> -__maybe_unused                                                         \
>  static void n ## _overflow_test(struct kunit *test) {                  \
>         unsigned i;                                                     \
>                                                                         \
> +       SKIP_64_ON_32(__same_type(t, u64));                             \
> +       SKIP_64_ON_32(__same_type(t, s64));                             \
> +       SKIP_SIGN_MISMATCH(__same_type(n ## _tests[0].a, u32) &&        \
> +                          __same_type(n ## _tests[0].b, u32) &&        \
> +                          __same_type(n ## _tests[0].sum, int));       \
> +                                                                       \
>         for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)                   \
>                 do_test_ ## n(test, &n ## _tests[i]);                   \
>         kunit_info(test, "%zu %s arithmetic tests finished\n",          \
> @@ -273,10 +302,8 @@ DEFINE_TEST_FUNC(u16, "%d");
>  DEFINE_TEST_FUNC(s16, "%d");
>  DEFINE_TEST_FUNC(u32, "%u");
>  DEFINE_TEST_FUNC(s32, "%d");
> -#if BITS_PER_LONG == 64
>  DEFINE_TEST_FUNC(u64, "%llu");
>  DEFINE_TEST_FUNC(s64, "%lld");
> -#endif
>
>  DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
>         {0, 0, 0, 0, 0, false, false, false},
> @@ -716,18 +743,9 @@ static struct kunit_case overflow_test_cases[] = {
>         KUNIT_CASE(s16_s16__s16_overflow_test),
>         KUNIT_CASE(u32_u32__u32_overflow_test),
>         KUNIT_CASE(s32_s32__s32_overflow_test),
> -/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
> -#if BITS_PER_LONG == 64
>         KUNIT_CASE(u64_u64__u64_overflow_test),
>         KUNIT_CASE(s64_s64__s64_overflow_test),
> -#endif
> -/*
> - * Clang 11 and earlier generate unwanted libcalls for signed output, unsigned
> - * input.
> - */
> -#if !(defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11)
>         KUNIT_CASE(u32_u32__int_overflow_test),
> -#endif
>         KUNIT_CASE(u32_u32__u8_overflow_test),
>         KUNIT_CASE(u8_u8__int_overflow_test),
>         KUNIT_CASE(int_int__u8_overflow_test),
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
