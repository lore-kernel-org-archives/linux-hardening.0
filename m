Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20442C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCF964E0D
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 23:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhBJXuS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233744AbhBJXuK (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Feb 2021 18:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 660B764E0B;
        Wed, 10 Feb 2021 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613000970;
        bh=DFd7DSXy7nWVxMi3ogNh04lyt3UKSNz0wPfFB3/Ikgk=;
        h=Date:From:To:Cc:Subject:From;
        b=RwE0EQrcXAXhRu1tEHQ5OhsgYK9JITPA5slwojL1+mXW77Z8/D7tRuDy1HrBeaNDi
         VSoq6CR/wVeUFMyFlVpogSpN78LwdeH5XGoLpMSHKSsAS39OBexHYcGz7nUI3cSElf
         pEhdAKrevf4lPyeCXeXC2xLVhsNo2ROTK8vxd6WVAJwem1bv+G36GDRLwJXdn7jQCA
         6HG7oiRQ/xiXWpnelxJgLOzGhYUy0qDiZUPImb86cg+e57sZh1Z4tfOz3bTKymv2N8
         Fq6+9zJNjKrznJWXV08nvgsPXEnSBZPFkS58LWHyMzO9Br/s54B6maQz3ZGArCPUPb
         vCxAkBdkPgidQ==
Date:   Wed, 10 Feb 2021 17:49:27 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/radeon/nislands_smc.h: Replace one-element array
 with flexible-array member in struct NISLANDS_SMC_SWSTATE
Message-ID: <20210210234927.GA68137@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use flexible-array member in struct NISLANDS_SMC_SWSTATE, instead of
one-element array.

Also, this helps with the ongoing efforts to enable -Warray-bounds by
fixing the following warnings:

drivers/gpu/drm/radeon/ni_dpm.c: In function ‘ni_convert_power_state_to_smc’:
drivers/gpu/drm/radeon/ni_dpm.c:2521:20: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2521 |   smc_state->levels[i].dpm2.MaxPS =
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/ni_dpm.c:2523:20: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2523 |   smc_state->levels[i].dpm2.NearTDPDec = NISLANDS_DPM2_NEAR_TDP_DEC;
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/ni_dpm.c:2524:20: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2524 |   smc_state->levels[i].dpm2.AboveSafeInc = NISLANDS_DPM2_ABOVE_SAFE_INC;
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/ni_dpm.c:2525:20: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2525 |   smc_state->levels[i].dpm2.BelowSafeInc = NISLANDS_DPM2_BELOW_SAFE_INC;
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/ni_dpm.c:2526:35: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2526 |   smc_state->levels[i].stateFlags |=
      |                                   ^~
drivers/gpu/drm/radeon/ni_dpm.c:2526:35: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2526 |   smc_state->levels[i].stateFlags |=
      |   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
 2527 |    ((i != (state->performance_level_count - 1)) && power_boost_limit) ?
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2528 |    PPSMC_STATEFLAG_POWERBOOST : 0;
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/ni_dpm.c:2442:20: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2442 |   smc_state->levels[i + 1].aT = cpu_to_be32(a_t);

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/6023ed54.BfIY+9Uz81I6nq19%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/radeon/nislands_smc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/nislands_smc.h b/drivers/gpu/drm/radeon/nislands_smc.h
index 3cf8fc0d83f4..7395cb6b3cac 100644
--- a/drivers/gpu/drm/radeon/nislands_smc.h
+++ b/drivers/gpu/drm/radeon/nislands_smc.h
@@ -134,11 +134,11 @@ typedef struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL NISLANDS_SMC_HW_PERFORMANCE_LEV
 
 struct NISLANDS_SMC_SWSTATE
 {
-    uint8_t                             flags;
-    uint8_t                             levelCount;
-    uint8_t                             padding2;
-    uint8_t                             padding3;
-    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
+	uint8_t                             flags;
+	uint8_t                             levelCount;
+	uint8_t                             padding2;
+	uint8_t                             padding3;
+	NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
 };
 
 typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
-- 
2.27.0

