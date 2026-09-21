Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CF3B42CC;
	Mon, 21 Sep 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977505; cv=none; b=eO5pXowWc3xAD7tRYXYBvv1MxJGebWjhe6qxnoTbngWIwYXr3t98xrOY9xjCzTYyWs614W1I3tDwaviTuufISZW4VbERmjRRuj0IWP61RQwEIrXG1knLe83x6DnLFtS1QkyBP8mRtvYAhOfyurq9j0964iBcbO/Q0G0nfWWII2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977505; c=relaxed/simple;
	bh=+WGfdR3Y4f4MJOabUzkDEAYVtCQqjvgmchKMVu5bAso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mG5vXLvzuKlTDEduePUHGXHBL6Q7FeQ0qGwVNJ1G8ixts7z9NyH4wn0dWnOCDTLc5KHG7JILPGbelnOOrQ1KbKuC6i3hZ74ALVwH0ASdWWrehWUpgLo0CUbPJhDGSYdD28hTOjzPVfalUQzArSPM2NnznzO2GkXi82m7o6+FhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Tbm2wJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Tbm2wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745871F00898;
	Mon, 21 Sep 2026 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977500;
	bh=L/18n8TfyaFMDLnAYEp51nwGZPC1Y8Qvb7X09zPa7Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/Tbm2wJxme0+N0pPuGOo8l68ppGyPNpDhIC88m3xFlT8W2gs2H0UtOcaFX9iXwkS
	 COcGAExn661bK6PWCy47/Y9KvNRK9Capy8ppPxO3wWFDlJV5njIu70kOH9B8waNcL6
	 d6b/mpFAr35uy3KaVJDRyPlxeT1kPwDY4TDyg3KiNWt9J1VHjqAzIcp80PjutjKnqS
	 K3D9lhTABsKYOqMjzwN3SKVtRrBzxlWF96B+TLvD3c4i7oouEgH78A03DroLWGeF2Z
	 JuJwF8pMShZX1rKiCS5CtTF1YuKEr/PwoCl8dl2GystyIzixncFflxEEHpkeOvvb/l
	 2GcjE3lK1EDJw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 3/7] mm/slab: Add kmem_buckets_destroy()
Date: Mon, 21 Sep 2026 00:58:14 -0700
Message-Id: <20260921075820.1718334-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921075811.too.775-kees@kernel.org>
References: <20260921075811.too.775-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4729; i=kees@kernel.org; h=from:subject; bh=+WGfdR3Y4f4MJOabUzkDEAYVtCQqjvgmchKMVu5bAso=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkbHs9UUVx8Nfu38g2JFUlnXu/wXSKoUZe4uPxUm0ODS qZpdcy7jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkkVjD8z+N5yGySI+I2a/8V v7vmn5ezRey+emMBg+2JhF2itXI8uQz/a1aHH9OSFKp4G/eEN0gx01qHScXVznvTV4XDy6Kd8vg 5AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

kmem_buckets_create() intentionally had no "destroy" counterpart. Every
caller has lived in core kernel code and creates its set once at boot,
so nothing has needed to take one down. However, KUnit tests may be
built module, so we need it now to support the coming tests.

Some caches have size aliases, so the same pointer is stored at more
then one index, so we have to save it, clear all matching instances, and
then free the saved cache pointer. (This is what the bitmap was tracking
before in the "allocation failed" error path.)

When CONFIG_SLAB_BUCKETS=n the whole body compiles away, matching the
ZERO_SIZE_PTR that kmem_buckets_create() hands back in that configuration.

Link: https://lore.kernel.org/all/20240809073309.2134488-1-kees@kernel.org/
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <linux-mm@kvack.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/slab.h |  1 +
 mm/slab_common.c     | 49 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cda126def67a..18a2351f9084 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -893,6 +893,7 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int useroffset, unsigned int usersize,
 				  void (*ctor)(void *));
+void kmem_buckets_destroy(kmem_buckets *bucket);
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cc58f192f349..eb29cfb2f0a9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -434,12 +434,9 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int usersize,
 				  void (*ctor)(void *))
 {
-	unsigned long mask = 0;
 	unsigned int idx;
 	kmem_buckets *b;
 
-	BUILD_BUG_ON(ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]) > BITS_PER_LONG);
-
 	/*
 	 * When the separate buckets API is not built in, just return
 	 * a non-NULL value for the kmem_buckets pointer, which will be
@@ -493,7 +490,6 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 			kfree(cache_name);
 			if (WARN_ON(!(*b)[aligned_idx]))
 				goto fail;
-			set_bit(aligned_idx, &mask);
 		}
 		if (idx != aligned_idx)
 			(*b)[idx] = (*b)[aligned_idx];
@@ -502,14 +498,53 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 	return b;
 
 fail:
-	for_each_set_bit(idx, &mask, ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]))
-		kmem_cache_destroy((*b)[idx]);
-	kmem_cache_free(kmem_buckets_cache, b);
+	kmem_buckets_destroy(b);
 
 	return NULL;
 }
 EXPORT_SYMBOL(kmem_buckets_create);
 
+/**
+ * kmem_buckets_destroy - Destroy a set of caches made by kmem_buckets_create()
+ * @bucket: The set to destroy, which may be NULL.
+ *
+ * Destroys each cache in @bucket and then frees @bucket itself. As for
+ * kmem_cache_destroy(), every object allocated from @bucket must have been
+ * freed beforehand, and @bucket must not be used afterwards.
+ *
+ * Context: Process context. May sleep, as kmem_cache_destroy() takes the
+ *	    slab mutex and can wait on RCU callbacks for each cache.
+ */
+void kmem_buckets_destroy(kmem_buckets *bucket)
+{
+	unsigned int idx, i;
+
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS) || ZERO_OR_NULL_PTR(bucket))
+		return;
+
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		struct kmem_cache *cache = (*bucket)[idx];
+
+		if (!cache)
+			continue;
+
+		/*
+		 * Sizes below arch_slab_minalign() share one cache, which
+		 * kmem_buckets_create() then stores at each of their indices.
+		 * Drop every reference to it before destroying it, so that no
+		 * later pass reads a pointer to a cache that is already gone.
+		 */
+		for (i = idx; i < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); i++)
+			if ((*bucket)[i] == cache)
+				(*bucket)[i] = NULL;
+
+		kmem_cache_destroy(cache);
+	}
+
+	kmem_cache_free(kmem_buckets_cache, bucket);
+}
+EXPORT_SYMBOL(kmem_buckets_destroy);
+
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
  * once or there will be a use-after-free problem. The actual deletion
-- 
2.34.1

