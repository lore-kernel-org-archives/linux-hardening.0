Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE7C433E0
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Feb 2021 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAB964E33
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Feb 2021 08:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhBAIij (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Feb 2021 03:38:39 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:7647 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232572AbhBAIie (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Feb 2021 03:38:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNWr9V6_1612168662;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNWr9V6_1612168662)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 16:37:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     keescook@chromium.org
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] gcc-plugins: remove unneeded semicolon
Date:   Mon,  1 Feb 2021 16:37:39 +0800
Message-Id: <1612168659-33332-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Eliminate the following coccicheck warning:
./scripts/gcc-plugins/latent_entropy_plugin.c:527:2-3: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 scripts/gcc-plugins/latent_entropy_plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index 9dced66..589454b 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -524,7 +524,7 @@ static unsigned int latent_entropy_execute(void)
 	while (bb != EXIT_BLOCK_PTR_FOR_FN(cfun)) {
 		perturb_local_entropy(bb, local_entropy);
 		bb = bb->next_bb;
-	};
+	}
 
 	/* 4. mix local entropy into the global entropy variable */
 	perturb_latent_entropy(local_entropy);
-- 
1.8.3.1

