Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01AFC4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DF0610CF
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhHROpT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:45:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44375 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S239446AbhHROpR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 10:45:17 -0400
Received: (qmail 195955 invoked by uid 1000); 18 Aug 2021 10:44:42 -0400
Date:   Wed, 18 Aug 2021 10:44:42 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Al Cooper <alcooperx@gmail.com>,
        linux-usb@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] USB: EHCI: Add register array bounds to HCS ports
Message-ID: <20210818144442.GC193695@rowland.harvard.edu>
References: <20210818043035.1308062-1-keescook@chromium.org>
 <20210818043035.1308062-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818043035.1308062-2-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 09:30:33PM -0700, Kees Cook wrote:
> The original EHCI register struct used a trailing 0-element array for
> addressing the N_PORTS-many available registers. However, after
> commit a46af4ebf9ff ("USB: EHCI: define extension registers like normal ones")
> the 0-element array started to overlap the USBMODE extension register.
> 
> To avoid future compile-time warnings about accessing indexes within a
> 0-element array, rearrange the struct to actually describe the expected
> layout (max 15 registers) with a union. All offsets remain the same, and
> bounds checking becomes possible on accesses to port_status and hostpc.
> 
> There are no binary differences, and struct offsets continue to match.

Two comments...

> ---
>  include/linux/usb/ehci_def.h | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
> index 78e006355557..5398f571113b 100644
> --- a/include/linux/usb/ehci_def.h
> +++ b/include/linux/usb/ehci_def.h
> @@ -45,6 +45,7 @@ struct ehci_caps {
>  #define HCS_PORTROUTED(p)	((p)&(1 << 7))	/* true: port routing */
>  #define HCS_PPC(p)		((p)&(1 << 4))	/* true: port power control */
>  #define HCS_N_PORTS(p)		(((p)>>0)&0xf)	/* bits 3:0, ports on HC */
> +#define HCS_N_PORTS_MAX		0xf		/* N_PORTS valid 0x1-0xF */

I would prefer to see this value in decimal.  It seems very odd to say 
something like "The maximum number of ports is 0xf".

>  
>  	u32		hcc_params;      /* HCCPARAMS - offset 0x8 */
>  /* EHCI 1.1 addendum */
> @@ -126,8 +127,9 @@ struct ehci_regs {
>  	u32		configured_flag;
>  #define FLAG_CF		(1<<0)		/* true: we'll support "high speed" */
>  
> -	/* PORTSC: offset 0x44 */
> -	u32		port_status[0];	/* up to N_PORTS */
> +	union {
> +		/* PORTSC: offset 0x44 */
> +		u32	port_status[HCS_N_PORTS_MAX];

Please don't lose the second comment.

>  /* EHCI 1.1 addendum */
>  #define PORTSC_SUSPEND_STS_ACK 0
>  #define PORTSC_SUSPEND_STS_NYET 1
> @@ -164,28 +166,28 @@ struct ehci_regs {
>  #define PORT_CSC	(1<<1)		/* connect status change */
>  #define PORT_CONNECT	(1<<0)		/* device connected */
>  #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
> -
> -	u32		reserved3[9];
> -
> -	/* USBMODE: offset 0x68 */
> -	u32		usbmode;	/* USB Device mode */
> +		struct {
> +			u32	reserved3[9];
> +			/* USBMODE: offset 0x68 */
> +			u32	usbmode;	/* USB Device mode */
> +		};
>  #define USBMODE_SDIS	(1<<3)		/* Stream disable */
>  #define USBMODE_BE	(1<<2)		/* BE/LE endianness select */
>  #define USBMODE_CM_HC	(3<<0)		/* host controller mode */
>  #define USBMODE_CM_IDLE	(0<<0)		/* idle state */
> -
> -	u32		reserved4[6];
> +	};
> +	u32		reserved4;
>  
>  /* Moorestown has some non-standard registers, partially due to the fact that
>   * its EHCI controller has both TT and LPM support. HOSTPCx are extensions to
>   * PORTSCx
>   */
>  	/* HOSTPC: offset 0x84 */
> -	u32		hostpc[0];	/* HOSTPC extension */
> +	u32		hostpc[HCS_N_PORTS_MAX];
>  #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
>  #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
>  
> -	u32		reserved5[17];
> +	u32		reserved5[2];
>  
>  	/* USBMODE_EX: offset 0xc8 */
>  	u32		usbmode_ex;	/* USB Device mode extension */

Otherwise okay.

Alan Stern
