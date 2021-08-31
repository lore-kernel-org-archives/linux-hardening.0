Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2041C4320A
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59756103A
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhHaRq7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhHaRq7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 31 Aug 2021 13:46:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4763C061764
        for <linux-hardening@vger.kernel.org>; Tue, 31 Aug 2021 10:46:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j2so11106216pll.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Aug 2021 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7VtopklDkVx9rWQ7VmtX224wBeDKumuy7TD9fs5BoM=;
        b=YhuvLsEj6SFK4fpO4TscKyqihlQ7QT3tF2+ttBY2FAahWa/8RQtvQY+LSrRqLiWwS9
         EeK5+xmPwYbIcHj/gTMc8O6snGB5rgvpaFaUjagSIx5GXTZEnTX0WxBvGBDDECzBALAT
         wnBVCPLQwVm+IlVXeV54EeEX6QMk8Iz1Hichg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7VtopklDkVx9rWQ7VmtX224wBeDKumuy7TD9fs5BoM=;
        b=shv2KOigmrsKATeJbBS6Y950tOJrJjNT4+iJ/7QBlVqVmZl7Y1N0d49E3hMEZgdFFD
         9zG+2WZtaZw+ddidrbTzxscGqVZ4VKwTTQjQuxdyjjRtzuJ/nuSUnp9mxfdSREHnmAOL
         VMFEwC+iS4E8KQT3ZrRZPDmg6d3MaLbPaGdd+60Z0VuqmfoeF46WHCqou9ekFa7S1inB
         oYqKCtpYIYiIemUe3/Zu92bJKCm9rLrVu99qyGmNLegS/UhffxAFNbE5yRrBtSiOjwkj
         PN80zB5WhPxW7k/yO02lwZ8pCSjk8rDHY5Thwrm3F3wVgjiN4ZO3C4dX9vIOv81VOZm8
         jyOg==
X-Gm-Message-State: AOAM532bTlgBuzBrSZf/oHcVPYxooR3ipt80bZTNmYP3Ga7GkjgJq+Td
        GIGAjBBOAzXHlfroSskzPfUvUQ==
X-Google-Smtp-Source: ABdhPJzsjMuQU67S6mA83MZGXgytEtrA01XwQsbUsMeMmG6Xkfg+OH9K0pPUqTURRdxYblTcTFTHaA==
X-Received: by 2002:a17:90b:2212:: with SMTP id kw18mr6716149pjb.59.1630431963219;
        Tue, 31 Aug 2021 10:46:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b69sm2927963pfb.64.2021.08.31.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:46:02 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:46:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 4/5] Makefile: Enable -Warray-bounds
Message-ID: <202108311042.FFE1818D@keescook>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <20210827163015.3141722-5-keescook@chromium.org>
 <20210831043128.GA2749311@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831043128.GA2749311@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 30, 2021 at 09:31:28PM -0700, Guenter Roeck wrote:
> On Fri, Aug 27, 2021 at 09:30:14AM -0700, Kees Cook wrote:
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
> > index e4f5895badb5..8e7e73a642e2 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -995,7 +995,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
> >  
> >  # We'll want to enable this eventually, but it's not going away for 5.7 at least
> >  KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
> >  
> 
> This patch causes 'alpha' builds to fail when trying to build an image with
> gcc 11.2.
> 
> In file included from include/linux/string.h:20,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/smp.h:13,
>                  from include/linux/lockdep.h:14,
>                  from include/linux/spinlock.h:63,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:6,
>                  from include/linux/mm.h:10,
>                  from include/linux/pagemap.h:8,
>                  from arch/alpha/mm/init.c:10:
> In function '__memset',
>     inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
> arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> In function '__memset',
>     inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
> arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
> In function '__memset',
>     inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
> arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>    37 |                         return __builtin_memset(s, c, n);
> 
> Seen in next-20210830.

Ah-ha, thanks for the report! I didn't see this in my builds -- what
config target did you use for this?

Looks like GCC isn't happy about an unsigned long->void * conversion
here...

include/asm/page.h:#define PAGE_OFFSET          0xfffffc0000000000UL
...
include/uapi/asm/setup.h:#define KERNEL_START_PHYS      0x1000000 /* required: Wildfire/Titan/Marvel */
include/uapi/asm/setup.h:#define EMPTY_PGT (PAGE_OFFSET+KERNEL_START_PHYS+0x04000)
...
mm/init.c:      memset((void *) EMPTY_PGT, 0, PAGE_SIZE);

I'll try to figure out the right annotations to fix this...

-- 
Kees Cook
