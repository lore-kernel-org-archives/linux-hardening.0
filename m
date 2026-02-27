Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBEA36A008;
	Fri, 27 Feb 2026 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215015; cv=none; b=l3YfdC33MHF3niFknq2Q7ga6GTZlDoDZNez1BRyOkkg5Zss3pA3yaaMTUDTTW7WRkZjmrNu9qtoGuXlHUuQRFX8iMDuzNwfEvdDqeW33czVYUXAtDT2PS5c8/AOWayLhYNh5xvRrKSncV/24zFu8oI10pKGocPAzY+HzzjCl5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215015; c=relaxed/simple;
	bh=QZMxKOICrVVAkKLuQLZmf2e+AwZmRInS5D5KzVvJIaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcUHn+6qy2mlFJQmdqh7sn+Lr6DrO/RBl9/npmOJqqUxrVj7YkrprFyPQ3OnTKGxY9iYiKI6YMHHRn4AY0tuoYwZgxdfTE1lf9KkFwLM7PUTU5r/qgRnA+1RvUx9ZZ3SjttX9pqKlkEjJQHRPEXy8pav9psjjkvucBfmKQSP5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A6CE14BF;
	Fri, 27 Feb 2026 09:56:47 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85B283F73B;
	Fri, 27 Feb 2026 09:56:49 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v6 15/30] mm: kpkeys: Handle splitting of linear map
Date: Fri, 27 Feb 2026 17:55:03 +0000
Message-ID: <20260227175518.3728055-16-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260227175518.3728055-1-kevin.brodsky@arm.com>
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When block mappings are used for the linear map, the kpkeys page
table allocator attempts to cache whole blocks to reduce splitting.
However, splitting cannot be fully avoided, if only because
allocating a (PMD) block may require splitting a PUD.

This requires special handling because we cannot recursively split
the linear map: to ensure that all page table pages (PTPs) are
mapped with the privileged pkey at all times, we need a reserve of
PTPs that can be used to split the linear map (inserted at PMD
and/or PTE level). This reserve is made up of 2 groups of 2 pages
(PMD + PTE):

1. 2 pages for set_memory_pkey() while refilling the allocator's
   page cache. A mutex is used to guarantee that only one such
   splitting happens at a time. These 2 pages are always available,
   and are replenished by the refill operation itself (which yields
   at least 4 pages: order >= 2).

2. 2 pages for any other splitting operation (e.g. set_memory_pkey()
   in another context or set_memory_ro()). In this case we need to
   explicitly replenish the reserve before attempting the operation;
   a new API is introduced for that purpose:

   * kpkeys_prepare_direct_map_split() performs a refill if the
     reserve needs to be replenished. It should be called by the
     relevant architecture code and doesn't require locking.

   * kpkeys_ready_for_direct_map_split() returns whether splitting
     can be performed. This should be called once the linear map lock
     has been acquired. If false, the lock should be released and
     another refill attempted.

The first group needs to be populated on startup before the
kpkeys_hardened_pgtables feature is enabled; this is done by filling
up the page cache in pba_init().

The page reserve is accessed by passing a new flag
__GFP_PGTABLE_SPLIT. This is probably overkill for such a narrow
use-case, but it avoids invasive changes to the pagetable_alloc()
logic.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Adding a GFP flag was just the easy thing to do - alternative
suggestions welcome (new variant of pagetable_alloc()?)

Relying on the owner of alloc_mutex to decide which reserve to use isn't
very pretty, but there doesn't seem to be a simpler solution here.

