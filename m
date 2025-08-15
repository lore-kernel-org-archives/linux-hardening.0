Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6332BDC21;
	Fri, 15 Aug 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248211; cv=none; b=ag8XtarJKuDvZK/176wATB9BnEwVTvZpzYIvm2xPO7uOgxG5ja29Zzr3MTrERLVrXI8bvtw3VQu+6g/HWs6YKNyAXQcJAz8FXltBx8YHr49vqOYPmF+hEpM6EhQ94oKChgGkImbPGHBmN2MbVi9HsETW/Yj28jyGfP7jkXzBsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248211; c=relaxed/simple;
	bh=6BdOHuGR84+0veFfdcaAbFAWk3TWkmEjJXfe4lBxfqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SODPuaZpg1msErTIgQQVurPaPsHHjWsb0z5b549wOjIxAqEtYRP0iBb4qmjBKVjTBusYnGxePv6s7Q/S5NQZthpySPqqaAe5ia8isyKvb6Zs0IUXyi3BoMc78F6w78cablZsNwq4Ww3UgDi2rHm+SzcFu+NoikVwPnrca34BUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2900D497;
	Fri, 15 Aug 2025 01:56:41 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C52313F63F;
	Fri, 15 Aug 2025 01:56:44 -0700 (PDT)
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
Subject: [RFC PATCH v5 17/18] mm: Add basic tests for kpkeys_hardened_pgtables
Date: Fri, 15 Aug 2025 09:55:11 +0100
Message-ID: <20250815085512.2182322-18-kevin.brodsky@arm.com>
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

Add basic tests for the kpkeys_hardened_pgtables feature: try to
perform a direct write to kernel and user page table entries and
ensure it fails.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 mm/Makefile                               |   1 +
 mm/tests/kpkeys_hardened_pgtables_kunit.c | 106 ++++++++++++++++++++++
 security/Kconfig.hardening                |  12 +++
 3 files changed, 119 insertions(+)
 create mode 100644 mm/tests/kpkeys_hardened_pgtables_kunit.c

diff --git a/mm/Makefile b/mm/Makefile
index 10848df0ca85..b1e6cf7f753c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -148,3 +148,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
+obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES_KUNIT_TEST) += tests/kpkeys_hardened_pgtables_kunit.o
diff --git a/mm/tests/kpkeys_hardened_pgtables_kunit.c b/mm/tests/kpkeys_hardened_pgtables_kunit.c
new file mode 100644
index 000000000000..3d916f0719d0
--- /dev/null
+++ b/mm/tests/kpkeys_hardened_pgtables_kunit.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/mman.h>
+#include <linux/pgtable.h>
+#include <linux/vmalloc.h>
+
+KUNIT_DEFINE_ACTION_WRAPPER(vfree_wrapper, vfree, const void *);
+
+static inline pte_t *get_kernel_pte(unsigned long addr)
+{
+	pmd_t *pmdp = pmd_off_k(addr);
+
+	if (!pmdp || pmd_leaf(*pmdp))
+		return NULL;
+
+	return pte_offset_kernel(pmdp, addr);
+}
+
+static void write_linear_map_pte(struct kunit *test)
+{
+	pte_t *ptep;
+	pte_t pte;
+	int ret;
+
+	if (!arch_kpkeys_enabled())
+		kunit_skip(test, "kpkeys are not supported");
+
+	/*
+	 * The choice of address is mostly arbitrary - we just need something
+	 * that is PTE-mapped, such as a global variable.
+	 */
+	ptep = get_kernel_pte((unsigned long)&init_mm);
+	KUNIT_ASSERT_NOT_NULL_MSG(test, ptep, "Failed to get PTE");
+
+	pte = ptep_get(ptep);
+	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
+	ret = copy_to_kernel_nofault(ptep, &pte, sizeof(pte));
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
+			    "Direct PTE write wasn't prevented");
+}
+
+static void write_kernel_vmalloc_pte(struct kunit *test)
+{
+	void *mem;
+	pte_t *ptep;
+	pte_t pte;
+	int ret;
+
+	if (!arch_kpkeys_enabled())
+		kunit_skip(test, "kpkeys are not supported");
+
+	mem = vmalloc(PAGE_SIZE);
+	KUNIT_ASSERT_NOT_NULL(test, mem);
+	ret = kunit_add_action_or_reset(test, vfree_wrapper, mem);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ptep = get_kernel_pte((unsigned long)mem);
+	KUNIT_ASSERT_NOT_NULL_MSG(test, ptep, "Failed to get PTE");
+
+	pte = ptep_get(ptep);
+	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
+	ret = copy_to_kernel_nofault(ptep, &pte, sizeof(pte));
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
+			    "Direct PTE write wasn't prevented");
+}
+
+static void write_user_pmd(struct kunit *test)
+{
+	pmd_t *pmdp;
+	pmd_t pmd;
+	unsigned long uaddr;
+	int ret;
+
+	if (!arch_kpkeys_enabled())
+		kunit_skip(test, "kpkeys are not supported");
+
+	uaddr = kunit_vm_mmap(test, NULL, 0, PAGE_SIZE, PROT_READ,
+			      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, 0);
+	KUNIT_ASSERT_NE_MSG(test, uaddr, 0, "Could not create userspace mm");
+
+	/* We passed MAP_POPULATE so a PMD should already be allocated */
+	pmdp = pmd_off(current->mm, uaddr);
+	KUNIT_ASSERT_NOT_NULL_MSG(test, pmdp, "Failed to get PMD");
+
+	pmd = pmdp_get(pmdp);
+	pmd = set_pmd_bit(pmd, __pgprot(PROT_SECT_NORMAL));
+	ret = copy_to_kernel_nofault(pmdp, &pmd, sizeof(pmd));
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
+			    "Direct PMD write wasn't prevented");
+}
+
+static struct kunit_case kpkeys_hardened_pgtables_test_cases[] = {
+	KUNIT_CASE(write_linear_map_pte),
+	KUNIT_CASE(write_kernel_vmalloc_pte),
+	KUNIT_CASE(write_user_pmd),
+	{}
+};
+
+static struct kunit_suite kpkeys_hardened_pgtables_test_suite = {
+	.name = "Hardened pgtables using kpkeys",
+	.test_cases = kpkeys_hardened_pgtables_test_cases,
+};
+kunit_test_suite(kpkeys_hardened_pgtables_test_suite);
+
+MODULE_DESCRIPTION("Tests for the kpkeys_hardened_pgtables feature");
+MODULE_LICENSE("GPL");
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 41b7530530b7..653663008096 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -277,6 +277,18 @@ config KPKEYS_HARDENED_PGTABLES
 	  This option has no effect if the system does not support
 	  kernel pkeys.
 
+config KPKEYS_HARDENED_PGTABLES_KUNIT_TEST
+	tristate "KUnit tests for kpkeys_hardened_pgtables" if !KUNIT_ALL_TESTS
+	depends on KPKEYS_HARDENED_PGTABLES
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to check that the kpkeys_hardened_pgtables feature
+	  functions as intended, i.e. prevents arbitrary writes to user and
+	  kernel page tables.
+
+	  If unsure, say N.
+
 endmenu
 
 config CC_HAS_RANDSTRUCT
-- 
2.47.0

