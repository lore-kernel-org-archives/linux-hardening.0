Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D34C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B8E2173E
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086685;
	bh=Afpoi0axZ63mSzi9LUVJhYqlciQbhzVpxbkFCpclXHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtKOajJGCkJY59iH4U5gm9OzAF877NwaxzO7hiPRH0SxlUftJTAa9EPA+UoD0anLb
	 aRbUqbuSqHxVXw8Zok0CFKrd7Dw8P7KCkxvx23ejW2Ox9QcbUIh2gMfKdWlByvc0c4
	 J7XKB6xWyKhwNKgCLqksR7WZ8lmU/YVWvBSgvYyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgJGQEp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgJGQEp (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:04:45 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94FC1216C4;
        Wed,  7 Oct 2020 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086683;
        bh=Afpoi0axZ63mSzi9LUVJhYqlciQbhzVpxbkFCpclXHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbEwHOL6kLktQ/Z9t+jJPTlmu8CJwv+nelU6Z5CYjF82+UW5enSegQzU8yTye9H9h
         0mJzWw0fPpELJrlwbVjBuqMfGZx7v2T6lewPGPzmoV4V2GdsCjoAeMHzgEPMZoUGJy
         GF8Ay1rkhrwvdw0MvcRgPGhvWA5pXo+vQKMFlY1o=
Date:   Wed, 7 Oct 2020 11:10:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 13/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_ppt_v1_pcie_table
Message-ID: <1f91ef3bc6aeb8adb7362166f09076ddbe13182f.1602020074.git.gustavoars@kernel.org>
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
struct phm_ppt_v1_pcie_table, instead of a one-element array, and use
the struct_size() helper to calculate the size for the allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7db0bc.7Xivn4K83f7XW0ug%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h    |  2 +-
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 22 ++++++++-----------
 .../powerplay/hwmgr/vega10_processpptables.c  | 10 +++------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
index e11298cdeb30..729615aff126 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
@@ -103,7 +103,7 @@ typedef struct phm_ppt_v1_pcie_record phm_ppt_v1_pcie_record;
 
 struct phm_ppt_v1_pcie_table {
 	uint32_t count;                                            /* Number of entries. */
-	phm_ppt_v1_pcie_record entries[1];                         /* Dynamically allocate count entries. */
+	phm_ppt_v1_pcie_record entries[];			   /* Dynamically allocate count entries. */
 };
 typedef struct phm_ppt_v1_pcie_table phm_ppt_v1_pcie_table;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 426655b9c678..4fa58614e26a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -478,7 +478,7 @@ static int get_pcie_table(
 		PPTable_Generic_SubTable_Header const *ptable
 		)
 {
-	uint32_t table_size, i, pcie_count;
+	uint32_t i, pcie_count;
 	phm_ppt_v1_pcie_table *pcie_table;
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
@@ -491,12 +491,10 @@ static int get_pcie_table(
 		PP_ASSERT_WITH_CODE((atom_pcie_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-		table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_pcie_record) * atom_pcie_table->ucNumEntries;
-
-		pcie_table = kzalloc(table_size, GFP_KERNEL);
-
-		if (pcie_table == NULL)
+		pcie_table = kzalloc(struct_size(pcie_table, entries,
+						 atom_pcie_table->ucNumEntries),
+				     GFP_KERNEL);
+		if (!pcie_table)
 			return -ENOMEM;
 
 		/*
@@ -530,12 +528,10 @@ static int get_pcie_table(
 		PP_ASSERT_WITH_CODE((atom_pcie_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-		table_size = sizeof(uint32_t) +
-			sizeof(phm_ppt_v1_pcie_record) * atom_pcie_table->ucNumEntries;
-
-		pcie_table = kzalloc(table_size, GFP_KERNEL);
-
-		if (pcie_table == NULL)
+		pcie_table = kzalloc(struct_size(pcie_table, entries,
+						 atom_pcie_table->ucNumEntries),
+				     GFP_KERNEL);
+		if (!pcie_table)
 			return -ENOMEM;
 
 		/*
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 3d7f915381c8..535404de78a2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -784,7 +784,7 @@ static int get_pcie_table(struct pp_hwmgr *hwmgr,
 		struct phm_ppt_v1_pcie_table **vega10_pcie_table,
 		const Vega10_PPTable_Generic_SubTable_Header *table)
 {
-	uint32_t table_size, i, pcie_count;
+	uint32_t i, pcie_count;
 	struct phm_ppt_v1_pcie_table *pcie_table;
 	struct phm_ppt_v2_information *table_info =
 			(struct phm_ppt_v2_information *)(hwmgr->pptable);
@@ -795,12 +795,8 @@ static int get_pcie_table(struct pp_hwmgr *hwmgr,
 			"Invalid PowerPlay Table!",
 			return 0);
 
-	table_size = sizeof(uint32_t) +
-			sizeof(struct phm_ppt_v1_pcie_record) *
-			atom_pcie_table->ucNumEntries;
-
-	pcie_table = kzalloc(table_size, GFP_KERNEL);
-
+	pcie_table = kzalloc(struct_size(pcie_table, entries, atom_pcie_table->ucNumEntries),
+			     GFP_KERNEL);
 	if (!pcie_table)
 		return -ENOMEM;
 
-- 
2.27.0

