Return-Path: <SRS0=b1nQ=DN=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E593CC4363A
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Oct 2020 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A002C206F4
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Oct 2020 00:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MKoKz0OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJEX73 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEX66 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Oct 2020 19:58:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A1C0613CE
        for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2020 16:58:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t23so672072pji.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2020 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IyYHcOMJJgz6DjQJMJICe5Q/mnTS/f/1ZLqnbqzHwzs=;
        b=MKoKz0OSIYP0krdxpW8Pp2IZAiN8d7/XESlc3ZA8hQfb5No/ycUM3rJBH0Oh2YixAr
         /TWRtvWkYAaVoD9ldm+IS3PyXXiIGae2E0Idg/YMQcWe3Mv6ejFv7GKHCCZHJEV0Vnvs
         F6IyYGy+KGw6Q2nTNC/KhRXmyPNZSESgbyY1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IyYHcOMJJgz6DjQJMJICe5Q/mnTS/f/1ZLqnbqzHwzs=;
        b=AOMdBcWfwCS8REB4z0wZfysFeodnEWIf/urVfPTXYP6mSWFOLs5Axxyw0deuDKpbZp
         oEB85gqasoa8pT+A+K+6yjCzuPvsInWPZxnttLX+28AbEPb+G0+J+fLPe+VL3mi4b+ei
         AQoPkb3Rl18VtulIDDRZAVIg46+PI5wklnPH6WyLRWq3T2TC+JyI5XcAJJoWf085AV8T
         i/BG5XBYFQjHyCeL3XP9zHydFYvvs7X6KhnDGViwL0jNuaSJz/rMIghssMY6Mcv+FDVD
         DV0y59/xGfgnTed44CNc+3X2BKcrpmXfE1c2Cbe5a+ndUJ7y0tBw4TFthaUDDCesnpgf
         ZsoA==
X-Gm-Message-State: AOAM530tDfzrrfqCPD3HGDiAz9ryzYPmn2v7C8eYU6vq0kf89GxY2rc3
        CEWOt8OWPe2dJVPat5WkLd6Cag==
X-Google-Smtp-Source: ABdhPJz6aq3Dc7Q1bTJsDhjU+8zMwfQgjhmTMqdtd5NBmP8a8eSzpprCcBsvsQCGC4fWa8KbZ7j/Zw==
X-Received: by 2002:a17:90a:fb55:: with SMTP id iq21mr1795566pjb.229.1601942336755;
        Mon, 05 Oct 2020 16:58:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6sm1155412pfl.50.2020.10.05.16.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:58:55 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:58:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Emese Revfy <re.emese@gmail.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] MAINTAINERS: Change hardening mailing list
Message-ID: <202010051658.BAFDE623B@keescook>
References: <20201005225319.2699826-1-keescook@chromium.org>
 <f1935658-97d3-2f6e-8643-522f9b6227cc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1935658-97d3-2f6e-8643-522f9b6227cc@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 05, 2020 at 04:19:49PM -0700, Randy Dunlap wrote:
> On 10/5/20 3:53 PM, Kees Cook wrote:
> > As more email from git history gets aimed at the OpenWall
> > kernel-hardening@ list, there has been a desire to separate "new topics"
> > from "on-going" work. To handle this, the superset of hardening email
> > topics are now to be directed to linux-hardening@vger.kernel.org. Update
> > the MAINTAINTERS file and the .mailmap to accomplish this, so that
> 
>       MAINTAINERS
> 
> > linux-hardening@ can be treated like any other regular upstream kernel
> > development list.
> > 
> > Link: https://lore.kernel.org/linux-hardening/202010051443.279CC265D@keescook/
> > Link: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Get_Involved
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > I intend to include this in one of my trees, unless akpm or jon want it?
> > ---
> >  .mailmap    | 1 +
> >  MAINTAINERS | 4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index 50096b96c85d..91cea2d9a6a3 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -184,6 +184,7 @@ Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>
> >  Linas Vepstas <linas@austin.ibm.com>
> >  Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
> >  Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
> > +<linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
> >  Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
> >  Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
> >  Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index adc4f0619b19..44d97693b6f3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7216,7 +7216,7 @@ F:	drivers/staging/gasket/
> >  GCC PLUGINS
> >  M:	Kees Cook <keescook@chromium.org>
> >  R:	Emese Revfy <re.emese@gmail.com>
> > -L:	kernel-hardening@lists.openwall.com
> > +L:	linux-hardening@lists.openwall.com
> 
> ?? confusing.

I'm glad you can read well, but I can't write well. ;)

Sending a v2. Thank you!

-Kees

> 
> >  S:	Maintained
> >  F:	Documentation/kbuild/gcc-plugins.rst
> >  F:	scripts/Makefile.gcc-plugins
> > @@ -9776,7 +9776,7 @@ F:	drivers/scsi/53c700*
> >  LEAKING_ADDRESSES
> >  M:	Tobin C. Harding <me@tobin.cc>
> >  M:	Tycho Andersen <tycho@tycho.pizza>
> > -L:	kernel-hardening@lists.openwall.com
> > +L:	linux-hardening@lists.openwall.com
> 
> ??
> 
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
> >  F:	scripts/leaking_addresses.pl
> > 
> 
> 
> -- 
> ~Randy
> 

-- 
Kees Cook
