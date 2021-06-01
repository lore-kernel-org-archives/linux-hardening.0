Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDBC47080
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29256136E
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhFATWL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATWL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA4C06174A
        for <linux-hardening@vger.kernel.org>; Tue,  1 Jun 2021 12:20:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r1so160341pgk.8
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wNSZ6PEDj3I1kXtwa13X25gdAklt5nxT1YtwBzGa2YQ=;
        b=NhHRA4kT8tiQuiZykTXa40SjjGmLaMqpdUobJPj+9UB6O9VPanYx2GXGoNNW2idVtb
         tSOeuNxywX6WbCQ1hiCrgr3uDWI8i/vEtmIa5SoynKtda2lGyxsFkYlhhnQHp9VFuyVV
         phF+MPvJKH71mbm93+BxK1iJZVF3Uu19OmnwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wNSZ6PEDj3I1kXtwa13X25gdAklt5nxT1YtwBzGa2YQ=;
        b=SHPwPmy5C5/h1OmX4I3ZeN65OMHFgkC/P2jlT7oGYXKUVlPi2J52WJh8EiczlDG75O
         VjkXaIPVYmgPup+pmgiLdbXYv0g6KVXQaik4rvyriZgINUt+hYUwX9dTRouB3D+M7AU2
         6II8zpFhqBIxvSM0LgTdorI/OZqH7/a8jOhC3TQZS/KkljPTMIZGVkyUENDzU7VHqS3b
         ucysUF78zGxkm9rdMI6vAEqYGxm/9piKjs5LMIKLKBG8jr11NhVcRGutbqpv9sslUZ/l
         e8e0na/7BTPrmrgN0LfGcppLjvf/RvPMfQ9NlkW358nQvbK+J9Re/pwzfEjJ5Ij3xwb1
         NYzQ==
X-Gm-Message-State: AOAM533xslR9sZQSz6GKZ7UCcJ2hPndQBlXbX6P6xBrG7ENLDlOYvujq
        jz8UAtz5wx3v075r6aCE8zgChA==
X-Google-Smtp-Source: ABdhPJxgSwrzgiPoAYHk8fJ2FP/69zlFDckk7KeQjqUvaP9nnygyCFBz7Yg0bGTSdlJmazXgdvvoPg==
X-Received: by 2002:aa7:8f3a:0:b029:2e9:c63a:312e with SMTP id y26-20020aa78f3a0000b02902e9c63a312emr14024994pfr.73.1622575229181;
        Tue, 01 Jun 2021 12:20:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi11sm2712312pjb.29.2021.06.01.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:28 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] kgdb: Fix fall-through warning for Clang
Message-ID: <202106011220.AA0C1482@keescook>
References: <20210528200222.GA39201@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200222.GA39201@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 28, 2021 at 03:02:22PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a goto statement instead
> of letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 25 in linux-next. This is one of those last remaining
>       warnings.

So close! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
>  kernel/debug/debug_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 4708aec492df..431749dd9ab6 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1038,6 +1038,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
>  	switch (kgdbreboot) {
>  	case 1:
>  		kgdb_breakpoint();
> +		goto done;
>  	case -1:
>  		goto done;
>  	}
> -- 
> 2.27.0
> 

-- 
Kees Cook
