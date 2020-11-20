Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB5C71156
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E528724124
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2qnWWDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgKTShX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbgKTShX (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:23 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A4224124;
        Fri, 20 Nov 2020 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897442;
        bh=6N5FCjGIpvdfkyPYHiRGAUpmmlmMXiVF8o1zCi8P9nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2qnWWDx9RRGjQh4PkbaxsbGrx7YXSDM1ttk13WOB64/oSB92GUk2uZlGbKOG87Ub
         Vct7YbXzinFtc319fG8VB6V6s/2GCxITtSSRmyPv9diabxJUWYJFR8qjGwHVCp5Oam
         Lk5LvdD4+WXpL0wiMyGvEu18ARfyxZqUuGpgPI+0=
Date:   Fri, 20 Nov 2020 12:37:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 101/141] mtd: mtdchar: Fix fall-through warnings for Clang
Message-ID: <0b0268d7cced9266f16e7dab8c7e881bb52c22f0.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
index b40f46a43fc6..a306659ea683 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -993,6 +993,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 			if (!mtd_has_oob(mtd))
 				return -EOPNOTSUPP;
 			mfi->mode = arg;
+			break;
 
 		case MTD_FILE_MODE_NORMAL:
 			break;
-- 
2.27.0

