Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9727FC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 14:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CC16104F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 14:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhHRO6M (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:58:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42435 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S238721AbhHRO6M (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 10:58:12 -0400
Received: (qmail 196408 invoked by uid 1000); 18 Aug 2021 10:57:36 -0400
Date:   Wed, 18 Aug 2021 10:57:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, linux-usb@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] USB: EHCI: Add alias for Broadcom INSNREG
Message-ID: <20210818145736.GD193695@rowland.harvard.edu>
References: <20210818043035.1308062-1-keescook@chromium.org>
 <20210818043035.1308062-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818043035.1308062-3-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 09:30:34PM -0700, Kees Cook wrote:
> Refactor struct ehci_regs to avoid accessing beyond the end of
> port_status. This change results in no difference in the resulting
> object code.
> 
> Avoids several warnings when building with -Warray-bounds:
> 
> drivers/usb/host/ehci-brcm.c: In function 'ehci_brcm_reset':
> drivers/usb/host/ehci-brcm.c:113:32: warning: array subscript 16 is above array bounds of 'u32[15]' {aka 'unsigned int[15]'} [-Warray-bounds]
>   113 |  ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/host/ehci.h:274,
>                  from drivers/usb/host/ehci-brcm.c:15:
> ./include/linux/usb/ehci_def.h:132:7: note: while referencing 'port_status'
>   132 |   u32 port_status[HCS_N_PORTS_MAX];
>       |       ^~~~~~~~~~~
> 
> Note that the documentation around this proprietary register is
> confusing. If "USB_EHCI_INSNREG00" is at port_status[0x0f], its offset
> would be 0x80 (not 0x90). The code uses port_status[0x10], so is that
> not using "USB_EHCI_INSNREG00"?

I suspect the 0x90 value in the comment is a typo for 0x80.

> Perhaps port_status[0x10] is USB_EHCI_INSNREG01 and port_status[0x12]
> is USB_EHCI_INSNREG03? If so, the union could be adjusted to better
> represent the layout.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/host/ehci-brcm.c | 11 +++++------
>  include/linux/usb/ehci_def.h | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> index 3e0ebe8cc649..5d232d3701f9 100644
> --- a/drivers/usb/host/ehci-brcm.c
> +++ b/drivers/usb/host/ehci-brcm.c
> @@ -110,8 +110,8 @@ static int ehci_brcm_reset(struct usb_hcd *hcd)
>  	 *   bus usage
>  	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90

This last comment line is no longer necessary, thanks to the revised 
port definitions.  And since it is actively misleading, with the 0x90 
instead of 0x80, I think it should be removed entirely.

>  	 */
> -	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> -	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> +	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
> +	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
>  
>  	return ehci_setup(hcd);
>  }
> @@ -223,11 +223,10 @@ static int __maybe_unused ehci_brcm_resume(struct device *dev)
>  	/*
>  	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
>  	 *   bus usage
> -	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
> -	 * @ 0x90
> +	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90

Same here.

>  	 */
> -	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> -	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> +	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
> +	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
>  
>  	ehci_resume(hcd, false);
>  
> diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
> index 5398f571113b..86f0909cab99 100644
> --- a/include/linux/usb/ehci_def.h
> +++ b/include/linux/usb/ehci_def.h
> @@ -182,11 +182,23 @@ struct ehci_regs {
>   * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
>   * PORTSCx
>   */
> -	/* HOSTPC: offset 0x84 */
> -	u32		hostpc[HCS_N_PORTS_MAX];
> +	union {
> +		/* HOSTPC: offset 0x84 */
> +		u32	hostpc[HCS_N_PORTS_MAX];
>  #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
>  #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
>  
> +		/*
> +		 * This was originally documented as:
> +		 * "port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90"
> +		 * but this doesn't make sense: the code was using
> +		 * port_status[0x10]. port_status[0x0f] would be reserved4.
> +		 * Also, none of these are near 0x90. port_status[0x10] is
> +		 * offset 0x84, and port_status[0x0f] would be 0x80.
> +		 */

This comment is entirely inappropriate.  It's the sort of thing that 
belongs in the git history, not in the code.

> +		u32	brcm_insnreg[3];

Given the notation in the original comments, perhaps it would be better 
to define this as:

		struct {		/* Broadcom proprietary registers */
			u32	brcm_insnreg01;		/* offset 0x84 */
			u32	brcm_insnreg02;
			u32	brcm_insnreg03;
		};

I don't know.  It would be nice to hear from somebody at Broadcom.

Alan Stern

> +	};
> +
>  	u32		reserved5[2];
>  
>  	/* USBMODE_EX: offset 0xc8 */
> -- 
> 2.30.2
> 
