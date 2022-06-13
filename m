Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42147CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbiFMSay (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiFMSai (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD1B7162
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74D5FB8105C
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBEC341C4;
        Mon, 13 Jun 2022 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131613;
        bh=IPA+kiwvV+1I+qUanmD8732ycgrDexqF5Q7Ns+HEYT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgKnvfuU6NoIVaf3nKaUii7KMWe50plGp89lTyOkup9mhop3E0+1dRZ5a5YA1ee48
         AqueSHIbr78dTJW4rKIeXjQYcCYTLKGknsowBT0lxuLzw/Mpxn3nr3EJEtowdvCwSI
         pP2VohjW4rdzLQDz41ccqNFzOrIH9ghVg9syOP/UoJOXfD8WONhjRh19a4vQ4oE0AT
         Hruv0K/s9LAsgqfR90iEc+M8o9MXz/l+3I4lqRAdzlkncr9dafaAv4JXqJTVyP8J6w
         JQOBFJARbHqP7wq2oEsXXkP8nXILl9j94GR1XECamdXhzxf+j/7bSyFdF8iYxwHdCA
         W+tHts0l7mvdQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 20/26] arm64: head: avoid relocating the kernel twice for KASLR
Date:   Mon, 13 Jun 2022 16:45:44 +0200
Message-Id: <20220613144550.3760857-21-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15594; h=from:subject; bh=IPA+kiwvV+1I+qUanmD8732ycgrDexqF5Q7Ns+HEYT4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02TdJ+584dBuED8K4beqoDv65Y4qExzfsMOsf2P zP/pNwOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNkwAKCRDDTyI5ktmPJJfrDA Cc8ofRgbC0DJOnOK04D2eF9wZKeh9Q12AL/dYObktTTHz439wj75Mi8z/e1mXOo8/pVgeYjPQu7+bw cPkLJRrmr0XVRuAhrGiJHDwMwk/TSB8DQduOk73M9AIG5cNSI7s1DI1ADrAUGjt3Uhw2y38uGqeK35 EuwZq/WC7jtDlxdkuUU8v17OZvanPlqBs4AumhrOybfEAn6iopBS3k1cEJ8zIC+Zlp9shcZAOgdBtE TAZiDhweTQbFuE+uXtcZtjiSeua8M+xcICW1E/oqnlJtyMqz3nUht3OPWlq7PSKrs4eibat85OoWAi 5jfcsnc/ukHFS8YIWsKT1oq0xCgewBpWQ0QYo2RLdCLU3q2QXQ12ckbr4r89MefVHKhcR7oyBk32m0 Aj2ZbjmqRLt66Bq9M/0YxrgjCXuhsY7tZqHoYFDGNDzPbaUutMJq8PlVAi6RciO0n0zJqTA4ztHhtc TGcY8IY/XPSUx3QF2I7Yy6Y6HD8fh4y5GLvcRjZlcCsHs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, when KASLR is in effect, we set up the kernel virtual address
space twice: the first time, the KASLR seed is looked up in the device
tree, and the kernel virtual mapping is torn down and recreated again,
after which the relocations are applied a second time. The latter step
means that statically initialized global pointer variables will be reset
to their initial values, and to ensure that BSS variables are not set to
values based on the initial translation, they are cleared again as well.

All of this is needed because we need the command line (taken from the
DT) to tell us whether or not to randomize the virtual address space
before entering the kernel proper. However, this code has expanded
little by little and now creates global state unrelated to the virtual
randomization of the kernel before the mapping is torn down and set up
again, and the BSS cleared for a second time. This has created some
issues in the past, and it would be better to avoid this little dance if
possible.

So instead, let's use the temporary mapping of the device tree, and
execute the bare minimum of code to decide whether or not KASLR should
be enabled, and what the seed is. Only then, create the virtual kernel
mapping, clear BSS, etc and proceed as normal.  This avoids the issues
around inconsistent global state due to BSS being cleared twice, and is
generally more maintainable, as it permits us to defer all the remaining
DT parsing and KASLR initialization to a later time.

This means the relocation fixup code runs only a single time as well,
allowing us to simplify the RELR handling code too, which is not
idempotent and was therefore required to keep track of the offset that
was applied the first time around.

Note that this means we have to clone a pair of FDT library objects, so
that we can control how they are built - we need the stack protector
and other instrumentation disabled so that the code can tolerate being
called this early. Note that only the kernel page tables and the
temporary stack are mapped read-write at this point, which ensures that
the early code does not modify any global state inadvertently.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/head.S           |  73 ++++---------
 arch/arm64/kernel/image-vars.h     |   4 +
 arch/arm64/kernel/kaslr.c          |  87 ---------------
 arch/arm64/kernel/pi/Makefile      |  33 ++++++
 arch/arm64/kernel/pi/kaslr_early.c | 112 ++++++++++++++++++++
 6 files changed, 171 insertions(+), 140 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fa7981d0d917..88a96511580e 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_ACPI)			+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
-obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o pi/
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 8de346dd4470..5a2ff6466b6b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -86,15 +86,13 @@
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
-	 *  x24        __primary_switch() .. relocate_kernel()  current RELR displacement
+	 *  x24        __primary_switch()                       linear map KASLR seed
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
-	adrp	x23, __PHYS_OFFSET
-	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	create_idmap
 
 	/*
@@ -441,6 +439,10 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+#ifdef CONFIG_RANDOMIZE_BASE
+	adrp	x5, memstart_offset_seed	// Save KASLR linear map seed
+	strh	w24, [x5, :lo12:memstart_offset_seed]
+#endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
@@ -448,16 +450,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	early_fdt_map			// Try mapping the FDT early
 	mov	x0, x22				// pass FDT address in x0
 	bl	init_feature_override		// Parse cpu feature overrides
-#ifdef CONFIG_RANDOMIZE_BASE
-	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
-	b.ne	0f
-	bl	kaslr_early_init		// parse FDT for KASLR options
-	cbz	x0, 0f				// KASLR disabled? just proceed
-	orr	x23, x23, x0			// record KASLR offset
-	ldp	x29, x30, [sp], #16		// we must enable KASLR, return
-	ret					// to __primary_switch()
-0:
-#endif
 	mov	x0, x20
 	bl	switch_to_vhe			// Prefer VHE if possible
 	ldp	x29, x30, [sp], #16
@@ -759,27 +751,17 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 * entry in x9, the address being relocated by the current address or
 	 * bitmap entry in x13 and the address being relocated by the current
 	 * bit in x14.
-	 *
-	 * Because addends are stored in place in the binary, RELR relocations
-	 * cannot be applied idempotently. We use x24 to keep track of the
-	 * currently applied displacement so that we can correctly relocate if
-	 * __relocate_kernel is called twice with non-zero displacements (i.e.
-	 * if there is both a physical misalignment and a KASLR displacement).
 	 */
 	adr_l	x9, __relr_start
 	adr_l	x10, __relr_end
 
-	sub	x15, x23, x24			// delta from previous offset
-	cbz	x15, 7f				// nothing to do if unchanged
-	mov	x24, x23			// save new offset
-
 2:	cmp	x9, x10
 	b.hs	7f
 	ldr	x11, [x9], #8
 	tbnz	x11, #0, 3f			// branch to handle bitmaps
 	add	x13, x11, x23
 	ldr	x12, [x13]			// relocate address entry
-	add	x12, x12, x15
+	add	x12, x12, x23
 	str	x12, [x13], #8			// adjust to start of bitmap
 	b	2b
 
@@ -788,7 +770,7 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	cbz	x11, 6f
 	tbz	x11, #0, 5f			// skip bit if not set
 	ldr	x12, [x14]			// relocate bit
-	add	x12, x12, x15
+	add	x12, x12, x23
 	str	x12, [x14]
 
 5:	add	x14, x14, #8			// move to next bit's address
@@ -812,40 +794,27 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
-
+#ifdef CONFIG_RELOCATABLE
+	adrp	x23, __PHYS_OFFSET
+	and	x23, x23, MIN_KIMG_ALIGN - 1
+#ifdef CONFIG_RANDOMIZE_BASE
+	mov	x0, x22
+	adrp	x1, init_pg_end
+	mov	sp, x1
+	mov	x29, xzr
+	bl	__pi_kaslr_early_init
+	and	x24, x0, #SZ_2M - 1		// capture memstart offset seed
+	bic	x0, x0, #SZ_2M - 1
+	orr	x23, x23, x0			// record kernel offset
+#endif
+#endif
 	bl	clear_page_tables
 	bl	create_kernel_mapping
 
 	adrp	x1, init_pg_dir
 	load_ttbr1 x1, x1, x2
 #ifdef CONFIG_RELOCATABLE
