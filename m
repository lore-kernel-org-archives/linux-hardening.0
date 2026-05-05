Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87A47D93A
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997289; cv=none; b=YuBfh2tvWDVnHw3ejLbdMuQnaUUn/X+bUWQH+jhuQ89RblQEUfs4nJcHHeZZb1O3uAOXHG3pmAFEo4djh7sGr9YoKbZnsNspBHo9QtS7dMM6bITRSCTA8jWLQdwMVHOixigr2Eq0OVP+y128aXDPojBs10KBwIpDLl/AfFxvZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997289; c=relaxed/simple;
	bh=PHibZSTZ+M49JBQ4ek0CSdAJ2no6ww2ow8catbJRkbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0hRMoNWwZPh2zjf0BFnTVrjQorEOiZksV0+rSMRAO2FzvWAe+sOzIAm6BBuyeRd+atOIeyXkt7I6Efa6tjPuyiPKeWCjPXvK+4ubmvmJCU3iouoR1zEDmNxQ9Akiv3W11ygNQsf40hYPjY8ckOpmksl7UTWfq+Bezfq6Z4ygUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pJt30ocT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pJt30ocT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E294E2681;
	Tue,  5 May 2026 09:08:01 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29F193F905;
	Tue,  5 May 2026 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997287; bh=PHibZSTZ+M49JBQ4ek0CSdAJ2no6ww2ow8catbJRkbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pJt30ocTXb7hE3yyXbYT/nSgcR9UGUgOhCrLw1N3ELE9tv7VKn9yqPIGkenp5OBxD
	 lj0a0EN2vzEyemi5amPKyxEWoByxWzuAMzvvvnb+vE2s+djQKhWqcy4M5gk+WT+l6y
	 KErmv1Lg62LAOWaupMVBcFI2wyMSxZAv2SJS9BaA=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:03 +0100
Subject: [PATCH RFC v7 14/24] mm: kpkeys: Protect vmemmap page tables
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-14-20c0bdd97197@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=3365;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=PHibZSTZ+M49JBQ4ek0CSdAJ2no6ww2ow8catbJRkbA=;
 b=tgzTvZYCgZKHtLvh8bIbz88J3Sv+Gfhv63Gz+41QPPK0ecs+LDqfcfVQJszRcWPf09gQS/R2H
 Qy0ZIBKMqBXAfXZvmpbDux3ogpELrzjrv18rcm/SClO23PGIj/3dmFA
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

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

This is a minimal patch to protect vmemmmap page tables. More work
may be needed here:

* Restoring NUMA awareness

* General refactoring of how these page tables are allocated: since
  we are not using the standard per-level functions (e.g.
  pmd_alloc()), we are not calling pagetable_*_ctor() or
  ptdesc_set_kernel(). [Maybe that doesn't matter because these page
  tables can only be freed via vmemmap_free()?]
---
 mm/sparse-vmemmap.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6eadb9d116e4..0c0d3b1e356c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -184,13 +184,28 @@ pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 	return pte;
 }
 
-static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
+static void * __meminit vmemmap_alloc_pgtable(int node)
 {
-	void *p = vmemmap_alloc_block(size, node);
+	void *p;
+
+	if (slab_is_available()) {
+		struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, 0);
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
@@ -199,7 +214,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		kernel_pte_init(p);
@@ -212,7 +227,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 {
 	pud_t *pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pmd_init(p);
@@ -225,7 +240,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pud_init(p);
@@ -238,7 +253,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pgd_populate_kernel(addr, pgd, p);

-- 
2.51.2

