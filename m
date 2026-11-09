Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240098;
	b=xtGEYBumd4N0B6qnLQ/eDP/bvjHd3HYn6tLTsa6t237YQFVWOJ5cY/bOZfXWPqkKJ44X
	 1NgLF091xEFrAnFd3C7F2Hp4sxTG74hN/2GNybWKmt8rf60lE4JMwy/S2T5Ii4wRidAsB
	 hkfl+FaXmPSAlZ7xjnl6+Wg588R0NC7MsO/f7eCsZrgxJ72BoEC1jlBfIfZuQNDK2WT6t
	 kKh0CabD4DveienV/SSh4oFKn5XfcUlH8txyJr3qwNVm2z2baharK38wRRv7I0tBqpmuD
	 5UfvEXSzyREz8HNVZmXKdtQ+SzbKvA9taEYqqX/c3sWWHleS5NjYx90bpIRcWtR3qVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240098;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FL5Kx3AUeCmxtQnGnnWTgoFnfi9x0Ew1zUUgZ1tmvPk=;
	b=X4QOJ7+8hWXXlSrI1jJvIpe9MDzw4CCvbZoiI/hnBzeH5Ie901f3/3WoEvtGTe/fyxfy
	 DLK1MvJaEQBydx+h0Pc6qb4TNs01KQJdageqpVrLsv0OcoUVKR4UxErOh8qp9wxTjnWYU
	 89tIVA3bYnx7n5MXD2s2SHJkI8MdrkMn2w51KBH/TGL5UrUr5jD1MfCXNDaGmSbn0Y3VZ
	 W44S8a5gZc9rBGCxp2z9IJtGsAaZ9p4E3NFCWkf2PiG2E1XX+R/BXwm4K0slesRtkLp7W
	 y14GN6JasA38PziRk11oO5AoqHKrn6xbSjzDtTQllZok5xEOIUOkAozrqDc1xbDwrPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DZGU+qoU;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547D606A330;
	Mon,  9 Nov 2026 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2547D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DZGU+qoU
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0DD14BF;
	Mon,  9 Nov 2026 08:01:34 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F09B3F632;
	Mon,  9 Nov 2026 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240097; bh=FJhxPDyYVdBG5bX8IuKyyMgqF3Nmg2Z/S4Ly98Gbm0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZGU+qoUNwtnqV/JUKbMv9TCdVdPFTHjn3xhVDCFs2NiQszgkOPYy6MeFaiKAyeGe
	 lALp04xTRVdYeolq1s6qX5/Au3ZOkCX42+T6MbIiJO+7MkuLcT//S4x68+avHavHXc
	 ZTz3NyvO64EuR+p5wp3JjrtAOWyGjM39QNUDdEOM=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:37 +0000
Subject: [PATCH RFC v10 12/22] mm: kpkeys: Protect regular page tables
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
Message-Id: <20261109-kpkeys-v10-12-aa6c4d9603bc@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=5221;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=FJhxPDyYVdBG5bX8IuKyyMgqF3Nmg2Z/S4Ly98Gbm0Q=;
 b=N9Y50oJC035I6cz85GsnRJy64slnDo6TL/8rzblh2yRCsgVCTagovaG2p4NnaC2dSArHieM48
 xMAOSyQE8vHAvSZaisSwZlhfhdYt6qh3ZFAUCA0gbP2XMD4XyHEd7aL
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

If the kpkeys_hardened_pgtables feature is enabled, page table pages
(PTPs) should be protected by modifying the linear mapping to map
them with a privileged pkey (KPKEYS_PKEY_PGTABLES). This patch
introduces a new page allocator for that purpose:

* kpkeys_pgtable_alloc() allocates a new PTP and sets the linear
  mapping to KPKEYS_PKEY_PGTABLES for that page

* kpkeys_pgtable_free() frees such a PTP and restores the linear
  mapping to the default pkey

This interface is then hooked into pagetable_alloc() and
pagetable_free(), protecting all page tables created once the buddy
allocator is available. Early page tables are allocated in other
ways and will be protected in subsequent patches.

