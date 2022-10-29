Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9123DC433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 29 Oct 2022 07:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ2H0L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJ2H0K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 29 Oct 2022 03:26:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD58C8944
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:26:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 78so6634495pgb.13
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yyu0gP5Bb5qvocG8rpAWZtvXtV2KdF5OgX3sx6HcHQ=;
        b=eKyt9tfG9gweAqhcqLfGjGcVfvk3YhEwQzY5C7ht52aRbjB8RAyYvIT7/RvXrXSPYQ
         5VQK1mjBMumwUFTjZ8euzvgxSKvtb+xTEDKedZ8JROWflZ1Buz0MpCqbnnixWWrLGvn3
         +nkZv93pI/RsG4cHaEecJJn0JGUH7/LrgXLJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Yyu0gP5Bb5qvocG8rpAWZtvXtV2KdF5OgX3sx6HcHQ=;
        b=L7KfqSKaZQ5CGLrZKyfdtnGsu1XzGt88LAvhr8HB7mBb2eoB0KJM41YbCKhEYb5h8Y
         eE4XD6UczbMgB8/R8AbLttmU11JZ0VAP6sdbRR4XRUI+zlr6/8e1grNLxnnyJLqfELGg
         zEWIoKhKyisuiaX3k38A3RqohJ29huwHZ7OfbL3ETn8Q5jmiFBKNBTVJhNvPkgXPXoyK
         AiWuT4kAv/ml/+LEC1SjULkAZ+kh8fradCqeMyfNN5vLiLoyLlcpEHfpC3sFin5O4RHk
         GK4ApoCGJCEVwKLulC4+CQNkLIzFocppCcfr35C26sMoLVMSD29uXc1KYivXsFUxNNvH
         Jg7g==
X-Gm-Message-State: ACrzQf37a6fWEK+yChBKtyABKCeIRwxe+HkDsaBrJYJQLMcOojLvVxRa
        t3NGsx5gwCZemtrZ7HjIc15maw==
X-Google-Smtp-Source: AMsMyM5H5GaoRCI8ygD2fvAGRfIBNhhHRuNei1zA0uK+T3MYurTYRxSwNAcok7DZJjgMdO4V3gy2Pw==
X-Received: by 2002:a63:4651:0:b0:43c:1cb7:5c09 with SMTP id v17-20020a634651000000b0043c1cb75c09mr3100964pgk.259.1667028367680;
        Sat, 29 Oct 2022 00:26:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a560100b00212e60c7d9csm499779pjf.41.2022.10.29.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:26:07 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:26:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/6] hostap: Avoid clashing function prototypes
Message-ID: <202210290025.15F3F949B9@keescook>
References: <cover.1666894751.git.gustavoars@kernel.org>
 <8388b5ed9e729eb9dadec875a7576219e6d61223.1666894751.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8388b5ed9e729eb9dadec875a7576219e6d61223.1666894751.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 27, 2022 at 03:18:37PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 42 warnings like these:
> 
> ../drivers/net/wireless/intersil/hostap/hostap_ioctl.c:3868:2: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, char *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         (iw_handler) prism2_get_name,                   /* SIOCGIWNAME */
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The hostap Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. There are no resulting binary differences
> before/after changes.
> 
> Link: https://github.com/KSPP/linux/issues/235
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks like prism2_private_handler contents could be uncast? Otherwise,
yeah, looks good.

-- 
Kees Cook
