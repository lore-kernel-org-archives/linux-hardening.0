Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BE2701BD;
	Thu, 24 Apr 2025 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745461887; cv=none; b=kOj0AKvwmsLYxEbhVbNVX+675fVQk8dlgvTlOlCjK5pNt8dicn5ZdXM4jAZ2FhTHpN5KJDLN+993TcpzqlJZsO0yySLK+bbDn+xEXej8eZD/VylnC0GerVixZiVlfz8ucXO7S08I71DbNs59kDr1WTY+/4c6LMgLWzWonISr3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745461887; c=relaxed/simple;
	bh=F+VOSj6UtH+TTn63+hB3/3gz1CdcNwfMxLUTwC58j6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8061yKVqX4zGMhFA/R8ZC08MNRP/yW2O5xiwFQL4ks3GLksmDWYb51Lpl9a/zJSJiXp9h84uDHCaZaf8GzHeq5f7a0HSsgjkzMma1xg/Fyznwvr1ERdGBXB9QkGi/9dMGwIWKX4wXbKV8w2Ub+smS61O55tvokH7x77riJwevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLRmod4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLRmod4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00861C4CEE2;
	Thu, 24 Apr 2025 02:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745461887;
	bh=F+VOSj6UtH+TTn63+hB3/3gz1CdcNwfMxLUTwC58j6M=;
	h=From:To:Cc:Subject:Date:From;
	b=hLRmod4/B/lyG5ddQk94K6GXnHLJKlqg6eoYlj3APrrxZgsqybZYS9o3iu3AojMA3
	 plwO9KMPhcWfPsTJvC0j3mJypQT3yx6+AmxGAQySJAFjVxwZ0r4as25rcapo3DIJyM
	 18Yn1GuntFm3NQ1bKRVVg5Js4R0/Jy7jncvbPSzcKikJrqhvLM3PCEFNjsnUjugZ5e
	 O5Oq+aL+gdX+zJ1LFq3zH/hKtOsT2WRp7qNI0G0UJRqlxGKJPjOjhrl1n2EyLN0GHd
	 9FfmlbKEmxvpeQeaegzBBmVJu/JlSCYuVD137UhqtDAysLJz/WdiX092iTG6HunY1p
	 8WWExvkUxmZ7Q==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm: vmalloc: Support more granular vrealloc() sizing
Date: Wed, 23 Apr 2025 19:31:23 -0700
Message-Id: <20250424023119.work.333-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3853; i=kees@kernel.org; h=from:subject:message-id; bh=F+VOSj6UtH+TTn63+hB3/3gz1CdcNwfMxLUTwC58j6M=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmci6rrZ6TV+31/f/hx9H2fCQ2bZef5B85bP0Py2Pl7S YJMW+9d6ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjI20uMDLu05Vf2Oa86Pj/v vLRNnIt3ea8Fi62FQlOQnc3zy8eUJjP8rxK65u5rLRfRYmAlGv2rZ/+tosZLj9tSdxWaFmkuKLJ kBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce struct vm_struct::requested_size so that the requested
(re)allocation size is retained separately from the allocated area
size. This means that KASAN will correctly poison the correct spans
of requested bytes. This also means we can support growing the usable
portion of an allocation that can already be supported by the existing
area's existing allocation.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/all/20250408192503.6149a816@outsider.home/
Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: <linux-mm@kvack.org>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e3..5ca8d4dd149d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -61,6 +61,7 @@ struct vm_struct {
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
 	const void		*caller;
+	unsigned long		requested_size;
 };
 
 struct vmap_area {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3ed720a787ec..bd8cf50f06b3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1940,7 +1940,7 @@ static inline void setup_vmalloc_vm(struct vm_struct *vm,
 {
 	vm->flags = flags;
 	vm->addr = (void *)va->va_start;
-	vm->size = va_size(va);
+	vm->size = vm->requested_size = va_size(va);
 	vm->caller = caller;
 	va->vm = vm;
 }
@@ -3133,6 +3133,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 
 	area->flags = flags;
 	area->caller = caller;
+	area->requested_size = requested_size;
 
 	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
 	if (IS_ERR(va)) {
@@ -4063,6 +4064,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
  */
 void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 {
+	struct vm_struct *vm = NULL;
+	size_t alloced_size = 0;
 	size_t old_size = 0;
 	void *n;
 
@@ -4072,15 +4075,17 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	}
 
 	if (p) {
-		struct vm_struct *vm;
-
 		vm = find_vm_area(p);
 		if (unlikely(!vm)) {
 			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
 			return NULL;
 		}
 
-		old_size = get_vm_area_size(vm);
+		alloced_size = get_vm_area_size(vm);
+		old_size = vm->requested_size;
+		if (WARN(alloced_size < old_size,
+			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
+			return NULL;
 	}
 
 	/*
@@ -4088,14 +4093,27 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	 * would be a good heuristic for when to shrink the vm_area?
 	 */
 	if (size <= old_size) {
-		/* Zero out spare memory. */
-		if (want_init_on_alloc(flags))
+		/* Zero out "freed" memory. */
+		if (want_init_on_free())
 			memset((void *)p + size, 0, old_size - size);
+		vm->requested_size = size;
 		kasan_poison_vmalloc(p + size, old_size - size);
 		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
 		return (void *)p;
 	}
 
+	/*
+	 * We already have the bytes available in the allocation; use them.
+	 */
+	if (size <= alloced_size) {
+		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
+		/* Zero out "alloced" memory. */
+		if (want_init_on_alloc(flags))
+			memset((void *)p + old_size, 0, size - old_size);
+		vm->requested_size = size;
+		kasan_poison_vmalloc(p + size, alloced_size - size);
+	}
+
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
 	n = __vmalloc_noprof(size, flags);
 	if (!n)
-- 
2.34.1

