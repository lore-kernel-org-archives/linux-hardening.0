Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942DEE645B
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 11:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjIOLAW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 07:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjIOLAS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:18 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C0A19BA
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:57 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-529fa33ac99so1446952a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775596; x=1695380396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOse4MLSxLAQnwPck5JwfSnTM0/2w8+aiHpu8xQSJg0=;
        b=wEBLi8Pqw0u7yFLZgv46Dx9+Atqe+oud6meqog8I47zKzg8Eskqs+OurJC/F0QHH45
         wC/4SdPnnxcNVgcrFJF6UWoxu8QVGVxFeOe3eYmSBvIXfDmmiogJiJzVcw0LPdp3ily8
         SF1bTzPLRBiAxRe2HzPkoIDRIHlffQcWukdD44lbwhoc9ygdlZldIbS7PMwJbCnQk91G
         czbVaEeUnaqpGOxPa9MYmRiuSYSwPdPTmBJ6KBSetdpXmAYYlYElT+1FJmRpVQ5lVtjE
         YLL6tuk0AAPj/zRSdDBxJ1mZcxaxhpl7YDu1dOOJLSQrohRSE+b51uH3V1mKbZYrmbLo
         Qi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775596; x=1695380396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOse4MLSxLAQnwPck5JwfSnTM0/2w8+aiHpu8xQSJg0=;
        b=ofoyYAhBWjYyV4D7M6H1dUiIC8twGi/E4ac5VqqD6+i1b5eihG96mSuFqsXkZTtN4g
         uUApTbCwF5i0dDBAKmZOyXvHFsKzu6T5d5/yAU2P6u0lXPNTHDiFyLUX4WF6FEtXvV0a
         kx9hE7lbeiQtBHsRsNKr2Oz3xfo2PRyIMUQJQO56VOTqpq91kYe2Z51+0Yv6kHAR+igc
         K9WJZP/OxJlXYVDSFPDcPzfei8FntmlMh0XQ212E3AYoxOBHbder1PMzV7RdPJS2KhX9
         jcq5YxQyu+bhhe1Q6vjejZDpAWTvkXonUTzcGP0ZOqWm6K5KhCkuuQ88SQ01llR92U8u
         CZxg==
X-Gm-Message-State: AOJu0YwQu1rMK5MhFM5rRKUqgAzFem2N1kw5JgJWRCys25aOCGf3no2o
        mTE23B0eA6qKUv6DLBblmw2kEDaOoioVWhVIhw==
X-Google-Smtp-Source: AGHT+IFLNNO7nLlngx6UR+g98LJngeXta2Ps2Exu4HntuRM5obt3GthiOTu6TJ2m43o6UrVjvgY27QRf/WNPQWcdWw==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a50:baa4:0:b0:525:442c:2e5d with SMTP
 id x33-20020a50baa4000000b00525442c2e5dmr9427ede.6.1694775595758; Fri, 15 Sep
 2023 03:59:55 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:26 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-8-matteorizzo@google.com>
Subject: [RFC PATCH 07/14] mm/slub: pass slab pointer to the freeptr decode helper
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

This is refactoring in preparation for checking freeptrs for corruption
inside freelist_ptr_decode().

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 mm/slub.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index eaa1256aff89..42e7cc0b4452 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -383,7 +383,8 @@ static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
 }
 
 static inline void *freelist_ptr_decode(const struct kmem_cache *s,
-					freeptr_t ptr, unsigned long ptr_addr)
+					freeptr_t ptr, unsigned long ptr_addr,
+					struct slab *slab)
 {
 	void *decoded;
 
@@ -395,7 +396,8 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
 	return decoded;
 }
 
-static inline void *get_freepointer(struct kmem_cache *s, void *object)
+static inline void *get_freepointer(struct kmem_cache *s, void *object,
+				    struct slab *slab)
 {
 	unsigned long ptr_addr;
 	freeptr_t p;
@@ -403,7 +405,7 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 	object = kasan_reset_tag(object);
 	ptr_addr = (unsigned long)object + s->offset;
 	p = *(freeptr_t *)(ptr_addr);
-	return freelist_ptr_decode(s, p, ptr_addr);
+	return freelist_ptr_decode(s, p, ptr_addr, slab);
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -424,18 +426,19 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
  * get_freepointer_safe() returns initialized memory.
  */
 __no_kmsan_checks
-static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
+static inline void *get_freepointer_safe(struct kmem_cache *s, void *object,
+					     struct slab *slab)
 {
 	unsigned long freepointer_addr;
 	freeptr_t p;
 
 	if (!debug_pagealloc_enabled_static())
-		return get_freepointer(s, object);
+		return get_freepointer(s, object, slab);
 
 	object = kasan_reset_tag(object);
 	freepointer_addr = (unsigned long)object + s->offset;
 	copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
-	return freelist_ptr_decode(s, p, freepointer_addr);
+	return freelist_ptr_decode(s, p, freepointer_addr, slab);
 }
 
 static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
@@ -627,7 +630,7 @@ static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
 
 	bitmap_zero(obj_map, slab->objects);
 
-	for (p = slab->freelist; p; p = get_freepointer(s, p))
+	for (p = slab->freelist; p; p = get_freepointer(s, p, slab))
 		set_bit(__obj_to_index(s, addr, p), obj_map);
 }
 
