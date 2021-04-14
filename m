Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB0C433B4
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Apr 2021 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D5761164
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Apr 2021 20:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbhDNUOQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Apr 2021 16:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348186AbhDNUOO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Apr 2021 16:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4FBF61177;
        Wed, 14 Apr 2021 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618431232;
        bh=pjYXcJSJfnY3qBJHkeakI7NfbOgpLhAxUI1E81NIjo8=;
        h=Date:From:To:Cc:Subject:From;
        b=hLv3Ib10bDmBqFSKlEZPpNJezJ0auMwkgvRwCY69qwsJZZrMfYubt9nR3sPB2RdiC
         OD0xYvbOZrb1yyXmE2TV+bRyhSHixzd0RY/Kv86yi6XM+eWC/RnuaYLtB/nHnacIIb
         cMnp8SLoMASnI1D4A5Ry6Dd8WNLwvoqP2RGC2TUD+9n6wjzFJfxbzGlGIcp550/tAZ
         NNejaTj/mykj4n9EZB+bei0FCt4r3QrIMzpV5FXZJ9hVVWlO9h4h8391W0dkQ0yhP1
         afDjvWy6bw4pCeUpnJh6KgJTt19fuKcBy7AO/OpXIOQu8B3NyC5ewUYDNrvkrlvbKi
         ru7dWmfnXZtNA==
Date:   Wed, 14 Apr 2021 15:14:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
Message-ID: <20210414201403.GA392764@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Replace a couple of calls to memcpy() with simple assignments in order
to fix the following out-of-bounds warning:

drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]

The problem is that the original code is trying to copy data into a
couple of struct members adjacent to each other in a single call to
memcpy(). This causes a legitimate compiler warning because memcpy()
overruns the length of &desc.qw2 and &resp.qw2, respectively.

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Fix another instance of this same issue in prq_event_thread().

 drivers/iommu/intel/svm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5165cea90421..332365ec3195 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1020,9 +1020,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			resp.qw2 = 0;
 			resp.qw3 = 0;
 
-			if (req->priv_data_present)
-				memcpy(&resp.qw2, req->priv_data,
-				       sizeof(req->priv_data));
+			if (req->priv_data_present) {
+				resp.qw2 = req->priv_data[0];
+				resp.qw3 = req->priv_data[1];
+			}
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
 prq_advance:
@@ -1194,9 +1195,10 @@ int intel_svm_page_response(struct device *dev,
 		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
 		desc.qw2 = 0;
 		desc.qw3 = 0;
-		if (private_present)
-			memcpy(&desc.qw2, prm->private_data,
-			       sizeof(prm->private_data));
+		if (private_present) {
+			desc.qw2 = prm->private_data[0];
+			desc.qw3 = prm->private_data[1];
+		}
 
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
-- 
2.27.0

