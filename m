Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD4C43470
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 00:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E494E613EA
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 00:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhEEAdY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 May 2021 20:33:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:19820 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbhEEAdX (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 May 2021 20:33:23 -0400
IronPort-SDR: LDaNp2MLP1T+aTmViAThbvBbg8azv0brTRbLKvM+MrBHlECk4Di4AtG2MnogqjbFm4314xkPlg
 kcR+a4DvCYiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196058593"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196058593"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:27 -0700
IronPort-SDR: ip0J5D3qBZcnDAFgdM7HQHdxWI8/FjbpAGZI0G2d4bIwRZLNN6s4O1irKqEf+BRPr25p+FQq1v
 G9Ah1barEj0Q==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="429490787"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.26.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:27 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Cc:     ira.weiny@intel.com, rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 4/9] mm: Explicitly zero page table lock ptr
Date:   Tue,  4 May 2021 17:30:27 -0700
Message-Id: <20210505003032.489164-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In ptlock_init() there is a VM_BUG_ON_PAGE() check on the page table lock
pointer. Explicitly zero the lock in ptlock_free() so a page table lock
can be re-initialized without triggering the BUG_ON().

It appears this doesn't normally trigger because the private field
shares the same space in struct page as ptl and page tables always
return to the buddy allocator before being re-initialized as new page
tables. When the page returns to the buddy allocator, private gets
used to store the page order, so it inadvertently clears ptl as well.
In future patches, pages will get re-initialized as page tables without
returning to the buddy allocator so this is needed.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5efa07fb6cdc..130f8c1e380a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5225,5 +5225,6 @@ bool ptlock_alloc(struct page *page)
 void ptlock_free(struct page *page)
 {
 	kmem_cache_free(page_ptl_cachep, page->ptl);
+	page->ptl = 0;
 }
 #endif
-- 
2.30.2

