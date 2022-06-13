Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60FC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbiFMSbF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbiFMSau (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668FB5780
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AE1DB81058
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EF4C341C7;
        Mon, 13 Jun 2022 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131581;
        bh=OhKluuvrPX/ZIKI6cSSrnjwjMiDdvqkJIcBzUOSbddk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/UfUVUaH1ovxR820aTzGba59k83AkXAuugCzGUdqM3E8Esk7X/UiOvMWhqm7cMwS
         O43BEMkIhWLNjEF//ZpU/EEtxsheNB71hbHxVjJanMv03P8FjX84Gabjm4781a0Jdw
         2QfZHj/SvDF4Q2J5pexDtWkN56MvlewnvVRtqpH0mtnMc/zdFc2/DwqcQSQxX+vvGU
         aTCZfyBARcbw1CeBvt3CMJx1aCoAhg0tYeptrnrh9DobSyu03szbV9lpItLd0xPYtm
         9Fdx3RocD3RFYeAwRVF/uzPGF+8VIj4fg2zmEUXePYh+tHRe0Fd87e0QP45DZH88r5
         OiY3NZjIuA7Ug==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 07/26] arm64: head: split off idmap creation code
Date:   Mon, 13 Jun 2022 16:45:31 +0200
Message-Id: <20220613144550.3760857-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5970; h=from:subject; bh=OhKluuvrPX/ZIKI6cSSrnjwjMiDdvqkJIcBzUOSbddk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip013BkB7RbgceET9//c1e3q1KM8XQiA2SuRu0Jut Lucg722JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNdwAKCRDDTyI5ktmPJGctC/ 44lf4aX8pgQZFwviqJI43KozRnPQH7s3iwBbiHsw8pTquGElPc9lMeEeBhx3igXEf8YCyX/rAtj0II ACeitxinucMeH7NLGaOg08+7zrb2g1LYylLZuTtCPhZ/OwS+3EQXKokf3fS63SjORzeBva3cSJE4J/ 0sFOO4tJNx3ct61l+QHu/doTVHGvlHniG5PjbgkldMEl9Md2vxgQVpKeJNWyyoZtHA0PR4TwmsWv8D 6EsoGGPltihj4SD7kSXEV03CMnzS9w2QnFMmZKHQQjhaZj9NNuYFqdqUNYv2/J35RHGE11wioaO6Vc RlSmYTWGa9LHM42dQ2OuZ32UMU1SJbkqKBumh6179dNhhASESL+wuoah2oJHFKkNEljaDyHwu3HfYs Kgv13z6VU+pfBB/f+TMXuuPlKzSu5zBFi7ryXtExSyors5FDUMyVWyCkn0bDeGajX8SxV/fZsGwgPI P/HagQGRUPyF4lhvN7ekddofZR7Yls2QVl9viWs+Vq7iM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Split off the creation of the ID map page tables, so that we can avoid
running it again unnecessarily when KASLR is in effect (which only
randomizes the virtual placement). This will permit us to drop some
explicit cache maintenance to the PoC which was necessary because the
cache invalidation being performed on some global variables might
otherwise clobber unrelated variables that happen to share a cacheline.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 101 ++++++++++----------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index eb54c0289c8a..1cbc52097bf9 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -84,7 +84,7 @@
 	 *  Register   Scope                      Purpose
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x28        __create_page_tables()                   callee preserved temp register
+	 *  x28        clear_page_tables()                      callee preserved temp register
 	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
 	 */
@@ -94,7 +94,10 @@ SYM_CODE_START(primary_entry)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
-	bl	__create_page_tables
+	bl	clear_page_tables
+	bl	create_idmap
+	bl	create_kernel_mapping
+
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
 	 * details.
@@ -122,6 +125,35 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	b	dcache_inval_poc		// tail call
 SYM_CODE_END(preserve_boot_args)
 
+SYM_FUNC_START_LOCAL(clear_page_tables)
+	mov	x28, lr
+
+	/*
+	 * Invalidate the init page tables to avoid potential dirty cache lines
+	 * being evicted. Other page tables are allocated in rodata as part of
+	 * the kernel image, and thus are clean to the PoC per the boot
+	 * protocol.
+	 */
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	bl	dcache_inval_poc
+
+	/*
+	 * Clear the init page tables.
+	 */
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+1:	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	stp	xzr, xzr, [x0], #16
+	subs	x1, x1, #64
+	b.ne	1b
+
+	ret	x28
+SYM_FUNC_END(clear_page_tables)
+
 /*
  * Macro to populate page table entries, these entries can be pointers to the next level
  * or last level entries pointing to physical memory.
@@ -231,44 +263,8 @@ SYM_CODE_END(preserve_boot_args)
 	populate_entries \tbl, \rtbl, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
 	.endm
 
-/*
- * Setup the initial page tables. We only setup the barest amount which is
- * required to get the kernel running. The following sections are required:
- *   - identity mapping to enable the MMU (low address, TTBR0)
- *   - first few MB of the kernel linear mapping to jump to once the MMU has
- *     been enabled
- */
-SYM_FUNC_START_LOCAL(__create_page_tables)
-	mov	x28, lr
 
-	/*
-	 * Invalidate the init page tables to avoid potential dirty cache lines
-	 * being evicted. Other page tables are allocated in rodata as part of
-	 * the kernel image, and thus are clean to the PoC per the boot
-	 * protocol.
-	 */
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	bl	dcache_inval_poc
-
-	/*
-	 * Clear the init page tables.
-	 */
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
-
-	mov	x7, SWAPPER_MM_MMUFLAGS
-
-	/*
-	 * Create the identity mapping.
-	 */
+SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
@@ -319,12 +315,23 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 */
 #endif
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
+	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
 	/*
-	 * Map the kernel image (starting with PHYS_OFFSET).
+	 * Since the page tables have been populated with non-cacheable
+	 * accesses (MMU disabled), invalidate those tables again to
+	 * remove any speculatively loaded cache lines.
 	 */
+	dmb	sy
+
+	adrp	x0, idmap_pg_dir
+	adrp	x1, idmap_pg_end
+	b	dcache_inval_poc		// tail call
+SYM_FUNC_END(create_idmap)
+
+SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	adrp	x0, init_pg_dir
 	mov_q	x5, KIMAGE_VADDR		// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
@@ -332,6 +339,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
+	mov	x7, SWAPPER_MM_MMUFLAGS
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
@@ -342,16 +350,10 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 */
 	dmb	sy
 
-	adrp	x0, idmap_pg_dir
-	adrp	x1, idmap_pg_end
-	bl	dcache_inval_poc
-
 	adrp	x0, init_pg_dir
 	adrp	x1, init_pg_end
-	bl	dcache_inval_poc
-
-	ret	x28
-SYM_FUNC_END(__create_page_tables)
+	b	dcache_inval_poc		// tail call
+SYM_FUNC_END(create_kernel_mapping)
 
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
@@ -836,7 +838,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x20			// disable the MMU
 	isb
-	bl	__create_page_tables		// recreate kernel mapping
+	bl	clear_page_tables
+	bl	create_kernel_mapping		// Recreate kernel mapping
 
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
-- 
2.30.2

