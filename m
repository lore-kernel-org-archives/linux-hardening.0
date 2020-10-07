Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B7C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC3E2173E
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086530;
	bh=kOWMKdamMcHW4Au2qrv3BhwsErtH4o8/QHcKuDMMRZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sua2aMu5olAtfZlroD9ZBp19J9gHS3Rohao5zXONlh280MtBBUHAUr48NTIwRyOAi
	 ZVR7rqDQCy4TIbMYGZEuYEHx8SRvfTm9FP5ubvDILsWQ3ofmZPcLhsE08hOrRMTHEM
	 mLIbEjw/wNCCMjA62utSUPQNZSvaKNBom8IXwI80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgJGQCJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgJGQCJ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:02:09 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BDF216C4;
        Wed,  7 Oct 2020 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086528;
        bh=kOWMKdamMcHW4Au2qrv3BhwsErtH4o8/QHcKuDMMRZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmGuJcVPJl3uga+8gAEvy+A4ZKDXXdQ1NcKMQBBi5AlUWLanqoW8qlXaryD82NEW4
         GoHt/F/tvWyIsctqQoCyH9T9Z5JlH4PeAgiNDx3M7SWbmbHIv3udv5fnnIBt2vPFcy
         KswO3N14vLrZHi7XvcFESAd5CWm3c3Mw3kLOfJ5M=
Date:   Wed, 7 Oct 2020 11:08:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 09/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_samu_clock_voltage_dependency_table
Message-ID: <7aa857a6242477b90da3643678d2798c7037b30f.1602020074.git.gustavoars@kernel.org>
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
struct phm_samu_clock_voltage_dependency_table, instead of a one-element array,
and use the struct_size() helper to calculate the size for the allocation.

Also, save some heap space as the original code is multiplying
table->numEntries by sizeof(struct phm_samu_clock_voltage_dependency_table)
when it should have been multiplied it by
sizeof(struct phm_samu_clock_voltage_dependency_record) instead.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c5d3a.ryM4GmZr3e0JeZy+%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                    |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c  | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 7e0c948a7097..dad703ba0522 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
 
 struct phm_samu_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_samu_clock_voltage_dependency_record entries[1];
+	struct phm_samu_clock_voltage_dependency_record entries[];
 };
 
 struct phm_cac_tdp_table {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index e059802d1e25..48d550d26c6a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1163,15 +1163,12 @@ static int get_samu_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
 		 struct phm_samu_clock_voltage_dependency_table **ptable,
 		 const ATOM_PPLIB_SAMClk_Voltage_Limit_Table *table)
 {
-	unsigned long table_size, i;
+	unsigned long i;
 	struct phm_samu_clock_voltage_dependency_table *samu_table;
 
-	table_size = sizeof(unsigned long) +
-		sizeof(struct phm_samu_clock_voltage_dependency_table) *
-		table->numEntries;
-
-	samu_table = kzalloc(table_size, GFP_KERNEL);
-	if (NULL == samu_table)
+	samu_table = kzalloc(struct_size(samu_table, entries, table->numEntries),
+			     GFP_KERNEL);
+	if (!samu_table)
 		return -ENOMEM;
 
 	samu_table->count = table->numEntries;
-- 
2.27.0

