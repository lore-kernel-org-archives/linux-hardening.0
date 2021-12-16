Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE0C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 21:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhLPVyI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLPVyH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 16:54:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB42C061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FxsC6amCuAZFSahXDaieLHiz+Xxu18/zbToomONxAZM=; b=SzQJ4/uELzoWhsgIEpd1ZA6JF5
        yz1fVXarmGVFcevbWbo/pU2ZaZS3P1QZQNXTB6U/n0GIdJrHbb45+TcF/YWcscuqIJgSQhY8ylQav
        1Ouu1akpTf0aYQBwTyec9gxa0Yj/d/IX0PRvYb9Vw6tq9Gw6dEJZwY7qQecAPkriOLpA1R8rkkf01
        /hKGCDYetu7/UaoM6EDKk7sN0AZKJke6DoC2ug6fAZRMdDT48XyhlT2PNKgYjFBtFXQpoivGDomVu
        O+vp/+bQ/3J2zc5wnrSvPz1bXYHylHfknnGJGkQwfg8tjDWmEtfYqnVl+D+mJMunqxP51fJjSH5JN
        22WReiCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyhE-00FzY6-MA; Thu, 16 Dec 2021 21:53:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 1/4] mm/usercopy: Check kmap addresses properly
Date:   Thu, 16 Dec 2021 21:53:48 +0000
Message-Id: <20211216215351.3811471-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216215351.3811471-1-willy@infradead.org>
References: <20211216215351.3811471-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

If you are copying to an address in the kmap region, you may not copy
across a page boundary, no matter what the size of the underlying
allocation.  You can't kmap() a slab page because slab pages always
come from low memory.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 arch/x86/include/asm/highmem.h   |  1 +
 include/linux/highmem-internal.h | 10 ++++++++++
 mm/usercopy.c                    | 16 ++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 032e020853aa..731ee7cc40a5 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -26,6 +26,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/fixmap.h>
+#include <asm/pgtable_areas.h>
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 0a0b2b09b1b8..01fb76d101b0 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -149,6 +149,11 @@ static inline void totalhigh_pages_add(long count)
 	atomic_long_add(count, &_totalhigh_pages);
 }
 
+static inline bool is_kmap_addr(const void *x)
+{
+	unsigned long addr = (unsigned long)x;
+	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
+}
 #else /* CONFIG_HIGHMEM */
 
 static inline struct page *kmap_to_page(void *addr)
@@ -234,6 +239,11 @@ static inline void __kunmap_atomic(void *addr)
 static inline unsigned int nr_free_highpages(void) { return 0; }
 static inline unsigned long totalhigh_pages(void) { return 0UL; }
 
+static inline bool is_kmap_addr(const void *x)
+{
+	return false;
+}
+
 #endif /* CONFIG_HIGHMEM */
 
 /*
diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..8c039302465f 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -228,12 +228,16 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (!virt_addr_valid(ptr))
 		return;
 
-	/*
-	 * When CONFIG_HIGHMEM=y, kmap_to_page() will give either the
-	 * highmem page or fallback to virt_to_page(). The following
-	 * is effectively a highmem-aware virt_to_head_page().
-	 */
-	page = compound_head(kmap_to_page((void *)ptr));
+	if (is_kmap_addr(ptr)) {
+		unsigned long page_end = (unsigned long)ptr | (PAGE_SIZE - 1);
+
+		if ((unsigned long)ptr + n - 1 > page_end)
+			usercopy_abort("kmap", NULL, to_user,
+					offset_in_page(ptr), n);
+		return;
+	}
+
+	page = virt_to_head_page(ptr);
 
 	if (PageSlab(page)) {
 		/* Check slab allocator for flags and size. */
-- 
2.33.0

