Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B495C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 20:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2BD60E8B
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 20:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ1Uoi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJ1Uoh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 16:44:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9DAC061745
        for <linux-hardening@vger.kernel.org>; Thu, 28 Oct 2021 13:42:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n11so5297682plf.4
        for <linux-hardening@vger.kernel.org>; Thu, 28 Oct 2021 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mb/mWw8HAiK6lwVPCHL9I1kcRE7UYBim01+6DNM+U2o=;
        b=VmGwAq85nazzr23K6C1YnUPNR0Nc4o4CCUMv8SS811F81xRod2iIlDfsYm9jQL6wGo
         OkDnRt0mjseEgenzNWKb4WcrDpZQj633Qwjjvc08WOiptim/r+0uHf/uftiGGWXghcju
         CiY/p5U300wCXKVlPjGWpByMryqXfSRBHBlhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mb/mWw8HAiK6lwVPCHL9I1kcRE7UYBim01+6DNM+U2o=;
        b=r5gLJkZiranzuc9mugDm0eakht244knRIo8Om8oluRF4udWb7V29hAPDT2IXe1ymnw
         YWtlyEwuvYGzpCYJI9pPfPp2UF0QECPS5/8Xgzuo1F+6h82mZW/vbWwEhgwunXg6ZKsr
         HGtQB4f6+zMj9GtAi4b7UhxErooIq4pcvcnUu1Obj3KrIWx3638A2hMmgXQosVRSZK9i
         VT2x0NUS06TfNO2aZZga1mSrkDxMYc7qkARCPJkhSytww6pPfl0UH8wSqiOJqiU86Vgt
         nJbtV99FniYEfprUyJHOdiSghNpVUSk2dw91Z4I5AIsGBO3I/iwo0OXV1n7sRIWvuct4
         4NBw==
X-Gm-Message-State: AOAM530qnt6jkzPeLmlUS6yec3ntNPIPpSgZmD/uH3y3yNPq6vehVWoq
        sTVy0DJ6oniwSjVCa2wnqeQdMw==
X-Google-Smtp-Source: ABdhPJyacBcVTIrxQhqzTVhzpHTjk/+EXzvPVleAxcwhFltK0MGOmvy8hS1Z3zuaGutm0mZ0uPb2YA==
X-Received: by 2002:a17:902:a412:b0:140:a4a:4ba with SMTP id p18-20020a170902a41200b001400a4a04bamr5906072plq.52.1635453728984;
        Thu, 28 Oct 2021 13:42:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 125sm4230631pfv.155.2021.10.28.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:42:08 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:42:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
Message-ID: <202110281341.8479EC4759@keescook>
References: <20211013150025.2875883-1-arnd@kernel.org>
 <b35768f5-8e06-ebe6-1cdd-65f7fe67ff7a@arm.com>
 <721BDA47-9998-4F0B-80B4-F4E4765E4885@chromium.org>
 <20211028131526.d63d1074a8faa20e1de5e209@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028131526.d63d1074a8faa20e1de5e209@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 28, 2021 at 01:15:26PM -0700, Andrew Morton wrote:
> On Thu, 14 Oct 2021 19:40:45 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > 
> > 
> > On October 14, 2021 1:12:54 AM PDT, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> > >
> > >
> > >On 10/13/21 5:00 PM, Arnd Bergmann wrote:
> > >> From: Arnd Bergmann <arnd@arndb.de>
> > >> 
> > >> Calling memcmp() and memchr() with an intentional buffer overflow
> > >> is now caught at compile time:
> > >> 
> > >> In function 'memcmp',
> > >>     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
> > >> include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> > >>   263 |                         __read_overflow();
> > >>       |                         ^~~~~~~~~~~~~~~~~
> > >> In function 'memchr',
> > >>     inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
> > >> include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> > >>   277 |                 __read_overflow();
> > >>       |                 ^~~~~~~~~~~~~~~~~
> > >> 
> > >> Change the kasan tests to wrap those inside of a noinline function
> > >> to prevent the compiler from noticing the bug and let kasan find
> > >> it at runtime.
> > >> 
> > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > >Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > How about just explicitly making the size invisible to the compiler?
> > 
> > I did this for similar issues in the same source:
> > 
> > https://lore.kernel.org/linux-hardening/20211006181544.1670992-1-keescook@chromium.org/T/#u

This is already fixed in your tree with:

"kasan: test: consolidate workarounds for unwanted __alloc_size() protection"

which was based on this original patch (and my comments).

-- 
Kees Cook
