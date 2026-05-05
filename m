Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305148AE04
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997285; cv=none; b=Uy/WRk4PcyrCYDCVhj3uDbG97pCGdhl/CClsKu1rUWmUGR/eyoabkdQtalToqbczDbKG6IePunBKI9vWxWTOJ1vAMneNE6K+HwKB6gInbXFzkNtkencK2qWTUcbrCnpsJcl64/pd6EhQBBGbeP9zKn+HireKjq8WCCzxDdcbZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997285; c=relaxed/simple;
	bh=+4mPtU8ML5lnaH7LBGXsM7pqQ71TUsjEb8tbnZNz60I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfGV+KLuqc5Gre2GbA9A/b0oDG4lqAg2cCFuURl3DQUf2EuNpRlOF6eKO1M/uOkrTciIwlO8Hbp2HI93vkjEfqrP3Hr+cR+k7a9KV3N4Heb8TsZ0bXpG+wGNAbGShY0xg6I1YuyT1sJArSZjvsjyCCAoSrXwicTjN88uO9+ubcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UWnqVtTi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UWnqVtTi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABE514BF;
	Tue,  5 May 2026 09:07:57 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02BD3F763;
	Tue,  5 May 2026 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997282; bh=+4mPtU8ML5lnaH7LBGXsM7pqQ71TUsjEb8tbnZNz60I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UWnqVtTiScYhyf2YNfT5kwzRiOxZ2+MxnuBhDO6eaoxCD6MrQj73ajhFdbV5hnASr
	 Iltr+1TATmFuqayCN02ByZ7XV1AsqXE1fdf0YNQD90xEve37wWgcuOO+CtjZT+PFR+
	 s3n5MHf4xZSUaJEOkOpQd3apjCCPt2FZznaavMIk=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:02 +0100
Subject: [PATCH RFC v7 13/24] mm: kpkeys: Introduce early page table
 allocator
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-13-20c0bdd97197@arm.com>
References: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
In-Reply-To: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=6674;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=+4mPtU8ML5lnaH7LBGXsM7pqQ71TUsjEb8tbnZNz60I=;
 b=5vOnQto1KS+1yKFStg02+/OAXLFol1nVopa7ZEdXQ7Cx1SD8A1ujKOazl0i+AvzNgruHVjxJI
 Bt5gGNPNB06BKXFoMekN7Dnm07z8yxqvVr+UiyHt52uI6YuDKzZMh9u
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The kpkeys_hardened_pgtables feature aims to protect all page table
pages (PTPs) by mapping them with a privileged pkey. This is primarily
handled by kpkeys_pgtable_alloc(), called from pagetable_alloc().
However, this does not cover PTPs allocated early, before the
buddy allocator is available. These PTPs are allocated by architecture
code, either 1. from static pools or 2. using the memblock allocator,
and should also be protected.

This patch addresses the second category: PTPs allocated via memblock.
Such PTPs are notably used to create the linear map. Protecting them as
soon as they are allocated would require modifying the linear map while
it is being created, which seems at best difficult. Instead, a
simple allocator is introduced, obtaining pages from memblock and
keeping track of all allocated ranges to set their pkey once it is
safe to do so. PTPs allocated at that stage are not freed, so there
is no need to manage a free list.

Since kpkeys_hardened_pgtables currently requires the linear map to
be PTE-mapped, we can directly allocate page by page using memblock,
without intermediate cache. We rely on memblock allocating
contiguous pages to minimise the number of tracked ranges.

The number of PTPs required to create the linear map is proportional to
the amount of available memory, which means it may be large. At such
an early point, the memblock allocator may however only track a
limited number of regions, and we size the tracking array
(allocated_ranges) accordingly. The array may be quite large as a
result (16KB on arm64), but it is discarded once boot has completed.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/kpkeys.h        |   7 +++
 mm/kpkeys_hardened_pgtables.c | 116 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index c9f63415162b..544a2d954bc1 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -140,6 +140,8 @@ void kpkeys_pgtable_free(struct page *page, unsigned int order);
  */
 void kpkeys_hardened_pgtables_init(void);
 
+phys_addr_t kpkeys_physmem_pgtable_alloc(void);
+
 #else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
 
 static inline bool kpkeys_hardened_pgtables_enabled(void)
@@ -161,6 +163,11 @@ static inline void kpkeys_pgtable_free(struct page *page, unsigned int order) {}
 
 static inline void kpkeys_hardened_pgtables_init(void) {}
 
