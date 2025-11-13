Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2C10E3
	for <linux-hardening@vger.kernel.org>; Thu, 13 Nov 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992584; cv=none; b=rWHgqqhR//krYyzoNn1vb9JZkDzwoVWqw3nnKIlcvGGV3oKGNVw7WaPifLK6gx2Cj6zjTfMzgJ27m8GvdMOWF/DXbYHyLZ2BDiJTEUNHkVL01cMG7B5D5ocSiurfAxAvJsO9ZN9ogsLhIBa0binYd9KC/20g1WlU4i4npc08eJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992584; c=relaxed/simple;
	bh=PtnL9n9+dsPj9okOv9DE2Xnu9R8coLD6X43xU2icSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We9uutL+DCCWRmAOr5bub6A3fPTn2UQJGNSdG4dlhN+kcV4rM6RykqHN1Z2RdXF+Ykb2e+k9whI1SBEyYM/MracWsSsxQd750tEPQeyytFuvz5Gzk+nVD9NZDsswA7YJ50nEGvivKcxtn36ct0zMO6DSzNo+wOP/+F4K3lD5uiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8FNNgr+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8FNNgr+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sc/kRw94YXpZ4S+oCdRqxdYA0RV/OiQatEvBHMPr30A=; b=H8FNNgr+oRIanasd5fks71b04f
	6KjQojcQb0DFAu/IANQJDEBLz6cpsW+Tw3XsswpNk4rqN/eTQvPp0OxxWeYXsby8lddbAO1oOiuCi
	9TTA6nhlbN0bFVrHudcqsUS0IhB15hZBT7Dgeef3NR4ZyjSfDjwMENfXwp5VkiGigmEB5PSC3F8k2
	hLe9I35RZ5JwztfPnqleqyn2txxkatOYv/ci8Yw9ulnxyXlI41jwEmU6m8G6wzix/gfJtC+e2mOaL
	LlduQQzP5hAQrF1VKN/w8ekloKzISyTUl670taf93/Yaq+t74dUsn9uombw/4PDbP6cxp2stYm/mZ
	rLIti+5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJKu7-00000006fP8-2eem;
	Thu, 13 Nov 2025 00:09:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 13/16] usercopy: Remove folio references from check_heap_object()
Date: Thu, 13 Nov 2025 00:09:27 +0000
Message-ID: <20251113000932.1589073-14-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113000932.1589073-1-willy@infradead.org>
References: <20251113000932.1589073-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use page_slab() instead of virt_to_folio() followed by folio_slab().
We do end up calling compound_head() twice for non-slab copies, but that
will not be a problem once we allocate memdescs separately.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 mm/usercopy.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index dbdcc43964fb..5de7a518b1b1 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -164,7 +164,8 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 {
 	unsigned long addr = (unsigned long)ptr;
 	unsigned long offset;
-	struct folio *folio;
+	struct page *page;
+	struct slab *slab;
 
 	if (is_kmap_addr(ptr)) {
 		offset = offset_in_page(ptr);
@@ -189,16 +190,23 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	if (!virt_addr_valid(ptr))
 		return;
 
-	folio = virt_to_folio(ptr);
-
-	if (folio_test_slab(folio)) {
+	page = virt_to_page(ptr);
+	slab = page_slab(page);
+	if (slab) {
 		/* Check slab allocator for flags and size. */
-		__check_heap_object(ptr, n, folio_slab(folio), to_user);
-	} else if (folio_test_large(folio)) {
-		offset = ptr - folio_address(folio);
-		if (n > folio_size(folio) - offset)
+		__check_heap_object(ptr, n, slab, to_user);
+	} else if (PageCompound(page)) {
+		page = compound_head(page);
+		offset = ptr - page_address(page);
+		if (n > page_size(page) - offset)
 			usercopy_abort("page alloc", NULL, to_user, offset, n);
 	}
+
+	/*
+	 * We cannot check non-compound pages.  They might be part of
+	 * a large allocation, in which case crossing a page boundary
+	 * is fine.
+	 */
 }
 
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
-- 
2.47.2

