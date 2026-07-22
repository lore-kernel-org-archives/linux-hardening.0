Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D534BA5A;
	Wed, 22 Jul 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730590; cv=none; b=Y+44w77wvtcWDWL67fkO6Eo/liwrtP6GplExxSuY12vyEBqDOZg4VYRYIlf9t8zBeWVVoQFrIs9kRMPIhoV79k6DqeCrrBs6H+P0BF8Zwm7GBlpE+agbGgRPrB21t9VmzQeE9iJ/XqEVmPHsoPwKgmqGouDRyJVgggo4X2zMZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730590; c=relaxed/simple;
	bh=Y2eo83WQ5KXIWQ4HG9NgyTmnBmpnXEbXS51MTrxNjeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTsOU4AxB2SddTkxv3XZdin2/+VMUu7+XREnskPXqtUeSZg3IB2b6TlK00PSLIYDshRNRNKcd0zek/zIBsUFwj+e40pREuVJeCGbANPhhjDM9ZqoV4jg+HaKJbM1HNJzHbNrOBfsGbp/7qJMWX4n4uFK5Qd4JgXf7ZEveMjnnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LY4eNAqr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LY4eNAqr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18DFD1595;
	Wed, 22 Jul 2026 07:29:44 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2591C3F59E;
	Wed, 22 Jul 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784730588; bh=Y2eo83WQ5KXIWQ4HG9NgyTmnBmpnXEbXS51MTrxNjeo=;
	h=From:To:Cc:Subject:Date:From;
	b=LY4eNAqrFUtIkbYvUFZ5nAL4UyFumbz1yIdqCVGw5Upbu9b+vxRPcMREjKqhyp1gY
	 4idufJUVCGrnai65nN2cagm/x+5cXN09qdPaTwzqgHdCoY41juiBBxe+XvGFZSzFB9
	 WB5Lr319cDa9ePsfBeTDrpAmbyfApF7V271BuDSs=
From: Dev Jain <dev.jain@arm.com>
To: kees@kernel.org,
	akpm@linux-foundation.org
Cc: Dev Jain <dev.jain@arm.com>,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	urezki@gmail.com
Subject: [PATCH] mm/usercopy: harden bounds checking for vmalloc allocations
Date: Wed, 22 Jul 2026 14:29:35 +0000
Message-ID: <20260722142936.3287702-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmalloc allocator stores the actual allocation size inside the
vm_struct structure. We can use this bound in usercopy instead of the
page-aligned va_end to catch usercopy beyond the actual allocation size.

For vmap, the requested_size field is always page-aligned since it maps a
certain number of pages. Same for vm_map_ram (alongwith, not even having
a vm_struct). So the check is only relevant for vmalloc mappings.

Because there are early vm areas registered even before vmalloc_init,
requested_size may be zero. So also check whether the requested_size
is set.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Applies on mm-new (3d18f3499c48).

 mm/usercopy.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 5de7a518b1b1c..772681aff8477 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -176,10 +176,28 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 
 	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
 		struct vmap_area *area = find_vmap_area(addr);
+		struct vm_struct *vm;
 
 		if (!area)
 			usercopy_abort("vmalloc", "no area", to_user, 0, n);
 
+		vm = area->vm;
+		/*
+		 * Mappings with a vm_struct track the originally requested
+		 * size. Check against that rather than the page-rounded
+		 * vmap_area->va_end so copies cannot reach vmalloc tail
+		 * padding. vmap mappings are always page aligned.
+		 */
+		if (vm && (vm->flags & VM_ALLOC) && vm->requested_size) {
+			unsigned long size = vm->requested_size;
+
+			offset = addr - area->va_start;
+			if (offset > size || n > size - offset)
+				usercopy_abort("vmalloc", NULL, to_user,
+					       offset, n);
+			return;
+		}
+
 		if (n > area->va_end - addr) {
 			offset = addr - area->va_start;
 			usercopy_abort("vmalloc", NULL, to_user, offset, n);
-- 
2.43.0

