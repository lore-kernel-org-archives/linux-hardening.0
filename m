Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC8C64E8A
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFF022470
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPe4qsAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgKTSeU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbgKTSeT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:34:19 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E2824124;
        Fri, 20 Nov 2020 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897258;
        bh=LkP90+IldsCEssBoMIIJIVEBsSJUZiiRjlMlCbMHCN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPe4qsAgFXUgT7198akCzbI0y12yn3yR0cBMoXgYFH41C8VproujatSpshDgo7xnI
         i8UgLUzKjSBLCTW/KUHzZaZiCcY/yTB30yJsvGBADbDIOE+mt0VfkoFj1AJC4SjjLA
         px/6W70asnHX+MG+9LtGPQLPVEm8o60CBFO4k3Ig=
Date:   Fri, 20 Nov 2020 12:34:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chas Williams <3chas3@gmail.com>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 070/141] atm: fore200e: Fix fall-through warnings for Clang
Message-ID: <613a064fad28ee2afbc14d9a81d4a67b3c1634f7.1605896059.git.gustavoars@kernel.org>
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
by explicitly adding a fallthrough pseudo-keyword.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/atm/fore200e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 9a70bee84125..ba3ed1b77bc5 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -423,6 +423,7 @@ fore200e_shutdown(struct fore200e* fore200e)
 	/* XXX shouldn't we *start* by deregistering the device? */
 	atm_dev_deregister(fore200e->atm_dev);
 
+	fallthrough;
     case FORE200E_STATE_BLANK:
 	/* nothing to do for that state */
 	break;
-- 
2.27.0

