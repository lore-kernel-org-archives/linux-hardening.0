Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED62C41604
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E325C20789
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086416;
	bh=l3rN8L44AMXr0k7n8yBVUG4uvWHnJ/3s48bP7J/pDdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gd6vNf6PO/Zra/pfBj/i/EExJCpTdULL3Y0XVrAaC5NIzxUsPtzKWEbyIW0WIyUyo
	 Dg5bnZ+ycJDN//S3ntE0B0LXHFaCduHWOV5HEQMXlrlazPkUEolHPK9nhjf+hbiumL
	 b2s+xAaakTOiRam7CQ6Oo63nxPK9A3zCpO+UBb3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgJGQAP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgJGQAP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 12:00:15 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79C920789;
        Wed,  7 Oct 2020 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086414;
        bh=l3rN8L44AMXr0k7n8yBVUG4uvWHnJ/3s48bP7J/pDdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=futr1neV1dsv3jHdiLh1vpEzXiG5oXcmHbYybFfRUz0UPxrOsEWnZtrTEchFAHpMt
         xXypdeA5y1TSOM5hLcbs+4mhkmNkjQn3qbY6ZC3Q9pp7fyUUK1wxlagCkJRjPnPRtT
         4G86bvPmwJSjQjD8A3TPfTMGzNm6N6J9rPwdkiKU=
Date:   Wed, 7 Oct 2020 11:06:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 06/14] drm/amd/pm: Replace one-element array with
 flexible-array in struct phm_phase_shedding_limits_table
Message-ID: <c3584841a052b031fe9dd963b5d6effe65aae640.1602020074.git.gustavoars@kernel.org>
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
struct phm_phase_shedding_limits_table, instead of a one-element array,
and use the struct_size() helper to calculate the size for the allocation.

Also, save some heap space as the original code is multiplying
ptable->ucNumEntries by sizeof(struct phm_phase_shedding_limits_table)
when it should have multiplied it by sizeof(struct phm_phase_shedding_limits_record)
instead.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c5d36.6PStUZp2HRxAz7IM%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                   |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 361cb1125351..ad614e32079e 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -161,7 +161,7 @@ struct phm_vce_clock_voltage_dependency_record {
 
 struct phm_phase_shedding_limits_table {
 	uint32_t                           count;
-	struct phm_phase_shedding_limits_record  entries[1];
+	struct phm_phase_shedding_limits_record  entries[];
 };
 
 struct phm_vceclock_voltage_dependency_table {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index a1b198045978..b2ef76580c6a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1530,16 +1530,12 @@ static int init_phase_shedding_table(struct pp_hwmgr *hwmgr,
 				(((unsigned long)powerplay_table4) +
 				le16_to_cpu(powerplay_table4->usVddcPhaseShedLimitsTableOffset));
 			struct phm_phase_shedding_limits_table *table;
-			unsigned long size, i;
+			unsigned long i;
 
 
-			size = sizeof(unsigned long) +
-				(sizeof(struct phm_phase_shedding_limits_table) *
-				ptable->ucNumEntries);
-
-			table = kzalloc(size, GFP_KERNEL);
-
-			if (table == NULL)
+			table = kzalloc(struct_size(table, entries, ptable->ucNumEntries),
+					GFP_KERNEL);
+			if (!table)
 				return -ENOMEM;
 
 			table->count = (unsigned long)ptable->ucNumEntries;
-- 
2.27.0

