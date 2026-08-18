Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAA947987C
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062354; cv=none; b=m8KtDIpRhR0nAbeiIPLe/n6zRr8hk+Z9cBzbEOl4Vwzqjxw6k/jfXiEeV2H7wTGz2/ilHzd+WCC4aKAqsswTUIQ+3kb2Gbh63zoXMMuRHDI62x1iCDVZWjeaFwozuvPgkK2R5+PJ75mF7jRIohEjhxX/obMe5hWmu0bGrizG/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062354; c=relaxed/simple;
	bh=1EO3k0c+FHJUCZCdnF735lljydJEz2rzsWuY6mMubD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sxy5lI6Ex0M/DZtFpXRm906RcZCBrCPriczSDQXDjWwNAVZqMzkrAHEYqNgPME3vgVcTz58dPQeSiOfbbJhpSBYqLfWC4xt5mewq2AjqMNC5stXAcUWl3vhUKhkYzOHw7y6EyJeSpyQde+h9qT6F1CcD+KkQXCFd7SGVS4Hukb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MVpVNtE+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MVpVNtE+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC2919F0;
	Tue, 18 Aug 2026 07:12:27 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28A833F85F;
	Tue, 18 Aug 2026 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062351; bh=1EO3k0c+FHJUCZCdnF735lljydJEz2rzsWuY6mMubD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MVpVNtE+s6JKTe66mRKuLWliAEhYpulHOW3KgflDpMXN5HpajNqhtFKqQqS32po/m
	 clufFv7KTMg+0enxYgHQWTmgUY6rAbHrCSx54wWK6SZEWoK2uMmAsW7wgbxixmEO1w
	 qWm/UZ3nhVHujFS/QeMCRxBW4qJsFVsJO5ijlUT0=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:08:56 +0100
Subject: [PATCH RFC v9 14/25] mm: kpkeys: Protect vmemmap page tables
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-14-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
In-Reply-To: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062276; l=4966;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=1EO3k0c+FHJUCZCdnF735lljydJEz2rzsWuY6mMubD4=;
 b=i8EMSLRarw4Lb8saYUyCRHKL6dzs16IPU6VokXE/NTK4jf/8WGtgr97R0yW37iF8378tRjtKa
 GnuXFjtHKy/A9mS01rGsFzJK3PG+piy4/Ovw1zKqSULisIBCmV0ndJD
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

When the kpkeys_hardened_pgtables feature is enabled, make sure that
vmemmap page tables are protected by using:

* The standard pagetable_alloc() if the buddy allocator is
  available, as it already allocates protected memory.

* The memblock-based kpkeys allocator for early allocations.

These allocators are not NUMA-aware, so the page tables may be
allocated on any node. This could potentially incur some overhead on
large NUMA systems.

The arm64 hotplug code is also amended to use a matching
pagetable_free(), ensuring that the pkey is reset when the page
tables are freed. x86 already uses pagetable_free() on that path.

Unlike in vmemmap_alloc_block(), __GFP_RETRY_MAYFAIL is not used as
it isn't justified for allocating page tables - this disables the
OOM and we do not have a fallback if we fail to allocate page
tables. See previous discussion linked below.

Link: https://lore.kernel.org/all/38d2a358-4146-bfc9-2a4f-68ce02f75c94@suse.cz/
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

This is a minimal patch to protect vmemmmap page tables. More work
may be needed here:

* Restoring NUMA awareness

* Moving the arm64 change to a separate commit?

* General refactoring of how these page tables are allocated: since
  we are not using the standard per-level functions (e.g.
  pmd_alloc()), we are not calling pagetable_*_ctor() or
  ptdesc_set_kernel(). I sent a separate series [1] that partially
  addresses this, but more work is still needed.

[1] https://lore.kernel.org/all/20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com/
---
 arch/arm64/mm/mmu.c |  2 +-
 mm/sparse-vmemmap.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 767478d9e84b..b071f128b9fa 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1446,7 +1446,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 static void free_hotplug_pgtable_page(struct page *page)
 {
 	pagetable_dtor(page_ptdesc(page));
-	free_hotplug_page_range(page, PAGE_SIZE, NULL);
+	pagetable_free(page_ptdesc(page));
 }
 
 static bool pgtable_range_aligned(unsigned long start, unsigned long end,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index ebd3ac997f64..1fec89168ff1 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -179,13 +179,29 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
 	return pte;
 }
 
-static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
+static void * __meminit vmemmap_alloc_pgtable(int node)
 {
-	void *p = vmemmap_alloc_block(size, node);
+	void *p;
+
+	if (slab_is_available()) {
+		gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
+		struct ptdesc *ptdesc = pagetable_alloc(gfp, 0);
+
+		return ptdesc ? ptdesc_address(ptdesc) : NULL;
+	}
+
+	if (kpkeys_hardened_pgtables_early_enabled()) {
+		phys_addr_t phys = kpkeys_physmem_pgtable_alloc();
+
+		p = phys ? phys_to_virt(phys) : NULL;
+	} else {
+		p = __earlyonly_bootmem_alloc(node, PAGE_SIZE, PAGE_SIZE,
+					      __pa(MAX_DMA_ADDRESS));
+	}
 
 	if (!p)
 		return NULL;
-	memset(p, 0, size);
+	memset(p, 0, PAGE_SIZE);
 
 	return p;
 }
@@ -194,7 +210,7 @@ static pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, in
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		kernel_pte_init(p);
@@ -207,7 +223,7 @@ static pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, in
 {
 	pud_t *pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pmd_init(p);
@@ -220,7 +236,7 @@ static p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, in
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pud_init(p);
@@ -233,7 +249,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pgd_populate_kernel(addr, pgd, p);
@@ -346,10 +362,11 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
 	 * memmap_init().
 	 */
 
-	p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+	p = vmemmap_alloc_block(PAGE_SIZE, node);
 	if (!p)
 		return NULL;
 
+	memset(p, 0, PAGE_SIZE);
 	tail = virt_to_page(p);
 	zone->vmemmap_tails[idx] = tail;
 

-- 
2.51.2

