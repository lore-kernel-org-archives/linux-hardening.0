Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269B3C43460
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E893661006
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhDPTyV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhDPTyE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 15:54:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1910C061574
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 12:53:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 20so10594180pll.7
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4QdNLxtMyGBXnzcuFRJGiRcHb2u3OpFrU/9Q6DJdtHM=;
        b=XzsdTPW17a3D0CPunlZ/4Z5f/H9FiCbcKc7JSo7yT/4tvhMDg88Uy9/DpphB0gFPyN
         WZwYxeCI7knl4QLYflLQLThv9/rAjYkTJHWNifKWZOeDMqeAW/KK2+XPusnBD3GpPWqv
         vfePIE7jYmbgRh3hZsK+hEL+IYHJZ2tS82dcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4QdNLxtMyGBXnzcuFRJGiRcHb2u3OpFrU/9Q6DJdtHM=;
        b=YKzHJziQGUpdaIEtYYyRwvEjApz7a7Cf7lgte5smmv+ysTjVLA+xnh9vkQoCCiQocN
         gLmb1ZPxWsUm9akwluIwyA9IHcFC27k8TRIecFsryRflWMq6q6bCS6BA7mysV++KErCc
         eNWgGVLt+E7Y3IKP24Q2UlaKO7SdL1bYqAJN/a1J+ykl2vNXk9E4cBSMZRBDRINYyqHK
         ixHHIfpX+hfJCYsoDIEQEr+bgvgb2tM8/kfAMIgriq3kWURRhx5yYd74SkCHCPXVGOWe
         I6uhgaS19rG7McicFHJtKGwHiJN8P+Ta8Hm2ISObHfcTOh9I+3CB4VbrQpnMtEgSRVWA
         egHw==
X-Gm-Message-State: AOAM533gwnPsAuO3bb2UJM6QsoCAanxONav3nUVSBzyG29xKg/uaIp8L
        lLZuEPodZPxcmCAEVx4qMPn5Qg==
X-Google-Smtp-Source: ABdhPJyOi0Hh1KaoxJrDOCHEREwQAXtTICn1Y0/lFNXgtHYCnfD5JLKmsk3YmfHUaTA/Thzsnhgwog==
X-Received: by 2002:a17:902:8604:b029:e6:60ad:6921 with SMTP id f4-20020a1709028604b02900e660ad6921mr11346580plo.15.1618602817589;
        Fri, 16 Apr 2021 12:53:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10sm3733203pga.5.2021.04.16.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:53:37 -0700 (PDT)
Date:   Fri, 16 Apr 2021 12:53:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] sctp: Fix out-of-bounds warning in
 sctp_process_asconf_param()
Message-ID: <202104161249.D889C975D9@keescook>
References: <20210416191236.GA589296@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416191236.GA589296@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 02:12:36PM -0500, Gustavo A. R. Silva wrote:
> Fix the following out-of-bounds warning:
> 
> net/sctp/sm_make_chunk.c:3150:4: warning: 'memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/109
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yup!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
