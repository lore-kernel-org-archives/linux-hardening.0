Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F6C433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974C165011
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEI2x (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhCEI2f (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 03:28:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61E3D64DCE;
        Fri,  5 Mar 2021 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932915;
        bh=d2yIkPOp3EpBCDhbDKuigF1lskG1wpuFHvgwfi1+Olk=;
        h=Date:From:To:Cc:Subject:From;
        b=MJ4gEx3OpgHoWnjpm+LLhkQoztvJ4dNQ0FIl4X4IP3p0MxWny0fC52tSsXdF+vzS7
         666gt3UNL3qt1sB5lzwGeAkpZiuC9RLgigYfT26qmUS8yAACbR0hqvzIzg2Ja6vbO/
         HPrKpXSm8Txwg1eqhk1lbg5hrJpSeICFP89uaa7mAZQ9wb/dDxjaqbxKjT3ENzLBXh
         5bCxqO8eodYmLA+K3f97Mtt8BxImUj8bdRZnk2KFAy6tdRfGm5v7f52FRrXxANl9KQ
         HyPu8VDqzKmV8fLgbvcVYS92dIds9KVhTsqer55Rrb9Mk8bSlY3TXsYDTUmn1X0cTe
         aiawgkA+UICnw==
Date:   Fri, 5 Mar 2021 02:28:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] ubi: Fix fall-through warnings for Clang
Message-ID: <20210305082832.GA137724@embeddedor>
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
Changes in v3:
 Update the changelog text according to the actual code change.

Changes in v2:
 Make use of a break statement instead of fallthrough, for consistency.
 Link: https://lore.kernel.org/lkml/20201123093347.719a77cf@xps13/

 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index f399edc82191..a7e3eb9befb6 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1350,6 +1350,7 @@ static int bytes_str_to_int(const char *str)
 		fallthrough;
 	case 'K':
 		result *= 1024;
+		break;
 	case '\0':
 		break;
 	default:
-- 
2.27.0

