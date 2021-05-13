Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B9C433B4
	for <linux-hardening@archiver.kernel.org>; Thu, 13 May 2021 23:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253E56143E
	for <linux-hardening@archiver.kernel.org>; Thu, 13 May 2021 23:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEMXCb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 May 2021 19:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhEMXC2 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 May 2021 19:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1742261363;
        Thu, 13 May 2021 23:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620946878;
        bh=uN3yahKzBwkB+gvkdxWGKQOVS3XTusPU7ZhMIZnGDxg=;
        h=Date:From:To:Cc:Subject:From;
        b=VhIteCOOz2hyzdB7KWnX31mJ/jwWRmgYODHNwr12yHXS7kFIq2eqOChX8N240WNJ9
         315412YAXRjUnOd+u6iJY3ZOFOe3sDRi3Er3CwHVDs/IjSay7rMU5RbWGhCI6RvioC
         k4bo1L2jS79wlkwd3hYKOohsE0B0BDhoj3HiRw75dAmJi0PjsNPMZVjti1crtUhETB
         MpJmv/8bbH7uMBVnvJC7wcso+wyu2meCdShKfHI0AIHMyGZQXDFcs1Mm7UOcGyWwV9
         MRfscd9E8SyuOMwV1hCCwaWb4vviuJQNcP725m3tod75sLU3QSJRABZoYZmWGK8g1N
         kuAKYNp6vkOww==
Date:   Thu, 13 May 2021 18:01:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] vfio/iommu_type1: Use struct_size() for kzalloc()
Message-ID: <20210513230155.GA217517@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows
that, in the worst scenario, could lead to heap overflows.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index a0747c35a778..a3e925a41b0d 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2795,7 +2795,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 		return 0;
 	}
 
-	size = sizeof(*cap_iovas) + (iovas * sizeof(*cap_iovas->iova_ranges));
+	size = struct_size(cap_iovas, iova_ranges, iovas);
 
 	cap_iovas = kzalloc(size, GFP_KERNEL);
 	if (!cap_iovas)
-- 
2.27.0

