Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA70EB64DA
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 19:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjFMT0n (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjFMTYv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 15:24:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6B1FEE
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:24:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-653fcd58880so4572571b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684286; x=1689276286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hW07/KxIwpPsYdFA9lPkBZ4Xt/G7PhfjivAGs4nndnM=;
        b=QklL5AG1tnpVT2frkelZwrvdvjq6NFTrjc5Tvszw/aY/f3B3LALEwyX5gYg+7k89GF
         3cHjdzapmDZJt99ue2P72ax0cIVA9VO9+o5PHgSe42jmMAUnIiY+ghg7elKePQGvMEZ+
         oSz1rroYJAyibfzgpXQPviHZwRvqIKvQ1tbW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684286; x=1689276286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW07/KxIwpPsYdFA9lPkBZ4Xt/G7PhfjivAGs4nndnM=;
        b=Xl0i43mP60st6emz6PgmNz38KDhUUVTKJQlN+OpdtaGiw62ykuchtEi1FXrcreMBR8
         JWVOGSft5vUtWAldxYQL5cW5iqj5jcQTVBgDmbLypBViEUbFlYWFjhWjRD0GI0y4qckd
         V5wLZ28LPXC3K9zXndIhniJvvqy2DGeYxu3lFrr6c4tOb/SGbh9x7RXnOYwAyqX7Twos
         nnTBz0FLqHsMZDjuOCKHuiG4WeSN0dGvu1cV/e9waZZHIyRIT9bTfap6H4wDLqt1O9aG
         lEyFk1qVkvvyFjGPGBV5D7qDbxVhJaUDhGUfwDXIdYINCrJ7dmb9cfeYmpyrwmF+URWE
         p9qw==
X-Gm-Message-State: AC+VfDxfcIXDWRDL0/z/PWBwHup/wkjtp43JM3m77U8nm1U0vS0mhgtc
        +pdUAkxmaj0B/THpVZDamhv/ZA==
X-Google-Smtp-Source: ACHHUZ5nGaJQrazHitO9RBRakIkNp+QjgEC3mKbozW40uweFVPJxBHm2vmipYf4h5+/k8wqt0EJcMQ==
X-Received: by 2002:a05:6a00:1826:b0:63b:854e:8459 with SMTP id y38-20020a056a00182600b0063b854e8459mr17087049pfa.31.1686684285923;
        Tue, 13 Jun 2023 12:24:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm8952203pff.0.2023.06.13.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:24:45 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:24:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] cfg80211: cfg80211: strlcpy withreturn
Message-ID: <202306131224.338EAD654@keescook>
References: <20230612232301.2572316-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612232301.2572316-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:01PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since WIPHY_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
