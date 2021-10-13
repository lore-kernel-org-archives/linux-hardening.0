Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F2C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914CB610FC
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJMPCe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhJMPCe (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 692F860720;
        Wed, 13 Oct 2021 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634137231;
        bh=Kf8uHVjkarQQnfDUcAzsGWVS+btn2CLXNlG1S1kgSwM=;
        h=From:To:Cc:Subject:Date:From;
        b=D0mhcJwLXff71e4P+kB8dw5HLxZkq2KRq3oS5oOZYLI2yXYn8rEPgLHvRloyf6v1Z
         KogTzrfyowT60coi8wAwPzbZu8kRr2qTooWPwTGMVnJcOz282foh6hKxr/8KYXcMr5
         HQx3FGDY9HdQMquCWwRSyY/427emkmqQEz7vt8sBymIKjUiZwJrOPYoAMnBa05F51S
         tnZtGIAudW0FNxetbOWTrfrPUfZXL8aY9bToV3lx6sN6hkF+5WJzIdp6Ke5c56FqSg
         JRdBS/6g45a1ljUwJb07hAE3jvz4Sz7dsX7d6R/LdAuYvazDlEr7tIrdDDG4CMI0FM
         DuA9ckSEmwvog==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kasan: test: use underlying string helpers
Date:   Wed, 13 Oct 2021 17:00:05 +0200
Message-Id: <20211013150025.2875883-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Calling memcmp() and memchr() with an intentional buffer overflow
is now caught at compile time:

In function 'memcmp',
    inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
  263 |                         __read_overflow();
      |                         ^~~~~~~~~~~~~~~~~
In function 'memchr',
    inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
  277 |                 __read_overflow();
      |                 ^~~~~~~~~~~~~~~~~

Change the kasan tests to wrap those inside of a noinline function
to prevent the compiler from noticing the bug and let kasan find
it at runtime.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_kasan.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 67ed689a0b1b..903215e944f1 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -852,6 +852,21 @@ static void kmem_cache_invalid_free(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+/*
+ * noinline wrappers to prevent the compiler from noticing the overflow
+ * at compile time rather than having kasan catch it.
+ * */
+static noinline void *__kasan_memchr(const void *s, int c, size_t n)
+{
+	return memchr(s, c, n);
+}
+
+static noinline int __kasan_memcmp(const void *s1, const void *s2, size_t n)
+{
+	return memcmp(s1, s2, n);
+}
+
+
 static void kasan_memchr(struct kunit *test)
 {
 	char *ptr;
@@ -870,7 +885,7 @@ static void kasan_memchr(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_ptr_result = memchr(ptr, '1', size + 1));
+		kasan_ptr_result = __kasan_memchr(ptr, '1', size + 1));
 
 	kfree(ptr);
 }
@@ -895,7 +910,7 @@ static void kasan_memcmp(struct kunit *test)
 	memset(arr, 0, sizeof(arr));
 
 	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_int_result = memcmp(ptr, arr, size+1));
+		kasan_int_result = __kasan_memcmp(ptr, arr, size+1));
 	kfree(ptr);
 }
 
-- 
2.29.2

