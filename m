Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ECDC43219
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKJQul (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiKJQuM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:50:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687EBC9D
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:49:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b11so2007918pjp.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyrWfcByjJXJ5u7emZGohwKYRcoGGODByISYDFHgldU=;
        b=SkZKW3Yo1le1fuMFEG+mH3AW0pGZzhfl1jquZr26xXoWgcpGUgwx/9i59trYLnbyNp
         0fECbdTZThXTLRMivyi83uOwpVX+PQtcAkIY/lpHnBGqzgJ8HE/JGcY/yGpDr/tts6s8
         fEUAZIy98nqHcvqsGCP73UaA5HAyPfN1MhCsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyrWfcByjJXJ5u7emZGohwKYRcoGGODByISYDFHgldU=;
        b=t+V5H9AuysrpJBsYKEyQwwTUNdptonZ1KE07wW7FH2VO17sZM+TtKpgGaK74shIgj/
         azG3hF+tSDnhvCa7p/o7uxEL/Aa9+r0H1AXkfcTpRMzXT2GD/SDxLaFMCPUyV8b3aCtT
         1mvv/VrCDlVXfHXlvuMY/FtzmHcx4HuqtMQPKJVe0d3aFaFR82vewo+pyhZxF8g/KS7N
         bOR99Jt8fqUiATc3jXocH3QRGOdizICk3fxRJq24VITj+rcpbV8zPlb8gt5ds+swwi6P
         TK+NwB+RlY6nKMlMG3NMjnawtI+N3PzeVGxWGrfKzmwm4b+XcM23eTiiXDDbkUhTz0P6
         VVCQ==
X-Gm-Message-State: ACrzQf3r3wQKsBwGYTMQWM9boMaukqPx6ItyrxcUK+knc0GZZjWjI/Wf
        pCXwPoQfzEsW6v6dkYhUEL3FXw==
X-Google-Smtp-Source: AMsMyM4giYvP77sTPDWGk4iRexWkKdhko7Z9x8ZbVQ0+6fKkZQD8biAGSZtsNEYAUXSGiobU0OhdmQ==
X-Received: by 2002:a17:902:e803:b0:187:3a52:d262 with SMTP id u3-20020a170902e80300b001873a52d262mr47366180plg.85.1668098988693;
        Thu, 10 Nov 2022 08:49:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b0016be834d54asm11586089plh.306.2022.11.10.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:49:48 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:49:47 -0800
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: nvkm_dp_train(): Integer handling issues
Message-ID: <202211100849.DDBADD2A6@keescook>
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

  Wed Nov 9 10:43:10 2022 +1000
    8bb30c882334 ("drm/nouveau/disp: add method to trigger DP link retrain")

Coverity reported the following:

*** CID 1527267:  Integer handling issues  (NEGATIVE_RETURNS)
drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c:458 in nvkm_dp_train()
452     	u8  pwr;
453
454     	/* Retraining link?  Skip source configuration, it can mess up the active modeset. */
455     	if (atomic_read(&outp->dp.lt.done)) {
456     		for (rate = 0; rate < outp->dp.rates; rate++) {
457     			if (outp->dp.rate[rate].rate == ior->dp.bw * 27000)
vvv     CID 1527267:  Integer handling issues  (NEGATIVE_RETURNS)
vvv     "ret" is passed to a parameter that cannot be negative.
458     				return nvkm_dp_train_link(outp, ret);
459     		}
460     		WARN_ON(1);
461     		return -EINVAL;
462     	}
463

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527267 ("Integer handling issues")
Fixes: 8bb30c882334 ("drm/nouveau/disp: add method to trigger DP link retrain")

Thanks for your attention!

-- 
Coverity-bot
