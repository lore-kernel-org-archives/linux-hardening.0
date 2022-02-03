Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FDC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbiBCRUw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352828AbiBCRPx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 12:15:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58EC06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 09:15:53 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s6so2667321plg.12
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCxgeYKdwlKt0oqnTuPB4zw2ANgtkFxZ4Jnzg7Jm2aQ=;
        b=c7TfdBKWq7b7RwXKegDo7mrxtFQaaMbFoWobJsoFragv/CCi7+NaQgykHUP9fODpAh
         zDUYUZfAmM6XrgVppNUw1Zuu90Gp2iASFyev8WnefWTyjFibflL2S1CNcWlwjQx2YLCW
         rvlQn7kFjydRTsZ1iGN4NjaGbVymOO3oSxaoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCxgeYKdwlKt0oqnTuPB4zw2ANgtkFxZ4Jnzg7Jm2aQ=;
        b=Y5C2yxClXNAxWHxqdHK+0TDXXkcKG/HqH4LmQm9Yka+1ZSrUpSk7Rp87A97ljdhOEJ
         RYkJVwjRQXON1T4k4pj28JELXR5jFkrNISVHvEEHvpZFIhfcXoEgAZjEJRAf5t20P6JY
         ipo0zPHoZSBBjY6ETlwntx/ib+vlzGcwXN8+vqZZDnBwhqJH3Ju9asy9pca73yxB8roj
         myFgO+dkH/7opkpc5aJknWsiofdRdW9GGqVydrNFaeQTYpnXmAkITdYnBINNggd0rEMb
         EsVmaQf8aTtNan8Q71AhrjJ/pNoLc8PR6/becDlqNQ/Ab/zQBpx+mVEwwYFuqZWHhYVv
         vs3w==
X-Gm-Message-State: AOAM533S9HR/JP/0gZCnQCHfQDdWoEgafwv1iahv62ZYzm50GtYPBAAI
        DQ7RFDwIVL0DjIS4LZJYs8mcHg==
X-Google-Smtp-Source: ABdhPJzJUGd7ygya4e6M/1Gh2HV6OhdW0Ix+MHxpkRCd4Y5gQDZhB7ej+H+RwMQeV6zcPMjLwU3ZZw==
X-Received: by 2002:a17:90b:3a87:: with SMTP id om7mr11784961pjb.196.1643908552517;
        Thu, 03 Feb 2022 09:15:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18sm29699773pfk.14.2022.02.03.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:15:52 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:15:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202030911.4914709E@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
 <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
 <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> Not if -ffreestanding, which is what several architectures are
> using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> functions to other stdlib functions (e.g. strncat() -> strlen() +
> store, strncmp() -> strcmp()), which breaks linking if the latter is
> only provided inline.

Hah, for i386:

arch/x86/Makefile
	# temporary until string.h is fixed
	KBUILD_CFLAGS += -ffreestanding

This "temporary" is from 2006. ;)

6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")

Removing that appears to solve it, and appears to build correctly. I'll
continue testing.

> It works after dropping -ffreestanding.

I wonder if the other architectures were just copying x86?

-- 
Kees Cook
