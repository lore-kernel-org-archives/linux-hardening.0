Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3BC47083
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C816A613EC
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFBU4q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:56:46 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44011 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhFBUzo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 16:55:44 -0400
Received: by mail-pg1-f180.google.com with SMTP id e22so3279499pgv.10
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jun 2021 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvBVKKuCkHy2pwXOhSmYF/8asqpcAnySspHtL7Uf0EY=;
        b=GDb7DdnITH1/95qRk77G6hq5OLr2t1g+co9KRVhEi+aWul1jaq6z2UDQvaMBNXNCkd
         XU1hsCa6WHRjDmMikEUzUuYq/c5MBH2aD7ZaQ8j3rC3CyvpdEuVEVGT2JGwp+R1oNaau
         Zx+hSd72dIvWSuFCrKKhXruFxv7IB2leWk3FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvBVKKuCkHy2pwXOhSmYF/8asqpcAnySspHtL7Uf0EY=;
        b=mGLXvzPEiaaxE4Gnh7Jodq6Z35hiK3WUdjrDngPRVOZpjJNgg4sTURIpBfiI1z/3TJ
         D+76KF/6TmrRqAcEqk0pvga+kEnFTcOpJ1dAP50CCFtxLoWzdVEKKdl6M14MMVWY3MEJ
         /xCcKYNMQKlv6CBc3keDIwqBV3VpI7wx90fmoKw7SdJ4vItKA2ajesyoqYF9SIUnhTvz
         6yDJD56ImEmI2duBJiYHViMhRZk48+UI1AnaCiRegRVf7iPC37m4e+A/3FuFTzCWYG2A
         strDn+1mbqbyGJ9pCXwJ0vxPGq5ZqDyA0QlNnRELxPzOmJ0WKfP2aMtP2LfCtc+cgV1t
         lX/A==
X-Gm-Message-State: AOAM530S4BKFDJJVClao0VCQBSrFAZZnERJ3EzPggScGbu6eMm9I0DIy
        ztUm5/MfGqFUGpzitu5imAjLLg==
X-Google-Smtp-Source: ABdhPJzQA2Kuv7FOGj+yBnevenaxOfCwvvS+TKqCt5Se8cg0JQNeLpwmhDa3WvqEYQgAIc8sX114Bw==
X-Received: by 2002:a05:6a00:84f:b029:2be:3b80:e9eb with SMTP id q15-20020a056a00084fb02902be3b80e9ebmr28959717pfk.39.1622667181114;
        Wed, 02 Jun 2021 13:53:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f28sm545147pgb.12.2021.06.02.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:53:00 -0700 (PDT)
Date:   Wed, 2 Jun 2021 13:52:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     kernel test robot <lkp@intel.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: bonding: Use strscpy() instead of
 manually-truncated strncpy()
Message-ID: <202106021352.484D660@keescook>
References: <20210602203138.4082470-1-keescook@chromium.org>
 <7214.1622666840@famine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7214.1622666840@famine>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 02, 2021 at 01:47:20PM -0700, Jay Vosburgh wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
> >Silence this warning by just using strscpy_pad() directly:
> >
> >>> drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
> >    4877 |   strncpy(params->primary, primary, IFNAMSIZ);
> >         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >Additionally replace other strncpy() uses, as it is considered deprecated:
> >https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> >
> >Reported-by: kernel test robot <lkp@intel.com>
> >Link: https://lore.kernel.org/lkml/202102150705.fdR6obB0-lkp@intel.com
> >Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> 	There's one more "strncpy(...); primary[IFNAMSIZ - 1] = 0;" set
> in bond_options.c:bond_option_primary_set(), doesn't it also generate
> this warning?

Gah, I was looking only in the same file not the whole directory. :)

v3 on the way!

> 
> 	Either way, the change looks good to me.

Thanks!

> 
> Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> 
> 	-J
> 
> 
> >---
> >v2:
> > - switch to strscpy_pad() and replace earlier strncpy() too
> >v1: https://lore.kernel.org/lkml/20210602181133.3326856-1-keescook@chromium.org
> >---
> > drivers/net/bonding/bond_main.c | 8 +++-----
> > 1 file changed, 3 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index c5a646d06102..e9cb716ad849 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -620,7 +620,7 @@ static int bond_check_dev_link(struct bonding *bond,
> > 		 */
> > 
> > 		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
> >-		strncpy(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
> >+		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
> > 		mii = if_mii(&ifr);
> > 		if (ioctl(slave_dev, &ifr, SIOCGMIIPHY) == 0) {
> > 			mii->reg_num = MII_BMSR;
> >@@ -5329,10 +5329,8 @@ static int bond_check_params(struct bond_params *params)
> > 			(struct reciprocal_value) { 0 };
> > 	}
> > 
> >-	if (primary) {
> >-		strncpy(params->primary, primary, IFNAMSIZ);
> >-		params->primary[IFNAMSIZ - 1] = 0;
> >-	}
> >+	if (primary)
> >+		strscpy_pad(params->primary, primary, sizeof(params->primary));
> > 
> > 	memcpy(params->arp_targets, arp_target, sizeof(arp_target));
> > 
> >-- 
> >2.25.1
> 
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

-- 
Kees Cook
