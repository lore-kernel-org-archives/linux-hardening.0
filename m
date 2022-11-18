Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B318DC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 03:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiKRD5T (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240839AbiKRD5B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 22:57:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC06905AA
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 19:57:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k5so3421295pjo.5
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 19:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8B1s0J4vkfD99lkbpUfX7NsV2A8gl/zFhB0jTXPx4F4=;
        b=cR9j3NBALJiubldTqL7hDr5StmKWZVzq2nFTqDyoa8cMEJ/Vl5k8ppRD4V1Kqc4FQq
         XvpGgzYZZWhFtQr7/RThBiL6KgexiOSckgqUVONchkC/S3sobaKyhzU3adQWbHgU0nCJ
         rD7KfTSEm8QUGEtxHu3UzVB/Ya1UC4hwsDnko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B1s0J4vkfD99lkbpUfX7NsV2A8gl/zFhB0jTXPx4F4=;
        b=A4Ev+zCBdfiaAggozxILSWJ5MG7vhGJuL/Kt3Qd41U0ycGm9eqDgwnUT2p0EH7eNYS
         3/Zu/nybSBBHItINJK3VAgc+gQKb0RYvz3vSt4tIWnRzGIYDkjA7W9kjbpm5BIVHwb1h
         2rdi4bA1zxZ9t5O7VEeaC6PL8jk83sPv6/mQDsaWiyO6Qe0d9vuoPF/R0WGJGb7klYfT
         neNawUvCYVBmb2TnJ7A5azUqyZ36BBz3fIqjFpcg2eYIf6oKvbiapZ4E10/PkSiWnVWA
         ICP1vDfjydy/v7+P24hFslx1AEIpvrAV9ZOxddeqAiFZhXpH9LHYzJbnPMHTx2NqGwTf
         PZ1g==
X-Gm-Message-State: ANoB5pkEfe8BY1rbL+35ooBlSq1pCXpBaCAleTWzkiEpGifV2HkDX/1s
        uN/c143pPWgJc9WjW2OvOSHBkQ==
X-Google-Smtp-Source: AA0mqf6JLRc+ImEbk3jcSNvaZW8JeT4jX9mjfwZAJlSP3dC42Eo6aMOAIQvR8stlWLtkxabInUEGsg==
X-Received: by 2002:a17:90a:b298:b0:212:f923:2f90 with SMTP id c24-20020a17090ab29800b00212f9232f90mr5755322pjr.93.1668743820127;
        Thu, 17 Nov 2022 19:57:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6-20020a656086000000b0047722bc3016sm683354pgu.80.2022.11.17.19.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:56:59 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] mm: Make ksize() a reporting-only function
Date:   Thu, 17 Nov 2022 19:56:57 -0800
Message-Id: <20221118035656.gonna.698-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4800; h=from:subject:message-id; bh=Z9YyO0LwjFqRuv/Azz2xAdd8WdFra8on/pdrLBKRfK0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdwKJFMoqLEX42onP27WvbKXgxbbST+JJjwmiMqFo 9nXiQxiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3cCiQAKCRCJcvTf3G3AJq/ZD/ sGlZyzLuKKDjnPxvjXfOv1yhSHIWk/DAFlOwg9tQcertx2R8rm/uJPICL+RuB5KqnNHu1aiZg3Co/O WLmLHBqvIUb0MUCpAZNSLgm6nTuaabey28O0f+yW8vlNwSKT14xHFUSMxStc1YmnMEFs/F/LmLAug/ bmoobIxZeqa0Aq+ImsvMy+Semml0HLZAzfr22XJ13xyZNaAE06fGjHUM4h63wV4RswGPe+COqw0PTt KSX+ZfMfD4m4Ltw5HSUHAr4BP5Pxz8f05jgHNdCTll/d9UHZ9Xn0WpStS4tLQikIwbs2cuqjdSsN5K 4jNFdBkZhZDfzhq6wmUCy4pixNs+o/eTCq1EE6JVIYPDrM+RmPBv0iwIqF3+jWtTXPUiY7SL1saXC7 OObPcdFfDrY5VKam7Yde+T2C/EbZy9uZmR0tkEo90H0igCyjHVsBwjNsMFYfaJB8mjO18+1YzaInSR Hj4ndnFz2O/hWh9z7t1iC1TsjLHtZSv12AdCVeWAvSUGDl7wDow8/4L+IKDGs7Ee4CTbrdJmqKpvmz 6BldL3a+p9hTtV9M68PnjlWm7KkvFGSFxD8dRVU2fQ0hExGLs39UsMVK/ckoHeXHHKOKtBPeVczBCw MUC//OycG4vu0Qn3A0CeEIUlcUKu7E7cklt41zMfMR88e6fwpoah2SPTGK5A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With all "silently resizing" callers of ksize() refactored, remove the
logic in ksize() that would allow it to be used to effectively change
the size of an allocation (bypassing __alloc_size hints, etc). Users
wanting this feature need to either use kmalloc_size_roundup() before an
allocation, or use krealloc() directly.

