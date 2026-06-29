Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085692F3C13
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769640; cv=none; b=ZP1gs4aPLABI8xMVPGUmC0/OMEg55yQex2z3aRw9yQATQt99ztaSvYquzbLXHTcCzg3aHzvMVVUp90qQhryIOFjssAEkDOFA22fxsjPwhpnBJfDmO0hGdqlLfWE7smFFu/8smtW2onXZSsa7JMqtRUGDt7pZA8iGxoPsBkA8xVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769640; c=relaxed/simple;
	bh=AQDh0sR4xqQtaGY4gYXpI6mSYdSDC0X8Kw37xoC8foU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RM9XAlPSzU30uIFjque9D0dPoTU9Bg1ttbtX30BdopRdIhKwiVGLq7cLTbUfrIYw/QtIJjgXvRMkIBJr91rOCBv6TfuKpnd8Fbj20f+dxIBnyJd6TrtlrGjYDIstE4wrhAdGde2EhyPiSETqQERQgR95ZzCDpxUyT5brsuiRU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=FQ4W9DAJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="FQ4W9DAJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso991554b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782769636; x=1783374436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdIjkiFaOfGY07XYoiVOjCOSv8Q05CUjEKu6WlWNo1A=;
        b=FQ4W9DAJNaWTdaQm64P0K15Tf7nzMhW9rcakuZXV/vPNky96cMYM8PFBL8jXeYmn1i
         EgCX0oFEXa8ltn03y/FBNVno7bPEvDvkKPt8ss23yO1VWwBMfR1OpUOBg4YjW7tsc/V2
         UtEgqcTYf9gn83M75E5gqoGcgTA86IPZOMilLvlTdnf0ScXs/vFuNxjZn8hlVTh8XTWO
         bhG2UQSkBPYFhhiGCzFQgNqNIfbFSoAxmKMWqvFr6NK89qNrxZTc2ebm5KRyMWalHzLn
         8vDYO6ECHCso/sqlcw/aG1XKToi8QkSDPdR0Dy2SLSigd92n2eD+Fp6/sjsV/mbBooBU
         jG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769636; x=1783374436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdIjkiFaOfGY07XYoiVOjCOSv8Q05CUjEKu6WlWNo1A=;
        b=jVfoFQh//I9vp96dk4lz9R1Cqji+lyM21bMrDiBjJEMCmRuxMnNy6BG2efe369C4I7
         rjw91AbfWvIWCrcu+z7RsR2hqKkt96fqNj1Zqn640lYOhgNL5DGhSyb/iW+yX3bBF+Hw
         B3Nm1SxjqagKaNb79i265TiIzoPM+BK5nS3WdTkOqYihMzeH9BIdDOdxxWZ5UJFIXukZ
         I1Zsw83Ba2/UXcCYgdkMfNpe2RDpSu4OZdfTgSnk6a68zxW9StLVQZeB5WwuicfAsXtO
         3CspvQyhbxxvNYWqHvCEyjmPEvJmKbDULHrWsmiEkSjvNTjKNDjABMECTIldiwb3VdlO
         YqgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMPJGfxeV7HumGu+ArpCd0f/jtX2Qu3ahkoueBgap5BJRTZI0daoY3zGg29y/EZzvTYU1DcDmcboljkRIR8PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKgFTluDPBQ/mQYn1Yk/r17yzMp041f0ox2h3aPd1EDQ5jhCb
	R6Jb2EQph89flxOHRxlMKfRi2by65ZNBJfuooeYml/P0wJdHVeRv4cbg19AkWz6FvQ==
X-Gm-Gg: AfdE7ck3OuefSlkNFb+/sVLfGXFNlQB7HhX4hY7oPaYZ2JO6jyJ8XfWhR0+Z5PthziD
	40X7v5qWf+Odb60oZIW5atavdliyUEWBEJqXLcuSvqCeNhbYcWUqT4UQdNIIWGxVlGPUWpNdUe0
	bQ5HYCBUTEyqWbpQ7DF6aVkgkKr4A4kRInKyzNgseE7h3ITiOkv6ZLHdJ2r6XwFolYq0whzRW/f
	FJIID5dfjXUKbLurIrh3ZvzATtjhpYljmIjMxIOgCbKI7H0ScaOapzVDvnxCkJDlB5X4z+5Y/iR
	1/RxYjb1+g+QYbaYndBXbP3TI6ZcRl8iqUgefvkEXQ+IsDvg3PUlgMnk5sxc4Kcgs6EtjVPwWwV
	fQzJ3aJRg95o+FVDNXfQXFRhwB8vTjYVaFpvC9m4KU9kFZvFT81Bk9geV/jIdIKBPruP1J6QAyw
	==
