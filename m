Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014FC433E6
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7E664DFF
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 23:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhCDXUf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhCDXUd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Mar 2021 18:20:33 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD494C06175F
        for <linux-hardening@vger.kernel.org>; Thu,  4 Mar 2021 15:20:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so494161pfk.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 Mar 2021 15:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BmHuJ6EbKgv6oC/dKNN76FQAZcbaEkgGB9SgRX7z29E=;
        b=AECHJZxSqvO+H4GKfRfbmYxEEWwhR68+5jgW+7sCDf7jwXzJXGnkkpow7w+vSypoOZ
         mZxKl1Rxqm1dyKVqStc7s0lW7M5tgeNWs/QnZENt9tDvYo8kMmVqS8h+gl3jrVX8tO+A
         /c/zigxHkh/9WkLw1nocQtHKi43PAANebC9vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmHuJ6EbKgv6oC/dKNN76FQAZcbaEkgGB9SgRX7z29E=;
        b=Y9SsnwA5XnZlvTDMXDqv5/ck69Kpa0JAz6HyThXK+43Fa2KzLhWvd/91Vk2ja6TOQi
         Y1dhQblDCpsy7+4q1jl3IkKgQYmlv7untVimTaO8pt4S2MBrc+BU/GxOm56Uu6a0tRkB
         0XBjfUydvKa7Ve8EPYNeVi9NJDB4AkXXRCfbb/h1KR7KPqdKMSzW79a3Bhnl5ckH2Jns
         eprHsYpOlG718pQHxkip7JdSVY2qi9NkIes+sAIsBdbx4avZQPz9ZQ959sJGU1OL4423
         r86+HhRJvcrV+cjHq9eZtbJGxA64oAUoM2YOGLuWs/X0Yj3toIW8+hE0n7NuUUYu18Ok
         Jezg==
X-Gm-Message-State: AOAM530BOGO0tnFRwIFfnmD42HGneWvcSoV7XRqmQa/GpEp0YnvkNrJr
        7GqxL7ADEKP+I6Jd03Og5fm1z1rLCBMIcw==
X-Google-Smtp-Source: ABdhPJzL95WWM3jJYkOgx7odmGkUkJlPHvcnpsTZPqC6hZXjg6GSAgg8EYiRpn+3ZgM1ClMsY/c5zg==
X-Received: by 2002:a65:6645:: with SMTP id z5mr5434570pgv.273.1614900032448;
        Thu, 04 Mar 2021 15:20:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11sm423311pfd.43.2021.03.04.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 15:20:31 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:20:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: rebuild GCC plugins when the compiler is upgraded
Message-ID: <202103041518.22EB819E@keescook>
References: <20210304113708.215121-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304113708.215121-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 04, 2021 at 08:37:08PM +0900, Masahiro Yamada wrote:
> Linus reported a build error due to the GCC plugin incompatibility
> when the compiler is upgraded. [1]
> 
>   cc1: error: incompatible gcc/plugin versions
>   cc1: error: failed to initialize plugin ./scripts/gcc-plugins/stackleak_plugin.so
> 
> GCC plugins are tied to a particular GCC version. So, they must be
> rebuilt when the compiler is upgraded.
> 
> This seems to be a long-standing flaw since the initial support of
> GCC plugins.
> 
> Extend commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the
> compiler is updated"), so that GCC plugins are covered by the
> compiler upgrade detection.
> 
> [1]: https://lore.kernel.org/lkml/CAHk-=wieoN5ttOy7SnsGwZv+Fni3R6m-Ut=oxih6bbZ28G+4dw@mail.gmail.com/
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This seems fine to me, but I want to make sure Josh has somewhere to
actually go with this. Josh, does this get you any closer? It sounds
like the plugins need to move to another location for packaged kernels?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
