Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70F3D9048
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304153; cv=none; b=ZjZh94lxiYcoY7seyTNNCpUw19qyE8IRw1pUU2ayN4Yz70eHsisdvyzvsPkJVr/lHyN64jF39AksTOMXcRYjwjSRdTyOt9w7Y4vgFdGfLTQf5jCO0uTwdytpi78VfuD6KBI7ZU9W9436FRbriyN2FbcZRhHHYCpdaghLTDH789Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304153; c=relaxed/simple;
	bh=KF0mgBdYxfDGv1ypJG02sC7+sHIEf/dO3mdr8ffAPqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CjMGDWJDwWZS7WBgvJFRYI4LMdRS17M/4iR9d9aYsdTY2oKaqY53iebHGYGzjBitBuYxVttM9Hmq0F7WLV3UWSV2djbdWJiNpGMse6VmYUSpPeK0i8NbDO0XjfZLoIMMralXEMS3VbggJytZh1iMg1LK7L/+yYKwFeu4vnH/qOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pC5xsVVM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pC5xsVVM"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48a5775d647so60542475e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304150; x=1777908950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTH9nHu8rDITPKAJB2BnahRrdCbOr3wfwwaQ1ZOWZK8=;
        b=pC5xsVVMXaTFdYGEYgAABeSROKlluH0hpFscImBOtva97t3NFf92R2t4B2pQw5e1+2
         //C5FwI2nPOwOEWDfhHsHgc2dWx2Z4WDVu6Xmw+02t60SFBJkeK5pQvUuCsIThybL09r
         40UviY5Fejt4flXeq+F+++G1YJ+wrz+ml36JK75WyEvFQOMsxj8d+iBoqmnKpR43Aqur
         rkedbeA9iHsb4G6OWddZ0u4C2BnGsg8n0U9g40bselFPIlYE0jt0qEgyE//CZkLASHQ1
         1ozvVO7ZmlY7YjO4oEgrQkstVP1VUAyhjxQGuWcpgfbg1CeTMyRNGfOLaL+g78DiFG+l
         t4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304150; x=1777908950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTH9nHu8rDITPKAJB2BnahRrdCbOr3wfwwaQ1ZOWZK8=;
        b=BSJf+o+V20cyogu1qr0kSIjFriSznAzEAeMvdUG5Jxh+IVn5uvN1jJ3fnr03v3MlaW
         Nf7Q+KE9K2yWCzZmC9ebgQSJldBPONjz/2IXsDX+N0h7KcbsXZTy+/z5FYwI016acpFA
         yETlzLDCYNSqsMy1VrpraL0p0yyrv2zcNA27O72/jSCbJBicIszNPeJ5GFUP78G0B9UD
         +9QQKc2eLtC1nVCdgbPuMR0kupIPWQv0QkQxqeFRSQTaV2ZstkqsWCySKRBTCG9BLCoZ
         4VbIlF3bZvSzkHKLv3aID/+l5zx+sngYrZKuQZwBcOXS1OkSzCRBwH6Zci3x7DDfP6Sy
         qdsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qQ7JOHuiwk8oJ739UrIerTeqbSyKUPmIwyRY+vQxy+3S+hIZ/G892EuC5lA+aWQg58h8ar6jUWHBgXp2dpos=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyz874BI5G25yGFqlv4saXfHU8sJ20/s4QXeRq+4QLW+tuXVdP
	rt5nWSYgL4t7HWMfEiox3PGVw+SZMlNlCqD9kh/FiE0iU2lM3DAINF6qLkzyu9+xb64MdExaBA=
	=
