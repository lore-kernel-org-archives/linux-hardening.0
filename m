Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86132C433E9
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Jan 2021 23:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6AB23B00
	for <linux-hardening@archiver.kernel.org>; Fri, 22 Jan 2021 23:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbhAVXRM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbhAVTfF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 22 Jan 2021 14:35:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249DDC0613D6
        for <linux-hardening@vger.kernel.org>; Fri, 22 Jan 2021 11:33:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 30so4489420pgr.6
        for <linux-hardening@vger.kernel.org>; Fri, 22 Jan 2021 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRHYirbpaVjReacEED4lbaCE3EfoPDnBMgBWDqUdb1M=;
        b=jcbK3Jb+1ldTw8xuHGcbe/WyAd9rzEWhNsbjwzL7GUFNO0kBbs7g9+lznqTJXv5guQ
         ThmJrhp8cBtmrAw3PicbPDCzSDRMsMTXouV2Ed/Soxu0Aianbna8t6Eyn8vx3xOUitbj
         /UrYMZXa4Z2WVDt0h6nszyYChGEcP/Gw8IFgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRHYirbpaVjReacEED4lbaCE3EfoPDnBMgBWDqUdb1M=;
        b=fFlBDBURTh6/D6/8xRhwi9Apg8DcOASALS6hTqKYSXl1DvCAiNxycU5XMoUZdArGW4
         ashfQkAscZ1uutqUFFnOOcMsaai3YSRftXW6wCGwkBo3yn3X3W1OABUm80/mgEFqv/hB
         IhmH4TMa4Xx4CRfgNUylYL+FmiL0Rr0R3q54LNr9KQm0DOSUa9NAB4icpu291oAJnXwX
         LTgIm8wEPsvat2/Rzy4D/SxGZnfrN6eSuHXgf0BAl2R9fRA3fkOF4rkdsHCVVSHxIQTJ
         bbwJ4B74PlXGbc7OY82QhL86up6nlhyPflgP1pIhyx9q250YuuzqGMMk05S+DYoSSx4D
         4Sqw==
X-Gm-Message-State: AOAM530RUbdG+WIVssYmlIFvrG7d0EOMYka8i0hCZsuP6ePrPdpcRTpq
        JjZWBCTKvPPIT7QsfP9pRio9ZQ==
X-Google-Smtp-Source: ABdhPJzSZ+w9Sa36H0s07wBdXa3HqO3jCZJZAhirfObi0OICrHS6njgn1JnYamu9MMLKfJqtYJ237g==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr1322451pge.156.1611344023652;
        Fri, 22 Jan 2021 11:33:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 129sm9463735pfw.86.2021.01.22.11.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:33:42 -0800 (PST)
Date:   Fri, 22 Jan 2021 11:33:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kspp-next] kbuild: prevent CC_FLAGS_LTO self-bloating on
 recursive rebuilds
Message-ID: <202101221133.389539337D@keescook>
References: <20210121184544.659998-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121184544.659998-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 21, 2021 at 06:45:55PM +0000, Alexander Lobakin wrote:
> CC_FLAGS_LTO gets initialized only via +=, never with := or =.
> When building with CONFIG_TRIM_UNUSED_KSYMS, Kbuild may perform
> several kernel rebuilds to satisfy symbol dependencies. In this
> case, value of CC_FLAGS_LTO is concatenated each time, which
> triggers a full rebuild.
> Initialize it with := to fix this.
> 
> Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Ah-ha, good catch; thanks!

I'll get this into the tree.

-Kees

> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 668909e7a460..2233951666f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -895,10 +895,10 @@ endif
>  
>  ifdef CONFIG_LTO_CLANG
>  ifdef CONFIG_LTO_CLANG_THIN
> -CC_FLAGS_LTO	+= -flto=thin -fsplit-lto-unit
> +CC_FLAGS_LTO	:= -flto=thin -fsplit-lto-unit
>  KBUILD_LDFLAGS	+= --thinlto-cache-dir=$(extmod-prefix).thinlto-cache
>  else
> -CC_FLAGS_LTO	+= -flto
> +CC_FLAGS_LTO	:= -flto
>  endif
>  CC_FLAGS_LTO	+= -fvisibility=hidden
>  
> -- 
> 2.30.0
> 
> 

-- 
Kees Cook
