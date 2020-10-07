Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE40C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF65216C4
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086662;
	bh=3cmBsuMFJG0w/OcgqfCHa6aItbGr0wGxUb1AbOPczm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTfXV7Cou2qGLL0wTLGVeBpKY5UR+2MZIjmclNonMnL5tBdoY7F358FZOpcqYL8EY
	 fofqNe8wivg9QI1y0EZMhe+hNLPd0REDfX7kMuJkFYl/ExdGvAsyNKbyj+fYL9NC2s
	 dHx8W9wYLhZNLJqiQpYtsd9gRHJ4OtReI8VpdEyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgJGQEV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgJGQEQ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:04:16 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E92321707;
        Wed,  7 Oct 2020 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086656;
        bh=3cmBsuMFJG0w/OcgqfCHa6aItbGr0wGxUb1AbOPczm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJHOYLbukTm0WNj7dQ3yrvGHH7JCMjOiLrVlaNeB3+s5+WrFH835OEL1PuMnE77nZ
         lvD5iNOZn16kE5hLy7W7amlx9MvBm7FCX3Rpsz5nGxKZmTzL69mgZ8DdZUU8dxSPhW
         qKmsuyaD9KOLNLm1szfnasqAa3X7Sy8wgL9Th2rw=
Date:   Wed, 7 Oct 2020 11:10:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 12/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_ppt_v1_voltage_lookup_table
Message-ID: <aab5dcc4a793914f0b6a713f5b2c32cc84b1aa00.1602020074.git.gustavoars@kernel.org>
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
struct phm_ppt_v1_voltage_lookup_table, instead of a one-element array,
and use the struct_size() helper to calculate the size for the allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7d61df.jWrFfnjxGbjSkPOp%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h     |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 10 +++-------
 .../amd/pm/powerplay/hwmgr/vega10_processpptables.c    | 10 +++-------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
index 923cc04e405a..e11298cdeb30 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
@@ -86,7 +86,7 @@ typedef struct phm_ppt_v1_voltage_lookup_record phm_ppt_v1_voltage_lookup_record
 
 struct phm_ppt_v1_voltage_lookup_table {
 	uint32_t count;
-	phm_ppt_v1_voltage_lookup_record entries[1];    /* Dynamically allocate count entries. */
+	phm_ppt_v1_voltage_lookup_record entries[];    /* Dynamically allocate count entries. */
 };
 typedef struct phm_ppt_v1_voltage_lookup_table phm_ppt_v1_voltage_lookup_table;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 5d8016cd1986..426655b9c678 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -157,7 +157,7 @@ static int get_vddc_lookup_table(
 		uint32_t max_levels
 		)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	phm_ppt_v1_voltage_lookup_table *table;
 	phm_ppt_v1_voltage_lookup_record *record;
 	ATOM_Tonga_Voltage_Lookup_Record *atom_record;
@@ -165,12 +165,8 @@ static int get_vddc_lookup_table(
 	PP_ASSERT_WITH_CODE((0 != vddc_lookup_pp_tables->ucNumEntries),
 		"Invalid CAC Leakage PowerPlay Table!", return 1);
 
-	table_size = sizeof(uint32_t) +
-		sizeof(phm_ppt_v1_voltage_lookup_record) * max_levels;
-
-	table = kzalloc(table_size, GFP_KERNEL);
-
-	if (NULL == table)
+	table = kzalloc(struct_size(table, entries, max_levels), GFP_KERNEL);
+	if (!table)
 		return -ENOMEM;
 
 	table->count = vddc_lookup_pp_tables->ucNumEntries;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 4f6a73a2cf28..3d7f915381c8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -1040,18 +1040,14 @@ static int get_vddc_lookup_table(
 		const ATOM_Vega10_Voltage_Lookup_Table *vddc_lookup_pp_tables,
 		uint32_t max_levels)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	phm_ppt_v1_voltage_lookup_table *table;
 
 	PP_ASSERT_WITH_CODE((vddc_lookup_pp_tables->ucNumEntries != 0),
 			"Invalid SOC_VDDD Lookup Table!", return 1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_voltage_lookup_record) * max_levels;
-
-	table = kzalloc(table_size, GFP_KERNEL);
-
-	if (table == NULL)
+	table = kzalloc(struct_size(table, entries, max_levels), GFP_KERNEL);
+	if (!table)
 		return -ENOMEM;
 
 	table->count = vddc_lookup_pp_tables->ucNumEntries;
-- 
2.27.0

