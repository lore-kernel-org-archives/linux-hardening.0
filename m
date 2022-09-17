Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BCBECAAA1
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Sep 2022 02:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIQCUk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Sep 2022 22:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQCUj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Sep 2022 22:20:39 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65D54C99
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 19:20:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o123so24501418vsc.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oGVwvUbROocDCKmIi63dwILH5RW1QiYjDieu+3HIGsc=;
        b=p4xe7FkTwPfgqVWHMfckvfXbZ74PEfbA+zGhE3mwURum3Wtwo6VikqJgSAObdpAFke
         MHgaf3cMGbcsp7NKYQST+kgVWi7QA/7EfeeoGpttq5en4rUxgqRWjbhB3n/S//vgR2uv
         S6WlzAYbgM9x6YRypeUAifzcU+4agyXG2WIF5YjQTmbFQQQ9PuFPqhCcTxCqC21V8Oma
         fehUSROGSD31s8uKBl1as5duo/aDD+hrtnyxHZxLITS42/VP+0byTiZn/qi2IZK9QjXQ
         G0LgZLpYHmcT0na0Uoui2L7qNB6jaNUt1Ej0X2zNAazPs/ALCYW+dn5M3uVKopRR+64h
         qv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oGVwvUbROocDCKmIi63dwILH5RW1QiYjDieu+3HIGsc=;
        b=JW+Y/2fD44R5WtQTKX14pHJ1bL3AhFHUejgbqHQWEzFx/LHg3YDC0WJ5v3JO+wdpNn
         jvLqpBdRav8MmGMb1yz82Bks4OYE+dD7J0oYK0HEtpFPysLYvFWmB3kEdG0DsO4Kqjcy
         dRu7sk0jQZzqTFTCKM9lVB4z3FkVdgG2Jk11msaAcAhZAjsIqLGRPVA3yWblqvLugjfs
         ipF86saobF6P9fMi2QaXU1ZZ2Iwf2y4dIj6e46ntJXxKtIc5Lcv61StJXUqi3YK885ml
         I9F+tW1U0FaUjS/XNbb+aKUl1mpH3FxrJiL7CsNmsvxyzRsR3hCtMopbG8bffR0a5fTP
         m5Aw==
X-Gm-Message-State: ACrzQf1CSdbnlI78WLaFQFJl5EjAYLqcLib7dU8AEymHHA1gP78sK9gW
        Q81WuLofYWXRmd+AHGGQGiFixOTu4P8Beucwpp38Fg==
X-Google-Smtp-Source: AMsMyM5q6QRJAwXaZJ4XFbVgFggwa1+pamVcYJuzMq6iNMYJMIVWBOPdicQlAri+7OMdOIMIErnmt4nZD65EK0hktVA=
X-Received: by 2002:a67:ed55:0:b0:39a:7942:f574 with SMTP id
 m21-20020a67ed55000000b0039a7942f574mr3217830vsp.65.1663381237345; Fri, 16
 Sep 2022 19:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220916135953.1320601-1-keescook@chromium.org>
In-Reply-To: <20220916135953.1320601-1-keescook@chromium.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 16 Sep 2022 20:20:00 -0600
Message-ID: <CAOUHufbUUf1--=qiseAYzjN2DdyCkf_x=CQboWYDduH7VgpXmQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/dumpstack: Inline copy_from_user_nmi()
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, dev@der-flo.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-perf-users@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-hardening@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 16, 2022 at 8:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> This fixes a find_vmap_area() deadlock. The main fix is patch 2, repeated here:
>
>     The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
>     designed to skip any checks where the length is known at compile time as
>     a reasonable heuristic to avoid "likely known-good" cases. However, it can
>     only do this when the copy_*_user() helpers are, themselves, inline too.
>
>     Using find_vmap_area() requires taking a spinlock. The check_object_size()
>     helper can call find_vmap_area() when the destination is in vmap memory.
>     If show_regs() is called in interrupt context, it will attempt a call to
>     copy_from_user_nmi(), which may call check_object_size() and then
>     find_vmap_area(). If something in normal context happens to be in the
>     middle of calling find_vmap_area() (with the spinlock held), the interrupt
>     handler will hang forever.
>
>     The copy_from_user_nmi() call is actually being called with a fixed-size
>     length, so check_object_size() should never have been called in the
>     first place. In order for check_object_size() to see that the length is
>     a fixed size, inline copy_from_user_nmi(), as already done with all the
>     other uaccess helpers.
>
>     Reported-by: Yu Zhao <yuzhao@google.com>
>     Link: https://lore.kernel.org/all/CAOUHufaPshtKrTWOz7T7QFYUNVGFm0JBjvM700Nhf9qEL9b3EQ@mail.gmail.com
>     Reported-by: dev@der-flo.net
>
> Patch 1 is a refactor for patch 2, and patch 3 should make sure we avoid
> future deadlocks.

Thanks!

Tested-by: Yu Zhao <yuzhao@google.com>

The same test has been holding up well for a few hours now. It used to
throw that warning in less than half an hour.
