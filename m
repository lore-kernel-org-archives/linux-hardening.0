Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E5EC63777
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 11:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52145238E6
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 11:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="mMgCOAbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKRLH7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgKRLH6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Nov 2020 06:07:58 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6140C0613D4
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2020 03:07:58 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4Cbg5T4cCyz8shP;
        Wed, 18 Nov 2020 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605697677;
        bh=/ovjSkkj+pP7zpXzoV2FaBY80rRmAkeAXTToEnVDEWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMgCOAbDjQ+yGDUHcYfa9kc9nDG2pwfSWDacKs/gYhxxw7jGSdwNFr6vnbLYR6EBz
         PrDr1/5L0eSxcTJ3jcwibtQ7ipw3xVF3O+FW3gq/hhy1XZmk43rLAsMm0Z5vBUUlHM
         mmeSUYZva9uKATjxFT7NNNTPHdi69npYBI0wVb/g=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Cbg5S686vz8sgF;
        Wed, 18 Nov 2020 11:07:56 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v5 5/5] Correct wrong filenames in comment.
Date:   Wed, 18 Nov 2020 12:07:31 +0100
Message-Id: <20201118110731.15833-6-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
References: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

In lkdtm.h, files targeted in comments are named "lkdtm_file.c" while there are
named "file.c" in directory.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/lkdtm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 138f06254b61..6aa6d6a1a839 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -6,7 +6,7 @@
 
 #include <linux/kernel.h>
 
-/* lkdtm_bugs.c */
+/* bugs.c */
 void __init lkdtm_bugs_init(int *recur_param);
 void lkdtm_PANIC(void);
 void lkdtm_BUG(void);
@@ -35,7 +35,7 @@ void lkdtm_CORRUPT_PAC(void);
 void lkdtm_FORTIFY_OBJECT(void);
 void lkdtm_FORTIFY_SUBOBJECT(void);
 
-/* lkdtm_heap.c */
+/* heap.c */
 void __init lkdtm_heap_init(void);
 void __exit lkdtm_heap_exit(void);
 void lkdtm_OVERWRITE_ALLOCATION(void);
@@ -47,7 +47,7 @@ void lkdtm_SLAB_FREE_DOUBLE(void);
 void lkdtm_SLAB_FREE_CROSS(void);
 void lkdtm_SLAB_FREE_PAGE(void);
 
-/* lkdtm_perms.c */
+/* perms.c */
 void __init lkdtm_perms_init(void);
 void lkdtm_WRITE_RO(void);
 void lkdtm_WRITE_RO_AFTER_INIT(void);
@@ -62,7 +62,7 @@ void lkdtm_EXEC_NULL(void);
 void lkdtm_ACCESS_USERSPACE(void);
 void lkdtm_ACCESS_NULL(void);
 
-/* lkdtm_refcount.c */
+/* refcount.c */
 void lkdtm_REFCOUNT_INC_OVERFLOW(void);
 void lkdtm_REFCOUNT_ADD_OVERFLOW(void);
 void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void);
@@ -83,10 +83,10 @@ void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void);
 void lkdtm_REFCOUNT_TIMING(void);
 void lkdtm_ATOMIC_TIMING(void);
 
-/* lkdtm_rodata.c */
+/* rodata.c */
 void lkdtm_rodata_do_nothing(void);
 
-/* lkdtm_usercopy.c */
+/* usercopy.c */
 void __init lkdtm_usercopy_init(void);
 void __exit lkdtm_usercopy_exit(void);
 void lkdtm_USERCOPY_HEAP_SIZE_TO(void);
@@ -98,7 +98,7 @@ void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
 void lkdtm_USERCOPY_STACK_BEYOND(void);
 void lkdtm_USERCOPY_KERNEL(void);
 
-/* lkdtm_stackleak.c */
+/* stackleak.c */
 void lkdtm_STACKLEAK_ERASING(void);
 
 /* cfi.c */
-- 
2.20.1

