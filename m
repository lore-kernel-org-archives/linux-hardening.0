Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FEC43217
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiKJQtV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiKJQtB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:49:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435AFA195
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:48:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso5170751pjg.5
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDJ5GbeH4x/1yjxtjF2BP9FcVDh9qhDYbgp39xw30DM=;
        b=Fe2LrkP4LSaAmzpNbzUlL4Sz8W/ckj87PLB0s4ExV2y1hr/SBDx2aHXMGIHH4Q1HZp
         SlVXRYyU/kLp+VT2nJhpvSEpLp5Gw306usHXiFoSvkdLXpFh1XiL/tfTwivIahCI7ZWT
         lxhf3NYj8/XNq2LoDLiXIqTqCb4OIr0rR5gOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDJ5GbeH4x/1yjxtjF2BP9FcVDh9qhDYbgp39xw30DM=;
        b=fTsmv7E4uhxk1Go+Sf2AOrLwrhtnAP2Mcoz615kXqlQ7l/n5Oenr5eQ0yFz6eKby5K
         LpIKACLglgKd9EhQGs4bK4BzQ81B4S36Sq2X1OkEZF+sFd3P/E/cTQo1D+Xf38jGobB1
         Tmolbjg2kOMg5vcluQASwMGhZLDUkM5hV0/D0UPIgQBSOtadvGYN4oouy0JxfduTuuKs
         sZOgnyRL5c0gBlwDlHCLJPaWRwepAzAGWuSCto91rUBG/r586jCAopY6exZsXR633/M+
         Kuqzt6S47KBaigurBsKHlpjt8IdPo0TW+EUQ0e/3OURjNi2g+uPGUoUwEBLa525lveKq
         rm2A==
X-Gm-Message-State: ACrzQf2VUpY4sl6CUfRJiBilTUIb9m64k01/yyJxE6WFHD2ptvC5Puh3
        mc8IJ7WboH8BiOv7JOMdgkJttg==
X-Google-Smtp-Source: AMsMyM5L7JASpAto4IfQ834QGHOPC/E4fFSGlP1B6IiNOx5M0h4LxXrBlQ6jL1GcB0G62qrRYLVm/w==
X-Received: by 2002:a17:902:d503:b0:187:19c4:f9db with SMTP id b3-20020a170902d50300b0018719c4f9dbmr58312424plg.82.1668098898782;
        Thu, 10 Nov 2022 08:48:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id om15-20020a17090b3a8f00b00213c7cf21c0sm50871pjb.5.2022.11.10.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:48:18 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:48:17 -0800
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
Subject: Coverity: nv50_sor_atomic_enable(): Memory - corruptions
Message-ID: <202211100848.FFBA2432@keescook>
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

*** CID 1527269:  Memory - corruptions  (OVERRUN)
drivers/gpu/drm/nouveau/dispnv50/disp.c:1619 in nv50_sor_atomic_enable()
1613     				lvds_8bpc = true;
1614     		}
1615
1616     		nvif_outp_acquire_lvds(&nv_encoder->outp, lvds_dual, lvds_8bpc);
1617     		break;
1618     	case DCB_OUTPUT_DP:
vvv     CID 1527269:  Memory - corruptions  (OVERRUN)
vvv     Overrunning array "(*nv_encoder).dp.dpcd" of 15 bytes by passing it to a function which accesses it at byte offset 15.
1619     		nvif_outp_acquire_dp(&nv_encoder->outp, nv_encoder->dp.dpcd, 0, 0, hda, false);
1620     		depth = nv50_dp_bpc_to_depth(asyh->or.bpc);
1621
1622     		if (nv_encoder->outp.or.link & 1)
1623     			proto = NV887D_SOR_SET_CONTROL_PROTOCOL_DP_A;
1624     		else

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527269 ("Memory - corruptions")
Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquire")

Thanks for your attention!

-- 
Coverity-bot
