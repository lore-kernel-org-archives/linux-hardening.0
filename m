Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F5C433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 05:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC16D64F06
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 05:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCRFx3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 01:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRFw7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 01:52:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00DC06175F
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 22:52:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so4443653pjc.2
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HFnvCDyiDf/wXkwBZxcS7hyjxLXnLTp2jBAW0bn33UQ=;
        b=MXB/zjXdp9mm9moKZkRhOBxcpgK+FGMMTS7zXwSq0BNTrtHc5RjCTKABMaBwl2XRH2
         1Cx9jAYecE+0q9K7KxUEFr0jIVdVNduxTdQ8C+XhkyeRiIIcPIaHmQgsk2lWg/xsshch
         Z97QRsNogtrRutzljWF5QJuDnPzdciyYX6d7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HFnvCDyiDf/wXkwBZxcS7hyjxLXnLTp2jBAW0bn33UQ=;
        b=rQ0oG6CmC3ehZv9EqmtRgpTOoq89kM5PB6aaclm2F3P2Im+pk+9QjV/GEzTQTOcVZ0
         yZwcV3fMleTflKC/LQ7JvC+/h6Id0EbcuTYu3ff+mR4V/LKlfluR+kiBb8hXYuJTMoJN
         46+YclmHFGLjv4sl5CqbBmGW2m5ULpjiRswUAoJZkN5uT1bbkLRlE3XcMNbpZ1gL72oX
         pEh0Wy7/dvqbElS4+3uxri+gSXmab9hKhKtIlsYLSCoB6YzJwBL3nF2SxQ8StbCz3TK9
         jeWoeeOO+72et8fbIWcNY2Ye8zGD+ID801apXQ/OOOQ9w0ikVdP/A0B7y3guS/ePp9BX
         zw7g==
X-Gm-Message-State: AOAM531sXTtJ1L4wGSPI5CbZHtrL+xzWLlpjXtxD5TGs8XJzMEMuws3w
        +VHwBIWsb4m4nXKdPhkAkfCqUA==
X-Google-Smtp-Source: ABdhPJzNV7VwYKDSP95ny2zJ1+cMAig/Dkcu+O5FILijf/qb+Toh9TR4o2X4szY+1VXGaRr/axJaBA==
X-Received: by 2002:a17:90a:5587:: with SMTP id c7mr2450777pji.5.1616046778334;
        Wed, 17 Mar 2021 22:52:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm900079pfb.178.2021.03.17.22.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:52:57 -0700 (PDT)
Date:   Wed, 17 Mar 2021 22:52:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on
 old gcc
Message-ID: <202103172251.F9D770D@keescook>
References: <279558.1615192821@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <279558.1615192821@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 08, 2021 at 03:40:21AM -0500, Valdis Klētnieks wrote:
> It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
> due to a gcc bug fixed in gcc6, throw errors during the build.
> The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> 
> Version the option based on what gcc we're using.

Is there a better way to detect this than with version checking?

-Kees

> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Fixes: 27c287b41659 ("gcc-plugins: fix gcc 11 indigestion with plugins...")
> ---
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index b5487cce69e8..cc779973724a 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -21,8 +21,11 @@ always-y += $(GCC_PLUGIN)
>  
>  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
>  
> +# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
> +GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
> +
>  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
> +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
>  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
>  		   -ggdb -Wno-narrowing -Wno-unused-variable \
>  		   -Wno-format-diag
> 
> 

-- 
Kees Cook
