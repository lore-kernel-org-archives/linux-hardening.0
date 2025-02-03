Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9B204584;
	Mon,  3 Feb 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578018; cv=none; b=Ij9QU94U5zgPY7NrXAzcJqORcXfQrJf83AhnDsJeoJi7NNHdPWOkA3v6E9Gnas6Io2xgSuJAiwtJu6ceeXjFvE0MX24O+b+hUkP6rR+Sq7QZk/cawMRE4qyzpreztD841Cn8FGZWdDX749U6Id5UtjpBco5epmYJHkiI8dzgxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578018; c=relaxed/simple;
	bh=Kjo5K1Crtf8dmpQApZPDgxVosi8520Lm98uF5fSX0w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQl6ZOESZMJNimg/BT+RgUsUPrHnSLBQFAAuCZIX3IkKsfLoHisUtOcQ1FR9Kam5nUJ3W+421eFyBnMlbGuy0A4aaeHLp/2VJbGc4Fio4AjWFP6q55NDPjB0GrzfMLd9EfdODIZEe7mE+OPM2fKEzbAbyfKv/Led1HDkuf2Bqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D770F1476;
	Mon,  3 Feb 2025 02:20:40 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E587F3F63F;
	Mon,  3 Feb 2025 02:20:12 -0800 (PST)
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
Subject: [RFC PATCH v3 09/15] mm: Introduce kpkeys_hardened_pgtables
Date: Mon,  3 Feb 2025 10:18:33 +0000
Message-ID: <20250203101839.1223008-10-kevin.brodsky@arm.com>
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

kpkeys_hardened_pgtables is a hardening feature based on kpkeys. It
aims to prevent the corruption of page tables by: 1. mapping all
page table pages, both kernel and user, with a privileged pkey
(KPKEYS_PKEY_PGTABLES), and 2. granting write access to that pkey
only when running at a higher kpkeys level (KPKEYS_LVL_PGTABLES).

The feature is exposed as CONFIG_KPKEYS_HARDENED_PGTABLES; it
requires explicit architecture opt-in by selecting
ARCH_HAS_KPKEYS_HARDENED_PGTABLES, since much of the page table
handling is arch-specific.

This patch introduces an API to modify the PTPs' pkey and switch
kpkeys level using a guard object. Because this API is going to be
called from low-level pgtable helpers (setters, allocators), it must
be inactive on boot and explicitly switched on if and when kpkeys
become available. A static key is used for that purpose; it is the
responsibility of each architecture supporting
kpkeys_hardened_pgtables to call kpkeys_hardened_pgtables_enable()
as early as possible to switch on that static key. The initial
kernel page tables are also walked to set their pkey, since they
have already been allocated at that point.

The definition of the kpkeys_hardened_pgtables guard class does not
use the static key on the restore path to avoid mismatched
set/restore pairs. Indeed, enabling the static key itself involves
modifying page tables, and it is thus possible that the guard object
is created when the static key appears as false, and destroyed when it
appears as true. To avoid this situation, we reserve an invalid value
for the pkey register and use it to disable the restore path.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/asm-generic/kpkeys.h  |  4 ++++
 include/linux/kpkeys.h        | 45 ++++++++++++++++++++++++++++++++++-
 mm/Kconfig                    |  3 +++
 mm/Makefile                   |  1 +
 mm/kpkeys_hardened_pgtables.c | 44 ++++++++++++++++++++++++++++++++++
 security/Kconfig.hardening    | 12 ++++++++++
 6 files changed, 108 insertions(+), 1 deletion(-)
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
index 62f897c65658..645eaf00096c 100644
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
@@ -110,4 +114,43 @@ static inline bool arch_kpkeys_enabled(void)
 
 #endif /* CONFIG_ARCH_HAS_KPKEYS */
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+
+DECLARE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_enabled);
+
+/*
+ * Use guard(kpkeys_hardened_pgtables)() to temporarily grant write access
+ * to page tables.
+ */
+KPKEYS_GUARD_COND(kpkeys_hardened_pgtables, KPKEYS_LVL_PGTABLES,
+		  static_branch_unlikely(&kpkeys_hardened_pgtables_enabled))
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
+KPKEYS_GUARD_NOOP(kpkeys_hardened_pgtables)
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
index 71edc478f111..2a8ebe780e64 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1149,6 +1149,9 @@ config ARCH_HAS_PKEYS
 	bool
 config ARCH_HAS_KPKEYS
 	bool
+# ARCH_HAS_KPKEYS must be selected when selecting this option
+config ARCH_HAS_KPKEYS_HARDENED_PGTABLES
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..130691364172 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
+obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
new file mode 100644
index 000000000000..c6eb7fb6ae56
--- /dev/null
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/mm.h>
+#include <linux/kpkeys.h>
+#include <linux/set_memory.h>
+
+DEFINE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_enabled);
+
+int kpkeys_protect_pgtable_memory(struct folio *folio)
+{
+	unsigned long addr = (unsigned long)folio_address(folio);
+	unsigned int order = folio_order(folio);
+	int ret = 0;
+
+	if (static_branch_unlikely(&kpkeys_hardened_pgtables_enabled))
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
+	if (static_branch_unlikely(&kpkeys_hardened_pgtables_enabled))
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
+	static_branch_enable(&kpkeys_hardened_pgtables_enabled);
+	ret = kernel_pgtables_set_pkey(KPKEYS_PKEY_PGTABLES);
+	WARN_ON(ret);
+}
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index b56e001e0c6a..f729488eac56 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -301,6 +301,18 @@ config BUG_ON_DATA_CORRUPTION
 
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

