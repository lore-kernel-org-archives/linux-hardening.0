Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579BC43214
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB4061038
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbhHaAA6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:00:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:50155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239194AbhHaAA4 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:00:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381522"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381522"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712861"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:01 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/19] x86/cpufeatures: Add feature for pks tables
Date:   Mon, 30 Aug 2021 16:59:15 -0700
Message-Id: <20210830235927.6443-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add a feature for PKS tables and a kernel parameter to disable it if
desired. Check this boot parameter early in boot such that
initialization functionality that happens earlier in boot can be skipped
if the disable boot parameter is present.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/cpufeatures.h            |  2 +-
 arch/x86/include/asm/pgtable.h                |  6 ++++++
 arch/x86/mm/init.c                            |  1 +
 arch/x86/mm/pgtable.c                         | 19 +++++++++++++++++++
 .../arch/x86/include/asm/disabled-features.h  |  8 +++++++-
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 80c357f638fd..8d2c4e9d32ec 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_PKS_TABLES		( 3*32+10) /* "" Write protected page tables */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 3c119ef49062..3505e3b1f40b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -118,8 +118,14 @@ extern pmdval_t early_pmd_flags;
 #endif	/* CONFIG_PARAVIRT_XXL */
 
 #ifdef CONFIG_PKS_PG_TABLES
+void pks_tables_check_boottime_disable(void);
+void enable_pgtable_write(void);
+void disable_pgtable_write(void);
 bool pks_tables_inited(void);
 #else /* CONFIG_PKS_PG_TABLES */
+static inline void pks_tables_check_boottime_disable(void) { }
+static void enable_pgtable_write(void) { }
+static void disable_pgtable_write(void) { }
 #define pks_tables_inited() 0
 #endif /* CONFIG_PKS_PG_TABLES */
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 75ef19aa8903..c8933c6d5efd 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -719,6 +719,7 @@ void __init init_mem_mapping(void)
 	unsigned long end;
 
 	pti_check_boottime_disable();
+	pks_tables_check_boottime_disable();
 	probe_page_size_mask();
 	setup_pcid();
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 4b929fa1a0ac..ef0b4ce95522 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -7,6 +7,7 @@
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
 #include <asm/set_memory.h>
+#include <asm/cmdline.h>
 #include <linux/page-flags.h>
 
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
@@ -930,6 +931,24 @@ static int __init pks_page_init(void)
 }
 
 device_initcall(pks_page_init);
+
+__init void pks_tables_check_boottime_disable(void)
+{
+	if (cmdline_find_option_bool(boot_command_line, "nopkstables"))
+		return;
+
+	/*
+	 * PTI will want to allocate higher order page table pages, which the
+	 * PKS table allocator doesn't support. So don't attempt to enable PKS
+	 * tables in this case.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_PTI)) {
+		pr_info("PTI enabled, not enabling PKS tables");
+		return;
+	}
+	setup_force_cpu_cap(X86_FEATURE_PKS_TABLES);
+}
+
 #endif /* CONFIG_PKS_PG_TABLES */
 #else /* !CONFIG_X86_64 */
 
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..d98bdfa72170 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -50,6 +50,12 @@
 # define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
 #endif
 
+#ifdef CONFIG_PKS_TABLES
+# define DISABLE_PKS_TABLES		0
+#else
+# define DISABLE_PKS_TABLES		(1 << (X86_FEATURE_PKS_TABLES & 31))
+#endif
+
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
@@ -75,7 +81,7 @@
 #define DISABLED_MASK4	(DISABLE_PCID)
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
-#define DISABLED_MASK7	(DISABLE_PTI)
+#define DISABLED_MASK7	(DISABLE_PTI|DISABLE_PKS_TABLES)
 #define DISABLED_MASK8	0
 #define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
 #define DISABLED_MASK10	0
-- 
2.17.1

