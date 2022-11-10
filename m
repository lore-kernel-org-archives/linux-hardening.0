Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B04EC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 00:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiKJAHw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiKJAHu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 19:07:50 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFAA15FF2
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 16:07:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d10so258247pfh.6
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 16:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apfq1SJY8kBx0BPw4YjdGxKuUOfnIjSNdWi3xLj6lho=;
        b=A4QJ6G9P8aJKFDPDxo52Ftk1kEZlvjRGyxrBbpMizRk9l8ITNTKNRnPL/A1Q49wDEu
         LaEll8jsdoHVD8it+xQcwASslVNSY1GimgdGJ5qmhosCnpl/pddkxzOS3tz7bQfxmznu
         8ecD4ZTou/SslQXNmz3kiMn+42Agc+m1S1qLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apfq1SJY8kBx0BPw4YjdGxKuUOfnIjSNdWi3xLj6lho=;
        b=7egx5S+aWYdHFOAeY30Qhkx/vceFH++JFwQ5ypxE8aWSrXeWZ0Kzo9VRJEJU5n5/R/
         cl4hTIV+qGH48Ihfts5dSjCrj7+wG2ZWP6fBfQd2pWFVAz6EeRUhyYlWlTwkYD06K/Se
         BIHye/uv+8LtwBrCl4aOSbxfpMuuNZpWecq5URZzr/FUiL7Qe+7gau3gbCpZHlcag3YK
         VK5gGimwX5eTgjTsv6gRmlldyGJNX50fGlkF/ssqSmxjuoYJs43it3BgMAgcJX2Rz5ps
         r2EXnPptkziO7C4oZzUAM9/2fGqwh+5OdQDcbn2nsOxcbBK7ppnlogzxQAWv4q/6GxmW
         4AYg==
X-Gm-Message-State: ACrzQf33/N7Z+4djZk97XTskqfLwrZdRL3IX2dYkk5AsKP9wUaZGzOcG
        w+53CyfbpYZyy8himZG5ad1Blg==
X-Google-Smtp-Source: AMsMyM5uW6jcbP6d7HwAUyGzvA10jUcOYZSJZFmIfbGrV+kdNkRKAEplEpnGHaPXxQ24QU6JmV2+jQ==
X-Received: by 2002:a63:cd42:0:b0:46f:9f49:9468 with SMTP id a2-20020a63cd42000000b0046f9f499468mr49028791pgj.361.1668038869770;
        Wed, 09 Nov 2022 16:07:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y15-20020a62ce0f000000b0056d2e716e01sm8840208pfg.139.2022.11.09.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:07:49 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:07:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/7] wifi: hostap: Avoid clashing function prototypes
Message-ID: <202211091607.187D7AEF7@keescook>
References: <cover.1667934775.git.gustavoars@kernel.org>
 <e480e7713f1a4909ae011068c8d793cc4a638fbd.1667934775.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e480e7713f1a4909ae011068c8d793cc4a638fbd.1667934775.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 08, 2022 at 02:25:17PM -0600, Gustavo A. R. Silva wrote:
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
> These changes were made partly manually and partly with the help of
> Coccinelle.
> 
> Link: https://github.com/KSPP/linux/issues/235
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