-#ifdef CONFIG_RELR
-	mov	x24, #0				// no RELR displacement yet
-#endif
 	bl	__relocate_kernel
-#ifdef CONFIG_RANDOMIZE_BASE
-	ldr	x8, =__primary_switched
-	adrp	x0, __PHYS_OFFSET
-	blr	x8
-
-	/*
-	 * If we return here, we have a KASLR displacement in x23 which we need
-	 * to take into account by discarding the current kernel mapping and
-	 * creating a new one.
-	 */
-	adrp	x1, reserved_pg_dir		// Disable translations via TTBR1
-	load_ttbr1 x1, x1, x2
-	bl	clear_page_tables
-	bl	create_kernel_mapping		// Recreate kernel mapping
-
-	tlbi	vmalle1				// Remove any stale TLB entries
-	dsb	nsh
-	isb
-
-	adrp	x1, init_pg_dir			// Re-enable translations via TTBR1
-	load_ttbr1 x1, x1, x2
-	bl	__relocate_kernel
-#endif
 #endif
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 241c86b67d01..0c381a405bf0 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -41,6 +41,10 @@ __efistub_dcache_clean_poc = __pi_dcache_clean_poc;
 __efistub___memcpy		= __pi_memcpy;
 __efistub___memmove		= __pi_memmove;
 __efistub___memset		= __pi_memset;
+
+__pi___memcpy			= __pi_memcpy;
+__pi___memmove			= __pi_memmove;
+__pi___memset			= __pi_memset;
 #endif
 
 __efistub__text			= _text;
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index af9ffe4d0f0f..06515afce692 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -23,95 +23,8 @@
 u64 __ro_after_init module_alloc_base;
 u16 __initdata memstart_offset_seed;
 
-static __init u64 get_kaslr_seed(void *fdt)
-{
-	int node, len;
-	fdt64_t *prop;
-	u64 ret;
-
-	node = fdt_path_offset(fdt, "/chosen");
-	if (node < 0)
-		return 0;
-
-	prop = fdt_getprop_w(fdt, node, "kaslr-seed", &len);
-	if (!prop || len != sizeof(u64))
-		return 0;
-
-	ret = fdt64_to_cpu(*prop);
-	*prop = 0;
-	return ret;
-}
-
 struct arm64_ftr_override kaslr_feature_override __initdata;
 
