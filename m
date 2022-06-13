Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F7CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbiFMSal (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245431AbiFMSa1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A644B7DDD
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0582C61408
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667E4C385A2;
        Mon, 13 Jun 2022 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131625;
        bh=GLTQOvO8ALumUHjKduRBAh0lrNOPTYfIFhWJqoX+RMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFS5m2Yv8jnT5fAWiK0jIe+TcVJO1UhWaYERVOn+Ij3CJJoXj1gxczV9V0H1nXszt
         8SD/jV8Ehwzl6iHk0kI1aznZQhYSQ8Lqh4BI3LEWJlLAndV8enErzivAElNjRG4+HN
         gnzIVt1POb+O8BUGbjFbClaNfg8exM67nxQpq6rQsMnJ0kEG/OX61xqFdByzc71Scv
         N4oReyZeBKSHw1JttXA9lVz1v7XbjHNa91+Vnil3DUSfHbkp7E5MnRYQE4L9oEgtn/
         9tK0xBZTb/EpztgdtI2Az2+61sNnlTRN9HlaZ2rDrXUZHOzkFf0GOqXXUyZiGapF2Z
         QlKekMATaOAkw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 25/26] arm64: mm: add support for WXN memory translation attribute
Date:   Mon, 13 Jun 2022 16:45:49 +0200
Message-Id: <20220613144550.3760857-26-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9476; h=from:subject; bh=GLTQOvO8ALumUHjKduRBAh0lrNOPTYfIFhWJqoX+RMA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02bIio5aiPiiJurKkQYLTVrh0lfOtEatrfPKGvb 1XK6c6qJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNmwAKCRDDTyI5ktmPJEymC/ 9rVBAXTP9o2W/s5LIR+W2q2KcZPlWpCJ/pwox/057EbwYRBid8OGGbaLxWgi1DGHOMIiUnBr4FE5Qx E+6yd10fxuvhWBqk6xiXB4hhnDnxhNQCbnCcc6YigNQ0s0K0B/NDCNVeHEkXhJ7NelPH+Mm6goyjH9 UVJbEVs6qR9I57Od8c9ApA4CCXeP44ETevzNPedCcBIbW7pbs+7mRgI4OyRSEO7DbzYjI9oZUDY/So MIhzGcRN38xEsUPXdJnFrgymX89U4U9wqOGkmxw45ouzUq16hiu36gh3N80oUh0RIF3zXLk6UNDKHK 4kyIVp8GjOzf8vtQfOsADanNAo9PsAx9S1hyxRjZPB5+lEk4NqOWgxkPAlQdYAEuXNTgTyrjKnY28b Yy1Uv5/pS7rKI69u2L6PsTX8LAC0pv5ds5lx/Ln8me4dwG++qHPZPqi0UR1D7mJuRn0ayJVtypbPvm cJ8vZ5qoXvt/Pu2UOVqnQ5NpCYh1jTZ3yNIWWYaZ4XKTM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The AArch64 virtual memory system supports a global WXN control, which
can be enabled to make all writable mappings implicitly no-exec. This is
a useful hardening feature, as it prevents mistakes in managing page
table permissions from being exploited to attack the system.

When enabled at EL1, the restrictions apply to both EL1 and EL0. EL1 is
completely under our control, and has been cleaned up to allow WXN to be
enabled from boot onwards. EL0 is not under our control, but given that
widely deployed security features such as selinux or PaX already limit
the ability of user space to create mappings that are writable and
executable at the same time, the impact of enabling this for EL0 is
expected to be limited. (For this reason, common user space libraries
that have a legitimate need for manipulating executable code already
carry fallbacks such as [0].)

If enabled at compile time, the feature can still be disabled at boot if
needed, by passing arm64.nowxn on the kernel command line.

[0] https://github.com/libffi/libffi/blob/master/src/closures.c#L440

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig                   | 11 ++++++
 arch/arm64/include/asm/cpufeature.h  |  8 +++++
 arch/arm64/include/asm/mman.h        | 36 ++++++++++++++++++++
 arch/arm64/include/asm/mmu_context.h | 30 +++++++++++++++-
 arch/arm64/kernel/head.S             | 28 ++++++++++++++-
 arch/arm64/kernel/idreg-override.c   | 16 +++++++++
 arch/arm64/mm/proc.S                 |  6 ++++
 7 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..d262d5ab4316 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1422,6 +1422,17 @@ config RODATA_FULL_DEFAULT_ENABLED
 	  This requires the linear region to be mapped down to pages,
 	  which may adversely affect performance in some cases.
 
+config ARM64_WXN
+	bool "Enable WXN attribute so all writable mappings are non-exec"
+	help
+	  Set the WXN bit in the SCTLR system register so that all writable
+	  mappings are treated as if the PXN/UXN bit is set as well.
+	  If this is set to Y, it can still be disabled at runtime by
+	  passing 'arm64.nowxn' on the kernel command line.
+
+	  This should only be set if no software needs to be supported that
+	  relies on being able to execute from writable mappings.
+
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	help
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 14a8f3d93add..fc364c4d31e2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -911,10 +911,18 @@ extern struct arm64_ftr_override id_aa64mmfr1_override;
 extern struct arm64_ftr_override id_aa64pfr1_override;
 extern struct arm64_ftr_override id_aa64isar1_override;
 extern struct arm64_ftr_override id_aa64isar2_override;
+extern struct arm64_ftr_override sctlr_override;
 
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
 
