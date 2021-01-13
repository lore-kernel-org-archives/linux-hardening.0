Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05324C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC4C21534
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbhAMSAm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbhAMSAl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Jan 2021 13:00:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE10C061575
        for <linux-hardening@vger.kernel.org>; Wed, 13 Jan 2021 10:00:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so1488761plh.12
        for <linux-hardening@vger.kernel.org>; Wed, 13 Jan 2021 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M49+su6FFncBgS/CCqedl4zaR41swmris5y2FQmmX8Q=;
        b=Qp2ZpgMDB8wPfXkD1qxAPN+S6HJHqkyeiYeRindACAarfWpMuamYhPkgCHfb764Zc+
         GwSLBKbmWEekmGCbKIrA8LrNmy2kzc4XglmheYCjmrA7dQ/cA21T5o7zs80a1wSTFiyu
         hIQ0TX9RDpD8TSMaCgDUoF/P830n12KZOOmQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M49+su6FFncBgS/CCqedl4zaR41swmris5y2FQmmX8Q=;
        b=F2p5TL4GhJ8K43zyCfWXs8V/HNOVYEOi5O1fDcxyS/p08JK9Tq5g9ogskdGno/61E5
         yHaUOCavKFgavYUIkGjtjTPlgPrYlsK16gq7jYHaBtOEHEfS9qs2RV55cnierCQR26CN
         qNOXRmntEZC8ccuJ6Imj3NcKueLobIZdRMD8sMy0bYhPvQieS+BF8Ec4z7BIY42GBl35
         k08tPyYjH9o/JvRVrXi1MYBzF4h+MHRmV4PhGl2wlFwZgZmtUQ9UI/ZtV41wg/xyDHlN
         nKpcpvT08SZkoCtGj4PN7IDhBXZjPc+3J9dCD5ETmdWRV87OooXH1YHV1OnrA0bo+AuM
         xuAQ==
X-Gm-Message-State: AOAM533kLnAwCeMCInnbuSoIdTm6pj/anyKhX1h8a2vrStc2N1kdTONx
        IHrxg8iseYeE+v2Xx8ooQti8Xg==
X-Google-Smtp-Source: ABdhPJzDPnT7NEWPzGgmFD5HvClTVipXiJQcVnJAsKqYUmyLS4WAIKC6jAGAix2B7xquczdF+zO9Vw==
X-Received: by 2002:a17:902:b7c3:b029:da:74c3:427 with SMTP id v3-20020a170902b7c3b02900da74c30427mr3449507plz.38.1610560801075;
        Wed, 13 Jan 2021 10:00:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x23sm3944638pge.47.2021.01.13.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:00:00 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:59:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gcc-plugins: fix gcc 11 indigestion with plugins...
Message-ID: <202101130959.596D763@keescook>
References: <38485.1610500756@turing-police>
 <20210113170836.xvlq5xlmkjpi4zx7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210113170836.xvlq5xlmkjpi4zx7@treble>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 13, 2021 at 11:08:36AM -0600, Josh Poimboeuf wrote:
> On Tue, Jan 12, 2021 at 08:19:16PM -0500, Valdis Klētnieks wrote:
> > Fedora Rawhide has started including gcc 11,and the g++ compiler
> > throws a wobbly when it hits scripts/gcc-plugins:
> > 
> >   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> > In file included from /usr/include/c++/11/type_traits:35,
> >                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
> >                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
> >                  from scripts/gcc-plugins/gcc-common.h:7,
> >                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> > /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
> >  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
> >    32 | #error This file requires compiler and library support \
> > 
> > Patch is more complicated than would otherwise be needed, because
> > older gcc (4.9, 5.4) have gnu++11 but throw an error due to a gcc bug
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> > 
> > Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > ---
> > diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> > index d66949bfeba4..cc779973724a 100644
> > --- a/scripts/gcc-plugins/Makefile
> > +++ b/scripts/gcc-plugins/Makefile
> > @@ -21,10 +21,13 @@ always-y += $(GCC_PLUGIN)
> >  
> >  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
> >  
> > +# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
> > +GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
> > +
> >  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> > -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
> > +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
> >  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> > -		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
> > +		   -ggdb -Wno-narrowing -Wno-unused-variable \
> >  		   -Wno-format-diag
> >  
> >  plugin_ldflags	= -shared
> 
> The first patch has already been merged into Linus' tree, so this
> probably should be an incremental fix on top, with a Fixes: tag.

Yes, please. :)

-- 
Kees Cook
