Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46FAC4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE261247
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhHVH5i (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVH5i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D4C061575
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso11584320pjb.1
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K15d43mjq6biIgLR18/PG2ST/9ClHTj/frmKzAh8Fgc=;
        b=B5QY9BABO+ydPAidOIYg9icRT6RA3TJzzpxIxJHzpK3xJCgD1axrJj40bx21SpJ52o
         Oe5Ig13T7H7S4fGe3oAM2ZRGMUHW8dsOGGTxUY7BlxiT6uLYHZWGjz3MVxpkghKBQxwT
         RDPH+h5BIqphwABDAmyO2hmme1bxjIJjQRhYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K15d43mjq6biIgLR18/PG2ST/9ClHTj/frmKzAh8Fgc=;
        b=Y5JXNkpUc31BpCZwXmEKbkN+RH41Xu1uX/Nb6fBE408BRLYAbeQ76JyXDlmbuiSY5y
         2UeDrEC1MfKVRm7syCPda9eGp5fSuZ6TUNMKyzgN5Y7wNdC5K5qT+GrUOLrYz5L1eSo3
         DXYtC/nFiT6zr3zE3omZ2M3JSOczQHYVDkufC36ofA5+4Cp5SxqI3qULtRzndhDOYJQJ
         TnN7Yr9kBvWTwqYNaZYILLp+aMmmy2a2YDzbQJ1TSAKqmdR+BFnAKraiCje0gbLCgEWx
         MGR6CogTyMTAjqQF1LjV3erPqPqvASWF/KT75ETGwKKOBC8mqnh9ggxz0WzHEt+TQfWu
         8aOA==
X-Gm-Message-State: AOAM533gDBIiQux53Xjafp9GlB7D1AG+HXDScDB7Q6HAvlq7LYoStvNC
        xVWtVugk15GAY5SqcaSZloo8HA==
X-Google-Smtp-Source: ABdhPJzWqLhyoBLtPJm2TcOLdF6MIEB71sJYdvMFFd/ZchUyZ9SRDrN4hHDJyFHLC6S3v2rmybcqiw==
X-Received: by 2002:a17:902:b709:b0:12d:a7ab:952f with SMTP id d9-20020a170902b70900b0012da7ab952fmr23596616pls.25.1629619017001;
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm12273644pfu.67.2021.08.22.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 21/25] lib: Introduce CONFIG_TEST_MEMCPY
Date:   Sun, 22 Aug 2021 00:51:18 -0700
Message-Id: <20210822075122.864511-22-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10296; h=from:subject; bh=SCs0gUiQeBdkXzSIn2KtU6GgHndNNkCfOloouMv/FjA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH5gffUe7V9h9DhEAh8IAruzpJoIjBSw/gQvBpt RsXbH1SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+QAKCRCJcvTf3G3AJvgHD/ 9EBKdt7wIMwq+pnHce4zVRAo13cVlsThSeQHWDVBiOwrDL15EUv1ydtUf2763IWxp1RRvbBSiU3TIH sEcLlcN6FHepmlOs3mucsMgU0WXa0k2ir8YDGqk9KdM9M4bkm1nt6bnZs1RrXegQoROLyie0bLSOPk 2MITOblSGe7hKwDKQlWnHwznMZcMEMHfSfIgybxwTCW7pS+gCEyOtIbFxwdlaiURwmFIIRyPitA3Od WGHg5KKfu5AyzYSll2aAnAB7TSg6t4tYMjIIcnElsUdxtxkPCMwFSqbR0re6Azd0lGAjXNx+5YG2O+ +0IeGHcUQQEaSFsCTcXSgK3ZsI5ysmJAiW0rUM8Nl+jNjPIuba4wGlwEiYG44THSu5y0CwYPFkiMd4 pQmWrAaNSYVpuN6+8S9y2Z8P0KeWGD8UqG60ferrjCTbqYu5m0Py85/znwzAW5aD1sEpID8yoBz+n+ SRhglq0gpbGa4k+PHFzqL6YnvV4Bnr4lidQEmoChW8kYcDQmuhe0HFnIdOhHzWLhajkoeL3itvOxzr 9WPPI3cSUu7EKvW86ITqzA656hJCq/P0I6/aSfhNvMxKN5BM2tJVFFcEHKPFnCRDuyDN+l4UcJIPwp 2rRvI7Afl2ewBSTyHLdYIEFZ/Oi7qOrO+JBMhN0s9kK96gbLCjTU4l4xKJZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Before changing anything about memcpy(), memmove(), and memset(), add
run-time tests to check basic behaviors for any regressions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS       |   9 ++
 lib/Kconfig.debug |  11 ++
 lib/Makefile      |   1 +
 lib/test_memcpy.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 lib/test_memcpy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c8be735cc91..e3ffd4bdc24f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7248,6 +7248,15 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/nvidia/*
 
+FORTIFY_SOURCE
+M:	Kees Cook <keescook@chomium.org>
+L:	linux-hardening@vger.kernel.org
+S:	Supported
+F:	include/linux/fortify-string.h
+F:	lib/test_fortify/*
+F:	scripts/test_fortify.sh
+K:	\b__NO_FORTIFY\b
+
 FPGA DFL DRIVERS
 M:	Wu Hao <hao.wu@intel.com>
 R:	Tom Rix <trix@redhat.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 831212722924..9199be57ba2a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2467,6 +2467,17 @@ config RATIONAL_KUNIT_TEST
 
 	  If unsure, say N.
 
+config MEMCPY_KUNIT_TEST
+	tristate "Test memcpy(), memmove(), and memset() functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for memcpy(), memmove(), and memset() functions.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index bd17c2bf43e1..8a4c8bdb38a2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
+obj-$(CONFIG_TEST_MEMCPY) += test_memcpy.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
diff --git a/lib/test_memcpy.c b/lib/test_memcpy.c
new file mode 100644
index 000000000000..ec546cec883e
--- /dev/null
+++ b/lib/test_memcpy.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for memcpy(), memmove(), and memset().
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+struct some_bytes {
+	union {
+		u8 data[32];
+		struct {
+			u32 one;
+			u16 two;
+			u8  three;
+			/* 1 byte hole */
+			u32 four[4];
+		};
+	};
+};
+
+#define check(instance, v) do {	\
+	int i;	\
+	BUILD_BUG_ON(sizeof(instance.data) != 32);	\
+	for (i = 0; i < sizeof(instance.data); i++) {	\
+		KUNIT_ASSERT_EQ_MSG(test, instance.data[i], v, \
+			"line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
+			__LINE__, #instance, v, i, instance.data[i]);	\
+	}	\
+} while (0)
+
+#define compare(name, one, two) do { \
+	int i; \
+	BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
+	for (i = 0; i < sizeof(one); i++) {	\
+		KUNIT_EXPECT_EQ_MSG(test, one.data[i], two.data[i], \
+			"line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
+			__LINE__, #one, i, one.data[i], #two, i, two.data[i]); \
+	}	\
+	kunit_info(test, "ok: " TEST_OP "() " name "\n");	\
+} while (0)
+
+static void memcpy_test(struct kunit *test)
+{
+#define TEST_OP "memcpy"
+	struct some_bytes control = {
+		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes zero = { };
+	struct some_bytes middle = {
+		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
+			  0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes three = {
+		.data = { 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes dest = { };
+	int count;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x20);
+	check(zero, 0);
+	compare("static initializers", dest, zero);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	memcpy(dest.data, zero.data, sizeof(dest.data));
+	compare("complete overwrite", dest, zero);
+
+	/* Verify middle overwrite. */
+	dest = control;
+	memcpy(dest.data + 12, zero.data, 7);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	count = 1;
+	memcpy(ptr++, zero.data, count++);
+	ptr += 8;
+	memcpy(ptr++, zero.data, count++);
+	compare("argument side-effects", dest, three);
+#undef TEST_OP
+}
+
+static void memmove_test(struct kunit *test)
+{
+#define TEST_OP "memmove"
+	struct some_bytes control = {
+		.data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes zero = { };
+	struct some_bytes middle = {
+		.data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x00, 0x00, 0x00, 0x00,
+			  0x00, 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes five = {
+		.data = { 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x00, 0x00, 0x00, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes overlap = {
+		.data = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes overlap_expected = {
+		.data = { 0x00, 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x07,
+			  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes dest = { };
+	int count;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x99);
+	check(zero, 0);
+	compare("static initializers", zero, dest);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	memmove(dest.data, zero.data, sizeof(dest.data));
+	compare("complete overwrite", dest, zero);
+
+	/* Verify middle overwrite. */
+	dest = control;
+	memmove(dest.data + 12, zero.data, 7);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	count = 2;
+	memmove(ptr++, zero.data, count++);
+	ptr += 9;
+	memmove(ptr++, zero.data, count++);
+	compare("argument side-effects", dest, five);
+
+	/* Verify overlapping overwrite is correct. */
+	ptr = &overlap.data[2];
+	memmove(ptr, overlap.data, 5);
+	compare("overlapping write", overlap, overlap_expected);
+#undef TEST_OP
+}
+
+static void memset_test(struct kunit *test)
+{
+#define TEST_OP "memset"
+	struct some_bytes control = {
+		.data = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			},
+	};
+	struct some_bytes complete = {
+		.data = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			},
+	};
+	struct some_bytes middle = {
+		.data = { 0x30, 0x30, 0x30, 0x30, 0x31, 0x31, 0x31, 0x31,
+			  0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31,
+			  0x31, 0x31, 0x31, 0x31, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			},
+	};
+	struct some_bytes three = {
+		.data = { 0x60, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x61, 0x61, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			},
+	};
+	struct some_bytes dest = { };
+	int count, value;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x30);
+	check(dest, 0);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	memset(dest.data, 0xff, sizeof(dest.data));
+	compare("complete overwrite", dest, complete);
+
+	/* Verify middle overwrite. */
+	dest = control;
+	memset(dest.data + 4, 0x31, 16);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	value = 0x60;
+	count = 1;
+	memset(ptr++, value++, count++);
+	ptr += 8;
+	memset(ptr++, value++, count++);
+	compare("argument side-effects", dest, three);
+#undef TEST_OP
+}
+
+static struct kunit_case memcpy_test_cases[] = {
+	KUNIT_CASE(memset_test),
+	KUNIT_CASE(memcpy_test),
+	KUNIT_CASE(memmove_test),
+	{}
+};
+
+static struct kunit_suite memcpy_test_suite = {
+	.name = "memcpy-test",
+	.test_cases = memcpy_test_cases,
+};
+
+kunit_test_suite(memcpy_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.30.2

