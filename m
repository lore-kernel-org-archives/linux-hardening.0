Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C3C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Dec 2021 23:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383545AbhLCX5O (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Dec 2021 18:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383482AbhLCX5N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Dec 2021 18:57:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D9C061354
        for <linux-hardening@vger.kernel.org>; Fri,  3 Dec 2021 15:53:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u17so3150693plg.9
        for <linux-hardening@vger.kernel.org>; Fri, 03 Dec 2021 15:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVvBBVeVK8DjGILhnluaZWIdY/jp280YmrZN5s9cMlU=;
        b=NvXNLxVfkOqcl1NdXf/dEmSHlqF/9VQdXpYze4+d7ntMPesMI3msa6q57DK/vD1wHt
         yIGelN70MHUB6BXrs9m2Jt1nvQRqSH04k8ZxZ+9xOpA0w2GxLDm9AqoABay3YehHPjmN
         0l1Y2gIIhrd+5I97gxuFq5jmGvcbcvRvX8ZBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVvBBVeVK8DjGILhnluaZWIdY/jp280YmrZN5s9cMlU=;
        b=fJS9dOSlvjSYv+TEWKFwOxRpVLJ/fBlCNk9p/b8yTuurndjvzzbAXs/007TnbNaM57
         wJDyAVH5K/7s2oXajfQ47JJPQK5J2T8+ZseeUWDkBsjKtJukDm94s22SLh41lM6brz1l
         /cnVf2jxrjCTjTo4fEmm7s5OwLAuSsOy2ZQo4ur/kwFtVDQMyxqN8ZZv6+8KdjScBMCw
         /EF39GUeBpL59VVCAUfqsFbs2ZDg3palZZTY21LMndbvxcxKhJB2HFRsrWScbX9lnUU0
         FdMxtTTTUkMN/zjj3rN10pHr6n+GucbvpnjVUJ+P50u5w4y5FwbY4IEFKx/5vJnlZDze
         z73A==
X-Gm-Message-State: AOAM533DGLK7i09Gm4PWeT84th99pmgQwypD+VXRXoW+habDW6KQfPdj
        Ba2XhPajxadq5Q0XG7cTfVt85Q==
X-Google-Smtp-Source: ABdhPJyh4sVUaW0Ir7GT6UGWRej1hWbVpjoja2UeZTPgbhKu8+ctBvf0nPTAwfeSphdR9SscTCFdlg==
X-Received: by 2002:a17:903:408d:b0:142:22f1:5886 with SMTP id z13-20020a170903408d00b0014222f15886mr26707647plc.34.1638575628701;
        Fri, 03 Dec 2021 15:53:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w19sm325479pga.80.2021.12.03.15.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:53:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ubsan: Remove CONFIG_UBSAN_OBJECT_SIZE
Date:   Fri,  3 Dec 2021 15:53:46 -0800
Message-Id: <20211203235346.110809-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708; h=from:subject; bh=C+YlD5eCcTI+BCxvNOr6WPTTM7rlW8dSWnkH9e9gT3M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqq4JWzZLom5zES09EKyuYtCz2ptD5h7II+7EPHvi f9laaHeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYaquCQAKCRCJcvTf3G3AJpfLD/ 9cIZk0jm3L72+DFOOlEcIOcfIUty4M/OZF87RySKyRSTONXB8J3Us+Ifm4Wo9ny82gQgrbtJh84pDE GzgnItpcv8GJhUDZ1NoUmo34W+eOhhJli4yZewV9g9WORrPmnHnmEpcCCbkk/X2TdDaL18LlwXNSJu dpqOVLeKB0I6rIWf5PuF2hJV3GzsbEpBz87eagUHuP7RxdSOneSwH+uHA+XR1vj5xpICouayXBqcnf nWMS4fwWxQsPdoZSbfCN7uW/OtJmM7E/ClU4S63ZZ6JJHxMRNQoSj5vpoGP3ohMl6cAeN+YfimuQzo 5LUFjAmLBMkZC/l0uFwUaDB0zeETw49pWWLfZKL9AaCo1HU3u3ybAChek7NOqt1MySZxy6/ac3f0q7 GCfYc84OTq9q35PZV+R4kQ6ieKymPz5H8ZaB7efnHj/SrY07yMENjH/Zylt0DdtRXQi9gH+cNNn2Hh vbJRTTidf8lza6qb1jqIV2tZbxlWmfDW58RBmghnMO40FXv1lPvTEb4V47LUPOUfB1lFUOCNLWQTPN 9zZZ/4X/d231QRAZGxBlp3pqPCVGBME0oHkraPevghjzzA4sSB2M6loEwNMjas8SZpYTg/hqlyTLHP wXiqEjjQnikwLmlHMWOsKRUgVtI3IYX7ZBCqZJuAwNQ0ecwCSkwxKuNPrV5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The object-size sanitizer is redundant to -Warray-bounds, and
inappropriately performs its checks at run-time when all information
needed for the evaluation is available at compile-time, making it quite
difficult to use:

https://bugzilla.kernel.org/show_bug.cgi?id=214861

With -Warray-bounds almost enabled globally, it doesn't make sense to
keep this around.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.ubsan      | 13 -------------
 lib/test_ubsan.c       | 22 ----------------------
 scripts/Makefile.ubsan |  1 -
 3 files changed, 36 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index e5372a13511d..236c5cefc4cc 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -112,19 +112,6 @@ config UBSAN_UNREACHABLE
 	  This option enables -fsanitize=unreachable which checks for control
 	  flow reaching an expected-to-be-unreachable position.
 
-config UBSAN_OBJECT_SIZE
-	bool "Perform checking for accesses beyond the end of objects"
-	default UBSAN
-	# gcc hugely expands stack usage with -fsanitize=object-size
-	# https://lore.kernel.org/lkml/CAHk-=wjPasyJrDuwDnpHJS2TuQfExwe=px-SzLeN8GFMAQJPmQ@mail.gmail.com/
-	depends on !CC_IS_GCC
-	depends on $(cc-option,-fsanitize=object-size)
-	help
-	  This option enables -fsanitize=object-size which checks for accesses
-	  beyond the end of objects where the optimizer can determine both the
-	  object being operated on and its size, usually seen with bad downcasts,
-	  or access to struct members from NULL pointers.
-
 config UBSAN_BOOL
 	bool "Perform checking for non-boolean values used as boolean"
 	default UBSAN
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 7e7bbd0f3fd2..2062be1f2e80 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -79,15 +79,6 @@ static void test_ubsan_load_invalid_value(void)
 	eval2 = eval;
 }
 
