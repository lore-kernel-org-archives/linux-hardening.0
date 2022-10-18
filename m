Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFAC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 10:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJRKPv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRKPu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 06:15:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95436B1BA3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 03:15:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so13555272pjl.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYbltMZ64D7hKvFQTXjLIPARfSfHVemLqW1KHFhpOJw=;
        b=a2JbG4PXkuao8NgxshI79Akk5safpmTtaDgWz7dDb/xODD7hfdgWQbTWR/hVtPJf/8
         Ed0McMKCrk31A3JODbEIJjTs62iyrEL8sS2w5F0ftSrBprIi8s4hjDFMUy3g2gDSs2JQ
         LFxciMt200wcopnUAqYZII+yKIgHL2K34H4AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYbltMZ64D7hKvFQTXjLIPARfSfHVemLqW1KHFhpOJw=;
        b=WFy5XBjt0JF3290+JumfZv8yP1hllE8RmcE4kPnIHPCm94RO5daHgoPMh9jn4n17IC
         0yObhjVTqfo0lc831WM86w+CHkj9sSHsyB415ntHA3+2PTTuyqIU//5cuYgnoGxh3L/R
         eQSLhR+DnogUsjGoQgDxS5bHbxEw8g8NoPKuy+9+MXebxT+e48gwaZqU31EliyRkI6ix
         M8m1sGaNiQ2xmws16hYLhv29gep69KpT4e6Ly5iG6X2Ly464CtBeCPgJHn5AAigCIz8q
         P6rwuA9NdEk2YxYpuA5pIMHp7ilozjwMjxBvN904wGogX29uEUuYLoxeU9gI6FPossJl
         UnZg==
X-Gm-Message-State: ACrzQf1zT7NsYY/eJgUaVIuIeZwb9jXxlMC1GopkiCBHM/oVvgMl//vv
        3VPPwPSCsQ4X8XEbfVQxxcWB/V7YA77Bkg==
X-Google-Smtp-Source: AMsMyM45fpCWMbhUwSQa4qqlAC/5HONfOVazlMSqRilbb2GgOwvHEIL5Wxs4HvOt0+aeEnPhJsXwGQ==
X-Received: by 2002:a17:902:ef96:b0:17e:e7f3:31db with SMTP id iz22-20020a170902ef9600b0017ee7f331dbmr2355819plb.127.1666088138449;
        Tue, 18 Oct 2022 03:15:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v8-20020a654608000000b0044046aec036sm7638023pgq.81.2022.10.18.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:15:37 -0700 (PDT)
Date:   Tue, 18 Oct 2022 03:15:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] driver core: Add __alloc_size hint to devm allocators
Message-ID: <202210180310.A13EAA7@keescook>
References: <20221018073430.never.551-kees@kernel.org>
 <d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 12:09:30PM +0200, Rasmus Villemoes wrote:
> On 18/10/2022 09.34, Kees Cook wrote:
> > Mark the devm_*alloc()-family of allocations with appropriate
> > __alloc_size() hints so the compiler can attempt to reason about buffer
> > lengths from allocations.
> > 
> 
> > @@ -226,7 +226,8 @@ static inline void *devm_kcalloc(struct device *dev,
> >  void devm_kfree(struct device *dev, const void *p);
> >  char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
> >  const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
> > -void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
> > +void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
> > +	__alloc_size(3);
> 
> I think it's wrong to apply the __malloc attribute to kmemdup() and
> variants.
>
> 'malloc'
>      This tells the compiler that a function is 'malloc'-like, i.e.,
>      that the pointer P returned by the function cannot alias any other
>      pointer valid when the function returns, and moreover no pointers
>      to valid objects occur in any storage addressed by P.

Oh, ew, it defines rules about _contents_ as well. Thank you for
pointing that out!

I suppose we can use __realloc_size for these cases then?

-- 
Kees Cook