X-Received: by 2002:aa7:9a83:0:b0:847:82db:9046 with SMTP id d2e1a72fcca58-8479f1698a3mr736747b3a.26.1782769636217;
        Mon, 29 Jun 2026 14:47:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:151e:4b96:1640:8d7c:ffc5:b8d9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8c781sm436430b3a.9.2026.06.29.14.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:47:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-hardening@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>,
	Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>,
	Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based stack pivot
Date: Mon, 29 Jun 2026 14:47:12 -0700
Message-ID: <20260629214712.1198680-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc area,
which an unprivileged user can surround with attacker-controlled data by
spraying vmap allocations adjacent to a target stack (for example via
XDP_UMEM_REG, though other vmalloc spray paths work too). Today each
guarded vmalloc allocation is followed by a single unmapped guard page.

A single guard page is not enough to contain the x86_64 ENTER
instruction used as a one-instruction stack pivot. ENTER imm16, imm8
builds a stack frame and lowers RSP by:

	imm16 + 8 * (L + 1),  L = imm8 & 0x1f

imm16 is an unsigned 16-bit operand (ENTER never raises RSP), and L is
in [0, 31], so the maximum displacement of a single ENTER is:

	0xffff + 8 * 0x20 = 0x100ff bytes

That is more than enough to step off the current stack, across the
one-page guard, and into the adjacent sprayed pages. When those pages
contain a return sled feeding a ROP chain, reaching any ENTER gadget
(opcode 0xc8, abundant as both intended and unintended gadgets) turns a
control-flow hijack into full ROP execution without any register control
at the hijack site, making it a one-gadget-style primitive that
significantly eases exploitation. The pivot happens after the control
transfer, so it is not constrained by CFI (kCFI/FineIBT).

Widen the guard region from one page to VMAP_GUARD_PAGES (0x11 pages,
0x11000 bytes), which is the smallest whole-page span exceeding the
0x100ff-byte maximum single-ENTER pivot. A pivot off the top of the
stack now lands in the unmapped guard and faults, instead of in mapped,
attacker-controlled memory. RANDOMIZE_KSTACK_OFFSET only perturbs RSP by
a sub-page amount, so it does not change the required width.

Introduce a VMAP_GUARD_PAGES knob that defaults to a single page (no
change for current architectures) and can be overridden per arch via
asm/vmalloc.h, and set it to 0x11 on x86_64. This is deliberately scoped
to x86_64: the 0x100ff bound is a property of the ENTER opcode, and ENTER
is also a one-byte opcode (0xc8) that appears as abundant unintended
gadgets. Other architectures (e.g. arm64) have no equivalent
single-instruction, immediate-controlled pivot reachable as an unaligned
unintended gadget, so they keep the one-page guard and pay no cost.

The override is gated on CONFIG_X86_64 rather than applying to all of x86:
VMAP_STACK is selected only on x86_64, so 32-bit kernel stacks are not in
the vmalloc area and the technique does not apply there. 32-bit x86 also
has a far smaller vmalloc window, where widening every guarded area by 16
pages would needlessly pressure the address space.

The guard pages are never populated, so there is no extra physical
memory and no additional page-table population beyond the larger virtual
span; the cost is virtual address space and vmap_area bookkeeping, which
is negligible against the 64-bit vmalloc window. get_vm_area_size() is
adjusted by the same VMAP_GUARD_SIZE so the usable size reported to
callers is unchanged.

On x86 this widens the guard for all guarded vmap areas, not only thread
stacks. ret2enter targets the stack specifically, so a narrower
alternative is to apply the wider guard only on the thread-stack
allocation path via a dedicated VM_ flag; we kept the change in the
common path as defense in depth for any vmalloc-adjacent pivot target,
but are happy to scope it to stacks if maintainers prefer.

