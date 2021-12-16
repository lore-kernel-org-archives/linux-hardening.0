Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2C2C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 21:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhLPVx5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLPVx4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 16:53:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BFC061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 13:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yd8tiX8+x5pXfOFC4eElbWaK5eHhiwmaYRCfz7A9fM4=; b=cHMTBQ+svuDgXMImHP699DDS3K
        k6HtE/PXCUE/5o4x3XPmZoNajs3H4wqcV6e3UxcZhuhNXDZOZ8pWXRmRNPTJh0GX3i6p1wArCSG9d
        ZL3tWcUpqdu37q/3BlANIeUNCP4n81A42S/ad59ATiAFzXoDDtzGtINuiVhfdfN3SBD4KpJI2hFzm
        M8kcPvpp72AzUEy5kikllthnq5QduRTqTJ2v15sB+1wN2t4rIcSIhEHGpPBEt8ZIY49bJdCqRseNj
        P3QPsj9D436d1IId7BYHGYw/qmqehqk/wvgZVcK8oQIwfyI/PdO2xrRztagcrnd7vmPIh2E2uRsiW
        FrzsgsjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyhE-00FzYC-TR; Thu, 16 Dec 2021 21:53:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 4/4] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Date:   Thu, 16 Dec 2021 21:53:51 +0000
Message-Id: <20211216215351.3811471-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216215351.3811471-1-willy@infradead.org>
References: <20211216215351.3811471-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There isn't enough information to make this a useful check any more;
the useful parts of it were moved in earlier patches, so remove this
set of checks now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/usercopy.c    | 61 ------------------------------------------------
 security/Kconfig | 13 +----------
 2 files changed, 1 insertion(+), 73 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index db2e8c4f79fd..1ee1f0d74828 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -157,64 +157,6 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 		usercopy_abort("null address", NULL, to_user, ptr, n);
 }
 
-/* Checks for allocs that are marked in some way as spanning multiple pages. */
-static inline void check_page_span(const void *ptr, unsigned long n,
-				   struct page *page, bool to_user)
-{
-#ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
-	const void *end = ptr + n - 1;
-	bool is_reserved, is_cma;
-
-	/*
-	 * Sometimes the kernel data regions are not marked Reserved (see
-	 * check below). And sometimes [_sdata,_edata) does not cover
-	 * rodata and/or bss, so check each range explicitly.
-	 */
-
-	/* Allow reads of kernel rodata region (if not marked as Reserved). */
-	if (ptr >= (const void *)__start_rodata &&
-	    end <= (const void *)__end_rodata) {
-		if (!to_user)
-			usercopy_abort("rodata", NULL, to_user, 0, n);
-		return;
-	}
-
-	/* Allow kernel data region (if not marked as Reserved). */
-	if (ptr >= (const void *)_sdata && end <= (const void *)_edata)
-		return;
-
-	/* Allow kernel bss region (if not marked as Reserved). */
-	if (ptr >= (const void *)__bss_start &&
-	    end <= (const void *)__bss_stop)
-		return;
-
-	/* Is the object wholly within one base page? */
-	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
-		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
-		return;
-
-	/*
-	 * Reject if range is entirely either Reserved (i.e. special or
-	 * device memory), or CMA. Otherwise, reject since the object spans
-	 * several independently allocated pages.
-	 */
-	is_reserved = PageReserved(page);
-	is_cma = is_migrate_cma_page(page);
-	if (!is_reserved && !is_cma)
-		usercopy_abort("spans multiple pages", NULL, to_user, 0, n);
-
-	for (ptr += PAGE_SIZE; ptr <= end; ptr += PAGE_SIZE) {
-		page = virt_to_head_page(ptr);
-		if (is_reserved && !PageReserved(page))
-			usercopy_abort("spans Reserved and non-Reserved pages",
-				       NULL, to_user, 0, n);
-		if (is_cma && !is_migrate_cma_page(page))
-			usercopy_abort("spans CMA and non-CMA pages", NULL,
-				       to_user, 0, n);
-	}
-#endif
-}
-
 static inline void check_heap_object(const void *ptr, unsigned long n,
 				     bool to_user)
 {
@@ -257,9 +199,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 		unsigned long offset = ptr - page_address(page);
 		if (offset + n > page_size(page))
 			usercopy_abort("page alloc", NULL, to_user, offset, n);
-	} else {
-		/* Verify object does not incorrectly span multiple pages. */
-		check_page_span(ptr, n, page, to_user);
 	}
 }
 
diff --git a/security/Kconfig b/security/Kconfig
index 0b847f435beb..5b289b329a51 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -160,20 +160,9 @@ config HARDENED_USERCOPY
 	  copy_from_user() functions) by rejecting memory ranges that
 	  are larger than the specified heap object, span multiple
 	  separately allocated pages, are not on the process stack,
-	  or are part of the kernel text. This kills entire classes
+	  or are part of the kernel text. This prevents entire classes
 	  of heap overflow exploits and similar kernel memory exposures.
 
-config HARDENED_USERCOPY_PAGESPAN
-	bool "Refuse to copy allocations that span multiple pages"
-	depends on HARDENED_USERCOPY
-	depends on EXPERT
-	help
-	  When a multi-page allocation is done without __GFP_COMP,
-	  hardened usercopy will reject attempts to copy it. There are,
-	  however, several cases of this in the kernel that have not all
-	  been removed. This config is intended to be used only while
-	  trying to find such users.
-
 config FORTIFY_SOURCE
 	bool "Harden common str/mem functions against buffer overflows"
 	depends on ARCH_HAS_FORTIFY_SOURCE
-- 
2.33.0

