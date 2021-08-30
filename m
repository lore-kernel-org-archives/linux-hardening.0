Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE72C4320A
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D703260FC0
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhHaABJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:01:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:50163 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239229AbhHaABB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:01:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381540"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712959"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:05 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 13/19] mm/debug_vm_page_table: Use setters instead of WRITE_ONCE
Date:   Mon, 30 Aug 2021 16:59:21 -0700
Message-Id: <20210830235927.6443-14-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently debug_vm_page_table uses some raw WRITE_ONCE invocations to
write to page tables, which PKS tables is designed to prevent. So use the
set_p**() helpers instead of WRITE_ONCE for x86, so debug_vm_page_table
will work with PKS tables enabled.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 mm/debug_vm_pgtable.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1c922691aa61..a0b8859ecf04 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -411,11 +411,17 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PMD huge\n");
+
+#ifdef CONFIG_X86
+	/* Use setter so that protections can be toggled if needed */
+	set_pmd(pmdp, __pmd(0));
+#else
+	WRITE_ONCE(*pmdp, __pmd(0));
+#endif
 	/*
 	 * X86 defined pmd_set_huge() verifies that the given
 	 * PMD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*pmdp, __pmd(0));
 	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
 	WARN_ON(!pmd_clear_huge(pmdp));
 	pmd = READ_ONCE(*pmdp);
@@ -430,11 +436,16 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 		return;
 
 	pr_debug("Validating PUD huge\n");
+#ifdef CONFIG_X86
+	/* Use setter so that protections can be toggled if needed */
+	set_pud(pudp, __pud(0));
+#else
+	WRITE_ONCE(*pudp, __pud(0));
+#endif
 	/*
 	 * X86 defined pud_set_huge() verifies that the given
 	 * PUD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*pudp, __pud(0));
 	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
 	WARN_ON(!pud_clear_huge(pudp));
 	pud = READ_ONCE(*pudp);
@@ -473,7 +484,12 @@ static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
 
 	pr_debug("Validating PUD clear\n");
 	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
+#ifdef CONFIG_X86
+	/* Use setter so that protections can be toggled if needed */
+	set_pud(pudp, pud);
+#else
 	WRITE_ONCE(*pudp, pud);
+#endif
 	pud_clear(pudp);
 	pud = READ_ONCE(*pudp);
 	WARN_ON(!pud_none(pud));
@@ -514,7 +530,12 @@ static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
 
 	pr_debug("Validating P4D clear\n");
 	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
+#ifdef CONFIG_X86
+	/* Use setter so that protections can be toggled if needed */
+	set_p4d(p4dp, p4d);
+#else
 	WRITE_ONCE(*p4dp, p4d);
+#endif
 	p4d_clear(p4dp);
 	p4d = READ_ONCE(*p4dp);
 	WARN_ON(!p4d_none(p4d));
@@ -549,7 +570,12 @@ static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
 
 	pr_debug("Validating PGD clear\n");
 	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
+#ifdef CONFIG_X86
+	/* Use setter so that protections can be toggled if needed */
+	set_pgd(pgdp, pgd);
+#else
 	WRITE_ONCE(*pgdp, pgd);
+#endif
 	pgd_clear(pgdp);
 	pgd = READ_ONCE(*pgdp);
 	WARN_ON(!pgd_none(pgd));
@@ -610,8 +636,12 @@ static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
 
 	pr_debug("Validating PMD clear\n");
 	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pmdp, pmd);
+#ifdef CONFIG_X86
+	/* Use setter so that protections can be toggled if needed */
 	pmd_clear(pmdp);
+#else
+	WRITE_ONCE(*pmdp, pmd);
+#endif
 	pmd = READ_ONCE(*pmdp);
 	WARN_ON(!pmd_none(pmd));
 }
-- 
2.17.1

