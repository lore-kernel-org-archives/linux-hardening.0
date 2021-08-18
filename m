Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCFC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254E2610E6
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhHRRcl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhHRRck (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 13:32:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D7C0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:32:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o2so2976640pgr.9
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cZiGf9NqEbSIzjZ0ZsTq8YmVi8aldxtom00P1asafmc=;
        b=YTc6jfMCddIaLswA48fTheTTk8fBRyNo12VVvmvmb1+vhmdXGY+Hu+5jkTk4rG3YT8
         BuuZKeur8vRJFleLgiRPeT2BWk+mpY7QdhWg6vQd2s16RPW/k9ZUEkcral3lvl6Z8v9b
         Dmr74QBXC7h9gFNxwncahDmGpC7yInXnBfXO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZiGf9NqEbSIzjZ0ZsTq8YmVi8aldxtom00P1asafmc=;
        b=pw40CKy1qrMFK8mvghD+gRnnmalpYz7cKD5eoSTy+i3R4VrgPC2dI0jeS8f4pFL0t8
         jetYw6G4QI/eHKl8hY8Jkw67kLVqrxDSg6bjCeXH9C6HSW/aqoM2BOga2C77tTbhmZOb
         W/RcbZtbEy4YPQTaeq+CJXcNTVe1pvZClwGShJyOd5v7YMAVxp7RRyoYs+Y+ZZeeVxlh
         8diCBOzhDZr0KTxrsaF+vlR19yoGhODc2LQDTxTZUe0UXCYzpvr3647KwkAxrv+U+NHA
         Jec6bCQn76mRhcOLOXYAp+AfFwwGSkJD0aCY0yvQUd633p/A9yRsnfqTYBOmEIXtcvOz
         Pb9A==
X-Gm-Message-State: AOAM533kidPlNC93bL8vZh5Jsc5HNWVNPVDz9LSqEQ6vyii6YxiHx7gu
        A0zfkgK2brjKqnIJRj+eACoisg==
X-Google-Smtp-Source: ABdhPJw3y3hOsBlnISbJmmR0FIih7/OTc8YLhCrxI1K0la+zMdPFouSsc1sZrAwK4Xct8Z3BNdpEiA==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr9965214pgv.425.1629307925514;
        Wed, 18 Aug 2021 10:32:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm361257pfo.76.2021.08.18.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:32:04 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:32:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/heap: Avoid __alloc_size hint warning
Message-ID: <202108181030.F007BCE205@keescook>
References: <20210818044540.1601664-1-keescook@chromium.org>
 <YR0StuqeKm1vbaM5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR0StuqeKm1vbaM5@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 04:01:26PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 17, 2021 at 09:45:40PM -0700, Kees Cook wrote:
> > Once __alloc_size hints have been added, the compiler will
> > (correctly!) see this as an overflow. We are, however, trying to test
> > for this condition, so work around it with a volatile int.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/misc/lkdtm/heap.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> > index 3d9aae5821a0..e59fcbe00ae0 100644
> > --- a/drivers/misc/lkdtm/heap.c
> > +++ b/drivers/misc/lkdtm/heap.c
> > @@ -12,6 +12,8 @@ static struct kmem_cache *double_free_cache;
> >  static struct kmem_cache *a_cache;
> >  static struct kmem_cache *b_cache;
> >  
> > +static volatile int __offset = 1;
> 
> Perhaps a comment here as to why volatile is ok to use?  That feels like
> it is a hack around the compiler of today, what happens tomorrow when
> newer versions decide to ignore volatile as it "knows" no one ever
> changes it?

Sure, I can do that. LKDTM uses this a lot because it, by definition,
means the compiler cannot assume it knows anything about its value. (And
as such reloads from memory at every use, which is why it's frowned upon
anywhere else in the kernel.)

-- 
Kees Cook
