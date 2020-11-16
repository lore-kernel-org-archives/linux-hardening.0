Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CABC4742C
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Nov 2020 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301F122447
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Nov 2020 14:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="UGZldpm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgKPOuj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:50:39 -0500
Received: from devianza.investici.org ([198.167.222.108]:26963 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbgKPOuj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Nov 2020 09:50:39 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CZX7K43lLz6vMd;
        Mon, 16 Nov 2020 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605538237;
        bh=v2/DaV8STEEMs9x+B77A7l6psuLVf/YLdYQGCG8Qjcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGZldpm2HcciQOQQQzd4+if+mmKbJc7wDGKK5HkI+N/Z1o7F9DfkZ5HmKK6Ci2f6e
         OOIBMTQ5hjTK5vRMu/hgLXqWSA81suaf4jVb4S0JmUuq/Yu395j4IM2OV9MlmuvA9S
         ys6P0Yzgz8plB9+PZPCbVC2Fs+7USXFA2GJAlDxU=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CZX7K2JVYz6vMX;
        Mon, 16 Nov 2020 14:50:37 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, keescook@chromium.org
Subject: [PATCH v4 2/5] lkdtm: tests for FORTIFY_SOURCE
Date:   Mon, 16 Nov 2020 15:50:09 +0100
Message-Id: <20201116145012.24471-3-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
References: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

Add code to test both:

 - runtime detection of the overrun of a structure. This covers the
   __builtin_object_size(x, 0) case. This test is called FORTIFY_OBJECT.

 - runtime detection of the overrun of a char array within a structure.
   This covers the __builtin_object_size(x, 1) case which can be used
   for some string functions. This test is called FORTIFY_SUBOBJECT.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/lkdtm/bugs.c  | 50 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  2 ++
 drivers/misc/lkdtm/lkdtm.h |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index a0675d4154d2..110f5a8538e9 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -482,3 +482,53 @@ noinline void lkdtm_CORRUPT_PAC(void)
 	pr_err("XFAIL: this test is arm64-only\n");
 #endif
 }
+
+void lkdtm_FORTIFY_OBJECT(void)
+{
+	struct target {
+		char a[10];
+	} target[2] = {};
+	int result;
+
+	/*
+	 * Using volatile prevents the compiler from determining the value of
+	 * 'size' at compile time. Without that, we would get a compile error
+	 * rather than a runtime error.
+	 */
+	volatile int size = 11;
+
+	pr_info("trying to read past the end of a struct\n");
+
+	result = memcmp(&target[0], &target[1], size);
+
+	/* Print result to prevent the code from being eliminated */
+	pr_err("FAIL: fortify did not catch an object overread!\n"
+	       "\"%d\" was the memcmp result.\n", result);
+}
+
+void lkdtm_FORTIFY_SUBOBJECT(void)
+{
+	struct target {
+		char a[10];
+		char b[10];
+	} target;
+	char *src;
+
+	src = kmalloc(20, GFP_KERNEL);
+	strscpy(src, "over ten bytes", 20);
+
+	pr_info("trying to strcpy past the end of a member of a struct\n");
+
+	/*
+	 * strncpy(target.a, src, 20); will hit a compile error because the
+	 * compiler knows at build time that target.a < 20 bytes. Use strcpy()
+	 * to force a runtime error.
+	 */
+	strcpy(target.a, src);
+
+	/* Use target.a to prevent the code from being eliminated */
+	pr_err("FAIL: fortify did not catch an sub-object overrun!\n"
+	       "\"%s\" was copied.\n", target.a);
+
+	kfree(src);
+}
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 97803f213d9d..b8c51a633fcc 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -117,6 +117,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(UNSET_SMEP),
 	CRASHTYPE(CORRUPT_PAC),
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
+	CRASHTYPE(FORTIFY_OBJECT),
+	CRASHTYPE(FORTIFY_SUBOBJECT),
 	CRASHTYPE(OVERWRITE_ALLOCATION),
 	CRASHTYPE(WRITE_AFTER_FREE),
 	CRASHTYPE(READ_AFTER_FREE),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 6dec4c9b442f..49e6b945feb7 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -32,6 +32,8 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
 void lkdtm_DOUBLE_FAULT(void);
 void lkdtm_CORRUPT_PAC(void);
+void lkdtm_FORTIFY_OBJECT(void);
+void lkdtm_FORTIFY_SUBOBJECT(void);
 
 /* lkdtm_heap.c */
 void __init lkdtm_heap_init(void);
-- 
2.20.1

