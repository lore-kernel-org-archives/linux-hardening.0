Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA35C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 14:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbhLMO1J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbhLMO1I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 09:27:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78305C06173F
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 06:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IFa+DfiRwDRCozF/2nCT7kRZcW4NwEd0UI8DBzwcaaA=; b=iD8Wu5BjPcK7VGavwSrSgUlsXJ
        tqiC0hMOWgWwzB59+08QudrEsHZvKuwQmXrTBjR1uymNzzXLzsg8B7tubFibFBHhFzWlkaKBw5xHl
        uk7+OT0kO9ZJ3TsTv/TFwViAUYI2c2BCbEdMWf8qQ3L71h+0JFizUOIk+V8tDX2FqfjzUcTboBbai
        GxXzDalnP0aDCNPkIDv/lRxnYJxJCOA6H/1y5IMk/TCp3bYMY7KFfnoOPk7u3M5yWKj4+368X2Bwm
        AJhICcPAJJhdY+Y8ETQwnQHw3Ag+ZkrmGFCc0Ck2awXzi1L1KzsXhGhGahtElf4k1ck//3LSxNy1+
        zSg/k6lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmID-00Crlz-CV; Mon, 13 Dec 2021 14:27:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 3/3] mm/usercopy: Detect compound page overruns
Date:   Mon, 13 Dec 2021 14:27:03 +0000
Message-Id: <20211213142703.3066590-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213142703.3066590-1-willy@infradead.org>
References: <20211213142703.3066590-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Move the compound page overrun detection out of
CONFIG_HARDENED_USERCOPY_PAGESPAN so it's enabled for more people.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 63476e1506e0..db2e8c4f79fd 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -163,7 +163,6 @@ static inline void check_page_span(const void *ptr, unsigned long n,
 {
 #ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
 	const void *end = ptr + n - 1;
-	struct page *endpage;
 	bool is_reserved, is_cma;
 
 	/*
@@ -194,11 +193,6 @@ static inline void check_page_span(const void *ptr, unsigned long n,
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
@@ -258,6 +252,11 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (PageSlab(page)) {
 		/* Check slab allocator for flags and size. */
 		__check_heap_object(ptr, n, page, to_user);
+	} else if (PageHead(page)) {
+		/* A compound allocation */
+		unsigned long offset = ptr - page_address(page);
+		if (offset + n > page_size(page))
+			usercopy_abort("page alloc", NULL, to_user, offset, n);
 	} else {
 		/* Verify object does not incorrectly span multiple pages. */
 		check_page_span(ptr, n, page, to_user);
-- 
2.33.0

