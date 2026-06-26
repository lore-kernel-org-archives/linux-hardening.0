Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D603590C3
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495335; cv=none; b=dcs3TrbzyJ7YtyTa8oFue2ZmEYHnrL89v/8qFjTIlKPK1ER2/x+IROzV9CavzVfEuX8QTgTjy89xiBqbt0icDGoQzCuYMSwD1q6RL4L/oq8wg08b04h7EnOC3AezExfYVxPS79ugH5kzvX9YUqBXcfNmSClVrz9x3BtCcmMhw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495335; c=relaxed/simple;
	bh=m1gqzkpLwZfTcS++MTPWX8j4/fApO5XgotnxbLDQxMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIvF97/R0vZ5fyAQxBoqOFGsf0IaTZgZmZMbDKtdn6xAzh2yOWXg6AvCKgaquRfOIPfuPtL+kn9kXlKQTpuArO7NKyK42IpqRqMe2M/4a8akQPcpUmh2ATWl7s4DPPUkoRSU7TuRyM+YmASHLGPMlJJKq4beTBjlN5WRQ1uPQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=oLVL9KlH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="oLVL9KlH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7f1db3ad4so11468725ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782495333; x=1783100133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rq/jb9kJpeX24z87UrbY8sPlcGI6O1WY5TpBBjHjfY=;
        b=oLVL9KlHgw1vz9JaBKRN52OX8MHRDni/iWD9b1rZbWYFi4T01W330tQ+wMC1Uz5eod
         5+buGWEcDjbq3O3WKBcf3fYGvCpQhrcyqLhkm6TRANbPB/V9UK4bNo3GArW34zLsLoo9
         QGdFERJqi6qujq9WTm91NvxOusfOL88NkU/5BH+HAAnfJeQKNxQjukPu8RXOB4DVbGOy
         RwqfPgRv17MeehysnFh4UpYyhQCwgAmh2fGPhS9zCVctJDOQ4hFyEHJ+SB/FD3igXEdD
         COCX5XIqAx8mbCQWDuUn7RsEp1mhCch6IrsmVi/db9XlbpFfdgkPmlfIWyV9tXYJj2oX
         BEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495333; x=1783100133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rq/jb9kJpeX24z87UrbY8sPlcGI6O1WY5TpBBjHjfY=;
        b=hmhhI6mQx3qXFRtgsiRoV66UfpZtkqYSqz5DtcE+Ti/5QO5tphhhvAEIm3GbD3qDgG
         sraT+ACUdMlOGAlLUuVwQP1yyRKV7+AQoBIJmeOHQ+sFihVOj3R0Ey7ybyp0f7Q4rMbW
         +jyr5FgJE7vNvBu/Wnz7Y1WzaerwilnVwXj1/NONALTu/qxVal8lxLBa/uCKN1HDkEj9
         +DgDtzz1yNm2p3y8Lhwb4KG7twyXMsowXB7iYviQnPv2eYVye/sr/Tbxbjn4wUjdOBOK
         kYOHgBP3+Ycke8/G9UTZ97JDNYCqHizi06c4dkstI6OSnY4/IfCnXB9afL16K7zMxkt8
         j1Gw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4M2DiNem24jFmWtIzDB747qbX/r8RpbizfHknC2vvE1jFuGL6RuLenXC1oehDRaO53TgcdNj1np0fhmCeEaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVwaT3mtuswuNT6e77hfLjk+8xylqg0NV9H6atxZ9gEqOaOQ3
	JyUNtXkYY05j4KKkdUvw058e9r07/WdD15BvFId283SJeCbRplP9zmMhFHcZHe180Q==
X-Gm-Gg: AfdE7cmzmawdz5ktbsKZfBNf54UUd8/P440+h+KIaKr90QiXk79Wt+CGzuYakbu0Dw2
	1wbIELgpuPamuayCiXo1ph0flPLKnHVpqU//JxZFb2vmgrB5XN7XMfmjpEpi7DLLxwEN8+SM1ju
	8X3SyK5TXzydrLJ+FGQv2JeUzloZnng4QlJpRMTyObIQWewtMnq9wqc193QnSzMUGeo3hxlwUkN
	F5serbW9EW5rt1vivMyuUSQPDFvMVOcQI9lCPl+6C0FGxZpa9upVeeIu3JBWnUUR7Tnm+qlcHSC
	eRx9PIz5ivub2raqhYm8+haCgYCfGsb18JW7bdgLTa9ffvLVuD7o1b8u7P+SwInsW0rqMKdvT0p
	FyQFS6Du4ETb48NccYlJj5nSWo3xzxkjtQBHxqQScAIqgNph+/zwRvkxIFLpxe6TMJT6pn0tf8o
	4R5vEG9/y2
X-Received: by 2002:a17:903:1cb:b0:2c7:f227:58ee with SMTP id d9443c01a7336-2c7fca717bdmr68178005ad.22.1782495333348;
        Fri, 26 Jun 2026 10:35:33 -0700 (PDT)
Received: from p1.. ([172.56.109.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f6509ca0sm42853305ad.81.2026.06.26.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:35:32 -0700 (PDT)
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
Subject: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based stack pivot
Date: Fri, 26 Jun 2026 10:34:44 -0700
Message-ID: <20260626173444.2252041-1-xmei5@asu.edu>
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

Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Jennifer Miller <jmill@asu.edu>
---
 arch/x86/include/asm/vmalloc.h | 21 +++++++++++++++++++++
 include/linux/vmalloc.h        | 16 ++++++++++++++--
 mm/vmalloc.c                   |  2 +-
 3 files changed, 36 insertions(+), 3 deletions(-)

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
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bb6ae08d18f5..8bb2b3ef40a8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3217,7 +3217,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 		return NULL;
 
 	if (!(flags & VM_NO_GUARD))
-		size += PAGE_SIZE;
+		size += VMAP_GUARD_SIZE;
 
 	area->flags = flags;
 	area->caller = caller;
-- 
2.43.0

