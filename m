Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C443C433E9
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182FE64FE8
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEJzs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCEJz1 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:55:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF78601FE;
        Fri,  5 Mar 2021 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938127;
        bh=BwyCyNwSVVjU+tWHfkQT/ZaAvB0AsGJsbbtQOdjgqb8=;
        h=Date:From:To:Cc:Subject:From;
        b=ghhgQCNuKaiTYdECadP13F7vB1UwGz4FAqW00mMklvxnRJ0zjKL51chPy8Ss5bcCb
         w9R+9rwc8AAyluugGvioCG22ChFtP6R5hjq4BfdT77vwi3MX56BQRTfyXxBbE05W15
         dIE4fRaWMHxT1NAxC38NmCbElME98QIzeZm0rKqBYDh6xlctt0yHzwfsED0MNBFquB
         WUKMo5TgUfcZTGHQOAVU6EgL8tHDXLsve2jZajtH2wlJtlnx8W8oZUwbH40AuZHl6Z
         TDu/Y9M1Od72iaVWXzpx1DlIlI06UDBtKKcqW5fkoQ9zICEgyTLmZKqrST3Ujb0EQ1
         hA6o830locIQQ==
Date:   Fri, 5 Mar 2021 03:55:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] drm/i915/gem: Fix fall-through warnings for
 Clang
Message-ID: <20210305095524.GA141804@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a return statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index c2dba1cd9532..2a14a5c94a8a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -60,6 +60,7 @@ static void try_to_writeback(struct drm_i915_gem_object *obj,
 	switch (obj->mm.madv) {
 	case I915_MADV_DONTNEED:
 		i915_gem_object_truncate(obj);
+		return;
 	case __I915_MADV_PURGED:
 		return;
 	}
-- 
2.27.0

