Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B0C43216
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7030060F4B
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbhHaABP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:01:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:50155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233270AbhHaABI (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:01:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381561"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381561"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530713028"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:09 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 18/19] x86/mm: Add PKS table soft mode
Date:   Mon, 30 Aug 2021 16:59:26 -0700
Message-Id: <20210830235927.6443-19-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Some users may not want to treat errant page table writes as fatal, and
would prefer to just log the invalid access and continue. Add a "soft"
mode for this. Add a config to make always make this the default behavior,
and a config to enable it at boot in the absence of the new config.

After a single warning, the page tables will be writable, so no warnings
will be reported until the next reboot.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/x86/include/asm/pgtable.h                  |  1 +
 arch/x86/mm/pgtable.c                           | 16 +++++++++++++++-
 arch/x86/mm/pkeys.c                             |  3 +++
 mm/Kconfig                                      | 12 ++++++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7902fce7f1da..8bb290fee77f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4254,6 +4254,10 @@
 	nopti		[X86-64]
 			Equivalent to pti=off
 
+	nopkstables	[X86-64] Disable PKS page table protection
+
+	pkstablessoft	[X86-64] Warn instead of oops on pks tables violations
+
 	pty.legacy_count=
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 871308c40dac..2e4b4308bd59 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -122,6 +122,7 @@ void pks_tables_check_boottime_disable(void);
 void enable_pgtable_write(void);
 void disable_pgtable_write(void);
 bool pks_tables_inited(void);
+bool pks_tables_fault(unsigned long addr, bool write);
 #else /* CONFIG_PKS_PG_TABLES */
 static inline void pks_tables_check_boottime_disable(void) { }
 static void enable_pgtable_write(void) { }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69b43097c9da..0dcbd976a91b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -40,7 +40,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 #ifdef CONFIG_PKS_PG_TABLES
 static struct grouped_page_cache gpc_pks;
 static bool __ro_after_init pks_tables_inited_val;
-
+static bool __ro_after_init pks_tables_soft;
 
 struct page *alloc_table_node(gfp_t gfp, int node)
 {
@@ -971,6 +971,16 @@ bool pks_tables_inited(void)
 	return pks_tables_inited_val;
 }
 
+bool pks_tables_fault(unsigned long addr, bool write)
+{
+	WARN(1, "Write to protected page table, exploit attempt?");
+	if (!pks_tables_soft)
+		return 0;
+
+	pks_abandon_protections(PKS_KEY_PG_TABLES);
+	return 1;
+}
+
 static int __init pks_page_init(void)
 {
 	/*
@@ -999,6 +1009,10 @@ __init void pks_tables_check_boottime_disable(void)
 	if (cmdline_find_option_bool(boot_command_line, "nopkstables"))
 		return;
 
+	if (IS_ENABLED(CONFIG_PKS_PG_TABLES_SOFT_ALWAYS) ||
+	    cmdline_find_option_bool(boot_command_line, "pkstablessoft"))
+		pks_tables_soft = true;
+
 	/*
 	 * PTI will want to allocate higher order page table pages, which the
 	 * PKS table allocator doesn't support. So don't attempt to enable PKS
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 48a390722c06..d8df2bb4bbd0 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -247,6 +247,9 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = {
 #ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
 	[PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
 #endif
+#ifdef CONFIG_PKS_PG_TABLES
+	[PKS_KEY_PG_TABLES] = pks_tables_fault,
+#endif
 };
 
 bool handle_pks_key_callback(unsigned long address, bool write, u16 key)
diff --git a/mm/Kconfig b/mm/Kconfig
index 0f8e8595a396..1f4fc85cbd2c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -851,6 +851,18 @@ config PKS_PG_TABLES
 	depends on !HIGHMEM && !X86_PAE && SPARSEMEM_VMEMMAP
 	depends on ARCH_HAS_SUPERVISOR_PKEYS
 
+config PKS_PG_TABLES_SOFT_ALWAYS
+	bool
+	default y
+	depends on PKS_PG_TABLES
+	help
+	  This features enables PKS tables "soft" mode by default, such that
+	  the first PKS table violation is logged and after that protections
+	  are disabled. This is useful for cases where users would not like
+	  to treat bugs that incorrectly modify page tables as fatal, but would
+	  still like to get notifications of illegitimate attempts to modify
+	  them.
+
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
 	help
-- 
2.17.1