X-Received: from wmcn9.prod.google.com ([2002:a05:600c:c0c9:b0:485:fb9c:ffa5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3546:b0:488:81b1:ae36
 with SMTP id 5b1f17b1804b1-488fb7880camr604813405e9.23.1777304149544; Mon, 27
 Apr 2026 08:35:49 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:31 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5803; i=ardb@kernel.org;
 h=from:subject; bh=YSdu4q+PtPsInD53oLl+3uBw5SBzUVoUd7FzWVZ14jY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E5+Lo4bOq9KZm6o4L8u/vb/hydxl+fVRaYE/zvc9Y
 VmglsHQUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYix8jIsKnEu41r6pMdV/e7
 tUrq7Z357SWjW05Bks+rK6s47Vdea2ZkmLNng5zCxX8/rKfelTlnZcUXtfa71MttQVn9jCEdZr+ LeQA=
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-31-ardb+git@google.com>
Subject: [PATCH v4 14/15] arm64: mm: Generalize manipulation code of read-only descriptors
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Before moving the fixmap PUD/PMD tables into .rodata, update the
existing descriptor manipulation code so it will fallback to the fixmap
for any descriptor located in the .pgdir_rodata section.

This is slightly more costly, as it evaluates whether or not a
descriptor is in the kernel's rodata region at levels PMD and higher for
any configuration, rather than only when the level in question is the
root level.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 27 ++++++++++----------
 arch/arm64/kernel/vmlinux.lds.S  |  8 ++++--
 arch/arm64/mm/mmu.c              | 24 ++++++++---------
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a1c5894332d9..94235dd428be 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -816,23 +816,22 @@ extern pgd_t swapper_pg_dir[];
 extern pgd_t idmap_pg_dir[];
 extern pgd_t tramp_pg_dir[];
 extern pgd_t reserved_pg_dir[];
+extern pgd_t __pgdir_rodata_start[], __pgdir_rodata_end[];
 
-extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
+extern void set_rodata_pte(pte_t *ptep, pte_t pte);
 
-static inline bool in_swapper_pgdir(void *addr)
+static inline bool in_pgdir_rodata(void *addr)
 {
-	return ((unsigned long)addr & PAGE_MASK) ==
-	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
+	return addr >= (void *)__pgdir_rodata_start &&
+	       addr < (void *)__pgdir_rodata_end;
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-#ifdef __PAGETABLE_PMD_FOLDED
-	if (in_swapper_pgdir(pmdp)) {
-		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
+	if (in_pgdir_rodata(pmdp)) {
+		set_rodata_pte((pte_t *)pmdp, __pte(pmd_val(pmd)));
 		return;
 	}
-#endif /* __PAGETABLE_PMD_FOLDED */
 
 	WRITE_ONCE(*pmdp, pmd);
 
@@ -893,8 +892,8 @@ static inline bool pgtable_l4_enabled(void);
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
-	if (!pgtable_l4_enabled() && in_swapper_pgdir(pudp)) {
-		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
+	if (in_pgdir_rodata(pudp)) {
+		set_rodata_pte((pte_t *)pudp, __pte(pud_val(pud)));
 		return;
 	}
 
@@ -974,8 +973,8 @@ static inline bool mm_pud_folded(const struct mm_struct *mm)
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
-	if (in_swapper_pgdir(p4dp)) {
-		set_swapper_pgd((pgd_t *)p4dp, __pgd(p4d_val(p4d)));
+	if (in_pgdir_rodata(p4dp)) {
+		set_rodata_pte((pte_t *)p4dp, __pte(p4d_val(p4d)));
 		return;
 	}
 
@@ -1102,8 +1101,8 @@ static inline bool mm_p4d_folded(const struct mm_struct *mm)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	if (in_swapper_pgdir(pgdp)) {
-		set_swapper_pgd(pgdp, __pgd(pgd_val(pgd)));
+	if (in_pgdir_rodata(pgdp)) {
+		set_rodata_pte((pte_t *)pgdp, __pte(pgd_val(pgd)));
 		return;
 	}
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2dca18574619..e5e1d0fd7f27 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -243,8 +243,12 @@ SECTIONS
 	reserved_pg_dir = .;
 	. += PAGE_SIZE;
 
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
+	.pgdir_rodata : {
+		__pgdir_rodata_start = .;
+		swapper_pg_dir = .;
+		. += PAGE_SIZE;
+		__pgdir_rodata_end = .;
+	}
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a464f3d2d2df..84d81bae07a7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -65,34 +65,34 @@ static bool rodata_is_rw __ro_after_init = true;
  */
 long __section(".mmuoff.data.write") __early_cpu_boot_status;
 
-static DEFINE_SPINLOCK(swapper_pgdir_lock);
+static DEFINE_SPINLOCK(rodata_pgdir_lock);
 static DEFINE_MUTEX(fixmap_lock);
 
-void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
+void noinstr set_rodata_pte(pte_t *ptep, pte_t pte)
 {
-	pgd_t *fixmap_pgdp;
+	pte_t *fixmap_ptep;
 
 	/*
-	 * Don't bother with the fixmap if swapper_pg_dir is still mapped
-	 * writable in the kernel mapping.
+	 * Don't bother with the fixmap if rodata is still mapped
+	 * writable in the kernel and linear mappings.
 	 */
 	if (rodata_is_rw) {
-		WRITE_ONCE(*pgdp, pgd);
+		WRITE_ONCE(*ptep, pte);
 		dsb(ishst);
 		isb();
 		return;
 	}
 
-	spin_lock(&swapper_pgdir_lock);
-	fixmap_pgdp = pgd_set_fixmap(__pa_symbol(pgdp));
-	WRITE_ONCE(*fixmap_pgdp, pgd);
+	spin_lock(&rodata_pgdir_lock);
+	fixmap_ptep = pte_set_fixmap(__pa_nodebug(ptep));
+	WRITE_ONCE(*fixmap_ptep, pte);
 	/*
 	 * We need dsb(ishst) here to ensure the page-table-walker sees
 	 * our new entry before set_p?d() returns. The fixmap's
 	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
 	 */
-	pgd_clear_fixmap();
-	spin_unlock(&swapper_pgdir_lock);
+	pte_clear_fixmap();
+	spin_unlock(&rodata_pgdir_lock);
 }
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
@@ -1071,6 +1071,7 @@ void __init mark_linear_text_alias_ro(void)
 	/*
 	 * Remove the write permissions from the linear alias of .text/.rodata
 	 */
+	WRITE_ONCE(rodata_is_rw, false);
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    pgprot_tagged(PAGE_KERNEL_RO));
@@ -1221,7 +1222,6 @@ void mark_rodata_ro(void)
 	 * to cover NOTES and EXCEPTION_TABLE.
 	 */
 	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
-	WRITE_ONCE(rodata_is_rw, false);
 	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
 	/* mark the range between _text and _stext as read only. */
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