---
 include/linux/gfp_types.h     |   3 +
 include/linux/kpkeys.h        |  13 +++++
 mm/kpkeys_hardened_pgtables.c | 100 ++++++++++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 814bb2892f99..34e882c9253d 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -56,6 +56,7 @@ enum {
 	___GFP_NOLOCKDEP_BIT,
 #endif
 	___GFP_NO_OBJ_EXT_BIT,
+	___GFP_PGTABLE_SPLIT_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -97,6 +98,7 @@ enum {
 #define ___GFP_NOLOCKDEP	0
 #endif
 #define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#define ___GFP_PGTABLE_SPLIT	BIT(___GFP_PGTABLE_SPLIT_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -146,6 +148,7 @@ enum {
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
 #define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
+#define __GFP_PGTABLE_SPLIT   ((__force gfp_t)___GFP_PGTABLE_SPLIT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index 303ddef6752c..983f55655dde 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -124,6 +124,9 @@ static inline bool kpkeys_hardened_pgtables_enabled(void)
 struct page *kpkeys_pgtable_alloc(gfp_t gfp);
 void kpkeys_pgtable_free(struct page *page);
 
+int kpkeys_prepare_direct_map_split(void);
+bool kpkeys_ready_for_direct_map_split(void);
+
 /*
  * Should be called from mem_init(): as soon as the buddy allocator becomes
  * available and before any call to pagetable_alloc().
@@ -142,6 +145,16 @@ static inline struct page *kpkeys_pgtable_alloc(gfp_t gfp)
 	return NULL;
 }
 
+static inline int kpkeys_prepare_direct_map_split(void)
+{
+	return 0;
+}
+
+static inline bool kpkeys_ready_for_direct_map_split(void)
+{
+	return true;
+}
+
 static inline void kpkeys_pgtable_free(struct page *page) {}
 
 static inline void kpkeys_hardened_pgtables_init(void) {}
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
index da5695da518d..5b1231e1422a 100644
--- a/mm/kpkeys_hardened_pgtables.c
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -5,6 +5,7 @@
 #include <linux/kpkeys.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/set_memory.h>
 
 __ro_after_init DEFINE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_key);
@@ -35,6 +36,8 @@ static int set_pkey_default(struct page *page, unsigned int nr_pages)
 static bool pba_enabled(void);
 static struct page *pba_pgtable_alloc(gfp_t gfp);
 static void pba_pgtable_free(struct page *page);
+static int pba_prepare_direct_map_split(void);
+static bool pba_ready_for_direct_map_split(void);
 static void pba_init(void);
 
 /* Trivial allocator in case the linear map is PTE-mapped (no block mapping) */
@@ -79,6 +82,22 @@ void kpkeys_pgtable_free(struct page *page)
 		noblock_pgtable_free(page);
 }
 
+int kpkeys_prepare_direct_map_split(void)
+{
+	if (pba_enabled())
+		return pba_prepare_direct_map_split();
+
+	return 0;
+}
+
+bool kpkeys_ready_for_direct_map_split(void)
+{
+	if (pba_enabled())
+		return pba_ready_for_direct_map_split();
+
+	return true;
+}
+
 void __init kpkeys_hardened_pgtables_init(void)
 {
 	if (!arch_kpkeys_enabled())
@@ -94,7 +113,24 @@ void __init kpkeys_hardened_pgtables_init(void)
  * freeing of full blocks.
  */
 #define PBA_GFP_ALLOC		GFP_KERNEL
-#define PBA_GFP_OPT_MASK	(__GFP_ZERO | __GFP_ACCOUNT)
+#define PBA_GFP_OPT_MASK	(__GFP_ZERO | __GFP_ACCOUNT | __GFP_PGTABLE_SPLIT)
+
+/*
+ * Pages need to be reserved for splitting the linear map; __GFP_PGTABLE_SPLIT
+ * must be passed to access these pages. 4 pages are reserved:
+ *
+ * - 2 in case a PMD and/or PTE page needs to be allocated if set_memory_pkey()
+ *   splits the linear map while refilling our own page cache (see
+ *   __refill_pages()). These 2 pages must always be available as we cannot
+ *   refill recursively. They are protected by alloc_mutex and are guaranteed to
+ *   be replenished when refilling is complete and we release the mutex.
+ *
+ * - 2 for splitting the linear map for any other purpose (e.g. calling
+ *   set_memory_pkey() or set_memory_ro() on an arbitrary range). These pages
+ *   are replenished before the split is attempted, see
+ *   kpkeys_prepare_direct_map_split().
+ */
+#define PBA_NR_RESERVED_PAGES	4
 
 #define BLOCK_ORDER		PMD_ORDER
 
@@ -128,12 +164,14 @@ struct pkeys_block_allocator {
 	struct list_head cached_list;
 	unsigned long nr_cached;
 	spinlock_t lock;
+	struct mutex alloc_mutex;
 };
 
 static struct pkeys_block_allocator pkeys_block_allocator = {
 	.cached_list = LIST_HEAD_INIT(pkeys_block_allocator.cached_list),
 	.nr_cached = 0,
 	.lock = __SPIN_LOCK_UNLOCKED(pkeys_block_allocator.lock),
+	.alloc_mutex = __MUTEX_INITIALIZER(pkeys_block_allocator.alloc_mutex)
 };
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(pba_enabled_key);
@@ -143,6 +181,13 @@ static bool pba_enabled(void)
 	return static_branch_likely(&pba_enabled_key);
 }
 
+static bool alloc_mutex_locked(void)
+{
+	struct pkeys_block_allocator *pba = &pkeys_block_allocator;
+
+	return mutex_get_owner(&pba->alloc_mutex) == (unsigned long)current;
+}
+
 static void cached_list_add_pages(struct page *page, unsigned int nr_pages)
 {
 	struct pkeys_block_allocator *pba = &pkeys_block_allocator;
@@ -179,6 +224,7 @@ static void __refill_pages_add_to_cache(struct page *page, unsigned int order,
 
 static struct page *__refill_pages(bool alloc_one)
 {
+	struct pkeys_block_allocator *pba = &pkeys_block_allocator;
 	struct page *page;
 	unsigned int order;
 	int ret;
@@ -195,6 +241,8 @@ static struct page *__refill_pages(bool alloc_one)
 
 	pr_debug("%s: order=%d, pfn=%lx\n", __func__, order, page_to_pfn(page));
 
+	guard(mutex)(&pba->alloc_mutex);
+
 	ret = set_pkey_pgtable(page, 1 << order);
 
 	if (ret) {
@@ -210,16 +258,27 @@ static struct page *__refill_pages(bool alloc_one)
 	return page;
 }
 
+static int refill_pages(void)
+{
+	return __refill_pages(false) ? 0 : -ENOMEM;
+}
+
 static struct page *refill_pages_and_alloc_one(void)
 {
 	return __refill_pages(true);
 }
 
-static bool cached_page_available(void)
+static bool cached_page_available(gfp_t gfp)
 {
 	struct pkeys_block_allocator *pba = &pkeys_block_allocator;
 
-	return pba->nr_cached > 0;
+	if (gfp & __GFP_PGTABLE_SPLIT) {
+		pr_debug("%s: split pgtable (nr_cached: %lu, in_alloc: %d)\n",
+			__func__, pba->nr_cached, alloc_mutex_locked());
+		return true;
+	}
+
+	return pba->nr_cached > PBA_NR_RESERVED_PAGES;
 }
 
 static struct page *get_cached_page(gfp_t gfp)
@@ -229,7 +288,7 @@ static struct page *get_cached_page(gfp_t gfp)
 
 	guard(spinlock_bh)(&pba->lock);
 
-	if (!cached_page_available())
+	if (!cached_page_available(gfp))
 		return NULL;
 
 	page = list_first_entry_or_null(&pba->cached_list, struct page, lru);
@@ -311,10 +370,43 @@ static void pba_pgtable_free(struct page *page)
 	cached_list_add_pages(page, 1);
 }
 
+static int pba_prepare_direct_map_split(void)
+{
+	if (pba_ready_for_direct_map_split())
+		return 0;
+
+	/* Ensure we have at least PBA_NR_RESERVED_PAGES available */
+	return refill_pages();
+}
+
+static bool pba_ready_for_direct_map_split(void)
+{
+	struct pkeys_block_allocator *pba = &pkeys_block_allocator;
+
+	/*
+	 * For a regular split, we must ensure the reserve is fully replenished
+	 * before splitting (which may consume 2 pages out of 4).
+	 *
+	 * When refilling our cache, alloc_mutex is locked and we must use
+	 * pages from the reserve (remaining 2 pages).
+	 */
+	return READ_ONCE(pba->nr_cached) >= PBA_NR_RESERVED_PAGES ||
+		alloc_mutex_locked();
+}
+
 static void __init pba_init(void)
 {
+	int ret;
+
 	if (arch_has_pte_only_direct_map())
 		return;
 
 	static_branch_enable(&pba_enabled_key);
+
+	/*
+	 * Refill the cache so that the reserve pages are available for
+	 * splitting next time we need to refill.
+	 */
+	ret = refill_pages();
+	WARN_ON(ret);
 }
-- 
2.51.2

