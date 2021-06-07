Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70597C47082
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Jun 2021 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F0A61153
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Jun 2021 20:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFGUdF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhFGUdE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Jun 2021 16:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AF6D61139;
        Mon,  7 Jun 2021 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623097872;
        bh=pPJBqBlQGXvfAld1PUvVv5IJNwFjE/rO5W6JlS1cXrU=;
        h=Date:From:To:Cc:Subject:From;
        b=kODygim17HTj9MZtf/1L5Umw+L256UX+5IukHOU8+Imp1NX53aO03JrJSGiruIBKN
         jHjTGGJ97JPUg9Zojj4T8J1O/yo4QKhjqDLJY0chP71mjYCm1LwJzGxgGp9okUq2pM
         TVVnIPzZig4viPX2cNfav+KGBs74T84oR4jNdF75Yg35V5/CRkgGfW6Eu8RdF4Bs9p
         1xrcA6TyrFX2YPj/Z7i8XWoZm4ed+I34rjgVeI/pB3Fabp/M6w2mBnMWm7yw0soHVf
         VIt0gRAPF9M+zNenNQaXXn4gr7TGaR5VBb5t1hH3/3GAAfK8+eIxS1Ry0hu2QZ4hR1
         oah4RLjVBy4Ng==
Date:   Mon, 7 Jun 2021 15:32:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] drm/i915/gem: Fix fall-through warning for Clang
Message-ID: <20210607203229.GA60476@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a
warning by explicitly adding a fallthrough; statement.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 13 in linux-next(20210607). This is one of those last
      remaining warnings. :)

 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index f4fb68e8955a..17714da24033 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -62,6 +62,7 @@ static void try_to_writeback(struct drm_i915_gem_object *obj,
 	switch (obj->mm.madv) {
 	case I915_MADV_DONTNEED:
 		i915_gem_object_truncate(obj);
+		fallthrough;
 	case __I915_MADV_PURGED:
 		return;
 	}
-- 
2.27.0

