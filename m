Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54EDC32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIZWAf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIZWAe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:00:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AF5AE86B
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:00:33 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so6325634pgc.5
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vA/6myQNQnJHYk+EUx6DGwR93ze/m7/gJ74a1YFBZ2E=;
        b=U8sJtotxHMan7w/+4cTY25Ek0IfBdX5nCMlrmk+usONkjHNzmc7aD7dc0o8CYs171r
         tQ/XiitLYP4hzQ8L64lYJumQEojtI9TgQluFVjbRZDcyZ4/NDftB8giHUEk0o/af7Yca
         4HFZaiM/0R/tiAmzw0SY5Bbr5mQZqxk6Esb7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vA/6myQNQnJHYk+EUx6DGwR93ze/m7/gJ74a1YFBZ2E=;
        b=YSdGuCk/pljpVSFv7evgQ91PaRodZKSuov97CmISNx57sbnhUKeMlDgH5qW8wfZqTN
         KYpDvKy/Ek5gK2JwMeA2LFWwLKvMQkNW9V9iKcUwS1I/gAZBxUwojm9NVRw+nCowvA+2
         9Yn0ejSqQF8LPDldGlgZewjHXZUqnFVR08yoQYsF5sEPfoAg83ZP8HhK57mS5LmNR4Gv
         VR273ZcvvWIcCjtqhbrPd+KNYxXuPi3HeNGBq31W1IVuqpGEQLoodpY+PsqpRaLrOl0G
         wGxfwqKxhH6X+mPieyoPHbX+jMoZZitaZOTFbyHVh0zMfExLmnZdko5+EXMeReq/K51J
         2sKw==
X-Gm-Message-State: ACrzQf0bGn9qzwNIMtL7MxXK72uZTCIaVIINEJ2vMJW8mKLrbIPrRfFS
        XvU2DMburUG6TWoJvqxisTsTYQ==
X-Google-Smtp-Source: AMsMyM5JiIgVIgSTi23Z1w9ajKUhq1aAliulpHYeL13NSOYqKW4HOG61sl4hc17hHP8PREpsKCyqHA==
X-Received: by 2002:a63:fc5b:0:b0:43c:3f90:ca07 with SMTP id r27-20020a63fc5b000000b0043c3f90ca07mr18295865pgk.110.1664229632744;
        Mon, 26 Sep 2022 15:00:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 7-20020a621507000000b0053e80515df8sm12685410pfv.202.2022.09.26.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:00:32 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:00:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath10k: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261500.38CBB07FB0@keescook>
References: <YzIcoloIQBDqGlgc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIcoloIQBDqGlgc@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:41:54PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/212
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
