Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D8201262;
	Mon,  3 Feb 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578033; cv=none; b=ceFX02nHWlUsh+UCyKJGkHq+g1n6zBJ33O02qP6eEC0kanBfBq6phJH7JD6bX6HCLQlBV5vvWfAribYippXRAZDuZ1XHOMj1VgIJ85EAT4GpCNMi88S4bE7RNpPibHN6T2YrQXgV2GOl+jDojXAcGOUHBoeGp6hWnc4l4G+P66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578033; c=relaxed/simple;
	bh=kYAcDzGD2BIShrpPUjGovFYqBArflioPG4DBhfrGObg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq3FQhX8w1OpMgFg+A5NCmOdKrW3+6f7/SOTHoLUcrZTqBfMXJ+1qATDI6KYeIofusEdpCqhHfCtE+i6Fig36qn5OyGqNw71kHgKF6/E4BsSO9W7FFkN/y3zHsif+SuvGQRfYV1AXMkXJFi3Ibk5geOn8U98qlvMJbAk9MGbV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268A51682;
	Mon,  3 Feb 2025 02:20:56 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34BDF3F63F;
	Mon,  3 Feb 2025 02:20:28 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH v3 13/15] arm64: mm: Guard page table writes with kpkeys
Date: Mon,  3 Feb 2025 10:18:37 +0000
Message-ID: <20250203101839.1223008-14-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203101839.1223008-1-kevin.brodsky@arm.com>
References: <20250203101839.1223008-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, page tables (both
user and kernel) are mapped with a privileged pkey in the linear
mapping. As a result, they can only be written under the
kpkeys_hardened_pgtables guard, which sets POR_EL1 appropriately to
allow such writes.

Use this guard wherever page tables genuinely need to be written,
keeping its scope as small as possible (so that POR_EL1 is reset as
fast as possible). Where atomics are involved, the guard's scope
encompasses the whole loop to avoid switching POR_EL1 unnecessarily.

This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
(default).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 20 ++++++++++++++++++--
 arch/arm64/mm/fault.c            |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..37ce03a6ab70 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -39,6 +39,7 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
+#include <linux/kpkeys.h>
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
@@ -314,6 +315,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 
 static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
 {
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*ptep, pte);
 }
 
@@ -758,6 +760,7 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	}
 #endif /* __PAGETABLE_PMD_FOLDED */
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pmdp, pmd);
 
 	if (pmd_valid(pmd)) {
@@ -825,6 +828,7 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pudp, pud);
 
 	if (pud_valid(pud)) {
@@ -906,6 +910,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*p4dp, p4d);
 	dsb(ishst);
 	isb();
@@ -1033,6 +1038,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 		return;
 	}
 
+	guard(kpkeys_hardened_pgtables)();
 	WRITE_ONCE(*pgdp, pgd);
 	dsb(ishst);
 	isb();
@@ -1233,6 +1239,7 @@ static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	pte_t old_pte, pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	pte = __ptep_get(ptep);
 	do {
 		old_pte = pte;
@@ -1279,7 +1286,10 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
-	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
+	pte_t pte;
+
+	scoped_guard(kpkeys_hardened_pgtables)
+		pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
 
 	page_table_check_pte_clear(mm, pte);
 
@@ -1322,7 +1332,10 @@ static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address, pmd_t *pmdp)
 {
-	pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
+	pmd_t pmd;
+
+	scoped_guard(kpkeys_hardened_pgtables)
+		pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
 
 	page_table_check_pmd_clear(mm, pmd);
 
@@ -1336,6 +1349,7 @@ static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
 {
 	pte_t old_pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	do {
 		old_pte = pte;
 		pte = pte_wrprotect(pte);
@@ -1369,6 +1383,7 @@ static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
 {
 	pte_t old_pte;
 
+	guard(kpkeys_hardened_pgtables)();
 	do {
 		old_pte = pte;
 
@@ -1416,6 +1431,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
 	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
+	guard(kpkeys_hardened_pgtables)();
 	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
 }
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ef63651099a9..ab45047155b9 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -220,6 +220,8 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
 	if (pte_same(pte, entry))
 		return 0;
 
+	guard(kpkeys_hardened_pgtables)();
+
 	/* only preserve the access flags and write permission */
 	pte_val(entry) &= PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
 
-- 
2.47.0

