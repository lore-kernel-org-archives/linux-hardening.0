Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490AEE6458
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 11:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjIOLAV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjIOLAK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:10 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C571713
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:54 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9a9e12a3093so319230866b.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775593; x=1695380393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/q3ouMwQ7IDAIohC0sCavv+JpOlHz5JpjrFwf8Yaow=;
        b=kf7ywg1cK7qdtNseJfNJII+vGPd7GqIfWF5yIxge0QWHLNSZcmfhkFdLuP1xmndcc7
         nSBFVW6bbXgqYdZF44TryJrX6lIXD0llXx/q4W7/HIK/KZL9UHx9DRlyvIlyYDw4ikIO
         9J86p55d8HaGcnaJT81C9lcK4VDFZoSc9Y0DKt1vNPhkgeABErHaTpvAmsOy54Qs6P3v
         TXIZFA7nvgHo6K/GkBdhDBToPm/1JwRQB8rbxbt7C/wuYEYeDJ7WAEJYXuhuTMnr1Irw
         cN37ZbwXueaajQEwjv3mx5ecKdvPGuUxp7fRsw6UgXKUQKlzyp5JhwbOB3tozbjRyo+N
         Du3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775593; x=1695380393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/q3ouMwQ7IDAIohC0sCavv+JpOlHz5JpjrFwf8Yaow=;
        b=L2eXHFj4DzAU+JPWnXNDGQPL3QslWiyyT4QyeG6M7NX0hp555oSvJjTUEM9qT6hWCc
         871W/jS2lIXkGqSkBsPjrpMbpum8nFT/+CDEoey9rDheZb4J34KzWF4GcFrI9p5RjwUT
         0jVdZqQ8dpEVpeA/vBInBYYNOqWMuG/1vKLGai0E6FL3jo5MiUe/vs2HverKcJxbt8JV
         8KQe42ZuxSsgf/jRvmCJ3YF/fpRpyF+2QY5HOdGznvKaR2O3sT1LNRi/JiScDXCAiB7g
         wyI2OsZTV9r7zDSdO3FOTg/bh/KUAfDRh0N7hXNqhF2KTU1aBISrgqU55BbUTiClSgtA
         b2lA==
X-Gm-Message-State: AOJu0YxTvENGCuNXVWuzjoTyuDCNU9refJ8OJWxMt0ltit5I4gkzhkIG
        gaB9qj7NN1OeQ18h2CW8wCiULQQ8HrlhwoOiXQ==
X-Google-Smtp-Source: AGHT+IGzGcqa6kGNtl+Zbc2lxfKKH+MRmw22LvMY2Bcl+linrh96N5epPcLI/8cSAKDbzrfQBk304rpFFgdGLDJl5w==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a17:907:c9aa:b0:9ad:c79d:2a20 with
 SMTP id uj42-20020a170907c9aa00b009adc79d2a20mr11116ejc.1.1694775593399; Fri,
 15 Sep 2023 03:59:53 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:25 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-7-matteorizzo@google.com>
Subject: [RFC PATCH 06/14] mm/slub: pass additional args to alloc_slab_page
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jann Horn <jannh@google.com>

This is refactoring in preparation for SLAB_VIRTUAL.

The implementation of SLAB_VIRTUAL needs access to struct kmem_cache in
alloc_slab_page in order to take unused slabs from the slab freelist,
which is per-cache.

In addition to that it passes two different sets of GFP flags.
meta_gfp_flags is used for the memory backing the metadata region and
page tables, and gfp_flags for the data memory.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9b87afade125..eaa1256aff89 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1869,7 +1869,8 @@ static void folio_clear_slab(struct folio *folio, struct slab *slab)
 	__folio_clear_slab(folio);
 }
 
-static inline struct slab *alloc_slab_page(gfp_t flags, int node,
+static inline struct slab *alloc_slab_page(struct kmem_cache *s,
+		gfp_t meta_flags, gfp_t flags, int node,
 		struct kmem_cache_order_objects oo)
 {
 	struct folio *folio;
@@ -2020,7 +2021,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
 
-	slab = alloc_slab_page(alloc_gfp, node, oo);
+	slab = alloc_slab_page(s, flags, alloc_gfp, node, oo);
 	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
@@ -2028,7 +2029,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(alloc_gfp, node, oo);
+		slab = alloc_slab_page(s, flags, alloc_gfp, node, oo);
 		if (unlikely(!slab))
 			return NULL;
 		stat(s, ORDER_FALLBACK);
-- 
2.42.0.459.ge4e396fd5e-goog

