Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA365C54EE9
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Sep 2022 00:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiI1AGi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Sep 2022 20:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI1AGh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Sep 2022 20:06:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B0AA35A
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 17:06:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so10466908plo.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nNIu9MOBq5hXpqXGFXeNQOwTfuesFp67Vbi5mmPF+QI=;
        b=kUwqWtNdY2Mx+kov5RP9qUMeaw9c0wV/DbWRtl6+wKMW67Md/xEb8If18qATSTY2ID
         e+Ax3xY4AQZK6N+imYuOmXYh//oDf5MNsqX5aTYbRlJV93tHwARlNLEuufspzFwCCJH+
         2BPdFfciME/AAhJE1tzapdjZStaFl9NVHIDGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nNIu9MOBq5hXpqXGFXeNQOwTfuesFp67Vbi5mmPF+QI=;
        b=F4x67y6t/M8IbmWmuWs2N6aZhD90OONa5v75hcglqvKVBIx3GX3wLLJMBWUPzsiJaa
         ENnscFpH3PpNBN2r6Lo7l3RXDQAvHaZOc9l5gdiSVWSGrneMd6lnMR4LwSUB9zUeRF7s
         Bq2mRyYgq8SNvZTax90rP8mBkmweIKD6steXPUvomH8zmITf5E1PWp4N7tXaJXcVcDk7
         fbEvU//JhIhKp6Nffp+1wPJID4jNWx2EQN2FzCte5c+TVnQnLXJXYnsG+IRySY6TPgUh
         IO9z5s+i/C5OuqkuNCh1m6Q/4GhNzR0Mk2lLktCNnb8crEev3cr2oR58umfR7ZH5nTTk
         Wz0g==
X-Gm-Message-State: ACrzQf2Wr3vQE94UB7FvKLyhSrBO7CAoKNIpVy4l15tmLYPUP1kWO65T
        gSmEDIfvlbmhtxwWj1PxtppaH7xA6Oq6KQ==
X-Google-Smtp-Source: AMsMyM5lBc6cgMPxALJU5BgfuW4pY/gvxhlTJwS9euToRkedOuI3DRtl5bdU+XtVB97UJZQrTxd5Dw==
X-Received: by 2002:a17:902:b415:b0:178:2835:29e7 with SMTP id x21-20020a170902b41500b00178283529e7mr29921888plr.86.1664323595769;
        Tue, 27 Sep 2022 17:06:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f22-20020a63f116000000b0042a713dd68csm2226542pgi.53.2022.09.27.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:06:34 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:06:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@inria.fr, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [cocci] spatch --jobs N missing matches?
Message-ID: <202209271425.50502D365C@keescook>
References: <202209260912.8DCCD70@keescook>
 <alpine.DEB.2.22.394.2209262259030.2915@hadrien>
 <202209261505.9AE38B8@keescook>
 <alpine.DEB.2.22.394.2209272235060.2842@hadrien>
 <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Tue, Sep 27, 2022 at 11:09:35PM +0200, Julia Lawall wrote:
> The problem is fixed in github.  Coccinelle was doing some caching of
> header files, that was not desirable in the case where one actually wants
> to match the code, and not just get type information.

Thank you for the fix! I can confirm things appear to be working
correctly now. (And took 124 minutes to run.)

> [...]
> Actually, there are not that many memcpys in the considered code.  Then
> there are not that many that refer to the last element of a structure.  If
> level2 produces nothing, then level 1 should not be applied.
> 
> In the original rule order, all of the pairs of a flexible structure and
> any structure are considered, regardless of whether any memcpys are
> present.

Ah! Yes, I keep forgetting to start with the narrowest part first. :P

I also forget that I can do a "depends" on something that has no other
matches, but if it's built on prior rules that I use in later rules,
then it limits that rule directly. I haven't quite managed to think
sideways hard enough. :)

-- 
Kees Cook
