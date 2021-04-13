Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76FC433ED
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Apr 2021 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18234613C4
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Apr 2021 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhDMTyY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhDMTyV (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Apr 2021 15:54:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59B5D613B1;
        Tue, 13 Apr 2021 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618343641;
        bh=aQ0sL/CtSIpmqSH+Y8uXo9Dlmv+4Dn7h4gts/aYLS0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=ashQWDCNaUuDS2zXVNRMUkGpM6HVQrcbYTKAcRIaXm1Fh4slwpuvuPPvTyq8Hwugv
         7b0Io+RETbDsjMb0pCxmWVfgBsqmvsO/xvlpd4OJMBzi3DpHnSWlZttNzMswUO7n4g
         LIpdvvuRQdqvPH1PL8FLBrwOK89XjDvLe5wYC2FYuTQpe4NCWudhEkmlKLND+4dmX6
         bkX033gOCyuxs3uXecqylb8jWB0hglDS32HeN4dW0CA56YTro6jjEdej/sURztlzJL
         O9V9lin5B1Y2qamg9MJywPUmDpRn7i4+X59RpfeMgI24tO5Pq7rlRn0v9vU2GYmJa0
         XfVkUHQJymfjg==
Date:   Tue, 13 Apr 2021 14:54:09 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
Message-ID: <20210413195409.GA322376@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Replace call to memcpy() with just a couple of simple assignments in
order to fix the following out-of-bounds warning:

drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]

The problem is that the original code is trying to copy data into a
couple of struct members adjacent to each other in a single call to
memcpy(). This causes a legitimate compiler warning because memcpy()
overruns the length of &desc.qw2.

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iommu/intel/svm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5165cea90421..65909f504c50 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1194,9 +1194,10 @@ int intel_svm_page_response(struct device *dev,
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

