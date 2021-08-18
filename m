Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB4EC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC560E78
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRRQa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhHRRQ3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 13:16:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5798C0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:15:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso9360865pjb.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9sygy20fI2oL0kJi8mBbhY37SIpWJz/q6mr+StXZZU=;
        b=oU6cy+imYpRkxskembg3Gu5PucyPFy8HtFmsHk6V+BzEkQEnaov/yT4za7CTd2UtNM
         3wvmzYvjEfcGGNOiagmh8QXb0dMD8pcRFChEC18sZuvBsqEStL4HLxqlX6hZAVCYOqQR
         Rtwwo4IGSqLpiiVuKtRQ/WAzITNa3UY2o65o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9sygy20fI2oL0kJi8mBbhY37SIpWJz/q6mr+StXZZU=;
        b=qomgmaJndoK26fSjIAPjwWU9ul+vBQC59bGiv8XQGydAu4+WzJ35KuRencl/Qr0Vyt
         SIMSsqX/S14SPuc0GTR5TK/Abq96GzPvwHjTA1/evIjyIzt6DOnqHkQG/8u2oZRXHVP7
         uloH9z5SJxcOnzJo0wKQHiOQn4IfVGjiqKkM4JuoXxkTMGowRUhK1Txh+gDrMIFwdEN/
         cqd6t8P6OFMT2oyBgO4TWVO/UpTOJJRMVBmmhFV6TUlpiPJKy/6DvD9ycfPAlMdKlRTZ
         MHnqhAEO1w1zZCwZcd//Sk0p6JiL7Cm3fFwSlaZnC88MdG4Jj+hLRw5Xy5dReKFap5Ca
         tZiQ==
X-Gm-Message-State: AOAM5333sopOu42KqY4KN4mIZYYQ1cpKiQc2LXdOjanMX8kJh7rdAB4S
        QCw8gwtpL58VApKpm7viZUPUtQ==
X-Google-Smtp-Source: ABdhPJwKia/5GGKCbnPOR/TUjREIi907SNS2bEdU6Mh1+TQEFW75in9xrQoVv1Gl99ssQv/cFlCXvQ==
X-Received: by 2002:a17:90b:88:: with SMTP id bb8mr10252475pjb.23.1629306954330;
        Wed, 18 Aug 2021 10:15:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z131sm355644pfc.159.2021.08.18.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:15:53 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:15:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, linux-usb@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] USB: EHCI: Add alias for Broadcom INSNREG
Message-ID: <202108181013.63E7B4903B@keescook>
References: <20210818043035.1308062-1-keescook@chromium.org>
 <20210818043035.1308062-3-keescook@chromium.org>
 <20210818145736.GD193695@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818145736.GD193695@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 10:57:36AM -0400, Alan Stern wrote:
> On Tue, Aug 17, 2021 at 09:30:34PM -0700, Kees Cook wrote:
> > Refactor struct ehci_regs to avoid accessing beyond the end of
> > port_status. This change results in no difference in the resulting
> > object code.
> > 
> > Avoids several warnings when building with -Warray-bounds:
> > 
> > drivers/usb/host/ehci-brcm.c: In function 'ehci_brcm_reset':
> > drivers/usb/host/ehci-brcm.c:113:32: warning: array subscript 16 is above array bounds of 'u32[15]' {aka 'unsigned int[15]'} [-Warray-bounds]
> >   113 |  ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> >       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from drivers/usb/host/ehci.h:274,
> >                  from drivers/usb/host/ehci-brcm.c:15:
> > ./include/linux/usb/ehci_def.h:132:7: note: while referencing 'port_status'
> >   132 |   u32 port_status[HCS_N_PORTS_MAX];
> >       |       ^~~~~~~~~~~
> > 
> > Note that the documentation around this proprietary register is
> > confusing. If "USB_EHCI_INSNREG00" is at port_status[0x0f], its offset
> > would be 0x80 (not 0x90). The code uses port_status[0x10], so is that
> > not using "USB_EHCI_INSNREG00"?
> 
> I suspect the 0x90 value in the comment is a typo for 0x80.

That'd be my conclusion too. I've updated this for v2.

> 
> > Perhaps port_status[0x10] is USB_EHCI_INSNREG01 and port_status[0x12]
> > is USB_EHCI_INSNREG03? If so, the union could be adjusted to better
> > represent the layout.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Al Cooper <alcooperx@gmail.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: linux-usb@vger.kernel.org
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/usb/host/ehci-brcm.c | 11 +++++------
> >  include/linux/usb/ehci_def.h | 16 ++++++++++++++--
> >  2 files changed, 19 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> > index 3e0ebe8cc649..5d232d3701f9 100644
> > --- a/drivers/usb/host/ehci-brcm.c
> > +++ b/drivers/usb/host/ehci-brcm.c
> > @@ -110,8 +110,8 @@ static int ehci_brcm_reset(struct usb_hcd *hcd)
> >  	 *   bus usage
> >  	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
> 
> This last comment line is no longer necessary, thanks to the revised 
> port definitions.  And since it is actively misleading, with the 0x90 
> instead of 0x80, I think it should be removed entirely.

Done.

> 
> >  	 */
> > -	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> > -	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> > +	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
> > +	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
> >  
> >  	return ehci_setup(hcd);
> >  }
> > @@ -223,11 +223,10 @@ static int __maybe_unused ehci_brcm_resume(struct device *dev)
> >  	/*
> >  	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
> >  	 *   bus usage
> > -	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
> > -	 * @ 0x90
> > +	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
> 
> Same here.
> 
> >  	 */
> > -	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> > -	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> > +	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
> > +	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
> >  
> >  	ehci_resume(hcd, false);
> >  
> > diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
> > index 5398f571113b..86f0909cab99 100644
> > --- a/include/linux/usb/ehci_def.h
> > +++ b/include/linux/usb/ehci_def.h
> > @@ -182,11 +182,23 @@ struct ehci_regs {
> >   * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
> >   * PORTSCx
> >   */
> > -	/* HOSTPC: offset 0x84 */
> > -	u32		hostpc[HCS_N_PORTS_MAX];
> > +	union {
> > +		/* HOSTPC: offset 0x84 */
> > +		u32	hostpc[HCS_N_PORTS_MAX];
> >  #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
> >  #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
> >  
> > +		/*
> > +		 * This was originally documented as:
> > +		 * "port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90"
> > +		 * but this doesn't make sense: the code was using
> > +		 * port_status[0x10]. port_status[0x0f] would be reserved4.
> > +		 * Also, none of these are near 0x90. port_status[0x10] is
> > +		 * offset 0x84, and port_status[0x0f] would be 0x80.
> > +		 */
> 
> This comment is entirely inappropriate.  It's the sort of thing that 
> belongs in the git history, not in the code.

I wanted it to be easily discoverable, but since we've got a preferred
result now, I'm dropping this and orienting against 0x80.

> 
> > +		u32	brcm_insnreg[3];
> 
> Given the notation in the original comments, perhaps it would be better 
> to define this as:
> 
> 		struct {		/* Broadcom proprietary registers */
> 			u32	brcm_insnreg01;		/* offset 0x84 */
> 			u32	brcm_insnreg02;
> 			u32	brcm_insnreg03;
> 		};

Following the other register arrays, I'm going to keep an array for
this, but adjust the numbering to start at 0 @ 0x80 so the code will
poke offset 1 and 3.

> I don't know.  It would be nice to hear from somebody at Broadcom.

Agreed. :)

Thanks for the review!

-- 
Kees Cook
