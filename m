Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695D3C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Jun 2022 06:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiFIGzR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Jun 2022 02:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiFIGzQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Jun 2022 02:55:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453951105C6
        for <linux-hardening@vger.kernel.org>; Wed,  8 Jun 2022 23:55:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i39so12216390ybj.9
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jun 2022 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hzn4RqA/oVkoeaB2GIBLmXQFW/1IHl+Sw+drpCifoBo=;
        b=rbSfirctn1ihsei+9/2RiWuCazFO4CC1EsqwPZwmG40XlDDfipAqj+drfb6Lsq1ccG
         mbUrK05zBuB5ioiKD3NGJpjqZHQTunqAXjgGYblpaOCRIafkTMperWsJUZrwvexbtKaC
         /vOqng4090WTULSKLbgT8h3pCn7PXCQx48+L6T1a8H6Rd0PtfjqrF2Gaf9Gc0O+oardP
         OlQ89tkpPXVAtWZ0fS/jc8jeDLc47gKXFTM48lqwGxjAGnH5qsW+K+p/IG6XFs4KRoWP
         c08TCPgwivPjaJK5mjETv69Aeii7izIEeF9ND3HzYJB8VSRD57ot/YNoxoCPe4/ATTQC
         NILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hzn4RqA/oVkoeaB2GIBLmXQFW/1IHl+Sw+drpCifoBo=;
        b=VO6cMKpbiXaRWXlyP5ZynMjqqLtfAXacdzS5/C24v9Kx1q9q4ElYeU5P3GPp3En5is
         wqTKkL85psthfzjVID3aHsRjy3+Ust0bFL7jxlc84XVVLknfhTBhMnQjlM93kOsTPRJn
         7Ixs6KksI2mg3PNZHLLNiNJJpM6DZtqZ9/NqTFQH4uo/2J5nz/NoY4NRTSE0p4pfiBA2
         vNMWwNfS5QfFcBbwv0IIOiNczOnOgUPyoMrC79hTgXAooJBYjCy3kUM++6mSMLU4WBYq
         V2xJJWAJpFbcMS6jAFzns+Bkd69fJTcu36TuwtRwF7zAySFHZpRuzMKUyDLWbGUPtGfu
         UVzQ==
X-Gm-Message-State: AOAM531PzMzAo09TyKutFq4BeaedadAyt6T00YgQqI9gPsh4j2hIBPCS
        rknVfL5bW7CsaAZzsODIwagmcxcHxRfnae0YKI4nIw==
X-Google-Smtp-Source: ABdhPJw2xuGWyqVKAnnJUv52k+cZtRW6BdNoa4788f8plmlsprCQFLMJcRsGinm7LZ/u7kZVZOv2LXweQIO8hTmHSiY=
X-Received: by 2002:a25:b686:0:b0:664:2b6:8e13 with SMTP id
 s6-20020a25b686000000b0066402b68e13mr6435489ybj.533.1654757714276; Wed, 08
 Jun 2022 23:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220608214024.1068451-1-keescook@chromium.org>
In-Reply-To: <20220608214024.1068451-1-keescook@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 08:54:37 +0200
Message-ID: <CANpmjNPNM4pB0H2X9iR6F3LeOBsbzj7+eE7fAUEy0Rp8db77XQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Silence GCC 12 warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 8 Jun 2022 at 23:40, Kees Cook <keescook@chromium.org> wrote:
>
> GCC 12 continues to get smarter about array accesses. The KASAN tests
> are expecting to explicitly test out-of-bounds conditions at run-time,
> so hide the variable from GCC, to avoid warnings like:
>
> ../lib/test_kasan.c: In function 'ksize_uaf':
> ../lib/test_kasan.c:790:61: warning: array subscript 120 is outside array bounds of 'void[120]' [-Warray-bounds]

Since this keeps happening, I wonder if we could just pass
'-Wno-array-bounds' ? We already have 'CFLAGS_test_kasan.o += $(call
cc-disable-warning, vla)'.

Although eventually I'd assume all the OPTIMIZE_HIDE_VAR() should be
in place, and hopefully it'll have been the last one. I leave it to
you.

>   790 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
>       |                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> ../lib/test_kasan.c:97:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
>    97 |         expression; \
>       |         ^~~~~~~~~~
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/test_kasan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index c233b1a4e984..58c1b01ccfe2 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -131,6 +131,7 @@ static void kmalloc_oob_right(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         /*
>          * An unaligned access past the requested kmalloc size.
>          * Only generic KASAN can precisely detect these.
> @@ -159,6 +160,7 @@ static void kmalloc_oob_left(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, *ptr = *(ptr - 1));
>         kfree(ptr);
>  }
> @@ -171,6 +173,7 @@ static void kmalloc_node_oob_right(struct kunit *test)
>         ptr = kmalloc_node(size, GFP_KERNEL, 0);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
>         kfree(ptr);
>  }
> @@ -191,6 +194,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
>
>         kfree(ptr);
> @@ -271,6 +275,7 @@ static void kmalloc_large_oob_right(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
>         kfree(ptr);
>  }
> @@ -410,6 +415,8 @@ static void kmalloc_oob_16(struct kunit *test)
>         ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>
> +       OPTIMIZER_HIDE_VAR(ptr1);
> +       OPTIMIZER_HIDE_VAR(ptr2);
>         KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 = *ptr2);
>         kfree(ptr1);
>         kfree(ptr2);
> @@ -756,6 +763,8 @@ static void ksize_unpoisons_memory(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         real_size = ksize(ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
> +
>         /* This access shouldn't trigger a KASAN report. */
>         ptr[size] = 'x';
>
> @@ -778,6 +787,7 @@ static void ksize_uaf(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         kfree(ptr);
>
> +       OPTIMIZER_HIDE_VAR(ptr);
>         KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
>         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
>         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> --
> 2.32.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220608214024.1068451-1-keescook%40chromium.org.
