Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473EF20126A;
	Fri,  6 Dec 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480024; cv=none; b=c0Wh2Ky85osUdnYpZSAT16o9anMdyOiSij/nmx3ZEWPbsHPsyiCyGqgBzGxKzYYJZH8wyOFuOrHPC0NHEzCEzqsajNciO9C8Zcl9rWDdpl8wcYPays1ZcuPUjsuXsTEW0a3+3n6gmCX3oFC2bojKDNWr0Opdq0eadgWkIIff71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480024; c=relaxed/simple;
	bh=qSfYtuzvw72wBWwbnXwGw6YowtBDZuAywT62Vc53Zq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv8PEQFSPMGXUrQZHRn7m/wMxUWPjxtAZeiSsfD6v8OX50uv8c9kVdocsFKR7l0c1opYPJlWhXEpINAAGtFl9Cr5is8o0YTrvrNp/hrXp2J2jxZc/KuchvLzG+2GSLbP1sxWDGBzKbsxNcIn+cbkbWfucBWboETAFjJSnuNbAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A511B12FC;
	Fri,  6 Dec 2024 02:14:09 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBBCB3F71E;
	Fri,  6 Dec 2024 02:13:38 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	jannh@google.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	kees@kernel.org,
	maz@kernel.org,
	pierre.langlois@arm.com,
	qperret@google.com,
	ryan.roberts@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH 09/16] mm: Introduce kpkeys_hardened_pgtables
Date: Fri,  6 Dec 2024 10:11:03 +0000
Message-ID: <20241206101110.1646108-10-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
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
 include/asm-generic/kpkeys.h  | 12 +++++++
 include/linux/kpkeys.h        | 67 ++++++++++++++++++++++++++++++++++-
 mm/Kconfig                    |  3 ++
 mm/Makefile                   |  1 +
 mm/kpkeys_hardened_pgtables.c | 17 +++++++++
 security/Kconfig.hardening    | 12 +++++++
 6 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 mm/kpkeys_hardened_pgtables.c

diff --git a/include/asm-generic/kpkeys.h b/include/asm-generic/kpkeys.h
index 3404ce249757..cec92334a9f3 100644
--- a/include/asm-generic/kpkeys.h
+++ b/include/asm-generic/kpkeys.h
@@ -2,8 +2,20 @@
 #ifndef __ASM_GENERIC_KPKEYS_H
 #define __ASM_GENERIC_KPKEYS_H
 
+#ifndef KPKEYS_PKEY_PGTABLES
+#define KPKEYS_PKEY_PGTABLES	1
+#endif
+
 #ifndef KPKEYS_PKEY_DEFAULT
 #define KPKEYS_PKEY_DEFAULT	0
 #endif
 
+/*
+ * Represents a pkey register value that cannot be used, typically disabling
+ * access to all keys.
+ */
+#ifndef KPKEYS_PKEY_REG_INVAL
+#define KPKEYS_PKEY_REG_INVAL	0
+#endif
+
 #endif	/* __ASM_GENERIC_KPKEYS_H */
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index bcc063425926..bd3e0f36d2d6 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -4,12 +4,14 @@
 
 #include <linux/bug.h>
 #include <linux/cleanup.h>
+#include <linux/jump_label.h>
 #include <linux/set_memory.h>
 
 #define KPKEYS_LVL_DEFAULT	0
+#define KPKEYS_LVL_PGTABLES	1
 
 #define KPKEYS_LVL_MIN		KPKEYS_LVL_DEFAULT
-#define KPKEYS_LVL_MAX		KPKEYS_LVL_DEFAULT
+#define KPKEYS_LVL_MAX		KPKEYS_LVL_PGTABLES
 
 #define KPKEYS_GUARD(_name, set_level, restore_pkey_reg)		\
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false);			\
@@ -64,4 +66,67 @@ static inline bool arch_kpkeys_enabled(void)
 
 #endif /* CONFIG_ARCH_HAS_KPKEYS */
 
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+
+DECLARE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_enabled);
+
+/*
+ * Use guard(kpkeys_hardened_pgtables)() to temporarily grant write access
+ * to page tables.
+ */
+KPKEYS_GUARD(kpkeys_hardened_pgtables,
+	     static_branch_unlikely(&kpkeys_hardened_pgtables_enabled) ?
+		     kpkeys_set_level(KPKEYS_LVL_PGTABLES) :
+		     KPKEYS_PKEY_REG_INVAL,
+	     _T != KPKEYS_PKEY_REG_INVAL ?
+		     kpkeys_restore_pkey_reg(_T) :
+		     (void)0)
+
+static inline int kpkeys_protect_pgtable_memory(unsigned long addr, int numpages)
+{
+	int ret = 0;
+
+	if (static_branch_unlikely(&kpkeys_hardened_pgtables_enabled))
+		ret = set_memory_pkey(addr, numpages, KPKEYS_PKEY_PGTABLES);
+
+	WARN_ON(ret);
+	return ret;
+}
+
+static inline int kpkeys_unprotect_pgtable_memory(unsigned long addr, int numpages)
+{
+	int ret = 0;
+
+	if (static_branch_unlikely(&kpkeys_hardened_pgtables_enabled))
+		ret = set_memory_pkey(addr, numpages, KPKEYS_PKEY_DEFAULT);
+
+	WARN_ON(ret);
+	return ret;
+}
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
+KPKEYS_GUARD(kpkeys_hardened_pgtables, 0, (void)_T)
+
+static inline int kpkeys_protect_pgtable_memory(unsigned long addr, int numpages)
+{
+	return 0;
+}
+static inline int kpkeys_unprotect_pgtable_memory(unsigned long addr, int numpages)
+{
+	return 0;
+}
+static inline void kpkeys_hardened_pgtables_enable(void) {}
+
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
 #endif /* _LINUX_KPKEYS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index f51dffca9d4e..07ae45a1395f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1106,6 +1106,9 @@ config ARCH_HAS_PKEYS
 	bool
 config ARCH_HAS_KPKEYS
 	bool
+# ARCH_HAS_KPKEYS must be selected when selecting this option
+config ARCH_HAS_KPKEYS_HARDENED_PGTABLES
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
diff --git a/mm/Makefile b/mm/Makefile
index dba52bb0da8a..ffe799c1c897 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -146,3 +146,4 @@ obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
+obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
new file mode 100644
index 000000000000..e26fc20bdafe
--- /dev/null
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/mm.h>
+#include <linux/kpkeys.h>
+
+DEFINE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_enabled);
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
index c9d5ca3d8d08..95f93f1d4055 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -300,6 +300,18 @@ config BUG_ON_DATA_CORRUPTION
 
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

