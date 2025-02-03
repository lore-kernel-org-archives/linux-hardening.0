Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FFE202F79;
	Mon,  3 Feb 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578014; cv=none; b=WPl1rmpO3GBc2pen+hjspk5iUlSBXOjEm1jNuwvazBM3x++TOLeC0+67DPIo+nst+mLTKf5/ba/ZimGYPIbxMgjhExiV6dk8YNjpk1+RUMzIlyfDr/i6pGPw1+7oi55s/Qus13DMjVg8ilRfGTLnQ9G6ijOf+GqCtNnYU2nwDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578014; c=relaxed/simple;
	bh=SH+kivUVnQ8BCYOQFIOaz8Eu1XIlmfF1ISbi7u0MGyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0DD7hT86E0PXYnuN9JI3KtD+QFmqr4ANntPfBZBptS48yMO41unESySLpsAAcGm304LafAnD85J2IbmL9vu8TxbKMhNxsb7IHWCMi7V+8MzoeRkeo6nvdNSx4m/GrKCtKUKBkUUUfwY2ftPZAcVKyqphO4hSj/t3tsa81HRZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F1A111FB;
	Mon,  3 Feb 2025 02:20:37 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D2BF3F63F;
	Mon,  3 Feb 2025 02:20:08 -0800 (PST)
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
Subject: [RFC PATCH v3 08/15] mm: Introduce kernel_pgtables_set_pkey()
Date: Mon,  3 Feb 2025 10:18:32 +0000
Message-ID: <20250203101839.1223008-9-kevin.brodsky@arm.com>
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

kernel_pgtables_set_pkey() allows setting the pkey of all page table
pages in swapper_pg_dir, recursively. This will be needed by
kpkeys_hardened_pgtables, as it relies on all PTPs being mapped with
a non-default pkey. Those initial kernel page tables cannot
practically be assigned a non-default pkey right when they are
allocated, so mutating them during (early) boot is required.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h |   2 +
 mm/memory.c        | 137 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..c3998b78f6a5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4155,4 +4155,6 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+int kernel_pgtables_set_pkey(int pkey);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..1386b9cfb459 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -77,6 +77,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
 #include <linux/fsnotify.h>
+#include <linux/kpkeys.h>
+#include <linux/set_memory.h>
 
 #include <trace/events/kmem.h>
 
@@ -7066,3 +7068,138 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma)
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_vma_unlock_read(vma);
 }
+
+static int set_page_pkey(void *p, int pkey)
+{
+	unsigned long addr = (unsigned long)p;
+
+	/*
+	 * swapper_pg_dir itself will be made read-only by mark_rodata_ro()
+	 * so there is no point in changing its pkey.
+	 */
+	if (p == swapper_pg_dir)
+		return 0;
+
+	return set_memory_pkey(addr, 1, pkey);
+}
+
+static int set_pkey_pte(pmd_t *pmd, int pkey)
+{
+	pte_t *pte;
+	int err;
+
+	pte = pte_offset_kernel(pmd, 0);
+	err = set_page_pkey(pte, pkey);
+
+	return err;
+}
+
+static int set_pkey_pmd(pud_t *pud, int pkey)
+{
+	pmd_t *pmd;
+	int i, err = 0;
+
+	pmd = pmd_offset(pud, 0);
+
+	err = set_page_pkey(pmd, pkey);
+	if (err)
+		return err;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (pmd_none(pmd[i]) || pmd_bad(pmd[i]) || pmd_leaf(pmd[i]))
+			continue;
+		err = set_pkey_pte(&pmd[i], pkey);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int set_pkey_pud(p4d_t *p4d, int pkey)
+{
+	pud_t *pud;
+	int i, err = 0;
+
+	if (mm_pmd_folded(&init_mm))
+		return set_pkey_pmd((pud_t *)p4d, pkey);
+
+	pud = pud_offset(p4d, 0);
+
+	err = set_page_pkey(pud, pkey);
+	if (err)
+		return err;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (pud_none(pud[i]) || pud_bad(pud[i]) || pud_leaf(pud[i]))
+			continue;
+		err = set_pkey_pmd(&pud[i], pkey);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int set_pkey_p4d(pgd_t *pgd, int pkey)
+{
+	p4d_t *p4d;
+	int i, err = 0;
+
+	if (mm_pud_folded(&init_mm))
+		return set_pkey_pud((p4d_t *)pgd, pkey);
+
+	p4d = p4d_offset(pgd, 0);
+
+	err = set_page_pkey(p4d, pkey);
+	if (err)
+		return err;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (p4d_none(p4d[i]) || p4d_bad(p4d[i]) || p4d_leaf(p4d[i]))
+			continue;
+		err = set_pkey_pud(&p4d[i], pkey);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+/**
+ * kernel_pgtables_set_pkey - set pkey for all kernel page table pages
+ * @pkey: pkey to set the page table pages to
+ *
+ * Walks swapper_pg_dir setting the protection key of every page table page (at
+ * all levels) to @pkey. swapper_pg_dir itself is left untouched as it is
+ * expected to be mapped read-only by mark_rodata_ro().
+ *
+ * No-op if the architecture does not support kpkeys.
+ */
+int kernel_pgtables_set_pkey(int pkey)
+{
+	pgd_t *pgd = swapper_pg_dir;
+	int i, err = 0;
+
+	if (!arch_kpkeys_enabled())
+		return 0;
+
+	spin_lock(&init_mm.page_table_lock);
+
+	if (mm_p4d_folded(&init_mm)) {
+		err = set_pkey_p4d(pgd, pkey);
+		goto out;
+	}
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if (pgd_none(pgd[i]) || pgd_bad(pgd[i]) || pgd_leaf(pgd[i]))
+			continue;
+		err = set_pkey_p4d(&pgd[i], pkey);
+		if (err)
+			break;
+	}
+
+out:
+	spin_unlock(&init_mm.page_table_lock);
+	return err;
+}
-- 
2.47.0

