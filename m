Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D926AEC;
	Wed, 12 Feb 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347507; cv=none; b=qjhyeSZuunq2DbTCzC8rTTQKXPnk01BBfHCA8ilZnPrMWvp3a66BQlGZdWDdDKJBCXcPzyRonlTieBPJoJ23HDiEWGAWRFm7+zr3u+aJPFa1hF8PaR8t5XhW03GbUNN3wm50sMktEDIeJ76FbQu3YTQBtE/2QsxjaJzQ2B2IdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347507; c=relaxed/simple;
	bh=GDtWkcUr24DAw2soyjNVUASe8KPYgvoICBqLsg3wca8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6o0WjLbDZKHXc9L4o9GifCDz8z3TbLJlBfGA7TXR6Dosu6TE389zIjmFeqwySqmYUrZmBP7VsrycEmVyfh8LllpGp7PIGG7YPC9WUeOhZWnAiRXvOMDcbDIzNbS++stn8p6azGNHqtYDk5GlE1UgU5oyKmPnh+/LHJSDLba9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yt9jF3gjhz16PjB;
	Wed, 12 Feb 2025 16:00:33 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 588A21802D0;
	Wed, 12 Feb 2025 16:05:00 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Feb
 2025 16:04:59 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Kees
 Cook <kees@kernel.org>
CC: Tamas Koczka <poprdi@google.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng
	<xiujianfeng@huawei.com>, <linux-mm@kvack.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gongruiqi1@huawei.com>
Subject: [PATCH v3 1/2] slab: Adjust placement of __kvmalloc_node_noprof
Date: Wed, 12 Feb 2025 16:15:04 +0800
Message-ID: <20250212081505.2025320-2-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212081505.2025320-1-gongruiqi1@huawei.com>
References: <20250212081505.2025320-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Move __kvmalloc_node_noprof (as well as kvfree*, kvrealloc_noprof and
kmalloc_gfp_adjust for consistency) into mm/slub.c so that it can
directly invoke __do_kmalloc_node, which is needed for the next patch.

No functional changes intended.

Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 mm/slub.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/util.c | 162 ------------------------------------------------------
 2 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..abc982d68feb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4878,6 +4878,168 @@ void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL(krealloc_noprof);
 
