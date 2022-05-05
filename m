Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07EC433FE
	for <linux-hardening@archiver.kernel.org>; Thu,  5 May 2022 23:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiEEXZ3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 May 2022 19:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386693AbiEEXZ2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 May 2022 19:25:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2019D606DF
        for <linux-hardening@vger.kernel.org>; Thu,  5 May 2022 16:21:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so9305593pjv.4
        for <linux-hardening@vger.kernel.org>; Thu, 05 May 2022 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FsJQBm+KiPbU5oZFlb156b8rhBJ4Uorz+AB43axdvEs=;
        b=b4QBt9I2EvR67CODikPi0a9mXhgWqX571i5/EdReKIE9EODbHkItMvjvwDbOCQysfV
         OYPj+ES6jzaUAcaXntn5yP9xnuimsNNoETSjjEpKqFnZJq7HiU4QIoUizYG8dqlIAlRt
         KFEUvFE02VVTOS1MXYfEMUXarlkOSW796wnzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FsJQBm+KiPbU5oZFlb156b8rhBJ4Uorz+AB43axdvEs=;
        b=rr0e2MpNpxZ6lQI+rK3AwQLWBKZiExFBBccmuk2e+FvM0xee53MO3sHp3AuqWkIgM+
         tnRgh0bpc2fFFvfevC/a+gvTVKo4Bw0XdU+X8Iscm74eAiuJzSzAVKe+vmrQW36T79fF
         PIgVDXM9k+dJ23384vMrSC1NY3FPB59xpW469msgd/KtgJ9YjL3TQzs8fA3tXMDqM5dT
         gsAJYLqhrdmdwvH3xyGoLUtWZnEJ/Es0n/FV++hycQq3hO82hQk6MIGDt/w8AFCtQmGN
         BES298F5jtDEtH76tICtCJD4PtTmBiY+LIy7pPO6PEGJypVXwcJ68Pm3n2oW7ExgYIdS
         j+XA==
X-Gm-Message-State: AOAM532hlnPBjAdgG+0M4e/Q5q4mujw6J6IZL9TbbEJPhykgAmNA8LQp
        o0LLKHIMQWcmnV3JK1xNNU2duQ==
X-Google-Smtp-Source: ABdhPJzP9zRP08NXdI9jDsvHPqaceGoA2zYTGlw+nZr3rV2CSebijDo0y4t+sdVuBwBLJoTyc6pOsQ==
X-Received: by 2002:a17:90a:589:b0:1d5:e1b1:2496 with SMTP id i9-20020a17090a058900b001d5e1b12496mr8887205pji.209.1651792907648;
        Thu, 05 May 2022 16:21:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19-20020aa78f33000000b0050dc76281b0sm1912701pfr.138.2022.05.05.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:21:46 -0700 (PDT)
Date:   Thu, 5 May 2022 16:21:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Raju Rangoju <rajur@chelsio.com>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: chelsio: cxgb4: Avoid potential negative array
 offset
Message-ID: <202205051611.7C4B6EB86@keescook>
References: <20220503144425.2858110-1-keescook@chromium.org>
 <20220504201358.0ba62232@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504201358.0ba62232@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 04, 2022 at 08:13:58PM -0700, Jakub Kicinski wrote:
> On Tue,  3 May 2022 07:44:25 -0700 Kees Cook wrote:
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > index e7b4e3ed056c..f119ec7323e5 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > @@ -2793,14 +2793,14 @@ int t4_get_raw_vpd_params(struct adapter *adapter, struct vpd_params *p)
> >  		goto out;
> >  	na = ret;
> >  
> > -	memcpy(p->id, vpd + id, min_t(int, id_len, ID_LEN));
> > +	memcpy(p->id, vpd + id, clamp_t(int, id_len, 0, ID_LEN));
> 
> The typing is needed because of the enum, right? The variable is
> unsigned, seems a little strange to use clamp(int, ..., 0, constant)
> min(unsigned int, ..., constant) will be equivalent with fewer branches.
> Is it just me?

I just chased down the origin of "unsigned int", but it's actually a
u16 out of the VPD:

static u16 pci_vpd_lrdt_size(const u8 *lrdt)
{
        return get_unaligned_le16(lrdt + 1);
}

static int pci_vpd_find_tag(const u8 *buf, unsigned int len, u8 rdt, unsigned int *size)
{
	...
                unsigned int lrdt_len = pci_vpd_lrdt_size(buf + i);
	...
                                *size = lrdt_len;

I'm not sure why it was expanded to unsigned int size, maybe in other
call sites it was easier to deal with for possible math, etc?

Anyway, doesn't need changing. I'll send the int/unsigned int shortly...

-- 
Kees Cook
