Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B8C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiKJQn5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiKJQnQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:16 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDF245EEF
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:42:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y4so1849416plb.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfgsLc2+G9HPdaL8aH3Xzd8lv8JeS+eH5Ba4xV4l/yA=;
        b=IruV/cOGCppTZMecE2WVY8zukl+kcYVeoo7vFWW6yGTBj+JNzqw7SwdygU11Ap5tXp
         +IWICnrL7OpPlowtcizxkZ8u7fNIf7VOdlhb+UCVVdiNOgc1eLngTeYpENadc4W7k2ql
         lwVFIi2Zm+49ixbK5qXD6pVFvTfaAaG7iPD9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfgsLc2+G9HPdaL8aH3Xzd8lv8JeS+eH5Ba4xV4l/yA=;
        b=A1eC+WhQDZTv2ZxqYdQr2Ar9/kQikyeb3obc0koFtOyZtZWslLaTUQ7lsVSdzyiK3o
         tsqIq8uiXdXWzq91OSVssFpFWoEBJkQIGDJX1n4b5/2SQYt7z4C3obv0+/+tSzMksjeA
         w5o3OK2Wx0GYY9n9InV7fkO/I+vi3ufZkW08QHz2SmeFx1g8ct4a6yQUbiQSwK363Js8
         4F1RILLvKYEvvL4fd6cqW501kirT9+NJ+IJ0i/vaDN9D3pJ7r1OPBXhSbRv+56guVzZB
         79Rxhg1mug306N3EaVdCIS0Zn+gezJZb+PpDURhaAUzsB+otaEY5Irav8ivz2LP0aIKx
         J4JA==
X-Gm-Message-State: ACrzQf0KOvo05JLhF9G92rWRwj2fPEWkK+/sJoVreb5XK6hbfqXFEJ3a
        OTtsaVokzcC03jmCUhSWzXUOsA==
X-Google-Smtp-Source: AMsMyM4zFp+Wrf9N4R4CuG0pbWGCwDSSClCq2oRdgHwJJKI1w+NXOW7FDTxl0KXE16WpLHC9sb8z8g==
X-Received: by 2002:a17:902:82c2:b0:188:5581:c8de with SMTP id u2-20020a17090282c200b001885581c8demr1293917plz.140.1668098578376;
        Thu, 10 Nov 2022 08:42:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b00186f0f59d1esm11373906plb.192.2022.11.10.08.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:42:58 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:42:57 -0800
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
Subject: Coverity: nv50_hdmi_enable(): OVERRUN
Message-ID: <202211100842.076585A@keescook>
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
    f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + infoframe methods")

Coverity reported the following:

*** CID 1527272:    (OVERRUN)
drivers/gpu/drm/nouveau/dispnv50/disp.c:801 in nv50_hdmi_enable()
795
796     		size = hdmi_infoframe_pack(&infoframe, args.data, 17);
797     	} else {
798     		size = 0;
799     	}
800
vvv     CID 1527272:    (OVERRUN)
vvv     Overrunning struct type nvif_outp_infoframe_v0 of 8 bytes by passing it to a function which accesses it at byte offset 21 using argument "size" (which evaluates to 14).
801     	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, &args.infoframe, size);
802
803     	/* Vendor InfoFrame. */
804     	if (!drm_hdmi_vendor_infoframe_from_display_mode(&infoframe.vendor.hdmi,
805     							 &nv_connector->base, mode))
806     		size = hdmi_infoframe_pack(&infoframe, args.data, 17);
drivers/gpu/drm/nouveau/dispnv50/disp.c:810 in nv50_hdmi_enable()
804     	if (!drm_hdmi_vendor_infoframe_from_display_mode(&infoframe.vendor.hdmi,
805     							 &nv_connector->base, mode))
806     		size = hdmi_infoframe_pack(&infoframe, args.data, 17);
807     	else
808     		size = 0;
809
vvv     CID 1527272:    (OVERRUN)
vvv     Overrunning struct type nvif_outp_infoframe_v0 of 8 bytes by passing it to a function which accesses it at byte offset 21 using argument "size" (which evaluates to 14).
810     	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, &args.infoframe, size);
811
812     	nv50_audio_enable(encoder, nv_crtc, nv_connector, state, mode);
813     }
814
815     /******************************************************************************

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527272 ("OVERRUN")
Fixes: f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + infoframe methods")

It looks like this should address &args not &args.infoframe, if the
intention is to include the "data" member.

Thanks for your attention!

-- 
Coverity-bot
