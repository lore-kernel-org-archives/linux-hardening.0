Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32375C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 19:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABAF61002
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhJRT6V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233326AbhJRT6V (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 15:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55257611EF;
        Mon, 18 Oct 2021 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634586969;
        bh=mizSE5xBGArY9H4hUHcLjaxNkoiuCvEqrYP3b+c4OVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qga3VIFHjIyGNlkogxrbKR1Ch0/4iUjF4Jpxq/vwbv8fLxdQtjU2P4zidB38PuLFU
         xmDKZvmRHBOj8zfd+z1VLTO5cKZDFRwbwF9Q/P6OT3g678LZJ9RmGmDfqF7dFru9hg
         rRgvRN2ZT9xXPi09MyT2G0v67XukWDofjDsoSWRM96FnMgh1QxsPVbAfquUUcNs/aw
         mXfCQe4hYE3ypo+7y5bQMtoYo6aV4owJIMfPISg7zw89YFiZ/ARKrBHTJI2mfslUNF
         Mk/W5pdSYM6V2ZVgmGiFhnTZjbZEyGmodgtgeMf0qzmG05IDO92Hstlrr+eJSUHvKj
         kymKnVy2Wcjzw==
Received: by mail-wr1-f42.google.com with SMTP id e3so43144268wrc.11;
        Mon, 18 Oct 2021 12:56:09 -0700 (PDT)
X-Gm-Message-State: AOAM53189gGw9Ou1/DPY3vtZRWWtZLaLQH8m8QpLlpfrL5K9VAH5SsMx
        TaPl5ib/Qkzlh5SFdf8NOKiwLhNPfTw6Kr+VqXE=
X-Google-Smtp-Source: ABdhPJydyJsUzWWwJISFLo02CDRywgSn21yZ3GCOt41uSGSrZDdXqSTb4vc9BVHMFnC1YUXqQlzbL8QiLrbRSrCdDzA=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr37629747wrb.336.1634586967765;
 Mon, 18 Oct 2021 12:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211013150025.2875883-1-arnd@kernel.org> <202110181245.499CB7594B@keescook>
In-Reply-To: <202110181245.499CB7594B@keescook>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Oct 2021 21:55:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0huVQ+pGgHFNeeoOPAwP4+KiDfBYokVzQ=fUM-QJ+H+w@mail.gmail.com>
Message-ID: <CAK8P3a0huVQ+pGgHFNeeoOPAwP4+KiDfBYokVzQ=fUM-QJ+H+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 18, 2021 at 9:47 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Oct 13, 2021 at 05:00:05PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Calling memcmp() and memchr() with an intentional buffer overflow
> > is now caught at compile time:
> >
> > In function 'memcmp',
> >     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
> > include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> >   263 |                         __read_overflow();
> >       |                         ^~~~~~~~~~~~~~~~~
> > In function 'memchr',
> >     inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
> > include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> >   277 |                 __read_overflow();
> >       |                 ^~~~~~~~~~~~~~~~~
> >
> > Change the kasan tests to wrap those inside of a noinline function
> > to prevent the compiler from noticing the bug and let kasan find
> > it at runtime.
>
> Is this with W=1 ? I had explicitly disabled the read overflows for
> "phase 1" of the overflow restriction tightening...

I have a somewhat modified source tree that builds cleanly with W=1 after
disabling all the noisy ones, so this is probably one that I would not have
seen without it.

> (And what do you think of using OPTIMIZER_HIDE_VAR() instead[1]?
>
> [1] https://lore.kernel.org/linux-hardening/20211006181544.1670992-1-keescook@chromium.org/T/#u

Yes, that is probably better. I can try updating the patch tomorrow,
unless you do it first.

       Arnd
