Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BECC38A02
	for <linux-hardening@archiver.kernel.org>; Sat, 29 Oct 2022 07:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJ2HI6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ2HI5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 29 Oct 2022 03:08:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37BC894E
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:08:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j12so6666378plj.5
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzcLGa40PU645ZHdnZiIvzrctQOCbb8NjdOW/tOfkS4=;
        b=Ncg8dU+PZyCkYjAAH0AwNWHdcll+bkHHTTJj0zkxNOxreTHJ+prUiMGsHUe3V6u+Sx
         PowDRBjszWb522ZgOCL84Wq/LyhxKvESfTBB2/TyPllH5GYb7+exRGqjkJBEtFP9T4LS
         LKBdbzKGDDgPZyfS9KTTdw4JPqIXh4T6O7RAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzcLGa40PU645ZHdnZiIvzrctQOCbb8NjdOW/tOfkS4=;
        b=O9uItV7lPo+WaY4XWp1AwZrNQqBraLaPZYOr4UmOR0qAGLZpVj/TPZ9cIGwMiqffs+
         FkK2lyEbxMyJLoKOuTmtCZBf8WgCsY/bkZZNrGDK4429D4j2aqgBPpn6WPnKV3kLWaQz
         dywqvWiHbjVD1fRIrqv7Q7wsDgRmAXTEJytEoXRTiIehggfTJbWpw+W9SXIF0ugpEVt/
         x9GzHpzDmnQYRx41zfBgI2Hv5oq2WzbIXPt41Wv6uzJZjC22n119zm8FFiRjyPVa7twC
         00V6TSpmQrgvwUGjADnFkFzu3CRhj0QMiKgIzmneU0AZsCCv5YTss4Ut+BHYZdbr04P9
         aYAg==
X-Gm-Message-State: ACrzQf18kr6UkQIdMvcfluY8xe43yDoNysdlKSAehtnJdEyz6FMgN1X4
        3ByRajWKl7iHHfVfHU31muT7FHlEH+Zk6g==
X-Google-Smtp-Source: AMsMyM7t+pEir+OtaKpYxEjojwh2ilO+LY0D6A+WGDhuYjJXWK+Uy3UX3wJWTPlbaLcbM7860PBf6Q==
X-Received: by 2002:a17:902:d54a:b0:186:e852:6775 with SMTP id z10-20020a170902d54a00b00186e8526775mr3066421plf.44.1667027335098;
        Sat, 29 Oct 2022 00:08:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o5-20020a62f905000000b0056b4c5dde61sm584610pfh.98.2022.10.29.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:08:54 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:08:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/6] zd1201: Avoid clashing function prototypes
Message-ID: <202210290008.F909BCDEB3@keescook>
References: <cover.1666894751.git.gustavoars@kernel.org>
 <973dea1fc38ee4df0a6ff6d07b3a3966be781316.1666894751.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <973dea1fc38ee4df0a6ff6d07b3a3966be781316.1666894751.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 27, 2022 at 03:19:19PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 30 warnings like these:
> 
> ../drivers/net/wireless/zydas/zd1201.c:1560:2: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_freq *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         (iw_handler) zd1201_set_freq,           /* SIOCSIWFREQ */
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The zd1201 Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch.There are no resulting binary differences
> before/after changes.
> 
> Link: https://github.com/KSPP/linux/issues/233
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

This looks right to me. I've got half a cocci script that spits out
something close says interdiff. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