+static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
+{
+	/*
+	 * We want to attempt a large physically contiguous block first because
+	 * it is less likely to fragment multiple larger blocks and therefore
+	 * contribute to a long term fragmentation less than vmalloc fallback.
+	 * However make sure that larger requests are not too disruptive - no
+	 * OOM killer and no allocation failure warnings as we have a fallback.
+	 */
+	if (size > PAGE_SIZE) {
+		flags |= __GFP_NOWARN;
+
+		if (!(flags & __GFP_RETRY_MAYFAIL))
+			flags |= __GFP_NORETRY;
+
+		/* nofail semantic is implemented by the vmalloc fallback */
+		flags &= ~__GFP_NOFAIL;
+	}
+
+	return flags;
+}
+
+/**
+ * __kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * failure, fall back to non-contiguous (vmalloc) allocation.
+ * @size: size of the request.
+ * @b: which set of kmalloc buckets to allocate from.
+ * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
+ * @node: numa node to allocate from
+ *
+ * Uses kmalloc to get the memory but if the allocation fails then falls back
+ * to the vmalloc allocator. Use kvfree for freeing the memory.
+ *
+ * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
+ * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
+ * preferable to the vmalloc fallback, due to visible performance drawbacks.
+ *
+ * Return: pointer to the allocated memory of %NULL in case of failure
+ */
+void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
+{
+	void *ret;
+
+	/*
+	 * It doesn't really make sense to fallback to vmalloc for sub page
+	 * requests
+	 */
+	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b),
+				    kmalloc_gfp_adjust(flags, size),
+				    node);
+	if (ret || size <= PAGE_SIZE)
+		return ret;
+
+	/* non-sleeping allocations are not supported by vmalloc */
+	if (!gfpflags_allow_blocking(flags))
+		return NULL;
+
+	/* Don't even allow crazy sizes */
+	if (unlikely(size > INT_MAX)) {
+		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
+		return NULL;
+	}
+
+	/*
+	 * kvmalloc() can always use VM_ALLOW_HUGE_VMAP,
+	 * since the callers already cannot assume anything
+	 * about the resulting pointer, and cannot play
+	 * protection games.
+	 */
+	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
+			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+			node, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(__kvmalloc_node_noprof);
+
+/**
+ * kvfree() - Free memory.
+ * @addr: Pointer to allocated memory.
+ *
+ * kvfree frees memory allocated by any of vmalloc(), kmalloc() or kvmalloc().
+ * It is slightly more efficient to use kfree() or vfree() if you are certain
+ * that you know which one to use.
+ *
+ * Context: Either preemptible task context or not-NMI interrupt.
+ */
+void kvfree(const void *addr)
+{
+	if (is_vmalloc_addr(addr))
+		vfree(addr);
+	else
+		kfree(addr);
+}
+EXPORT_SYMBOL(kvfree);
+
+/**
+ * kvfree_sensitive - Free a data object containing sensitive information.
+ * @addr: address of the data object to be freed.
+ * @len: length of the data object.
+ *
+ * Use the special memzero_explicit() function to clear the content of a
+ * kvmalloc'ed object containing sensitive data to make sure that the
+ * compiler won't optimize out the data clearing.
+ */
+void kvfree_sensitive(const void *addr, size_t len)
+{
+	if (likely(!ZERO_OR_NULL_PTR(addr))) {
+		memzero_explicit((void *)addr, len);
+		kvfree(addr);
+	}
+}
+EXPORT_SYMBOL(kvfree_sensitive);
+
+/**
+ * kvrealloc - reallocate memory; contents remain unchanged
+ * @p: object to reallocate memory for
+ * @size: the size to reallocate
+ * @flags: the flags for the page level allocator
+ *
+ * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
+ * and @p is not a %NULL pointer, the object pointed to is freed.
+ *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
+ *
+ * This function must not be called concurrently with itself or kvfree() for the
+ * same memory allocation.
+ *
+ * Return: pointer to the allocated memory or %NULL in case of error
+ */
+void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
+{
+	void *n;
+
+	if (is_vmalloc_addr(p))
+		return vrealloc_noprof(p, size, flags);
+
+	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
+	if (!n) {
+		/* We failed to krealloc(), fall back to kvmalloc(). */
+		n = kvmalloc_noprof(size, flags);
+		if (!n)
+			return NULL;
+
+		if (p) {
+			/* We already know that `p` is not a vmalloc address. */
+			kasan_disable_current();
+			memcpy(n, kasan_reset_tag(p), ksize(p));
+			kasan_enable_current();
+
+			kfree(p);
+		}
+	}
+
+	return n;
+}
+EXPORT_SYMBOL(kvrealloc_noprof);
+
 struct detached_freelist {
 	struct slab *slab;
 	void *tail;
diff --git a/mm/util.c b/mm/util.c
index b6b9684a1438..c808668f0548 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -612,168 +612,6 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_mmap);
 