While widening the guard, also mark percpu vmap areas VM_NO_GUARD.
pcpu_get_vm_areas() and pcpu_page_first_chunk() size each area exactly and
reserve no guard, so get_vm_area_size() would subtract a guard that was
never added and underflow if an area were smaller than the guard. This is
a latent correctness fix only: on x86_64 percpu areas are megabyte-scale,
far larger than the guard.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Jennifer Miller <jmill@asu.edu>
---
v2: VM_NO_GUARD for percpu vmap areas

 arch/x86/include/asm/vmalloc.h | 21 +++++++++++++++++++++
 include/linux/vmalloc.h        | 16 ++++++++++++++--
 mm/percpu.c                    |  2 +-
 mm/vmalloc.c                   |  4 ++--
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
index 49ce331f3ac6..2c341f398227 100644
--- a/arch/x86/include/asm/vmalloc.h
+++ b/arch/x86/include/asm/vmalloc.h
@@ -5,6 +5,27 @@
 #include <asm/page.h>
 #include <asm/pgtable_areas.h>
 
+/*
+ * The x86 ENTER instruction can be used as a one-instruction stack pivot:
+ * ENTER imm16, imm8 lowers RSP by imm16 + 8 * (L + 1), L = imm8 & 0x1f.
+ * imm16 is an unsigned 16-bit operand (ENTER never raises RSP) and L is in
+ * [0, 31], so a single ENTER can lower RSP by at most
+ * 0xffff + 8 * 0x20 = 0x100ff bytes. With CONFIG_VMAP_STACK the kernel
+ * stack lives in the vmalloc area, where an unprivileged user can spray
+ * adjacent allocations; a single-page guard is too small to contain such a
+ * pivot. Use 0x11 guard pages (0x11000 bytes), the smallest whole-page
+ * span exceeding 0x100ff, so the pivot faults in the guard instead of
+ * landing in attacker-controlled memory.
+ *
+ * Restrict this to 64-bit: VMAP_STACK is selected only on x86_64, so 32-bit
+ * kernel stacks are not in the vmalloc area and the technique does not apply.
+ * 32-bit also has a far smaller vmalloc window, where a 16-page-per-area
+ * widening would needlessly pressure the address space.
+ */
+#ifdef CONFIG_X86_64
+#define VMAP_GUARD_PAGES	0x11
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
 #ifdef CONFIG_X86_64
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 3b02c0c6b371..b8546e519deb 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -49,6 +49,18 @@ struct iov_iter;		/* in uio.h */
 #define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
 #endif
 
+/*
+ * Number of unmapped guard pages appended to each guarded vmalloc
+ * allocation. The default is a single page; an architecture may override
+ * VMAP_GUARD_PAGES (via asm/vmalloc.h) when a wider guard is needed to
+ * contain a worst-case single-instruction stack pivot into an adjacent,
+ * attacker-controlled vmap allocation (see arch/x86 for the ENTER case).
+ */
+#ifndef VMAP_GUARD_PAGES
+#define VMAP_GUARD_PAGES	1
+#endif
+#define VMAP_GUARD_SIZE		(VMAP_GUARD_PAGES * PAGE_SIZE)
+
 struct vm_struct {
 	union {
 		struct vm_struct *next;	  /* Early registration of vm_areas. */
@@ -236,8 +248,8 @@ int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 static inline size_t get_vm_area_size(const struct vm_struct *area)
 {
 	if (!(area->flags & VM_NO_GUARD))
-		/* return actual size without guard page */
-		return area->size - PAGE_SIZE;
+		/* return actual size without guard region */
+		return area->size - VMAP_GUARD_SIZE;
 	else
 		return area->size;
 
diff --git a/mm/percpu.c b/mm/percpu.c
index b0676b8054ed..9f7262228be1 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3243,7 +3243,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 	}
 
 	/* allocate vm area, map the pages and copy static data */
-	vm.flags = VM_ALLOC;
+	vm.flags = VM_ALLOC | VM_NO_GUARD;
 	vm.size = num_possible_cpus() * ai->unit_size;
 	vm_area_register_early(&vm, PAGE_SIZE);
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bb6ae08d18f5..fc435054f640 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3217,7 +3217,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 		return NULL;
 
 	if (!(flags & VM_NO_GUARD))
-		size += PAGE_SIZE;
+		size += VMAP_GUARD_SIZE;
 
 	area->flags = flags;
 	area->caller = caller;
@@ -5027,7 +5027,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC | VM_NO_GUARD,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}
-- 
2.43.0