-static void test_ubsan_null_ptr_deref(void)
-{
-	volatile int *ptr = NULL;
-	int val;
-
-	UBSAN_TEST(CONFIG_UBSAN_OBJECT_SIZE);
-	val = *ptr;
-}
-
 static void test_ubsan_misaligned_access(void)
 {
 	volatile char arr[5] __aligned(4) = {1, 2, 3, 4, 5};
@@ -98,29 +89,16 @@ static void test_ubsan_misaligned_access(void)
 	*ptr = val;
 }
 
-static void test_ubsan_object_size_mismatch(void)
-{
-	/* "((aligned(8)))" helps this not into be misaligned for ptr-access. */
-	volatile int val __aligned(8) = 4;
-	volatile long long *ptr, val2;
-
-	UBSAN_TEST(CONFIG_UBSAN_OBJECT_SIZE);
-	ptr = (long long *)&val;
-	val2 = *ptr;
-}
-
 static const test_ubsan_fp test_ubsan_array[] = {
 	test_ubsan_shift_out_of_bounds,
 	test_ubsan_out_of_bounds,
 	test_ubsan_load_invalid_value,
 	test_ubsan_misaligned_access,
-	test_ubsan_object_size_mismatch,
 };
 
 /* Excluded because they Oops the module. */
 static const test_ubsan_fp skip_ubsan_array[] = {
 	test_ubsan_divrem_overflow,
-	test_ubsan_null_ptr_deref,
 };
 
 static int __init test_ubsan_init(void)
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 9e2092fd5206..7099c603ff0a 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -8,7 +8,6 @@ ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)	+= -fsanitize=local-bounds
 ubsan-cflags-$(CONFIG_UBSAN_SHIFT)		+= -fsanitize=shift
 ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
-ubsan-cflags-$(CONFIG_UBSAN_OBJECT_SIZE)	+= -fsanitize=object-size
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
 ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= -fsanitize-undefined-trap-on-error
-- 
2.30.2

