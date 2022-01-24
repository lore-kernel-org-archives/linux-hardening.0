Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF0C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiAXRsO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43186 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbiAXRsM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D8A61301
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DEC340EA;
        Mon, 24 Jan 2022 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046490;
        bh=n1eJJ4h5kOscCZLHFbapcGr7Nu8+OUcDuVRcwnRmu9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4EcbP2uWhgUFd7ZWqsyQ1E65yeZzP44sjgl/yulXKXIleScq/buCaA/YytbVEMF+
         7CK5Z04QHL1GAVl8iM1Tse5GPbm9otwoZZu8FBNPNHE6mOMDi1TfW6NQJTgB2Jc6ag
         NVYBwwkQkCCMK128cv1HqPRoJ9iBUGEE054lZbqOBCN7SKpyXb1hWsFXEFUCD7d/9A
         mnSiR58rqNuaJ+ZiovQJkWjipJz/oxY8gkypU4pxUAAPgbmgSPdJ1DH7O/dd0xP9Yd
         jiBgX1K0YIi4TB0rUdoITI4TTVa531T9m0iT6t6OuERV23Q3mf6E3izT261pKLfho4
         n1YsQ45JqRuJQ==
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
Subject: [PATCH v5 05/32] ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER
Date:   Mon, 24 Jan 2022 18:47:17 +0100
Message-Id: <20220124174744.1054712-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6739; i=ardb@kernel.org; h=from:subject; bh=0u2xOg6wEXf72p6oUm4/55dvuXn004dvI5pPJqhcG+M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYLPXmptE87nyCCtDjIvjbkji/yK6wvaHIvcKEx /XUyjUmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mCwAKCRDDTyI5ktmPJBmjC/ 4jhXpVJV+rOHgknzpEXiOQavsgM1U/nwn+f1DB5iJFDF+IHIaWTljW4IMRwO59tthJoyibmDGNCAOU BOZ+hPvv4FyuZiBh+SS2ih3vkeLKsjS163gFZ7BwWaelWaF7tvR2OVBUnaSH/OlL9bIYkeGmKq61t8 yxU/djMV3FGWkast3rNHdhOaO1sFKOQmLE3AO+OwE69fbYnv6K7eowmqi945WXhyQEMBI1HlbIQcre qovnu4lBQQjbYM80D7VVV+rNMdhS5Vx5+vM7bi84I4kOfzBgPQFBsV8zxzharD1r8RhEEN86OiukJV qgv8UupFXN0ryRiab2dQ1iwNx3tkbm3g1ee6Ctt/6DH87o25599S6T1WCWAzBEJC1hZCOz0p5HkjBu 1gmrj2jzVYZgzY/U4WfDd49nNdxxSh1kL5V/4dqZcLgranBUaWtQK09og9JrAx1rmqL+RCGPVLBAAo Ar5SyjgIZggA+BjooyjTqr/gJmQf7jHvgZIcXxqWHG58o=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

iop32x uses the entry-macro.S file for both the IRQ entry and for
hooking into the arch_ret_to_user code path. This is done because the
cp6 registers have to be enabled before accessing any of the interrupt
controller registers but have to be disabled when running in user space.

There is also a lazy-enable logic in cp6.c, but during a hardirq, we
know it has to be enabled.

Both the cp6-enable code and the code to read the IRQ status can be
lifted into the normal generic_handle_arch_irq() path, but the
cp6-disable code has to remain in the user return code. As nothing
other than iop32x uses this hook, just open-code it there with an
ifdef for the platform that can eventually be removed when iop32x
has reached the end of its life.

The cp6-enable path in the IRQ entry has an extra cp_wait barrier that
the trap version does not have, but it is harmless to do it in both
cases to simplify the logic here at the cost of a few extra cycles
for the trap.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig                                |  5 +---
 arch/arm/kernel/entry-common.S                  | 16 +++++-----
 arch/arm/mach-iop32x/cp6.c                      | 10 ++++++-
 arch/arm/mach-iop32x/include/mach/entry-macro.S | 31 --------------------
 arch/arm/mach-iop32x/iop3xx.h                   |  1 +
 arch/arm/mach-iop32x/irq.c                      | 23 +++++++++++++++
 6 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bef5085f2ce7..ac2f88ce0b9a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -226,9 +226,6 @@ config GENERIC_ISA_DMA
 config FIQ
 	bool
 
-config NEED_RET_TO_USER
-	bool
-
 config ARCH_MTD_XIP
 	bool
 
@@ -370,9 +367,9 @@ config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_IOP
 	select GPIOLIB
-	select NEED_RET_TO_USER
 	select FORCE_PCI
 	select PLAT_IOP
 	help
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index ac86c34682bb..c928d6b04cce 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -16,12 +16,14 @@
 
 	.equ	NR_syscalls, __NR_syscalls
 
-#ifdef CONFIG_NEED_RET_TO_USER
-#include <mach/entry-macro.S>
-#else
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
+	.macro  arch_ret_to_user, tmp
+#ifdef CONFIG_ARCH_IOP32X
+	mrc	p15, 0, \tmp, c15, c1, 0
+	tst	\tmp, #(1 << 6)
+	bicne	\tmp, \tmp, #(1 << 6)
+	mcrne	p15, 0, \tmp, c15, c1, 0	@ Disable cp6 access
 #endif
