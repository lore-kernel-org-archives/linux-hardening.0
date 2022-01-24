Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC00DC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiAXRsP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbiAXRsP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9863C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACD7612FC
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC9C340E8;
        Mon, 24 Jan 2022 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046494;
        bh=IWrjbMTWtbV2vW1HSXLK21QpPiTl8d7SkHaWwNzmMSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmQ/07C0FVkg4AhjQQv/bpwk9IpBLDN/FkOm489QpZkkerE1pHVDsbymgXNthyJlQ
         8lyVf8tjt6r0AgC0n2oJj7rEzqjbnrY7sjtBaWoP3MS6rmPelb6MLPojRtHdY2Fi3G
         OV1EYL2SjtW49X4bDNqVMoH3nrD04lTsnW7SdtAsfDfegKSEN3C5nWiOad/l5vlSlC
         lA818ytKc6o/MJmNisiniikXEaqG1qroDvfgKjW0Dy5v6WfAM6RoT38A2phFKqjVJO
         ysi/Xv13uL/COzcpap0sZ7Yc+q6K8kT6QL6AAKcS9O7jaUBlB4AuidbgRGgNN15QcJ
         pQc3wrjeERqOw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 06/32] ARM: remove old-style irq entry
Date:   Mon, 24 Jan 2022 18:47:18 +0100
Message-Id: <20220124174744.1054712-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8430; i=ardb@kernel.org; h=from:subject; bh=3kl5/3H+g5iKvSKJA4TNx5q8FVxa+Bn//qGU0XUVr/s=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYNbceVqyuSi5Fi6wlBotOjqVgB3NV3jNdZktmS 0oeRqoSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mDQAKCRDDTyI5ktmPJD2eDA CbEyHCnxS9QIAQbSh8sg5OJjAPPAO1pKXyZW9CdyDyIm+88f74mTwYgaeOlabIyPiHfj5S84pEnQ6I tq8UQJPxkoWtM7rnrs4lcDMUxYrZ9fFAurnmF88cpvSUbQnIzk6ghnhb7dK/9vXx8oucP5GEx6NZz0 W8EX1jBtwDkiA6KKlbd62XCLGKBJ1M7RCJUXOGdmneVJlILgRUrBfm91wuDCbO6jDCLsJirBEziaoq dRhT2EsEv4UKtsJ5IhqfHnxABWzR0GFGbuamCCeYWGf5y6I5EX/fPqFDYoHxGGJdkONBNulqd4XvV0 2XZ7qYFzvRJBmzSL69GoLbZFV8owd74TNYM8wZgID+UUbhy6ZjAEbOpK/k4ShRqGn/dqSNslkPuPYC U0XU2ImfzD+zle5o/eTApNpno3zf0XqfVCdxokYIgyx7jJNSBojmAUo+av+frKm049yyhHBSPodolC M8E2sPtSuckYQaB1xckPXb7Mq8R2cJ8KY1PvIJea2Xo+E=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The last user of arch_irq_handler_default is gone now, so the
entry-macro-multi.S file and all references to mach/entry-macro.S can
be removed, as well as the asm_do_IRQ() entrypoint into the interrupt
handling routines implemented in C.

Note: The ARMv7-M entry still uses its own top-level IRQ entry, calling
nvic_handle_irq() from assembly. This could be changed to go through
generic_handle_arch_irq() as well, but it's unclear to me if there are
any benefits.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ardb: keep irq_handler macro as it will carry the IRQ stack handling]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                         | 12 +-----
 arch/arm/include/asm/entry-macro-multi.S | 40 --------------------
 arch/arm/include/asm/irq.h               |  1 -
 arch/arm/include/asm/mach/arch.h         |  2 -
 arch/arm/include/asm/smp.h               |  5 ---
 arch/arm/kernel/entry-armv.S             |  8 ----
 arch/arm/kernel/irq.c                    | 17 ---------
 arch/arm/kernel/smp.c                    |  5 ---
 8 files changed, 1 insertion(+), 89 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ac2f88ce0b9a..7528cbdb90a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -58,6 +58,7 @@ config ARM
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_MULTI_HANDLER if MMU
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
@@ -319,7 +320,6 @@ config ARCH_MULTIPLATFORM
 	select AUTO_ZRELADDR
 	select TIMER_OF
 	select COMMON_CLK
-	select GENERIC_IRQ_MULTI_HANDLER
 	select HAVE_PCI
 	select PCI_DOMAINS_GENERIC if PCI
 	select SPARSE_IRQ
@@ -343,7 +343,6 @@ config ARCH_EP93XX
 	select ARM_AMBA
 	imply ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
-	select GENERIC_IRQ_MULTI_HANDLER
 	select AUTO_ZRELADDR
 	select CLKSRC_MMIO
 	select CPU_ARM920T
@@ -358,7 +357,6 @@ config ARCH_FOOTBRIDGE
 	select FOOTBRIDGE
 	select NEED_MACH_IO_H if !MMU
 	select NEED_MACH_MEMORY_H
-	select GENERIC_IRQ_MULTI_HANDLER
 	help
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
@@ -367,7 +365,6 @@ config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
 	select CPU_XSCALE
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_IOP
 	select GPIOLIB
 	select FORCE_PCI
@@ -383,7 +380,6 @@ config ARCH_IXP4XX
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CPU_XSCALE
 	select DMABOUNCE if PCI
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_IXP4XX
 	select GPIOLIB
 	select HAVE_PCI
