Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC9AC41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9E421707
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086499;
	bh=Ci5si85NH59q4Nd51m/tvgULjrVXrm3GhsTTOHSXt9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQRWglbuJ3XDiTKb1ysuUCtHbOWxGjF0PDBpIOeoWq+Pvz5X2lM+3sfZdquhULkHp
	 tYAj4cE93c565NY9/sUTYuvC8uzVM6SG3AynAvC/CCTcttCelkC1JGfz/1JrDzir8P
	 SK3DIc2CTxbKxtI/MSsbvVrf7IGnX4h3RlOdgyBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgJGQBi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgJGQBi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:01:38 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26EE4206E5;
        Wed,  7 Oct 2020 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086498;
        bh=Ci5si85NH59q4Nd51m/tvgULjrVXrm3GhsTTOHSXt9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr8ZvKeFKU2W8ExkhPUCvGIlh35v3FSxvvSZ1Y31kOFMhvMQP0HT+u32E0VCvZsJx
         4WPYtkKulZOo+XCAuXKpNXY3AtCshYHYTrtnanN+US3Cday4znFq+JIdmhLYO5zcI0
         FQe+zZ1kD3LAiVajwdLXxeG2YcdKQUDPZSBsoA8E=
Date:   Wed, 7 Oct 2020 11:07:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 08/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_cac_leakage_table
Message-ID: <0e4dcb96d01f93e3a9288cf8f84548410d0ceee6.1602020074.git.gustavoars@kernel.org>
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
struct phm_cac_leakage_table, instead of a one-element array,
and use the struct_size() helper to calculate the size for the allocation.

Also, save some heap space as the original code is multiplying
table->ucNumEntries by sizeof(struct phm_cac_leakage_table) when it
should have been multiplied it by sizeof(struct phm_cac_leakage_record)
instead.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c5d38.iT%2FQTjN+659XUDo5%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                  |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c    | 13 +++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index b8e33325fac6..7e0c948a7097 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -393,7 +393,7 @@ union phm_cac_leakage_record {
 
 struct phm_cac_leakage_table {
 	uint32_t count;
-	union phm_cac_leakage_record entries[1];
+	union phm_cac_leakage_record entries[];
 };
 
 struct phm_samu_clock_voltage_dependency_record {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 7719f52e6d52..e059802d1e25 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1384,17 +1384,14 @@ static int get_cac_leakage_table(struct pp_hwmgr *hwmgr,
 				const ATOM_PPLIB_CAC_Leakage_Table *table)
 {
 	struct phm_cac_leakage_table  *cac_leakage_table;
-	unsigned long            table_size, i;
+	unsigned long i;
 
-	if (hwmgr == NULL || table == NULL || ptable == NULL)
+	if (!hwmgr || !table || !ptable)
 		return -EINVAL;
 
-	table_size = sizeof(ULONG) +
-		(sizeof(struct phm_cac_leakage_table) * table->ucNumEntries);
-
-	cac_leakage_table = kzalloc(table_size, GFP_KERNEL);
-
-	if (cac_leakage_table == NULL)
+	cac_leakage_table = kzalloc(struct_size(cac_leakage_table, entries, table->ucNumEntries),
+				    GFP_KERNEL);
+	if (!cac_leakage_table)
 		return -ENOMEM;
 
 	cac_leakage_table->count = (ULONG)table->ucNumEntries;
-- 
2.27.0

