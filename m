Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9440C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516E321707
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086330;
	bh=ZIXfWwTPMtSWQtAsNNmnq/E01PDvR4T4ANy6nPbnjXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tYD8TfDvnAjMjnZOWUpsG6OcgLZeSSQ08e+mO0K/8N5BdTRV/KK1u6sYgIGup5OKJ
	 JbhB/iUzTyIQnthZR+2HF/OXCxVCDp86u/kE1E+/07zYqGmOMql4188pwyCgl7Y9+v
	 iS4vh/bBgJ0nB25q/VHn05Voi+9D6GY87DD61Fdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgJGP6u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgJGP6t (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 11:58:49 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C865F215A4;
        Wed,  7 Oct 2020 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086329;
        bh=ZIXfWwTPMtSWQtAsNNmnq/E01PDvR4T4ANy6nPbnjXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJ4tbuvTG2Dnh8B4NerafV1cgJFZNQ51eEMIbGMHt+FOj1DYU6eJIyzvm3eOtFivn
         LcQVnQuFvlRSdOWS4cNmlukjGvO6Sm2mDkXJBOoeStjuSrKPVehuoMgzei9cHHhiVq
         9pMkvXquCgnaKigjPZ8mNL6rluFf/leTg69TF5Ek=
Date:   Wed, 7 Oct 2020 11:04:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 04/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_uvd_clock_voltage_dependency_table
Message-ID: <737f08bfa48ba706952bba91e823129f0dba1389.1602020074.git.gustavoars@kernel.org>
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
struct phm_uvd_clock_voltage_dependency_table, instead of a one-element
array, and use the struct_size() helper to calculate the size for the
allocation.

Also, save some heap space as the original code is multiplying
table->numEntries by sizeof(struct phm_uvd_clock_voltage_dependency_table)
when it should have multiplied it by sizeof(phm_uvd_clock_voltage_dependency_record)
instead.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c433e.pXkC6KsN6HN%2FLdhj%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                    |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c  | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index e84cff09af2d..2f1886bc5535 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
 
 struct phm_uvd_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_uvd_clock_voltage_dependency_record entries[1];
+	struct phm_uvd_clock_voltage_dependency_record entries[];
 };
 
 struct phm_acp_clock_voltage_dependency_record {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index d9bed4df6f65..305d95c4162d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1105,15 +1105,12 @@ static int get_uvd_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
 		const ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table *table,
 		const UVDClockInfoArray *array)
 {
-	unsigned long table_size, i;
+	unsigned long i;
 	struct phm_uvd_clock_voltage_dependency_table *uvd_table;
 
-	table_size = sizeof(unsigned long) +
-		 sizeof(struct phm_uvd_clock_voltage_dependency_table) *
-		 table->numEntries;
-
-	uvd_table = kzalloc(table_size, GFP_KERNEL);
-	if (NULL == uvd_table)
+	uvd_table = kzalloc(struct_size(uvd_table, entries, table->numEntries),
+			    GFP_KERNEL);
+	if (!uvd_table)
 		return -ENOMEM;
 
 	uvd_table->count = table->numEntries;
-- 
2.27.0

