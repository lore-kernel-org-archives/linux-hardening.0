Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1899C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CE861153
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 15:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhIKPsC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 11 Sep 2021 11:48:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48695 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230305AbhIKPsB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 11 Sep 2021 11:48:01 -0400
Received: (qmail 69147 invoked by uid 1000); 11 Sep 2021 11:46:48 -0400
Date:   Sat, 11 Sep 2021 11:46:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci: Prefer struct_size over open coded arithmetic
Message-ID: <20210911154648.GA68944@rowland.harvard.edu>
References: <20210911112631.10004-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911112631.10004-1-len.baker@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 11, 2021 at 01:26:31PM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-hcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 1f5e69314a17..666b1c665188 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -191,8 +191,7 @@ static int ohci_urb_enqueue (
>  	}
> 
>  	/* allocate the private part of the URB */
> -	urb_priv = kzalloc (sizeof (urb_priv_t) + size * sizeof (struct td *),
> -			mem_flags);
> +	urb_priv = kzalloc(struct_size(urb_priv, td, size), mem_flags);
>  	if (!urb_priv)
>  		return -ENOMEM;
>  	INIT_LIST_HEAD (&urb_priv->pending);
> --
> 2.25.1
> 
