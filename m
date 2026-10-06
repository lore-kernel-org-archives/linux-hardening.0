Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D73AB48F;
	Tue,  6 Oct 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278439; cv=none; b=Sz77cS5mnGVc1U9i/+qjR9BBbkJfnHCNor18k+3/6SZpLiFkOWnPaulY3d4o7HbCsnfSS1+BiIvWYUitbjfNL/usxz2wwfQB0nAm2EwUtyny9VxjitnYrSKOYDnIDi7TL93B/mIDthIfk5Y4CBc7oF4q7wCHpREMc4oa15jfCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278439; c=relaxed/simple;
	bh=k2v7XTUE7M2oSlV7PbZULb9YGZZnAP5BYpCfw9riwUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm5ISMN4SdHocjpxt60L4/uF12EMc4/2K8swjoEz3bILHTFyEHEgzncH5QV7X4UNJD0Q8z+nR42G0D/Jw647zChewS+a92gARoxb0M4tMyyVYLyZ97s4T1T1Uno+dvTBeUfS/y46kocjVDYiew1Q222k/oSlm8k+OceqX5ZaCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4co+Zpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4co+Zpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7096B1F0089F;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278436;
	bh=RRyPEkZ+ZfmK6tjBW72oAefzXONIUsLRfqoAHzypc3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4co+ZpcCJ8t4bVYxlz7ppJ19xOX2Z+P98GC60KCa3ERMO6O69lS8UC7MM18SoDvI
	 s/Lgo1ZJuQB2Qtii2akqe1NpJ23hbjsi7E7wRXd6uwZjYPXaJW688bmmFgThgH0Bli
	 fBhMY2nIMwW0beaDf3H9t1SM8uZHAf/aInl90KsT3wI0nEJEl1jqsh8O41wrXJ//+t
	 KkGZJ4s0djlVAe5fowLygTFmLbQTFc7eqFy/HZAgxTo36VICiJ8IO/IPJBViINoptL
	 x/jr+7NXYQk4EB67SCnunmjnvoURxxDMxbDMzCWh0huDtBXlE99Fx/Q1Syqk64vUaz
	 y1BkZgYGM8J3Q==
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
Subject: [PATCH net-next v6 6/8] mm/slab: Add tests for the existing kmem_buckets behaviour
Date: Tue,  6 Oct 2026 02:20:32 -0700
Message-ID: <20261006092035.166776-6-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006092030.got.500-kees@kernel.org>
References: <20261006092030.got.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10322; i=kees@kernel.org; h=from:subject; bh=k2v7XTUE7M2oSlV7PbZULb9YGZZnAP5BYpCfw9riwUY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlH9iaWaF63ar82eZX4n72zhZjuJhl3ezPJP9m8XOrww rDTp4Ind5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzk7zFGho1CehqnJk+3udFt l/BRcn2Y6Zql6tKzHpVrWiUYJK43vMLw3133yMTfGtwn007fVc7+8yRgXxv/3Hu7VDc+zuea7vN TiAEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

kmem_buckets has had no test coverage since it was added. Add tests,
including stuff unique to the bucket design:

 - A bucket allocation comes from a cache of the set's own, and that
   cache carries SLAB_NO_MERGE.

 - Each size is served by a cache of the set, of the size kmalloc()
   rounds it up to, including 96 and 192, which are not powers of two and
   which kmalloc shares with a larger class on some configurations. Sizes
   above KMALLOC_MAX_CACHE_SIZE go to the page allocator instead, bucket
   set or not.

 - Each cache is aligned like the kmalloc cache it mirrors.

 - With CONFIG_SLAB_BUCKETS=n, kmem_buckets_create() still returns a
   non-NULL (zero size alloc pointer), so that callers only have to check
   for failure, and allocations through it come from the general caches.

 - Destroying a set takes its caches down rather than only freeing the
   set, which is what a module creating one on each load depends on.
   A set freed without its caches would leave the names taken, and the
   next load would warn about every one of them. This test skips when
   KFENCE serves its allocation, since a KFENCE object is in none of the
   cache's slabs for the teardown to find.

The tests skip rather than compile out, which is useful for testing
the CONFIG_SLAB_BUCKETS=n behaviors.

Built and tests passing (with expected skips) on ARCH=x86_64 defconfig
with GCC 16.2.0, with CONFIG_SLAB_BUCKETS as y and n.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/tests/slub_kunit.c | 228 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index e3b63f0338d5..a2a15a49c5d7 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <kunit/resource.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -9,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/perf_event.h>
 #include <linux/kprobes.h>