For kfree_sensitive(), move the unpoisoning logic inline. Replace the
some of the partially open-coded ksize() in __do_krealloc with ksize()
now that it doesn't perform unpoisoning.

Adjust the KUnit tests to match the new ksize() behavior.

Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org
Cc: kasan-dev@googlegroups.com
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
- improve kunit test precision (andreyknvl)
- add Ack (vbabka)
v1: https://lore.kernel.org/all/20221022180455.never.023-kees@kernel.org
---
 mm/kasan/kasan_test.c | 14 +++++++++-----
 mm/slab_common.c      | 26 ++++++++++----------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 7502f03c807c..fc4b22916587 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -821,7 +821,7 @@ static void kasan_global_oob_left(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
-/* Check that ksize() makes the whole object accessible. */
+/* Check that ksize() does NOT unpoison whole object. */
 static void ksize_unpoisons_memory(struct kunit *test)
 {
 	char *ptr;
@@ -829,15 +829,19 @@ static void ksize_unpoisons_memory(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
 	real_size = ksize(ptr);
+	KUNIT_EXPECT_GT(test, real_size, size);
 
 	OPTIMIZER_HIDE_VAR(ptr);
 
-	/* This access shouldn't trigger a KASAN report. */
-	ptr[size] = 'x';
+	/* These accesses shouldn't trigger a KASAN report. */
+	ptr[0] = 'x';
+	ptr[size - 1] = 'x';
 
-	/* This one must. */
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size]);
+	/* These must trigger a KASAN report. */
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);
 
 	kfree(ptr);
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8276022f0da4..27caa57af070 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1335,11 +1335,11 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 	void *ret;
 	size_t ks;
 
-	/* Don't use instrumented ksize to allow precise KASAN poisoning. */
+	/* Check for double-free before calling ksize. */
 	if (likely(!ZERO_OR_NULL_PTR(p))) {
 		if (!kasan_check_byte(p))
 			return NULL;
-		ks = kfence_ksize(p) ?: __ksize(p);
+		ks = ksize(p);
 	} else
 		ks = 0;
 
@@ -1407,21 +1407,21 @@ void kfree_sensitive(const void *p)
 	void *mem = (void *)p;
 
 	ks = ksize(mem);
-	if (ks)
+	if (ks) {
+		kasan_unpoison_range(mem, ks);
 		memzero_explicit(mem, ks);
+	}
 	kfree(mem);
 }
 EXPORT_SYMBOL(kfree_sensitive);
 
 size_t ksize(const void *objp)
 {
-	size_t size;
-
 	/*
-	 * We need to first check that the pointer to the object is valid, and
-	 * only then unpoison the memory. The report printed from ksize() is
-	 * more useful, then when it's printed later when the behaviour could
-	 * be undefined due to a potential use-after-free or double-free.
+	 * We need to first check that the pointer to the object is valid.
+	 * The KASAN report printed from ksize() is more useful, then when
+	 * it's printed later when the behaviour could be undefined due to
+	 * a potential use-after-free or double-free.
 	 *
 	 * We use kasan_check_byte(), which is supported for the hardware
 	 * tag-based KASAN mode, unlike kasan_check_read/write().
@@ -1435,13 +1435,7 @@ size_t ksize(const void *objp)
 	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
 		return 0;
 
-	size = kfence_ksize(objp) ?: __ksize(objp);
-	/*
-	 * We assume that ksize callers could use whole allocated area,
-	 * so we need to unpoison this area.
-	 */
-	kasan_unpoison_range(objp, size);
-	return size;
+	return kfence_ksize(objp) ?: __ksize(objp);
 }
 EXPORT_SYMBOL(ksize);
 
-- 
2.34.1

