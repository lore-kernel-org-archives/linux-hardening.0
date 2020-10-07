Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0618CC41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52EF216C4
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086363;
	bh=hJslUfi5rxFoAmtR6R3uKnAvE+gdWHluNs09jV3jZg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OGSR2DF5VcUB8kQUPJm91uLYJ3j1JEnqVY8RDbPDD05XmbMDw1MsdA/eG/3LPC0SM
	 t3ic8RXkisFFUxFamWMcrc0FwPAsipNSGdLa7OO3MVy2XMtN2n2jVx3uqC7/8164JR
	 4y/BKJwDRNG3hZlrvjHYu5oqFBpPS/W2tq62fFDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgJGP7X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbgJGP7X (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 11:59:23 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B7120789;
        Wed,  7 Oct 2020 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086362;
        bh=hJslUfi5rxFoAmtR6R3uKnAvE+gdWHluNs09jV3jZg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrtFOIzP21KalR8ZHk3BCgbUZNnv2AH75XI7f5mpgy7Oifo8EVpV8Bbj2UJwxiSG7
         Oo8WcS2SOOOMdTGIbXW5qE4svUn34BrVGGxE+Ihl+yC/aLg9GKQGUovRuuGkrycs+R
         sT/x+XmuuRS10wBy64mQ0OAEfF3lPFpDOzSAOGbs=
Date:   Wed, 7 Oct 2020 11:05:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 05/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_acp_clock_voltage_dependency_table
Message-ID: <92351e6a3328d31e61927462edac3b8dcbcd41b9.1602020074.git.gustavoars@kernel.org>
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
struct phm_acp_clock_voltage_dependency_table, instead of a one-element
array, and use the struct_size() helper to calculate the size for the
allocation.

Also, save some heap space as the original code is multiplying
table->numEntries by sizeof(struct phm_acp_clock_voltage_dependency_table)
when it should have multiplied it by sizeof(phm_acp_clock_voltage_dependency_record)
instead.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c5d3c.TyfOhg%2FA6JycL6ZN%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                    |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c  | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 2f1886bc5535..361cb1125351 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
 
 struct phm_acp_clock_voltage_dependency_table {
 	uint32_t count;
-	struct phm_acp_clock_voltage_dependency_record entries[1];
+	struct phm_acp_clock_voltage_dependency_record entries[];
 };
 
 struct phm_vce_clock_voltage_dependency_record {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 305d95c4162d..a1b198045978 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1194,15 +1194,12 @@ static int get_acp_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
 		struct phm_acp_clock_voltage_dependency_table **ptable,
 		const ATOM_PPLIB_ACPClk_Voltage_Limit_Table *table)
 {
-	unsigned table_size, i;
+	unsigned long i;
 	struct phm_acp_clock_voltage_dependency_table *acp_table;
 
-	table_size = sizeof(unsigned long) +
-		sizeof(struct phm_acp_clock_voltage_dependency_table) *
-		table->numEntries;
-
-	acp_table = kzalloc(table_size, GFP_KERNEL);
-	if (NULL == acp_table)
+	acp_table = kzalloc(struct_size(acp_table, entries, table->numEntries),
+			    GFP_KERNEL);
+	if (!acp_table)
 		return -ENOMEM;
 
 	acp_table->count = (unsigned long)table->numEntries;
-- 
2.27.0

