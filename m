Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE53BC4320A
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6E060E98
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbhHaAAx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:00:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:50152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233594AbhHaAAw (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:00:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381511"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381511"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 16:59:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712796"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 16:59:57 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 01/19] list: Support getting most recent element in list_lru
Date:   Mon, 30 Aug 2021 16:59:09 -0700
Message-Id: <20210830235927.6443-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In future patches, some functionality will use list_lru that also needs
to keep track of the most recently used element on a node. Since this
information is already contained within list_lru, add a function to get
it so that an additional list is not needed in the caller.

Do not support memcg aware list_lru's since it is not needed by the
intended caller.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/list_lru.h | 13 +++++++++++++
 mm/list_lru.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 1b5fceb565df..08e07c19fd13 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -103,6 +103,19 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item);
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
 
+/**
+ * list_lru_get_mru: gets and removes the tail from one of the node lists
+ * @list_lru: the lru pointer
+ * @nid: the node id
+ *
+ * This function removes the most recently added item from one of the node
+ * id specified. This function should not be used if the list_lru is memcg
+ * aware.
+ *
+ * Return value: The element removed
+ */
+struct list_head *list_lru_get_mru(struct list_lru *lru, int nid);
+
 /**
  * list_lru_count_one: return the number of objects currently held by @lru
  * @lru: the lru pointer.
diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..c1bec58168e1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -156,6 +156,34 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 }
 EXPORT_SYMBOL_GPL(list_lru_del);
 
+struct list_head *list_lru_get_mru(struct list_lru *lru, int nid)
+{
+	struct list_lru_node *nlru = &lru->node[nid];
+	struct list_lru_one *l = &nlru->lru;
+	struct list_head *ret;
+
+	/* This function does not attempt to search through the memcg lists */
+	if (list_lru_memcg_aware(lru)) {
+		WARN_ONCE(1, "list_lru: %s not supported on memcg aware list_lrus", __func__);
+		return NULL;
+	}
+
+	spin_lock(&nlru->lock);
+	if (list_empty(&l->list)) {
+		ret = NULL;
+	} else {
+		/* Get tail */
+		ret = l->list.prev;
+		list_del_init(ret);
+
+		l->nr_items--;
+		nlru->nr_items--;
+	}
+	spin_unlock(&nlru->lock);
+
+	return ret;
+}
+
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
 	list_del_init(item);
-- 
2.17.1

