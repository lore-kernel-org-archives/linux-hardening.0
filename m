Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831CBC4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 03:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiLBDXx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLBDXw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 22:23:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C3D78C8
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 19:23:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t17so3714175pjo.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yY6gYe0jMoQOUxAo/XW0gvLy18PjZJInyxKTnKGra0Y=;
        b=mWg+1k8tLdmRboO8CdEYOc/bgyxydYUdyFcVDc5S4AbOtPngnYlYkCITrTpxZfE4Dz
         XjQb9yqfGilIpKuXSJ5aSmvUvoQ5mpbhx4KbUNITsRD65szE5WKnL96uQO80aEgsClzG
         0Vw41ZQcyYCqKtNE5jslZhyGoHR0IkAzXbfMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY6gYe0jMoQOUxAo/XW0gvLy18PjZJInyxKTnKGra0Y=;
        b=s5E1gedGBd2KaX0k0XDm6+NjZi6jzsMU2nmxitoPyxPtefpbe2ByhkwsxKIGVHUzZz
         Xi5yDcSNAX6k02evlXH/j3ykBAmfVMa4SCoDMWSzetAk+uF3pW9dO8GxnRdur29uSKhP
         zIRpvi8AAJ/FvIg8bfyMcjZxUSlazhpi9qpX8ssZkDz6liWkthYW+/tqzHRtLvVUVBah
         Lq1MWctPld4QUvuyc8PvaNDHw9LWNoT1noYCrDDFf8QlPt1v0Lu9ejVEb6/nhbP1SU39
         Qgi+aovC5blZbU0VpFSb1I6wQ5J2I3n9zWYJM82jEaGTHogu5e+tN8WsxB1oHdzKCfgu
         sD3A==
X-Gm-Message-State: ANoB5pmxBjIqUGdrHRUM74Cf4dsnAG0tVfCM8dlOQt8sQSGxnYuhnW7I
        NgoWTyVu4lFEEHmjRo9xbk721A==
X-Google-Smtp-Source: AA0mqf773jlXfFtvUNPzleI1zzwoMcdaJ5vS2QEyu1vN8eJZOdHbwv7AHWP1c1jEjeQ9lflAqG2XOg==
X-Received: by 2002:a17:90a:d34d:b0:218:a0ce:9d5e with SMTP id i13-20020a17090ad34d00b00218a0ce9d5emr63698522pjx.96.1669951430920;
        Thu, 01 Dec 2022 19:23:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090a850c00b0020ae09e9724sm3697996pjn.53.2022.12.01.19.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:23:50 -0800 (PST)
Date:   Thu, 1 Dec 2022 19:23:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <202212011920.A6648E9B@keescook>
References: <20221202010410.gonna.444-kees@kernel.org>
 <Y4ludwin631WFhcG@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4ludwin631WFhcG@sol.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 01, 2022 at 07:18:15PM -0800, Eric Biggers wrote:
> On Thu, Dec 01, 2022 at 05:04:14PM -0800, Kees Cook wrote:
> > GCC 12 appears to perform constant propagation incompletely(?) and can
> > no longer notice that "len" is always 0 when "data" is NULL. Expand the
> > check to avoid warnings about memcpy() having a NULL argument:
> 
> Is there a gcc option to turn off the "memcpy with NULL and len=0 is undefined
> behavior" thing?  It's basically a bug in the C standard.

It's not undefined -- it's just pedantic. __builtin_memcpy is defined
internally to GCC with __attribute__((nonnull (1, 2))), and since it can
find a path from an always-NULL argument, it warns. I think it's a dumb
limitation, given that "zero size to/from NULL" is perfectly valid.

-- 
Kees Cook
