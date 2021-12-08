Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7D9C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 05:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhLHF2A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhLHF14 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Dec 2021 00:27:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E1CC061756
        for <linux-hardening@vger.kernel.org>; Tue,  7 Dec 2021 21:24:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq11so1122072pjb.3
        for <linux-hardening@vger.kernel.org>; Tue, 07 Dec 2021 21:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LWpn27xpBvngeaGA+vOksGc0Why3OU0y9bZknS30xY=;
        b=M3HJ4FCR8wWK0d84r93J2nDa4lCm1c5zm1NoLHg5U9JpTIqEWmrj5XLpDFuFhBW1cy
         7PZwxRg+A4t5xGsPeAVZ3rA3sTbQTJuk6KGYiaFrgIpK7U0cCM2waeIjsjvVPMq9plwA
         FQCFWQkSiqiQXMZtTCCFh5ESNIlrSp1NZ25ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LWpn27xpBvngeaGA+vOksGc0Why3OU0y9bZknS30xY=;
        b=z+PM78ALaggefxT/542FZu8PBHjcR7Ia9Wm9hkV8XCuXtn4bP5oqYAvKDzv4F2alD2
         xruPgl1XgPOiZAip7mX7UJSnJ7PB30JfCYE394Qeu0XBpyeQxAPquuuph7GgHMoLExNh
         HlukJZx7rp0vbeFtnu+kCXreashOtlBRoURadBw4vtr+7RzdYvRqkUvT4dl09o5/7ZNb
         CHKkXPLjx6BmQ2PMw5Ef14tMPxNTO1+Hy3HhUJYLCr5IuhvslOFcmN9mKo34Lu9aBJDX
         eGFKjHKqNCYIRZBfDE39LMm/FXsZAiwEHWiIGkRuwfRZ+g3WY4EGhWSl2FLjdEQvCpx/
         Pv0w==
X-Gm-Message-State: AOAM530ECfyoogYnrVljGBGNU5pzteE1kqUcZJR0CKb0iHUXKNP1ElV0
        oZ6IDCQtwZmAtJLQaYkcs/Uf9g==
X-Google-Smtp-Source: ABdhPJyxArWbqyNOBKeJzP4ix4N263bd5ndDZkW6Qg7gzPdWajoqDpQ0Jb17t5yCQuGAHGQfNHPupg==
X-Received: by 2002:a17:90a:657:: with SMTP id q23mr4510814pje.21.1638941064876;
        Tue, 07 Dec 2021 21:24:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1sm1634961pfu.47.2021.12.07.21.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:24:24 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:24:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: marvell/octeontx - Use kcalloc() instead
 of kzalloc()
Message-ID: <202112072124.B4642C7@keescook>
References: <20211208041721.GA171099@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208041721.GA171099@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 07, 2021 at 10:17:21PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
