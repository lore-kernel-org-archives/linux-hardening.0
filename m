Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40245CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245451AbiFMSbQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245506AbiFMSbD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:31:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFFB7147
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 517C9B8105D
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03504C3411B;
        Mon, 13 Jun 2022 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131608;
        bh=pxy0llk3lU+vE7ZUGCdY3eOFHQYtTICKHWtxJ9n32Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5GMee2g1tG1N9JYRkdAPnStzTZNCOlvORYzbcBInolwvmmbJGvq0n9RB3IEEsSRw
         kJYwQVN88i/aZe6VGA1i9OaQvN8w/44Mxn4HSy3oRbJ3x44iNlrxkuDfj0qaF36Nro
         0DwiepvQSXjetXFfpZPzlhkOENQumDdhpGpmZ6iMEor6O0QzVNzlpAU5BASRJIZcem
         Io8FSHRX7G5wR0B17507Z+LvBTGEHLIp5NuWmS5xpXGoV/IlIi1ZFaQBTKu7jhyp3R
         HnIOUudlrGYXlrNvmsUO3f1aS1TVlOdWTF8Om91hTKhdX0WCDWnRb823LrkvHxG4EL
         T8Fr5ZebPbQcQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 18/26] arm64: head: record CPU boot mode after enabling the MMU
Date:   Mon, 13 Jun 2022 16:45:42 +0200
Message-Id: <20220613144550.3760857-19-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5885; h=from:subject; bh=pxy0llk3lU+vE7ZUGCdY3eOFHQYtTICKHWtxJ9n32Jc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02PejBEZAWtKDoYK9J8rjOdKs5aow9TJyQlJeFY WrykIPmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNjwAKCRDDTyI5ktmPJAV4C/ oCZL7/oH3WsuehM/ebly+VeHVYEuPolJPuOYbL036gmWrURFMwmknGuSrVyjrudVaSdcK0VT8Phw6z RT83frkLZgT4beyJuCfdpQ2Js0ggq5tirGIUrJjqDUEJ+wF/7Xwad1XETa+KojCfe9ziZ0rTMGwlUj 3x/lybDrKW64rDyqI/4zOOtYYB9L/84NhujaQr6RhPsTd9xo6ywr9s8Q7xN+W7XL1ws+vSHDY0tfZV k2kIO7u12CHpZOjKIxdqMiQeOOPLlgoMlcRqDUw7K3pwiKMMYyzvb8b1FcPDTkyBbc0txp+U2igqqv RDIObbSFjksjoYlJ0cAzSIOsQSyCYNXIL7BnF7BJhTo+1J1sqLbJJFO0qpoiSUHWt9Ag4mH6Wk0Wfo nhLpZUx+11y+18ARfBXGnpX+pHVC3o6ehbzxTiUZSQEtksXHczZamluQ2rDgsa6fJydDh5fyxdxN1A 9kv8siW5RwTHpp2TYqqfD8jCTbFD+H028MraTC8djUiFY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to avoid having to touch memory with the MMU and caches
disabled, and therefore having to invalidate it from the caches
explicitly, just defer storing the value until after the MMU has been
turned on, unless we are giving up with an error.

While at it, move the associated variable definitions into C code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S     | 50 +++++---------------
 arch/arm64/kernel/hyp-stub.S |  4 +-
 arch/arm64/mm/mmu.c          |  8 ++++
 3 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 583cbea865e1..8de346dd4470 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -82,6 +82,7 @@
 	 * primary lowlevel boot path:
 	 *
 	 *  Register   Scope                      Purpose
