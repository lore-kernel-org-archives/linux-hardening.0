Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A099C4743C
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2709F613F1
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 18:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFDSYT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSYS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 14:24:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB13C061767
        for <linux-hardening@vger.kernel.org>; Fri,  4 Jun 2021 11:22:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e22so8514063pgv.10
        for <linux-hardening@vger.kernel.org>; Fri, 04 Jun 2021 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UX1G2MyuSMoI9qtV/IxvY2Ox2XX3g0K693XM4XnGuQs=;
        b=brEmXwIeWk511PUJq83cxnT/omO9wa73pzK4DBRRfyw6IWWvIhLLWGnHkQu0cTXiId
         osUMl3zdzBrUmpwlIil/zSWrkJ02MAiC0TmLGGOkxs0YiRQNoKaQ23SXe129ISop5J0w
         psq9IuXjXRSwfDxo+lWbs78DFv2LT0K2q7H8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UX1G2MyuSMoI9qtV/IxvY2Ox2XX3g0K693XM4XnGuQs=;
        b=CpQ9DmDBJT8Dof8mz7/917WGyyoFOoZnK6uoDt1X/wLYO4cLuJozNe0A0qGk0LrAx0
         iDW2JY/2QgjJAqKYSjeB72eugHvBT2JxcZS1irwiyFaUaPtxGPyO7EJ+xsBZgwyA+Ule
         mjlA+tz6va9maNKlqfxiFTaQtAloBqIE8+RB9lXOacjLwp3K83EbKNcscx9K4tXs4Hzl
         uoSBNWn2NQhsUW5/Uj3P/epxK40F2ui1unbCE+wz7tvkntfcPzdxRPGdaDck8A8PE/q6
         1+YD6bM/2kWdYkvt70vCq8TEN98ott8cZ3tZ7A+ze+zrEYzqSJrHYy+ZymUJ3cIOip/p
         bKuA==
X-Gm-Message-State: AOAM5323ADQGSqgOxBax46OYCCGHraXJThvM5l5KhiL0qvXJV3FFdQwC
        9D5QGjJq2/BNWN0VT4Ogj+4WuA==
X-Google-Smtp-Source: ABdhPJx/yQn8DS3AzA7xRJxe/WtzLqKi+h8G2XgHEWQGo8dMvTira3vRnBtv6+zBFbCRjJOcdsXa1w==
X-Received: by 2002:a62:148e:0:b029:2e4:e5a5:7e33 with SMTP id 136-20020a62148e0000b02902e4e5a57e33mr5846985pfu.9.1622830937626;
        Fri, 04 Jun 2021 11:22:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm2352888pfh.97.2021.06.04.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:22:17 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:22:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: mpi3mr: Fix fall-through warning for Clang
Message-ID: <202106041121.41CF254@keescook>
References: <20210604023530.GA180997@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604023530.GA180997@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 03, 2021 at 09:35:30PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a break statement instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
