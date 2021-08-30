Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4AC4320E
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C74B60F5B
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Aug 2021 20:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhH3UNZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhH3UNZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 16:13:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70949C06175F
        for <linux-hardening@vger.kernel.org>; Mon, 30 Aug 2021 13:12:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so625146pje.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Aug 2021 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyqR6zuX2UnSlgO+2J5doXVmpsPXm+DS8g/36ybZddY=;
        b=SQIeHtMBmXoWaJa+oEtkE7Z1Wr1+Gk4thLQ2B11dg25gCON/sRMIUQ2ljp7IqrY8Os
         VDOxbk7Omq2Pkz+86BFH/5NQSq7osGz1aCoVXyKXmHyt8R9/VCV80GPZM2udmS+cBlv2
         ekjmo0brEeHjMdioxs/LOQzXP+9CsqieIfHzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyqR6zuX2UnSlgO+2J5doXVmpsPXm+DS8g/36ybZddY=;
        b=rK3IEPIr4Hx0Cu+G3jZOJWHbfIKuOEFMiywu9NqxUti2Cy2jsJ+xP8iZLBDYZD8CTh
         dN3akOR4SZ27w0aDDk8t9I5V02IvDnURSzNKktYwmVhq5Wpu9rK56MnSOu/6srfG7B2i
         U8ijhH5Yth/+XHaXRctKHWU7AfaNfvRqb4hTwcywqdreCdxPsaPTOBNf+x+NrhJAjL3i
         hH5XEPbogt2/QpCFR2RrKrG/7rkJ0Y3XsNkogsK/yBn6Tnu66wuvbPJlJsHheLe3LLmN
         pFpTEI9R3Y25EUsunCh70yNp3qMIMGeaiocQZCwps0oMHKmTx+ih8GmVvAWtjKABCz6s
         i+1Q==
X-Gm-Message-State: AOAM532hihNrADDJBpLAwlR7Nxaxyp00W/gEGPWv/F729lXdCfIPYfDd
        mSArTXCPTpECf/hiFXcjaSQFdQ==
X-Google-Smtp-Source: ABdhPJwxc+D9Kf5/yanvqh7j1hXLkbHyjoIvaTM7O7M6Ceokm1ELoy1wb3ivRqj2YByLgovOTg4T5g==
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr940236pji.11.1630354350873;
        Mon, 30 Aug 2021 13:12:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c16sm15534732pfb.196.2021.08.30.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:12:30 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:12:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Message-ID: <202108301259.1FC43498@keescook>
References: <20210827163015.3141722-1-keescook@chromium.org>
 <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS0nJtNDCwfbaubZ@Ryzen-9-3900X.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 30, 2021 at 11:44:54AM -0700, Nathan Chancellor wrote:
> On Fri, Aug 27, 2021 at 09:30:10AM -0700, Kees Cook wrote:
> > v3:
> > - fix typo in treewide conversion (u8 should have been __u8)
> > - improve changelog for DECLARE_FLEX_ARRAY patch
> > - add acks/reviews
> > v2: https://lore.kernel.org/lkml/20210826050458.1540622-1-keescook@chromium.org/
> > v1: https://lore.kernel.org/lkml/20210818081118.1667663-1-keescook@chromium.org/
> > 
> > Hi,
> > 
> > In support of the improved buffer overflow detection for memcpy(),
> > this enables -Warray-bounds and -Wzero-length-bounds globally. Mostly
> > it involves some struct member tricks with the new DECLARE_FLEX_ARRAY()
> > macro. Everything else is just replacing stacked 0-element arrays
> > with actual unions in two related treewide patches. There is one set of
> > special cases that were fixed separately[1] and are needed as well.
> > 
> > I'm expecting to carry this series with the memcpy() series in my
> > "overflow" tree. Reviews appreciated! :)
> 
> Hi Kees,
> 
> I ran this series through my local build tests and uncovered two
> warnings in the same file that appear to be unhandled as of
> next-20210830. This is from ARCH=powerpc pseries_defconfig with
> clang-14, I did not try earlier versions of clang.

Thanks for double-checking!

> 
> arch/powerpc/kernel/signal_32.c:780:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
>         unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> [...]
> arch/powerpc/kernel/signal_32.c:1044:3: error: array index 2 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
>                 unsafe_put_sigset_t(&old_ctx->uc_sigmask, &current->blocked, failed);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This smells like some kind of casting issue. uc_sigmask has only a single
unsigned long element but unsafe_put_compat_sigset() seems to be doing
stuff with [3], etc. Is it expecting u8? I will keep looking...

-- 
Kees Cook
