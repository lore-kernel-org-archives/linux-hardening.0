Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB7C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 22:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3CB64DDA
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Feb 2021 22:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBJWlP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhBJWlP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Feb 2021 17:41:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5898164E8A;
        Wed, 10 Feb 2021 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612996834;
        bh=fv/SaLX4OCbE+8LRP74tQIUI6aMJIwiNKHsef7saXqc=;
        h=Date:From:To:Cc:Subject:From;
        b=FkYmsTOayGNs35h2mi4e3gHIin0mbtpK2ov/p/hu4m8hqbmEhw/0DqAIgEXpBoASj
         KQeYDvQm1/rLMnskdVd+UI5fa1ALYJu+o8LAVNiqlTRqC+rDAU0bnBwUgTesuUdd2D
         1lgRYeXqomTOCcsk7//NjPkKqhyjGqgROfv86HXmp2VZ3Ml4zVqweoMaoRkgGwL1UW
         fTWSdj8qf7m93PrvcAmB9YlOrhzo9EHfG5UBqUeW3d6v4wEqyD1Cvp1mXyX3qD8kEY
         IPwFcbcmzxz/OOCaRn/3nugCqG5Ebh7sLJJ0i1DPMn2kQMBREZ4EbgSSamz452Ugha
         a5mbXO/6nUSgQ==
Date:   Wed, 10 Feb 2021 16:40:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE
Message-ID: <20210210224031.GA8795@embeddedor>
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

Refactor the code according to the use of a flexible-array member in
struct SISLANDS_SMC_SWSTATE, instead of a one-element array, and use
the struct_size() helper to calculate the size for the allocation.

Also, this helps with the ongoing efforts to enable -Warray-bounds and
fix the following warnings:

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2448:20: warning: array
subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’
{aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2449:20: warning: array
subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’
{aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2450:20: warning: array
subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’
{aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2451:20: warning: array
subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’
{aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2452:20: warning: array
subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’
{aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:5570:20: warning: array
subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’
{aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/6023be58.sk66L%2FV4vuSJI5mI%25lkp@intel.com/ 
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c       |  6 ++----
 drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h | 10 +++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index afa1711c9620..62291358fb1c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -5715,11 +5715,9 @@ static int si_upload_sw_state(struct amdgpu_device *adev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
-	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
-		((new_state->performance_level_count - 1) *
-		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
-
+	size_t state_size = struct_size(smc_state, levels,
+					new_state->performance_level_count);
 	memset(smc_state, 0, state_size);
 
 	ret = si_convert_power_state_to_smc(adev, amdgpu_new_state, smc_state);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
index d2930eceaf3c..0f7554052c90 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
@@ -182,11 +182,11 @@ typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PERFORMANCE_LEV
 
 struct SISLANDS_SMC_SWSTATE
 {
-    uint8_t                             flags;
-    uint8_t                             levelCount;
-    uint8_t                             padding2;
-    uint8_t                             padding3;
-    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
+	uint8_t                             flags;
+	uint8_t                             levelCount;
+	uint8_t                             padding2;
+	uint8_t                             padding3;
+	SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
 };
 
 typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
-- 
2.27.0

