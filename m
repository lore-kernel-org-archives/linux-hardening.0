Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C2EC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 10 Jan 2022 23:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbiAJXPp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 Jan 2022 18:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbiAJXPo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 Jan 2022 18:15:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A87C06173F
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jan 2022 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BHhXo+AiVU90OItLmEg1G7k1aWJm7bvB04PrbDkRSvg=; b=J0IBKvayJTZCRIbOwYHIOgFiCw
        PrQhqFhxJ0wdgWPH4IzsV9cfwFN6167MVzdwDY/IpXWVZWnZBlt/FRGbZ+A6ZnzKsiX34lRkBqw6C
        c2KGJERqfWWc/AFQZQpM9Cpt52CKGpHLvB+naedmQWMPcv60C8+oxGrbzqr2XDXQmCcxSzdwp2NW/
        HYsvzJ4ZBoabfdQwXOd3PSlNCdmHIhWoQJiTGhrGYKewQQbXM8hfvsLggQOxlL818cKCtMximhMoV
        oq8wsJrgpuSUjSpFN1H0MM9oJD97WmWf2yQhFH5NQQiet6LqUfvu4sza8oMGkjQxvYAzmqE36tgj2
        D9CD8egQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n73sy-002nGJ-Hv; Mon, 10 Jan 2022 23:15:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] mm/usercopy: Detect large folio overruns
Date:   Mon, 10 Jan 2022 23:15:29 +0000
Message-Id: <20220110231530.665970-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110231530.665970-1-willy@infradead.org>
References: <20220110231530.665970-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Move the compound page overrun detection out of
CONFIG_HARDENED_USERCOPY_PAGESPAN and convert it to use folios so it's
enabled for more people.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index dcf71b7e3098..e1cb98087a05 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -164,7 +164,6 @@ static inline void check_page_span(const void *ptr, unsigned long n,
 {
 #ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
 	const void *end = ptr + n - 1;
-	struct page *endpage;
 	bool is_reserved, is_cma;
 
 	/*
@@ -195,11 +194,6 @@ static inline void check_page_span(const void *ptr, unsigned long n,
 		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
 		return;
 
-	/* Allow if fully inside the same compound (__GFP_COMP) page. */
-	endpage = virt_to_head_page(end);
-	if (likely(endpage == page))
-		return;
-
 	/*
 	 * Reject if range is entirely either Reserved (i.e. special or
 	 * device memory), or CMA. Otherwise, reject since the object spans
@@ -259,6 +253,10 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (folio_test_slab(folio)) {
 		/* Check slab allocator for flags and size. */
 		__check_heap_object(ptr, n, folio_slab(folio), to_user);
+	} else if (folio_test_large(folio)) {
+		unsigned long offset = ptr - folio_address(folio);
+		if (offset + n > folio_size(folio))
+			usercopy_abort("page alloc", NULL, to_user, offset, n);
 	} else {
 		/* Verify object does not incorrectly span multiple pages. */
 		check_page_span(ptr, n, folio_page(folio, 0), to_user);
-- 
2.33.0