@@ -937,7 +940,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	print_slab_info(slab);
 
 	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
-	       p, p - addr, get_freepointer(s, p));
+	       p, p - addr, get_freepointer(s, p, slab));
 
 	if (s->flags & SLAB_RED_ZONE)
 		print_section(KERN_ERR, "Redzone  ", p - s->red_left_pad,
@@ -1230,7 +1233,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		return 1;
 
 	/* Check free pointer validity */
-	if (!check_valid_pointer(s, slab, get_freepointer(s, p))) {
+	if (!check_valid_pointer(s, slab, get_freepointer(s, p, slab))) {
 		object_err(s, slab, p, "Freepointer corrupt");
 		/*
 		 * No choice but to zap it and thus lose the remainder
@@ -1298,7 +1301,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 			break;
 		}
 		object = fp;
-		fp = get_freepointer(s, object);
+		fp = get_freepointer(s, object, slab);
 		nr++;
 	}
 
@@ -1810,7 +1813,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		object = next;
 		/* Single objects don't actually contain a freepointer */
 		if (object != old_tail)
-			next = get_freepointer(s, object);
+			next = get_freepointer(s, object, virt_to_slab(object));
 
 		/* If object's reuse doesn't have to be delayed */
 		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
@@ -2161,7 +2164,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	lockdep_assert_held(&n->list_lock);
 
 	object = slab->freelist;
-	slab->freelist = get_freepointer(s, object);
+	slab->freelist = get_freepointer(s, object, slab);
 	slab->inuse++;
 
 	if (!alloc_debug_processing(s, slab, object, orig_size)) {
@@ -2192,7 +2195,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 
 
 	object = slab->freelist;
-	slab->freelist = get_freepointer(s, object);
+	slab->freelist = get_freepointer(s, object, slab);
 	slab->inuse = 1;
 
 	if (!alloc_debug_processing(s, slab, object, orig_size))
@@ -2517,7 +2520,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	freelist_tail = NULL;
 	freelist_iter = freelist;
 	while (freelist_iter) {
-		nextfree = get_freepointer(s, freelist_iter);
+		nextfree = get_freepointer(s, freelist_iter, slab);
 
 		/*
 		 * If 'nextfree' is invalid, it is possible that the object at
@@ -2944,7 +2947,7 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 
 	/* Reached end of constructed freelist yet? */
 	if (object != tail) {
-		object = get_freepointer(s, object);
+		object = get_freepointer(s, object, slab);
 		goto next_object;
 	}
 	checks_ok = true;
@@ -3173,7 +3176,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * That slab must be frozen for per cpu allocations to work.
 	 */
 	VM_BUG_ON(!c->slab->frozen);
-	c->freelist = get_freepointer(s, freelist);
+	c->freelist = get_freepointer(s, freelist, c->slab);
 	c->tid = next_tid(c->tid);
 	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 	return freelist;
@@ -3275,7 +3278,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 * For !pfmemalloc_match() case we don't load freelist so that
 		 * we don't make further mismatched allocations easier.
 		 */
-		deactivate_slab(s, slab, get_freepointer(s, freelist));
+		deactivate_slab(s, slab, get_freepointer(s, freelist, slab));
 		return freelist;
 	}
 
@@ -3377,7 +3380,7 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 	    unlikely(!object || !slab || !node_match(slab, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
-		void *next_object = get_freepointer_safe(s, object);
+		void *next_object = get_freepointer_safe(s, object, slab);
 
 		/*
 		 * The cmpxchg will only match if there was no additional
@@ -3984,7 +3987,7 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 
 			continue; /* goto for-loop */
 		}
-		c->freelist = get_freepointer(s, object);
+		c->freelist = get_freepointer(s, object, c->slab);
 		p[i] = object;
 		maybe_wipe_obj_freeptr(s, p[i]);
 	}
@@ -4275,7 +4278,7 @@ static void early_kmem_cache_node_alloc(int node)
 	init_tracking(kmem_cache_node, n);
 #endif
 	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
-	slab->freelist = get_freepointer(kmem_cache_node, n);
+	slab->freelist = get_freepointer(kmem_cache_node, n, slab);
 	slab->inuse = 1;
 	kmem_cache_node->node[node] = n;
 	init_kmem_cache_node(n);
-- 
2.42.0.459.ge4e396fd5e-goog

