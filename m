Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62523C4167B
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiKJQum (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiKJQuN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 11:50:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56933120A2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:50:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso2053110pjc.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVqd+PvgZXEgpR5oiDP8I3WYALDkF1kwCNnCVwq1mpo=;
        b=KOrM7nTAXpp3ofHwJJRvDPycbrxwy/BUtfmO83XndSZ41PtDxOacBE0DrQFpxytI1Q
         JJCh2k1V7GgfY+6JXBzLBO19fnq0I4c2Jxvx68eO/LtakOsggQNrDZKf2M8qFcI91F9P
         1JIEUsrASBrRow9EergEBIaIRb3VyJeJht5a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVqd+PvgZXEgpR5oiDP8I3WYALDkF1kwCNnCVwq1mpo=;
        b=m+E0CKK12xTIgklQbY0ibs2PcnvPmNtGLxwF6wy1Tw+AK9oX7m/JRSBY98x3ssvxB4
         3ylHR1OciAMTTTmwJqkCzsX/Z37tZqG0Qbue2aYvYac66RoFCr4tCMUFuSnrxbwMxVnz
         SNxBwhaqvQKoNTOCElx+WGAB1W1PQCSIxxIe++90vfKYxZbu04JatJ22Jk5QlK3E7UPH
         AYmlZBYw5PpiXAZJh4aL9ketFyXbEBPNvRbu6D1Q3eGGY/3LiMucnMgSIDuLIZUSbElg
         EdmlyGAyIB7Rac5kmwOoIYXYK0x7KnnFAm1CMvflnhp6/rIrv/zTvyUXKG4fN64pP/Ff
         BWwQ==
X-Gm-Message-State: ACrzQf29I28PXUiMULA+CfnIZh7Mc+y8xynEfiOIt5yfHA9XzEtN+5Um
        IMDg6YipGjjWpi9/KenD11xAGg==
X-Google-Smtp-Source: AMsMyM68qD69p1bOkhPUXlhFPk3ZndMHRyb1mJfNywAclXB2dk8dtu5d1uueCVKTxNOxV0ehqJ3EmA==
X-Received: by 2002:a17:90b:4d91:b0:213:f1b:dab5 with SMTP id oj17-20020a17090b4d9100b002130f1bdab5mr65253209pjb.95.1668099005884;
        Thu, 10 Nov 2022 08:50:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0017f92246e4dsm11375728pli.181.2022.11.10.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:50:05 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:50:04 -0800
To:     Lyude Paul <lyude@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: nouveau_dp_irq(): Null pointer dereferences
Message-ID: <202211100850.7A8DD75@keescook>
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

  Mon Aug 31 19:10:08 2020 -0400
    a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")

Coverity reported the following:

*** CID 1527266:  Null pointer dereferences  (REVERSE_INULL)
drivers/gpu/drm/nouveau/nouveau_dp.c:237 in nouveau_dp_irq()
231     	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
232     	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
233     	struct nv50_mstm *mstm;
234     	u64 hpd = 0;
235     	int ret;
236
vvv     CID 1527266:  Null pointer dereferences  (REVERSE_INULL)
vvv     Null-checking "outp" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
237     	if (!outp)
238     		return;
239
240     	mstm = outp->dp.mstm;
241     	NV_DEBUG(drm, "service %s\n", connector->name);
242

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527266 ("Null pointer dereferences")
Fixes: a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")

Thanks for your attention!

-- 
Coverity-bot
