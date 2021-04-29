Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13092C433ED
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Apr 2021 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFABA6144E
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Apr 2021 07:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhD2Hb5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Hbz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Apr 2021 03:31:55 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Apr 2021 00:31:08 PDT
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:1::465:209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F168CC06138B
        for <linux-hardening@vger.kernel.org>; Thu, 29 Apr 2021 00:31:08 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4FW6PS25tRzQjnf;
        Thu, 29 Apr 2021 09:21:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id NN2a4URMhZGs; Thu, 29 Apr 2021 09:21:29 +0200 (CEST)
From:   "Christopher M. Riedl" <cmr@bluescreens.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, keescook@chromium.org
Subject: [PATCH v4 04/11] lkdtm/x86_64: Add test to hijack a patch mapping
Date:   Thu, 29 Apr 2021 02:20:50 -0500
Message-Id: <20210429072057.8870-5-cmr@bluescreens.de>
In-Reply-To: <20210429072057.8870-1-cmr@bluescreens.de>
References: <20210429072057.8870-1-cmr@bluescreens.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 1.26 / 15.00 / 15.00
X-Rspamd-Queue-Id: 519EF17E8
X-Rspamd-UID: c86d02
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

A previous commit implemented an LKDTM test on powerpc to exploit the
temporary mapping established when patching code with STRICT_KERNEL_RWX
enabled. Extend the test to work on x86_64 as well.

Signed-off-by: Christopher M. Riedl <cmr@bluescreens.de>
---
 drivers/misc/lkdtm/perms.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index c6f96ebffccfd..55c3bec6d3b72 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -224,7 +224,7 @@ void lkdtm_ACCESS_NULL(void)
 }
 
 #if (IS_BUILTIN(CONFIG_LKDTM) && defined(CONFIG_STRICT_KERNEL_RWX) && \
-	defined(CONFIG_PPC))
+	(defined(CONFIG_PPC) || defined(CONFIG_X86_64)))
 /*
  * This is just a dummy location to patch-over.
  */
@@ -233,28 +233,51 @@ static void patching_target(void)
 	return;
 }
 
+#ifdef CONFIG_PPC
 #include <asm/code-patching.h>
 struct ppc_inst * const patch_site = (struct ppc_inst *)&patching_target;
+#endif
+
+#ifdef CONFIG_X86_64
+#include <asm/text-patching.h>
+u32 * const patch_site = (u32 *)&patching_target;
+#endif
 
 static inline int lkdtm_do_patch(u32 data)
 {
+#ifdef CONFIG_PPC
 	return patch_instruction(patch_site, ppc_inst(data));
+#endif
+#ifdef CONFIG_X86_64
+	text_poke(patch_site, &data, sizeof(u32));
+	return 0;
+#endif
 }
 
 static inline u32 lkdtm_read_patch_site(void)
 {
+#ifdef CONFIG_PPC
 	struct ppc_inst inst = READ_ONCE(*patch_site);
 	return ppc_inst_val(ppc_inst_read(&inst));
+#endif
+#ifdef CONFIG_X86_64
+	return READ_ONCE(*patch_site);
+#endif
 }
 
 /* Returns True if the write succeeds */
 static inline bool lkdtm_try_write(u32 data, u32 *addr)
 {
+#ifdef CONFIG_PPC
 	__put_kernel_nofault(addr, &data, u32, err);
 	return true;
 
 err:
 	return false;
+#endif
+#ifdef CONFIG_X86_64
+	return !__put_user(data, addr);
+#endif
 }
 
 static int lkdtm_patching_cpu(void *data)
@@ -347,8 +370,8 @@ void lkdtm_HIJACK_PATCH(void)
 
 void lkdtm_HIJACK_PATCH(void)
 {
-	if (!IS_ENABLED(CONFIG_PPC))
-		pr_err("XFAIL: this test only runs on powerpc\n");
+	if (!IS_ENABLED(CONFIG_PPC) && !IS_ENABLED(CONFIG_X86_64))
+		pr_err("XFAIL: this test only runs on powerpc and x86_64\n");
 	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
 		pr_err("XFAIL: this test requires CONFIG_STRICT_KERNEL_RWX\n");
 	if (!IS_BUILTIN(CONFIG_LKDTM))
-- 
2.26.1

