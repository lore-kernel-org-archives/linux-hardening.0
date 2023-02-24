Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129BDC6FD18
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Feb 2023 09:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBXJAN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Feb 2023 04:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBXJAH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Feb 2023 04:00:07 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87763A3B
        for <linux-hardening@vger.kernel.org>; Fri, 24 Feb 2023 01:00:05 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id ck7-20020a0564021c0700b004a25d8d7593so17958720edb.0
        for <linux-hardening@vger.kernel.org>; Fri, 24 Feb 2023 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+KSe6yW61OhH8F5xK9sHNFGGyhwmdu+LoC5TlHU1sA=;
        b=MeczQ9i/Gh5ybhKSh6LHvUv3XoWphMzafnUqnCe84CpugDhL780/nnP4v86GRpxut3
         fN83m3TjZfUfh40XNOmFhKFmdEqHFqEVZmuhpk3Tlq5HdyAFoH1GpaVMlfTlB9Lj27L0
         5bHOtC8kl5EXXZfaVzoBwKtBYrvNBPogX+U10Qu55u5F6kaBmMS4LWai8CnqIxTtePbJ
         r5WOcRQcj4QKFbLshIPoCj3NywHr80ZOAwMDfB2al588iDlEXtct6RN7xY79W1bHTy7a
         IqsyMT2L4sF1zgurIlgG2HNGoVkEKVSau31sfRUAOzTckgDPykx8WLBc2nLSHcolzkQf
         +4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+KSe6yW61OhH8F5xK9sHNFGGyhwmdu+LoC5TlHU1sA=;
        b=xbr09oiBmxEhcXQBzreptEaPuWpzh/Ki1RFvzZaDFJCvwwiyX598ue2SyaETU6mW3t
         71LBM0M07lAKI/Ovc2ZUnQzWEFfIr3jHSVgn4gi440D2RqYMJW22GXhgKoramU1hzrin
         2/r31D6R7a3u/NOa/tRLJZJzrykPfPtZEvvnzTPnUzdVnDciG38P28U0nQvyl80DHp4w
         JlhJpYdhPnkuubOgTF36HUCDHxaLHO54p46C0CNcmmuH3cswmn5znln1R0ys8rRciljK
         eTS8jX2LX0DN+YzLipn4M+U6cXfGtG9dl90BmOY/HvaI9t5CPxyi2sg1fqfI8yq7O4JD
         yblQ==
X-Gm-Message-State: AO0yUKUA1gpa1l01dTCgmKyVw5gdI9FAmMwjoDx7A6qvva0sJsh5xdd1
        Zs75QQfHr+So5xXIgqPb4q29sOaGSg==
X-Google-Smtp-Source: AK7set8yeA9c9phELQWpHGJcxcfHs4Ohf8boIVTjey61Dmo3Jly/lRrvnHxnoJmxBuCnZumHAIuEQLl2Dg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:53eb:6453:f5f5:3bb9])
 (user=elver job=sendgmr) by 2002:a50:c301:0:b0:49d:ec5e:1e9a with SMTP id
 a1-20020a50c301000000b0049dec5e1e9amr7086377edb.7.1677229204289; Fri, 24 Feb
 2023 01:00:04 -0800 (PST)
Date:   Fri, 24 Feb 2023 09:59:41 +0100
In-Reply-To: <20230224085942.1791837-1-elver@google.com>
Mime-Version: 1.0
References: <20230224085942.1791837-1-elver@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224085942.1791837-3-elver@google.com>
Subject: [PATCH v5 3/4] kasan: test: Fix test for new meminstrinsic instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The tests for memset/memmove have been failing since they haven't been
instrumented in 69d4c0d32186.

Fix the test to recognize when memintrinsics aren't instrumented, and
skip test cases accordingly. We also need to conditionally pass
-fno-builtin to the test, otherwise the instrumentation pass won't
recognize memintrinsics and end up not instrumenting them either.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
v4:
* New patch.
---
 mm/kasan/Makefile     |  9 ++++++++-
 mm/kasan/kasan_test.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index d4837bff3b60..7634dd2a6128 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -35,7 +35,14 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
-CFLAGS_KASAN_TEST := $(CFLAGS_KASAN) -fno-builtin $(call cc-disable-warning, vla)
+CFLAGS_KASAN_TEST := $(CFLAGS_KASAN) $(call cc-disable-warning, vla)
+ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+# If compiler instruments memintrinsics by prefixing them with __asan/__hwasan,
+# we need to treat them normally (as builtins), otherwise the compiler won't
+# recognize them as instrumentable. If it doesn't instrument them, we need to
+# pass -fno-builtin, so the compiler doesn't inline them.
+CFLAGS_KASAN_TEST += -fno-builtin
+endif
 
 CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
 CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 74cd80c12b25..627eaf1ee1db 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -165,6 +165,15 @@ static void kasan_test_exit(struct kunit *test)
 		kunit_skip((test), "Test requires " #config "=n");	\
 } while (0)
 
+#define KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test) do {		\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))				\
+		break;  /* No compiler instrumentation. */		\
+	if (IS_ENABLED(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX))	\
+		break;  /* Should always be instrumented! */		\
+	if (IS_ENABLED(CONFIG_GENERIC_ENTRY))				\
+		kunit_skip((test), "Test requires checked mem*()");	\
+} while (0)
+
 static void kmalloc_oob_right(struct kunit *test)
 {
 	char *ptr;
@@ -454,6 +463,8 @@ static void kmalloc_oob_16(struct kunit *test)
 		u64 words[2];
 	} *ptr1, *ptr2;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	/* This test is specifically crafted for the generic mode. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
@@ -476,6 +487,8 @@ static void kmalloc_uaf_16(struct kunit *test)
 		u64 words[2];
 	} *ptr1, *ptr2;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr1 = kmalloc(sizeof(*ptr1), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
@@ -498,6 +511,8 @@ static void kmalloc_oob_memset_2(struct kunit *test)
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -511,6 +526,8 @@ static void kmalloc_oob_memset_4(struct kunit *test)
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -524,6 +541,8 @@ static void kmalloc_oob_memset_8(struct kunit *test)
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -537,6 +556,8 @@ static void kmalloc_oob_memset_16(struct kunit *test)
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -550,6 +571,8 @@ static void kmalloc_oob_in_memset(struct kunit *test)
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -566,6 +589,8 @@ static void kmalloc_memmove_negative_size(struct kunit *test)
 	size_t size = 64;
 	size_t invalid_size = -2;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	/*
 	 * Hardware tag-based mode doesn't check memmove for negative size.
 	 * As a result, this test introduces a side-effect memory corruption,
@@ -590,6 +615,8 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 	size_t size = 64;
 	size_t invalid_size = size;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -618,6 +645,8 @@ static void kmalloc_uaf_memset(struct kunit *test)
 	char *ptr;
 	size_t size = 33;
 
+	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
+
 	/*
 	 * Only generic KASAN uses quarantine, which is required to avoid a
 	 * kernel memory corruption this test causes.
-- 
2.39.2.637.g21b0678d19-goog

