Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F81C4320E
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE58560E98
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhHaAA5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:00:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:50152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239179AbhHaAAz (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:00:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381520"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381520"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712846"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:00 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 06/19] x86/mm/cpa: Add perm callbacks to grouped pages
Date:   Mon, 30 Aug 2021 16:59:14 -0700
Message-Id: <20210830235927.6443-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Future patches will need to set permissions on pages in the cache, so
add some callbacks that let gouped page cache callers provide callbacks
the grouped pages can use when replenishing the cache or freeing pages via
the shrinker.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/set_memory.h |  8 ++++++-
 arch/x86/mm/pat/set_memory.c      | 38 ++++++++++++++++++++++++++++---
 arch/x86/mm/pgtable.c             |  3 ++-
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 6e897ab91b77..eaac7e3e08bf 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -138,14 +138,20 @@ static inline int clear_mce_nospec(unsigned long pfn)
  */
 #endif
 
+typedef int (*gpc_callback)(struct page*, unsigned int);
+
 struct grouped_page_cache {
 	struct shrinker shrinker;
 	struct list_lru lru;
 	gfp_t gfp;
+	gpc_callback pre_add_to_cache;
+	gpc_callback pre_shrink_free;
 	atomic_t nid_round_robin;
 };
 
-int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp);
+int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp,
+			    gpc_callback pre_add_to_cache,
+			    gpc_callback pre_shrink_free);
 struct page *get_grouped_page(int node, struct grouped_page_cache *gpc);
 void free_grouped_page(struct grouped_page_cache *gpc, struct page *page);
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e9527811f476..72a465e37648 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2357,6 +2357,9 @@ static void __dispose_pages(struct grouped_page_cache *gpc, struct list_head *he
 
 		list_del(cur);
 
+		if (gpc->pre_shrink_free)
+			gpc->pre_shrink_free(page, 1);
+
 		__free_pages(page, 0);
 	}
 }
@@ -2406,6 +2409,21 @@ static struct page *__remove_first_page(struct grouped_page_cache *gpc, int node
 	return NULL;
 }
 
+/* Helper to try to convert the pages, or clean up and free if it fails */
+static int __try_convert(struct grouped_page_cache *gpc, struct page *page, int cnt)
+{
+	int i;
+
+	if (gpc->pre_add_to_cache && gpc->pre_add_to_cache(page, cnt)) {
+		if (gpc->pre_shrink_free)
+			gpc->pre_shrink_free(page, cnt);
+		for (i = 0; i < cnt; i++)
+			__free_pages(&page[i], 0);
+		return 1;
+	}
+	return 0;
+}
+
 /* Get and add some new pages to the cache to be used by VM_GROUP_PAGES */
 static struct page *__replenish_grouped_pages(struct grouped_page_cache *gpc, int node)
 {
@@ -2414,18 +2432,30 @@ static struct page *__replenish_grouped_pages(struct grouped_page_cache *gpc, in
 	int i;
 
 	page = __alloc_page_order(node, gpc->gfp, HUGETLB_PAGE_ORDER);
-	if (!page)
-		return __alloc_page_order(node, gpc->gfp, 0);
+	if (!page) {
+		page = __alloc_page_order(node, gpc->gfp, 0);
+		if (__try_convert(gpc, page, 1))
+			return NULL;
+
+		return page;
+	}
 
 	split_page(page, HUGETLB_PAGE_ORDER);
 
+	/* If fail to convert to be added, try to clean up and free */
+	if (__try_convert(gpc, page, 1))
+		return NULL;
+
+	/* Add the rest to the cache except for the one returned below */
 	for (i = 1; i < hpage_cnt; i++)
 		free_grouped_page(gpc, &page[i]);
 
 	return &page[0];
 }
 
-int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp)
+int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp,
+			    gpc_callback pre_add_to_cache,
+			    gpc_callback pre_shrink_free)
 {
 	int err = 0;
 
@@ -2443,6 +2473,8 @@ int init_grouped_page_cache(struct grouped_page_cache *gpc, gfp_t gfp)
 	if (err)
 		list_lru_destroy(&gpc->lru);
 
+	gpc->pre_add_to_cache = pre_add_to_cache;
+	gpc->pre_shrink_free = pre_shrink_free;
 out:
 	return err;
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 81b767a5d6ef..4b929fa1a0ac 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -922,7 +922,8 @@ bool pks_tables_inited(void)
 
 static int __init pks_page_init(void)
 {
-	pks_tables_inited_val = !init_grouped_page_cache(&gpc_pks, GFP_KERNEL | PGTABLE_HIGHMEM);
+	pks_tables_inited_val = !init_grouped_page_cache(&gpc_pks, GFP_KERNEL | PGTABLE_HIGHMEM,
+					       NULL, NULL);
 
 out:
 	return !pks_tables_inited_val;
-- 
2.17.1

