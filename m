Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECBC433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Jan 2021 17:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B1D22285
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Jan 2021 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhALRcV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhALRcU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A2C061786
        for <linux-hardening@vger.kernel.org>; Tue, 12 Jan 2021 09:31:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j1so1772661pld.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Jan 2021 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gszL2E3VdL8RsIgnFpVUkcrAEKhs/wMGNVMIkIbtCio=;
        b=kXriF6lXXgicCw5/Lb3CqFuEtYLcY/CIJbgbkwvRS82DfY2tqQoot3SCGYJmO+caZc
         DlsJizP1kcplvgKi2Kxlnwio7DPWXT1k8qtzDAesiJCdc++uwb9iJa9Q1otIrNOpuhV0
         vjEsgrkFMeOj8tkTeSppZ2fh8AfPQpkrrx8fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gszL2E3VdL8RsIgnFpVUkcrAEKhs/wMGNVMIkIbtCio=;
        b=YrsIuVtp93LkxeNdvEZNiQbojC2G2FMNDjQUwxtcceKI9vXkAvm83fSsmVNVWy6Ide
         TNuJjd88BPWXP8eNCJo6djom/MxbwDb4IoHlz8vt66fCPM4XqLfzS4P2qVOpXhq2aCpZ
         2C0ENPjItEHMv5tS3vKJthqq1AlqCILr0YooZSKuohRpUUfajGnrGpa5JyNY2X1WlvNJ
         SJijAjc/+2UUYTcDIgw5wWe93EhiunhvymoopZG5NMtRaH50Be5ZLWu4p3/7XBrKHhqf
         vYJepsTWftAbrQaZCoxRycWhTl/yKaDZXaPLGP7VMccMv+80cZwZ+lNjJTKSamX3M7Hz
         tGBQ==
X-Gm-Message-State: AOAM53171+Et2TOppe46XXimm3qqSwgjqrzpZaWLXEwNAjVbLX60LXW8
        WB7qUyVBoWWa940bSJeJZwt21g==
X-Google-Smtp-Source: ABdhPJzrXTULtYCmxU7ZcNLU+k1uU5R8ekYs05eVYzYNSKiNNUMcSUwzfdVTV8Hd2GEWEO5pt7JrwA==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr194231pjs.124.1610472700173;
        Tue, 12 Jan 2021 09:31:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k125sm4726237pga.57.2021.01.12.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:39 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:31:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 45/51] gcc-plugins: fix gcc 11 indigestion
 with plugins...
Message-ID: <202101120931.61C1F0B@keescook>
References: <20210112125534.70280-1-sashal@kernel.org>
 <20210112125534.70280-45-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112125534.70280-45-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This will need an additional fix, so please don't backport it yet.

On Tue, Jan 12, 2021 at 07:55:27AM -0500, Sasha Levin wrote:
> From: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> 
> [ Upstream commit 67a5a68013056cbcf0a647e36cb6f4622fb6a470 ]
> 
> Fedora Rawhide has started including gcc 11,and the g++ compiler
> throws a wobbly when it hits scripts/gcc-plugins:
> 
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from /usr/include/c++/11/type_traits:35,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
>  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
>    32 | #error This file requires compiler and library support \
> 
> In fact, it works just fine with c++11, which has been in gcc since 4.8,
> and we now require 4.9 as a minimum.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/82487.1609006918@turing-police
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  scripts/gcc-plugins/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index d66949bfeba45..b5487cce69e8e 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -22,9 +22,9 @@ always-y += $(GCC_PLUGIN)
>  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
>  
>  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
> +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
>  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> -		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
> +		   -ggdb -Wno-narrowing -Wno-unused-variable \
>  		   -Wno-format-diag
>  
>  plugin_ldflags	= -shared
> -- 
> 2.27.0
> 

-- 
Kees Cook
