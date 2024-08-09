Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5421741FB;
	Fri,  9 Aug 2024 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188790; cv=none; b=eUho/FCwuZTUq3dOQz/Z9uEyDkLjzXnsN8Xi56QTRM9gZ4r7PU3oE5eAqX62ofu89e+H86Jlquk/1tzzLWjJzd8UBNnNhq9xIXQTIK7hE9tdMhJiTn4LDB2SaQoCB04CCaWu1jnKl90iOHAUd6sUhXROpzBQlYJgIoq3RycGOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188790; c=relaxed/simple;
	bh=WwVEHZxXP/denNiV+dxfYy7hsfC8akgc4PDoJIzTgCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZSjDUol97pCjlsXAncQykW4NErbXCZSpvS9G73S3o0SfHkUE5yFguRxJrJv5187OdX49fOjRHpWyL6PWs37MDMbQqW/cXZx71ahkuc3PqY6NK9z5bvKhLGfRn5vEtMowme6f4oJI39eleOPO3sKX5EDNDUKcW+H7wlKqQbxHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAgXWs1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAgXWs1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C99C4AF11;
	Fri,  9 Aug 2024 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188790;
	bh=WwVEHZxXP/denNiV+dxfYy7hsfC8akgc4PDoJIzTgCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAgXWs1XKo6iAYzTDWoioXqzTgVrNa4MoYZ4pl3diCJ3d8IMaeMQTl3LUdU4MmSNJ
	 moeSkqQ3YonWd/mpWyVpQNXdVhvpFglG6LQ3r1ZlZxG4tJ1UPkeCEKI6TxVTxfjDTU
	 lGRHfrPSDVCBwY5kVX34XejsM3+3wl0+XynFbgCjBw6fkywEUA4Q8Jz9oJcy6oIGbz
	 oEVwUOwqBv22WLCGoFb22ZbuO2H75EAQP60xliAgxoPNmxUrZFdaPLm1a1owS/jL7b
	 XcuYfJ0FqyUH38NLCXBsgiQ6pyQV7eCEWMSnDxxnOD2WX/Nb2OCPf1KWNK+sdyB09Y
	 6HKHxYMV8Vq9w==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/5] slab: Allocate and use per-call-site caches
Date: Fri,  9 Aug 2024 00:33:06 -0700
Message-Id: <20240809073309.2134488-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809072532.work.266-kees@kernel.org>
References: <20240809072532.work.266-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10722; i=kees@kernel.org; h=from:subject; bh=WwVEHZxXP/denNiV+dxfYy7hsfC8akgc4PDoJIzTgCM=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbjxn1Tdz6Xbdh/s6WL17vDgv/KesuvZIWvl70Z+FGn /x65TbrjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgInc/8HIcLbu+bae0p1OfcrS 3ofrO24W5Xt+yPlS1MpqFhTQf9RCiuF/gKqyfHxc5OOXDx6wX+2LmJTo7tm64m3mIyZr87OiVWY 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Use separate per-call-site kmem_cache or kmem_buckets. These are
allocated on demand to avoid wasting memory for unused caches.

A few caches need to be allocated very early to support allocating the
caches themselves: kstrdup(), kvasprintf(), and pcpu_mem_zalloc(). Any
GFP_ATOMIC allocations are currently left to be allocated from
KMALLOC_NORMAL.

With a distro config, /proc/slabinfo grows from ~400 entries to ~2200.

Since this feature (CONFIG_SLAB_PER_SITE) is redundant to
CONFIG_RANDOM_KMALLOC_CACHES, mark it a incompatible. Add Kconfig help
text that compares the features.

Improvements needed:
- Retain call site gfp flags in alloc_tag meta field to:
  - pre-allocate all GFP_ATOMIC caches (since their caches cannot
    be allocated on demand unless we want them to be GFP_ATOMIC
    themselves...)
  - Separate MEMCG allocations as well
