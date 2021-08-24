Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E8AC432BE
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 07:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1694161360
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Aug 2021 07:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhHXHBS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhHXHBQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Aug 2021 03:01:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6916EC06175F
        for <linux-hardening@vger.kernel.org>; Tue, 24 Aug 2021 00:00:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i3so1265411wmq.3
        for <linux-hardening@vger.kernel.org>; Tue, 24 Aug 2021 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICdLCAE9F2d1J4gjoAJ7XKYwkHuUbm1vnXwFQHx40iE=;
        b=nNas2w1Y3fz7wuL5P1E4e+IpX/4X0yObkGSivzMK3HvusWrYcgIzL40Hiw1OWyvMvx
         V1TwzHfaP7mJ+ozxvftB5YmzAd8LkjY6KaXFmiwCh6GB5fCekybMW1q4mkuHQCVRgMtl
         15FX6VANBhbuEthFCdEM7IOB2kxLgPBxMmlUwStsnThtykN40bdUCHxiOVq9vgzeyOqm
         jgylqVQ7leXHJYyQfpdtHbgQU4xpy6TsRmmdwA7qVg1UbZoKv+Rc3Qju2U2pV6ySHAZR
         XFN7QZ2q4Ytest0WptzCMsW4xklMPvZO+G/ZZxCEYI6qJ4aHmsALSZuTJESB93aKgoUq
         7crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICdLCAE9F2d1J4gjoAJ7XKYwkHuUbm1vnXwFQHx40iE=;
        b=YFEWWnWPDcmUyMXHfMt/gdxMatdiAWJ3W4fVux2O0hCcLSn1BygSIBiHSBiHmpZZ1G
         cT74+nZnNkrxIgRhNUx/Do/1+LjOEOt+sJQc9KVGdgeg6NePKEG33n4bfl/ap6vsN2g4
         LOYv8/8GxlqzKDiopdtaQgXDi4THXFuUYSNp8hw6g8gFMACG3lJ9R2LjYrVAyO+AB+dx
         LhZO/L2shtkRMUteoDMzAruxapOiUeuMHeEm+oJJ6VDHBBxmC2TdAh8w5mC/QZkITQSr
         qWuKhr+dynG2OVlLCHLXxsQw5QyfJp5ZaUdiraEqmitYt9AkpHy3WfZTaJVQ71mL8KpE
         YVWg==
X-Gm-Message-State: AOAM531za0oUexmo3DxKMNgJ/WYzggGPeh3aD4s6sPyQoWeGx1xtnglY
        zOPUioydd5aaq493WwRzzj3QEPYIJuvmKNPKQBWU6A==
X-Google-Smtp-Source: ABdhPJy985yRA4Oysjxf1QPktANY8Xl8Fwej2Qliu0YbgVY7veBPK5GUw1LEddDO8iS31szVLE9BN4bRrkY/cQdVlMw=
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr2545861wmq.31.1629788430655;
 Tue, 24 Aug 2021 00:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-22-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-22-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 24 Aug 2021 15:00:19 +0800
Message-ID: <CABVgOSn=fmUctW_xexDyS_c4G3ee4vGvuJLaanRDQbzQkfAOBQ@mail.gmail.com>
Subject: Re: [PATCH for-next 21/25] lib: Introduce CONFIG_TEST_MEMCPY
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 22, 2021 at 3:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> Before changing anything about memcpy(), memmove(), and memset(), add
> run-time tests to check basic behaviors for any regressions.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Thanks for adding a KUnit test here: it's great to have better
coverage of some of these basic functions!

There's a name mismatch with the Kconfig entry and the Makefile,
otherwise this looks good and works fine on my machine (under both UML
and qemu/x86_64).

It would be possible to split these tests up further if you wanted,
which could be useful if there's a desire to track the individual
assertion results independently. That's probably what I'd've done, but
It's a matter of personal preference either way, though: the tests
aren't absurdly huge or over-complicated as-is.

Cheers,
-- David

