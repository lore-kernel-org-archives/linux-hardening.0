Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB6C4363A
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AC321897
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602166664;
	bh=MImyq1wxf3lrgX+9kVfU/J30BpQJG8VyoFD/jCQpp4Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SEWC2wvpbbQtELYn7PgNg3zgCf+vVV4qBsSZMAR3MT4ZIYDNXCpYtEldQHEpgGoJD
	 u0s8IyGmq/Tpne+t2ADZkojL14Gd7FhD1V8jsNbtgaNLXt9rmw1O5TUl7/FAmimaoJ
	 kxNEVulms4mqqB+LTvHOGiaO8z5AODpwEJktOh7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgJHORo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgJHORo (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 10:17:44 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7183D206A1;
        Thu,  8 Oct 2020 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602166663;
        bh=MImyq1wxf3lrgX+9kVfU/J30BpQJG8VyoFD/jCQpp4Y=;
        h=Date:From:To:Cc:Subject:From;
        b=y10zNBEl2wXkYIoHHccmF/fAiQLyXYJCe1h6wXenprlpUAgwpqfrSWcRAWSxzmTLB
         LDpASH5w/Ie6+4OlweIcnJe8/AnBaAviMAchas8i9qInXaj6N7m+iqvBDRQWZKFVLt
         PI3TdEYU5rTuK5t2QoTedaG0pwQj0IRSKpGVpsqI=
Date:   Thu, 8 Oct 2020 09:23:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Use struct_size() helper in kmalloc()
Message-ID: <20201008142305.GA21249@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the new struct_size() helper instead of the offsetof() idiom.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5da487b64a66..30192dce7775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -239,8 +239,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 	if (!old)
 		return 0;
 
-	new = kmalloc(offsetof(typeof(*new), shared[old->shared_max]),
-		      GFP_KERNEL);
+	new = kmalloc(struct_size(new, shared, old->shared_max), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
-- 
2.27.0

