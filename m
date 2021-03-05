Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62FEC433E6
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C88665025
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEIWw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhCEIW1 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 03:22:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AFF364D74;
        Fri,  5 Mar 2021 08:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932546;
        bh=Vfm/3xKY58u7in+dQGJX80A4aCCKvonFzzMRt83pjsE=;
        h=Date:From:To:Cc:Subject:From;
        b=E82kKsDg5yjDRMd7HE3tnw1X8caSFXjwBZnkPxrrBaPUSSQR9zlAE0+odFDlg0O7q
         ZZcXzYV17/vIOtgUuGogMw0LAMOn+r+16bBRj4X0FdP6DUNSGIBBVgPEvcpUVwV4GR
         WOsmtvVn7iCAPHhLlpO4Sczz1xY/YvPtWlTFEfL0hmz3VpGnt0YPZQWgqWBbKvlfqa
         cpbWOysxfBD0foxRW7vInQac1tW07RoN6dG7fEcxIpU0hIJPrMJEF62dEGeGGHkO67
         Xde72yErDWkA1MaJ9lnV+2GBN6OBTjQLCXtsqiKd11vgpiCLbaAKf+JAQ7eDkvHQpY
         5rqu3J244d04g==
Date:   Fri, 5 Mar 2021 02:22:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] mtd: mtdchar: Fix fall-through warnings for
 Clang
Message-ID: <20210305082224.GA137360@embeddedor>
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
 drivers/mtd/mtdchar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 57c4a2f0b703..998d86f46488 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -983,6 +983,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 			if (!mtd_has_oob(mtd))
 				return -EOPNOTSUPP;
 			mfi->mode = arg;
+			break;
 
 		case MTD_FILE_MODE_NORMAL:
 			break;
-- 
2.27.0

