Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E2AC64E90
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3602242B
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBHzvXnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgKTShT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbgKTShS (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:18 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E2924124;
        Fri, 20 Nov 2020 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897437;
        bh=4tcQynLBYFF8R4IvD4h1vdRVG+jt6uczJrx4L0hagCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBHzvXnEsolriOEVZm+ZBZhfDdnNg5ZkjvjWMsENYLULfj5NkfZFWEDJBvqnHnYrb
         /0oW/MHBDqMUoQSVBjPwtbB7DCdQV3BFeSEohvzHj+NOet82XwE/UCFCHfkXAMIFYN
         Y1BMeP40udfBZij9lL/BoaUCVfOkqtYVPvRFPtnY=
Date:   Fri, 20 Nov 2020 12:37:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 100/141] mtd: cfi: Fix fall-through warnings for Clang
Message-ID: <72b76d0aaa1bf1c5d55914c2ab330ac2c95fc629.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements and a return
instead of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 1 +
 drivers/mtd/chips/cfi_cmdset_0002.c | 2 ++
 drivers/mtd/chips/cfi_cmdset_0020.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 42001c49833b..b7f5e7977dcd 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -2549,6 +2549,7 @@ static int cfi_intelext_suspend(struct mtd_info *mtd)
 			   anyway? The latter for now. */
 			printk(KERN_NOTICE "Flash device refused suspend due to active operation (state %d)\n", chip->state);
 			ret = -EAGAIN;
+			break;
 		case FL_PM_SUSPENDED:
 			break;
 		}
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index a1f3e1031c3d..6f6b0265c22d 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -902,6 +902,7 @@ static int get_chip(struct map_info *map, struct flchip *chip, unsigned long adr
 			/* Someone else might have been playing with it. */
 			goto retry;
 		}
+		return 0;
 
 	case FL_READY:
 	case FL_CFI_QUERY:
@@ -2994,6 +2995,7 @@ static int cfi_amdstd_suspend(struct mtd_info *mtd)
 			 * as the whole point is that nobody can do anything
 			 * with the chip now anyway.
 			 */
+			break;
 		case FL_PM_SUSPENDED:
 			break;
 
diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index 270322bca221..d35df526e0a6 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -1332,6 +1332,8 @@ static int cfi_staa_suspend(struct mtd_info *mtd)
 			 * as the whole point is that nobody can do anything
 			 * with the chip now anyway.
 			 */
+			break;
+
 		case FL_PM_SUSPENDED:
 			break;
 
-- 
2.27.0

