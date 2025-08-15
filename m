Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640172F0669;
	Fri, 15 Aug 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248182; cv=none; b=F7gccMEXREopI2K1wGfy+Z5cOYzXDdvfVdtfYj40eqkf9tD53PoRhanj/ehrQycSCzWx6+qBy3UNd9KG0O4geX9ECh0439DQC2lXXUKcbov3j13cBINXyWBAKAj79t23W1yIiuPCq0SAQ80RNLZEW4a0ubzYEBxUgUveVklvqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248182; c=relaxed/simple;
	bh=r+JSQKdi5dzAjbtVEKpEWaEwHP8e7BXDXVkpz1ngfiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiRmvr4bHTxW6d+bGRv4RwEG3QLw0fEldVGv1BzF5l0SS4oYSntCLkt7E5YuRdhbgb6lcHMeHPEzbRlAd2t8OX0trsdM+PkIIOXc1lO4UKELlhZuvS+wxcatxHhRyNyhQxcABvbcKD4mdVDK2Sbx4inVUDFhDT6b3icupeLd9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38611688;
	Fri, 15 Aug 2025 01:56:11 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4DA3F63F;
	Fri, 15 Aug 2025 01:56:15 -0700 (PDT)
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
Subject: [RFC PATCH v5 11/18] mm: Introduce kpkeys_hardened_pgtables
Date: Fri, 15 Aug 2025 09:55:05 +0100
Message-ID: <20250815085512.2182322-12-kevin.brodsky@arm.com>
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

kpkeys_hardened_pgtables is a hardening feature based on kpkeys. It
aims to prevent the corruption of page tables by: 1. mapping all
page table pages, both kernel and user, with a privileged pkey
(KPKEYS_PKEY_PGTABLES), and 2. granting write access to that pkey
only when running at a higher kpkeys level (KPKEYS_LVL_PGTABLES).

The feature is exposed as CONFIG_KPKEYS_HARDENED_PGTABLES; it
requires explicit architecture opt-in by selecting
ARCH_HAS_KPKEYS_HARDENED_PGTABLES, since much of the page table
handling is arch-specific.

This patch introduces an API to modify the PTPs' pkey. Because this
API is going to be called from low-level pgtable helpers, it must
be inactive on boot and explicitly switched on if and when kpkeys
become available. A static key is used for that purpose; it is the
responsibility of each architecture supporting
kpkeys_hardened_pgtables to call kpkeys_hardened_pgtables_enable()
as early as possible to switch on that static key. The initial
kernel page tables are also walked to set their pkey, since they
have already been allocated at that point.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/asm-generic/kpkeys.h  |  4 +++
 include/linux/kpkeys.h        | 46 ++++++++++++++++++++++++++++++++++-
 mm/Kconfig                    |  3 +++
 mm/Makefile                   |  1 +
 mm/kpkeys_hardened_pgtables.c | 44 +++++++++++++++++++++++++++++++++
 security/Kconfig.hardening    | 12 +++++++++
 6 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 mm/kpkeys_hardened_pgtables.c

diff --git a/include/asm-generic/kpkeys.h b/include/asm-generic/kpkeys.h
index ab819f157d6a..cec92334a9f3 100644
--- a/include/asm-generic/kpkeys.h
+++ b/include/asm-generic/kpkeys.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_GENERIC_KPKEYS_H
 #define __ASM_GENERIC_KPKEYS_H
 
+#ifndef KPKEYS_PKEY_PGTABLES
+#define KPKEYS_PKEY_PGTABLES	1
+#endif
+
 #ifndef KPKEYS_PKEY_DEFAULT
 #define KPKEYS_PKEY_DEFAULT	0
 #endif
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index faa6e2615798..5f4b096374ba 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -4,11 +4,15 @@
 
 #include <linux/bug.h>
 #include <linux/cleanup.h>
+#include <linux/jump_label.h>
+
+struct folio;
 
 #define KPKEYS_LVL_DEFAULT	0
+#define KPKEYS_LVL_PGTABLES	1
 
 #define KPKEYS_LVL_MIN		KPKEYS_LVL_DEFAULT
-#define KPKEYS_LVL_MAX		KPKEYS_LVL_DEFAULT
+#define KPKEYS_LVL_MAX		KPKEYS_LVL_PGTABLES
 
 #define __KPKEYS_GUARD(name, set_level, restore_pkey_reg, set_arg, ...)	\
 	__DEFINE_CLASS_IS_CONDITIONAL(name, false);			\
