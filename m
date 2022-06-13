Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A9C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245478AbiFMSbC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbiFMSas (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C8B7DC6
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57F49B8105D
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E253C341C0;
        Mon, 13 Jun 2022 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131618;
        bh=E2NfwwMf/mlkhPj0/Dm+COiDScQU3SGHYa/X8m18eYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4N9qiwFfoR62Ybu7y9csLyCKKSZH3LDFRn+r4JQ3hSD3m8dV11KTd51+eghMwh/O
         Eq+z/+tff4f26wkAQqbYso2GidBJkYL0YC0LIu8F4mry6+PXydwPZA8IvvScu5FDKr
         4Y3q8XChOdlZBf4zK5ik4CMy9F3qnMgV8MzTXwQXl5MFNIhldgCdgwBJgci0p8VJ7N
         ERyJb/0CNUJFOibPDX6asVqLc+zizx+I70GiQOIhXGhGUQSv5zbioSfVbuaJX5C/tT
         7tt5w9mGvM9imoHSOaGE7YGwOHQV+GnRd+sdt16hr40C8GXPkngxI2ZXtgDlahfJaF
         RHGJbSYZcVEag==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 22/26] arm64: mm: move ro_after_init section into the data segment
Date:   Mon, 13 Jun 2022 16:45:46 +0200
Message-Id: <20220613144550.3760857-23-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5175; h=from:subject; bh=E2NfwwMf/mlkhPj0/Dm+COiDScQU3SGHYa/X8m18eYE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02WLqn4rwEiXk3ewFAo3CfcRzxVyaG2WpgZTFy+ 8seXWiaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNlgAKCRDDTyI5ktmPJBJUC/ 9L3WpKh5i+ZvRIl6yH1JT4eqIWI8jmrXBewTgWLpOa0Cxtdyz0bkBabh6KNVIxaVLL1vxmdXYGIXNl x28T9EdIakKEZ4ZlQ4V4wDve+KRcW8GOP+tLMwRGAUWKYDhAjj/Ox46eM8J4VG5bEBVqSyOVZuRVCq F2NjYa/NKrFsmwrSw0lYgZ0lPQbaT6tacCsL77IYBa1nVNT6Q+waDPv5VbVWShRCyBkFK+dMzE08T6 ScVIjheOje+TROF9XBe+PD9jOrCXbbJF9JovohSomFoKqwXLZjYtc1JJmtK8lCArLKta0rtD8xcLrD GO01KcH/b2CcfVIl3uVpa2kL2tM7oXyOkMZb109oWPeRMCdlllh0qNvdRh9lcQFD/u0WjPdm8+F0aA 44/0vtBCx6Q+f4+CBMQhemoh5qxYAHG4kU33NV7eAYA3uK0ZKezYTq+RBLPMBlX2AiVR9NdE3+JpOX 08xME3mQcIi5NkKyPBWhctI2Og7vmsO+AbFeLD/ObDSl0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, the ro_after_init sections sits right in the middle of the
text/rodata/inittext segment, making it difficult to map any of those
non-writable during early boot. So instead, move it to the start of
.data, and update the init sequences so that the section is remapped
read-only once startup completes.

Note that this moves the entire HYP data section into .data as well -
this likely needs to remain as a single block for now, but could perhaps
split into a .rodata and .data..ro_after_init section later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 42 ++++++++++++--------
 arch/arm64/mm/mmu.c             | 29 ++++++++------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 45131e354e27..736aca63dad1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -59,6 +59,7 @@
 
 #define RO_EXCEPTION_TABLE_ALIGN	4
 #define RUNTIME_DISCARD_EXIT
+#define RO_AFTER_INIT_DATA
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -188,30 +189,13 @@ SECTIONS
 	/* everything from this point to __init_begin will be marked RO NX */
 	RO_DATA(PAGE_SIZE)
 
-	HYPERVISOR_DATA_SECTIONS
-
 	/* code sections that are never executed via the kernel mapping */
 	.rodata.text : {
 		TRAMP_TEXT
 		HIBERNATE_TEXT
 		KEXEC_TEXT
-		. = ALIGN(PAGE_SIZE);
 	}
 
-	idmap_pg_dir = .;
-	. += PAGE_SIZE;
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-	reserved_pg_dir = .;
-	. += PAGE_SIZE;
-
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -274,6 +258,30 @@ SECTIONS
 
 	_data = .;
 	_sdata = .;
+
+	__start_ro_after_init = .;
+	idmap_pg_dir = .;
+	. += PAGE_SIZE;
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
+	reserved_pg_dir = .;
+	. += PAGE_SIZE;
+
+	swapper_pg_dir = .;
+	. += PAGE_SIZE;
+
+	HYPERVISOR_DATA_SECTIONS
+
+	.data.ro_after_init : {
+		*(.data..ro_after_init)
+		JUMP_TABLE_DATA
+		. = ALIGN(SEGMENT_ALIGN);
+		__end_ro_after_init = .;
+	}
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 
 	/*
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9828ad826837..e9b074ffc768 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -495,11 +495,17 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
-	 * Remove the write permissions from the linear alias of .text/.rodata
+	 * Remove the write permissions from the linear alias of .text/.rodata/ro_after_init
 	 */
 	update_mapping_prot(__pa_symbol(_stext), (unsigned long)lm_alias(_stext),
 			    (unsigned long)__init_begin - (unsigned long)_stext,
 			    PAGE_KERNEL_RO);
+
+	update_mapping_prot(__pa_symbol(__start_ro_after_init),
+			    (unsigned long)lm_alias(__start_ro_after_init),
+			    (unsigned long)__end_ro_after_init -
+			    (unsigned long)__start_ro_after_init,
+			    PAGE_KERNEL_RO);
 }
 
 static bool crash_mem_map __initdata;
@@ -608,12 +614,10 @@ void mark_rodata_ro(void)
 {
 	unsigned long section_size;
 
-	/*
-	 * mark .rodata as read only. Use __init_begin rather than __end_rodata
-	 * to cover NOTES and EXCEPTION_TABLE.
-	 */
-	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
-	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
+	section_size = (unsigned long)__end_ro_after_init -
+		       (unsigned long)__start_ro_after_init;
+	update_mapping_prot(__pa_symbol(__start_ro_after_init),
+			    (unsigned long)__start_ro_after_init,
 			    section_size, PAGE_KERNEL_RO);
 
 	debug_checkwx();
@@ -733,18 +737,19 @@ static void __init map_kernel(pgd_t *pgdp)
 		text_prot = __pgprot_modify(text_prot, PTE_GP, PTE_GP);
 
 	/*
-	 * Only rodata will be remapped with different permissions later on,
-	 * all other segments are allowed to use contiguous mappings.
+	 * Only data will be partially remapped with different permissions
+	 * later on, all other segments are allowed to use contiguous mappings.
 	 */
 	map_kernel_segment(pgdp, _stext, _etext, text_prot, &vmlinux_text, 0,
 			   VM_NO_GUARD);
-	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
-			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
+	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL_RO,
+			   &vmlinux_rodata, 0, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
 			   &vmlinux_inittext, 0, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
 			   &vmlinux_initdata, 0, VM_NO_GUARD);
-	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
+	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data,
+			   NO_CONT_MAPPINGS | NO_BLOCK_MAPPINGS, 0);
 
 	if (!READ_ONCE(pgd_val(*pgd_offset_pgd(pgdp, FIXADDR_START)))) {
 		/*
-- 
2.30.2

