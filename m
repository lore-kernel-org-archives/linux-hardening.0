Return-Path: <SRS0=98sU=D4=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14FC55178
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81E820BED
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="AdjL7C8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444002AbgJUPGc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:06:32 -0400
Received: from confino.investici.org ([212.103.72.250]:63093 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443805AbgJUPGc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Oct 2020 11:06:32 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CGYjg0pJPz12jv;
        Wed, 21 Oct 2020 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603292791;
        bh=5wppvNi8rWwL0GiLeaJomvPTyeE6KiCIx2cerD7Nook=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdjL7C8Ezi5eAxC568/k9xe6esQdypyIVQscIe6cq5KLkjde8kj1exZEsBviUV+na
         zlUG1/GIzi3TIn+ZZUCgfgYiCM/AtIvE8TmzLXLucnEOU+bjfifTGVgunwGJTdLPHD
         80W5BlzxZb8ZiWdpmoweJnGzGCSlAFvgLiIUpubc=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CGYjf742Tz12js;
        Wed, 21 Oct 2020 15:06:30 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v3 5/5] Correct wrong filenames in comment.
Date:   Wed, 21 Oct 2020 17:06:08 +0200
Message-Id: <20201021150608.16469-6-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

In lkdtm.h, files targeted in comments are name "lkdtm_file.c" while there are
named "file.c" in directory.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/misc/lkdtm/lkdtm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 29c12dcdeab1..1f7521f60565 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -6,7 +6,7 @@
 
 #include <linux/kernel.h>
 
-/* lkdtm_bugs.c */
+/* bugs.c */
 void __init lkdtm_bugs_init(int *recur_param);
 void lkdtm_PANIC(void);
 void lkdtm_BUG(void);
@@ -36,7 +36,7 @@ void lkdtm_CORRUPT_PAC(void);
 void lkdtm_FORTIFY_OBJECT(void);
 void lkdtm_FORTIFY_SUBOBJECT(void);
 
-/* lkdtm_heap.c */
+/* heap.c */
 void __init lkdtm_heap_init(void);
 void __exit lkdtm_heap_exit(void);
 void lkdtm_OVERWRITE_ALLOCATION(void);
@@ -48,7 +48,7 @@ void lkdtm_SLAB_FREE_DOUBLE(void);
 void lkdtm_SLAB_FREE_CROSS(void);
 void lkdtm_SLAB_FREE_PAGE(void);
 
-/* lkdtm_perms.c */
+/* perms.c */
 void __init lkdtm_perms_init(void);
 void lkdtm_WRITE_RO(void);
 void lkdtm_WRITE_RO_AFTER_INIT(void);
@@ -63,7 +63,7 @@ void lkdtm_EXEC_NULL(void);
 void lkdtm_ACCESS_USERSPACE(void);
 void lkdtm_ACCESS_NULL(void);
 
-/* lkdtm_refcount.c */
+/* refcount.c */
 void lkdtm_REFCOUNT_INC_OVERFLOW(void);
 void lkdtm_REFCOUNT_ADD_OVERFLOW(void);
 void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void);
@@ -84,10 +84,10 @@ void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void);
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
@@ -100,7 +100,7 @@ void lkdtm_USERCOPY_STACK_BEYOND(void);
 void lkdtm_USERCOPY_KERNEL(void);
 void lkdtm_USERCOPY_KERNEL_DS(void);
 
-/* lkdtm_stackleak.c */
+/* stackleak.c */
 void lkdtm_STACKLEAK_ERASING(void);
 
 /* cfi.c */
-- 
2.20.1

