Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC4C4167E
	for <linux-hardening@archiver.kernel.org>; Sun, 27 Feb 2022 18:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiB0SqL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 27 Feb 2022 13:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiB0SqJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AB45132D
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 10:45:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so9129196pfv.1
        for <linux-hardening@vger.kernel.org>; Sun, 27 Feb 2022 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWQuW1pZiUPIz4vJWrH7gUOgoQp6sbO55rWZ8FArGBo=;
        b=HLkqZFFlTh5+wey7xEt6qvB2xnXL8ejZbXQpwYg5M1Hu1M39jy+KYOCy7/GkcvyadB
         BI27ZEoyAs5JPMjoehKWQKvoBalf8/7INAiq3V+ogadzoquBwdpxG2sGl1D3AwUozWZe
         1cb8DNTjkn+F/UQfsvc/MiKw8lt/uudrXvxGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWQuW1pZiUPIz4vJWrH7gUOgoQp6sbO55rWZ8FArGBo=;
        b=UE5SHp3i5ALJ39dZKrAn5vfriDh0LtCAQfODO43/NrwJgoF+TGNxl2Y9mDmwP5piIu
         2zDjuDUK+k+oBepBFUliZACnA1pH7LvMzQlKt9pF2EJir+O9gyJrEOHE4yoQZUvX1Axu
         ACyAWCzIXBkd1PKwu7q1RapiJR51D1qYkmh1AgBFcgjIklHEN2obxP6tRl/GV20Na4WD
         4sjSvHNCny56DparMKKqx8paWVgEg/K9K+o6gyhY7iaxztZp7uACkS0DEwyXSUNmyaIv
         WwmCGOw3iU+GZd5gso35HMwHHpfNah0c5CsJNVYboLoDaUNk/rTI0Qy9cot9ey3wzYuP
         7DlA==
X-Gm-Message-State: AOAM531f3N1gPfx3oJqE+CeQ+vGt6gYS2lQUaU/aVVEMQT+gzT18I+2w
        KXThmqT4jFdxcqJkv1wGflPVqw==
X-Google-Smtp-Source: ABdhPJzYJK2sbqKeWGcVXkV09fnJetSZa1jM/ltSYX5lABvFLKwJcjqTK4mm3tuldsTqkNji510KUQ==
X-Received: by 2002:a05:6a00:140b:b0:4e1:2cbd:30ba with SMTP id l11-20020a056a00140b00b004e12cbd30bamr17894766pfu.46.1645987523441;
        Sun, 27 Feb 2022 10:45:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm9954418pfl.24.2022.02.27.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
Date:   Sun, 27 Feb 2022 10:45:17 -0800
Message-Id: <20220227184517.504931-8-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7184; h=from:subject; bh=mgoDk12UNa5uSTGjFwO4+2nZAO80+cbZdVwcvxPnBXo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a8w5LxxpsIKgH44u9caHGgDW3ETo0Dp34N8ul1 zx4hrReJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGvAAKCRCJcvTf3G3AJpx8D/ 9NJbctB6I8TH57q8ZxlKFajHl++CZpRi+uCUD2clP0VMybkc6osP/9W8EKbq2NJ+lV4SD9NYZv+zg0 Gu8kfYQHAup5DPbbwwCgFA2mcjbsC9xEbShZNo0GNrioT7sceP4nUx9LmROGT8zIt5HVFl82xIZbJd bLWUxVm2pZzU+QO7kggwCOusM1upIZsy29LkhkIEyK863FjG/jQOTLGRm6sMdRa3VDGmoCrWryhVw2 XvqCvf2/wSERJSTzW3cCgmR9D2wkBWqYZiGOnuRFxJDDt3Z8Ci306XKDiBtG2RscJn982Wp0xJe928 l3nLadXMQ6czcDCUA1ebs4nr/p7CT1AZYNtQjquACs1zZkKKi7Heb8j6U3Kqnor8hobwxWFYf4MuUA iXCx3eM0g9SLpuMRiLfxyyUQM8RyAuhT/yV9HxQ8cNnK5UUaD0wZvSRu/RMC4lCYamCKA9+pD9fdNT zZrD3fgqGQR8qS5RotWk9Y7ZwXNtFTRgqoaNF+wVrgOo58Mk0xPPBRvuBIb1/HkD5rQOZKH4Q1b1uP KDf/c6lWLVbwMOoI31RoLBUwyNNrD2C0BABp4P+yclmNSYUdoebFUSbE6PHPKbBv11vlH2Y1NlCUq5 TWoMW97b0vqrT+Fg4vuna7z0fpv2BIqzYiQRHmVHlMdVvvR1eobpjMGw78bg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The original lib/test_stackinit.c, which exclusively tests toolchain
features, was designed to also be built without the full Linux kernel
sources so that compiler developers and distro maintainers had an easy
way to check for toolchain behaviors. When it was ported to KUnit, this
mode was removed to simplify the code.

