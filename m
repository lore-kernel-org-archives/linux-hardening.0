Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BB73DE450
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794328; cv=none; b=akz2pQeJZqKvi/oBeHfEg1QHljcSyJHl9PCK8ubpbbX+brsX9nGILcJKZWegq0pfP89mWLx+tSq37dzlHh6zvalZKsEK0hXTIUBk6bwklHQjP+b6pgYbxUFqm0rCOrsPgdxhAMQR/H+homytM8aMK8KqLgZ74jdxh/TAalIlzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794328; c=relaxed/simple;
	bh=hwcv2gonPHpgCT0f3+/I1m85tJYegiKdKnPZStVnGxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfxZxiIo3eJKsODorF1BozKtgOgCglLlnHXiNSe7SKbnDpZTtwnZLhMt2PhfvoafFrzCZAm4mcf0Mvwet1oHGYnL7w2QPjZusVwvkK4lqQkl/fCF8D7E0FnCfVXb4B1UO3yAvuKiiub14Al8ngq5yWvsSF7bJQO+cXRz7keDfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F/U4Y59a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F/U4Y59a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB571169C;
	Tue, 26 May 2026 04:18:41 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECCCD3F7D8;
	Tue, 26 May 2026 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779794326; bh=hwcv2gonPHpgCT0f3+/I1m85tJYegiKdKnPZStVnGxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F/U4Y59a//xfdzb3biidGRmmpns10SE1ABekJ1J4jBiRAORO4vXAkPRA3/AAh9yAK
	 16MYenua0OdnWEFug60TeFZoFPQ2Wdg12gsu3NuBqUCVkYM4OFvI5lPdZzFvBE6bTD
	 Zhhtzjx6g1w/0VU/RtPAKFo6NY8lH/PQ+LNtEB88=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 26 May 2026 12:16:10 +0100
Subject: [PATCH RFC v8 21/24] arm64: kpkeys: Guard page table writes
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kpkeys-v8-21-eaaacdacc67c@arm.com>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
In-Reply-To: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
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
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794212; l=4674;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=hwcv2gonPHpgCT0f3+/I1m85tJYegiKdKnPZStVnGxs=;
 b=acbni5FydzqysJ5dMgbsdAlXZrSXrjGZ9fILV417IMyC2z6ykw6ftEdeixBWE0s1kBd43a8Bh
 z9+CKJx/qiKCD3vFU+glse8yHgGm7Ws8vxmjz/JAEeXKgGZIBaPyBh+
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

When CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, page tables (both
user and kernel) are mapped with a privileged pkey in the linear
mapping. As a result, they can only be written in a privileged
kpkeys context.

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
 arch/arm64/mm/fault.c            | 17 ++++++++++-------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4dfa42b7d053..20072f32677d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -39,6 +39,14 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
+#include <linux/kpkeys.h>
+
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+KPKEYS_GUARD_COND(kpkeys_hardened_pgtables, KPKEYS_CTX_PGTABLES,
+		  kpkeys_hardened_pgtables_enabled())
+#else
+KPKEYS_GUARD_NOOP(kpkeys_hardened_pgtables)
+#endif
 
 static inline void emit_pte_barriers(void)
 {
@@ -359,6 +367,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
 {
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*ptep, pte);
 }
 
@@ -830,6 +839,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	}
 #endif /* __PAGETABLE_PMD_FOLDED */
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pmdp, pmd);
 
 	if (pmd_valid(pmd))
@@ -894,6 +904,7 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pudp, pud);
 
 	if (pud_valid(pud))
@@ -975,6 +986,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*p4dp, p4d);
 	queue_pte_barriers();
 }
@@ -1103,6 +1115,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pgdp, pgd);
 	queue_pte_barriers();
 }
@@ -1307,6 +1320,7 @@ static inline bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	pte_t old_pte, pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	pte = __ptep_get(ptep);
 	do {
 		old_pte = pte;
@@ -1354,7 +1368,10 @@ static inline pte_t __ptep_get_and_clear_anysz(struct mm_struct *mm,
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
@@ -1427,6 +1444,7 @@ static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
 {
 	pte_t old_pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	do {
 		old_pte = pte;
 		pte = pte_wrprotect(pte);
@@ -1460,6 +1478,7 @@ static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
 {
 	pte_t old_pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	do {
 		old_pte = pte;
 
@@ -1507,6 +1526,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
+	guard(kpkeys_hardened_pgtables)();
 	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
 }
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 739800835920..35f9b702f87d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -227,13 +227,16 @@ int __ptep_set_access_flags_anysz(struct vm_area_struct *vma,
 	 */
 	pte_val(entry) ^= PTE_RDONLY;
 	pteval = pte_val(pte);
-	do {
-		old_pteval = pteval;
-		pteval ^= PTE_RDONLY;
-		pteval |= pte_val(entry);
-		pteval ^= PTE_RDONLY;
-		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
-	} while (pteval != old_pteval);
+	scoped_guard(kpkeys_hardened_pgtables) {
+		do {
+			old_pteval = pteval;
+			pteval ^= PTE_RDONLY;
+			pteval |= pte_val(entry);
+			pteval ^= PTE_RDONLY;
+			pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval,
+						 pteval);
+		} while (pteval != old_pteval);
+	}
 
 	/*
 	 * Invalidate the local stale read-only entry.  Remote stale entries

-- 
2.51.2

