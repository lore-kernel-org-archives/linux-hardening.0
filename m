Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5078BCCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbiFMSbC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245506AbiFMSat (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2838BB7DCF
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3D54B8105C
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8FCC341C4;
        Mon, 13 Jun 2022 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131620;
        bh=39z4H7gQhk37tMuzT7u3jfPc/a1t6NKvtH23Ke11dSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slPGkU0PFtZFL2JNNsFuUVU4wQ7guIYoXHJL4zX9LmBDx/QlkLySG4g8nq4ryG/Qb
         rpUbpUpmJhB1f9GbvL++IhBnVRRXJGeg+7nAkl1EeSWp1qfluS6R4v1RqvggIqbtw5
         RxLsppORwuqvjfSvAXuDs7ScRFGumDIYtvixH6yGnqQcQxd8364wvwRcJhm9CmKkKV
         2rCYEFNxO3xku+jAqWML+iG+SujlbF6R3DpyGYzvF5n7i9eOMJlGeyqteYuNW1D4du
         2akW42Qbab1U/JevHoJxYb8kNgCYBDe0Q6z2Zx5WT3Ua6FAI33hGvpv/QaBXHLefcR
         jtd5qAd3vxGTg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 23/26] arm64: head: remap the kernel text/inittext region read-only
Date:   Mon, 13 Jun 2022 16:45:47 +0200
Message-Id: <20220613144550.3760857-24-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5386; h=from:subject; bh=39z4H7gQhk37tMuzT7u3jfPc/a1t6NKvtH23Ke11dSg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02YimbsU6+W6N3oes89CwxS3smL+xwynIaGeLP9 rtpbfaWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNmAAKCRDDTyI5ktmPJF5rDA CRhzzdUfxHEaLOJ+f/oakVY8sASHL8n7d8oqI56o7iaIHsFa6wS4AXfLXHUGeDYzFQvfLGXj9k5Wvf BzQRFKXB0HIUVV4QhHhs6MrHIv2fJXWJzmztrC0vvPRQQiHJA7TaAALz1NeMtErvGAMrCSLodDzrTO BZZat/MqQEOkNKDfeVkGbLrm35NQUaWVRjY5kga0t9EPtGo3BhnFVL7gHifl5bR1ka25h3VqXmL/Pp OeoLqJb7wBndScEY7wkB+wJ4h+cebitUELcnCrDf82t8/WqeStiJGUArtaXhegd7hISQmm7ZieYxAm l1e2CBrblYUSSmgwhOVb9AH/faBjPzigFYiWlXTqJkcZBdgorro0b6NMT4dqwFKVovFFB5thfP3YGK Z3rx4Zzg6IOhOXZMprLlZrh+TEodLUzkiYqVovrNsV8b4FMlcLliGhoMMrLLIvoqnWPiVTg9WgHa0C 38Cbs7zPVSXwOOOi/9M9F/z72msZo6KebMbQDxtH5IZ7s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to be able to run with WXN from boot (which could potentially
be under a hypervisor regime that mandates this), update the temporary
kernel page tables with read-only attributes for the text regions before
attempting to execute from them.

This is rather straight-forward for 16k and 64k granule configurations,
as the split between executable and writable regions is guaranteed to be
aligned to the granule used for the early kernel page tables. For 4k, it
involves installing a single table entry and populating it accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h |  8 +++
 arch/arm64/kernel/head.S           | 73 ++++++++++++++++++--
 arch/arm64/kernel/vmlinux.lds.S    |  2 +-
 arch/arm64/mm/proc.S               | 11 ---
 4 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index b2584709c332..e1e652410d7d 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -507,6 +507,14 @@ alternative_endif
 	load_ttbr1 \page_table, \tmp, \tmp2
 	.endm
 
+	.macro		__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
+	adrp		\tmp1, reserved_pg_dir
+	load_ttbr1 	\tmp1, \tmp1, \tmp2
+	tlbi		vmalle1
+	dsb		nsh
+	isb
+	.endm
+
 /*
  * reset_pmuserenr_el0 - reset PMUSERENR_EL0 if PMUv3 present
  */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6bf685f988f1..92cbad41eed8 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -87,7 +87,7 @@
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
 	 *  x24        __primary_switch()                       linear map KASLR seed
