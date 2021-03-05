Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8299BC433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4864C65011
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEIQU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCEIQT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 03:16:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4FA965014;
        Fri,  5 Mar 2021 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614932179;
        bh=t1cng2jl4iyc5DF35ZB4YuDSPYVo2bYVbHiZ7KKk+OQ=;
        h=Date:From:To:Cc:Subject:From;
        b=F/YKqPHxRMQ+1zHcBYGg0itcKDEpyLqAjcTMxv8MqjvZuBSCnAskyHmDWupKB1vqT
         sERqXEvfZHRq5lAjySHIVDYrIOkmRWxHUoinujM/FF+KsZi6P9O38STrSTFT0veGkF
         ThZPMVmDrfcdH4GT2ElxdTY/ARC3fe2cY9Zf2wBFBNH7Tew0ENZnqTkME9YqQMyUVx
         S/Ev2A4OJG8XFiJ1WniSjOJejeXfVK0QlTf2Vj8Mte8kvJPA80ST2akU9imbXzjiPf
         1GEMQvqmy67cjDBpU9I6csLRwUCuFVuInFDlY72lmSR27DU6K4rPx/BQU9T2J5e3/K
         uoEsYnp57vgRQ==
Date:   Fri, 5 Mar 2021 02:16:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] ubi: Fix fall-through warnings for Clang
Message-ID: <20210305081616.GA136956@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough pseudo-keyword instead of letting the
code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
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

