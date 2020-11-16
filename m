Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E57EC4742C
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Nov 2020 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B55220637
	for <linux-hardening@archiver.kernel.org>; Mon, 16 Nov 2020 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="Y8oipXKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgKPOup (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:50:45 -0500
Received: from devianza.investici.org ([198.167.222.108]:48875 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbgKPOun (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Nov 2020 09:50:43 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CZX7Q228dz6vMY;
        Mon, 16 Nov 2020 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605538242;
        bh=hS+AQpgkwkkJgmhCCSZivQzq6FA3XxLeOFmVBFod+gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8oipXKlN/8+X+iceIJ0Wt/12IY/xxMjqZeKbafG91QyyvrACFA2hh2H7IksUy+xN
         th/tx8H09xAvQESrGNLYZDY1cKjXdgjySi9IDFy3uxypojAZrCtahaSC8OvT49wHxb
         SVknJJoCIcKCyUC3VYPWcHMHrjzqG6Y3iXmVIaoY=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CZX7P70tQz6vMX;
        Mon, 16 Nov 2020 14:50:41 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-hardening@vger.kernel.org
Cc:     dja@axtens.net, keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC PATCH v4 4/5] Add new file in LKDTM to test fortified strscpy.
Date:   Mon, 16 Nov 2020 15:50:11 +0100
Message-Id: <20201116145012.24471-5-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
References: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

This new test ensures that fortified strscpy has the same behavior than vanilla
strscpy (e.g. returning -E2BIG when src content is truncated).
Finally, it generates a crash at runtime because there is a write overflow in
destination string.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/core.c               |  1 +
 drivers/misc/lkdtm/fortify.c            | 82 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              |  3 +
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 5 files changed, 88 insertions(+)
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
index b8c51a633fcc..3c0a67f072c0 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -175,6 +175,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
+	CRASHTYPE(FORTIFIED_STRSCPY),
 #ifdef CONFIG_X86_32
 	CRASHTYPE(DOUBLE_FAULT),
 #endif
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
new file mode 100644
index 000000000000..790d46591bf5
--- /dev/null
+++ b/drivers/misc/lkdtm/fortify.c
@@ -0,0 +1,82 @@
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
+	char *src;
+	char dst[5];
+
+	struct {
+		union {
+			char big[10];
+			char src[5];
+		};
+	} weird = { .big = "hello!" };
+	char weird_dst[sizeof(weird.src) + 1];
+
+	src = kstrdup("foobar", GFP_KERNEL);
+
+	if (src == NULL)
+		return;
+
+	/* Vanilla strscpy returns -E2BIG if size is 0. */
+	if (strscpy(dst, src, 0) != -E2BIG)
+		pr_warn("FAIL: strscpy() of 0 length did not return -E2BIG\n");
+
+	/* Vanilla strscpy returns -E2BIG if src is truncated. */
+	if (strscpy(dst, src, sizeof(dst)) != -E2BIG)
+		pr_warn("FAIL: strscpy() did not return -E2BIG while src is truncated\n");
+
+	/* After above call, dst must contain "foob" because src was truncated. */
+	if (strncmp(dst, "foob", sizeof(dst)) != 0)
+		pr_warn("FAIL: after strscpy() dst does not contain \"foob\" but \"%s\"\n",
+			dst);
+
+	/* Shrink src so the strscpy() below succeeds. */
+	src[3] = '\0';
+
+	/*
+	 * Vanilla strscpy returns number of character copied if everything goes
+	 * well.
+	 */
+	if (strscpy(dst, src, sizeof(dst)) != 3)
+		pr_warn("FAIL: strscpy() did not return 3 while src was copied entirely truncated\n");
+
+	/* After above call, dst must contain "foo" because src was copied. */
+	if (strncmp(dst, "foo", sizeof(dst)) != 0)
+		pr_warn("FAIL: after strscpy() dst does not contain \"foo\" but \"%s\"\n",
+			dst);
+
+	/* Test when src is embedded inside a union. */
+	strscpy(weird_dst, weird.src, sizeof(weird_dst));
+
+	if (strcmp(weird_dst, "hello") != 0)
+		pr_warn("FAIL: after strscpy() weird_dst does not contain \"hello\" but \"%s\"\n",
+			weird_dst);
+
+	/* Restore src to its initial value. */
+	src[3] = 'b';
+
+	/*
+	 * Use strlen here so size cannot be known at compile time and there is
+	 * a runtime write overflow.
+	 */
+	strscpy(dst, src, strlen(src));
+
+	pr_warn("FAIL: No overflow in above strscpy()\n");
+
+	kfree(src);
+}
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 49e6b945feb7..138f06254b61 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -104,4 +104,7 @@ void lkdtm_STACKLEAK_ERASING(void);
 /* cfi.c */
 void lkdtm_CFI_FORWARD_PROTO(void);
 
+/* fortify.c */
+void lkdtm_FORTIFIED_STRSCPY(void);
+
 #endif
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 74a8d329a72c..92ba4cc41314 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -68,3 +68,4 @@ USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+FORTIFIED_STRSCPY
-- 
2.20.1

