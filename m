Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0EC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbiFMSbG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiFMSau (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1AB527A
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9460B8105B
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2A3C34114;
        Mon, 13 Jun 2022 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131578;
        bh=tP8R1xHI6gZfqXXfZqQtZ+TXUEOhPzFX2O0GeERgqzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L27lk4ha7ZCGGC8pgl0vTVmJ8UtIuG/pxwTxGZGM62AW/vws+2PSAqh2QlXsn+CHR
         LuBsC3rwUvv0XtFsx7Dp/jq1zzftD5Hy861WDRAXJf86oFgxZVNJOEyFzippBVGcRD
         w02tXZnEFUWpJxxJeKVMAdaRTAMz3prCmik3wBFAt/K92cKDmtkZwKhjAwGJcgnplF
         s8hLhnVxD1yxzmh1K/pJHasCFAelCRrE4sWNsolPg3XGE4wQXzinsSCAKpbc8sG1mT
         F8c2r5VOoMEXeOTHkeSEr0N+sY6t8XJwjKqXYODo3NuULnNNw7q0gXpDdpZrxpVOmu
         Y+yG7LnYWd6YA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 06/26] arm64: head: switch to map_memory macro for the extended ID map
Date:   Mon, 13 Jun 2022 16:45:30 +0200
Message-Id: <20220613144550.3760857-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6360; h=from:subject; bh=tP8R1xHI6gZfqXXfZqQtZ+TXUEOhPzFX2O0GeERgqzc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip011w3V5UYIKiCXjI91akig/McBpdcqTLhu/dp6m 6mD3u+qJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNdQAKCRDDTyI5ktmPJP0vDA CBfGWtzgQm33wJx2gGr5rHUi5t/Hq7NKSKYEE1Tvt9uG8v0pIZI8NO9jV0PFZKqvFoEgHRUttQCuVG iID8P05K4pIEFg7+/EowhPuZbazD3YB1hY+iynee4sMygHAzzLtTx1l5jSQjEzx21mQswvL2u3H4Df KRb3jKLeMPYkrqspq49jhbUBroKDFHa4/CQWH60qGsXGSpqudo7EesUXVdkt7ES+wWkoRXsvc2NQt8 UPHoEEwyh936AD1fmeJHdWeCENnhSzPqTjPrhHJ/TeRf2+Z+zUTL+NNlQ5PS0U2SDbzWNDG9ft3jmy V5yT4aQJE77tNq16jDR1+sHie81jinXD3+qRdPAQzv0KksP7guICKEGCE/cQGeOvcJbWxlVL0+5GTT epMonmp8nw4IZ9dMcd2nvLAsD/mrMOIjHZcS1ltWlMTlA2tfi4Y3aIH0RTLRO/5fZVVrQV8Lih6G4s BfhAIeZC6bd1IFi2cg41iAIOeaGThwPcFw7veJBuT3sD4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In a future patch, we will start using an ID map that covers the entire
image, rather than a single page. This means that we need to deal with
the pathological case of an extended ID map where the kernel image does
not fit neatly inside a single entry at the root level, which means we
will need to create additional table entries and map additional pages
for page tables.

The existing map_memory macro already takes care of most of that, so
let's just extend it to deal with this case as well. While at it, drop
the conditional branch on the value of T0SZ: we don't set the variable
anymore in the entry code, and so we can just let the map_memory macro
deal with the case where the output address exceeds VA_BITS.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 76 ++++++++++----------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9fdde2f9cc0f..eb54c0289c8a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -122,29 +122,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	b	dcache_inval_poc		// tail call
 SYM_CODE_END(preserve_boot_args)
 
