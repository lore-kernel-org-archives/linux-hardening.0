Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6B8C32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiIZWDJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiIZWCd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:02:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326CDEBD64
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:02:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso8318983pjd.1
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=U3wnme3rYduyoVtIGUlTO8+VEkNnq6ssvexioDxXiO0=;
        b=m7A9wPP+UVXaKk5udgflsFMHhHQwhc4ksTnYsMbqMfDG+zGudxILZCBMPvDouo6CdU
         OYBbw1JYGR6PGl6yZEGs2tGERHcfDFJ6TvruMNhy75dUg2xdl101snMyzJHp/rPxtPbn
         pJCMR6qMtcCD/8rP213URMXb+s6hjzbt1RY/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=U3wnme3rYduyoVtIGUlTO8+VEkNnq6ssvexioDxXiO0=;
        b=vryOpVLEKQYt5WibTm72adjzqqqrvuHskpu/bj1wVeojrB4dtmEB/LL/s2DW6elv1L
         zXK1HV63ONVO98mDHqjmGFTD/IF+kr8g2Xiry6FbpzII7JoZR7w6qF46+SPpoJcBJ4U/
         QK+s2m238KI28nyP/7/UYFF6//6yDAlj0+Sz/5z1JEa0jvyFoegSTGeLmUMy6PwyXQKz
         UVm0AeaGWYaiEQOG1IhNqxManv+HOkhKtNLuvkrGsILkFVa34pPp4IY5qK2Z6a3Mg778
         tP4CvAyiQdNB42IqQ4Ac+XzGcrSY/XufWR9DRGaugt7qctJ/uQRQCHK8GMrtFvRgn7we
         0EDw==
X-Gm-Message-State: ACrzQf2zoKHhVk42dMbmEorqFFJMO9ojuRSENtHUW9J3BOM5hdUSvopm
        oC6lqbsNS7m35FZSn/8nmMr8lw==
X-Google-Smtp-Source: AMsMyM6CvAcNqkfH+luPZWoDW5EO95r3BSMZ19DrskXhps5m5gllCO8uEBnH0R9tyeEajnQjAOWoaA==
X-Received: by 2002:a17:90a:fc98:b0:202:52cf:c117 with SMTP id ci24-20020a17090afc9800b0020252cfc117mr917381pjb.26.1664229740742;
        Mon, 26 Sep 2022 15:02:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b00540d75197f2sm13197405pfq.143.2022.09.26.15.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:02:20 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:02:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ipw2x00: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261502.5E16542AB@keescook>
References: <YzIeULWc17XSIglv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIeULWc17XSIglv@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:49:04PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/220
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
