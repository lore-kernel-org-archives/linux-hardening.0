Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A982C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 02:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6122E611CC
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 02:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhIKCak (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCaj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 22:30:39 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A43C061574
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 19:29:27 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4H5xX5662jzQk95;
        Sat, 11 Sep 2021 04:29:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   "Christopher M. Riedl" <cmr@bluescreens.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-hardening@vger.kernel.org
Subject: [PATCH v6 3/4] powerpc: Use WARN_ON and fix check in poking_init
Date:   Fri, 10 Sep 2021 21:29:03 -0500
Message-Id: <20210911022904.30962-4-cmr@bluescreens.de>
In-Reply-To: <20210911022904.30962-1-cmr@bluescreens.de>
References: <20210911022904.30962-1-cmr@bluescreens.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DE9826E
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The latest kernel docs list BUG_ON() as 'deprecated' and that they
should be replaced with WARN_ON() (or pr_warn()) when possible. The
BUG_ON() in poking_init() warrants a WARN_ON() rather than a pr_warn()
since the error condition is deemed "unreachable".

Also take this opportunity to fix the failure check in the WARN_ON():
cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, ...) returns a positive integer
on success and a negative integer on failure.

Signed-off-by: Christopher M. Riedl <cmr@bluescreens.de>

---

v6:  * New to series - based on Christophe's relentless feedback in the
       crusade against BUG_ON()s :)
---
 arch/powerpc/lib/code-patching.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 8d0bb86125d5..e802e42c2789 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -126,16 +126,11 @@ static int text_area_cpu_down(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Although BUG_ON() is rude, in this case it should only happen if ENOMEM, and
- * we judge it as being preferable to a kernel that will crash later when
- * someone tries to use patch_instruction().
- */
 void __init poking_init(void)
 {
-	BUG_ON(!cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+	WARN_ON(cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 		"powerpc/text_poke:online", text_area_cpu_up,
-		text_area_cpu_down));
+		text_area_cpu_down) < 0);
 }
 
 /*
-- 
2.32.0

