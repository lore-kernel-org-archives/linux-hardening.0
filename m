Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD43C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 02:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJRCoD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiJRCnz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 22:43:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EC97D6A
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:43:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so12527527pls.9
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9bVbKjcMFy6WPGWlEhUD2iI062qF6nYT+c2WdgY1Q8=;
        b=gWp2faJnrCBXaa/EzcdaiT2psb/PKcsg9+6LtqyyYDhruCaHVeQ7fUSv4MDU7UZlmZ
         c2YFULQTK+7bF1Z6M4M7iVyKxo/AQs0mJp2x4jSD2wADIhZyAfCmCLAfyTpAXNo5Am1Y
         n9AWDMbyh9I0/jm5RxLt8JfNAgM6LjGg0lqN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9bVbKjcMFy6WPGWlEhUD2iI062qF6nYT+c2WdgY1Q8=;
        b=yxEUPSkVAmAHfTwCAKHJD2Q8ba3xkQbi8MmK1Ks+MUL+LkyQ+WkT0t5UvQRo1wzb6w
         LBLK2lnGmG3UbgvZg0uCQSprSm3/GgGyEkOU9Y8KN6Wqf864kEtSkksXqEvi3Fu/v3gb
         F0z+lNe2gOVZWLfo5FmyEjVYhuE9pA34HT57N6KlvI2qSpUyjxT8Ak6m2EST0Cnmys9g
         fXnNpw8xOLmK5YTGx2/86v1TMIkae7dW9hmlH2RIwJ/OtDTP7rA6feKmIXgzyGIrQnIW
         ky0mqkXeH9XXyxc8T0OoStP1AsdjtmTFfui7h4ryNc53fpa5bB5YlUOBgIeKuUOZgzoe
         EM9w==
X-Gm-Message-State: ACrzQf0Qc26KxcZVMDmUWuDPewynOhg/2mmcQtUH1Kyn4Gatky5d0lIS
        FHYDdeL3G2e/JLb+6Z58pKWtbQ==
X-Google-Smtp-Source: AMsMyM47Y1NyZHdqz1//0n1330NKrwJOAGp7q/D/pp97k2bhIugRMB78h4i6pLlpQLE0EUIevEe13w==
X-Received: by 2002:a17:902:d717:b0:17f:6155:e578 with SMTP id w23-20020a170902d71700b0017f6155e578mr717658ply.31.1666061031803;
        Mon, 17 Oct 2022 19:43:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001811a197797sm7274765pll.194.2022.10.17.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:43:51 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:43:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/6][next] ipw2x00: Remove unnecessary cast to iw_handler
 in ipw_wx_handlers
Message-ID: <202210171943.1B5E6B85@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <421a4b4673da8fb610850f674d0994ad46bc1ed6.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421a4b4673da8fb610850f674d0994ad46bc1ed6.1666038048.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 03:34:48PM -0500, Gustavo A. R. Silva wrote:
> Previous patches have removed the rest of the casts to iw_handler in
> ipw_wx_handlers array definition, and with that multiple
> -Wcast-function-type-strict warnings have been fixed.
> 
> Remove the one cast to iw_handler remaining, which was not removed in
> previous patches because there was no -Wcast-function-type-strict warning
> associated with it.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>  /* Rebase the WE IOCTLs to zero for the handler array */
>  static iw_handler ipw_wx_handlers[] = {
> -	IW_HANDLER(SIOCGIWNAME, (iw_handler)cfg80211_wext_giwname),
> +	IW_HANDLER(SIOCGIWNAME, cfg80211_wext_giwname),
>  	IW_HANDLER(SIOCSIWFREQ, ipw_wx_set_freq),
>  	IW_HANDLER(SIOCGIWFREQ, ipw_wx_get_freq),
>  	IW_HANDLER(SIOCSIWMODE, ipw_wx_set_mode),

I'd just collapse this into the previous cfg80211_wext patch...

-- 
Kees Cook