+static inline phys_addr_t kpkeys_physmem_pgtable_alloc(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
 
 #endif /* _LINUX_KPKEYS_H */
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
index fff7e2a64b64..c7a8935571ac 100644
--- a/mm/kpkeys_hardened_pgtables.c
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kpkeys.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/set_memory.h>
 
@@ -30,6 +31,9 @@ static int set_pkey_default(struct page *page, unsigned int nr_pages)
 	return ret;
 }
 
+/* pkeys physmem allocator (PPA) - implemented below */
+static void ppa_finalize(void);
+
 struct page *kpkeys_pgtable_alloc(gfp_t gfp, unsigned int order)
 {
 	struct page *page;
@@ -60,4 +64,116 @@ void __init kpkeys_hardened_pgtables_init(void)
 		return;
 
 	static_branch_enable(&kpkeys_hardened_pgtables_key);
+
+	ppa_finalize();
+}
+
+/*
+ * pkeys physmem allocator (PPA): allocator for very early page tables
+ * (especially for creating the linear map), based on memblock. Allocated
+ * ranges are tracked so that their pkey can be set once it is safe to do so.
+ */
+
+/*
+ * We may have to track many ranges when allocating page tables for the linear
+ * map, as their number grows with the amount of available memory. Assuming that
+ * memblock returns contiguous blocks whenever possible, the number of ranges
+ * to track cannot however exceed the number of regions that memblock itself
+ * tracks. memblock_allow_resize() hasn't been called yet at that point, so
+ * that limit is the size of the statically allocated array.
+ */
+#define PHYSMEM_MAX_RANGES	INIT_MEMBLOCK_MEMORY_REGIONS
+
+struct physmem_range {
+	phys_addr_t addr;
+	phys_addr_t size;
+};
+
+struct pkeys_physmem_allocator {
+	struct physmem_range allocated_ranges[PHYSMEM_MAX_RANGES];
+	unsigned int nr_allocated_ranges;
+};
+
+static struct pkeys_physmem_allocator pkeys_physmem_allocator __initdata;
+
+static int __init set_pkey_pgtable_phys(phys_addr_t pa, phys_addr_t size)
+{
+	unsigned long addr = (unsigned long)__va(pa);
+	int ret;
+
+	ret = set_memory_pkey(addr, size / PAGE_SIZE, KPKEYS_PKEY_PGTABLES);
+	pr_debug("%s: addr=%pa, size=%pa\n", __func__, &addr, &size);
+
+	WARN_ON(ret);
+	return ret;
+}
+
+static bool __init ppa_try_extend_last_range(phys_addr_t addr, phys_addr_t size)
+{
+	struct pkeys_physmem_allocator *ppa = &pkeys_physmem_allocator;
+	struct physmem_range *range;
+
+	if (!ppa->nr_allocated_ranges)
+		return false;
+
+	range = &ppa->allocated_ranges[ppa->nr_allocated_ranges - 1];
+
+	/* Merge the new range into the last range if they are contiguous */
+	if (addr == range->addr + range->size) {
+		range->size += size;
+		return true;
+	} else if (addr + size == range->addr) {
+		range->addr -= size;
+		range->size += size;
+		return true;
+	}
+
+	return false;
+}
+
+static void __init ppa_register_allocated_range(phys_addr_t addr,
+						phys_addr_t size)
+{
+	struct pkeys_physmem_allocator *ppa = &pkeys_physmem_allocator;
+	struct physmem_range *range;
+
+	if (!addr)
+		return;
+
+	if (ppa_try_extend_last_range(addr, size))
+		return;
+
+	/* Could not extend the last range, create a new one */
+	if (WARN_ON(ppa->nr_allocated_ranges >= PHYSMEM_MAX_RANGES))
+		return;
+
+	range = &ppa->allocated_ranges[ppa->nr_allocated_ranges++];
+	range->addr = addr;
+	range->size = size;
+}
+
+static void __init ppa_finalize(void)
+{
+	struct pkeys_physmem_allocator *ppa = &pkeys_physmem_allocator;
+
+	for (unsigned int i = 0; i < ppa->nr_allocated_ranges; i++) {
+		struct physmem_range *range = &ppa->allocated_ranges[i];
+
+		set_pkey_pgtable_phys(range->addr, range->size);
+	}
+}
+
+phys_addr_t __ref kpkeys_physmem_pgtable_alloc(void)
+{
+	size_t size = PAGE_SIZE;
+	phys_addr_t addr;
+
+	addr = memblock_phys_alloc_range(size, size, 0,
+					 MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (!addr)
+		return addr;
+
+	ppa_register_allocated_range(addr, size);
+
+	return addr;
 }

-- 
2.51.2

