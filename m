Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03ECC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiBPQWe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:22:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiBPQWe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 11:22:34 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12177EA744
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 08:22:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id e17so2529155pfv.5
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iH8izYx1CVz5zaeZ+ywlrsYpOCO6qk+mt4vdLHF4sUs=;
        b=eSk+1+Ggbfk0AhU70cpJBicS0hA69s9vK1Bi7n96BbfWLI6zRs8x+KOsBbAI8mclXZ
         3Zc8R9z9rkUEnkYWm55iGCZZ3nKpgsokl9S80sgZwB8Oh40iBMxq/oIobscYaTUl5IBA
         qh6yZLZLx4cteFegp47jDWPXBTBGtxZ10S+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iH8izYx1CVz5zaeZ+ywlrsYpOCO6qk+mt4vdLHF4sUs=;
        b=yNVnc8Ea/pwV/nmDW5Jm7iHOgr1h1xTXfYVHGHRj2y2Sw+JQwic3xKER2RuuEULhcA
         +C6kPYKqMase7yRXrxwEVFA0Qvc9YRNWTX67y3TfRtit9DuXWdZQzF0VEApfmNWeWHfv
         GzV65Nl2xh0ssy3DLpwIpqvkoohHImejDX7mzFo3OjoyeGXmHX73Rz6wnjBv+o6I0qtz
         Ny5yl8eBtoOiaa8QQygFvczvGz9uxWFWnmYbm0D1hNfIA7hvx3T1ysFRVfO0/8AoVuqf
         097IXNS4EXGS0/vlmNBq45FQNX2zu4RIujkxq1GZIEVDIwE/q8+jECoj2e/3kv19Ekd2
         Qvwg==
X-Gm-Message-State: AOAM53273+VgN6vTAvjB24uGgOqhXMD5oBBSbzrkr3xxUi1ITJeIbeQ6
        VUP38yn1X1zZGiGQfvXckG6M0w==
X-Google-Smtp-Source: ABdhPJwM35c8o4itXQ75uRT0gT9Q8ANPfi0G8/4vakNLoGb1EtCDC2a/D8VE1q3PilaofUGS3lvheQ==
X-Received: by 2002:a05:6a00:2387:b0:4e0:5414:da5c with SMTP id f7-20020a056a00238700b004e05414da5cmr3976133pfc.85.1645028541563;
        Wed, 16 Feb 2022 08:22:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h26sm5903093pgm.72.2022.02.16.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:22:21 -0800 (PST)
Date:   Wed, 16 Feb 2022 08:22:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kasan: test: Silence allocation warnings from GCC 12
Message-ID: <202202160821.AA9264A71@keescook>
References: <20220213183232.4038718-1-keescook@chromium.org>
 <CA+fCnZfOSD56Uvetqd=ofv-Wxw6LOOZv3sUDcEuX2F3u-MgL9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfOSD56Uvetqd=ofv-Wxw6LOOZv3sUDcEuX2F3u-MgL9Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 04:26:46PM +0100, Andrey Konovalov wrote:
> On Sun, Feb 13, 2022 at 7:32 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > GCC 12 is able to see more problems with allocation sizes at compile
> > time, so these must be silenced so the runtime checks will still be
> > available. Use OPTIMIZER_HIDE_VAR() to silence the new warnings:
> >
> > lib/test_kasan.c: In function 'ksize_uaf':
> 
> Hm, the warning mentions ksize_uaf, but none of the changes touch it.

Excellent point -- let me go re-test this.

-Kees

> 
> > lib/test_kasan.c:781:61: warning: array subscript 120 is outside array bounds of 'void[120]' [-Warray-bounds]
> >   781 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> >       |                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
> >    96 |         expression;                                                     \
> >       |         ^~~~~~~~~~
> > In function 'kmalloc',
> >     inlined from 'ksize_uaf' at lib/test_kasan.c:775:8:
> > ./include/linux/slab.h:581:24: note: at offset 120 into object of size 120 allocated by 'kmem_cache_alloc_trace'
> >   581 |                 return kmem_cache_alloc_trace(
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~
> >   582 |                                 kmalloc_caches[kmalloc_type(flags)][index],
> >       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   583 |                                 flags, size);
> >       |                                 ~~~~~~~~~~~~
> >
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: kasan-dev@googlegroups.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  lib/test_kasan.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 26a5c9007653..a19b3d608e3e 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -124,6 +124,7 @@ static void kmalloc_oob_right(struct kunit *test)
> >
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >
> >         /*
> >          * An unaligned access past the requested kmalloc size.
> > @@ -185,6 +186,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
> >
> >         kfree(ptr);
> > @@ -265,6 +267,7 @@ static void kmalloc_large_oob_right(struct kunit *test)
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
> >         kfree(ptr);
> >  }
> > @@ -748,6 +751,7 @@ static void ksize_unpoisons_memory(struct kunit *test)
> >
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         real_size = ksize(ptr);
> >
> >         /* This access shouldn't trigger a KASAN report. */
> > --
> > 2.30.2
> >

-- 
Kees Cook
