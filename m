Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B9C433E9
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6669F64F3A
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhCDAvZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:51:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350348AbhCCTFl (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Mar 2021 14:05:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B68F64EF3;
        Wed,  3 Mar 2021 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614798300;
        bh=85Krc/tdNXUI3941UDLi7ozDpdfAZuOSRnkZa35g1kM=;
        h=Date:From:To:Cc:Subject:From;
        b=Czbt8bsGw83pm7DsyPtBp60PbC2vRLv45EW9WesL6mrzf8U0cCF4V3GC4Wum9lCR/
         gun0VvIN9ouEhwN9lxQ/uCMa54OJuLxyYSCnxn3eris/JPNlxSG5ggGpj6hVxXQIcB
         bs8WgZ0/LlKV18H26C/rnVr4c4LyYQTIngNrdSc7c68tNRITvLKBMVTXWrlsm0edIT
         aKbOEFWpGWYr/ChbRSmupaAb8nD0WUMW6JzafXAFf+o7PoDeWPXILAR/r3xO1UTx0D
         W48Ioah28TJAwNsKVPXe+k8UjkFyzdVSo8o1u3Ph/ZlBYaj+kg+VuDQrsHwrlHFBmd
         D2QVmjSdymwaA==
Date:   Wed, 3 Mar 2021 13:04:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE
Message-ID: <20210303190458.GA16321@embeddedor>
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

Also, this helps with the ongoing efforts to enable -Warray-bounds by
fixing the following warnings:

drivers/gpu/drm/radeon/si_dpm.c: In function ‘si_convert_power_state_to_smc’:
drivers/gpu/drm/radeon/si_dpm.c:2350:20: warning: array subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2350 |   smc_state->levels[i].dpm2.MaxPS = (u8)((SISLANDS_DPM2_MAX_PULSE_SKIP * (max_sclk - min_sclk)) / max_sclk);
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/si_dpm.c:2351:20: warning: array subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2351 |   smc_state->levels[i].dpm2.NearTDPDec = SISLANDS_DPM2_NEAR_TDP_DEC;
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/si_dpm.c:2352:20: warning: array subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2352 |   smc_state->levels[i].dpm2.AboveSafeInc = SISLANDS_DPM2_ABOVE_SAFE_INC;
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/si_dpm.c:2353:20: warning: array subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2353 |   smc_state->levels[i].dpm2.BelowSafeInc = SISLANDS_DPM2_BELOW_SAFE_INC;
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/si_dpm.c:2354:20: warning: array subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2354 |   smc_state->levels[i].dpm2.PwrEfficiencyRatio = cpu_to_be16(pwr_efficiency_ratio);
      |   ~~~~~~~~~~~~~~~~~^~~
drivers/gpu/drm/radeon/si_dpm.c:5105:20: warning: array subscript 1 is above array bounds of ‘SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 5105 |   smc_state->levels[i + 1].aT = cpu_to_be32(a_t);
      |   ~~~~~~~~~~~~~~~~~^~~~~~~

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/603f9a8f.aDLrpMFzzSApzVYQ%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/radeon/si_dpm.c       |  5 ++---
 drivers/gpu/drm/radeon/sislands_smc.h | 10 +++++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 91bfc4762767..918609551804 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5250,10 +5250,9 @@ static int si_upload_sw_state(struct radeon_device *rdev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
-	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
-		((new_state->performance_level_count - 1) *
-		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
 	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
+	size_t state_size = struct_size(smc_state, levels,
+					new_state->performance_level_count);
 
 	memset(smc_state, 0, state_size);
 
diff --git a/drivers/gpu/drm/radeon/sislands_smc.h b/drivers/gpu/drm/radeon/sislands_smc.h
index 966e3a556011..fbd6589bdab9 100644
--- a/drivers/gpu/drm/radeon/sislands_smc.h
+++ b/drivers/gpu/drm/radeon/sislands_smc.h
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