-/*
- * This routine will be executed with the kernel mapped at its default virtual
- * address, and if it returns successfully, the kernel will be remapped, and
- * start_kernel() will be executed from a randomized virtual offset. The
- * relocation will result in all absolute references (e.g., static variables
- * containing function pointers) to be reinitialized, and zero-initialized
- * .bss variables will be reset to 0.
- */
-u64 __init kaslr_early_init(void)
-{
-	void *fdt;
-	u64 seed, offset, mask;
-	unsigned long raw;
-
-	/*
-	 * Try to map the FDT early. If this fails, we simply bail,
-	 * and proceed with KASLR disabled. We will make another
-	 * attempt at mapping the FDT in setup_machine()
-	 */
-	fdt = get_early_fdt_ptr();
-	if (!fdt) {
-		return 0;
-	}
-
-	/*
-	 * Retrieve (and wipe) the seed from the FDT
-	 */
-	seed = get_kaslr_seed(fdt);
-
-	/*
-	 * Check if 'nokaslr' appears on the command line, and
-	 * return 0 if that is the case.
-	 */
-	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
-		return 0;
-	}
-
-	/*
-	 * Mix in any entropy obtainable architecturally if enabled
-	 * and supported.
-	 */
-
-	if (arch_get_random_seed_long_early(&raw))
-		seed ^= raw;
-
-	if (!seed) {
-		return 0;
-	}
-
-	/*
-	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
-	 * kernel image offset from the seed. Let's place the kernel in the
-	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
-	 * the lower and upper quarters to avoid colliding with other
-	 * allocations.
-	 * Even if we could randomize at page granularity for 16k and 64k pages,
-	 * let's always round to 2 MB so we don't interfere with the ability to
-	 * map using contiguous PTEs
-	 */
-	mask = ((1UL << (VA_BITS_MIN - 2)) - 1) & ~(SZ_2M - 1);
-	offset = BIT(VA_BITS_MIN - 3) + (seed & mask);
-
-	/* use the top 16 bits to randomize the linear region */
-	memstart_offset_seed = seed >> 48;
-
-	return offset;
-}
-
 static int __init kaslr_init(void)
 {
 	u64 module_range;
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
new file mode 100644
index 000000000000..839291430cb3
--- /dev/null
+++ b/arch/arm64/kernel/pi/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2022 Google LLC
+
+KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   $(call cc-option,-mbranch-protection=none) \
+		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
+		   -include $(srctree)/include/linux/hidden.h \
+		   -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
+		   $(call cc-option,-fno-addrsig)
+
+# remove SCS flags from all objects in this directory
+KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
+
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
+
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
+			       --remove-section=.note.gnu.property \
+			       --prefix-alloc-sections=.init
+$(obj)/%.pi.o: $(obj)/%.o FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+obj-y		:= kaslr_early.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
new file mode 100644
index 000000000000..6c3855e69395
--- /dev/null
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2022 Google LLC
+// Author: Ard Biesheuvel <ardb@google.com>
+
+// NOTE: code in this file runs *very* early, and is not permitted to use
+// global variables or anything that relies on absolute addressing.
+
+#include <linux/libfdt.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include <asm/archrandom.h>
+#include <asm/memory.h>
+
+/* taken from lib/string.c */
+static char *__strstr(const char *s1, const char *s2)
+{
+	size_t l1, l2;
+
+	l2 = strlen(s2);
+	if (!l2)
+		return (char *)s1;
+	l1 = strlen(s1);
+	while (l1 >= l2) {
+		l1--;
+		if (!memcmp(s1, s2, l2))
+			return (char *)s1;
+		s1++;
+	}
+	return NULL;
+}
+static bool cmdline_contains_nokaslr(const u8 *cmdline)
+{
+	const u8 *str;
+
+	str = __strstr(cmdline, "nokaslr");
+	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
+}
+
+static bool is_kaslr_disabled_cmdline(void *fdt)
+{
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		int node;
+		const u8 *prop;
+
+		node = fdt_path_offset(fdt, "/chosen");
+		if (node < 0)
+			goto out;
+
+		prop = fdt_getprop(fdt, node, "bootargs", NULL);
+		if (!prop)
+			goto out;
+
+		if (cmdline_contains_nokaslr(prop))
+			return true;
+
+		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+			goto out;
+
+		return false;
+	}
+out:
+	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
+}
+
+static u64 get_kaslr_seed(void *fdt)
+{
+	int node, len;
+	fdt64_t *prop;
+	u64 ret;
+
+	node = fdt_path_offset(fdt, "/chosen");
+	if (node < 0)
+		return 0;
+
+	prop = fdt_getprop_w(fdt, node, "kaslr-seed", &len);
+	if (!prop || len != sizeof(u64))
+		return 0;
+
+	ret = fdt64_to_cpu(*prop);
+	*prop = 0;
+	return ret;
+}
+
+asmlinkage u64 kaslr_early_init(void *fdt)
+{
+	u64 seed;
+
+	if (is_kaslr_disabled_cmdline(fdt))
+		return 0;
+
+	seed = get_kaslr_seed(fdt);
+	if (!seed) {
+#ifdef CONFIG_ARCH_RANDOM
+		 if (!__early_cpu_has_rndr() ||
+		     !__arm64_rndr((unsigned long *)&seed))
+#endif
+		return 0;
+	}
+
+	/*
+	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
+	 * kernel image offset from the seed. Let's place the kernel in the
+	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
+	 * the lower and upper quarters to avoid colliding with other
+	 * allocations.
+	 */
+	return BIT(VA_BITS_MIN - 3) + (seed & GENMASK(VA_BITS_MIN - 3, 0));
+}
-- 
2.30.2

