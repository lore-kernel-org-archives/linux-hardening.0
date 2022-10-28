Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0211CC38A02
	for <linux-hardening@archiver.kernel.org>; Fri, 28 Oct 2022 15:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJ1PxI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1PxH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 Oct 2022 11:53:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12940E0E
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 08:53:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q1so5155946pgl.11
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RapN0FTxN0zsMZ08z7ppgL1l1wyHKn49LaZIgsPjjY=;
        b=g57PKyGkXUSjFuuJXbpUb8o0hZzb0pSDdLmQ0suvld/9O/Q0Zr2XM4eDKPqyJWUUoQ
         jFOg2gH9teVe2ny/kt7qB+WwYLlxnEGRwnB/2ntgiH0GEayB4vdVH0fPGykEr/b5VFdC
         ZenFcOnYoxGAKrORcvhogQoYs7mJaA2v5uNt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RapN0FTxN0zsMZ08z7ppgL1l1wyHKn49LaZIgsPjjY=;
        b=pL7iSaxeWZaVvd1Km6R+JRu+sH8JVwoDkxnIkUtbBldwtvLdgG36cWvQGuulNKuGuC
         3FkTHjV03H+3tEA1mcRdV+uADIC34144uxVMnoy5zi3/FzeSYDqTqKNcyMFOLRmi9lRw
         j1njIS5WJNRxSidmHRLpDCXCQcFlS7I1z/85+c2d+qe+SXfHm7tol7vc2hwv07Fr+OKw
         Y0bLjIJn5TddFOcrgZzczWu5yeamJEdL1pn0h5G6mtMDuqX4SueMd7ab9bSSoIBI9dp8
         EMkTY19gIDV1VcKOnOtS8t5tOa4HMBKG3+ZwgJ5BSIeV9uUprcofLe9UgOwuY5D/Z1q9
         6FCg==
X-Gm-Message-State: ACrzQf1HOMoopFd6iyv5dSAxW3Ps6K1KcjhKwcN2vprjnn8Nc7hwD1jk
        mACoid2zljXrSN03JtmdzIjKNw==
X-Google-Smtp-Source: AMsMyM6AI4VTAtK8hxaa4lpLNKTA8GWdsFpVy9579gMbjiE7P/0qXp5nawV03T22J+f7cp7qn8CF/Q==
X-Received: by 2002:a65:5c0c:0:b0:46e:f582:7378 with SMTP id u12-20020a655c0c000000b0046ef5827378mr195653pgr.120.1666972386070;
        Fri, 28 Oct 2022 08:53:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00000400b0053e4baecc14sm3024810pfk.108.2022.10.28.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:53:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4] mempool: Do not use ksize() for poisoning
Date:   Fri, 28 Oct 2022 08:53:01 -0700
Message-Id: <20221028154823.you.615-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; h=from:subject:message-id; bh=GsDEuQtQBehTnbCGH+DSrMKEOKg+OzR12RyNGPx7PEg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjW/rde6AlUoHw2yv4ICZYBd0pOTO/KK1WOZNXH+JX McX6voGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1v63QAKCRCJcvTf3G3AJofhEA CPPoNca2ZmUW3btRJPcPRFmWI7syDPpe2FAISaMnR9iRv/QVVTD2mr455X1lyFOIYVhH4DTPcux+k0 sEZhsoukzUH9IruZbDUxIZcGHWrfx/Ql1K37O73ygMV70nplbn0vsXXhL9Bjrql8yQbhHLhZB55F7E uhzIVjJtt1WmWjZmCTkLfnqBh0khW0nPBGZmGA2H8xKj9rGWfkdvQOvRxmAjInn+8tS1C8G3qvg4Aa x5A3uD40YTYb39yrB35KCZAZ3AAK/2HpRGJXhDRwf+KKr8UBuv/ZKwtl0uc8EGrxqzTd0wvij78ORU 7Sp32tJUDTVHixO5mf0u4ualW4epFWQEJyBRmLDhTeYjIaY59F7v8mGkmOCgBTB6e1ynLDErk+7dPt LgA5q/TAD19RDO1H/20IYnaYsJAwh9u1lQb5DF2q1gVxOcIwmG1rMq5qPRsLJMn5hXja9JSWCNLgWg CgZtaGq7G5e++BP2sgPYHw3+vxGhm8hcCXsoU/+8xrs52MwdkOjAVgk+WRdHSfzvPd60b5ELHZRNCx SOCaxipTY6GG0e+TsCJgtR3Ne8+0sDA5MVEFh+582MNGSECHMJwUwpRwYMscwr7BYrWg+WQcWUp7GR aq9xH/OtBDw7g+ImGw8UfnkI2o8xpvMAt98io1m6aisddmYX9/ZSMM6PmfYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Nothing appears to be using ksize() within the kmalloc-backed mempools
except the mempool poisoning logic. Use the actual pool size instead
of the ksize() to avoid needing any special handling of the memory as
needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/lkml/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/
Cc: David Rientjes <rientjes@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This replaces mempool-use-kmalloc_size_roundup-to-match-ksize-usage.patch
v4: add review/ack tags, explicitly call out subject change
v3: https://lore.kernel.org/lkml/20221025233421.you.825-kees@kernel.org/
v2: https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
v1: https://lore.kernel.org/lkml/20220923202822.2667581-14-keescook@chromium.org/
---
 mm/mempool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 96488b13a1ef..54204065037d 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -58,7 +58,7 @@ static void check_element(mempool_t *pool, void *element)
 {
 	/* Mempools backed by slab allocator */
 	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
-		__check_element(pool, element, ksize(element));
+		__check_element(pool, element, (size_t)pool->pool_data);
 	} else if (pool->free == mempool_free_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
@@ -81,7 +81,7 @@ static void poison_element(mempool_t *pool, void *element)
 {
 	/* Mempools backed by slab allocator */
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
-		__poison_element(element, ksize(element));
+		__poison_element(element, (size_t)pool->pool_data);
 	} else if (pool->alloc == mempool_alloc_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
@@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_unpoison_range(element, __ksize(element));
+		kasan_unpoison_range(element, (size_t)pool->pool_data);
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
 				     false);
-- 
2.34.1

