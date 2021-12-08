Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F7CC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 05:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhLHFJB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhLHFJA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Dec 2021 00:09:00 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2AC061574
        for <linux-hardening@vger.kernel.org>; Tue,  7 Dec 2021 21:05:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h24so1111817pjq.2
        for <linux-hardening@vger.kernel.org>; Tue, 07 Dec 2021 21:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+rZCR20RPDGoAf8CztEP+MjH3/Q78QqNLnDRFO/ZKK4=;
        b=nm0VC0YOkSo4x8TCDSUgMFzzKJ2PNlINViWVZ953gIxiFkJI/38qV3fs2GL3GvUl6r
         07TVvuHsG/PS9EtTPUfx3lL8eivNM6YZdG1YTWCmr0xouhVqLjPssISeGlHfq41GxNNB
         sj5RCGLqqaWakdgek2IMut7ZXnJy+5SBrFRMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+rZCR20RPDGoAf8CztEP+MjH3/Q78QqNLnDRFO/ZKK4=;
        b=aZ6uUrHLFY1a13TpWtUKNALSXSm+J/9GrNZco0j13a8znnRJ/1+F99U/7GTZNjJuq5
         PZDeRd0YxCB/moxvj5Yc301g/wb8IEsWpr/4mr9BQ86tTjqFKl8LJNgmEIalnk9Rh9C8
         zFZoWCKfFzhJXwMSKxcJJgpiSVDXKySOtdKpm01KuqOaDBWELY++/ehkifivLvMNl/8P
         AmBtvZmmm6VoOlPSfJeTL6qph2LcjSNJMnBUX49YKkhC+oNL2JyG1SZ5HdwEPP9Oty5G
         fS1yWMuA3RPreCQYqQKwbKnqA0HDJkWfEIQQFHpbgrs/OslBkr6fnfa9ESuo6CbyIp+D
         L3tA==
X-Gm-Message-State: AOAM530PXnwrCtDPpkue22IawVQtTVAW+UCwmca3P6DS+oI54f9/WeZ/
        ugZGP0fVHGjCLCweebfKiYPbYQ==
X-Google-Smtp-Source: ABdhPJxig7g3enolr5gubLSCeyG6bgCaRSItQUy8n1rTsmpgNRh1QTcEN7S5aT+2hUUJPSbAQtPIvQ==
X-Received: by 2002:a17:90a:b015:: with SMTP id x21mr4665247pjq.84.1638939928718;
        Tue, 07 Dec 2021 21:05:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm1446050pfu.205.2021.12.07.21.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:05:28 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:05:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     George Cherian <gcherian@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: cavium - Use kcalloc() instead of kzalloc()
Message-ID: <202112072105.8935E88@keescook>
References: <20211208012459.GA145349@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208012459.GA145349@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 07, 2021 at 07:24:59PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
