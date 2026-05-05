Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A276548AE04
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997276; cv=none; b=H5fTvTuxiCvJS2o501sBH9bymFBniuXtx7FGBRKu92VsqiXdm82/AEq7rME5hUvmlOMl4VEagxpfaI0hqZwcxxEIqSYd+ifo19U5i19MaQ2y8lD9b/mCM1ImEXTwus9N2mj/90hKxGnano/OUXvu1LCOqOOcbcbThluArj1ht6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997276; c=relaxed/simple;
	bh=ozeOAdr3jlygQ+LzFQQTepylRW4GqnLBcYHZvpRCf6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K79axrXbwVh5x1VbG4psIQcFAq0BLRPxZiXAwYMZa12xRGGHAixeLFC3xTqaJO97vBMcRhhjYDRAEuZH+7vscSIC6LNzj6BBZf3fxmHedZDNmYFp48BPHlP0ncEAZsWw6eeIXI1YKo4eMWTZu5Gcr7BeEhoyYczfIzgZy0aHy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oDYOzeRr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oDYOzeRr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F7002681;
	Tue,  5 May 2026 09:07:48 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3DA3F763;
	Tue,  5 May 2026 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777997273; bh=ozeOAdr3jlygQ+LzFQQTepylRW4GqnLBcYHZvpRCf6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDYOzeRrxGkb6WgoF0/tyhcey0msj2rO63eaDHL/bZMbXnLNk38qmc2noaeoKNg8i
	 j8Z/2K7AQVJRPSMdDymRQUZUTGRMnJcfZLiSBSBMLyV7UxJ+P7EpkRcli994jTEJGD
	 Oc0LULVHGtjY3GvmDi9RsdzEtatCBoO9JuZW+ySQ=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 05 May 2026 17:06:00 +0100
Subject: [PATCH RFC v7 11/24] mm: kpkeys: Introduce
 kpkeys_hardened_pgtables feature
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-kpkeys-v7-11-20c0bdd97197@arm.com>
References: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
In-Reply-To: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
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
 Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777997220; l=5877;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=ozeOAdr3jlygQ+LzFQQTepylRW4GqnLBcYHZvpRCf6g=;
 b=eU7WrOKEsysSiJ7rQ1VLcmV9b9H85aOAXkzAXSutH6Aajlxhc3Iyh95ydDqhVRFPKQr6UUuUE
 QFdbj/hha2nBMtl+J4l+gDkDdlWAalvI6ADOBzdJcUQAWtlYjqbGbgX
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

kpkeys_hardened_pgtables is a hardening feature based on kpkeys. It
aims to prevent the corruption of page tables by: 1. mapping all
page table pages, both kernel and user, with a privileged pkey
(KPKEYS_PKEY_PGTABLES), and 2. granting write access to that pkey
only when running at in a privileged kpkeys context
(KPKEYS_CTX_PGTABLES). This patch introduces basic infrastructure;
the implementation of both aspects will follow.

The feature is exposed as CONFIG_KPKEYS_HARDENED_PGTABLES; it
requires explicit architecture opt-in by selecting
ARCH_HAS_KPKEYS_HARDENED_PGTABLES, since much of the page table
handling is arch-specific.

Because this feature relies on kpkeys being available and enabled,
and modifies attributes of the linear map, it must be inactive on
boot. kpkeys_hardened_pgtables_init() enables it by toggling a
static key; this function must be called by supported architectures
in mem_init(), before any call to pagetable_alloc() is made.

Supported architectures must also provide
arch_supports_kpkeys_early() in <asm/kpkeys.h>. This will be used
during early boot to detect whether kpkeys_hardened_pgtables is
going to be enabled (e.g. to decide how to allocate early page
tables).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/asm-generic/kpkeys.h  |  4 ++++
 include/linux/kpkeys.h        | 40 +++++++++++++++++++++++++++++++++++++++-
 mm/Kconfig                    |  3 +++
 mm/Makefile                   |  1 +
 mm/kpkeys_hardened_pgtables.c | 16 ++++++++++++++++
 security/Kconfig.hardening    | 12 ++++++++++++
 6 files changed, 75 insertions(+), 1 deletion(-)

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
index cb2d22758391..1ed0299ad5ac 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -4,11 +4,13 @@
 
 #include <linux/bug.h>
 #include <linux/cleanup.h>
+#include <linux/jump_label.h>
 
 #define KPKEYS_CTX_DEFAULT	0
+#define KPKEYS_CTX_PGTABLES	1
 
 #define KPKEYS_CTX_MIN		KPKEYS_CTX_DEFAULT
-#define KPKEYS_CTX_MAX		KPKEYS_CTX_DEFAULT
+#define KPKEYS_CTX_MAX		KPKEYS_CTX_PGTABLES
 
 #define __KPKEYS_GUARD(name, set_context, restore_pkey_reg, set_arg, ...) \
 	__DEFINE_CLASS_IS_CONDITIONAL(name, false);			\
@@ -115,4 +117,40 @@ static inline bool kpkeys_enabled(void)
 
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
+static inline bool kpkeys_hardened_pgtables_early_enabled(void)
+{
+	return arch_supports_kpkeys_early();
+}
+
+/*
+ * Should be called from mem_init(): as soon as the buddy allocator becomes
+ * available and before any call to pagetable_alloc().
+ */
+void kpkeys_hardened_pgtables_init(void);
+
+#else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
+static inline bool kpkeys_hardened_pgtables_enabled(void)
+{
+	return false;
+}
+
+static inline bool kpkeys_hardened_pgtables_early_enabled(void)
+{
+	return false;
+}
+
+static inline void kpkeys_hardened_pgtables_init(void) {}
+
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
 #endif /* _LINUX_KPKEYS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 819fb0d7b7bd..dbba6b878d5a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1244,6 +1244,9 @@ config ARCH_HAS_PKEYS
 	bool
 config ARCH_HAS_KPKEYS
 	bool
+# ARCH_HAS_KPKEYS must be selected when selecting this option
+config ARCH_HAS_KPKEYS_HARDENED_PGTABLES
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
diff --git a/mm/Makefile b/mm/Makefile
index 8ad2ab08244e..7603e6051afa 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -150,3 +150,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) += tests/lazy_mmu_mode_kunit.o
+obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
diff --git a/mm/kpkeys_hardened_pgtables.c b/mm/kpkeys_hardened_pgtables.c
new file mode 100644
index 000000000000..763f267bbfe4
--- /dev/null
+++ b/mm/kpkeys_hardened_pgtables.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kpkeys.h>
+#include <linux/mm.h>
+
+#include <kunit/visibility.h>
+
+__ro_after_init DEFINE_STATIC_KEY_FALSE(kpkeys_hardened_pgtables_key);
+EXPORT_SYMBOL_IF_KUNIT(kpkeys_hardened_pgtables_key);
+
+void __init kpkeys_hardened_pgtables_init(void)
+{
+	if (!kpkeys_enabled())
+		return;
+
+	static_branch_enable(&kpkeys_hardened_pgtables_key);
+}
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 86f8768c63d4..fdaf977d4626 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -275,6 +275,18 @@ config BUG_ON_DATA_CORRUPTION
 
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
2.51.2