+	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
@@ -91,9 +92,9 @@
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
+	mov	x20, x0
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
-	bl	set_cpu_boot_mode_flag
 	bl	create_idmap
 
 	/*
@@ -429,6 +430,9 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	sub	x4, x4, x0			// the kernel virtual and
 	str_l	x4, kimage_voffset, x5		// physical mappings
 
+	mov	x0, x20
+	bl	set_cpu_boot_mode_flag
+
 	// Clear BSS
 	adr_l	x0, __bss_start
 	mov	x1, xzr
@@ -454,6 +458,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	ret					// to __primary_switch()
 0:
 #endif
+	mov	x0, x20
 	bl	switch_to_vhe			// Prefer VHE if possible
 	ldp	x29, x30, [sp], #16
 	bl	start_kernel
@@ -553,52 +558,21 @@ SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
 	b.ne	1f
 	add	x1, x1, #4
 1:	str	w0, [x1]			// Save CPU boot mode
-	dmb	sy
-	dc	ivac, x1			// Invalidate potentially stale cache line
 	ret
 SYM_FUNC_END(set_cpu_boot_mode_flag)
 
-/*
- * These values are written with the MMU off, but read with the MMU on.
- * Writers will invalidate the corresponding address, discarding up to a
- * 'Cache Writeback Granule' (CWG) worth of data. The linker script ensures
- * sufficient alignment that the CWG doesn't overlap another section.
- */
-	.pushsection ".mmuoff.data.write", "aw"
-/*
- * We need to find out the CPU boot mode long after boot, so we need to
- * store it in a writable variable.
- *
- * This is not in .bss, because we set it sufficiently early that the boot-time
- * zeroing of .bss would clobber it.
- */
-SYM_DATA_START(__boot_cpu_mode)
-	.long	BOOT_CPU_MODE_EL2
-	.long	BOOT_CPU_MODE_EL1
-SYM_DATA_END(__boot_cpu_mode)
-/*
- * The booting CPU updates the failed status @__early_cpu_boot_status,
- * with MMU turned off.
- */
-SYM_DATA_START(__early_cpu_boot_status)
-	.quad 	0
-SYM_DATA_END(__early_cpu_boot_status)
-
-	.popsection
-
 	/*
 	 * This provides a "holding pen" for platforms to hold all secondary
 	 * cores are held until we're ready for them to initialise.
 	 */
 SYM_FUNC_START(secondary_holding_pen)
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
-	mrs	x0, mpidr_el1
+	mrs	x2, mpidr_el1
 	mov_q	x1, MPIDR_HWID_BITMASK
-	and	x0, x0, x1
+	and	x2, x2, x1
 	adr_l	x3, secondary_holding_pen_release
 pen:	ldr	x4, [x3]
-	cmp	x4, x0
+	cmp	x4, x2
 	b.eq	secondary_startup
 	wfe
 	b	pen
@@ -610,7 +584,6 @@ SYM_FUNC_END(secondary_holding_pen)
 	 */
 SYM_FUNC_START(secondary_entry)
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
 	b	secondary_startup
 SYM_FUNC_END(secondary_entry)
 
@@ -618,6 +591,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
+	mov	x20, x0				// preserve boot mode
 	bl	switch_to_vhe
 	bl	__cpu_secondary_check52bitva
 	bl	__cpu_setup			// initialise processor
@@ -629,6 +603,9 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 SYM_FUNC_END(secondary_startup)
 
 SYM_FUNC_START_LOCAL(__secondary_switched)
+	mov	x0, x20
+	bl	set_cpu_boot_mode_flag
+	str_l	xzr, __early_cpu_boot_status, x3
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
 	isb
@@ -691,7 +668,6 @@ SYM_FUNC_START(__enable_mmu)
 	b.lt    __no_granule_support
 	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
 	b.gt    __no_granule_support
-	update_early_cpu_boot_status 0, x3, x4
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
 	load_ttbr1 x1, x1, x3
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 43d212618834..5bafb53fafb4 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -223,11 +223,11 @@ SYM_FUNC_END(__hyp_reset_vectors)
 
 /*
  * Entry point to switch to VHE if deemed capable
+ *
+ * w0: boot mode, as returned by init_kernel_el()
  */
 SYM_FUNC_START(switch_to_vhe)
 	// Need to have booted at EL2
-	adr_l	x1, __boot_cpu_mode
-	ldr	w0, [x1]
 	cmp	w0, #BOOT_CPU_MODE_EL2
 	b.ne	1f
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ed3a4b87529b..9828ad826837 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -56,6 +56,14 @@ EXPORT_SYMBOL(kimage_vaddr);
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
+u32 __boot_cpu_mode[] = { BOOT_CPU_MODE_EL2, BOOT_CPU_MODE_EL1 };
+
+/*
+ * The booting CPU updates the failed status @__early_cpu_boot_status,
+ * with MMU turned off.
+ */
+long __section(".mmuoff.data.write") __early_cpu_boot_status;
+
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
-- 
2.30.2

