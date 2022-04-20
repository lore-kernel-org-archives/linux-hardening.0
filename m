Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD3EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 12:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350988AbiDTMgb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbiDTMga (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Apr 2022 08:36:30 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312F3FDB9
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 05:33:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o16so1639133ljp.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YK1gwQHfzWNPMKl1EIpM7XtIAL3qDFBevpSSKsKoNRY=;
        b=nPa8hfPZywMg937IwHbiNMiNe8EsqyiDAnCYtzJBpjQaHy1d4TpWnr2834Me5gYmy6
         qTW2rv5tNUcbKvQgNCcpb7eEm7/s0Pg6OtLyEXP2aL8WySIbMfxMX/Cc9L+LqMsCMvYJ
         bjgQaQ25ApPqwrTi0/ibvD/VIeeh6l3EQ5Jd1NTSscsl8uaVbtXR6ekbs9Lpnori+E50
         2ah6ROt2CtGASMwpjB3xM1pNorO2ZOpzRd5sEsXlmPay6hjuSlTelSxM3gUyxMmJzU9e
         6T29Qsgm2Q9D5xKR0YMR4TKrumrG7NXHLcHv3ufx+hwDy1gq66fKoJ7AtqK6OORx8kRO
         Tpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK1gwQHfzWNPMKl1EIpM7XtIAL3qDFBevpSSKsKoNRY=;
        b=tArFX7buZvOsi0L3CFbIPUzeasMXDGJkStkKRNj0URYQkioyOQZmHkbaXeClJosAYR
         oX2QuVEkP/4bg2QWpeh6wGiikh8/FjV/sHsWT+dPcNbgrvpTMpvl9sPjhdXxCsGR+FUf
         IFsqnvc5PALskgcO9KXbXaMOUIfeCSr7blGV+RYo3LWle4mLyvXR53WO0LRNv5m03jR7
         VexeST4dewbkR6FVL/27y+buc/LfKPJSd5Bg4vu6cs6Sx+y13TfZF8FRPvv7+8xALl1W
         7uPtU1wtXhVN+pa8DbN26Bj5nvjaFqd3JXVgQ/E5QxyLwnUIZa6z32053t3hNfd+VgkK
         a+lg==
X-Gm-Message-State: AOAM531khvch0Ejvs13UjEpS9zP0r1Tsy8c0m5aJUVywqXU0JA4hyPpv
        x0z1sM13xba7Yz0HDpykWTXb6YPiL7VD3kQZLqwfcA==
X-Google-Smtp-Source: ABdhPJxQh4qATIg7fh2d/Rn6HYLS5+wfjP3gtV1tUSHmAmwfdypDh6a+tcEIkZGaV0XlelDf1q6MHbymQ5w2b/7dafg=
X-Received: by 2002:a05:651c:1546:b0:24c:7e0c:38b1 with SMTP id
 y6-20020a05651c154600b0024c7e0c38b1mr13233370ljp.375.1650458022985; Wed, 20
 Apr 2022 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220419041742.4117026-1-keescook@chromium.org> <Yl+8K++wZUJCthMj@hovoldconsulting.com>
In-Reply-To: <Yl+8K++wZUJCthMj@hovoldconsulting.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Apr 2022 14:33:06 +0200
Message-ID: <CAG48ez2Pikm5g2RfJxae=jz1C7KSCWc99sCa7fXFBKvDOPJubA@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: Fix heap overflow in WHITEHEAT_GET_DTR_RTS
To:     Kees Cook <keescook@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 20, 2022 at 10:14 AM Johan Hovold <johan@kernel.org> wrote:
> On Mon, Apr 18, 2022 at 09:17:42PM -0700, Kees Cook wrote:
> > This looks like it's harmless, as both the source and the destinations are
> > currently the same allocation size (4 bytes) and don't use their padding,
> > but if anything were to ever be added after the "mcr" member in "struct
> > whiteheat_private", it would be overwritten. The structs both have a
> > single u8 "mcr" member, but are 4 bytes in padded size. The memcpy()
> > destination was explicitly targeting the u8 member (size 1) with the
> > length of the whole structure (size 4), triggering the memcpy buffer
> > overflow warning:
>
> Ehh... No. The size of a structure with a single u8 is 1, not 4. There's
> nothing wrong with the current code even if the use of memcpy for this
> is a bit odd.
>
> > In file included from include/linux/string.h:253,
> >                  from include/linux/bitmap.h:11,
> >                  from include/linux/cpumask.h:12,
> >                  from include/linux/smp.h:13,
> >                  from include/linux/lockdep.h:14,
> >                  from include/linux/spinlock.h:62,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/slab.h:15,
> >                  from drivers/usb/serial/whiteheat.c:17:
> > In function 'fortify_memcpy_chk',
> >     inlined from 'firm_send_command' at drivers/usb/serial/whiteheat.c:587:4:
> > include/linux/fortify-string.h:328:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >   328 |                         __write_overflow_field(p_size_field, size);
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> So something is confused here.

So something's going wrong in fortify_memcpy_chk()? It looks like it
is called with constant "size" equal to 1, and the condition
"p_size_field < size" (with an unsigned comparison) is either true
(meaning p_size_field would have to be 0) or not known at compile
time?

The original report says it happened when compiling with
CONFIG_CC_OPTIMIZE_FOR_SIZE=y, maybe that matters?
