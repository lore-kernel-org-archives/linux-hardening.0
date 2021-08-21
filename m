Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94239C4320A
	for <linux-hardening@archiver.kernel.org>; Sat, 21 Aug 2021 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A59611CE
	for <linux-hardening@archiver.kernel.org>; Sat, 21 Aug 2021 05:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhHUFnu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 21 Aug 2021 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhHUFnt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 21 Aug 2021 01:43:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B874C061757
        for <linux-hardening@vger.kernel.org>; Fri, 20 Aug 2021 22:43:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b9so2779705plx.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Aug 2021 22:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sE8/Gezsq3ktVT1yBNWUnjMOxfVYbA50Rdyo+0rKjg=;
        b=i+WrkoXjNKg4kf7Ku0gUlQx7eIoc5b0b0YLG92TKYL9BVo0rPqj+uzdLB+MjPabU3J
         HjWDWfEsdrVtR+NH2G9+XReIX26V18hHaRdIgzgV8JpSXS7H5HUc9NyL4mjtoZdJexDM
         PZIXoQghEQmI+ZcvoTlg3lVMhlUTAKbTqJLVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sE8/Gezsq3ktVT1yBNWUnjMOxfVYbA50Rdyo+0rKjg=;
        b=AWwiS47oIBltHbzyvewDmL29X69JBRq5196BlJn4Xd1NSW8jkdldwNr/UcO+bOsmdP
         EsnRn9rAjIV73/Pcq/Rqrv8YXBrRzwYl5U+hurhSOIP/p8gXpg9rYuOhlk55wv3TSYWq
         n2fUz/e6Ocd1rNUQKr956jwklp+Iyn8J0SIqPngEgWRTqB4k5nVW9IfSuPqVYra/noQS
         cKvNef1M8bKwwizTa/On7BG2joYv2lCUGpXXSl+5+hU46s49k8epmTP/KDP4u7FFglp+
         t4/7JTQpR1ypM3sri4SbVKJmfZR7vfyw2G3iArV3nyPTSztJja0iwwKMDnrhv3rA5O/e
         uNLg==
X-Gm-Message-State: AOAM533EWeU/4J9JH1B+vupowx1ROtKC5yb7WWBBpQ2qDY+CyvW+iwic
        sk3hTXX2s8ZNbOmFYCQPZgPwqQ==
X-Google-Smtp-Source: ABdhPJzgQUYdkk9J8dqAROFTOnmvvqyCpq+uP6WafjZ2SeuiM0a5Vtnmi8qv2wGXx2oleUl8CurB6g==
X-Received: by 2002:a17:902:bb92:b0:12d:ad99:7fb6 with SMTP id m18-20020a170902bb9200b0012dad997fb6mr19095378pls.49.1629524590503;
        Fri, 20 Aug 2021 22:43:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11sm7570761pjf.17.2021.08.20.22.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 22:43:09 -0700 (PDT)
Date:   Fri, 20 Aug 2021 22:43:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        LukasBulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        linux-csky@vger.kernel.org
Subject: Re: What is the oldest perl version being used with the kernel ?
 update oldest supported to 5.14 ?
Message-ID: <202108201856.41AB391@keescook>
References: <37ec9a36a5f7c71a8e23ab45fd3b7f20efd5da24.camel@perches.com>
 <YR/zrjiCwnzMMcmA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR/zrjiCwnzMMcmA@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 20, 2021 at 07:25:50PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 20, 2021 at 10:27:59AM -0700, Joe Perches wrote:
> > Perl 5.8 is nearly 20 years old now.
> > 
> > https://en.wikipedia.org/wiki/Perl_5_version_history
> > 
> > checkpatch uses regexes that are incompatible with perl versions
> > earlier than 5.10, but these uses are currently runtime checked
> > and skipped if the perl version is too old.  This runtime checking
> > skips several useful tests.
> > 
> > There is also some desire for tools like kernel-doc, checkpatch and
> > get_maintainer to use a common library of regexes and functions:
> > https://lore.kernel.org/lkml/YR2lexDd9N0sWxIW@casper.infradead.org/
> > 
> > It'd be useful to set the minimum perl version to something more modern.
> > 
> > I believe perl 5.14, now only a decade old, is a reasonable target.
> > 
> > Any objections or suggestions for a newer minimum version?
> 
> Not an objection per se, but some data points.
> 
> Oracle Linux 5 (released 2007, still under support) has perl 5.8.8
> Oracle Linux 6 (released 2011) has perl 5.10.1
> Oracle Linux 7 (released 2014) has perl 5.16.3
> Oracle Linux 8 (released 2019) has perl 5.26.3
> 
> I don't know that we need to be able to build on a distro from 2007
> or even from 2011.  I think it's reasonable to require updating to a
> 2014 distro in order to build a 2021 kernel.
> 
> For comparison, we currently require gcc-4.9 to build the kernel, and
> 4.9.0 was released in 2014.  So perl-5.16 wouldn't be an unreasonable
> requirement, I believe.

Ubuntu name/version mapping: https://wiki.ubuntu.com/
Ubuntu Perl versions: https://launchpad.net/ubuntu/+source/perl

The oldest publicly supported Ubuntu (18.04 Bionic) uses Perl 5.26.

-- 
Kees Cook
