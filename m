Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DDC433ED
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4EE613CB
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 00:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhEEAdW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 May 2021 20:33:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:19816 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhEEAdV (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 May 2021 20:33:21 -0400
IronPort-SDR: qJpJqSotIUY1o1C1bdB+4sAmMP1F4pzPE0pTd2sb3Cq94aM1lz6aEafTivQzdYICc0dtt45Zzw
 2sy4eMViOfPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196058588"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196058588"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:26 -0700
IronPort-SDR: roaeflJUzMbIdPqfYu//snYPz/jcvlf7Iez+eWxjvAEdyulf3N7WL8xhAqP51GegBkjQy8tLea
 FkILiWT9I2SQ==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="429490764"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.26.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:25 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Cc:     ira.weiny@intel.com, rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 2/9] list: Support list head not in object for list_lru
Date:   Tue,  4 May 2021 17:30:25 -0700
Message-Id: <20210505003032.489164-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In future patches, there will be a need to keep track of objects with
list_lru where the list_head is not in the object (will be in struct
page). Since list_lru automatically determines the node id from the
list_head, this will fail when using struct page.

So create a new function in list_lru, list_lru_add_node(), that allows
the node id of the item to be passed in. Otherwise it behaves exactly
like list_lru_add().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/list_lru.h | 13 +++++++++++++
 mm/list_lru.c            | 10 ++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 4bde44a5024b..7ad149b22223 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -90,6 +90,19 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item);
 
+/**
+ * list_lru_add_node: add an element to the lru list's tail
+ * @list_lru: the lru pointer
+ * @item: the item to be added.
+ * @nid: the node id of the item
+ *
+ * Like list_lru_add, but takes the node id as parameter instead of
+ * calculating it from the list_head passed in.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool list_lru_add_node(struct list_lru *lru, struct list_head *item, int nid);
+
 /**
  * list_lru_del: delete an element to the lru list
  * @list_lru: the lru pointer
diff --git a/mm/list_lru.c b/mm/list_lru.c
index fd5b19dcfc72..8e32a6fc1527 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -112,9 +112,8 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-bool list_lru_add(struct list_lru *lru, struct list_head *item)
+bool list_lru_add_node(struct list_lru *lru, struct list_head *item, int nid)
 {
-	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
@@ -134,6 +133,13 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 	spin_unlock(&nlru->lock);
 	return false;
 }
+
+bool list_lru_add(struct list_lru *lru, struct list_head *item)
+{
+	int nid = page_to_nid(virt_to_page(item));
+
+	return list_lru_add_node(lru, item, nid);
+}
 EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_del(struct list_lru *lru, struct list_head *item)
-- 
2.30.2