-/*
- * Macro to create a table entry to the next page.
- *
- *	tbl:	page table address
- *	virt:	virtual address
- *	shift:	#imm page table shift
- *	ptrs:	#imm pointers per table page
- *
- * Preserves:	virt
- * Corrupts:	ptrs, tmp1, tmp2
- * Returns:	tbl -> next level table page address
- */
-	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
-	add	\tmp1, \tbl, #PAGE_SIZE
-	phys_to_pte \tmp2, \tmp1
-	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
-	lsr	\tmp1, \virt, #\shift
-	sub	\ptrs, \ptrs, #1
-	and	\tmp1, \tmp1, \ptrs		// table index
-	str	\tmp2, [\tbl, \tmp1, lsl #3]
-	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
-	.endm
-
 /*
  * Macro to populate page table entries, these entries can be pointers to the next level
  * or last level entries pointing to physical memory.
@@ -209,15 +186,27 @@ SYM_CODE_END(preserve_boot_args)
  *	phys:	physical address corresponding to vstart - physical memory is contiguous
  *	order:  #imm 2log(number of entries in PGD table)
  *
+ * If extra_shift is set, an extra level will be populated if the end address does
+ * not fit in 'extra_shift' bits. This assumes vend is in the TTBR0 range.
+ *
  * Temporaries:	istart, iend, tmp, count, sv - these need to be different registers
  * Preserves:	vstart, flags
  * Corrupts:	tbl, rtbl, vend, istart, iend, tmp, count, sv
  */
-	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, order, istart, iend, tmp, count, sv
+	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, order, istart, iend, tmp, count, sv, extra_shift
 	sub \vend, \vend, #1
 	add \rtbl, \tbl, #PAGE_SIZE
 	mov \count, #0
 
+	.ifnb	\extra_shift
+	tst	\vend, #~((1 << (\extra_shift)) - 1)
+	b.eq	.L_\@
+	compute_indices \vstart, \vend, #\extra_shift, #(PAGE_SHIFT - 3), \istart, \iend, \count
+	mov \sv, \rtbl
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	mov \tbl, \sv
+	.endif
+.L_\@:
 	compute_indices \vstart, \vend, #PGDIR_SHIFT, #\order, \istart, \iend, \count
 	mov \sv, \rtbl
 	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
@@ -284,20 +273,32 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
 	/*
-	 * VA_BITS may be too small to allow for an ID mapping to be created
-	 * that covers system RAM if that is located sufficiently high in the
-	 * physical address space. So for the ID map, use an extended virtual
-	 * range in that case, and configure an additional translation level
-	 * if needed.
+	 * The ID map carries a 1:1 mapping of the physical address range
+	 * covered by the loaded image, which could be anywhere in DRAM. This
+	 * means that the required size of the VA (== PA) space is decided at
+	 * boot time, and could be more than the configured size of the VA
+	 * space for ordinary kernel and user space mappings.
+	 *
+	 * There are three cases to consider here:
+	 * - 39 <= VA_BITS < 48, and the ID map needs up to 48 VA bits to cover
+	 *   the placement of the image. In this case, we configure one extra
+	 *   level of translation on the fly for the ID map only. (This case
+	 *   also covers 42-bit VA/52-bit PA on 64k pages).
+	 *
+	 * - VA_BITS == 48, and the ID map needs more than 48 VA bits. This can
+	 *   only happen when using 64k pages, in which case we need to extend
+	 *   the root level table rather than add a level. Note that we can
+	 *   treat this case as 'always extended' as long as we take care not
+	 *   to program an unsupported T0SZ value into the TCR register.
+	 *
+	 * - Combinations that would require two additional levels of
+	 *   translation are not supported, e.g., VA_BITS==36 on 16k pages, or
+	 *   VA_BITS==39/4k pages with 5-level paging, where the input address
+	 *   requires more than 47 or 48 bits, respectively.
 	 */
-	idmap_get_t0sz x5
-	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
-	b.ge	1f			// .. then skip VA range extension
-
 #if (VA_BITS < 48)
 #define IDMAP_PGD_ORDER	(VA_BITS - PGDIR_SHIFT)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
-#define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
 
 	/*
 	 * If VA_BITS < 48, we have to configure an additional table level.
@@ -309,20 +310,17 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #if VA_BITS != EXTRA_SHIFT
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
-
-	mov	x2, EXTRA_PTRS
-	create_table_entry x0, x3, EXTRA_SHIFT, x2, x5, x6
 #else
 #define IDMAP_PGD_ORDER	(PHYS_MASK_SHIFT - PGDIR_SHIFT)
+#define EXTRA_SHIFT
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
 	 * translation level, but the top-level table has more entries.
 	 */
 #endif
-1:
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 
-	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14
+	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
-- 
2.30.2

