Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919A176228;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188790; cv=none; b=imsZ1EDm1kwZH21YMr7eCNzBDPrKz+uMeKpmYf08gUjA1fQJBcQ/A0mlopUPr1eN8t+N0XgZdf0eWvdYNupOGjd96yC0hkPdc7udOOpYaRini9SpiJI92lobYQIiwqXv4PAnBIM/3rDq8zNbX4yMYbaVW6+alg6nFGE8krcUfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188790; c=relaxed/simple;
	bh=Iabo073v2g0BX5idKAlpNK0sS3Na+mbsF9YuoIGYIVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2QqUaVOzniuxkF5S2sPol8m6xwmCRJ4pdmO9Z9uYU+rQ369/aIOhkWuPt/zVoaXmrcylNT1hW+FTBPEiArVjAaZLmP0wkSOol9+7Z3EUMoPKZNa8vQLqpE65JoIhqnvVkwfgzuUQUcUd3t+efKR+XfiaMUV56cgc0IiHiPE/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4q8IAk/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4q8IAk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8720C4AF0F;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188789;
	bh=Iabo073v2g0BX5idKAlpNK0sS3Na+mbsF9YuoIGYIVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4q8IAk/qlgqcTCea3BBJdIf8hDOC1XjjLxhcI8dkm1ljzbm+iszrHUacqp7lGQQq
	 jGNBVMkdhPRB0YBHgDKEbwNi4qZIaA7IOQMRouJlraAAcY8ZANl/rh82rIf2q7a7Sk
	 RGDqTlGc0UkZl79HBkzQlQPhNfE3UMMSY31PiSUNZY49KE4SM+jd9QH+P+ipVYPvlr
	 PHnohauWkmIwt2xg5wEQ8yc8x/rD4IETjsdn1fVLzbTajnMZKrEL/FtYFbIOrNxBUu
	 jCkle8QjxtskMzf4qXmks1dSVdfJo3x06Hf3Uia/frmvQwd2b0c1VatOnwxcL02pJN
	 EqUeRe1J4h/QQ==
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
Subject: [PATCH 4/5] alloc_tag: Track fixed vs dynamic sized kmalloc calls
Date: Fri,  9 Aug 2024 00:33:05 -0700
Message-Id: <20240809073309.2134488-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809072532.work.266-kees@kernel.org>
References: <20240809072532.work.266-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8513; i=kees@kernel.org; h=from:subject; bh=Iabo073v2g0BX5idKAlpNK0sS3Na+mbsF9YuoIGYIVE=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbjxla/OkOZpqjmTXXV1pxl+T8wjPTGhjbs13unfB2Y DSfGRnZUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMBFZZ0aG2zfLDrTphUWynG79 HvZ6UuCs3+Fnq13vX2MPMGJ4Pkd5ESPDrh3z73lW79405Y3IHS2OfPYiTYNZKYUfe4ubfrw2nb2 WGQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For slab allocations, record whether the call site is using a fixed
size (i.e. compile time constant) or a dynamic size. Report the results
in /proc/allocinfo.

Improvements needed:
- examine realloc routines for needed coverage

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
 include/linux/alloc_tag.h | 30 ++++++++++++++++++++++++++----
 include/linux/slab.h      | 16 ++++++++--------
 lib/alloc_tag.c           |  8 ++++++++
 mm/Kconfig                |  8 ++++++++
 4 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8c61ccd161ba..f5d8c5849b82 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -20,6 +20,19 @@ struct alloc_tag_counters {
 	u64 calls;
 };
 
+#ifdef CONFIG_SLAB_PER_SITE
+struct alloc_meta {
+	/* 0 means non-slab, SIZE_MAX means dynamic, and everything else is fixed-size. */
+	size_t sized;
+};
+#define ALLOC_META_INIT(_size)	{		\
+		.sized = (__builtin_constant_p(_size) ? (_size) : SIZE_MAX), \
+	}
+#else
+struct alloc_meta { };
+#define ALLOC_META_INIT(_size)	{ }
+#endif
+
 /*
  * An instance of this structure is created in a special ELF section at every
  * allocation callsite. At runtime, the special section is treated as
@@ -27,6 +40,7 @@ struct alloc_tag_counters {
  */
 struct alloc_tag {
 	struct codetag			ct;
+	struct alloc_meta		meta;
 	struct alloc_tag_counters __percpu	*counters;
 } __aligned(8);
 
@@ -74,19 +88,21 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
  */
 DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
-#define DEFINE_ALLOC_TAG(_alloc_tag)						\
+#define DEFINE_ALLOC_TAG(_alloc_tag, _meta_init)				\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
 	__section("alloc_tags") = {						\
 		.ct = CODE_TAG_INIT,						\
+		.meta = _meta_init,						\
 		.counters = &_shared_alloc_tag };
 
 #else /* ARCH_NEEDS_WEAK_PER_CPU */
 
