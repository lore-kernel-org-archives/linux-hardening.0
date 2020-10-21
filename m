Return-Path: <SRS0=98sU=D4=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DACC388F9
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E0520BED
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 15:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="BkVWkDLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444001AbgJUPGa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443805AbgJUPGa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Oct 2020 11:06:30 -0400
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66985C0613CE
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2020 08:06:30 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CGYjd1Wxjz12jq;
        Wed, 21 Oct 2020 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603292789;
        bh=TxYAC9j0ASbKP643M9/2azNe1Lwy9RQE7h+DEvTSJhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkVWkDLIievt/u/1BmLvqXACuX3HQP+yHBbkOoGb2JA8jQzxKpP9shFqVqrZwYTlU
         1cqxoHAnHh7GFKnYBwPSPYaCCgGUu3oZXfu4gY7VKZVVAze+sZ9efHnOZMCQ3D/Jqu
         79aj+dHkGSk8mMXjgzCrzXl4vp97zY9BpmX6cXAk=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CGYjd0gBxz12jp;
        Wed, 21 Oct 2020 15:06:29 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC][PATCH v3 4/5] Add new file in LKDTM to test fortified strscpy.
Date:   Wed, 21 Oct 2020 17:06:07 +0200
Message-Id: <20201021150608.16469-5-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

This new test generates a crash at runtime because there is a write overflow in
destination string.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/core.c               |  1 +
 drivers/misc/lkdtm/fortify.c            | 47 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              |  3 ++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 5 files changed, 53 insertions(+)
 create mode 100644 drivers/misc/lkdtm/fortify.c

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..d898f7b22045 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -10,6 +10,7 @@ lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
+lkdtm-$(CONFIG_LKDTM)		+= fortify.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index a002f39a5964..4326e2d09870 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -180,6 +180,7 @@ static const struct crashtype crashtypes[] = {
 #ifdef CONFIG_X86_32
 	CRASHTYPE(DOUBLE_FAULT),
 #endif
+	CRASHTYPE(FORTIFIED_STRSCPY),
 };
 
 
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
new file mode 100644
index 000000000000..cecdfbb8ba55
--- /dev/null
+++ b/drivers/misc/lkdtm/fortify.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Francis Laniel <laniel_francis@privacyrequired.com>
+ *
+ * Add tests related to fortified functions in this file.
+ */
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "lkdtm.h"
+
+
+/*
+ * Calls fortified strscpy to test that it returns the same result as vanilla
+ * strscpy and generate a panic because there is a write overflow (i.e. src
+ * length is greater than dst length).
+ */
+void lkdtm_FORTIFIED_STRSCPY(void)
+{
+#if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
+	char *src;
+	char dst[3];
+
+	src = kstrdup("foobar", GFP_KERNEL);
+
+	if (src == NULL)
+		return;
+
+	/* Vanilla strscpy returns -E2BIG if size is 0. */
+	WARN_ON(strscpy(dst, src, 0) != -E2BIG);
+
+	/* Vanilla strscpy returns -E2BIG if src is truncated. */
+	WARN_ON(strscpy(dst, src, sizeof(dst)) != -E2BIG);
+
+	/* After above call, dst must contain "fo" because src was truncated. */
+	WARN_ON(strncmp(dst, "fo", sizeof(dst)) != 0);
+
+	/*
+	 * Use strlen here so size cannot be known at compile time and there is
+	 * a runtime overflow.
+	 */
+	strscpy(dst, src, strlen(src));
+
+	pr_info("Fail: No overflow in above strscpy call!\n");
+
+	kfree(src);
+#endif
+}
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 70c8b7c9460f..29c12dcdeab1 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -106,4 +106,7 @@ void lkdtm_STACKLEAK_ERASING(void);
 /* cfi.c */
 void lkdtm_CFI_FORWARD_PROTO(void);
 
+/* fortify.c */
+void lkdtm_FORTIFIED_STRSCPY(void);
+
 #endif
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 9d266e79c6a2..4234109579eb 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -70,3 +70,4 @@ USERCOPY_KERNEL
 USERCOPY_KERNEL_DS
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+FORTIFIED_STRSCPY
\ No newline at end of file
-- 
2.20.1

