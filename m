Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDBDC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiKJQtn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKJQtS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:49:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862031F633
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:48:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p21so1844863plr.7
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9kSxsO17Q+SGuhgv7bQJn3B89MxfwFUgXJQwdBXWxc=;
        b=np5+c7/D+/Pe+ETkZmBCcBkcIkF9rWztcNUNpZ8fjJM55FzJgNq4nkQ3nqPKjpN1y4
         +Vz42qN8iUh+CDPgfd4HJ+e7+YwQlV2RCywPsaAB8YsN7K22LSZWTzUSOkIgU8aIF4vU
         Sg6WhOoBQQUUrmLT0u0VujZkRgeFf/Mp4HGoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9kSxsO17Q+SGuhgv7bQJn3B89MxfwFUgXJQwdBXWxc=;
        b=4bI1ntsSem+lNJq1rkG8f9ZNG1NrKINFQWwgnwn4+FVPIO2CyYFfwmu2seLLeqpSdw
         35iusfn8PF29Wn2S3qld0cVdqrS1GFTNjJ05IuOm8oTYNSh1xnwxO0YZs4w4llBlEdnY
         U9XyfyGSKNuAAFReyjJU93ksOhqTHmTePX/iFU9M5XUqmaCWR7sdWJWPxJYjRp6oRKrN
         Xf8DiZDz763q1AWEmGbPWbqGItMQdoJI9Y+c44cLvut+bqiMlLzod7oOp8PjyAGFYWxv
         a0EO1vsjqa0gOe4zP7SMsDqvGcq3vIQ+aAkBT7xNvXdAal1C45MJWK01WDlKxS+YUs4X
         7hlg==
X-Gm-Message-State: ACrzQf1XIDYUE6Oum/3magGv1aFz5GELzd6ODZvA9i44YiZ37N/RSbzB
        zPSBZRymBT5LgUbohsvFOQhTlw==
X-Google-Smtp-Source: AMsMyM46trOzdUYGkS4TOBz+lvhrf5w6Z58imMinDBIdbLY+Ryt5gQlR73fs5ggqqfV6HJyw6Yc/cw==
X-Received: by 2002:a17:902:8d8d:b0:17d:b9c:cd64 with SMTP id v13-20020a1709028d8d00b0017d0b9ccd64mr1509659plo.40.1668098929893;
        Thu, 10 Nov 2022 08:48:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9-20020a63e809000000b00473c36ea150sm3597920pgh.92.2022.11.10.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:48:49 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:48:48 -0800
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: nv50_pior_atomic_enable(): Memory - corruptions
Message-ID: <202211100848.F4C2819BB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221110 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 9 08:22:02 2022 +1000
    813443721331 ("drm/nouveau/disp: move DP link config into acquire")

Coverity reported the following:

*** CID 1527268:  Memory - corruptions  (OVERRUN)
drivers/gpu/drm/nouveau/dispnv50/disp.c:1817 in nv50_pior_atomic_enable()
1811     	case DCB_OUTPUT_TMDS:
1812     		ctrl |= NVDEF(NV507D, PIOR_SET_CONTROL, PROTOCOL, EXT_TMDS_ENC);
1813     		nvif_outp_acquire_tmds(&nv_encoder->outp, false, false, 0, 0, 0, false);
1814     		break;
1815     	case DCB_OUTPUT_DP:
1816     		ctrl |= NVDEF(NV507D, PIOR_SET_CONTROL, PROTOCOL, EXT_TMDS_ENC);
vvv     CID 1527268:  Memory - corruptions  (OVERRUN)
vvv     Overrunning array "(*nv_encoder).dp.dpcd" of 15 bytes by passing it to a function which accesses it at byte offset 15.
1817     		nvif_outp_acquire_dp(&nv_encoder->outp, nv_encoder->dp.dpcd, 0, 0, false, false);
1818     		break;
1819     	default:
1820     		BUG();
1821     		break;
1822     	}

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527268 ("Memory - corruptions")
Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquire")

Thanks for your attention!

-- 
Coverity-bot
