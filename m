Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3FBC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiBPUeN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:34:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBPUeM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C62A39F0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:33:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso3464528pjl.4
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iwe6dEk//R9IuP/djM6G40dVnul034jHIp8QF8r0XR0=;
        b=BrGmYaDzFVlZCLvN5Oth2ItnzMAlHs1DOQ822SesSK2Oh5jI6qS4aqNad+42EY2kKb
         Ia8+hSaZ4mqQi9XOqxajxbt2sLo9H9by+N/WHQcxUA1yFiFYk9ATeu2f1uttgqFYOcpr
         x1RktQZKgCy5KR+NplaKdMWCDgeigYmlySNcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iwe6dEk//R9IuP/djM6G40dVnul034jHIp8QF8r0XR0=;
        b=OydGgfhedfsv1EddQfG9YdxkOnPxHca55j43zWBmIszOYFZJl1Tp1yjAbxyK80pteS
         gWBzgM7j61MCB35ReFovd3YtYF3pXgcASmJ851lKIA0fPGXfoc0XPWG/JuO0KPlTrw8E
         dpL0YK98mhymucLHdHwqSzAE09Qr9XB+OlrxHZK9yz1ny+WkU9ydLAc6oj0j64jVisu8
         vyQ4sYBE8rlcQTU4pV3PRK99/Z1Aun8OSm1jtdsaWN6SPEvlyZ9SSaAt5ZsF6OgZ6E3y
         ySrIJAcUBf7EJpWGcJpOyjptdWpvHTthDdnooKhF9zPl8OWACqDQMkXbp9X/bJl+xat2
         OR8Q==
X-Gm-Message-State: AOAM531VZ6/gVULW6R2Q0vvdfDHewxPJ7LDWH4h9yTcHItUE/gfEWvZH
        evqmNBUTq9pIDPBIK3Uv3XKFzw==
X-Google-Smtp-Source: ABdhPJwsH0zVt+LsoY8rw3hePDyetrBIK4AyokHSO8tVCiAs2LgBt0S1V97Mw3awlO8FX1zTwc/+nA==
X-Received: by 2002:a17:902:db05:b0:14d:743f:5162 with SMTP id m5-20020a170902db0500b0014d743f5162mr603116plx.12.1645043638779;
        Wed, 16 Feb 2022 12:33:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m21sm6259992pgh.69.2022.02.16.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:33:58 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:33:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath10k: Replace zero-length array with
 flexible-array member
Message-ID: <202202161233.805BB2B7A@keescook>
References: <20220216194807.GA904008@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194807.GA904008@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:48:07PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
