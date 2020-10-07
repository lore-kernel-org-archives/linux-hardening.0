Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E6C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C34A21707
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086187;
	bh=9KvHvObxnkiLqVCFdBl2Uwtt1o9NsUDBlzUyaonBWUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1qY8B/jhmGUiIuCbPCbZTCDRyT+Ix4Ecjv6CCpiUVTzy1TXJfcZLyJUY9sFv5zN4q
	 44JbPhbvDQBZiEYvkpz6xzOHTBOjsEz3WDYEmoaBLZ/J8AU/5PiyZxnvDyAIas4ss6
	 H9UyuvY3RwJeppsXOSrbaMHDRlTdp2evyXsowIhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgJGP41 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbgJGP41 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 11:56:27 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E10E20789;
        Wed,  7 Oct 2020 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086186;
        bh=9KvHvObxnkiLqVCFdBl2Uwtt1o9NsUDBlzUyaonBWUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTDNJ8LOZg5Gzgjz9n5LENJFUS+a+8BKaSnuAlx8ZvfRybtPHn9w71c16ecM7RTZu
         xO06P/7ck+CC1vp6TP1lj+rnA3dAPc/2Kuma1p5U/vLKGdONeedFqARTYyeXKuLoOx
         f8NzZ2oQZwpBSZySALyYme9Lw5XmVXm8qVvvb86c=
Date:   Wed, 7 Oct 2020 11:02:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 01/14] drm/amd/pm: Replace one-element array with
 flexible-array member
Message-ID: <069289d62f5cf464f607d33582c9e5826393b0f1.1602020074.git.gustavoars@kernel.org>
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
struct phm_clock_voltage_dependency_table, instead of a one-element
array, and use the struct_size() helper to calculate the size for the
allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c295c.8iqp1Ifc6oiVDq%2F%2F%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                       | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 9 +++------
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c      | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c      | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 3898a95ec28b..a1dbfd5636e6 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -122,8 +122,8 @@ struct phm_acpclock_voltage_dependency_record {
 };
 
 struct phm_clock_voltage_dependency_table {
-	uint32_t count;										/* Number of entries. */
-	struct phm_clock_voltage_dependency_record entries[1];		/* Dynamically allocate count entries. */
+	uint32_t count;							/* Number of entries. */
+	struct phm_clock_voltage_dependency_record entries[];		/* Dynamically allocate count entries. */
 };
 
 struct phm_phase_shedding_limits_record {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 719597c5d27d..d94a7d8e0587 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -377,14 +377,11 @@ static int get_clock_voltage_dependency_table(struct pp_hwmgr *hwmgr,
 		const ATOM_PPLIB_Clock_Voltage_Dependency_Table *table)
 {
 
-	unsigned long table_size, i;
+	unsigned long i;
 	struct phm_clock_voltage_dependency_table *dep_table;
 
-	table_size = sizeof(unsigned long) +
-		sizeof(struct phm_clock_voltage_dependency_table)
-		* table->ucNumEntries;
-
-	dep_table = kzalloc(table_size, GFP_KERNEL);
+	dep_table = kzalloc(struct_size(dep_table, entries, table->ucNumEntries),
+			    GFP_KERNEL);
 	if (NULL == dep_table)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 35ed47ebaf09..ed9b89980184 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -276,7 +276,7 @@ static int smu8_init_dynamic_state_adjustment_rule_settings(
 {
 	struct phm_clock_voltage_dependency_table *table_clk_vlt;
 
-	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 7),
+	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 8),
 				GFP_KERNEL);
 
 	if (NULL == table_clk_vlt) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 60b5ca974356..b485f8b1d6f2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -492,13 +492,12 @@ int phm_get_sclk_for_voltage_evv(struct pp_hwmgr *hwmgr,
  */
 int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr)
 {
-	uint32_t table_size;
 	struct phm_clock_voltage_dependency_table *table_clk_vlt;
 	struct phm_ppt_v1_information *pptable_info = (struct phm_ppt_v1_information *)(hwmgr->pptable);
 
 	/* initialize vddc_dep_on_dal_pwrl table */
-	table_size = sizeof(uint32_t) + 4 * sizeof(struct phm_clock_voltage_dependency_record);
-	table_clk_vlt = kzalloc(table_size, GFP_KERNEL);
+	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 4),
+				GFP_KERNEL);
 
 	if (NULL == table_clk_vlt) {
 		pr_err("Can not allocate space for vddc_dep_on_dal_pwrl! \n");
-- 
2.27.0

