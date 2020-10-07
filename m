Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D7C4727E
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3669D2177B
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086575;
	bh=TLtgDcbpdEwR1QGM4fDbkziKwC3gCpf2kRG8t9Zjkao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1wDY7lWLP0ay8uzFvNlpu+3+u46mrnvImCyfolvaGaca21PibRfCzLPtkjNyEXfnB
	 du0k+46BfBHipvTVPkBaG42QZBOcHsfn5vBfspBosN0KTAYTcSWhWVHNQi+8470swY
	 aWYj+T/b/lwg5oRkpjdVNrSyWPAi3AY7LVBz5dn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgJGQCy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgJGQCy (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:02:54 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8655F216C4;
        Wed,  7 Oct 2020 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086573;
        bh=TLtgDcbpdEwR1QGM4fDbkziKwC3gCpf2kRG8t9Zjkao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pI267f34imT2GwJxDUWed1YEdSXiHHYLgqxhF8INfg9oLB6oinNCDuoG2kxCODA2H
         HKqfFMW+HeIqkCo8DNZJofczHU+1tSezczEJVa6vqJDkG8S6+VYRYGIwHBZ2cOYP55
         i8zTxZV00FmDpFDn+JbQHNbkNqKZb5Ld5beGGd1Q=
Date:   Wed, 7 Oct 2020 11:08:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 10/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_ppt_v1_clock_voltage_dependency_table
Message-ID: <3954508c123dabe1076af7651f220dc8696e5710.1602020074.git.gustavoars@kernel.org>
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
struct phm_ppt_v1_clock_voltage_dependency_table, instead of a one-element
array, and use the struct_size() helper to calculate the size for the
allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: 
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h    |  2 +-
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 31 ++++--------
 .../powerplay/hwmgr/vega10_processpptables.c  | 50 ++++++-------------
 3 files changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
index c0193e09d58a..c167083b0872 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
@@ -48,7 +48,7 @@ typedef struct phm_ppt_v1_clock_voltage_dependency_record phm_ppt_v1_clock_volta
 
 struct phm_ppt_v1_clock_voltage_dependency_table {
 	uint32_t count;                                            /* Number of entries. */
-	phm_ppt_v1_clock_voltage_dependency_record entries[1];     /* Dynamically allocate count entries. */
+	phm_ppt_v1_clock_voltage_dependency_record entries[];	   /* Dynamically allocate count entries. */
 };
 
 typedef struct phm_ppt_v1_clock_voltage_dependency_table phm_ppt_v1_clock_voltage_dependency_table;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 52188f6cd150..0725531fbfff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -367,7 +367,7 @@ static int get_mclk_voltage_dependency_table(
 		ATOM_Tonga_MCLK_Dependency_Table const *mclk_dep_table
 		)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	phm_ppt_v1_clock_voltage_dependency_table *mclk_table;
 	phm_ppt_v1_clock_voltage_dependency_record *mclk_table_record;
 	ATOM_Tonga_MCLK_Dependency_Record *mclk_dep_record;
@@ -375,12 +375,9 @@ static int get_mclk_voltage_dependency_table(
 	PP_ASSERT_WITH_CODE((0 != mclk_dep_table->ucNumEntries),
 		"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) + sizeof(phm_ppt_v1_clock_voltage_dependency_record)
-		* mclk_dep_table->ucNumEntries;
-
-	mclk_table = kzalloc(table_size, GFP_KERNEL);
-
-	if (NULL == mclk_table)
+	mclk_table = kzalloc(struct_size(mclk_table, entries, mclk_dep_table->ucNumEntries),
+			     GFP_KERNEL);
+	if (!mclk_table)
 		return -ENOMEM;
 
 	mclk_table->count = (uint32_t)mclk_dep_table->ucNumEntries;
@@ -410,7 +407,7 @@ static int get_sclk_voltage_dependency_table(
 		PPTable_Generic_SubTable_Header const  *sclk_dep_table
 		)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	phm_ppt_v1_clock_voltage_dependency_table *sclk_table;
 	phm_ppt_v1_clock_voltage_dependency_record *sclk_table_record;
 
@@ -422,12 +419,9 @@ static int get_sclk_voltage_dependency_table(
 		PP_ASSERT_WITH_CODE((0 != tonga_table->ucNumEntries),
 			"Invalid PowerPlay Table!", return -1);
 
-		table_size = sizeof(uint32_t) + sizeof(phm_ppt_v1_clock_voltage_dependency_record)
-			* tonga_table->ucNumEntries;
-
-		sclk_table = kzalloc(table_size, GFP_KERNEL);
-
-		if (NULL == sclk_table)
+		sclk_table = kzalloc(struct_size(sclk_table, entries, tonga_table->ucNumEntries),
+				     GFP_KERNEL);
+		if (!sclk_table)
 			return -ENOMEM;
 
 		sclk_table->count = (uint32_t)tonga_table->ucNumEntries;
@@ -454,12 +448,9 @@ static int get_sclk_voltage_dependency_table(
 		PP_ASSERT_WITH_CODE((0 != polaris_table->ucNumEntries),
 			"Invalid PowerPlay Table!", return -1);
 
-		table_size = sizeof(uint32_t) + sizeof(phm_ppt_v1_clock_voltage_dependency_record)
-			* polaris_table->ucNumEntries;
-
-		sclk_table = kzalloc(table_size, GFP_KERNEL);
-
-		if (NULL == sclk_table)
+		sclk_table = kzalloc(struct_size(sclk_table, entries, polaris_table->ucNumEntries),
+				     GFP_KERNEL);
+		if (!sclk_table)
 			return -ENOMEM;
 
 		sclk_table->count = (uint32_t)polaris_table->ucNumEntries;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index e655c04ccdfb..787b23fa25e7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -571,18 +571,14 @@ static int get_socclk_voltage_dependency_table(
 		phm_ppt_v1_clock_voltage_dependency_table **pp_vega10_clk_dep_table,
 		const ATOM_Vega10_SOCCLK_Dependency_Table *clk_dep_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	phm_ppt_v1_clock_voltage_dependency_table *clk_table;
 
 	PP_ASSERT_WITH_CODE(clk_dep_table->ucNumEntries,
 		"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
-			clk_dep_table->ucNumEntries;
-
-	clk_table = kzalloc(table_size, GFP_KERNEL);
-
+	clk_table = kzalloc(struct_size(clk_table, entries, clk_dep_table->ucNumEntries),
+			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
@@ -605,18 +601,14 @@ static int get_mclk_voltage_dependency_table(
 		phm_ppt_v1_clock_voltage_dependency_table **pp_vega10_mclk_dep_table,
 		const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	phm_ppt_v1_clock_voltage_dependency_table *mclk_table;
 
 	PP_ASSERT_WITH_CODE(mclk_dep_table->ucNumEntries,
 		"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
-			mclk_dep_table->ucNumEntries;
-
-	mclk_table = kzalloc(table_size, GFP_KERNEL);
-
+	mclk_table = kzalloc(struct_size(mclk_table, entries, mclk_dep_table->ucNumEntries),
+			    GFP_KERNEL);
 	if (!mclk_table)
 		return -ENOMEM;
 
@@ -644,7 +636,7 @@ static int get_gfxclk_voltage_dependency_table(
 			**pp_vega10_clk_dep_table,
 		const ATOM_Vega10_GFXCLK_Dependency_Table *clk_dep_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	struct phm_ppt_v1_clock_voltage_dependency_table
 				*clk_table;
 	ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
@@ -652,12 +644,8 @@ static int get_gfxclk_voltage_dependency_table(
 	PP_ASSERT_WITH_CODE((clk_dep_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
-			clk_dep_table->ucNumEntries;
-
-	clk_table = kzalloc(table_size, GFP_KERNEL);
-
+	clk_table = kzalloc(struct_size(clk_table, entries, clk_dep_table->ucNumEntries),
+			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
@@ -711,19 +699,15 @@ static int get_pix_clk_voltage_dependency_table(
 			**pp_vega10_clk_dep_table,
 		const  ATOM_Vega10_PIXCLK_Dependency_Table *clk_dep_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	struct phm_ppt_v1_clock_voltage_dependency_table
 				*clk_table;
 
 	PP_ASSERT_WITH_CODE((clk_dep_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
-			clk_dep_table->ucNumEntries;
-
-	clk_table = kzalloc(table_size, GFP_KERNEL);
-
+	clk_table = kzalloc(struct_size(clk_table, entries, clk_dep_table->ucNumEntries),
+			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
@@ -747,7 +731,7 @@ static int get_dcefclk_voltage_dependency_table(
 			**pp_vega10_clk_dep_table,
 		const ATOM_Vega10_DCEFCLK_Dependency_Table *clk_dep_table)
 {
-	uint32_t table_size, i;
+	uint32_t i;
 	uint8_t num_entries;
 	struct phm_ppt_v1_clock_voltage_dependency_table
 				*clk_table;
@@ -775,12 +759,8 @@ static int get_dcefclk_voltage_dependency_table(
 		num_entries = clk_dep_table->ucNumEntries;
 
 
-	table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
-			num_entries;
-
-	clk_table = kzalloc(table_size, GFP_KERNEL);
-
+	clk_table = kzalloc(struct_size(clk_table, entries, num_entries),
+			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
-- 
2.27.0

