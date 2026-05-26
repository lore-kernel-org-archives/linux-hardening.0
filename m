Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F234279E0
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818376; cv=none; b=peXeADSBqtlE34HIwaAxYa12NyLhhnDY3vrk8ysU5NQgAyzWRLT0qgNs+889vFUfKRJJ6k7doHZwAI5ESnX3UDl9TC6kuFGinmZEkIDWBFx5apRWzqhm7LTlUEgqUzWkzVySAjDOsKW/Os4W0aXBqRlHsXM5//WrO84DN52K6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818376; c=relaxed/simple;
	bh=ZmR71NqyGJG4EJRqxzWirNcZmBaGhL9AzpoJZLkCgUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8nx2Q9Han+6kEbKAklvQ2ofuf5857tvkTZM4dd0wAfXk4u71thhyvLw6q9EexOCfhVfEsdQmwQUwU4C4nVRJkYsrmhKUkA1wMI+ERuHT5Ei3iH3Q16kUed5hRWJREsB/8Fwbs2RUJZyQ1upFkgfpHOYESdFy7CVFQwOKInT6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxuJtLmA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxuJtLmA"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49058295985so20435655e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818372; x=1780423172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJx2KhHmtgY53AkMvOyg5uK/J3luFDMcMijObo9+4vo=;
        b=nxuJtLmAQTr49ypdI6gtMNRPvShm5nLWpzWqBVpnlR9i5HBWj5NpbnBuJEyEm2tIam
         JCVVEsPMSLXI5s6jY1UROY1qUSbPn93qVRxG1q+CPVThczwmKI5IZfA2mjSvBgcaWtHq
         cooEovDDvjhiLfSCeXcdPtn5I30+zwViMx4kviK/INqfxCrFi5HVyrZF3tNQ8k7bYgar
         KOlnzvPsW2FnUQX2rPdr5UuqwFRJaVP4lMvDyh2bbJouH1dqXz/gxSH0WgKvwzF5dtAX
         WI80bN1s2t8Q/d7W8SavQwErh+k1Z74fQwP4JEvwQb3huix/s3Dfu1fI200UuSbEU4IS
         R5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818372; x=1780423172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJx2KhHmtgY53AkMvOyg5uK/J3luFDMcMijObo9+4vo=;
        b=miDZWdV44Tt0t2UQ8ajaXE1SBXsMpM4UT4SVy2FVbO9jPgUG7jLCy4DCcGCqy6pMdR
         qL2yCkCORgvSlyFxX5a5MchbdeBs3c4lGksuDZjVZe2NxGFd/ud88zLSLbr3TJYbonwE
         aiQ9OO7qYkPhwWBJqP3Q3taSaXtWmY/+IU5s0iAX266ogtP4hjtKJgaBpz/ejPA6JW02
         QCD02ZwfK1yzaDrN9lFBwnc3eeY6f6fQ7cNg5qujwLKUfA5Ml6KdQz69s1+rsBU8sfU2
         0KeO+wP9J+wQuGFeiaR1ZHzzqbDTAroxSt7Z8ClLN7OERzzqD11ZPTruBZn8kD6ba4S+
         wfQg==
X-Forwarded-Encrypted: i=1; AFNElJ+8k91IM2JEV3ZamM9FFHjyPY8sD5H4UppOCj4ekFQwMS8DjM6yyNRZ3Qhf4rbZ1pJ6I/FBaKNDUWz9CXFNTjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxuu8O02GV7EHn05t1gCuuWsWoiYzwCRQH/gK2/VrQ0TMGVbKC
	Bmc2hryb64cIFLxZQcwOOr6Cu6l1sOWq3fETGQkr3EIBYcBW+4kPzgNdfgiWtp4CT4ycaPL3NA=
	=
X-Received: from wrjn10.prod.google.com ([2002:adf:e34a:0:b0:43d:6f5f:8c52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c8:b0:490:44eb:c1e7
 with SMTP id 5b1f17b1804b1-49044ebc2d5mr360486815e9.30.1779818372100; Tue, 26
 May 2026 10:59:32 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:56 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=ardb@kernel.org;
 h=from:subject; bh=Qta0PMsGcvlQhpXqhjldDBt900x2YBq541ys84w8Z6A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0frL6+VN/jnUf5F5tPjtywfpJk9QUy2MKCjk0NTccj
 r7PUqfVUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayl53hf8n7L8U7Dq/XtJM8
 aaNT5xu9zmX9+a6ICfks3cp+rZ7mixj+Z6226zYNmPCvKn7q8tmXSzeumHZtU+IR1bAruyazqkp WMAIA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-26-ardb+git@google.com>
Subject: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of
 kernel image
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the fixmap and kasan page tables out of the BSS section, and place
them at the end of the image, right before the init_pg_dir section where
some of the other statically allocated page tables live.

These page tables are currently the only data objects in vmlinux that
are meant to be accessed via the kernel image's linear alias, and so
placing them together allows the remainder of the data/bss section to be
remapped read-only or unmapped entirely.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu.h    | 2 ++
 arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
 arch/arm64/mm/fixmap.c          | 6 +++---
 arch/arm64/mm/kasan_init.c      | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5e1211c540ab..fb95754f2876 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -13,6 +13,8 @@
 
 #ifndef __ASSEMBLER__
 
+#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
+
 #include <linux/refcount.h>
 #include <asm/cpufeature.h>
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e1ac876200a3..2b0ebfb30c63 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -349,9 +349,15 @@ SECTIONS
 	_edata = .;
 
 	/* start of zero-init region */
-	BSS_SECTION(SBSS_ALIGN, 0, 0)
+	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
 	__pi___bss_start = __bss_start;
 
+	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
+	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
+		*(.pgdir.bss)
+	}
+	ASSERT(ADDR(.pgdir.bss) == __bss_stop, ".pgdir.bss must follow BSS")
+
 	. = ALIGN(PAGE_SIZE);
 	__pi_init_pg_dir = .;
 	. += INIT_DIR_SIZE;
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c5c5425791da..1a3bbd67dd76 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -31,9 +31,9 @@ static_assert(NR_BM_PMD_TABLES == 1);
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
-static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __pgtbl_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __pgtbl_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __pgtbl_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index abeb81bf6ebd..dbf22cae82ee 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -214,7 +214,7 @@ asmlinkage void __init kasan_early_init(void)
 		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
 		 * when the linear region is mapped.
 		 */
-		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
+		static pte_t tbl[PTRS_PER_PTE] __pgtbl_bss;
 		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
 
 		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));
-- 
2.54.0.794.g4f17f83d09-goog

