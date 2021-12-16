Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59526C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 21:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhLPVyF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLPVyE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 16:54:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97806C061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jtkiEbeC8BH5Pq80FDCgjIrecOy7gCyzuNpIoqv5nX0=; b=DJwMtd4jnj3lLUZ0yZEetfivZS
        yHv/lAf3GgRuYuwfu+huJY7nUxInXVVeByfxdMGwS5hqgKQJ84T2U8CKSkeyGAiHgx8gkHXfZcgoG
        sKBEaiNe5/E1+e0r4Tpn6imTF3zEb0kR7cV63MHAw5vyfVgKmw0mWBepC4nLc8yORAoFz8+vOs0+Z
        ovsmwRtjUjuwwhdV0gD5gEDHCYxnafQGZNkPVAOdvCv8oprVEhVeBksy+xwLZaKni5TwIlT2AcUpF
        mBOd4vqvve/ATY6CGdt7feEV3gC/hWEPRGaJCNGVlfeYhingGDFntV5fwgvkM+thA2//m/JRAmgEi
        PDhy927A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyhE-00FzYA-RJ; Thu, 16 Dec 2021 21:53:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 3/4] mm/usercopy: Detect compound page overruns
Date:   Thu, 16 Dec 2021 21:53:50 +0000
Message-Id: <20211216215351.3811471-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216215351.3811471-1-willy@infradead.org>
References: <20211216215351.3811471-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Move the compound page overrun detection out of
CONFIG_HARDENED_USERCOPY_PAGESPAN so it's enabled for more people.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
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

