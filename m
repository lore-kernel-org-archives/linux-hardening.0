Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F074ECDFA1
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Oct 2022 23:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJYXg3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiJYXg1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Oct 2022 19:36:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C9F9841
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 16:36:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ez6so12400908pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGtKXigXG9GEUy3d0vDj3qy0ftcRaftXZM1jOrI1Icc=;
        b=dNQjW5t3D8tfppJYPI4FhUKWrCRWqRl5vraJjM+XSqyyGfsQCqbtXk/IzGLlout0kL
         9rC8n0q9VaV2x87PLzOOrnQFXpT1q5NfhXz+WExks9ljvBvt4Y1Cu90Uf2nkHbjZsdwb
         AFh/N2qcgtcQTg3qkkF3HuHldDD8YYah0PSSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGtKXigXG9GEUy3d0vDj3qy0ftcRaftXZM1jOrI1Icc=;
        b=u4XDgg86G2Kbb71fcL2cU/sHXFKevJ5i/QJCZLZ+2SqGSrdyljEVpcPWffHJdr5raS
         wV7QLS+PjL9vaXtv8JGqN0rfMIm5NJKyi2dBKtucNt6NmNjzZP5HM3yzaok+sh8Cvc9D
         zs/rMB9OO4fhvDCQTjNdd34Ww7aM80O7DKsvpUj2nnFWKg5wp1jPe8ItpNnqMFS38CI2
         SgKD3YRkumz1xP+y2ikvOuBhyoTEfVt7v/X/AkFHQnRcQBlx1BvPpiEVc0dFpvPNBBUD
         UXwdmV/m1Ujoq8uL6+5FBcblwRAEJBlASQ74QehSAp+eGaGkhKIqFBX20PMt62TtFdVf
         4hdg==
X-Gm-Message-State: ACrzQf1ykfnpfhIHPwkMMGxMxqO7CkEBl5F50U1bEWxjKDkIHdAdkL7o
        ALFRoW+ZTnp4E8BdA2xI/ZkoOQ==
X-Google-Smtp-Source: AMsMyM67e5J8KuTy6uusYenbNSudfaUf9vI6Vjeqp4+aQ9El3zzLt6CHVs8XnJ4OeyIXbHXZ2kZsMg==
X-Received: by 2002:a17:90b:4c52:b0:20d:489b:5607 with SMTP id np18-20020a17090b4c5200b0020d489b5607mr883820pjb.40.1666740986031;
        Tue, 25 Oct 2022 16:36:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b00186b5c1a715sm1697455plx.182.2022.10.25.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:36:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] mempool: Do not use ksize() for poisoning
Date:   Tue, 25 Oct 2022 16:36:22 -0700
Message-Id: <20221025233421.you.825-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; h=from:subject:message-id; bh=DzRLzcBQvhCrbv8dqqugqEjPL6g0B/ORdhfzQm5GdoI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjWHL23XANz0fyOFVUEswQiVca2LWQjEpYhi04g7Qf yhp2li+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1hy9gAKCRCJcvTf3G3AJgJmD/ 0YsgEIllXxuFczQPOKT5OyXY2E91me/tQO8Z6Gu/9W2iMlsKclcMR9Rv4FAOtfHdgvDip4FLJOLJLc /CKVJKqpYcqOOgMNYRay9vB3WFaRROjtfbxaSRGuqYJaaKlAuMMN6SzsvGcYElMES2eZ5ehr1Z7JSv 0qXKGztFjZqHHEdCxKO4no9wkVm7H7jqcAFN8EnmfqFdTCmXdelGOjUP4QQaOG8HQzfIpTooL6O4lO GT5A3Z6HOoLpxQqP59yMR3MVnHEAMhrTnm2DtZjivUlnCGoTESBO+j6itl18bIgJyfTUIpGUbCAVT2 FNugjNDHkfvzwsObrx7H2wCEJl6IlvQhJ+3zUQD2RKOfhEhs59gKDmwWY2KvgPi7iIZLdkYG4iqYuC HdvUImlPGL34J+keBIuU5AqFua5IhXdCcbDkUuu21mtbAAjApTF5aEdGoxL7TMd1f/c/W+NHv1tIQI ZlMFK7WnxeUdJkvU2MdvWfmQQOQ8Bq4LOkNy5gVle6JSJiT8+rntb6gYRZPQ2F16KPELAwO41z8yRR pRowiBKTghX6N7f5WT7DJistKtwKeWYTPTU6rAQ39FNBx0X5jjLho1958siE1P41CmtPkIHp22AOlL sNopLfijMyInV7h6SkihdcGY+JLhZuH1blJP2c44Qzvf7Pb5St67DbTPx3mw==
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
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: remove ksize() calls instead of adding kmalloc_roundup_size() calls (vbabka)
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

