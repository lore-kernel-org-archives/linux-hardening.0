Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18902F5460;
	Fri, 15 Aug 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248201; cv=none; b=KcxZwCA19BMS1XwfAWb5603S12f6u84ewFwbjB2tlY28Pq5tLUDixDUJ5Q0b4dRs7EhOXxF0ZJ7Bj0FwOeRd/Ivz6UX6mo0LaMBTcQQ/uuVZmnQ8CavVCVaAJN04l/fCAOMypZY7bpMQzEe99nDWRzMeeQt7Z0FltloAHO9Ma0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248201; c=relaxed/simple;
	bh=6oYYOMV2lXb1C0hqEreglgTFkhcTGJwexsDlWJHyrnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbSShfv2PJqfgB47WUeTUOiyQ3FuMUrtyPunVgJjs1fUuJs2idvb7oz3yp95VfqO2B5JCEpkO+Mpj4Un3q0Z9/FFMOTV9KLZIxWbUQ5EsvaKHb9YQodQbrJtQaWw40mNjdk489K5yGYrERhVwknWT+nWzsxkSgOLe0dqyjecyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1963E497;
	Fri, 15 Aug 2025 01:56:31 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32173F63F;
	Fri, 15 Aug 2025 01:56:34 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH v5 15/18] arm64: mm: Guard page table writes with kpkeys
Date: Fri, 15 Aug 2025 09:55:09 +0100
Message-ID: <20250815085512.2182322-16-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815085512.2182322-1-kevin.brodsky@arm.com>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, page tables (both
user and kernel) are mapped with a privileged pkey in the linear
mapping. As a result, they can only be written at an elevated kpkeys
level.

Introduce a kpkeys guard that sets POR_EL1 appropriately to allow
writing to page tables, and use this guard wherever necessary. The
scope is kept as small as possible, so that POR_EL1 is quickly reset
to its default value. Where atomics are involved, the guard's scope
encompasses the whole loop to avoid switching POR_EL1 unnecessarily.

This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
(default).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 22 +++++++++++++++++++++-
 arch/arm64/mm/fault.c            |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abd2dee416b3..1694fb839854 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -39,6 +39,14 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
+#include <linux/kpkeys.h>
+
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+KPKEYS_GUARD_COND(kpkeys_hardened_pgtables, KPKEYS_LVL_PGTABLES,
+		  kpkeys_hardened_pgtables_enabled())
+#else
+KPKEYS_GUARD_NOOP(kpkeys_hardened_pgtables)
+#endif
 
 static inline void emit_pte_barriers(void)
 {
@@ -390,6 +398,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
 {
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*ptep, pte);
 }
 
@@ -858,6 +867,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	}
 #endif /* __PAGETABLE_PMD_FOLDED */
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pmdp, pmd);
 
 	if (pmd_valid(pmd))
@@ -918,6 +928,7 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pudp, pud);
 
 	if (pud_valid(pud))
@@ -999,6 +1010,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*p4dp, p4d);
 	queue_pte_barriers();
 }
@@ -1127,6 +1139,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pgdp, pgd);
 	queue_pte_barriers();
 }
@@ -1316,6 +1329,7 @@ static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	pte_t old_pte, pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	pte = __ptep_get(ptep);
 	do {
 		old_pte = pte;
@@ -1363,7 +1377,10 @@ static inline pte_t __ptep_get_and_clear_anysz(struct mm_struct *mm,
 					       pte_t *ptep,
 					       unsigned long pgsize)
 {
-	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
+	pte_t pte;
+
+	scoped_guard(kpkeys_hardened_pgtables)
+		pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
 
 	switch (pgsize) {
 	case PAGE_SIZE:
@@ -1436,6 +1453,7 @@ static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
 {
 	pte_t old_pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	do {
 		old_pte = pte;
 		pte = pte_wrprotect(pte);
@@ -1469,6 +1487,7 @@ static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
 {
 	pte_t old_pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	do {
 		old_pte = pte;
 
@@ -1516,6 +1535,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
+	guard(kpkeys_hardened_pgtables)();
 	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
 }
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d816ff44faff..c4ab361bba72 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -214,6 +214,8 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
 	if (pte_same(pte, entry))
 		return 0;
 
+	guard(kpkeys_hardened_pgtables)();
+
 	/* only preserve the access flags and write permission */
 	pte_val(entry) &= PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
 
-- 
2.47.0

