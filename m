Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1AC2D0E4
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 22:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB393222E9
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 22:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNssUA9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgKQWDB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgKQWDB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Nov 2020 17:03:01 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B5CC0613CF
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2020 14:03:01 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id h12so1232708pjv.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2020 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ViAIxdEXYmY2hPHIdwh9pNwC47o326FcE9bbjHjsLIM=;
        b=kNssUA9oNhB9UWV6KYfqTWNHdQ2EZ92gBGoM0Y44vkNSV+c3H79NSmxssN1cz7vW8o
         trtQx4QN6HJuJGrK1bgsCuL0pSBcgMM821/VCJkuoeonTowLnz420BooLKRDAVyTrtKi
         mhD0AkcmNctlM7cZak9IkMOwiZYcigeR4WWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ViAIxdEXYmY2hPHIdwh9pNwC47o326FcE9bbjHjsLIM=;
        b=fGfbIzffL1uqbV3zk+3mB8ZYT1BSQHgSjhXMlIVx7ek4SSSkCHxshgu/gIY14Wbvo0
         S2imljUzkdXEbbuFZQlANR6uPaKXHi7Wsflmn/9TaX1yGnqNsnudJOnRT8zKsUa+phQI
         AJarF86in6qjR+EWPX4uPm2srvrjGidCfIqeoMTSwRP7AbN+u7vJ3/3Mc/LdTPS5WNMM
         ClUch5NbcqwgZA28qtQtFgcF+kXGsO3TjvsGS0rgt0igu+xYWCSFufcXMLLyNlNsy4ai
         XgpypCpR4blifuFGcN5QBiAry5nRW0VUX0tl4375uJ8cPCed0zHPsF1bs4KPKjF35fmk
         bDJg==
X-Gm-Message-State: AOAM532xqJrP7mnGr+16awZNiTbgo0jnF+NS5MSfIBMWpNQUOtlR9aW+
        FTzLR4RBhoGppM/0ZG+2dplVL+43zPiWNMEx
X-Google-Smtp-Source: ABdhPJw6rY1KdMctd3z4T2qO5IB8tHgovYCIvE77YoJq6HjJUhJTD0u7UhFqGkk+RUEvv0+W9NSSRA==
X-Received: by 2002:a17:90b:1083:: with SMTP id gj3mr1066640pjb.33.1605650580760;
        Tue, 17 Nov 2020 14:03:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm37341pjt.49.2020.11.17.14.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 14:02:59 -0800 (PST)
Date:   Tue, 17 Nov 2020 14:02:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC PATCH v4 3/5] string.h: Add FORTIFY coverage for strscpy()
Message-ID: <202011171402.0B95045@keescook>
References: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
 <20201116145012.24471-4-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145012.24471-4-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 16, 2020 at 03:50:10PM +0100, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> The fortified version of strscpy ensures the following before vanilla strscpy
> is called:
> 1. There is no read overflow because we either size is smaller than src length
> or we shrink size to src length by calling fortified strnlen.
> 2. There is no write overflow because we either failed during compilation or at
> runtime by checking that size is smaller than dest size.
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