-	 *  x28        create_idmap()                           callee preserved temp register
+	 *  x28        create_idmap(), remap_kernel_text()      callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
@@ -380,6 +380,66 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	ret
 SYM_FUNC_END(create_kernel_mapping)
 
+SYM_FUNC_START_LOCAL(remap_kernel_text)
+	mov	x28, lr
+
+	ldr_l	x1, kimage_vaddr
+	mov	x2, x1
+	ldr_l	x3, .Linitdata_begin
+	adrp	x4, _text
+	bic	x4, x4, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RX_MMUFLAGS
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
+#if SWAPPER_BLOCK_SHIFT > PAGE_SHIFT
+	/*
+	 * If the boundary between inittext and initdata happens to be aligned
+	 * sufficiently, we are done here. Otherwise, we have to replace its block
+	 * entry with a table entry, and populate the lower level table accordingly.
+	 */
+	ldr_l	x3, .Linitdata_begin
+	tst	x3, #SWAPPER_BLOCK_SIZE - 1
+	b.eq	0f
+
+	/* First, create a table mapping to replace the block mapping */
+	ldr_l	x1, kimage_vaddr
+	bic	x2, x3, #SWAPPER_BLOCK_SIZE - 1
+	adrp	x4, init_pg_end - PAGE_SIZE
+	mov	x5, #PMD_TYPE_TABLE
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
+	/* Apply executable permissions to the first subregion */
+	adrp	x0, init_pg_end - PAGE_SIZE
+	ldr_l	x3, .Linitdata_begin
+	bic	x1, x3, #SWAPPER_BLOCK_SIZE - 1
+	mov	x2, x1
+	adrp	x4, __initdata_begin
+	bic	x4, x4, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RX_MMUFLAGS | PTE_TYPE_PAGE
+	mov	x6, #PAGE_SHIFT
+	bl	remap_region
+
+	/* Apply writable permissions to the second subregion */
+	ldr_l	x2, .Linitdata_begin
+	bic	x1, x2, #SWAPPER_BLOCK_SIZE - 1
+	add	x3, x1, #SWAPPER_BLOCK_SIZE
+	adrp	x4, __initdata_begin
+	mov	x5, SWAPPER_RW_MMUFLAGS | PTE_TYPE_PAGE
+	mov	x6, #PAGE_SHIFT
+	bl	remap_region
+#endif
+0:	dsb	ishst
+	ret	x28
+SYM_FUNC_END(remap_kernel_text)
+
+	__INITDATA
+	.align	3
+.Linitdata_begin:
+	.quad	__initdata_begin
+	.previous
+
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
 	 *
@@ -808,12 +868,17 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #endif
 	bl	clear_page_tables
 	bl	create_kernel_mapping
-
+#ifdef CONFIG_RELOCATABLE
 	adrp	x1, init_pg_dir
 	load_ttbr1 x1, x1, x2
-#ifdef CONFIG_RELOCATABLE
-	bl	__relocate_kernel
+	bl	__relocate_kernel		// preserves x0
+
+	__idmap_cpu_set_reserved_ttbr1 x1, x2
 #endif
+	bl	remap_kernel_text
+	adrp	x1, init_pg_dir
+	load_ttbr1 x1, x1, x2
+
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
 	br	x8
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 736aca63dad1..3830c6c66e46 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -310,7 +310,7 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	init_pg_dir = .;
-	. += INIT_DIR_SIZE;
+	. += INIT_DIR_SIZE + PAGE_SIZE;
 	init_pg_end = .;
 
 	. = ALIGN(SEGMENT_ALIGN);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 493b8ffc9be5..c237e976b138 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -168,17 +168,6 @@ SYM_FUNC_END(cpu_do_resume)
 
 	.pushsection ".idmap.text", "awx"
 
-.macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
-	adrp	\tmp1, reserved_pg_dir
-	phys_to_ttbr \tmp2, \tmp1
-	offset_ttbr1 \tmp2, \tmp1
-	msr	ttbr1_el1, \tmp2
-	isb
-	tlbi	vmalle1
-	dsb	nsh
-	isb
-.endm
-
 /*
  * void idmap_cpu_replace_ttbr1(phys_addr_t ttbr1)
  *
-- 
2.30.2

