Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87C54F84
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633433; cv=none; b=DV56qHfVauarpcDij9Q275Zy5MyLKKIOoIDi1ji4XPEvCWyD2zp/GnrFcTIoOD9POuOwt7qPeKCHuSP0l3BVwC4QQGc2R8hczUdNycGoNzdjt7MZh++7dhEDPGk4/QKfaByT9/Rid3v2OcqsgGU1uENfdTuVHadMW4+9anl7EKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633433; c=relaxed/simple;
	bh=dsYwePKLsCLMzShH9MEQL3PgSxerM2N+02XNBrgQB3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOQQP0XPVzSCTC+DY5lhOqvjhs+2vfly3qxjukRtRcCfjIk4mfU1VbDaxGMtjzGp/wliBua/xMvPRm3bFx9suaZHYPYbXxow+dEXri+iyDnQ5y3N1LCdO5RlV1kTat0t6oqpoWgOLSELWSGren4lzdpc7p+GsXxBAwaJuSxynGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DzqiGsMv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DzqiGsMv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dcad814986so49090655ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 02:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633431; x=1710238231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCac96MRWhgh1/2EEmwcpolePHb0x1wbAjOzVa8BY+0=;
        b=DzqiGsMvnyuPX9FYpscrIGebjxFCgVqN8A4eMd5SDSMtEnT7/iK1cl5+LkAeASNtCH
         vq1PFFDl3DXQo6QPaxBMVlxhJ/NOusiSP/iXdVA2gnLBaxqMzUH+yut0IWq+rcNABnzQ
         59x8w3H71un7a8F7JQRBvIZ45eZp+iuHOnu7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633431; x=1710238231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCac96MRWhgh1/2EEmwcpolePHb0x1wbAjOzVa8BY+0=;
        b=xOQXMU7VQmClT2Ts+bWTSvdD40LiAJDAhkFIVZQ1/929z/V9ILH9/ZAr/6RrXt+OzO
         CkKUUK8gw1+iRAWs0Wxa+4DGsFypBKi/SpYKfsW4bYt1La+6z8UkBYps3coVnXQQvmaj
         inP8FX6Yv0Q9XZEVB1AklrKewsMtH4ucS/mAj0x5e6tEWSHCMVFxEz39kVkUn4rx2dBt
         8Qxku++rBjLJNsk4/0Bm+O0FYECEfKJi6UVtpBKdX/Jm0SVFe1zS5JT1cuVBAkx8qMhL
         EXxlCt1khT6+OBJ2USvaiZDHpAl8+t5UWgCyU35smTKjTRhqg4WzqRja2AreayJhpaTa
         29Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXvuFOjlytBdQ4HkBJDsUmZDSnvkEkd1DaeKVRoaLYZCVxNCrjD+jCOFJvLCPlHO6tfS7ojPSOD1bhziRio3CMlee06Yktg5JJMM3sjiG7Y
X-Gm-Message-State: AOJu0Yya5Ii0nlI9mqRqOtkcbMBqx2MKEeXCXnLu+Qh1l6LX0sSunEk+
	pAfIoEL0wvpENfkjLdGrBvkR7TcqYmTJfSPdRx1a5xwdmsy48OTjNEVHEnoYcQ==
X-Google-Smtp-Source: AGHT+IGQD7egJY3N2jy+qTOLk98RlzGpfSgXtQ8qNR83/EYIZpLvDqeKxbLyOSOxTxFrRo9HzKuI6Q==
X-Received: by 2002:a17:903:230a:b0:1dc:fb9d:402d with SMTP id d10-20020a170903230a00b001dcfb9d402dmr1584663plh.58.1709633430745;
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b001dc9893b03bsm10063682plh.272.2024.03.05.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:27 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] slub: Plumb kmem_buckets into __do_kmalloc_node()
Date: Tue,  5 Mar 2024 02:10:18 -0800
Message-Id: <20240305101026.694758-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5763; i=keescook@chromium.org;
 h=from:subject; bh=dsYwePKLsCLMzShH9MEQL3PgSxerM2N+02XNBrgQB3U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+Qh5OvUkS2WLPejBFffVYr3X7AdnuJ+g+ss
 wawW9pNc9iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 Jpz5D/90L2rsJJvl6+P+wDTk00KFpS0yvEOEnTFGCVFHdm1gLjjRgBEZOCCPWclrHgGTkc8hBia
 nOccJ3xAylGH42H9q91nYChjlw/IZUry4o+uK9hKbxXcdC57QMGm38XenTvoOd4Eeqry07ryFmS
 Vtt0qurq/+5ki/6NecKkeipCrrNoA5RCxIDY0d95UiJV9EO4VZiWoeJ6j+YW6sCHuYqojJUmth8
 nASULi9PDpCRxUlhbDJGHsgd7vhSSVKhr+iAVeILIgKu0ABrT+JLWABfwImg0azZt5Ls1q6akOw
 gnS+llQjZPPJ3vLk3Yqy3vdLff1gpUvad4G0TTJ69rOlneNSxmYTtrZZcxO/7jqHYl3Y3+pZWcI
 Ag/9AGf2AlCALy0WdUlBXXNfJE4lwywJnBfsr7GkeTtnd8JhTwB2w92l+xuHv5JUmzB5cSk6EOK
 dLaYXgNTlKnMTIq8eiOLrYhtEZGOpGgC15pVSSGiUBGviTyv+Rdi59+L+NVkvcHyG9z+2qVDc9/
 Lvm8+g1VDnXM8KSNOfUFbX48M+wlbPFG1fhjcwxttYIsH2AqUtWu8K48KlXf5ugIsLGlhRQmjEX
 8bFw/IhfXee/9Bt9phiU1TThOqIbodEUWlAb14Y/A/0YMUIOJbkeUWTR5mjkPZDaIFUh0MEGkE/ lg0QYFHUdAVLRJg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To be able to choose which buckets to allocate from, make the buckets