-#define DEFINE_ALLOC_TAG(_alloc_tag)						\
+#define DEFINE_ALLOC_TAG(_alloc_tag, _meta_init)				\
 	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
 	__section("alloc_tags") = {						\
 		.ct = CODE_TAG_INIT,						\
+		.meta = _meta_init,						\
 		.counters = &_alloc_tag_cntr };
 
 #endif /* ARCH_NEEDS_WEAK_PER_CPU */
@@ -191,7 +207,7 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
-#define DEFINE_ALLOC_TAG(_alloc_tag)
+#define DEFINE_ALLOC_TAG(_alloc_tag, _meta_init)
 static inline bool mem_alloc_profiling_enabled(void) { return false; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
@@ -210,8 +226,14 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
 
 #define alloc_hooks(_do_alloc)						\
 ({									\
-	DEFINE_ALLOC_TAG(_alloc_tag);					\
+	DEFINE_ALLOC_TAG(_alloc_tag, { });				\
 	alloc_hooks_tag(&_alloc_tag, _do_alloc);			\
 })
 
+#define alloc_sized_hooks(_do_alloc, _size, ...)			\
+({									\
+	DEFINE_ALLOC_TAG(_alloc_tag, ALLOC_META_INIT(_size));		\
+	alloc_hooks_tag(&_alloc_tag, _do_alloc(_size, __VA_ARGS__));	\
+})
+
 #endif /* _LINUX_ALLOC_TAG_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 86cb61a0102c..314d24c79e05 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -541,7 +541,7 @@ static_assert(PAGE_SHIFT <= 20);
  */
 void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
 			      gfp_t flags) __assume_slab_alignment __malloc;
-#define kmem_cache_alloc(...)			alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
+#define kmem_cache_alloc(...)		alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
 
 void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			    gfp_t gfpflags) __assume_slab_alignment __malloc;
@@ -685,7 +685,7 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 	}
 	return __kmalloc_noprof(size, flags);
 }
-#define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
+#define kmalloc(size, ...)	alloc_sized_hooks(kmalloc_noprof, size, __VA_ARGS__)
 
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
@@ -708,7 +708,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
 	}
 	return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node);
 }
-#define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
+#define kmalloc_node(size, ...)		alloc_sized_hooks(kmalloc_node_noprof, size, __VA_ARGS__)
 
 /**
  * kmalloc_array - allocate memory for an array.
@@ -726,7 +726,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
 		return kmalloc_noprof(bytes, flags);
 	return kmalloc_noprof(bytes, flags);
 }
-#define kmalloc_array(...)			alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
+#define kmalloc_array(...)		alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
 
 /**
  * krealloc_array - reallocate memory for an array.
@@ -761,8 +761,8 @@ void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flag
 					 unsigned long caller) __alloc_size(1);
 #define kmalloc_node_track_caller_noprof(size, flags, node, caller) \
 	__kmalloc_node_track_caller_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node, caller)
-#define kmalloc_node_track_caller(...)		\
-	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
+#define kmalloc_node_track_caller(size, ...)		\
+	alloc_sized_hooks(kmalloc_node_track_caller_noprof, size, __VA_ARGS__, _RET_IP_)
 
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
@@ -807,13 +807,13 @@ static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 {
 	return kmalloc_noprof(size, flags | __GFP_ZERO);
 }
-#define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
+#define kzalloc(size, ...)			alloc_sized_hooks(kzalloc_noprof, size, __VA_ARGS__)
 #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
 void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node) __alloc_size(1);
 #define kvmalloc_node_noprof(size, flags, node)	\
 	__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node)
-#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
+#define kvmalloc_node(size, ...)		alloc_sized_hooks(kvmalloc_node_noprof, size, __VA_ARGS__)
 
 #define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
 #define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flags, NUMA_NO_NODE)
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..6d2cb72bf269 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -78,6 +78,14 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
 	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
 	codetag_to_text(out, ct);
+#ifdef CONFIG_SLAB_PER_SITE
+	seq_buf_putc(out, ' ');
+	seq_buf_printf(out, "size:%s(%zu) slab:%s",
+				tag->meta.sized == 0 ? "non-slab" :
+					tag->meta.sized == SIZE_MAX ? "dynamic" : "fixed",
+				tag->meta.sized == SIZE_MAX ? 0 : tag->meta.sized,
+				tag->meta.cache ? "ready" : "unused");
+#endif
 	seq_buf_putc(out, ' ');
 	seq_buf_putc(out, '\n');
 }
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..855c63c3270d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -296,6 +296,14 @@ config SLAB_BUCKETS
 
 	  If unsure, say Y.
 
+config SLAB_PER_SITE
+	bool "Separate slab allocations by call size"
+	depends on !SLUB_TINY
+	default SLAB_FREELIST_HARDENED
+	select SLAB_BUCKETS
+	help
+	  Track sizes of kmalloc() call sites.
+
 config SLUB_STATS
 	default n
 	bool "Enable performance statistics"
-- 
2.34.1

