Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64BC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 00:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKJAHB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKJAHB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 19:07:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1746617A99
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 16:07:00 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 130so153721pgc.5
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJAIIa6Vlk97dPijdSTZusAFpsZaMTIG9iYNeY6hYbE=;
        b=dw9lyZglZzeUd+urH8dtKjOlHQwRFXKLx97i3NHd7iqX9uUOEzDD5aAvYo2HiURERK
         POXwlnCH+QQ4c2p55Oynmg8UxSk44H/ucl7OOwn3R23jMQg4Y4duMrUu9MjZADTXXvJq
         qw/02W31vwKHRoLIiBydme/bvngW2M31K0mww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJAIIa6Vlk97dPijdSTZusAFpsZaMTIG9iYNeY6hYbE=;
        b=PHFt86LyB7QaO89mlhrb627TSzAUsWDSUGb0FeNMlo4fE8N54EiPtwT2jP7ZTDaLKP
         MD960d1G7HLhqRUtRB/Yzp2KrvJUidG8IjUWR82AriQC8kZpmM4gLwUYRV9FmBDle89t
         0V9jLtEoKUu75Tmv7jtRsur2jM1Qs+e4O3eXpS1xwq3hvDqrq8b3V+IVURX4kJbzTKDe
         8vYzNi+bsxuyJ1YL+LdgrqFgsB6d+0Ti3qlCX6PTxzE+jf5h4MVlTTHb+V6yXGqLsirz
         AX0171fqxtMkZp4WGz66KNfeA0IsZJYQo2pQF006WiVeEKgWn7DjMdTsUnohbQx5EIq8
         m1zw==
X-Gm-Message-State: ACrzQf2a8xe/fpPgn23PWcgMIm/halI6sv1c/G0+YrhUWYBwKU6+MGoP
        ou4YSibplrnwFDZH5aWr3u7pmQ==
X-Google-Smtp-Source: AMsMyM7xgxlYavVGj8CSCMRAUq/ab8Tyu6hn/NiZE9Jp09ZmsKSMmadPxe6XXoVnMxlP0KfQKNxupA==
X-Received: by 2002:a63:35c6:0:b0:470:d38:7c63 with SMTP id c189-20020a6335c6000000b004700d387c63mr33856158pga.249.1668038819565;
        Wed, 09 Nov 2022 16:06:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b0016c9e5f291bsm9659662pln.111.2022.11.09.16.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:06:59 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:06:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/7] cfg80211: Avoid clashing function prototypes
Message-ID: <202211091606.11D47EF676@keescook>
References: <cover.1667934775.git.gustavoars@kernel.org>
 <a68822bf8dd587988131bb6a295280cb4293f05d.1667934775.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68822bf8dd587988131bb6a295280cb4293f05d.1667934775.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 08, 2022 at 02:23:55PM -0600, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 73 warnings like these:
> 
> drivers/net/wireless/intersil/orinoco/wext.c:1379:27: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_param *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         IW_HANDLER(SIOCGIWPOWER,        (iw_handler)orinoco_ioctl_getpower),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../net/wireless/wext-compat.c:1607:33: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_point *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         [IW_IOCTL_IDX(SIOCSIWGENIE)]    = (iw_handler) cfg80211_wext_siwgenie,
>                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../drivers/net/wireless/intersil/orinoco/wext.c:1390:27: error: incompatible function pointer types initializing 'const iw_handler' (aka 'int (*const)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') with an expression of type 'int (struct net_device *, struct iw_request_info *, struct iw_param *, char *)' [-Wincompatible-function-pointer-types]
>         IW_HANDLER(SIOCGIWRETRY,        cfg80211_wext_giwretry),
>                                         ^~~~~~~~~~~~~~~~~~~~~~
> 
> The cfg80211 Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. There are no resulting binary differences
> before/after changes.
> 
> These changes were made partly manually and partly with the help of
> Coccinelle.
> 
> Link: https://github.com/KSPP/linux/issues/234
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
