Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD3C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 19:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKDTlG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKDTlF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 15:41:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D27108A
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 12:41:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d20so4744551plr.10
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTleQU4VJfAukQnxKaDYAnGqK2WphhJc8fFwPIDZB8o=;
        b=msmwpF6Ois8LGAEpwDgc+v1z3O9zPF/gToUCKqHVslP3hhHCt/dUr3MBgaajqYY8+r
         v8IHIH33Nb8tZyr5wzF1Z1u4/02bw3vX6jbPl/qjsYR+o3kurpTnt8kUpMPNspaplUPj
         EIS1wt0Z83toaM+v3HO8zDdOzYakLB7A3sIXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTleQU4VJfAukQnxKaDYAnGqK2WphhJc8fFwPIDZB8o=;
        b=frWMkNiaNjB6dnbervbgKzZ3Y1pc9PXdaJ9O99Qg0OaSU2t3IeDEef7sjdLxhjrzLx
         Bvt30Xr0ACsd766wllAC0ag+zOd0Xuh4kKY5DuU+/lKutPMS3FfdHnRHC/Rdnj0NK8fa
         +Es5WfQJEGcsrk3Vj33rBACV5jkxVRDJCWPrazxtzLCHvLEWZSw9GAN6WjKgGpa3tS92
         JcfBuV/nsZ9pA700B1KISLeIeJjgVQ7BvD+88O8IMvsrghzeq6Oqv4bhc3/WsDJFSaVi
         ID331KNCcvNlOmtSkqQJuBcuctN9d63FLZvXZ97Qhpp8KCeavHPELPOvG2pgZVOUBaUy
         Egkw==
X-Gm-Message-State: ACrzQf2Azo3ehPVe10MmxUEqYxkgdiwUQP7eBBKxaawOtrNWvbvyD1Yu
        qYhPa3pqDsIlJsgZ4Jk2gUO9v8HOGBu6Hg==
X-Google-Smtp-Source: AMsMyM5lPZwJMkVoNQNtETbRNTdHQI/XbapUB0H45rWGJXujIBislKOpf8ovzPpaS4yP5yAJByf1Sw==
X-Received: by 2002:a17:902:aa44:b0:186:7a6b:7bbd with SMTP id c4-20020a170902aa4400b001867a6b7bbdmr37459295plr.78.1667590862227;
        Fri, 04 Nov 2022 12:41:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b00187197c499asm128906plb.164.2022.11.04.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:41:01 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:41:01 -0700
To:     Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        amd-gfx@lists.freedesktop.org, Oded Gabbay <oded.gabbay@gmail.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>, Ben Goz <ben.goz@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kent Russell <kent.russell@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Amber Lin <Amber.Lin@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: kfd_parse_subtype_cache(): Memory - corruptions
Message-ID: <202211041239.2B98F280@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Fri Dec 8 23:08:59 2017 -0500
    3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")

Coverity reported the following:

*** CID 1527133:  Memory - corruptions  (OVERRUN)
drivers/gpu/drm/amd/amdkfd/kfd_crat.c:1113 in kfd_parse_subtype_cache()
1107     			props->cache_size = cache->cache_size;
1108     			props->cacheline_size = cache->cache_line_size;
1109     			props->cachelines_per_tag = cache->lines_per_tag;
1110     			props->cache_assoc = cache->associativity;
1111     			props->cache_latency = cache->cache_latency;
1112
vvv     CID 1527133:  Memory - corruptions  (OVERRUN)
vvv     Overrunning array "cache->sibling_map" of 32 bytes by passing it to a function which accesses it at byte offset 63 using argument "64UL". [Note: The source code implementation of the function has been overridden by a builtin model.]
1113     			memcpy(props->sibling_map, cache->sibling_map,
1114     					sizeof(props->sibling_map));
1115
1116     			/* set the sibling_map_size as 32 for CRAT from ACPI */
1117     			props->sibling_map_size = CRAT_SIBLINGMAP_SIZE;
1118

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527133 ("Memory - corruptions")
Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")

I'm not sure why this suddenly appeared after 5 years, but the read
over-run looks legit:

struct crat_subtype_cache {
        ...
        uint8_t         sibling_map[CRAT_SIBLINGMAP_SIZE];

#define CRAT_SIBLINGMAP_SIZE    32


struct kfd_cache_properties {
        ...
        uint8_t                 sibling_map[CACHE_SIBLINGMAP_SIZE];

#define CACHE_SIBLINGMAP_SIZE 64

Thanks for your attention!

-- 
Coverity-bot
