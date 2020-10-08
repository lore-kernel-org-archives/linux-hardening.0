Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B907C4363A
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C847021D46
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602167368;
	bh=PF2rwC0QLEQYvjrSX4RIAM+DdcwHknxwU75KanQA0Kw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jV0W7VMSYt4sJkA3+u59/aU/z68GaWxNBdzDzj2qACBFnGDcu4/VeYfpDTIyOBJWR
	 ozmBDS9+ilenx8HCFUwtMb4uIXkAO4CfTFvcyb4l/wtpOj4uA1BsikleXz/fsloilO
	 uj/WFh9KF1kSrQjCgKgqWemyN6mr5zqoMaJOZiDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgJHO32 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730508AbgJHO32 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 10:29:28 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E32B121927;
        Thu,  8 Oct 2020 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602167368;
        bh=PF2rwC0QLEQYvjrSX4RIAM+DdcwHknxwU75KanQA0Kw=;
        h=Date:From:To:Cc:Subject:From;
        b=leCaKhQppEgiF0p9DKJJ63LgXV099VzZwcF9FrPkO55rnavjSA+GC26sAVzEAYTE2
         0X6Mr6cdJInQIGFs0drk9VvvU1ulYyKj4uf12HMwK2WE5CxyeDZ4/s18MddT5HZfDD
         Q7PyjDCFVS0VE9wpqxlaLIAuIUAj+VI/7lUXMcJU=
Date:   Thu, 8 Oct 2020 09:34:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] amd/amdgpu_ctx: Use struct_size() helper and kmalloc()
Message-ID: <20201008143450.GA23077@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the new struct_size() helper instead of the offsetof() idiom.
Also, use kmalloc() instead of kcalloc().

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c80d8339f58c..5be125f3b92a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -100,7 +100,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	enum drm_sched_priority priority;
 	int r;
 
-	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
+	entity = kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
 			 GFP_KERNEL);
 	if (!entity)
 		return  -ENOMEM;
-- 
2.27.0