available to the lower level kmalloc interfaces.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/slab.h |  8 ++++----
 lib/fortify_kunit.c  |  2 +-
 mm/slab.h            |  6 ++++--
 mm/slab_common.c     |  2 +-
 mm/slub.c            | 12 ++++++------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 55059faf166c..1cc1a7637b56 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -508,8 +508,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
+void *__kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node)
+		     __assume_kmalloc_alignment __alloc_size(2);
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
 									 __malloc;
 
@@ -608,7 +608,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node(size, flags, node);
+	return __kmalloc_node(NULL, size, flags, node);
 }
 
 /**
@@ -686,7 +686,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size,
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node(bytes, flags, node);
-	return __kmalloc_node(bytes, flags, node);
+	return __kmalloc_node(NULL, bytes, flags, node);
 }
 
 static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 2e4fedc81621..c44400b577f3 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -182,7 +182,7 @@ static void alloc_size_##allocator##_dynamic_test(struct kunit *test)	\
 	checker(expected_size, __kmalloc(alloc_size, gfp),		\
 		kfree(p));						\
 	checker(expected_size,						\
-		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
+		__kmalloc_node(NULL, alloc_size, gfp, NUMA_NO_NODE),	\
 		kfree(p));						\
 									\
 	orig = kmalloc(alloc_size, gfp);				\
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..931f261bde48 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -404,16 +404,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
  * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
  */
 static inline struct kmem_cache *
-kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
+kmalloc_slab(kmem_buckets *b, size_t size, gfp_t flags, unsigned long caller)
 {
 	unsigned int index;
 
+	if (!b)
+		b = &kmalloc_caches[kmalloc_type(flags, caller)];
 	if (size <= 192)
 		index = kmalloc_size_index[size_index_elem(size)];
 	else
 		index = fls(size - 1);
 
-	return kmalloc_caches[kmalloc_type(flags, caller)][index];
+	return (*b)[index];
 }
 
 gfp_t kmalloc_fix_flags(gfp_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8787cf17d6e4..1d0f25b6ae91 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -698,7 +698,7 @@ size_t kmalloc_size_roundup(size_t size)
 		 * The flags don't matter since size_index is common to all.
 		 * Neither does the caller for just getting ->object_size.
 		 */
-		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
+		return kmalloc_slab(NULL, size, GFP_KERNEL, 0)->object_size;
 	}
 
 	/* Above the smaller buckets, size is a multiple of page size. */
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..71220b4b1f79 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3959,7 +3959,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(kmalloc_large_node);
 
 static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+void *__do_kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node,
 			unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -3975,7 +3975,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	s = kmalloc_slab(size, flags, caller);
+	s = kmalloc_slab(b, size, flags, caller);
 
 	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 	ret = kasan_kmalloc(s, ret, size, flags);
@@ -3983,22 +3983,22 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	return ret;
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
+void *__kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node)
 {
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+	return __do_kmalloc_node(b, size, flags, node, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_node);
 
 void *__kmalloc(size_t size, gfp_t flags)
 {
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+	return __do_kmalloc_node(NULL, size, flags, NUMA_NO_NODE, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc);
 
 void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 				  int node, unsigned long caller)
 {
-	return __do_kmalloc_node(size, flags, node, caller);
+	return __do_kmalloc_node(NULL, size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-- 
2.34.1