@@ -399,7 +395,6 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_PJ4
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_PCI
 	select MVEBU_MBUS
@@ -422,7 +417,6 @@ config ARCH_PXA
 	select CLKSRC_MMIO
 	select TIMER_OF
 	select CPU_XSCALE if !CPU_XSC3
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_PXA
 	select GPIOLIB
 	select IRQ_DOMAIN
@@ -441,7 +435,6 @@ config ARCH_RPC
 	select ARM_HAS_SG_CHAIN
 	select CPU_SA110
 	select FIQ
-	select GENERIC_IRQ_MULTI_HANDLER
 	select HAVE_PATA_PLATFORM
 	select ISA_DMA_API
 	select LEGACY_TIMER_TICK
@@ -462,7 +455,6 @@ config ARCH_SA1100
 	select COMMON_CLK
 	select CPU_FREQ
 	select CPU_SA1100
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select IRQ_DOMAIN
 	select ISA
@@ -477,7 +469,6 @@ config ARCH_S3C24XX
 	select CLKSRC_SAMSUNG_PWM
 	select GPIO_SAMSUNG
 	select GPIOLIB
-	select GENERIC_IRQ_MULTI_HANDLER
 	select NEED_MACH_IO_H
 	select S3C2410_WATCHDOG
 	select SAMSUNG_ATAGS
@@ -495,7 +486,6 @@ config ARCH_OMAP1
 	select ARCH_OMAP
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_LEGACY_CLK
 	select IRQ_DOMAIN
diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
deleted file mode 100644
index dfc6bfa43012..000000000000
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/assembler.h>
-
-/*
- * Interrupt handling.  Preserves r7, r8, r9
- */
-	.macro	arch_irq_handler_default
-	get_irqnr_preamble r6, lr
-1:	get_irqnr_and_base r0, r2, r6, lr
-	movne	r1, sp
-	@
-	@ routine called with r0 = irq number, r1 = struct pt_regs *
-	@
-	badrne	lr, 1b
-	bne	asm_do_IRQ
-
-#ifdef CONFIG_SMP
-	/*
-	 * XXX
-	 *
-	 * this macro assumes that irqstat (r2) and base (r6) are
-	 * preserved from get_irqnr_and_base above
-	 */
-	ALT_SMP(test_for_ipi r0, r2, r6, lr)
-	ALT_UP_B(9997f)
-	movne	r1, sp
-	badrne	lr, 1b
-	bne	do_IPI
-#endif
-9997:
-	.endm
-
-	.macro	arch_irq_handler, symbol_name
-	.align	5
-	.global \symbol_name
-\symbol_name:
-	mov	r8, lr
-	arch_irq_handler_default
-	ret	r8
-	.endm
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 1cbcc462b07e..a7c2337b0c7d 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -26,7 +26,6 @@
 struct irqaction;
 struct pt_regs;
 
-extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index eec0c0bda766..9349e7a82c9c 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -56,9 +56,7 @@ struct machine_desc {
 	void			(*init_time)(void);
 	void			(*init_machine)(void);
 	void			(*init_late)(void);
-#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	void			(*handle_irq)(struct pt_regs *);
-#endif
 	void			(*restart)(enum reboot_mode, const char *);
 };
 
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index f16cbbd5cda4..7c1c90d9f582 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -24,11 +24,6 @@ struct seq_file;
  */
 extern void show_ipi_list(struct seq_file *, int);
 
-/*
- * Called from assembly code, this handles an IPI.
- */
-asmlinkage void do_IPI(int ipinr, struct pt_regs *regs);
-
 /*
  * Called from C code, this handles an IPI.
  */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 5cd057859fe9..9d9372781408 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -19,9 +19,6 @@
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/vfpmacros.h>
-#ifndef CONFIG_GENERIC_IRQ_MULTI_HANDLER
-#include <mach/entry-macro.S>
-#endif
 #include <asm/thread_notify.h>
 #include <asm/unwind.h>
 #include <asm/unistd.h>
@@ -30,19 +27,14 @@
 #include <asm/uaccess-asm.h>
 
 #include "entry-header.S"
-#include <asm/entry-macro-multi.S>
 #include <asm/probes.h>
 
 /*
  * Interrupt handling.
  */
 	.macro	irq_handler
-#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	mov	r0, sp
 	bl	generic_handle_arch_irq
-#else
-	arch_irq_handler_default
-#endif
 	.endm
 
 	.macro	pabt_helper
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index b79975bd988c..5a1e52a4ee11 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -80,23 +80,6 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 		ack_bad_irq(irq);
 }
 
-/*
- * asm_do_IRQ is the interface to be used from assembly code.
- */
-asmlinkage void __exception_irq_entry
-asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-
-	irq_enter();
-	old_regs = set_irq_regs(regs);
-
-	handle_IRQ(irq, regs);
-
-	set_irq_regs(old_regs);
-	irq_exit();
-}
-
 void __init init_IRQ(void)
 {
 	int ret;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 97ee6b1567e9..ed2b168ff46c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -628,11 +628,6 @@ static void ipi_complete(unsigned int cpu)
 /*
  * Main handler for inter-processor interrupts
  */
-asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
-{
-	handle_IPI(ipinr, regs);
-}
-
 static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.30.2

