Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC651C432BE
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91976101B
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbhHaABE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:01:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:50155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239218AbhHaABA (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:01:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381536"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381536"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712949"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:04 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 12/19] x86/mm: Use free_table in unmap path
Date:   Mon, 30 Aug 2021 16:59:20 -0700
Message-Id: <20210830235927.6443-13-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Memory hot unplug and memremap unmap paths will free direct map page
tables. So use free_table() for this.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/mm/init_64.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index de5a785ee89f..c2680a77ca88 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -975,7 +975,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
 
-static void __meminit free_pagetable(struct page *page, int order)
+static void __meminit free_pagetable(struct page *page, int order, bool table)
 {
 	unsigned long magic;
 	unsigned int nr_pages = 1 << order;
@@ -991,8 +991,14 @@ static void __meminit free_pagetable(struct page *page, int order)
 		} else
 			while (nr_pages--)
 				free_reserved_page(page++);
-	} else
-		free_pages((unsigned long)page_address(page), order);
+	} else {
+		if (table) {
+			/* The page tables will always be order 0. */
+			free_table(page);
+		} else {
+			free_pages((unsigned long)page_address(page), order);
+		}
+	}
 }
 
 static void __meminit gather_table(struct page *page, struct list_head *tables)
@@ -1008,7 +1014,7 @@ static void __meminit gather_table_finish(struct list_head *tables)
 
 	list_for_each_entry_safe(page, next, tables, lru) {
 		list_del(&page->lru);
-		free_pagetable(page, 0);
+		free_pagetable(page, 0, true);
 	}
 }
 
@@ -1018,7 +1024,7 @@ static void __meminit free_hugepage_table(struct page *page,
 	if (altmap)
 		vmem_altmap_free(altmap, PMD_SIZE / PAGE_SIZE);
 	else
-		free_pagetable(page, get_order(PMD_SIZE));
+		free_pagetable(page, get_order(PMD_SIZE), false);
 }
 
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd, struct list_head *tables)
@@ -1102,7 +1108,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
 			return;
 
 		if (!direct)
-			free_pagetable(pte_page(*pte), 0);
+			free_pagetable(pte_page(*pte), 0, false);
 
 		spin_lock(&init_mm.page_table_lock);
 		pte_clear(&init_mm, addr, pte);
-- 
2.17.1

