Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4CC32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiIZWBZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIZWBY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8E0B6D3E
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:01:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id iw17so7501433plb.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wU3T4FjaU9qDfVJPctHKYbqwT9poMiNECQZXFxXpthw=;
        b=NpMtrDRZOXiB0xUb1TtKFQTAvPuh4asn7d0bK8R3rbFTShInim3HcHlWpa98Lk7J8e
         9878xE/E6Ib4yZnFyXBhnCE+7wCuMQ6kfgTjahcmfbxLCDNnpRMweeXz7uoCcywzIXR8
         ru37hfNCKOUgEFCCc8u29FBz/d0RxXPlz4xnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wU3T4FjaU9qDfVJPctHKYbqwT9poMiNECQZXFxXpthw=;
        b=wSjGhW1uWtbGjhk2ad04ZAqpdVT4dNjvSvphO3QHLC432thgSolepTBPm85A+iCzXc
         3Z/eBia+A60O0rxZRD4Z/oQgfc3VS6sRnkWKG6GzaQR76uSvW2tu+aBVtcqt7gzuH4dw
         KCiTyiGS3X5qL2hP6TBG5oW4yfYDeL+Hu/Q3QEvTQqlf2+E2+TU47PxFSGQFkEUvm9LD
         imBK5MqpkV+qDZLccA3HOj9e68lLcpxNcmDAg/1UxwTBeIRuyQtPGgDo3+fYPrmmTK8D
         p3D2loS5iKu+N5clFAAOELXePJNqt8FoPmiK4uhDMeraTA+QUVD3J7Hly9LrlGMY0N0S
         Kraw==
X-Gm-Message-State: ACrzQf2qLKVcNa3KWwTDMBob9aVlqLaXXhhAEiKycd6Aq7PIM8TiABsQ
        cyMe30d3QLPhdDXOEtOuriHKSA==
X-Google-Smtp-Source: AMsMyM7lWbAH8ThnXEDFlwVQ/98rO2TnRsqVKkIvvgMC1lr8gdwsVgpsJhLsEH1PLYkt0s8t1dKdKw==
X-Received: by 2002:a17:90b:4f4b:b0:200:876b:c1c8 with SMTP id pj11-20020a17090b4f4b00b00200876bc1c8mr966306pjb.32.1664229681755;
        Mon, 26 Sep 2022 15:01:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090a74c400b00200461cfa99sm7004676pjl.11.2022.09.26.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:21 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] can: ucan: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.12780DB3@keescook>
References: <YzIdHDdz30BH4SAv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdHDdz30BH4SAv@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:43:56PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/214
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
