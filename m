Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Feb 2022 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbiBYRiD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiBYRh6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Feb 2022 12:37:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA917053
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 09:37:24 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p8so5267035pfh.8
        for <linux-hardening@vger.kernel.org>; Fri, 25 Feb 2022 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02IWQGflWXjYwUX29jDdu/P28RFJb4bHYd+IQuUew8g=;
        b=kUgfr+BUSyJkVMN/Doh8ZyiibLenLl15zo6bOy4rWBJYX17usBgH/o8iJTHO5XKZdv
         FIRoxVZBZpjCBE2RUff++qJBIi09y14ofiD3ly3QeSlZp5xJscoOCHa7IsD8lgTU/o1J
         xO0CrtIahGKQzcczYaERI0DLYTA+5L/usaOtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=02IWQGflWXjYwUX29jDdu/P28RFJb4bHYd+IQuUew8g=;
        b=NROtDE+y07eiT8BRYglSLSCcnxrrJ56nmU07w+gMTuO6zW2iVLrJlgO7U0DKADviQR
         8PtV6FO4g2DqMNCyzhtw9rr227zZLZHx5IsxqKUOf9/IS9TY7Mmgv+fV4u7y8Mod3Vfm
         5YMFSnTdWr4L3qfya7gKH8ocOVmuyf3wJ+ahkii3vuLV1NxQ4tOO0Awb3ROWuiOc/DAF
         C6hYTAjj2RG5WDvEbRPnYcONJao16xCu/6s8pYq7Lcz9ooRcp7l28ZORa8ziZE09rylo
         Ei6U4UNm+dK4qKJA8magdmAg/wgDuKzxOORPjRmS9F7gT4SkNTSzTdWZ5Mf3/zUfcUay
         UoMg==
X-Gm-Message-State: AOAM532UNylIWdeEO/l/JEjv7GD+VPIv8LcrM4BaJqNLoGygF67TPji3
        Dd+7SnZW/OxyCfTovRDM82BCWw==
X-Google-Smtp-Source: ABdhPJxa8cWp+caZT/XsGUM3pG14CnQKF4h0alaujNsw9OZoKX05Fs4iuNMYG7vu03MfC/TBygUB5w==
X-Received: by 2002:a63:8543:0:b0:35e:3bd9:3798 with SMTP id u64-20020a638543000000b0035e3bd93798mr7089608pgd.73.1645810644059;
        Fri, 25 Feb 2022 09:37:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id az22-20020a17090b029600b001bc6500625asm9681173pjb.45.2022.02.25.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:37:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 09:37:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Laight <David.Laight@aculab.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] m68k: Implement "current_stack_pointer"
Message-ID: <202202250936.BA139C4@keescook>
References: <20220224060448.1856091-1-keescook@chromium.org>
 <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
 <d75f1259c3e64387a161ebcb0448d594@AcuMS.aculab.com>
 <CAMuHMdWtQ+B-01ZOwZNvgQ7pndNsP3V90_jHdR=RS4K7O3Vk9g@mail.gmail.com>
 <95b9c3e8227a4892b26cc0384d1782c2@AcuMS.aculab.com>
 <CAMuHMdU6msvi0j=mS28GFYbm+uMRk7PkYe+zOM4sDmOVxeibLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU6msvi0j=mS28GFYbm+uMRk7PkYe+zOM4sDmOVxeibLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 24, 2022 at 10:56:09AM +0100, Geert Uytterhoeven wrote:
> Hi David, Kees,
> 
> On Thu, Feb 24, 2022 at 10:54 AM David Laight <David.Laight@aculab.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Sent: 24 February 2022 09:17
> > >
> > > On Thu, Feb 24, 2022 at 10:12 AM David Laight <David.Laight@aculab.com> wrote:
> > > > From: Geert Uytterhoeven
> > > > > Sent: 24 February 2022 08:59
> > > > ...
> > > > > > +register unsigned long current_stack_pointer __asm__("sp");
> > > > >
> > > > > I don't know what HARDENED_USERCOPY does, so I don't know if you need
> > > > > "usp" (see rdusp()) or "sp"?
> > > >
> > > > HARDENED_USERCOPY significantly slows down some systems calls
> > > > (especially things like sendmsg()) by trying to run-time verify
> > > > that the kernel buffer doesn't overrun a stack frame or kmalloc()ed
> > >
> > > Kernel stack frame of user stack frame?
> >
> > Kernel, the kernel doesn't care if the user stack gets trashed.

Right, this is strictly a kernel-side check in mm/usercopy.c:
https://lore.kernel.org/linux-hardening/20220225173345.3358109-1-keescook@chromium.org/

> 
> OK.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Kees: Do you want me to queue this in the m68k for-v5.18 branch, or do
> you want to take it yourself, together with the HARDENED_USERCOPY work?
> In case of the latter:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Please let me know. Thanks!

Yeah, I'll take it via my tree, just so it's all together.

Thanks!

-Kees


-- 
Kees Cook
