Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF3C4321E
	for <linux-hardening@archiver.kernel.org>; Sun, 27 Nov 2022 00:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiK0AzQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiK0AzP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Nov 2022 19:55:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7F10553
        for <linux-hardening@vger.kernel.org>; Sat, 26 Nov 2022 16:55:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g10so7065858plo.11
        for <linux-hardening@vger.kernel.org>; Sat, 26 Nov 2022 16:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsLJX0InAbt1kTuvXLVor2ZX32CfM2qEUmM/5HpvT0k=;
        b=TX4xrszZ73TLZMRLzOtqL582Nxzu/yrD4HfU99RN3oNyKJ3LN7xrw8jELReSbxqhLc
         R/C7r8S9aPqKc4mLuSphopRGYkMrGuyaFEcLH/zLG1Hk4AFsHw4lyXNzjxdq7PJlWlq4
         yj9ajMuSinkA7YHL44VSc/tZ4f6Vzmd5LKE6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsLJX0InAbt1kTuvXLVor2ZX32CfM2qEUmM/5HpvT0k=;
        b=3r6kiD9/+2XJSem9rDDYySl25fAGm1QDMQrJiq1tJgzI0gR6pytJ7ocFoxTJGtkhhc
         LVStxTKvFTHxjdPTxyqY+vFlYXGJauPnrqlDuDH6fF+mfYgowqgRRFNgrry1OSKCfcmR
         w7HMnLGq+8gj8DYW7JRojtwMUIO2GBAGZ1NqM+zPb+w4xOQIoyB1mpVOoQzdLP1eG1ZH
         4LkhI0mz5+cKyXUKCFFUIU+ruDRZjAnuY/lUpA3XI3quwbfBBOHRVlEFV1raHq9PHVIE
         XblLmI91k6UU13o6sgbQrw9idDw012D39nxB2n+VAGnJqr6KLgnYmeQREKilL8OuxW3r
         Xeog==
X-Gm-Message-State: ANoB5pnreBVDvaGeL7ucCpINxjmD6wLSJLvvhMcxz9NqkHXNve2b5Svy
        IxYoPspRiKb6H/2O8rzlN30Gbg==
X-Google-Smtp-Source: AA0mqf7wp2FIhD0FntRgJT1eFEiJKsh2svj3J2IIiX3PvH1BlpkEYBccuTfOAsKeGGUK2B8MQFqdGA==
X-Received: by 2002:a17:903:1ce:b0:186:a2ef:7a69 with SMTP id e14-20020a17090301ce00b00186a2ef7a69mr25665561plh.77.1669510513461;
        Sat, 26 Nov 2022 16:55:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 70-20020a621749000000b0056da073b2b7sm5250323pfx.210.2022.11.26.16.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 16:55:12 -0800 (PST)
Date:   Sat, 26 Nov 2022 16:55:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Message-ID: <202211261654.5F276B51B@keescook>
References: <20221118035656.gonna.698-kees@kernel.org>
 <CA+fCnZfVZLLmipRBBMn1ju=U6wZL+zqf7S2jpUURPJmH3vPLNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfVZLLmipRBBMn1ju=U6wZL+zqf7S2jpUURPJmH3vPLNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Nov 26, 2022 at 06:04:39PM +0100, Andrey Konovalov wrote:
> On Fri, Nov 18, 2022 at 4:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > With all "silently resizing" callers of ksize() refactored, remove the
> > logic in ksize() that would allow it to be used to effectively change
> > the size of an allocation (bypassing __alloc_size hints, etc). Users
> > wanting this feature need to either use kmalloc_size_roundup() before an
> > allocation, or use krealloc() directly.
> >
> > For kfree_sensitive(), move the unpoisoning logic inline. Replace the
> > some of the partially open-coded ksize() in __do_krealloc with ksize()
> > now that it doesn't perform unpoisoning.
> >
> > Adjust the KUnit tests to match the new ksize() behavior.
> >
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Cc: linux-mm@kvack.org
> > Cc: kasan-dev@googlegroups.com
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2:
> > - improve kunit test precision (andreyknvl)
> > - add Ack (vbabka)
> > v1: https://lore.kernel.org/all/20221022180455.never.023-kees@kernel.org
> > ---
> >  mm/kasan/kasan_test.c | 14 +++++++++-----
> >  mm/slab_common.c      | 26 ++++++++++----------------
> >  2 files changed, 19 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> > index 7502f03c807c..fc4b22916587 100644
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -821,7 +821,7 @@ static void kasan_global_oob_left(struct kunit *test)
> >         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
> >  }
> >
> > -/* Check that ksize() makes the whole object accessible. */
> > +/* Check that ksize() does NOT unpoison whole object. */
> >  static void ksize_unpoisons_memory(struct kunit *test)
> >  {
> >         char *ptr;
> > @@ -829,15 +829,19 @@ static void ksize_unpoisons_memory(struct kunit *test)
> >
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +
> >         real_size = ksize(ptr);
> > +       KUNIT_EXPECT_GT(test, real_size, size);
> >
> >         OPTIMIZER_HIDE_VAR(ptr);
> >
> > -       /* This access shouldn't trigger a KASAN report. */
> > -       ptr[size] = 'x';
> > +       /* These accesses shouldn't trigger a KASAN report. */
> > +       ptr[0] = 'x';
> > +       ptr[size - 1] = 'x';
> >
> > -       /* This one must. */
> > -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size]);
> > +       /* These must trigger a KASAN report. */
> > +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> > +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);
> 
> Hi Kees,
> 
> I just realized there's an issue here with the tag-based modes, as
> they align the unpoisoned area to 16 bytes.
> 
> One solution would be to change the allocation size to 128 -
> KASAN_GRANULE_SIZE - 5, the same way kmalloc_oob_right test does it,
> so that the last 16-byte granule won't get unpoisoned for the
> tag-based modes. And then check that the ptr[size] access fails only
> for the Generic mode.

Ah! Good point. Are you able to send a patch? I suspect you know exactly
what to change; it might take me a bit longer to double-check all of
those details.

-Kees

-- 
Kees Cook