-static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
-{
-	/*
-	 * We want to attempt a large physically contiguous block first because
-	 * it is less likely to fragment multiple larger blocks and therefore
-	 * contribute to a long term fragmentation less than vmalloc fallback.
-	 * However make sure that larger requests are not too disruptive - no
-	 * OOM killer and no allocation failure warnings as we have a fallback.
-	 */
-	if (size > PAGE_SIZE) {
-		flags |= __GFP_NOWARN;
-
-		if (!(flags & __GFP_RETRY_MAYFAIL))
-			flags |= __GFP_NORETRY;
-
-		/* nofail semantic is implemented by the vmalloc fallback */
-		flags &= ~__GFP_NOFAIL;
-	}
-
-	return flags;
-}
-
-/**
- * __kvmalloc_node - attempt to allocate physically contiguous memory, but upon
- * failure, fall back to non-contiguous (vmalloc) allocation.
- * @size: size of the request.
- * @b: which set of kmalloc buckets to allocate from.
- * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
- * @node: numa node to allocate from
- *
- * Uses kmalloc to get the memory but if the allocation fails then falls back
- * to the vmalloc allocator. Use kvfree for freeing the memory.
- *
- * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
- * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
- * preferable to the vmalloc fallback, due to visible performance drawbacks.
- *
- * Return: pointer to the allocated memory of %NULL in case of failure
- */
-void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
-{
-	void *ret;
-
-	/*
-	 * It doesn't really make sense to fallback to vmalloc for sub page
-	 * requests
-	 */
-	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b),
-				    kmalloc_gfp_adjust(flags, size),
-				    node);
-	if (ret || size <= PAGE_SIZE)
-		return ret;
-
-	/* non-sleeping allocations are not supported by vmalloc */
-	if (!gfpflags_allow_blocking(flags))
-		return NULL;
-
-	/* Don't even allow crazy sizes */
-	if (unlikely(size > INT_MAX)) {
-		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
-		return NULL;
-	}
-
-	/*
-	 * kvmalloc() can always use VM_ALLOW_HUGE_VMAP,
-	 * since the callers already cannot assume anything
-	 * about the resulting pointer, and cannot play
-	 * protection games.
-	 */
-	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
-			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
-			node, __builtin_return_address(0));
-}
-EXPORT_SYMBOL(__kvmalloc_node_noprof);
-
-/**
- * kvfree() - Free memory.
- * @addr: Pointer to allocated memory.
- *
- * kvfree frees memory allocated by any of vmalloc(), kmalloc() or kvmalloc().
- * It is slightly more efficient to use kfree() or vfree() if you are certain
- * that you know which one to use.
- *
- * Context: Either preemptible task context or not-NMI interrupt.
- */
-void kvfree(const void *addr)
-{
-	if (is_vmalloc_addr(addr))
-		vfree(addr);
-	else
-		kfree(addr);
-}
-EXPORT_SYMBOL(kvfree);
-
-/**
- * kvfree_sensitive - Free a data object containing sensitive information.
- * @addr: address of the data object to be freed.
- * @len: length of the data object.
- *
- * Use the special memzero_explicit() function to clear the content of a
- * kvmalloc'ed object containing sensitive data to make sure that the
- * compiler won't optimize out the data clearing.
- */
-void kvfree_sensitive(const void *addr, size_t len)
-{
-	if (likely(!ZERO_OR_NULL_PTR(addr))) {
-		memzero_explicit((void *)addr, len);
-		kvfree(addr);
-	}
-}
-EXPORT_SYMBOL(kvfree_sensitive);
-
-/**
- * kvrealloc - reallocate memory; contents remain unchanged
- * @p: object to reallocate memory for
- * @size: the size to reallocate
- * @flags: the flags for the page level allocator
- *
- * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
- * and @p is not a %NULL pointer, the object pointed to is freed.
- *
- * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
- * initial memory allocation, every subsequent call to this API for the same
- * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
- * __GFP_ZERO is not fully honored by this API.
- *
- * In any case, the contents of the object pointed to are preserved up to the
- * lesser of the new and old sizes.
- *
- * This function must not be called concurrently with itself or kvfree() for the
- * same memory allocation.
- *
- * Return: pointer to the allocated memory or %NULL in case of error
- */
-void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
-{
-	void *n;
-
-	if (is_vmalloc_addr(p))
-		return vrealloc_noprof(p, size, flags);
-
-	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
-	if (!n) {
-		/* We failed to krealloc(), fall back to kvmalloc(). */
-		n = kvmalloc_noprof(size, flags);
-		if (!n)
-			return NULL;
-
-		if (p) {
-			/* We already know that `p` is not a vmalloc address. */
-			kasan_disable_current();
-			memcpy(n, kasan_reset_tag(p), ksize(p));
-			kasan_enable_current();
-
-			kfree(p);
-		}
-	}
-
-	return n;
-}
-EXPORT_SYMBOL(kvrealloc_noprof);
-
 /**
  * __vmalloc_array - allocate memory for a virtually contiguous array.
  * @n: number of elements.
-- 
2.25.1

