Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24845C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiFMSbK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245278AbiFMSa4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826EB57AA
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D908F61376
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D94C341C0;
        Mon, 13 Jun 2022 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131593;
        bh=ffz6XeCg18rVIWyxW845dqGu+ZnLcmwK5q2IBUpozzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcpXSJTo0hgO217Q1ec8uXjw7Q1ytE87lpwPch+jbg/E1rh4Yf3T9VbuskAHZO2re
         Zep4rf/RhnW9DtTtItrNGw4Ubhn/DWL+ZbRKQODEq3Z6t2YXr8PWbpt3DlNNM4dZjS
         oWF3IfmHHsc+4EgS1pxY3WArhTPrsx2J3YxacKQdAJQuSEzh/rG/kT5NLTxiGwSFlt
         1UiMC9DSMUMFZUEtQKiDCl/MG4jPQrGwr5ySNoqybCqDbzkNXqHDgrnDcQNHt8HeHo
         DE2OeAqoZg5fUFJfl1EAM4RI/HTcpvbvPnsJREeLcZX5qtU+E3qzoY3eOWhUapSZrp
         c0RnzA8/yRxaA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 12/26] arm64: head: cover entire kernel image in initial ID map
Date:   Mon, 13 Jun 2022 16:45:36 +0200
Message-Id: <20220613144550.3760857-13-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8914; h=from:subject; bh=ffz6XeCg18rVIWyxW845dqGu+ZnLcmwK5q2IBUpozzg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02FgN4WN6ygqyK1mu7UUqA0lHfw6pg41oESXYqE 55986/yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNhQAKCRDDTyI5ktmPJCeVDA DGzWrcijO+PoAnLAi0bg9vmBa1B49aypbs/UYfp9ffG0h7nyiblKkYHl7sSFsMiqcNIzlG4sX4JwZP QzXyAzCx6wznbfAbYpCyu3N6W+MeFWD+DttgaqaWt5+wEzs+GZINpuzd268CaZdX/e9h260j06wWSU q8p5PAnnYQV05efneS/KO7xmK8bliQRAxOklHLwslLCGr/+ABs+2BKCGXMa04fcawJxnvlIHGiHmyi QjmXNXXe7FG5s6JGpNpYyuPc45te056bMS16WlLwshxEXD2tnbOrAlJANFE+bHnMG73E5ZdCv3KC2d RdlnXS2MScCwKwetntFbLrxWjzsXWwQzQihoM3qjKfHGQ4rhZ/O7pQLJHUSaluJodabiumuV2DLQKf EkUtK33uKaupBfwgQDhdH46URCg4ePgwUdRTip6Q/KpilsmnRlTpDOkYP8bYGccsgi37/+GgCeDvaV JkN0eXoSSjoRG7NWhsXBvjMioxQBynCInYoHy3TfEZiEI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As a first step towards avoiding the need to create, tear down and
recreate the kernel virtual mapping with MMU and caches disabled, start
by expanding the ID map so it covers the page tables as well as all
executable code. This will allow us to populate the page tables with the
MMU and caches on, and call KASLR init code before setting up the
virtual mapping.

Since this ID map is only needed at boot, create it as a temporary set
of page tables, and populate the permanent ID map after enabling the MMU
and caches. While at it, switch to read-only attributes for the where
possible, as writable permissions are only needed for the initial kernel
page tables. Note that on 4k granule configurations, the permanent ID
map will now be reduced to a single page rather than a 2M block mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 16 ++++++---
 arch/arm64/kernel/head.S                | 31 +++++++++++------
 arch/arm64/kernel/vmlinux.lds.S         |  7 ++--
 arch/arm64/mm/mmu.c                     | 35 +++++++++++++++++++-
 arch/arm64/mm/proc.S                    |  8 +++--
 5 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 96dc0f7da258..5395e5a04f35 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -35,10 +35,8 @@
  */
 #if ARM64_KERNEL_USES_PMD_MAPS
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
-#define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT) - 1)
 #else
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
-#define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT))
 #endif
 
 
@@ -87,7 +85,13 @@
 			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
 			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
 #define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end))
-#define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
+
+/* the initial ID map may need two extra pages if it needs to be extended */
+#if VA_BITS < 48
+#define INIT_IDMAP_DIR_SIZE	(INIT_DIR_SIZE + (2 * PAGE_SIZE))
+#else
+#define INIT_IDMAP_DIR_SIZE	INIT_DIR_SIZE
+#endif
 
 /* Initial memory map size */
 #if ARM64_KERNEL_USES_PMD_MAPS
@@ -107,9 +111,11 @@
 #define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
 #if ARM64_KERNEL_USES_PMD_MAPS
-#define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
+#define SWAPPER_RW_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
+#define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PMD_SECT_RDONLY)
 #else
-#define SWAPPER_MM_MMUFLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
+#define SWAPPER_RW_MMUFLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
+#define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PTE_RDONLY)
 #endif
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7397555f8437..93734c91a29a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -87,6 +87,7 @@
 	 *  x28        clear_page_tables()                      callee preserved temp register
 	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
+	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
@@ -298,9 +299,7 @@ SYM_FUNC_START_LOCAL(remap_region)
 SYM_FUNC_END(remap_region)
 
 SYM_FUNC_START_LOCAL(create_idmap)
