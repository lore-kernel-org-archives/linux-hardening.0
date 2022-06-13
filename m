Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44111C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbiFMSbQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245545AbiFMSbD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:31:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4EDB641F
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B66A61121
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894B6C385A2;
        Mon, 13 Jun 2022 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131605;
        bh=4fUGT6A0wQkzOLjo7YGQqUPF0YyCSsB6E9CDXhu0XAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOqaYYNXDrYqasdo0yp+g+A639cra4h8YNwfxvy06Y7vDdBMtQeOi+mpsjr7cGnGl
         ozmKkvyBhXryuZs0qYS2m8GpBSBMwK7TTqyLiHWPYtH1FLhLZz/oos2XNUIr70EqSQ
         In0ktm6QFtXux9R9kvqar255hr1NsniVqhcl1yFiK6F9dAhGcFUQtYXQ7FZbXGCxNA
         VdJK0RjN9TBrNPOSqdo1ARrHiKslSODKFpC3zQY6F901tOoghri3iZXlQ07FfIZuGD
         tlho2tu2qF3cPEHmhrPkeE7uqU8LFMKahem+1Sa69Jy5udolI+FbSNh0P7+IA41lP4
         9dKskb1gzOIIQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 17/26] arm64: head: populate kernel page tables with MMU and caches on
Date:   Mon, 13 Jun 2022 16:45:41 +0200
Message-Id: <20220613144550.3760857-18-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4295; h=from:subject; bh=4fUGT6A0wQkzOLjo7YGQqUPF0YyCSsB6E9CDXhu0XAw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02NV+6z4U5Wm9BPHtSHvjveEKJTikIyDLJYm9lw QRuagvaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNjQAKCRDDTyI5ktmPJHwGDA C0CQ+CUiZbyC3l/p5wkqLGL9p+lY+ErVEV6XBUhSKMbH+sL7chRh7mfRD/M3E6TL+Sw2+omfsJxEwB bH84i5RYEPXrdEx1Ws4pfBhNXxpFTwIOx7/GUj60q4XEgGJTB32ex0ofipEOrPPnRP5XFLRpF/+6Ey Ke9Zjbz4Gn9L4DHWy78TxZfY5SwG1gzebH1wNxGsO6gWdiG6cNm/X5hCs96mJrNhlgh8Wz+MVdMUsx gP6LbNTRKytXu3FvTwZavGSTrOuiX3q97Ok2Bxj3zO4XaKAq6LS0DEfEaJuyKCMkN85EiwCyiEDhhm nKYLDyJ7/CgYeMjXv5h0KWz/F8oneENchM1O8id4MzootR5WtOdR3D2mjAovGzxhxxXnrg/+2GY1nO UVW3fkNftlONWLJUghDwZRuvXRYCfR81QkvVvcqdCS1/jXVEGiPBq5O1Up0XaREeleiyZphQgblbda tQpaFTDzhqit32EyZDqyGozrZDoqyM/45QO4qMvotFAX0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Now that we can access the entire kernel image via the ID map, we can
execute the page table population code with the MMU and caches enabled.
The only thing we need to ensure is that translations via TTBR1 remain
disabled while we are updating the page tables the second time around,
in case KASLR wants them to be randomized.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 62 +++++---------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d704d0bd8ffc..583cbea865e1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -85,8 +85,6 @@
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x28        clear_page_tables()                      callee preserved temp register
-	 *  x19/x20    __primary_switch()                       callee preserved temp registers
 	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
@@ -96,9 +94,7 @@ SYM_CODE_START(primary_entry)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
-	bl	clear_page_tables
 	bl	create_idmap
-	bl	create_kernel_mapping
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -128,32 +124,14 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
-	mov	x28, lr
-
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
 	/*
 	 * Clear the init page tables.
 	 */
 	adrp	x0, init_pg_dir
 	adrp	x1, init_pg_end
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
-
-	ret	x28
+	sub	x2, x1, x0
+	mov	x1, xzr
+	b	__pi_memset			// tail call
 SYM_FUNC_END(clear_page_tables)
 
 /*
@@ -399,16 +377,8 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
 
-	/*
-	 * Since the page tables have been populated with non-cacheable
-	 * accesses (MMU disabled), invalidate those tables again to
-	 * remove any speculatively loaded cache lines.
-	 */
-	dmb	sy
-
-	adrp	x0, init_pg_dir
-	adrp	x1, init_pg_end
-	b	dcache_inval_poc		// tail call
+	dsb	ishst				// sync with page table walker
+	ret
 SYM_FUNC_END(create_kernel_mapping)
 
 	/*
@@ -863,14 +833,15 @@ SYM_FUNC_END(__relocate_kernel)
 #endif
 
 SYM_FUNC_START_LOCAL(__primary_switch)
-#ifdef CONFIG_RANDOMIZE_BASE
-	mov	x19, x0				// preserve new SCTLR_EL1 value
-	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
-#endif
-
-	adrp	x1, init_pg_dir
+	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
+
+	bl	clear_page_tables
+	bl	create_kernel_mapping
+
+	adrp	x1, init_pg_dir
+	load_ttbr1 x1, x1, x2
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
 	mov	x24, #0				// no RELR displacement yet
@@ -886,9 +857,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	 * to take into account by discarding the current kernel mapping and
 	 * creating a new one.
 	 */
-	pre_disable_mmu_workaround
-	msr	sctlr_el1, x20			// disable the MMU
-	isb
+	adrp	x1, reserved_pg_dir		// Disable translations via TTBR1
+	load_ttbr1 x1, x1, x2
 	bl	clear_page_tables
 	bl	create_kernel_mapping		// Recreate kernel mapping
 
@@ -896,8 +866,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	dsb	nsh
 	isb
 
-	set_sctlr_el1	x19			// re-enable the MMU
-
+	adrp	x1, init_pg_dir			// Re-enable translations via TTBR1
+	load_ttbr1 x1, x1, x2
 	bl	__relocate_kernel
 #endif
 #endif
-- 
2.30.2

