Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E779C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D28221707
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086615;
	bh=d/83Xa65B5kEJg/2ezzz6WtGokGgaiC3BZHaTrydl6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uG9DXVJilVxjeVyjswelo1gu3KhtMtgTM0HviHETU170mt0eiurZoSo2Dvcr/p5Tx
	 uzc7VsW3SRtsMVaF3IplAWetXqzt0vRSajgpQzJbBwaAeZEwufi7CP4DFcsX/HRkHP
	 o/DY4ZGJgi09be46QpmcewgA5qNkF2Dl/mTJYxrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgJGQDe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbgJGQDe (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:03:34 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB293216C4;
        Wed,  7 Oct 2020 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086613;
        bh=d/83Xa65B5kEJg/2ezzz6WtGokGgaiC3BZHaTrydl6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aa/PrehoTwMf2o6Nmax0kxYurzAXKofJngfLFWGSwZqxd3TTUCqesTj8Nur+rw5+d
         pTaiGbv+R77ZhIx9muKaUeow3mAGNxS9IQUpzT2qU6TyACyUwuWTmTdksHBX4gc4BN
         IGr09Mv9Vce10zxfPHRdKKGPq6227MNJetieH1hA=
Date:   Wed, 7 Oct 2020 11:09:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 11/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_ppt_v1_mm_clock_voltage_dependency_table
Message-ID: <787d732119dda8e1c6c0d524349278c20d34e01a.1602020074.git.gustavoars@kernel.org>
References: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1602020074.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in
struct phm_ppt_v1_mm_clock_voltage_dependency_table, instead of a
one-element array, and use the struct_size() helper to calculate the
size for the allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7d61e2.qiTVTyG2pVoG8bb0%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h    |  2 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c    | 11 ++++-------
 .../amd/pm/powerplay/hwmgr/vega10_processpptables.c   |  9 +++------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
index c167083b0872..923cc04e405a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
@@ -71,7 +71,7 @@ typedef struct phm_ppt_v1_mm_clock_voltage_dependency_record phm_ppt_v1_mm_clock
 
 struct phm_ppt_v1_mm_clock_voltage_dependency_table {
 	uint32_t count;													/* Number of entries. */
-	phm_ppt_v1_mm_clock_voltage_dependency_record entries[1];		/* Dynamically allocate count entries. */
+	phm_ppt_v1_mm_clock_voltage_dependency_record entries[];		/* Dynamically allocate count entries. */
 };
 typedef struct phm_ppt_v1_mm_clock_voltage_dependency_table phm_ppt_v1_mm_clock_voltage_dependency_table;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 0725531fbfff..5d8016cd1986 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -678,19 +678,16 @@ static int get_mm_clock_voltage_table(
 		const ATOM_Tonga_MM_Dependency_Table * mm_dependency_table
 		)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	const ATOM_Tonga_MM_Dependency_Record *mm_dependency_record;
 	phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table;
 	phm_ppt_v1_mm_clock_voltage_dependency_record *mm_table_record;
 
 	PP_ASSERT_WITH_CODE((0 != mm_dependency_table->ucNumEntries),
 		"Invalid PowerPlay Table!", return -1);
-	table_size = sizeof(uint32_t) +
-		sizeof(phm_ppt_v1_mm_clock_voltage_dependency_record)
-		* mm_dependency_table->ucNumEntries;
-	mm_table = kzalloc(table_size, GFP_KERNEL);
-
-	if (NULL == mm_table)
+	mm_table = kzalloc(struct_size(mm_table, entries, mm_dependency_table->ucNumEntries),
+			   GFP_KERNEL);
+	if (!mm_table)
 		return -ENOMEM;
 
 	mm_table->count = mm_dependency_table->ucNumEntries;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 787b23fa25e7..4f6a73a2cf28 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -344,18 +344,15 @@ static int get_mm_clock_voltage_table(
 		phm_ppt_v1_mm_clock_voltage_dependency_table **vega10_mm_table,
 		const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	const ATOM_Vega10_MM_Dependency_Record *mm_dependency_record;
 	phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table;
 
 	PP_ASSERT_WITH_CODE((mm_dependency_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_mm_clock_voltage_dependency_record) *
-			mm_dependency_table->ucNumEntries;
-	mm_table = kzalloc(table_size, GFP_KERNEL);
-
+	mm_table = kzalloc(struct_size(mm_table, entries, mm_dependency_table->ucNumEntries),
+			   GFP_KERNEL);
 	if (!mm_table)
 		return -ENOMEM;
 
-- 
2.27.0

