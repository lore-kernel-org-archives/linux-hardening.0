Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A5C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 22:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiKQWTj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiKQWTD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D945898CF
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:18:19 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v28so3100554pfi.12
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYzob4348nYU+2Eh2QmU2auy9qKtGqawS3+SiTC3pr8=;
        b=mT6f5gl1eMimurIMmfHra1ZzdxxC44UxnmLk9ya83XFZxxCWVmAJlNJsuQm9+hWqo9
         clAArb97Lztgdt9fUawtaUPdSOcO3YtzWHrw3P6moc6Dh0+MA3W56f7CCeSMPYplF2h3
         a7COln0GoeKLRrAgBqCQmkPuOYTL1GDqAZjjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYzob4348nYU+2Eh2QmU2auy9qKtGqawS3+SiTC3pr8=;
        b=d5FokWxgRxZZbj/CdE8xC5AtJK1ZHLRkye2TPRjC00bGAJvoJfC3UbxqmRR39XnH5y
         FHh3c80+m0xYhSQjlj/40tbacxqTPyaVB9ueE8N4Zc7rclylaMf1ngo/NlXAA4evTLlB
         e0jKUfd2nRHAWlRoU12vePEUuLqvcwKw5wLrSpB2bZHV0K2w0Ek41Z1XHJPIGtI3HeJg
         xT+XdF6yTwMBW0q9eo9lHFtkWLqgLLaenS8jVBXlamy3TtpRqIJeIG4QCvn3sTEBlmpt
         v4yYcGnlbxaLfbcB6gfYkBNVgqY2OQaf+xmNOAkRDPLbyjvUwMlCTXRdyMN0QiZyBxk3
         C7JQ==
X-Gm-Message-State: ANoB5pl5mQRw/bpMedTHItKEKhGFvblFO30CIoEv39RAWK5wjucI7OU5
        pNOm//oVjdeKf9UoNauIOHt2ig==
X-Google-Smtp-Source: AA0mqf4WXJ8bLo8CDx+tvlgGvCwBPESTcqzdM/ckT0mWIDLw4npKCloTa0mrn276bHYnkJex23nlEg==
X-Received: by 2002:a63:f047:0:b0:476:7742:de19 with SMTP id s7-20020a63f047000000b004767742de19mr3827473pgj.343.1668723498884;
        Thu, 17 Nov 2022 14:18:18 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b00188ef3ea2b6sm1901208plc.262.2022.11.17.14.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:18:18 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 17 Nov 2022 14:18:18 -0800
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: drm_mode_parse_cmdline_named_mode(): Security best
 practices violations
Message-ID: <202211171417.5A924A838@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221117 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Nov 15 10:09:44 2022 +0100
    a7ab155397dd ("drm/modes: Switch to named mode descriptors")

Coverity reported the following:

*** CID 1527354:  Security best practices violations  (STRING_OVERFLOW)
drivers/gpu/drm/drm_modes.c:1812 in drm_mode_parse_cmdline_named_mode()
1806     		int ret;
1807
1808     		ret = str_has_prefix(name, mode->name);
1809     		if (ret != name_end)
1810     			continue;
1811
vvv     CID 1527354:  Security best practices violations  (STRING_OVERFLOW)
vvv     You might overrun the 32-character fixed-size string "cmdline_mode->name" by copying "mode->name" without checking the length.
1812     		strcpy(cmdline_mode->name, mode->name);
1813     		cmdline_mode->pixel_clock = mode->pixel_clock_khz;
1814     		cmdline_mode->xres = mode->xres;
1815     		cmdline_mode->yres = mode->yres;
1816     		cmdline_mode->interlace = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
1817     		cmdline_mode->specified = true;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527354 ("Security best practices violations")
Fixes: a7ab155397dd ("drm/modes: Switch to named mode descriptors")

Since mode->name is unbounded, this may overrun cmdline_mode->name
without CONFIG_FORTIFY_SOURCE=y. Please use strscpy().

Thanks for your attention!

-- 
Coverity-bot
