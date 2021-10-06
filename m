Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21118C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F401F6109F
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhJFSRn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhJFSRm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 14:17:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCFC061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 11:15:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m5so3088541pfk.7
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdG7EWDcW6BJEY9ksYClAuQgmEOu2o4ECgX6UcvZ2zk=;
        b=S45eY5sxGxaARPnhN1Xz2UKmhtIJHIHbAsu54jKmCJUyrRpESJJhF2u9DPDFrHaq7F
         drpJwj6nkczgIxFZvZvMvKG6avApQrrzeIFjJ6Hr7ukyPUtw+rPai7t1yFPZnlUSxnIa
         Hd2WNBNnx7FPaP8+y1BkAWpOidWj/3kFOYnpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdG7EWDcW6BJEY9ksYClAuQgmEOu2o4ECgX6UcvZ2zk=;
        b=wugPI8r6dUCXSLBJ+CuplB3KEKZugCe8R8CqvG+61aP4dAkAU5VktMevSk/7kt/IoJ
         i/RSiMmXKgV8e6yBQ4GieCzjXj3k0//vrpDmq6maYWQWQJmHvu4MzMbMu4cb1HCZj8GU
         jcUVPbP4cQkdPFukzJ+kXTnecFLtHYIxhUv6nCszLITniwOWCWt72Eno1acXf/sr3eBd
         0z7GefqAT3bboJsISIhdUBSirUz9RjVooPR2x6lq+S7Ec58510IVt48AAXghp79hxexL
         /8pjqok0sXXXLsyQeyHT0RnjA76SMZE95TZKiSnoIIiIJEbz1/YdyAah3GsjdzSKEJA7
         fYbQ==
X-Gm-Message-State: AOAM530ABWuMkw71c6nEVFbc0Hpl7C5mK4k+Lz+6s/loJQwRfmsEWEN5
        UU1PFzykNpVW6+Y3b/IL+pe9F/x0NHGRwQ==
X-Google-Smtp-Source: ABdhPJzQbkrbJxVdVBZGk+s+GglEbnE7pwlp2xgbil4BB0fndLGticEbM4M+8d14ZxfuFwm4fldvJQ==
X-Received: by 2002:a63:74b:: with SMTP id 72mr152871pgh.290.1633544149174;
        Wed, 06 Oct 2021 11:15:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b23sm21869363pfi.135.2021.10.06.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 11:15:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] kasan: test: Bypass __alloc_size checks
Date:   Wed,  6 Oct 2021 11:15:44 -0700
Message-Id: <20211006181544.1670992-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; h=from:subject; bh=B1T1hxgxVDfQrLSNj+ORHFTRqT7J4uui00+KgHGqQ7E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhXefQSdeNtSXEzc4wkAzSvCwnIV5nf7JNgxhaY2in pL0uC/WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYV3n0AAKCRCJcvTf3G3AJj0LD/ 9gOXto1WuRJBbDz2HibWKwg/R/X8gbdg5zE7FdTyyVbz0LNGbuTXVroklxd4SG9vle3bPb++KqJLiD rapIUX1iI3LpUGydJo5vtyr7/DMJU2IHottLCAUmDbBfQxlJfErfV9cooDSiBTryFX5wLA2DUKA2uf c632273fduEfmsZFj8u4CaKCrGzjQIEP6rFA9E2Nx5EF8wJTKDGZEfX53guKBXnpNQStXw6NriB6hw GRH0IDNDGIRquhyPsG2kbDkWz8eud3kdMfJxjMr8ih5zZkQOdkH2bG7WWZVjveU/Cp5iWLAiKDW/Bw lkmCDOwaXMM86h2AJiqlXjtwMqussFDImN+PQ3fFLHgQz8yGtehxjrmJlMsLmMhnEyMvkgclXYvphF gBm6pon54h4Dc3Fhs5gz4j9Gv8TCdw23d83ui6GMZhC10ezi9kV4um1llDWFbpkrD8G68qTCArSEYU IjwT+x4qy1H4lpmghfs71tyikKFEEDiI9+xJAgpMMuFC8oqsyFTwmGVWErrVR+CxsQh8WbtTU6tZY+ 0vV9fCiolMiZUKnnzHoQE+93YOq5kNQFrYbnzvFArd8VIpaKDXEdlkEZ6iayoj/dYuX55gkRJOfSuu PL36GdgeckkrVvNaUZbucMi4zHU67KK6zC/INs8uAVyMNDA+O+MBokbNmOtg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Intentional overflows, as performed by the KASAN tests, are detected
at compile time[1] (instead of only at run-time) with the addition of
__alloc_size. Fix this by forcing the compiler into not being able to
trust the size used following the kmalloc()s.

[1] https://lore.kernel.org/lkml/20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use OPTIMIZER_HIDE_VAR() (jann, mark)
v1: https://lore.kernel.org/lkml/20211006035522.539346-1-keescook@chromium.org/
---
 lib/test_kasan.c        | 8 +++++++-
 lib/test_kasan_module.c | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 8835e0784578..8a8a8133f4cd 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -440,6 +440,7 @@ static void kmalloc_oob_memset_2(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, 2));
 	kfree(ptr);
 }
@@ -452,6 +453,7 @@ static void kmalloc_oob_memset_4(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, 4));
 	kfree(ptr);
 }
@@ -464,6 +466,7 @@ static void kmalloc_oob_memset_8(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, 8));
 	kfree(ptr);
 }
@@ -476,6 +479,7 @@ static void kmalloc_oob_memset_16(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, 16));
 	kfree(ptr);
 }
@@ -488,6 +492,7 @@ static void kmalloc_oob_in_memset(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 				memset(ptr, 0, size + KASAN_GRANULE_SIZE));
 	kfree(ptr);
@@ -497,7 +502,7 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 64;
-	volatile size_t invalid_size = -2;
+	size_t invalid_size = -2;
 
 	/*
 	 * Hardware tag-based mode doesn't check memmove for negative size.
@@ -510,6 +515,7 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
+	OPTIMIZER_HIDE_VAR(invalid_size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
 	kfree(ptr);
diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
index 7ebf433edef3..b112cbc835e9 100644
--- a/lib/test_kasan_module.c
+++ b/lib/test_kasan_module.c
@@ -35,6 +35,8 @@ static noinline void __init copy_user_test(void)
 		return;
 	}
 
+	OPTIMIZER_HIDE_VAR(size);
+
 	pr_info("out-of-bounds in copy_from_user()\n");
 	unused = copy_from_user(kmem, usermem, size + 1);
 
-- 
2.30.2

