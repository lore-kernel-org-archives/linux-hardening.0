Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29136C4361A
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Dec 2020 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7A422CE3
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Dec 2020 22:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgLDWHk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLDWHk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Dec 2020 17:07:40 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A7C061A4F
        for <linux-hardening@vger.kernel.org>; Fri,  4 Dec 2020 14:06:54 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j1so3918549pld.3
        for <linux-hardening@vger.kernel.org>; Fri, 04 Dec 2020 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gori3kUA64YgNU6UBCdbHw2TXtwN2d5yKUIKFTfI0AA=;
        b=moAcN6+ODHOyETjJBqhHDKOFH35pHugAZVIworJx8Bh8XiqNthLTtglxYxCQMcgD9t
         EuhEIrf5nys/mrqLdGSAeWPGHhgA2PGTdFkRkwfmcnnD9gFDUqc6ZiIOgqz320yBsIjF
         eDE4NFjkwKX2C7oclt2PA12CfOEDMnZhd4Vkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gori3kUA64YgNU6UBCdbHw2TXtwN2d5yKUIKFTfI0AA=;
        b=ttG1LZ7s/C2hMcADLrp0y22goN78MTJfHMqiyoWZVF5imipVzPP+Rvb32HxUMhvngu
         GAF6gZj4Bhoqozfz1K+2hNIlmMLWeWMvFjQa6Tl6knrKQBxHu5vlsvq6tmExCAtBU8qq
         DHO20I4OdiG3hPGPzRNgAHYQfWDtCEbVQ2PdtYxAfPxQ5Y07IklNvu0StxsrOT+t+Fdq
         sxBjAVQTeZ9LnF/cGv5itIQj97Sg94UsbW1Kqekiff9KpYfN5e6zHMOdv7YfezhOF84R
         78BAp48hLVMJygSyPL05k49+bgPkf99dJzUmZ6+I1PBqCHbakO1YQ00WRh+gvj2PqXRI
         bV2g==
X-Gm-Message-State: AOAM531faxCwte4l+pFA9G/hxVS0M0s0kL7pNgzEeSsI7oV2ABeQw9mr
        8dczSviiIMeHlybLOSNNGQfz6gSkjyNflo9P
X-Google-Smtp-Source: ABdhPJz7QSFylPAL05DlClEVzxlehxj1vIt6CBLVjFNfrVgwlmbSrF2SLY1xtozHZOjTroYefQocwA==
X-Received: by 2002:a17:90a:3ee3:: with SMTP id k90mr5882162pjc.164.1607119613927;
        Fri, 04 Dec 2020 14:06:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm5622902pfe.30.2020.12.04.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 14:06:52 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:06:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
Message-ID: <202012041403.792DE050C@keescook>
References: <20201202134929.99883-1-masahiroy@kernel.org>
 <202012021101.E0BAFC3B@keescook>
 <CAK7LNAQxS2Zn3O4Q0Ca5KgoyEwW5_5DtPDZoXAH+dxbki7dmLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQxS2Zn3O4Q0Ca5KgoyEwW5_5DtPDZoXAH+dxbki7dmLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 03, 2020 at 06:35:38PM +0900, Masahiro Yamada wrote:
> On Thu, Dec 3, 2020 at 4:01 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Dec 02, 2020 at 10:49:29PM +0900, Masahiro Yamada wrote:
> > > Documentation/process/changes.rst says the minimal GCC version is 4.9.
> > > Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Do you want to carry this in the kbuild tree, or would you like me to
> > pick it up?
> >
> > Thanks!
> >
> > --
> > Kees Cook
> 
> 
> Please pick it up.

Sounds good. Thanks!

Also, Emese, I haven't seen an email from you to LKML in almost 3
years. If you're interested in staying on CC for GCC plugin stuff,
please let me know. If not, I can update the MAINTAINERS file to reflect
reality. :)

-- 
Kees Cook