@@ -110,4 +114,44 @@ static inline bool arch_kpkeys_enabled(void)
 
 #endif /* CONFIG_ARCH_HAS_KPKEYS */
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+
+DECLARE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_key);
+
+static inline bool kpkeys_hardened_pgtables_enabled(void)
+{
+	return static_branch_unlikely(&kpkeys_hardened_pgtables_key);
+}
+
+int kpkeys_protect_pgtable_memory(struct folio *folio);
+int kpkeys_unprotect_pgtable_memory(struct folio *folio);
+
+/*
+ * Enables kpkeys_hardened_pgtables and switches existing kernel page tables to
+ * a privileged pkey (KPKEYS_PKEY_PGTABLES).
+ *
+ * Should be called as early as possible by architecture code, after (k)pkeys
+ * are initialised and before any user task is spawned.
+ */
+void kpkeys_hardened_pgtables_enable(void);
+
+#else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
+static inline bool kpkeys_hardened_pgtables_enabled(void)
+{
+	return false;
+}
+
+static inline int kpkeys_protect_pgtable_memory(struct folio *folio)
+{
+	return 0;
+}
+static inline int kpkeys_unprotect_pgtable_memory(struct folio *folio)
+{
+	return 0;
+}
+static inline void kpkeys_hardened_pgtables_enable(void) {}
+
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
 #endif /* _LINUX_KPKEYS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 90f2e5c381a6..e34edf5c41e7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1175,6 +1175,9 @@ config ARCH_HAS_PKEYS
 	bool
 config ARCH_HAS_KPKEYS
 	bool
+# ARCH_HAS_KPKEYS must be selected when selecting this option
+config ARCH_HAS_KPKEYS_HARDENED_PGTABLES
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
diff --git a/mm/Makefile b/mm/Makefile
index ef54aa615d9d..10848df0ca85 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
+obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
new file mode 100644
index 000000000000..931fa97bc8a7
--- /dev/null
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/mm.h>
+#include <linux/kpkeys.h>
+#include <linux/set_memory.h>
+
+DEFINE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_key);
+
+int kpkeys_protect_pgtable_memory(struct folio *folio)
+{
+	unsigned long addr = (unsigned long)folio_address(folio);
+	unsigned int order = folio_order(folio);
+	int ret = 0;
+
+	if (kpkeys_hardened_pgtables_enabled())
+		ret = set_memory_pkey(addr, 1 << order, KPKEYS_PKEY_PGTABLES);
+
+	WARN_ON(ret);
+	return ret;
+}
+
+int kpkeys_unprotect_pgtable_memory(struct folio *folio)
+{
+	unsigned long addr = (unsigned long)folio_address(folio);
+	unsigned int order = folio_order(folio);
+	int ret = 0;
+
+	if (kpkeys_hardened_pgtables_enabled())
+		ret = set_memory_pkey(addr, 1 << order, KPKEYS_PKEY_DEFAULT);
+
+	WARN_ON(ret);
+	return ret;
+}
+
+void __init kpkeys_hardened_pgtables_enable(void)
+{
+	int ret;
+
+	if (!arch_kpkeys_enabled())
+		return;
+
+	static_branch_enable(&kpkeys_hardened_pgtables_key);
+	ret = kernel_pgtables_set_pkey(KPKEYS_PKEY_PGTABLES);
+	WARN_ON(ret);
+}
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index b9a5bc3430aa..41b7530530b7 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -265,6 +265,18 @@ config BUG_ON_DATA_CORRUPTION
 
 	  If unsure, say N.
 
+config KPKEYS_HARDENED_PGTABLES
+	bool "Harden page tables using kernel pkeys"
+	depends on ARCH_HAS_KPKEYS_HARDENED_PGTABLES
+	help
+	  This option makes all page tables mostly read-only by
+	  allocating them with a non-default protection key (pkey) and
+	  only enabling write access to that pkey in routines that are
+	  expected to write to page table entries.
+
+	  This option has no effect if the system does not support
+	  kernel pkeys.
+
 endmenu
 
 config CC_HAS_RANDSTRUCT
-- 
2.47.0