+#include <linux/kfence.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -474,6 +476,227 @@ static int test_init(struct kunit *test)
 	return 0;
 }
 
+/* Destroy buckets on test exit so a failed KUNIT_ASSERT_*() doesn't leak. */
+KUNIT_DEFINE_ACTION_WRAPPER(destroy_buckets, kmem_buckets_destroy, kmem_buckets *);
+
+#define KUNIT_ASSERT_BUCKETS_CREATED(test, b)					\
+	do {									\
+		KUNIT_ASSERT_NOT_NULL(test, b);					\
+		KUNIT_ASSERT_EQ(test, 0,					\
+				kunit_add_action_or_reset(test,			\
+							  destroy_buckets, b)); \
+	} while (0)
+
+/*
+ * The cache an allocation came from, or NULL if it came from no cache at
+ * all, e.g. a size too big for any of them is served by the page allocator.
+ */
+static struct kmem_cache *cache_of(void *p)
+{
+	struct slab *slab = virt_to_slab(p);
+
+	return slab ? slab->slab_cache : NULL;
+}
+
+/*
+ * A bucket set exists to keep its allocations out of the caches everything
+ * else uses, so check the two things that make that true: they come from a
+ * cache of the set's own, and that cache is never merged into another.
+ */
+static void test_kmem_buckets_isolation(struct kunit *test)
+{
+	struct kmem_cache *bucket_cache, *general_cache;
+	kmem_buckets *b;
+	void *p, *q;
+
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		kunit_skip(test, "needs CONFIG_SLAB_BUCKETS");
+
+	b = kmem_buckets_create("isolated_buckets", 0, INT_MAX);
+	KUNIT_ASSERT_BUCKETS_CREATED(test, b);
+
+	/*
+	 * Free each allocation before asserting on the next one: the cache
+	 * outlives its objects, so nothing below needs them, and an assertion
+	 * that leaves one behind would make the deferred teardown report a
+	 * cache that is still in use.
+	 */
+	p = kmem_buckets_alloc(b, 128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	bucket_cache = cache_of(p);
+	kfree(p);
+	KUNIT_ASSERT_NOT_NULL(test, bucket_cache);
+
+	KUNIT_EXPECT_TRUE_MSG(test, strstarts(bucket_cache->name, "isolated_buckets-"),
+			      "expected a bucket cache, got %s", bucket_cache->name);
+
+	/*
+	 * Cache merging is on by default, and a bucket cache merged into a
+	 * same-sized general one would quietly undo the whole separation.
+	 */
+	KUNIT_EXPECT_TRUE(test, bucket_cache->flags & SLAB_NO_MERGE);
+
+	q = kmalloc(128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, q);
+	general_cache = cache_of(q);
+	kfree(q);
+	KUNIT_ASSERT_NOT_NULL(test, general_cache);
+
+	KUNIT_EXPECT_PTR_NE(test, bucket_cache, general_cache);
+}
+
+/*
+ * Each size is served by a cache of the set, of the size kmalloc() rounds it
+ * up to, including the size classes that are not powers of two, which kmalloc
+ * shares with a larger class on some configurations. Sizes past the largest
+ * cache are served by the page allocator, bucket set or not.
+ */
+static void test_kmem_buckets_sizes(struct kunit *test)
+{
+	static const size_t sizes[] = { 8, 96, 192, 1024, 4096 };
+	struct kmem_cache *c;
+	kmem_buckets *b;
+	void *p;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		kunit_skip(test, "needs CONFIG_SLAB_BUCKETS");
+
+	b = kmem_buckets_create("sized_buckets", 0, INT_MAX);
+	KUNIT_ASSERT_BUCKETS_CREATED(test, b);
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		p = kmem_buckets_alloc(b, sizes[i], GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, p);
+		c = cache_of(p);
+		kfree(p);
+		KUNIT_ASSERT_NOT_NULL(test, c);
+
+		KUNIT_EXPECT_TRUE_MSG(test, strstarts(c->name, "sized_buckets-"),
+				      "size %zu: expected a bucket cache, got %s",
+				      sizes[i], c->name);
+		KUNIT_EXPECT_EQ_MSG(test, c->object_size,
+				    kmalloc_size_roundup(sizes[i]),
+				    "size %zu: served by %s", sizes[i], c->name);
+	}
+
+	/* Too big for any cache: a folio from the page allocator, not a slab. */
+	p = kmem_buckets_alloc(b, KMALLOC_MAX_CACHE_SIZE + 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	c = cache_of(p);
+	kfree(p);
+
+	KUNIT_EXPECT_NULL(test, c);
+}
+
+/*
+ * A bucket cache stands in for a kmalloc cache, so it has to be aligned like
+ * one. The DMA layer decides whether a buffer needs bouncing from its size,
+ * on the grounds that a kmalloc cache of that size is already aligned for
+ * the device, so a weaker alignment here is not something a caller can see
+ * coming. Without slab debugging the size implies the alignment and this
+ * holds either way; with it, only the cache's own alignment does.
+ */
+static void test_kmem_buckets_alignment(struct kunit *test)
+{
+	static const size_t sizes[] = { 128, 512, 2048 };
+	struct kmem_cache *bucket_cache, *general_cache;
+	kmem_buckets *b;
+	void *p;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		kunit_skip(test, "needs CONFIG_SLAB_BUCKETS");
+
+	b = kmem_buckets_create("aligned_buckets", 0, INT_MAX);
+	KUNIT_ASSERT_BUCKETS_CREATED(test, b);
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		p = kmem_buckets_alloc(b, sizes[i], GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, p);
+		bucket_cache = cache_of(p);
+		KUNIT_EXPECT_TRUE_MSG(test,
+				      IS_ALIGNED((unsigned long)p, ARCH_DMA_MINALIGN),
+				      "size %zu: object %p is not %d byte aligned",
+				      sizes[i], p, (int)ARCH_DMA_MINALIGN);
+		kfree(p);
+
+		p = kmalloc(sizes[i], GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, p);
+		general_cache = cache_of(p);
+		kfree(p);
+
+		KUNIT_ASSERT_NOT_NULL(test, bucket_cache);
+		KUNIT_ASSERT_NOT_NULL(test, general_cache);
+		KUNIT_EXPECT_EQ_MSG(test, bucket_cache->align, general_cache->align,
+				    "size %zu: bucket cache aligned to %u, %s to %u",
+				    sizes[i], bucket_cache->align,
+				    general_cache->name, general_cache->align);
+	}
+}
+
+/*
+ * With the feature compiled out, kmem_buckets_create() still returns
+ * something non-NULL so that callers only have to check for failure, and
+ * allocations through it work (i.e. come from the general caches).
+ */
+static void test_kmem_buckets_disabled(struct kunit *test)
+{
+	kmem_buckets *b;
+	struct kmem_cache *c;
+	void *p;
+
+	if (IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		kunit_skip(test, "only meaningful without CONFIG_SLAB_BUCKETS");
+
+	b = kmem_buckets_create("disabled_buckets", 0, INT_MAX);
+	KUNIT_ASSERT_BUCKETS_CREATED(test, b);
+
+	p = kmem_buckets_alloc(b, 128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	c = cache_of(p);
+	kfree(p);
+	KUNIT_ASSERT_NOT_NULL(test, c);
+
+	KUNIT_EXPECT_TRUE_MSG(test, !strstarts(c->name, "disabled_buckets-"),
+			      "expected a general cache, got %s", c->name);
+}
+
+/* Destroying a set has to take its caches down, not just free the set. */
+static void test_kmem_buckets_destroy(struct kunit *test)
+{
+	kmem_buckets *b;
+	void *p;
+
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		kunit_skip(test, "needs CONFIG_SLAB_BUCKETS");
+
+	b = kmem_buckets_create("destroyed_buckets", 0, INT_MAX);
+	KUNIT_ASSERT_BUCKETS_CREATED(test, b);
+
+	/*
+	 * Deliberately leaked, as test_leak_destroy() leaks its own: the
+	 * teardown below has to find it. kmem_cache_destroy() unlists the
+	 * cache either way, so the name is still released.
+	 */
+	p = kmem_buckets_alloc(b, 128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+
+	/*
+	 * A KFENCE object is in none of the cache's slabs, so the teardown
+	 * would not find it to report.
+	 */
+	if (is_kfence_address(p)) {
+		kfree(p);
+		kunit_skip(test, "the allocation came from KFENCE");
+	}
+
+	/* Tear the set down now, rather than at exit, to check the report. */
+	kunit_release_action(test, destroy_buckets, b);
+
+	KUNIT_EXPECT_EQ(test, 2, slab_errors);
+}
+
 static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_clobber_zone),
 
@@ -495,6 +718,11 @@ static struct kunit_case test_cases[] = {
 #if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_kprobe),
 #endif
+	KUNIT_CASE(test_kmem_buckets_isolation),
+	KUNIT_CASE(test_kmem_buckets_sizes),
+	KUNIT_CASE(test_kmem_buckets_alignment),
+	KUNIT_CASE(test_kmem_buckets_disabled),
+	KUNIT_CASE(test_kmem_buckets_destroy),
 	{}
 };
 
-- 
2.55.0

