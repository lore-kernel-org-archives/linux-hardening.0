Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D820127E;
	Mon,  3 Feb 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578041; cv=none; b=H4bESaa4ghPIoKsqLF7EUp4bhg4sRYaACWxryvVza1+UCF/OeqmBhKxJqAgCk19gpkuaHkchZrXXSPCsUnS6M8M8la2lxMhaPRw1T4Ci1jJjMUDgz0JnoWVEwUXGn4YRk0D/yDons+V4Bq7MdJU8wl4g5yE9NJCEMAMCQiok/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578041; c=relaxed/simple;
	bh=R2OITuWs4Mkl+wMNPzMdlUJVmHUXXatoMZG9rVG7iDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iASlmZ5Nmd5EUyjaZPjhwIY416bqwInuQJADEEaeJKWFeyZt3qPvrMo8bRP2uHmi4oa2czw6pXp93XRP9u9ho/dbxYxARBiMOslzDnjOD+/0k58oW2f8EZNu941/2VpMTvytAXHHSmtpWP+CaXvAURGqZBBXP47tWuaR1InjEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C21571476;
	Mon,  3 Feb 2025 02:21:03 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01593F63F;
	Mon,  3 Feb 2025 02:20:35 -0800 (PST)
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
Subject: [RFC PATCH v3 15/15] mm: Add basic tests for kpkeys_hardened_pgtables
Date: Mon,  3 Feb 2025 10:18:39 +0000
Message-ID: <20250203101839.1223008-16-kevin.brodsky@arm.com>
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

Add basic tests for the kpkeys_hardened_pgtables feature: try to
perform a direct write to some kernel and user page table entry and
ensure it fails.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 mm/Makefile                        |  1 +
 mm/kpkeys_hardened_pgtables_test.c | 72 ++++++++++++++++++++++++++++++
 security/Kconfig.hardening         | 12 +++++
 3 files changed, 85 insertions(+)
 create mode 100644 mm/kpkeys_hardened_pgtables_test.c

diff --git a/mm/Makefile b/mm/Makefile
index 130691364172..f7263b7f45b8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -148,3 +148,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
+obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES_TEST) += kpkeys_hardened_pgtables_test.o
diff --git a/mm/kpkeys_hardened_pgtables_test.c b/mm/kpkeys_hardened_pgtables_test.c
new file mode 100644
index 000000000000..86d862d43bea
--- /dev/null
+++ b/mm/kpkeys_hardened_pgtables_test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/pgtable.h>
+#include <linux/mman.h>
+
+static void write_kernel_pte(struct kunit *test)
+{
+	pte_t *ptep;
+	pte_t pte;
+	int ret;
+
+	/*
+	 * The choice of address is mostly arbitrary - we just need a page
+	 * that is definitely mapped, such as the current function.
+	 */
+	ptep = virt_to_kpte((unsigned long)&write_kernel_pte);
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
+static int kpkeys_hardened_pgtables_suite_init(struct kunit_suite *suite)
+{
+	if (!arch_kpkeys_enabled()) {
+		pr_err("Cannot run kpkeys_hardened_pgtables tests: kpkeys are not supported\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct kunit_case kpkeys_hardened_pgtables_test_cases[] = {
+	KUNIT_CASE(write_kernel_pte),
+	KUNIT_CASE(write_user_pmd),
+	{}
+};
+
+static struct kunit_suite kpkeys_hardened_pgtables_test_suite = {
+	.name = "Hardened pgtables using kpkeys",
+	.test_cases = kpkeys_hardened_pgtables_test_cases,
+	.suite_init = kpkeys_hardened_pgtables_suite_init,
+};
+kunit_test_suite(kpkeys_hardened_pgtables_test_suite);
+
+MODULE_DESCRIPTION("Tests for the kpkeys_hardened_pgtables feature");
+MODULE_LICENSE("GPL");
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index f729488eac56..649847535fc3 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -313,6 +313,18 @@ config KPKEYS_HARDENED_PGTABLES
 	  This option has no effect if the system does not support
 	  kernel pkeys.
 
+config KPKEYS_HARDENED_PGTABLES_TEST
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