+static inline bool arm64_wxn_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_ARM64_WXN))
+		return false;
+	return (sctlr_override.val & sctlr_override.mask & 0xf) == 0;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..6d4940342ba7 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -35,11 +35,40 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 }
 #define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
 
+static inline bool arm64_check_wx_prot(unsigned long prot,
+				       struct task_struct *tsk)
+{
+	/*
+	 * When we are running with SCTLR_ELx.WXN==1, writable mappings are
+	 * implicitly non-executable. This means we should reject such mappings
+	 * when user space attempts to create them using mmap() or mprotect().
+	 */
+	if (arm64_wxn_enabled() &&
+	    ((prot & (PROT_WRITE | PROT_EXEC)) == (PROT_WRITE | PROT_EXEC))) {
+		/*
+		 * User space libraries such as libffi carry elaborate
+		 * heuristics to decide whether it is worth it to even attempt
+		 * to create writable executable mappings, as PaX or selinux
+		 * enabled systems will outright reject it. They will usually
+		 * fall back to something else (e.g., two separate shared
+		 * mmap()s of a temporary file) on failure.
+		 */
+		pr_info_ratelimited(
+			"process %s (%d) attempted to create PROT_WRITE+PROT_EXEC mapping\n",
+			tsk->comm, tsk->pid);
+		return false;
+	}
+	return true;
+}
+
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
 {
 	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
 
+	if (!arm64_check_wx_prot(prot, current))
+		return false;
+
 	if (system_supports_bti())
 		supported |= PROT_BTI;
 
@@ -50,6 +79,13 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
 
+static inline bool arch_validate_mmap_prot(unsigned long prot,
+					   unsigned long addr)
+{
+	return arm64_check_wx_prot(prot, current);
+}
+#define arch_validate_mmap_prot arch_validate_mmap_prot
+
 static inline bool arch_validate_flags(unsigned long vm_flags)
 {
 	if (!system_supports_mte())
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c7ccd82db1d2..cd4bb5410a18 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -19,13 +19,41 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
 extern bool rodata_full;
 
+static inline int arch_dup_mmap(struct mm_struct *oldmm,
+				struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	if (IS_ENABLED(CONFIG_ARM64_WXN) && execute &&
+	    (vma->vm_flags & (VM_WRITE | VM_EXEC)) == (VM_WRITE | VM_EXEC)) {
+		pr_warn_ratelimited(
+			"process %s (%d) attempted to execute from writable memory\n",
+			current->comm, current->pid);
+		/* disallow unless the nowxn override is set */
+		return !arm64_wxn_enabled();
+	}
+	return true;
+}
+
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
 	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 92cbad41eed8..834afdc1c6ff 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -511,6 +511,12 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	mov	x0, x20
 	bl	switch_to_vhe			// Prefer VHE if possible
 	ldp	x29, x30, [sp], #16
+#ifdef CONFIG_ARM64_WXN
+	ldr_l	x1, sctlr_override + FTR_OVR_VAL_OFFSET
+	tbz	x1, #0, 0f
+	blr	lr
+0:
+#endif
 	bl	start_kernel
 	ASM_BUG()
 SYM_FUNC_END(__primary_switched)
@@ -881,5 +887,25 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
-	br	x8
+	blr	x8
+#ifdef CONFIG_ARM64_WXN
+	/*
+	 * If we return here, we need to disable WXN before we proceed. This
+	 * requires the MMU to be disabled, so it needs to occur while running
+	 * from the ID map.
+	 */
+	mrs	x0, sctlr_el1
+	bic	x1, x0, #SCTLR_ELx_M
+	msr	sctlr_el1, x1
+	isb
+
+	tlbi	vmalle1
+	dsb	nsh
+	isb
+
+	bic	x0, x0, #SCTLR_ELx_WXN
+	msr	sctlr_el1, x0
+	isb
+	ret
+#endif
 SYM_FUNC_END(__primary_switch)
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index f92836e196e5..85d8fa47d196 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -94,12 +94,27 @@ static const struct ftr_set_desc kaslr __initconst = {
 	},
 };
 
+#ifdef CONFIG_ARM64_WXN
+asmlinkage struct arm64_ftr_override sctlr_override __ro_after_init;
+static const struct ftr_set_desc sctlr __initconst = {
+	.name		= "sctlr",
+	.override	= &sctlr_override,
+	.fields		= {
+		{ "nowxn", 0 },
+		{}
+	},
+};
+#endif
+
 static const struct ftr_set_desc * const regs[] __initconst = {
 	&mmfr1,
 	&pfr1,
 	&isar1,
 	&isar2,
 	&kaslr,
+#ifdef CONFIG_ARM64_WXN
+	&sctlr,
+#endif
 };
 
 static const struct {
@@ -115,6 +130,7 @@ static const struct {
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"kaslr.disabled=1" },
+	{ "arm64.nowxn",		"sctlr.nowxn=1" },
 };
 
 static int __init find_field(const char *cmdline,
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c237e976b138..9ffdf1091d97 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -487,6 +487,12 @@ SYM_FUNC_START(__cpu_setup)
 	 * Prepare SCTLR
 	 */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_ON
+#ifdef CONFIG_ARM64_WXN
+	ldr_l	x1, sctlr_override + FTR_OVR_VAL_OFFSET
+	tst	x1, #0x1			// WXN disabled on command line?
+	orr	x1, x0, #SCTLR_ELx_WXN
+	csel	x0, x0, x1, ne
+#endif
 	ret					// return to head.S
 
 	.unreq	mair
-- 
2.30.2