Add a small header that provides a minimally operational KUnit API that
can allow unit tests that don't depend on kernel-specific behaviors
to build and run strictly from userspace without kernel sources. Add
userspace-build support back to the renamed lib/stackinit_kunit.c test.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220224055145.1853657-1-keescook@chromium.org
v2:
 - split from stackinit_kunit.c refactoring patch
 - add missing returns (Daniel)
 - report expression mismatch in assert msg (Daniel)
 - emulate kunit_test_suites() (Daniel)
 - emit valid KTAP (David)
---
 include/uapi/misc/kunit.h | 181 ++++++++++++++++++++++++++++++++++++++
 lib/stackinit_kunit.c     |  11 +++
 2 files changed, 192 insertions(+)
 create mode 100644 include/uapi/misc/kunit.h

diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
new file mode 100644
index 000000000000..afdffda583ae
--- /dev/null
+++ b/include/uapi/misc/kunit.h
@@ -0,0 +1,181 @@
+#ifndef __UAPI_MISC_KUNIT_H__
+#define __UAPI_MISC_KUNIT_H__
+/*
+ * This is a light-weight userspace drop-in replacement for the in-kernel
+ * KUnit API. It seeks to implement a minimal subset of features so that
+ * a concisely written KUnit test can be made to run entirely in userspace
+ * when it doesn't actually depend on any real kernel internals.
+ *
+ * Additionally contains many refactored kernel-isms to support building
+ * and running in userspace without full kernel source.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <sys/types.h>
+
+#define __user			/**/
+#define noinline		__attribute__((__noinline__))
+#define __aligned(x)		__attribute__((__aligned__(x)))
+#ifdef __clang__
+# define __compiletime_error(message) /**/
+#else
+# define __compiletime_error(message) __attribute__((__error__(message)))
+#endif
+#define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		extern void prefix ## suffix(void) __compiletime_error(msg); \
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
+#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
+
+#define ARRAY_SIZE(a)		(sizeof (a) / sizeof ((a)[0]))
+
+#define MODULE_LICENSE(str)	/* str */
+
+typedef uint8_t			u8;
+typedef uint16_t		u16;
+typedef uint32_t		u32;
+typedef uint64_t		u64;
+
+#define TEST_PASS	0
+#define TEST_SKIP	1
+#define TEST_FAIL	2
+struct kunit {
+	int status;
+	char *msg;
+};
+struct kunit_case {
+        void (*run_case)(struct kunit *test);
+        const char *name;
+};
+struct kunit_suite {
+	const char *name;
+	const struct kunit_case *test_cases;
+};
+#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+#define KUNIT_ASSERT_TRUE_MSG(test, expr, fmt, ...)			\
+do {									\
+	if (!(expr)) {							\
+		if (test->status != TEST_SKIP)				\
+			test->status = TEST_FAIL;			\
+		if (test->msg)						\
+			free(test->msg);				\
+		asprintf(&test->msg, fmt, ##__VA_ARGS__);		\
+		return;							\
+	}								\
+} while (0)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		\
+	KUNIT_ASSERT_TRUE_MSG(test, (left) == (right),			\
+			      #left " != " #right ": " fmt,		\
+			      ##__VA_ARGS__)
+
+#define kunit_skip(test, fmt, ...)					\
+do {									\
+	test->status = TEST_SKIP;					\
+	if (test->msg)							\
+		free(test->msg);					\
+	asprintf(&test->msg, fmt, ##__VA_ARGS__);			\
+	return;								\
+} while (0)
+
+static int do_kunit_test_suite(struct kunit_suite *suite)
+{
+	const struct kunit_case *test_case;
+	int pass = 0, fail = 0, skip = 0;
+	int rc = 0;
+	size_t i = 0;
+
+	printf("  TAP version 14\n");
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+		i++;
+	printf("  1..%zu\n", i);
+	i = 0;
+	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
+		struct kunit test = { };
+
+		i++;
+		test_case->run_case(&test);
+		switch (test.status) {
+		default:
+		case TEST_FAIL:
+			fprintf(stderr, "  not ok %zu - %s%s%s",
+				i, test_case->name,
+				test.msg ? " # ERROR " : "",
+				test.msg ?: "\n");
+			rc = 1;
+			fail++;
+			break;
+		case TEST_SKIP:
+			fprintf(stdout, "  ok %zu - %s # SKIP%s%s",
+				i, test_case->name,
+				test.msg ? " " : "",
+				test.msg ?: "\n");
+			skip++;
+			break;
+		case TEST_PASS:
+			fprintf(stdout, "  ok %zu - %s\n",
+				i, test_case->name);
+			pass++;
+			break;
+		}
+		if (test.msg)
+			free(test.msg);
+	}
+	printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
+		suite->name, pass, fail, skip, i);
+	return rc;
+}
+
+static int run_suites(char *name, struct kunit_suite *suites[], size_t count)
+{
+	int pass = 0, fail = 0, skip = 0;
+	int one, ret = 0;
+	size_t i;
+
+	printf("TAP version 14\n");
+	printf("1..%zu\n", count);
+	for (i = 0; i < count; ++i) {
+		one = do_kunit_test_suite(suites[i]);
+		switch (one) {
+		case TEST_SKIP:
+			skip++;
+			break;
+		case TEST_PASS:
+			pass++;
+			break;
+		default:
+			fail++;
+			break;
+		}
+		printf("%sok %zu - %s\n",
+			one == TEST_FAIL ? "not " : "",
+			i + 1, suites[i]->name);
+		ret |= one;
+	}
+	printf("# %s: pass:%d fail:%d skip:%d total:%zu\n",
+		name, pass, fail, skip, count);
+	return ret;
+}
+
+#define kunit_test_suites(suite...)				\
+int main(int argc, char *argv[]) {				\
+	static struct kunit_suite *suites[] = { suite };	\
+	return run_suites(argv[0], suites, ARRAY_SIZE(suites));	\
+}
+
+#endif /* __UAPI_MISC_KUNIT_H__ */
diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index 35c69aa425b2..6d468630c90a 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -8,7 +8,13 @@
  *		--make_option LLVM=1 \
  *		--kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
  *
+ * External build example:
+ *	clang -O2 -Wall -ftrivial-auto-var-init=pattern \
+ *		-o stackinit_kunit stackinit_kunit.c
+ *	./stackinit_kunit
+ *
  */
+#ifdef __KERNEL__
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
@@ -17,6 +23,11 @@
 #include <linux/module.h>
 #include <linux/string.h>
 
+#else
+/* Userspace KUnit stub header. */
+#include <misc/kunit.h>
+#endif
+
 /* Exfiltration buffer. */
 #define MAX_VAR_SIZE	128
 static u8 check_buf[MAX_VAR_SIZE];
-- 
2.32.0

