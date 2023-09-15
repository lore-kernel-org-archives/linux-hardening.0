Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B72EE6458
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 11:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjIOLAI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjIOLAF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:05 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446CBCD0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:52 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9adb6dd9e94so137301366b.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775590; x=1695380390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWKqeflunudoGymWmoNHHzgvD8T7OkY46quv3dOXpy0=;
        b=y7rwNgx5k+DXr11V2BHWhy4llRFlcX1PV5xnO8aUypv9+5X3Q1RLH6DBPt5Ei6aH/q
         MxB3tr91+IBbtWdSO/Iz60Ku74D9gg4vdywXgL7Kdwzd0JxS7ke/fhSDQEP3g57rh4dy
         lwKdhFHtZoGTAVhH9eQRNbWgKxcSO2VGa4oI9/yXHSCmM1u6xHDDSg7lZyjwRmqcmDZt
         mXjdu88rV0iq2Ilc4zAVdsNx9jp/dk3Ytqc+GcVimQFc1xJnw/GSGP6MxLx3iyQFyO47
         yd+xZQuBp0PT/s0HZufJpypXiSURxaYzoSiDjTvy0d6q++ttBaNr9Dcm5fvlCM6Zhdqq
         bgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775590; x=1695380390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWKqeflunudoGymWmoNHHzgvD8T7OkY46quv3dOXpy0=;
        b=YRMiVFWSCyuzyQilp450A5rtMstxB+Zn5ORJL+9byu8sJH8tkxR8x3iydmv55TEgi/
         xis6mf4vFMkN7tiRJyXYPT1SG38WNFT/o5Ec6+ce/ypB9/BKQ40UZgWJ4JaCj8phCqHP
         NYzmjPtZW+bl23Vl/2K+XnDn5Ak5gE80o4R+IRbLjJwuUmqMA4xCmjdUEKKsC0XkzXIC
         BtAxx2V6sAqppESlJmyJ5cLJEFUthk/HCxNULTo5M4tvETfoAzHY82cLopAqAmQbllDc
         NehzDSoOWFXwuL4G0eTpfGBPAT9+4s6YoJEYQNk6xH10hGMj2vYFlVjDi1ginqj0x7h5
         n6mQ==
X-Gm-Message-State: AOJu0Yw9z8zvoT2gwFazXA0NlJuS6GXr1ESaZNbjkNFZizadJKjJ80nd
        ov/EFCWA+GwJFEJnnbyFoVPggznHdbOWrI31Xg==
X-Google-Smtp-Source: AGHT+IHib2bYQAS4qp2GAjeH5qpDFROM7WBawhFVE9nuJn7ed324ILtD5K90tbrPwgE6ihy4nV/s6H7sq+VLOkV6Ww==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a17:907:890:b0:9ad:a751:2ea3 with SMTP
 id zt16-20020a170907089000b009ada7512ea3mr6741ejb.6.1694775590539; Fri, 15
 Sep 2023 03:59:50 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:24 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-6-matteorizzo@google.com>
Subject: [RFC PATCH 05/14] mm/slub: create folio_set/clear_slab helpers
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

This is refactoring in preparation for SLAB_VIRTUAL. Extract this code
to separate functions so that it's not duplicated in the code that
allocates and frees page with SLAB_VIRTUAL enabled.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 mm/slub.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ad33d9e1601d..9b87afade125 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1849,6 +1849,26 @@ static void *setup_object(struct kmem_cache *s, void *object)
 /*
  * Slab allocation and freeing
  */
+
+static void folio_set_slab(struct folio *folio, struct slab *slab)
+{
+	__folio_set_slab(folio);
+	/* Make the flag visible before any changes to folio->mapping */
+	smp_wmb();
+
+	if (folio_is_pfmemalloc(folio))
+		slab_set_pfmemalloc(slab);
+}
+
+static void folio_clear_slab(struct folio *folio, struct slab *slab)
+{
+	__slab_clear_pfmemalloc(slab);
+	folio->mapping = NULL;
+	/* Make the mapping reset visible before clearing the flag */
+	smp_wmb();
+	__folio_clear_slab(folio);
+}
+
 static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 		struct kmem_cache_order_objects oo)
 {
@@ -1865,11 +1885,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 		return NULL;
 
 	slab = folio_slab(folio);
-	__folio_set_slab(folio);
-	/* Make the flag visible before any changes to folio->mapping */
-	smp_wmb();
-	if (folio_is_pfmemalloc(folio))
-		slab_set_pfmemalloc(slab);
+	folio_set_slab(folio, slab);
 
 	return slab;
 }
@@ -2067,11 +2083,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	int order = folio_order(folio);
 	int pages = 1 << order;
 
-	__slab_clear_pfmemalloc(slab);
-	folio->mapping = NULL;
-	/* Make the mapping reset visible before clearing the flag */
-	smp_wmb();
-	__folio_clear_slab(folio);
+	folio_clear_slab(folio, slab);
 	mm_account_reclaimed_pages(pages);
 	unaccount_slab(slab, order, s);
 	__free_pages(&folio->page, order);
-- 
2.42.0.459.ge4e396fd5e-goog