- Allocate individual caches within kmem_buckets on demand to
  further reduce memory usage overhead.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/alloc_tag.h |   8 +++
 lib/alloc_tag.c           | 121 +++++++++++++++++++++++++++++++++++---
 mm/Kconfig                |  19 +++++-
 mm/slab_common.c          |   1 +
 mm/slub.c                 |  31 +++++++++-
 5 files changed, 170 insertions(+), 10 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index f5d8c5849b82..c95628f9b049 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -24,6 +24,7 @@ struct alloc_tag_counters {
 struct alloc_meta {
 	/* 0 means non-slab, SIZE_MAX means dynamic, and everything else is fixed-size. */
 	size_t sized;
+	void *cache;
 };
 #define ALLOC_META_INIT(_size)	{		\
 		.sized = (__builtin_constant_p(_size) ? (_size) : SIZE_MAX), \
@@ -216,6 +217,13 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
+#ifdef CONFIG_SLAB_PER_SITE
+void alloc_tag_early_walk(void);
+void alloc_tag_site_init(struct codetag *ct, bool ondemand);
+#else
+static inline void alloc_tag_early_walk(void) {}
+#endif
+
 #define alloc_hooks_tag(_tag, _do_alloc)				\
 ({									\
 	struct alloc_tag * __maybe_unused _old = alloc_tag_save(_tag);	\
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 6d2cb72bf269..e8a66a7c4a6b 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -157,6 +157,89 @@ static void __init procfs_init(void)
 	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
+#ifdef CONFIG_SLAB_PER_SITE
+static bool ondemand_ready;
+
+void alloc_tag_site_init(struct codetag *ct, bool ondemand)
+{
+	struct alloc_tag *tag = ct_to_alloc_tag(ct);
+	char *name;
+	void *p, *old;
+
+	/* Only handle kmalloc allocations. */
+	if (!tag->meta.sized)
+		return;
+
+	/* Must be ready for on-demand allocations. */
+	if (ondemand && !ondemand_ready)
+		return;
+
+	old = READ_ONCE(tag->meta.cache);
+	/* Already allocated? */
+	if (old)
+		return;
+
+	if (tag->meta.sized < SIZE_MAX) {
+		/* Fixed-size allocations. */
+		name = kasprintf(GFP_KERNEL, "f:%zu:%s:%d", tag->meta.sized, ct->function, ct->lineno);
+		if (WARN_ON_ONCE(!name))
+			return;
+		/*
+		 * As with KMALLOC_NORMAL, the entire allocation needs to be
+		 * open to usercopy access. :(
+		 */
+		p = kmem_cache_create_usercopy(name, tag->meta.sized, 0,
+					       SLAB_NO_MERGE, 0, tag->meta.sized,
+					       NULL);
+	} else {
+		/* Dynamically-size allocations. */
+		name = kasprintf(GFP_KERNEL, "d:%s:%d", ct->function, ct->lineno);
+		if (WARN_ON_ONCE(!name))
+			return;
+		p = kmem_buckets_create(name, SLAB_NO_MERGE, 0, UINT_MAX, NULL);
+	}
+	if (p) {
+		if (unlikely(!try_cmpxchg(&tag->meta.cache, &old, p))) {
+			/* We lost the allocation race; clean up. */
+			if (tag->meta.sized < SIZE_MAX)
+				kmem_cache_destroy(p);
+			else
+				kmem_buckets_destroy(p);
+		}
+	}
+	kfree(name);
+}
+
+static void alloc_tag_site_init_early(struct codetag *ct)
+{
+	/* Explicitly initialize the caches needed to initialize caches. */
+	if (strcmp(ct->function, "kstrdup") == 0 ||
+	    strcmp(ct->function, "kvasprintf") == 0 ||
+	    strcmp(ct->function, "pcpu_mem_zalloc") == 0)
+		alloc_tag_site_init(ct, false);
+
+	/* TODO: pre-allocate GFP_ATOMIC caches here. */
+}
+#endif
+
+static void alloc_tag_module_load(struct codetag_type *cttype,
+				  struct codetag_module *cmod)
+{
+#ifdef CONFIG_SLAB_PER_SITE
+	struct codetag_iterator iter;
+	struct codetag *ct;
+
+	iter = codetag_get_ct_iter(cttype);
+	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
+		if (iter.cmod != cmod)
+			continue;
+
+		/* TODO: pre-allocate GFP_ATOMIC caches here. */
+		//alloc_tag_site_init(ct, false);
+	}
+#endif
+}
+
 static bool alloc_tag_module_unload(struct codetag_type *cttype,
 				    struct codetag_module *cmod)
 {
@@ -175,8 +258,21 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 
 		if (WARN(counter.bytes,
 			 "%s:%u module %s func:%s has %llu allocated at module unload",
-			 ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
+			 ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes)) {
 			module_unused = false;
+		}
+#ifdef CONFIG_SLAB_PER_SITE
+		else if (tag->meta.sized) {
+			/* Remove the allocated caches, if possible. */
+			void *p = READ_ONCE(tag->meta.cache);
+
+			WRITE_ONCE(tag->meta.cache, NULL);
+			if (tag->meta.sized < SIZE_MAX)
+				kmem_cache_destroy(p);
+			else
+				kmem_buckets_destroy(p);
+		}
+#endif
 	}
 
 	return module_unused;
@@ -260,15 +356,16 @@ static void __init sysctl_init(void)
 static inline void sysctl_init(void) {}
 #endif /* CONFIG_SYSCTL */
 
+static const struct codetag_type_desc alloc_tag_desc = {
+	.section	= "alloc_tags",
+	.tag_size	= sizeof(struct alloc_tag),
+	.module_load	= alloc_tag_module_load,
+	.module_unload	= alloc_tag_module_unload,
+};
+
 static int __init alloc_tag_init(void)
 {
-	const struct codetag_type_desc desc = {
-		.section	= "alloc_tags",
-		.tag_size	= sizeof(struct alloc_tag),
-		.module_unload	= alloc_tag_module_unload,
-	};
-
-	alloc_tag_cttype = codetag_register_type(&desc);
+	alloc_tag_cttype = codetag_register_type(&alloc_tag_desc);
 	if (IS_ERR(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
@@ -278,3 +375,11 @@ static int __init alloc_tag_init(void)
 	return 0;
 }
 module_init(alloc_tag_init);
+
+#ifdef CONFIG_SLAB_PER_SITE
+void alloc_tag_early_walk(void)
+{
+	codetag_early_walk(&alloc_tag_desc, alloc_tag_site_init_early);
+	ondemand_ready = true;
+}
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 855c63c3270d..4f01cb6dd32e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -302,7 +302,20 @@ config SLAB_PER_SITE
 	default SLAB_FREELIST_HARDENED
 	select SLAB_BUCKETS
 	help
-	  Track sizes of kmalloc() call sites.
+	  As a defense against shared-cache "type confusion" use-after-free
+	  attacks, every kmalloc()-family call allocates from a separate
+	  kmem_cache (or when dynamically sized, kmem_buckets). Attackers
+	  will no longer be able to groom malicious objects via similarly
+	  sized allocations that share the same cache as the target object.
+
+	  This increases the "at rest" kmalloc slab memory usage by
+	  roughly 5x (around 7MiB), and adds the potential for greater
+	  long-term memory fragmentation. However, some workloads
+	  actually see performance improvements when single allocation
+	  sites are hot.
+
+	  For a similar defense, see CONFIG_RANDOM_KMALLOC_CACHES, which
+	  has less memory usage overhead, but is probabilistic.
 
 config SLUB_STATS
 	default n
@@ -331,6 +344,7 @@ config SLUB_CPU_PARTIAL
 config RANDOM_KMALLOC_CACHES
 	default n
 	depends on !SLUB_TINY
+	depends on !SLAB_PER_SITE
 	bool "Randomize slab caches for normal kmalloc"
 	help
 	  A hardening feature that creates multiple copies of slab caches for
@@ -345,6 +359,9 @@ config RANDOM_KMALLOC_CACHES
 	  limited degree of memory and CPU overhead that relates to hardware and
 	  system workload.
 
+	  For a similar defense, see CONFIG_SLAB_PER_SITE, which is
+	  deterministic, but has greater memory usage overhead.
+
 endmenu # Slab allocator options
 
 config SHUFFLE_PAGE_ALLOCATOR
diff --git a/mm/slab_common.c b/mm/slab_common.c
index fc698cba0ebe..09506bfa972c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1040,6 +1040,7 @@ void __init create_kmalloc_caches(void)
 		kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
 						       sizeof(kmem_buckets),
 						       0, SLAB_NO_MERGE, NULL);
+	alloc_tag_early_walk();
 }
 
 /**
diff --git a/mm/slub.c b/mm/slub.c
index 3520acaf9afa..d14102c4b4d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4135,6 +4135,35 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 }
 EXPORT_SYMBOL(__kmalloc_large_node_noprof);
 
+static __always_inline
+struct kmem_cache *choose_slab(size_t size, kmem_buckets *b, gfp_t flags,
+			       unsigned long caller)
+{
+#ifdef CONFIG_SLAB_PER_SITE
+	struct alloc_tag *tag = current->alloc_tag;
+
+	if (!b && tag && tag->meta.sized &&
+	    kmalloc_type(flags, caller) == KMALLOC_NORMAL &&
+	    (flags & GFP_ATOMIC) != GFP_ATOMIC) {
+		void *p = READ_ONCE(tag->meta.cache);
+
+		if (!p && slab_state >= UP) {
+			alloc_tag_site_init(&tag->ct, true);
+			p = READ_ONCE(tag->meta.cache);
+		}
+
+		if (tag->meta.sized < SIZE_MAX) {
+			if (p)
+				return p;
+			/* Otherwise continue with default buckets. */
+		} else {
+			b = p;
+		}
+	}
+#endif
+	return kmalloc_slab(size, b, flags, caller);
+}
+
 static __always_inline
 void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 			unsigned long caller)
@@ -4152,7 +4181,7 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	s = kmalloc_slab(size, b, flags, caller);
+	s = choose_slab(size, b, flags, caller);
 
 	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 	ret = kasan_kmalloc(s, ret, size, flags);
-- 
2.34.1

