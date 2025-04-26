Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9913A244;
	Sat, 26 Apr 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626283; cv=none; b=WdgcExRY9yokFhqTtN4kGEJP6czhHRja/db8VzgzJCBkImaUxhelx58UNn9UNJH4pXUcJNMBRlo92eb0sIogs3wOr3vhdDMn78n7/aGBNz35k/NGUOsBgT37NG0eu1n0AXI9jKX+XBLpTO2nNtszS5Cjt+cS7IOVm1nVEeypPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626283; c=relaxed/simple;
	bh=DFNipnoqmsR5fihOyPm8o+8H9EYU2K0QxreJWh7S2IU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvEX5ou1MlLeO//RCFv8ROcmrcMwX02MaCOanadFZk7/VpIyVmzZ1+koYK5ZTx9s2AmRNO/QHhq9G8JUFQZPcrQNAHGeQGJ6ka/G18rdFPglPt1nNPLADb5xCLTeiFJyx+P936GH60OkVefFfrCglRAAX+R73Gjm1Cupp1IriBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgIq0piQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgIq0piQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E672C4CEE4;
	Sat, 26 Apr 2025 00:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745626282;
	bh=DFNipnoqmsR5fihOyPm8o+8H9EYU2K0QxreJWh7S2IU=;
	h=From:To:Cc:Subject:Date:From;
	b=WgIq0piQPB32xXyAho4BKC8PU4ny3GmB6xplNbn6HMbs1bPzGdu99PZdxqK0EKahj
	 enZSTa/WInTc6O5uARi/BCiVMry2bA6vYt2ZZwBYmjLXkqQuF/ycwKsVnPKehLAINO
	 IfkwPHGpzlDXBDHkPTY/zWY7T2SPZGxiftPYrxuQpE5vNa/m6PDAZdq1Ahz74Edjgj
	 4VsvkHUW+svDuOYqup//vYx6FhLkt3sfbxNRP375+hkxVvfIZTirxVz17vmmVzyQTx
	 mEKOkEIOzZsUNh8sOzf3ZsLfkFXLEWcikRQoWyeBeqGTXtmtZWGYrRobI87WeeA8w+
	 Rg3hAmQTpj/HA==
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
Subject: [PATCH v2] mm: vmalloc: Support more granular vrealloc() sizing
Date: Fri, 25 Apr 2025 17:11:07 -0700
Message-Id: <20250426001105.it.679-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3832; i=kees@kernel.org; h=from:subject:message-id; bh=DFNipnoqmsR5fihOyPm8o+8H9EYU2K0QxreJWh7S2IU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8KrMa8utO1i8SvnOyNfzJwpStsSc+S6xfEHJq4puwp awzvl/m6ChlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjIx8WMDO1H2qZ43jOfe+fV ahXXxJQTxdtvXN8j8bCzZVHbx/+5K/8zMjw4eTmkufjmp4aFrLfa3n1U/+T2dbFQ8b6vbgdd1m1 pWccBAA==
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
 mm/vmalloc.c            | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

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
index 3ed720a787ec..2d7511654831 100644
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
@@ -4088,14 +4093,26 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
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
-		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
 		return (void *)p;
 	}
 
+	/*
+	 * We already have the bytes available in the allocation; use them.
+	 */
+	if (size <= alloced_size) {
+		kasan_unpoison_vmalloc(p + old_size, size - old_size,
+				       KASAN_VMALLOC_PROT_NORMAL);
+		/* Zero out "alloced" memory. */
+		if (want_init_on_alloc(flags))
+			memset((void *)p + old_size, 0, size - old_size);
+		vm->requested_size = size;
+	}
+
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
 	n = __vmalloc_noprof(size, flags);
 	if (!n)
-- 
2.34.1

