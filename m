Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4716C433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 04:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhLHE6u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 7 Dec 2021 23:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbhLHE6t (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 7 Dec 2021 23:58:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C9C061756
        for <linux-hardening@vger.kernel.org>; Tue,  7 Dec 2021 20:55:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq11so1080081pjb.3
        for <linux-hardening@vger.kernel.org>; Tue, 07 Dec 2021 20:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNfiJvO3fejBotE5iySezNhtEJJwER74TgDA97YhjHw=;
        b=dFvbWj1YTb2rkTnoh4vumG6c98xkqmedsvStrzVGBcOXL5hS1P5l1JINBDvAe4CWYs
         C56jIevPqd1PVb3iikh9OpUZjBNpFhNIf2ZOp6sBPFhhVkk/Y9HyfWCJKJ7Zxsg+jYgr
         j26v5mM52Dd72VrH2kqFsdsH+aEdxKoaZ3JAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNfiJvO3fejBotE5iySezNhtEJJwER74TgDA97YhjHw=;
        b=UnUT5HcEoDZZgCTKsaC0CdmQOU41L+50fM9r7C3nWmahmZ6/FHUw3JWmRpqlqtS+cj
         x3bJc1h49oh8OYDIvXzCvzv4j527af9rwxjkH4UdUb1AsUgehPUycenMgfVJ/x7/aH04
         fLh+fCjMmrpQ63pSbO17EUKug0UuBH5T5BhBuCNgSTYTTNtM6qgiwrATbpuf2vqJJ/GI
         erUb4tGO7ftoaahtUy/+L1eOwsXrOMJsCv4AaJXK/XUaAoBNPhKjzUB+xQ+zXhtyDOZV
         fTeeyas9ptLrrbK+pgbfxGXwJ3KIwTnLiuRAMqRSQern6YlEsS4b+245kE8g1RnVD1i5
         FhCw==
X-Gm-Message-State: AOAM530wnNEuXYZa87fR74iuaORowcfoRRdOxp9wbReUIBZjrg6s2ei/
        PIhyZutlw3OM+G2oFdARMEDtXA==
X-Google-Smtp-Source: ABdhPJzS2d4ffr4Pk1pU3l5zZk+LeQbBGpywoHPpAOS/5wf7KsRFrJSCYOl6vgYqGytySqvqn2Y0Gw==
X-Received: by 2002:a17:902:860b:b0:143:87bf:648f with SMTP id f11-20020a170902860b00b0014387bf648fmr56650710plo.11.1638939317886;
        Tue, 07 Dec 2021 20:55:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm992605pgu.93.2021.12.07.20.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:55:17 -0800 (PST)
Date:   Tue, 7 Dec 2021 20:55:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: at_xdmac: Use struct_size() in
 devm_kzalloc()
Message-ID: <202112072055.3708E99@keescook>
References: <20211208001013.GA62330@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208001013.GA62330@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 07, 2021 at 06:10:13PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
