Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FFC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Dec 2021 19:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhLBTjY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhLBTjY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Dec 2021 14:39:24 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D507C06174A
        for <linux-hardening@vger.kernel.org>; Thu,  2 Dec 2021 11:36:01 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id j11so781395pgs.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Dec 2021 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0SCOI+o2Z/owL9Mbm+7ldS+Ld81vbYtWdoGHtJnRY5Y=;
        b=jHbX+QSaWPnnpWzqq1tRWLqe5/ckDCq0fs1OiUAHUuBYHXNsRp4tNlKtFROZysh7Xm
         5w6QTpy5Qznt44TW+gPAkDSU63d5O+gpQL9KTXA9nUXnBHzGX8gGzY2sUkX4KjBFQWKN
         j5uzRf9R9g65wpU4/lec6bpGPCY9iEi/i3utQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0SCOI+o2Z/owL9Mbm+7ldS+Ld81vbYtWdoGHtJnRY5Y=;
        b=mzREdcT1qisja5i3EQeMrxFZqfxLSSjbO+QUg1QX5L8pOwTErCsVofFctfY7Oece3v
         L8Oq093BIrEoPzyxIL9ScK5NEUnasXYLkrSSjkBmPziVBNtLBhmZbjJ9PI5kYI87N8qe
         hoME9EwbY5zMU+g2FgKatsujZWCUjfhu2QO3qSlnLK36tHRcK0jcYwdXOMeJ/bukLPjG
         B0EoVhLpdqQ6ML+1unF5EScvYdoGW+2LBbd2jacLdtqKha0Gxp9PRefjF4gCZdg3i7hw
         LAjxSSt3bEqJCMCBzgT37hbPlBfmTMAmbDCKQZYUfc/DY2X1Huk9241MfjThIXh73zeV
         7KuA==
X-Gm-Message-State: AOAM533anXGwjRoa9jf3XMvHAoC7nayiLIpzOBrEVuv3SiMzgYR3bU8a
        9uOa3Znd+4ycT0excxwf2Hlm8RAXEOFyoA==
X-Google-Smtp-Source: ABdhPJwG+2Ng4ORjTZPJ/DNAPaqRQbpeTyovONbGKBGWpSTCR3gwh2Oq8LwoJrRPz9k5/eNQ1u98/g==
X-Received: by 2002:a05:6a00:8cf:b0:4a8:3ae:1a78 with SMTP id s15-20020a056a0008cf00b004a803ae1a78mr14246553pfu.7.1638473760881;
        Thu, 02 Dec 2021 11:36:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id na15sm3632525pjb.31.2021.12.02.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:36:00 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:35:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yang Guang <cgel.zte@gmail.com>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: use swap() to make code cleaner
Message-ID: <202112021134.7ECC69C1@keescook>
References: <20211028003526.7117-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028003526.7117-1-yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 28, 2021 at 12:35:26AM +0000, Yang Guang wrote:
> Using swap() make it more readable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 334741a31d0a..feee5ba8fa2b 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -244,11 +244,8 @@ static void full_shuffle(tree *newtree, unsigned long length, ranctx *prng_state
>  	unsigned long i, randnum;
>  
>  	for (i = length - 1; i > 0; i--) {
> -		tree tmp;
>  		randnum = ranval(prng_state) % (i + 1);
> -		tmp = newtree[i];
> -		newtree[i] = newtree[randnum];
> -		newtree[randnum] = tmp;
> +		swap(newtree[i], newtree[randnum]);
>  	}
>  }

Hmm, I don't think you compile-tested this? The gcc plugins are build in
userspace without the kernel headers (i.e. no "swap" macro). I'd be
happy to avoid open-coding this, but that would require a new macro
specific to the gcc plugins (to avoid std::swap). Also, there are two
other open-coded swaps in here that could be changed too. :)

-Kees

-- 
Kees Cook
