Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E6EC433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Dec 2021 22:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbhLCWqr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbhLCWqr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Dec 2021 17:46:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF64C061751
        for <linux-hardening@vger.kernel.org>; Fri,  3 Dec 2021 14:43:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x131so4163642pfc.12
        for <linux-hardening@vger.kernel.org>; Fri, 03 Dec 2021 14:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SmYifbLGwqLgym0oSL2qVAxGB2P0Q3oKi0tEXLbFFBY=;
        b=TxiZfUoAR2bg5aoZKx4d7ryFP0k11M0RRfUmuX3Gei4Rbd9RiGIGHbOH3BVVrI39RA
         dAA8ykWUoCp5BKU18FWadAS9rjjEOw68u+Nv7z8iGRxKpeslXUcEwImK8IaYJqtez4Zl
         4Zx85nCwE0mgLI8CsAb4liyNMAn8tb7qMf/2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmYifbLGwqLgym0oSL2qVAxGB2P0Q3oKi0tEXLbFFBY=;
        b=igceToXlM+SJjLlMjGZFdcSEKy/PrMcfat7j/+NhxXwalibWg1+COGNn7K9B43P1Cq
         /yXhhj1vzEWnMXJq4M/A7LrENx5oZxGIQkWd782EDSPVKcmok0TWtWtCK4hrOx+SpfCt
         XBswLqB5sb6ESzkGkUYFgXmjFErb0r1TXYH9DWen5fNFOeP0wndn+y5eV4tumorvrppB
         gr6SdDmm/0PgxXt3l5+napMjky1TmUOrmNCdW20ItQgepZH+HjY0Ybvut2iRFWDufgfU
         QrcGsEngAYyO+CJNs1BImbYPjjL+ad95OOskLU1EIQBKT+xQpVJTZIBqHeTvblrZVsLp
         a0CA==
X-Gm-Message-State: AOAM5307/ykp9S3IP7vPTXuHZtdqw3ns1EeSXc7QmSiiA0qyH7/sLC4D
        3rMUVuaY8LxfNu7khuJzADmcIQ==
X-Google-Smtp-Source: ABdhPJywlcC0fEnqgj2OSMlQxPTmNufUhmu/pZo3pN7KcH0xCLDIjIxCrMCJ+EFItl2GrFZyqJap9g==
X-Received: by 2002:a05:6a00:24cd:b0:49f:a4d8:3d43 with SMTP id d13-20020a056a0024cd00b0049fa4d83d43mr22001716pfv.49.1638571402607;
        Fri, 03 Dec 2021 14:43:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm3158747pjh.1.2021.12.03.14.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:43:22 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:43:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <202112031441.200FE4975@keescook>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <E1A4953A-8801-48FA-A744-63DA548C5924@chromium.org>
 <20211203191611.GB450223@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203191611.GB450223@lapt>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 03, 2021 at 11:16:11AM -0800, Yury Norov wrote:
> On Fri, Dec 03, 2021 at 08:37:59AM -0800, Kees Cook wrote:
> > 
> > 
> > On December 3, 2021 4:30:35 AM PST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > >> It's common practice to cast small variable arguments to the find_*_bit()
> > >
> > >It's a bad practice and should be fixed accordingly, no?
> > 
> > There's an argument to be made that the first arg should be void * but that's a pretty invasive change at this point (and orthogonal to this fix).
> 
> What for? To save at most 7 bytes of alignment overhead for bitmaps
> like char bitmap[sizeof(unsigned long) + 1]?

I just meant to simplify the calling conventions. Right now everyone has
to cast to unsigned long *, which doesn't seem right: alignment and
strides can be done in the routine. But, I have no strong opinion about
this; it's just something I noticed while looking at it.

-- 
Kees Cook
