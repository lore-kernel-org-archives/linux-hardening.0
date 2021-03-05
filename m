Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC797C433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F43565018
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCEI0F (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCEI0C (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 03:26:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C09165014;
        Fri,  5 Mar 2021 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932762;
        bh=8kCER71SB1n8leoU2EokvztmF4jGpV7K4ZN1wSNRgdY=;
        h=Date:From:To:Cc:Subject:From;
        b=jATUPn7IhyWdnarY212YsfhDcdb7T5CObxeJPOXvyC1quwn2QrzKatXWTeoyLh1Bo
         1oXI+VqiVs/cNHaFRuZgwUHsvlRjOm+9efhQFV6HXLgf1kbD09mKeyUv0h4tI2As/D
         5M41oqOi+RWWO6aiGgeuz3Pk5IPQbCsj2M3rnsULCrJvXmoaG/nyByH4NCZowJGu/F
         C8SPoM7nM9PG/1esGPMcysWFF0HfN1mtXTWtKoV4z3tTwEzc5uJCTbsOF+QOM+uz1L
         niCFLhYyAZAdmg4xSQ+tr8vhCyyM1vb1ZkZtIvlymwfVV3COF0Yq+anFOYo7GCgYVy
         YBvh0OaxI2YCQ==
Date:   Fri, 5 Mar 2021 02:25:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] mtd: rawnand: fsmc: Fix fall-through warnings
 for Clang
Message-ID: <20210305082559.GA137646@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index a24e2f57fa68..bf695255b43a 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -930,6 +930,7 @@ static int fsmc_nand_attach_chip(struct nand_chip *nand)
 				 "Using 4-bit SW BCH ECC scheme\n");
 			break;
 		}
+		break;
 
 	case NAND_ECC_ENGINE_TYPE_ON_DIE:
 		break;
-- 
2.27.0