-	adrp	x0, idmap_pg_dir
-	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
-
+	mov	x28, lr
 	/*
 	 * The ID map carries a 1:1 mapping of the physical address range
 	 * covered by the loaded image, which could be anywhere in DRAM. This
@@ -347,11 +346,22 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * translation level, but the top-level table has more entries.
 	 */
 #endif
-	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
-	mov	x7, SWAPPER_MM_MMUFLAGS
+	adrp	x0, init_idmap_pg_dir
+	adrp	x3, _text
+	adrp	x6, _end
+	mov	x7, SWAPPER_RX_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
+	/* Remap the kernel page tables r/w in the ID map */
+	adrp	x1, _text
+	adrp	x2, init_pg_dir
+	adrp	x3, init_pg_end
+	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RW_MMUFLAGS
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
 	/*
 	 * Since the page tables have been populated with non-cacheable
 	 * accesses (MMU disabled), invalidate those tables again to
@@ -359,9 +369,10 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 */
 	dmb	sy
 
-	adrp	x0, idmap_pg_dir
-	adrp	x1, idmap_pg_end
-	b	dcache_inval_poc		// tail call
+	adrp	x0, init_idmap_pg_dir
+	adrp	x1, init_idmap_pg_end
+	bl	dcache_inval_poc
+	ret	x28
 SYM_FUNC_END(create_idmap)
 
 SYM_FUNC_START_LOCAL(create_kernel_mapping)
@@ -372,7 +383,7 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
-	mov	x7, SWAPPER_MM_MMUFLAGS
+	mov	x7, SWAPPER_RW_MMUFLAGS
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
@@ -853,7 +864,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #endif
 
 	adrp	x1, init_pg_dir
-	adrp	x2, idmap_pg_dir
+	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 8a078c0ee140..0ce3a7c9f8c4 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -199,8 +199,7 @@ SECTIONS
 	}
 
 	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-	idmap_pg_end = .;
+	. += PAGE_SIZE;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
@@ -236,6 +235,10 @@ SECTIONS
 	__inittext_end = .;
 	__initdata_begin = .;
 
+	init_idmap_pg_dir = .;
+	. += INIT_IDMAP_DIR_SIZE;
+	init_idmap_pg_end = .;
+
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 74f9982c30a7..ed3a4b87529b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -769,9 +769,40 @@ static void __init map_kernel(pgd_t *pgdp)
 	kasan_copy_shadow(pgdp);
 }
 
+static void __init create_idmap(void)
+{
+	u64 start = __pa_symbol(__idmap_text_start);
+	u64 size = __pa_symbol(__idmap_text_end) - start;
+	pgd_t *pgd = idmap_pg_dir;
+	u64 pgd_phys;
+
+	/* check if we need an additional level of translation */
+	if (VA_BITS < 48 && idmap_t0sz < TCR_T0SZ(VA_BITS_MIN)) {
+		pgd_phys = early_pgtable_alloc(PAGE_SHIFT);
+		set_pgd(&idmap_pg_dir[start >> VA_BITS],
+			__pgd(pgd_phys | P4D_TYPE_TABLE));
+		pgd = __va(pgd_phys);
+	}
+	__create_pgd_mapping(pgd, start, start, size, PAGE_KERNEL_ROX,
+			     early_pgtable_alloc, 0);
+
+	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)) {
+		extern u32 __idmap_kpti_flag;
+		u64 pa = __pa_symbol(&__idmap_kpti_flag);
+
+		/*
+		 * The KPTI G-to-nG conversion code needs a read-write mapping
+		 * of its synchronization flag in the ID map.
+		 */
+		__create_pgd_mapping(pgd, pa, pa, sizeof(u32), PAGE_KERNEL,
+				     early_pgtable_alloc, 0);
+	}
+}
+
 void __init paging_init(void)
 {
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+	extern pgd_t init_idmap_pg_dir[];
 
 #if VA_BITS > 48
 	if (cpuid_feature_extract_unsigned_field(
@@ -792,13 +823,15 @@ void __init paging_init(void)
 
 	pgd_clear_fixmap();
 
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), init_idmap_pg_dir);
 	init_mm.pgd = swapper_pg_dir;
 
 	memblock_phys_free(__pa_symbol(init_pg_dir),
 			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
 
 	memblock_allow_resize();
+
+	create_idmap();
 }
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 97cd67697212..493b8ffc9be5 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -249,8 +249,10 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
  *
  * Called exactly once from stop_machine context by each CPU found during boot.
  */
-__idmap_kpti_flag:
-	.long	1
+	.pushsection	".data", "aw", %progbits
+SYM_DATA(__idmap_kpti_flag, .long 1)
+	.popsection
+
 SYM_FUNC_START(idmap_kpti_install_ng_mappings)
 	cpu		.req	w0
 	temp_pte	.req	x0
@@ -273,7 +275,7 @@ SYM_FUNC_START(idmap_kpti_install_ng_mappings)
 
 	mov	x5, x3				// preserve temp_pte arg
 	mrs	swapper_ttb, ttbr1_el1
-	adr	flag_ptr, __idmap_kpti_flag
+	adr_l	flag_ptr, __idmap_kpti_flag
 
 	cbnz	cpu, __idmap_kpti_secondary
 
-- 
2.30.2

