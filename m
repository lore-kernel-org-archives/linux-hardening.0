Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA35C38A02
	for <linux-hardening@archiver.kernel.org>; Sat, 29 Oct 2022 07:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ2HUS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ2HUR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 29 Oct 2022 03:20:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB0303F0
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:20:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r18so6624873pgr.12
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss9mHb7Up4WJPG174BroMQ/rFUMxSmAvI9HWcoDXYeI=;
        b=lfDRgG4gcFVjPXy6WNAXfQOcZUwQLCRZzSVWisL6fGMaIBSiyE00C6zMO1EvlHZgv2
         0tHmkWcODvxiSRdK9Ax1/zGgaWNYudHsoleWrPIRDTNCFZ+Jb/nmrjqTpg/xO2e8YFz5
         8837MWqCeZonLNzlfWlRAuQAViIMtdkMad8wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss9mHb7Up4WJPG174BroMQ/rFUMxSmAvI9HWcoDXYeI=;
        b=fM1R5z/AGkjQdTKoxtk99xElYYNjUhqB7pEnGyH+Fzuj2pSBThyKGBkuszMj05ReQs
         Poq/dED0UnsTBCj+oTT9grEZlgZLYxE/EgsIboTdNs19FAYU4OQeE0QVwSzii5RmNPoJ
         19VRdc+gY7/qOJUFr2cMiiIxiME1+oPX4FnH2UBua4Kl2u/dvuK+AE0TLy0trIUSMz85
         P7eSg63pap72t13w/GJEadLqNeaKKKK2f6Y9KRfrA9E/wo9lIJPXRVxtVmtirA0Jov2Y
         W1SI20oVcrh+v0sUQi0T+OaFevhkcVLYp1sgLHHCtJnMPyWxsqfP0SVk1MKBhygcovxU
         Ue9Q==
X-Gm-Message-State: ACrzQf0yuOH+jGVzs7072Vty9+PLrHVt0R3OcbVaVqOfBv0jI14agV2C
        qdfxSV5HfRoTejclDpaQ1orv1A==
X-Google-Smtp-Source: AMsMyM4mHeFnX3w8YCr2wsNw66bw81ioiWfWld+qaCT8h6ltyUO0X1H0B9yBBV45mm3eQJY7kd2lZw==
X-Received: by 2002:a63:7909:0:b0:458:1ba6:ec80 with SMTP id u9-20020a637909000000b004581ba6ec80mr3057284pgc.414.1667028014840;
        Sat, 29 Oct 2022 00:20:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18-20020a62a212000000b0056bd737fdf3sm585170pff.123.2022.10.29.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:20:13 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:20:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: ks7010: Avoid clashing function
 prototypes
Message-ID: <202210290019.CD8CB27A63@keescook>
References: <cover.1666894751.git.gustavoars@kernel.org>
 <34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5.1666894751.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5.1666894751.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 27, 2022 at 03:22:46PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 27 warnings like these:
> 
> drivers/staging/ks7010/ks_wlan_net.c:2415:2: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_point *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         (iw_handler)ks_wlan_get_firmware_version,/* 3 KS_WLAN_GET_FIRM_VERSION */
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The ks_wlan_net Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. There are no resulting binary differences
> before/after changes.
> 
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - None. This patch is new in the series.
> 
>  drivers/staging/ks7010/ks_wlan_net.c | 184 ++++++++++++++-------------

I think the casts in ks_wlan_private_handler can be removed, too?

-- 
Kees Cook
