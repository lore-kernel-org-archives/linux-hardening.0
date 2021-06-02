Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FCC4708F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C153A613B1
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhFBUFC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:05:02 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:55903 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBUFB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 16:05:01 -0400
Received: by mail-pj1-f53.google.com with SMTP id k7so2259651pjf.5
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jun 2021 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s1sjAr9ezsvGRMG5Tl2f4lo3BdOtvxz+ZJuUyICioUA=;
        b=X7wS/R9XOO9moLEPu26T44hWfELyEpcKpGf4ejcI6KxP/IHbZzHWm3DrAIIOfjRmMm
         Hdm5llNjoEWnuOfGRe2+V7O7IxW+pFJj8OPQeUxwVF8268PEctI2ASL8t8M2U59NnRwX
         N9vxlFaoQV9dpUAA1POoaSmpbc13E3SOXDofg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s1sjAr9ezsvGRMG5Tl2f4lo3BdOtvxz+ZJuUyICioUA=;
        b=rKl0w05qB/bue1LmkYWedCdQE49UUplxOgDj6K01QfOyqysGW/VCHJf3ADnznCIP8O
         RGyFXPXTJr2F+dTbhUUKFaixtfSPG3y9BphXmy/JtkXUOnGmQx8s7mnayeYkPq5CBzQA
         U1aZ86lVazsOvzNkILm6zMNMK4G5bfPJLJ4q1GZ6pechr7iVnyRXC7LQjg/ybq1a8mK+
         EuEKyp61mg7XaxaQws4EZE2hup1pbigqsd9Kz8jXRB8bXoP7hvkCojS3WLF5r46IelUT
         QETchZbDDCJFYD/L2IZRQecxrsGNFC/rXTqj3jvK6hnJN4pyXO66boWDcB9kIFjgtqKu
         nM/Q==
X-Gm-Message-State: AOAM531epcdU19Omv8D44qlsPTxJRa+GWEp2A5brLLW5yY8GQQqGuuGF
        pDvpQ41imA5USmgNFOzOHQkP4g==
X-Google-Smtp-Source: ABdhPJwHwskbW0yeyMWaiBjFpL1jphLGqrKFs+hGNBQi+9mFNK0gn2FFWmraiEy5k6AHFpHCD4ViZA==
X-Received: by 2002:a17:90a:1588:: with SMTP id m8mr7410756pja.226.1622664124481;
        Wed, 02 Jun 2021 13:02:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l20sm256386pjq.38.2021.06.02.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:02:03 -0700 (PDT)
Date:   Wed, 2 Jun 2021 13:02:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: bonding: Use strscpy() instead of
 manually-truncated strncpy()
Message-ID: <202106021257.F0DFED3@keescook>
References: <20210602181133.3326856-1-keescook@chromium.org>
 <b53fc81b-2348-54f1-72ca-d143d34bf780@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b53fc81b-2348-54f1-72ca-d143d34bf780@oracle.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 02, 2021 at 12:46:46PM -0700, Rao Shoaib wrote:
> Would it make sense to also replace the other strncpy in the same file.

                strncpy(ifr.ifr_name, slave_dev->name, IFNAMSIZ);

I couldn't tell if this was a non-string, if it needed padding, etc. The
one I fixed below appears to be null-terminated? (Though now that I look
at it, perhaps it should be using strscpy_pad().)

And there are a bunch of other manual truncations in the kernel on
ifr_name:

$ git grep ifr_name | grep 'IFNAMSIZ.*=.*0'
drivers/net/tun.c:              ifr.ifr_name[IFNAMSIZ-1] = '\0';
net/core/dev_ioctl.c:   ifr->ifr_name[IFNAMSIZ-1] = 0;
net/core/dev_ioctl.c:   ifr->ifr_name[IFNAMSIZ-1] = 0;
net/decnet/dn_dev.c:    ifr->ifr_name[IFNAMSIZ-1] = 0;
net/ieee802154/socket.c:        ifr.ifr_name[IFNAMSIZ-1] = 0;
net/ipv4/devinet.c:     ifr->ifr_name[IFNAMSIZ - 1] = 0;
net/wireless/wext-core.c:       iwr.ifr_name[IFNAMSIZ-1] = 0;
tools/lib/bpf/xsk.c:    ifr.ifr_name[IFNAMSIZ - 1] = '\0';

And given the copy_to_user() that might happen, I think this should
absolutely be strscpy_pad(). I will send a v2...

-Kees

> 
> Shoaib
> 
> On 6/2/21 11:11 AM, Kees Cook wrote:
> > Silence this warning by just using strscpy() directly:
> > 
> > drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
> >      4877 |   strncpy(params->primary, primary, IFNAMSIZ);
> >           |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/lkml/202102150705.fdR6obB0-lkp@intel.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/net/bonding/bond_main.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index c5a646d06102..ecfc48f2d0d0 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5329,10 +5329,8 @@ static int bond_check_params(struct bond_params *params)
> >   			(struct reciprocal_value) { 0 };
> >   	}
> > -	if (primary) {
> > -		strncpy(params->primary, primary, IFNAMSIZ);
> > -		params->primary[IFNAMSIZ - 1] = 0;
> > -	}
> > +	if (primary)
> > +		strscpy(params->primary, primary, sizeof(params->primary));
> >   	memcpy(params->arp_targets, arp_target, sizeof(arp_target));

-- 
Kees Cook
