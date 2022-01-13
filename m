Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04152C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Jan 2022 18:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiAMS3H (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiAMS3G (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Jan 2022 13:29:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21160C06161C
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jan 2022 10:29:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a7so8217160plh.1
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jan 2022 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GNbIhnDu8mbLRfTXlwtBvscLfboFwv21ObpyqMknyMU=;
        b=l4lXFAvPwW8ptxy2c92znFTwv5GsqM4IWfYUgkhhMcp1Pwk9cZeNmv1nWmiKNpG1pS
         uVEQ8lRvKYFGHNpC7aW2avDuuHb2/xXtNHRvyQYQ3riMGlcSs6yYg89/yL1boexm0oQz
         Qav0Txllf4/MZlJyWhkghlFTqMUlquKTz0IAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GNbIhnDu8mbLRfTXlwtBvscLfboFwv21ObpyqMknyMU=;
        b=hSqFe4excYaNwOEia1bbRL1FYYa4+6l7jEeF/dCMFloFfCSML1vE+hdSOq8snC2mVO
         mbqLyZs01qHY6ocsKci4kIHVpYDf9ludVc+1BWR+y0mnxYHcFTXqTtLKgpQyCAPigIz/
         xYIxdooPOW4o2re37eCaWb7GmSoklEYpBYNfBh+sM90N+W9glyKeU0m/J4h2LQ6NQ7kr
         n2fPeUVjPaJtYyZnIfePSTrpdfRMcJ4HmwdEGGXUTEtCz4KkbfOr447GWKRIS1+TrglJ
         cURVmsJnGjkdLh3AwQDuvLjZa5LOBV0hBLDuJEPvdmFxQTTz9uPTu8A6Rj/UYi1AnkCo
         iejw==
X-Gm-Message-State: AOAM531bnwNX9Y6zP0MLgpYKYxQGNPWrCMt1h02xCfxI/Nv/h9Rm3bmM
        mrbKhr5y/kM3nBZZ7mx5QSi+rA==
X-Google-Smtp-Source: ABdhPJxbEiRlNgouAu1xXHQaBLC6lvNqbdwcbBhm0vZPbQdO6PK0RrNQGS6ckHyBEZKhLggIwJtG9w==
X-Received: by 2002:a17:903:404a:b0:14a:501b:8c92 with SMTP id n10-20020a170903404a00b0014a501b8c92mr5952668pla.86.1642098545687;
        Thu, 13 Jan 2022 10:29:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q2sm3660966pfu.66.2022.01.13.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 10:29:05 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:29:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Check for NULL header value
Message-ID: <202201131027.FCAC3072E4@keescook>
References: <20220113002001.3498383-1-keescook@chromium.org>
 <Yd/tSpnpb4vWp6OP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd/tSpnpb4vWp6OP@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 13, 2022 at 10:13:46AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 12, 2022 at 04:20:01PM -0800, Kees Cook wrote:
> > When building with -Warray-bounds, the following warning is emitted:
> > 
> > In file included from ./include/linux/string.h:253,
> >                  from ./arch/x86/include/asm/page_32.h:22,
> >                  from ./arch/x86/include/asm/page.h:14,
> >                  from ./arch/x86/include/asm/thread_info.h:12,
> >                  from ./include/linux/thread_info.h:60,
> >                  from ./arch/x86/include/asm/preempt.h:7,
> >                  from ./include/linux/preempt.h:78,
> >                  from ./include/linux/rcupdate.h:27,
> >                  from ./include/linux/rculist.h:11,
> >                  from ./include/linux/sched/signal.h:5,
> >                  from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
> >                  from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
> > In function 'memcpy',
> >     inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
> > ./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
> >    41 | #define __underlying_memcpy     __builtin_memcpy
> >       |                                 ^
> > 
> > This is because the compiler sees it is possible for "ptr" to be a NULL
> > value, and concludes that it has zero size and attempts to copy to it
> > would overflow. Instead, detect the NULL return and error out early.
> > 
> > Cc: Larry Finger <Larry.Finger@lwfinger.net>
> > Cc: Phillip Potter <phil@philpotter.co.uk>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Michael Straube <straube.linux@gmail.com>
> > Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_recv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > index 41bfca549c64..61135c49322b 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > @@ -1513,6 +1513,9 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
> >  	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
> >  	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
> >  
> > +	if (!ptr)
> > +		return _FAIL;
> 
> This will never happen, so let's not paper over compiler issues with
> stuff like this please.
> 
> As the call to get_recvframe_data() is only done in one place in this
> driver (in all drivers that look like this as well), it can just be
> replaced with the real code instead of the nonsensical test for NULL and
> then the compiler should be happy.
> 
> I'll gladly take that fix instead of this one, as that would be the
> correct solution here.

I changed it around, but it doesn't help. I assume this is because we
build with -fno-delete-null-pointer-checks, so the compiler continues
to assume it's possible for the incoming argument to be NULL.

Should I rearrange this to do a NULL check for precvframe before all the
assignments in addition to removing get_recvframe_data()?

-Kees

-- 
Kees Cook
