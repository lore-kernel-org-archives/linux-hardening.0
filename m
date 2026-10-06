Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB203AC0C3;
	Tue,  6 Oct 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278439; cv=none; b=bk4sYbYh3COjat903fx37xrmNgzRtCrCEBW68DFNlTa5hCAB1Z7+BOrjH3HFjiyttuzqPYjisSLYbnsMZtiar4P/nOUPK/p8+CJ4PhE5CkXUhmrZeqT5cVEcMwZqUZ5grQzRWWLoCTIoPtEay64Swa/7AIkqL6NBcDxrva3ngto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278439; c=relaxed/simple;
	bh=AI556dgcmDFEiUNFpt0nE2tTt5VEwxJ8p0QOtjqe2Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdR8gj3O/QpT+H3BKMUUUqyFVjbj67US+BmyEpEUiUhxNHHzV85zKHeL+Tnbw4s3NOrB6mCFunjPX3b+lLy/dgfZ8M6N2lsX55HS1hSpn+JhpJin4zVm2oIuWMYnLDA6mKspyrBu/Mjo12eFzURiz2b43UnzGI/WmcBYVOfWewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ4wYMkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ4wYMkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1601F0089E;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278436;
	bh=r5SQ+2kIxztKujOxzR77oFFLlb4omNpweC880YzyU/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQ4wYMkY00Ex9Qr8zNd8lCDm5MIFeTYX6K1i4Vz6QAO+bcS5+D7kuBRd62KxXTW5T
	 kC30EnTBpWG2xHCYvqhhoyIt0bEpyeC8Dk61mohcWYBb2MG0GLAknHPjE+iQxuK3pM
	 5TzQvQrWoEVu09lM4wS2A+NXCeIyhVKMfcSgDqQhUvv2dbdwncTScxlUwfpanfVuT2
	 4gxxTOTU44cQa4rPyyL4tKG7+VOO9Dcw1PXEaL9kQWKJnVBjQnvCxSc/VC4TpDWR4U
	 DZ5AToxXNDPR29+bLWHUemAy3paMXR45Tb8QilEZshgGXL22El9RTFs0AX4zVQPoew
	 mJR//XmSB97Zg==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 5/8] mm/slab: Add kmem_buckets_destroy()
Date: Tue,  6 Oct 2026 02:20:31 -0700
Message-ID: <20261006092035.166776-5-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006092030.got.500-kees@kernel.org>
References: <20261006092030.got.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4334; i=kees@kernel.org; h=from:subject; bh=AI556dgcmDFEiUNFpt0nE2tTt5VEwxJ8p0QOtjqe2Tg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlH9iZ8m1ofIzR7u/LerWfWr5YWdV6tbrPhdkrQv9yWP l+vX5MtO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACby6CrDP5Pg1iuu6UEHd354 arCgxT3x4YIcq/StnE83aVh/MV2aPYvhf4BNx+dJXgZPD7jPTan8dHz9wWMOFo0Pt3YevJ5umrV sNT8A
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
 include/linux/slab.h |  1 +
 mm/slab_common.c     | 50 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 31f97e2579a7..034d4d0ece00 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -892,6 +892,7 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
 				  unsigned int usersize);
+void kmem_buckets_destroy(kmem_buckets *bucket);
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 885aafa23da7..fb1dd15953a7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -430,12 +430,9 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
 				  unsigned int usersize)
 {
-	unsigned long mask = 0;
 	unsigned int idx;
 	kmem_buckets *b;
 
-	BUILD_BUG_ON(ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]) > BITS_PER_LONG);
-
 	/*
 	 * When the separate buckets API is not built in, just return
 	 * a non-NULL value for the kmem_buckets pointer, which will be
@@ -487,7 +484,6 @@ kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
 			kfree(cache_name);
 			if (WARN_ON(!(*b)[aligned_idx]))
 				goto fail;
-			set_bit(aligned_idx, &mask);
 		}
 		if (idx != aligned_idx)
 			(*b)[idx] = (*b)[aligned_idx];
@@ -496,14 +492,54 @@ kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
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
+		 * Sizes that kmalloc rounds up to a larger size class share
+		 * that class's cache, which kmem_buckets_create() then stores
+		 * at each of their indices.
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
2.55.0

