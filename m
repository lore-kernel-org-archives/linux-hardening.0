Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2194CC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Feb 2022 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiBAHwV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Feb 2022 02:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiBAHwV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Feb 2022 02:52:21 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06785C061714
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 23:52:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id e28so15127853pfj.5
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 23:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6s4d1v9hV2l1S/jpGRVn5Lt3j+92gPeJYBWBA1j+5io=;
        b=WEoyouC2mEjJyN2keJ8lz/FmsGhpcW9VCGGU0eYyeyHmPypxY1I5w88g1b4dc0n59T
         0afDY+/2ZoFcJ/tNyVRrW60Q6MA0YvqUjgY41Yc9PFoTRa3YifeSuSGZg2/ZkJj1baMh
         Sp133tNykapNNn3mktXSs1PlLKcpqHHAWFJfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6s4d1v9hV2l1S/jpGRVn5Lt3j+92gPeJYBWBA1j+5io=;
        b=uObrcfeHdHscqCeSUOI0BmjzfoDp97R3zq4qWHN8LsCIFd4Bun2YWvVNRVtQ39up4M
         15ZKNQVS/hzau4tgSbX2e0lyd4TDFlw75GssXaeY3Nw28sEIBIhgzxdKh9p25y/ohOcp
         gixBNFyEH7Rqrm4lgv1bxH9vL3mOSbBVPsRGDIie5pJHZ2be7KLJEcqr0/7Vez3Ug4ew
         +fwCVRAD8obeAXdcacoKUhu1GQnnnkcuqkcSA13peyzuMDlbDmN132Xsacxp31eNM6BN
         SLBt6pYOYv4Q6djTcSAFgunzg8uBOuTmwGuH6FqyBr5y6/FV9TbyRfBRnVfJSvXaGhww
         Z8lA==
X-Gm-Message-State: AOAM5333tSCNPfdg/8Uio4ufIgJ6/btNdJpayr2kvb9GiU8bbWpI8aR1
        d37WehdGGPm3qt6gAfgd6bcHLw==
X-Google-Smtp-Source: ABdhPJz+86lrnB0vbgzkR9pVdqvvY8GzFf7UQMSt4OXHSBKP+kYPv4oj5u65Q8Rf17l8kRU/e3C4JA==
X-Received: by 2002:aa7:8a05:: with SMTP id m5mr23596392pfa.40.1643701940511;
        Mon, 31 Jan 2022 23:52:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm20831001pgg.80.2022.01.31.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 23:52:20 -0800 (PST)
Date:   Mon, 31 Jan 2022 23:52:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@linaro.org>
Cc:     ci_notify@linaro.org,
        Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [TCWG CI] Regression caused by linux: Makefile: Enable
 -Warray-bounds
Message-ID: <202201312351.915CAD5A5@keescook>
References: <809699127.18214.1643504444637@jenkins.jenkins>
 <202201311410.EA1999F5@keescook>
 <CAK8P3a1CT+-3J7Ufv9TQwRiV4i_+FF=-+phwSjWafyGuPfG+AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1CT+-3J7Ufv9TQwRiV4i_+FF=-+phwSjWafyGuPfG+AA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 01, 2022 at 08:17:50AM +0100, Arnd Bergmann wrote:
> On Mon, Jan 31, 2022 at 11:30 PM Kees Cook <keescook@chromium.org> wrote:
> > On Sun, Jan 30, 2022 at 01:00:43AM +0000, ci_notify@linaro.org wrote:
> >
> > For example, extracting from the build log, I can see more:
> >
> > > 00:00:53 In file included from ./include/linux/io.h:13,
> > > 00:00:53                  from arch/arm/mach-cns3xxx/pm.c:8:
> > > 00:00:53 In function ‘__raw_readl’,
> > > 00:00:53     inlined from ‘cns3xxx_pwr_clk_en’ at arch/arm/mach-cns3xxx/pm.c:17:12:
> > > 00:00:53 ./arch/arm/include/asm/io.h:113:9: error: array subscript 0 is outside array bounds of ‘const volatile void[0]’ [-Werror=array-bounds]
> > > 00:00:53   113 |         asm volatile("ldr %0, %1"
> > > 00:00:53       |         ^~~
> >
> > Looks like something sees a "void" type... this smells like a compiler
> > bug. I haven't been able to reproduce this warning yet.
> 
> I suspect this is a variation of
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> 
> When gcc sees a pointer dereference of a literal address like *(int
> *)(void *)0x1234000,
> this is sometimes interpreted as a NULL pointer with an offset, which
> in turn is
> assumed to have zero bytes that can be dereferenced.

Eww.

I still can't reproduce this error myself. Any hints on compiler
versions?

-- 
Kees Cook
