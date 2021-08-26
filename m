Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36061C432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 05:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1757C61076
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 05:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhHZFwJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhHZFwJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 01:52:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88186C0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 22:51:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so1452889pjv.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 22:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ccQ0MGCdd2sOJEH6txbJHSp3br3UWRPN7Oxkykdkfrk=;
        b=h98ncCnoSgRO/F8RcTGwgl4lQgtwO7Z069Jg7gZwqH61LgYfFHRkVKlkk5SYejX3Qo
         wp+dBQvMBboIKtqJi98pwPqrfc0z40lBaUNd0lecBa90rVYJ+4XjuIYSPHipBNUKEW6J
         /Ns8wV2HFg8eY7ZT5jRFEk0xCu3jQqxN02ClQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccQ0MGCdd2sOJEH6txbJHSp3br3UWRPN7Oxkykdkfrk=;
        b=taVuD/oEWpPpnljvntpNKuwS1cKW6698CZktoZgvQEUm35lZJp8NchdWRDLvx3dOvs
         dUCZBoVmioEpze2zzxKXSKPiE1RJdhMkbrEgs8t3Yj/6fGUpKO0l3+eaTtP9ym7IWJDD
         JFRY8cmSDgE6eIOX0XZgorkeFvbgtV8BrnqkZs9unnlqNXUWzUUvh81qe64sjurnYYnW
         LbU6RX0Mvwx5UsAesVAxRgBpYyxE0vsZBTqp2eI1foDgZaPc12/xWCuOHFvTYf9GYhGV
         qauEg0cRNcKAJi4slR07iNFSaEEqUVGs4khWzNJaFvKAOjwZix6ZEZm84MvCWflE7jhh
         zAFA==
X-Gm-Message-State: AOAM532UKRsZIClzq6GnQj/K1Tjj0P5ZSJca5VQ1+Jgm0ky4hSDPJD3j
        CyOPTJcc+8YHZJv7aVAPsN8ZjQ==
X-Google-Smtp-Source: ABdhPJxNdpjMBaxv04Np/J/tJKVtP0qIehTtqoqEULck0k4pYP27+H3m2/MaKclQTAZAaqJQhLiqIw==
X-Received: by 2002:a17:90a:dac2:: with SMTP id g2mr14392631pjx.45.1629957082083;
        Wed, 25 Aug 2021 22:51:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm2088939pgj.11.2021.08.25.22.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 22:51:21 -0700 (PDT)
Date:   Wed, 25 Aug 2021 22:51:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Keith Packard <keithp@keithp.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/5] treewide: Replace 0-element memcpy() destinations
 with flexible arrays
Message-ID: <202108252250.C1DAEE5@keescook>
References: <20210826050458.1540622-1-keescook@chromium.org>
 <20210826050458.1540622-4-keescook@chromium.org>
 <87r1egpym5.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1egpym5.fsf@keithp.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 25, 2021 at 10:24:18PM -0700, Keith Packard wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > In some cases, use of the flex_array() helper is needed when a flexible
> > array is part of a union.
> 
> The code below seems to show that the helper is also needed when the
> flexible array is the only member of a struct? Or is this just an
> extension of the 'part of a union' clause?

That's correct. I have that documented in the DECLARE_FLEX_ARRAY macro
itself, but I mis-spoke in this changelog here (the uses were for "alone
in a struct"). I've adjusted the changelog now. :)

Thanks!

-Kees

> 
> > @@ -160,7 +160,7 @@ struct bmi_cmd {
> >  
> >  union bmi_resp {
> >  	struct {
> > -		u8 payload[0];
> > +		DECLARE_FLEX_ARRAY(u8, payload);
> >  	} read_mem;
> >  	struct {
> >  		__le32 result;
> 
> -- 
> -keith



-- 
Kees Cook
