Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155CCC41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6763216C4
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086293;
	bh=HBwtJxagqbtQwZ67Dx8naXj+wlYZpPAKjHhzii40SSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qN61aKkDz2aTlFQKSPel6hSLZgh/6gZ7wblCyhqL1n6VlMBu9ieFavUQ67z3bFFgU
	 9NcQ7v9W7KIeEVHWZqct6OX0xasWx6YIaPYFcvBBVhVjm/jcYF2tU0tNauNBKWiwsp
	 WBVIK9H/vmfO/pG3tPFwEfCSaTFAJHGIc4/lnkLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgJGP6N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGP6N (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 11:58:13 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8373120789;
        Wed,  7 Oct 2020 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086292;
        bh=HBwtJxagqbtQwZ67Dx8naXj+wlYZpPAKjHhzii40SSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBminQ92WVBJEwwafMT2XaIQUmSq/7wGDo+qB95LHJy0g79ZrIWTtmvjjuIlyhn4Z
         9yEtPd43j5BDsGcUzvcwnhQ277O6G/ZPA6BpyL779Q0fsxFTeoCOh2tIXEM+KEnG2t
         ZL8UqyTHDh3i/CmVF7LUqo+0XVsmt1okRgFdFtqA=
Date:   Wed, 7 Oct 2020 11:04:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 03/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_clock_array
Message-ID: <661ad1c0e07f4eda264c08b219c8c702d67a9531.1602020074.git.gustavoars@kernel.org>
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
struct phm_clock_array, instead of a one-element array, and use the
struct_size() helper to calculate the size for the allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c433f.ZyMD+YUIVAwiHGVe%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                    |  2 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c    | 11 ++++-------
 .../gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c  |  7 +++----
 .../amd/pm/powerplay/hwmgr/vega10_processpptables.c   |  9 +++------
 4 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index d68b547743e6..e84cff09af2d 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -91,7 +91,7 @@ struct phm_set_power_state_input {
 
 struct phm_clock_array {
 	uint32_t count;
-	uint32_t values[1];
+	uint32_t values[];
 };
 
 struct phm_clock_voltage_dependency_record {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index b760f95e7fa7..52188f6cd150 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -318,19 +318,16 @@ static int get_valid_clk(
 		phm_ppt_v1_clock_voltage_dependency_table const *clk_volt_pp_table
 		)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	struct phm_clock_array *table;
 	phm_ppt_v1_clock_voltage_dependency_record *dep_record;
 
 	PP_ASSERT_WITH_CODE((0 != clk_volt_pp_table->count),
 		"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-		sizeof(uint32_t) * clk_volt_pp_table->count;
-
-	table = kzalloc(table_size, GFP_KERNEL);
-
-	if (NULL == table)
+	table = kzalloc(struct_size(table, values, clk_volt_pp_table->count),
+			GFP_KERNEL);
+	if (!table)
 		return -ENOMEM;
 
 	table->count = (uint32_t)clk_volt_pp_table->count;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index d94a7d8e0587..d9bed4df6f65 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -404,12 +404,11 @@ static int get_valid_clk(struct pp_hwmgr *hwmgr,
 			struct phm_clock_array **ptable,
 			const struct phm_clock_voltage_dependency_table *table)
 {
-	unsigned long table_size, i;
+	unsigned long i;
 	struct phm_clock_array *clock_table;
 
-	table_size = sizeof(unsigned long) + sizeof(unsigned long) * table->count;
-	clock_table = kzalloc(table_size, GFP_KERNEL);
-	if (NULL == clock_table)
+	clock_table = kzalloc(struct_size(clock_table, values, table->count), GFP_KERNEL);
+	if (!clock_table)
 		return -ENOMEM;
 
 	clock_table->count = (unsigned long)table->count;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index f29af5ca0aa0..e655c04ccdfb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -875,17 +875,14 @@ static int get_valid_clk(
 		struct phm_clock_array **clk_table,
 		const phm_ppt_v1_clock_voltage_dependency_table *clk_volt_pp_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	struct phm_clock_array *table;
 
 	PP_ASSERT_WITH_CODE(clk_volt_pp_table->count,
 			"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(uint32_t) * clk_volt_pp_table->count;
-
-	table = kzalloc(table_size, GFP_KERNEL);
-
+	table = kzalloc(struct_size(table, values, clk_volt_pp_table->count),
+			GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
-- 
2.27.0

