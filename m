Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46035C433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 20:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbiBBU4D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbiBBU4D (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 15:56:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE00C06173B
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 12:56:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so8028199pjq.0
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+MOwEsZXX1JZ92aEsSTA+4bQ9fwXO7uqj6443Uicqb0=;
        b=Mb5OwFKvf8tT0DvmVkSF03zpcm3XzqSHtUtuMB8JAyioHdfW8f1uw1h2J6Oi+HuZLb
         3LH+5wQkRmNadqvUPytAJvY42l3NtWc5K9Qh9vU1oRYmBEQ2jlHROGDTkZ7g2fyV3Rvv
         xhWjglkXHBLAiS2L/bD5rGfl/Mrf6dN2i0eFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MOwEsZXX1JZ92aEsSTA+4bQ9fwXO7uqj6443Uicqb0=;
        b=WCjr/hweXba4ud89fQ0XOo2qXcGXpbzyewV3X/yCOO6Jqg5c3aEbjoRMavuGC/bWJ5
         RhR3zeg1aWFGI3HW/4KWLmJ9ffq8D5OPiIvZY5/oa44A8UuQ1tWeXY2Rxq+sx3rajqej
         3DRtGqumodTU86FdkSBqJpH9s2VMUr5A0Dz7fimb2Wd9Bzf9b5CXyzxlkIu3x21hXQUX
         rQEdSYiOWRWtxWo5IZk7UvipgaJBsV196Amw0zq40gTSxDu5W00dj+7fbTGD1ZiS/w+5
         gDuzScSfSki9T05uL96/4vaMwAjOelFTfRSMJPzs064kTqx9fpRLm5/WBekNV6E+cl2p
         NSDw==
X-Gm-Message-State: AOAM530QMUZbtcxnrpeDHS/8RYesd/otW2gdBvyT1M7gSOxc9DzEVFB9
        qM/p6LC5KfwgvCfbhKpYqCEk90lHKTFIWQ==
X-Google-Smtp-Source: ABdhPJyfeZdi8A1JowZl63xE7cjRteRe2f/EQsWsDnneOxd/1gPZEhtH8tPe/EVOXmca0ssZNZc69w==
X-Received: by 2002:a17:90a:548:: with SMTP id h8mr10099210pjf.109.1643835362724;
        Wed, 02 Feb 2022 12:56:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14sm28023672pfv.212.2022.02.02.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:56:02 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:56:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202202021254.5A1FD4FFBF@keescook>
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
 <20220202160903.GA2337834@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160903.GA2337834@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 02, 2022 at 08:09:03AM -0800, Guenter Roeck wrote:
> On Wed, Aug 18, 2021 at 01:11:17AM -0700, Kees Cook wrote:
> > With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
> > coverage, it is now possible to enable -Warray-bounds. Since both
> > GCC and Clang include -Warray-bounds in -Wall, we just need to stop
> > disabling it.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: linux-kbuild@vger.kernel.org
> > Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Makefile | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index a4aca01a4835..af22b83cede7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1072,7 +1072,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
> >  
> >  # We'll want to enable this eventually, but it's not going away for 5.7 at least
> >  KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
> > -KBUILD_CFLAGS += -Wno-array-bounds
> >  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
> >  
> >  # Another good warning that we'll want to enable eventually
> 
> alpha:defconfig:
> 
> In function '__memset',
>     inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> In function '__memset',
>     inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> In function '__memset',
>     inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);

Thanks! I'll take a look. Every instance of the "[0, 0]" bounds means
the compiler believes there's a way for the destination to be determined
at compile-time to be NULL.

> xtensa:allmodconfig:
> --------------
> Error log:
> In file included from include/linux/uaccess.h:11,
>                  from include/linux/sched/task.h:11,
>                  from arch/xtensa/kernel/process.c:21:
> arch/xtensa/kernel/process.c: In function 'copy_thread':
> arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above array bounds of 'long unsigned int[16]'

I assume this is a weird cast. I will also check this one out.

Thanks!

-- 
Kees Cook
