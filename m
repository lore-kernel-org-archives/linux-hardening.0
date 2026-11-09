Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240109;
	b=i56AkKnda+9w8m7OiT5rjr52sKl2UH9FZ7OWWvM/kGHZfEbKIF8KECxN6WZBhlz7+fhD
	 YTzGOh9MgqPNtgUCNJ15eWKCCER7JI+Cq7hsr1QxWAxWhU8cIY1gJhO2V2fxEAhXweRf6
	 cpd+LFZp153GPTp0TddrZAmuBouTAsI5XSchJqxBxnq+mvUfUXfW7+Ru6IBr/Ii0/+fQ9
	 G94YbhziDmuu1behs1w8ECr5nIacwd3HjhOpijrJJXp5Fkag1D0tuONIXORk62TKuUBk+
	 lX8ThDmOTte7Ucn1+kmE4aKpdUYetSuPDaY3Lv6aJLJKm2nc0Z4kMK8o7lUsHB/ZobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240109;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=mwD9lqFi3lP5XHrWQt/AOW6SRyYfneOldinY0XtaIdA=;
	b=HhVKeIhjn4V2kXnTMA+HJ0BQBx+APJWY/FoIcxtK5qVU8ONnJ80+s5asvJwHyqIbbu/i
	 JRCxJKbeApwuBa82qdbRn99VmOfoHnTCFAUUKDYcEdDqTyhYTHKi5OjWROZUcDTtn4p29
	 B/aZdID9TNJAX2GIpJQRkw3UfzfmEL3A8I8YFHKVKOmRHdt9710PjJRqmLrK90E8mgKpm
	 du+5I4G/lN8PW+jvYhEqf8Jc/CmaWWJunfEF/lXcgI2S/T+np8AmVIx5qaOvse3kzK6+i
	 oGZ/2DcmebyERdGvBBHHtRvIcEcFW+K3kDBPVeq2EhjSCt+TH6OF6kyPa07ey6Ag/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EsUYUXdr;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5D606EE87;
	Mon,  9 Nov 2026 16:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F5D606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EsUYUXdr
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D783814BF;
	Mon,  9 Nov 2026 08:01:44 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07F7D3F632;
	Mon,  9 Nov 2026 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240107; bh=LL3TBpqLpKZH6lBVyCZn6T3Prq9VMXDK4K5G18uGAf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EsUYUXdrXAen2v49OhDgKotRMKa6Qb8c1Z3+90GW6GbfrYjTYC1rEvsnnmUH+t+v4
	 W+GMn8L5sssE0Gm6pvLJIXFhKGZStMWkreLuGLf33FzjZRtj1em84Gy5t5l5etCECj
	 gly7xgxXHWBFCoVjR8S8g2uFifzTm0NR2CmRLRLY=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:39 +0000
Subject: [PATCH RFC v10 14/22] mm: kpkeys: Protect vmemmap page tables
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-kpkeys-v10-14-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
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
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=4616;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=LL3TBpqLpKZH6lBVyCZn6T3Prq9VMXDK4K5G18uGAf8=;
 b=i4ynNlUXMktda2i2JO5mNT9NsUhl50VMi2aYOXHiXBUN5YsbKykwex+lk5I3ZNHSnDyK1GmSV
 C/YDQMmuIbwDEO4xzjKcFip2uUBetbYzO93iBKDkWbO8RTL8gy9DNq1
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The kpkeys_hardened_pgtables feature automatically protect early
vmemmap page tables (covering standard boot memory) when it is
enabled.

In order to protect late vmemmap page tables  as well, allocate them
like regular page tables using pagetable_alloc().

pagetable_alloc() does the right thing to protect the backing pages
using kpkeys, but isn't NUMA-aware, so the pages may be allocated on
any node. This could potentially incur some overhead on large NUMA
systems that make heavy use of memory hotplug.

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

* x86 allows boot memory to be hot-removed in some circumstances.
  free_pagetable() should handle this situation by resetting the
  direct map pkey of reserved pages.

[1] https://lore.kernel.org/all/20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com/
---
 arch/arm64/mm/mmu.c |  2 +-
 mm/sparse-vmemmap.c | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6a2155db3d05..a61ea65bd496 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1496,7 +1496,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 static void free_hotplug_pgtable_page(struct page *page)
 {
 	pagetable_dtor(page_ptdesc(page));
-	free_hotplug_page_range(page, PAGE_SIZE, NULL);
+	pagetable_free(page_ptdesc(page));
 }
 
 static bool pgtable_range_aligned(unsigned long start, unsigned long end,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5d7e982f94d0..c47d3a016891 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -150,13 +150,22 @@ int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages
 	return 0;
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
+	p = vmemmap_alloc_block(PAGE_SIZE, node);
 
 	if (!p)
 		return NULL;
-	memset(p, 0, size);
+	memset(p, 0, PAGE_SIZE);
 
 	return p;
 }
@@ -305,7 +314,7 @@ static pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, in
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		kernel_pte_init(p);
@@ -318,7 +327,7 @@ static pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, in
 {
 	pud_t *pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pmd_init(p);
@@ -331,7 +340,7 @@ static p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, in
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pud_init(p);
@@ -344,7 +353,7 @@ static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		void *p = vmemmap_alloc_pgtable(node);
 		if (!p)
 			return NULL;
 		pgd_populate_kernel(addr, pgd, p);

-- 
2.56.0