This implementation of kpkeys_pgtable_{alloc,free}() is minimal and
relies on the linear map being fully PTE-mapped - otherwise
calling set_direct_map_pkey() on a single page may result in
splitting a block mapping, which in turn requires allocating a new
PTP. A more elaborate implementation could be added later to handle
this situation.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/kpkeys.h        | 10 +++++++++
 include/linux/mm.h            | 14 +++++++++++--
 mm/kpkeys_hardened_pgtables.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index cd3281223778..6c183c86b7d2 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -119,6 +119,9 @@ static inline bool kpkeys_hardened_pgtables_early_enabled(void)
 	return arch_supports_kpkeys_early();
 }
 
+struct page *kpkeys_pgtable_alloc(gfp_t gfp, unsigned int order);
+void kpkeys_pgtable_free(struct page *page, unsigned int order);
+
 void kpkeys_hardened_pgtables_init(void);
 
 #else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
@@ -133,6 +136,13 @@ static inline bool kpkeys_hardened_pgtables_early_enabled(void)
 	return false;
 }
 
+static inline struct page *kpkeys_pgtable_alloc(gfp_t gfp, unsigned int order)
+{
+	return NULL;
+}
+
+static inline void kpkeys_pgtable_free(struct page *page, unsigned int order) {}
+
 static inline void kpkeys_hardened_pgtables_init(void) {}
 
 #endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6af3b7008f1a..2af713841035 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,6 +39,7 @@
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
 #include <linux/vmemmap-optimization.h>
+#include <linux/kpkeys.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -3950,7 +3951,12 @@ static inline bool ptdesc_test_kernel(const struct ptdesc *ptdesc)
  */
 static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
 {
-	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
+	struct page *page;
+
+	if (kpkeys_hardened_pgtables_enabled())
+		page = kpkeys_pgtable_alloc(gfp | __GFP_COMP, order);
+	else
+		page = alloc_pages_noprof(gfp | __GFP_COMP, order);
 
 	return page_ptdesc(page);
 }
@@ -3959,8 +3965,12 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 static inline void __pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
+	unsigned int order = compound_order(page);
 
-	__free_pages(page, compound_order(page));
+	if (kpkeys_hardened_pgtables_enabled())
+		kpkeys_pgtable_free(page, order);
+	else
+		__free_pages(page, order);
 }
 
 #ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
index 4c654e0cf585..2311fd8da6bb 100644
--- a/mm/kpkeys_hardened_pgtables.c
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -1,12 +1,59 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kpkeys.h>
 #include <linux/mm.h>
+#include <linux/set_memory.h>
 
 #include <kunit/visibility.h>
 
 __ro_after_init DEFINE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_key);
 EXPORT_SYMBOL_IF_KUNIT(kpkeys_hardened_pgtables_key);
 
+static int set_pkey_pgtable(struct page *page, unsigned int nr_pages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	int ret;
+
+	ret = set_direct_map_pkey(addr, nr_pages, KPKEYS_PKEY_PGTABLES);
+
+	WARN_ON(ret);
+	return ret;
+}
+
+static int set_pkey_default(struct page *page, unsigned int nr_pages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	int ret;
+
+	ret = set_direct_map_pkey(addr, nr_pages, 0);
+
+	WARN_ON(ret);
+	return ret;
+}
+
+struct page *kpkeys_pgtable_alloc(gfp_t gfp, unsigned int order)
+{
+	struct page *page;
+	int ret;
+
+	page = alloc_pages_noprof(gfp, order);
+	if (!page)
+		return page;
+
+	ret = set_pkey_pgtable(page, 1 << order);
+	if (ret) {
+		__free_pages(page, order);
+		return NULL;
+	}
+
+	return page;
+}
+
+void kpkeys_pgtable_free(struct page *page, unsigned int order)
+{
+	set_pkey_default(page, 1 << order);
+	__free_pages(page, order);
+}
+
 void __init kpkeys_hardened_pgtables_init(void)
 {
 	if (!kpkeys_supported())

-- 
2.56.0