+	.endm
 
 #include "entry-header.S"
 
@@ -55,7 +57,7 @@ __ret_fast_syscall:
 
 
 	/* perform architecture specific actions before user return */
-	arch_ret_to_user r1, lr
+	arch_ret_to_user r1
 
 	restore_user_regs fast = 1, offset = S_OFF
  UNWIND(.fnend		)
@@ -128,7 +130,7 @@ no_work_pending:
 	asm_trace_hardirqs_on save = 0
 
 	/* perform architecture specific actions before user return */
-	arch_ret_to_user r1, lr
+	arch_ret_to_user r1
 	ct_user_enter save = 0
 
 	restore_user_regs fast = 0, offset = 0
diff --git a/arch/arm/mach-iop32x/cp6.c b/arch/arm/mach-iop32x/cp6.c
index ec74b07fb7e3..2882674a1c39 100644
--- a/arch/arm/mach-iop32x/cp6.c
+++ b/arch/arm/mach-iop32x/cp6.c
@@ -7,7 +7,7 @@
 #include <asm/traps.h>
 #include <asm/ptrace.h>
 
-static int cp6_trap(struct pt_regs *regs, unsigned int instr)
+void iop_enable_cp6(void)
 {
 	u32 temp;
 
@@ -16,7 +16,15 @@ static int cp6_trap(struct pt_regs *regs, unsigned int instr)
 		"mrc	p15, 0, %0, c15, c1, 0\n\t"
 		"orr	%0, %0, #(1 << 6)\n\t"
 		"mcr	p15, 0, %0, c15, c1, 0\n\t"
+		"mrc	p15, 0, %0, c15, c1, 0\n\t"
+		"mov	%0, %0\n\t"
+		"sub	pc, pc, #4  @ cp_wait\n\t"
 		: "=r"(temp));
+}
+
+static int cp6_trap(struct pt_regs *regs, unsigned int instr)
+{
+	iop_enable_cp6();
 
 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/include/mach/entry-macro.S b/arch/arm/mach-iop32x/include/mach/entry-macro.S
deleted file mode 100644
index 341e5d9a6616..000000000000
--- a/arch/arm/mach-iop32x/include/mach/entry-macro.S
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/arm/mach-iop32x/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for IOP32x-based platforms
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-	.macro get_irqnr_preamble, base, tmp
-	mrc	p15, 0, \tmp, c15, c1, 0
-	orr	\tmp, \tmp, #(1 << 6)
-	mcr	p15, 0, \tmp, c15, c1, 0	@ Enable cp6 access
-	mrc	p15, 0, \tmp, c15, c1, 0
-	mov	\tmp, \tmp
-	sub	pc, pc, #4			@ cp_wait
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	mrc     p6, 0, \irqstat, c8, c0, 0	@ Read IINTSRC
-	cmp     \irqstat, #0
-	clzne   \irqnr, \irqstat
-	rsbne   \irqnr, \irqnr, #32
-	.endm
-
-	.macro arch_ret_to_user, tmp1, tmp2
-	mrc	p15, 0, \tmp1, c15, c1, 0
-	ands	\tmp2, \tmp1, #(1 << 6)
-	bicne	\tmp1, \tmp1, #(1 << 6)
-	mcrne	p15, 0, \tmp1, c15, c1, 0	@ Disable cp6 access
-	.endm
diff --git a/arch/arm/mach-iop32x/iop3xx.h b/arch/arm/mach-iop32x/iop3xx.h
index 46b4b34a4ad2..a6ec7ebadb35 100644
--- a/arch/arm/mach-iop32x/iop3xx.h
+++ b/arch/arm/mach-iop32x/iop3xx.h
@@ -225,6 +225,7 @@ extern int iop3xx_get_init_atu(void);
 #include <linux/reboot.h>
 
 void iop3xx_map_io(void);
+void iop_enable_cp6(void);
 void iop_init_cp6_handler(void);
 void iop_init_time(unsigned long tickrate);
 void iop3xx_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-iop32x/irq.c b/arch/arm/mach-iop32x/irq.c
index d1e8824cbd82..6dca7e97d81f 100644
--- a/arch/arm/mach-iop32x/irq.c
+++ b/arch/arm/mach-iop32x/irq.c
@@ -29,6 +29,15 @@ static void intstr_write(u32 val)
 	asm volatile("mcr p6, 0, %0, c4, c0, 0" : : "r" (val));
 }
 
+static u32 iintsrc_read(void)
+{
+	int irq;
+
+	asm volatile("mrc p6, 0, %0, c8, c0, 0" : "=r" (irq));
+
+	return irq;
+}
+
 static void
 iop32x_irq_mask(struct irq_data *d)
 {
@@ -50,11 +59,25 @@ struct irq_chip ext_chip = {
 	.irq_unmask	= iop32x_irq_unmask,
 };
 
+static void iop_handle_irq(struct pt_regs *regs)
+{
+	u32 mask;
+
+	iop_enable_cp6();
+
+	do {
+		mask = iintsrc_read();
+		if (mask)
+			generic_handle_irq(fls(mask));
+	} while (mask);
+}
+
 void __init iop32x_init_irq(void)
 {
 	int i;
 
 	iop_init_cp6_handler();
+	set_handle_irq(iop_handle_irq);
 
 	intctl_write(0);
 	intstr_write(0);
-- 
2.30.2