>  MAINTAINERS       |   9 ++
>  lib/Kconfig.debug |  11 ++
>  lib/Makefile      |   1 +
>  lib/test_memcpy.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 286 insertions(+)
>  create mode 100644 lib/test_memcpy.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c8be735cc91..e3ffd4bdc24f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7248,6 +7248,15 @@ L:       netdev@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/nvidia/*
>
> +FORTIFY_SOURCE
> +M:     Kees Cook <keescook@chomium.org>
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported
> +F:     include/linux/fortify-string.h
> +F:     lib/test_fortify/*
> +F:     scripts/test_fortify.sh
> +K:     \b__NO_FORTIFY\b
> +

Do you want this to be part of the memcpy() KUnit test commit, or is
it better suited in one of the changes to the actual fortify stuff?

>  FPGA DFL DRIVERS
>  M:     Wu Hao <hao.wu@intel.com>
>  R:     Tom Rix <trix@redhat.com>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 831212722924..9199be57ba2a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2467,6 +2467,17 @@ config RATIONAL_KUNIT_TEST
>
>           If unsure, say N.
>
> +config MEMCPY_KUNIT_TEST
> +       tristate "Test memcpy(), memmove(), and memset() functions at runtime" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Builds unit tests for memcpy(), memmove(), and memset() functions.
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index bd17c2bf43e1..8a4c8bdb38a2 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
>  obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
>  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> +obj-$(CONFIG_TEST_MEMCPY) += test_memcpy.o

This doesn't match CONFIG_MEMCPY_KUNIT_TEST above, so the test is
never compiled in.

>  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
>  obj-$(CONFIG_TEST_SORT) += test_sort.o
>  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> diff --git a/lib/test_memcpy.c b/lib/test_memcpy.c
> new file mode 100644
> index 000000000000..ec546cec883e
> --- /dev/null
> +++ b/lib/test_memcpy.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for memcpy(), memmove(), and memset().
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +
> +struct some_bytes {
> +       union {
> +               u8 data[32];
> +               struct {
> +                       u32 one;
> +                       u16 two;
> +                       u8  three;
> +                       /* 1 byte hole */
> +                       u32 four[4];
> +               };
> +       };
> +};
> +
> +#define check(instance, v) do {        \
> +       int i;  \
> +       BUILD_BUG_ON(sizeof(instance.data) != 32);      \
> +       for (i = 0; i < sizeof(instance.data); i++) {   \
> +               KUNIT_ASSERT_EQ_MSG(test, instance.data[i], v, \
> +                       "line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
> +                       __LINE__, #instance, v, i, instance.data[i]);   \
> +       }       \
> +} while (0)
> +
> +#define compare(name, one, two) do { \
> +       int i; \
> +       BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
> +       for (i = 0; i < sizeof(one); i++) {     \
> +               KUNIT_EXPECT_EQ_MSG(test, one.data[i], two.data[i], \
> +                       "line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
> +                       __LINE__, #one, i, one.data[i], #two, i, two.data[i]); \
> +       }       \
> +       kunit_info(test, "ok: " TEST_OP "() " name "\n");       \
> +} while (0)
> +
> +static void memcpy_test(struct kunit *test)
> +{
> +#define TEST_OP "memcpy"
> +       struct some_bytes control = {
> +               .data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                       },
> +       };
> +       struct some_bytes zero = { };
> +       struct some_bytes middle = {
> +               .data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
> +                         0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                       },
> +       };
> +       struct some_bytes three = {
> +               .data = { 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> +                       },
> +       };
> +       struct some_bytes dest = { };
> +       int count;
> +       u8 *ptr;
> +
> +       /* Verify static initializers. */
> +       check(control, 0x20);
> +       check(zero, 0);
> +       compare("static initializers", dest, zero);
> +
> +       /* Verify assignment. */
> +       dest = control;
> +       compare("direct assignment", dest, control);
> +
> +       /* Verify complete overwrite. */
> +       memcpy(dest.data, zero.data, sizeof(dest.data));
> +       compare("complete overwrite", dest, zero);
> +
> +       /* Verify middle overwrite. */
> +       dest = control;
> +       memcpy(dest.data + 12, zero.data, 7);
> +       compare("middle overwrite", dest, middle);
> +
> +       /* Verify argument side-effects aren't repeated. */
> +       dest = control;
> +       ptr = dest.data;
> +       count = 1;
> +       memcpy(ptr++, zero.data, count++);
> +       ptr += 8;
> +       memcpy(ptr++, zero.data, count++);
> +       compare("argument side-effects", dest, three);
> +#undef TEST_OP
> +}
> +
> +static void memmove_test(struct kunit *test)
> +{
> +#define TEST_OP "memmove"
> +       struct some_bytes control = {
> +               .data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                       },
> +       };
> +       struct some_bytes zero = { };
> +       struct some_bytes middle = {
> +               .data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x00, 0x00, 0x00, 0x00,
> +                         0x00, 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                       },
> +       };
> +       struct some_bytes five = {
> +               .data = { 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x00, 0x00, 0x00, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                       },
> +       };
> +       struct some_bytes overlap = {
> +               .data = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +                         0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                       },
> +       };
> +       struct some_bytes overlap_expected = {
> +               .data = { 0x00, 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x07,
> +                         0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> +                       },
> +       };
> +       struct some_bytes dest = { };
> +       int count;
> +       u8 *ptr;
> +
> +       /* Verify static initializers. */
> +       check(control, 0x99);
> +       check(zero, 0);
> +       compare("static initializers", zero, dest);
> +
> +       /* Verify assignment. */
> +       dest = control;
> +       compare("direct assignment", dest, control);
> +
> +       /* Verify complete overwrite. */
> +       memmove(dest.data, zero.data, sizeof(dest.data));
> +       compare("complete overwrite", dest, zero);
> +
> +       /* Verify middle overwrite. */
> +       dest = control;
> +       memmove(dest.data + 12, zero.data, 7);
> +       compare("middle overwrite", dest, middle);
> +
> +       /* Verify argument side-effects aren't repeated. */
> +       dest = control;
> +       ptr = dest.data;
> +       count = 2;
> +       memmove(ptr++, zero.data, count++);
> +       ptr += 9;
> +       memmove(ptr++, zero.data, count++);
> +       compare("argument side-effects", dest, five);
> +
> +       /* Verify overlapping overwrite is correct. */
> +       ptr = &overlap.data[2];
> +       memmove(ptr, overlap.data, 5);
> +       compare("overlapping write", overlap, overlap_expected);
> +#undef TEST_OP
> +}
> +
> +static void memset_test(struct kunit *test)
> +{
> +#define TEST_OP "memset"
> +       struct some_bytes control = {
> +               .data = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                       },
> +       };
> +       struct some_bytes complete = {
> +               .data = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +                         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +                         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +                         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +                       },
> +       };
> +       struct some_bytes middle = {
> +               .data = { 0x30, 0x30, 0x30, 0x30, 0x31, 0x31, 0x31, 0x31,
> +                         0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31,
> +                         0x31, 0x31, 0x31, 0x31, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                       },
> +       };
> +       struct some_bytes three = {
> +               .data = { 0x60, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x61, 0x61, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +                       },
> +       };
> +       struct some_bytes dest = { };
> +       int count, value;
> +       u8 *ptr;
> +
> +       /* Verify static initializers. */
> +       check(control, 0x30);
> +       check(dest, 0);
> +
> +       /* Verify assignment. */
> +       dest = control;
> +       compare("direct assignment", dest, control);
> +
> +       /* Verify complete overwrite. */
> +       memset(dest.data, 0xff, sizeof(dest.data));
> +       compare("complete overwrite", dest, complete);
> +
> +       /* Verify middle overwrite. */
> +       dest = control;
> +       memset(dest.data + 4, 0x31, 16);
> +       compare("middle overwrite", dest, middle);
> +
> +       /* Verify argument side-effects aren't repeated. */
> +       dest = control;
> +       ptr = dest.data;
> +       value = 0x60;
> +       count = 1;
> +       memset(ptr++, value++, count++);
> +       ptr += 8;
> +       memset(ptr++, value++, count++);
> +       compare("argument side-effects", dest, three);
> +#undef TEST_OP
> +}
> +
> +static struct kunit_case memcpy_test_cases[] = {
> +       KUNIT_CASE(memset_test),
> +       KUNIT_CASE(memcpy_test),
> +       KUNIT_CASE(memmove_test),
> +       {}
> +};
> +
> +static struct kunit_suite memcpy_test_suite = {
> +       .name = "memcpy-test",

It may be better to just name the suite "memcpy", since -- by
definition -- it's a test if it's a KUnit test suite.

> +       .test_cases = memcpy_test_cases,
> +};
> +
> +kunit_test_suite(memcpy_test_suite);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.30.2
>
