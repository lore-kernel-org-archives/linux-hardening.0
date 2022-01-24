Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE8CC43219
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiAXRsT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbiAXRsS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A242C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B14C61301
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E43DC36AE3;
        Mon, 24 Jan 2022 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046497;
        bh=JfGRqkvVEJXcX89tKCRbEHW9dK4QL2euw/qDvAceXC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNdf4s3CsVpdnKFJNtIfJnOqXfWsYPuDWtgLBwbB/XF2QWG1xgNhat7H7QcVi0zRm
         jt40XW1kgFdhvEATIImin2JBVXfsQZrMlXwPiN+ZEludUCQ9rvg1vFdlll4UanRjmH
         70nK/YXHyspjj5n+Eu+sJ5LJiUTFrDen1Xss92N7b/3dsCbLOjzZEZZuqKhgYZh8dk
         6MQA2m8T2r27y2UOA27EnH8zp4yE0elFaXqMLsXK9q33dniF7GfCw3H5ziqiWowQQT
         9smGYAglF2/lAO3O4eeb7LWHBNj/vk+2Ugs5Zvs/w9kipt4okuZBtvHfYdSe+6ArCO
         SAOOqlOjbkBOw==
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
        Jesse Taube <mr.bossman075@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 07/32] irqchip: nvic: Use GENERIC_IRQ_MULTI_HANDLER
Date:   Mon, 24 Jan 2022 18:47:19 +0100
Message-Id: <20220124174744.1054712-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3684; i=ardb@kernel.org; h=from:subject; bh=yam0h+eZOmjuxXtEw2mQ3PuK/kcsMmUqmzLUnVe0QVo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYP31SMnZ6kRAIITxO41UnaJ8dod4MWPdmYDiKh X12A+ZCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mDwAKCRDDTyI5ktmPJFfODA CgyhSSS4JK1OatfMKaqqNHnhF/f90kibT65G+oeEFOiodnHfhtNtQeBiI5p1eIX+ThafAt/2wsSkUW TvkS+mBMu1UC6gRDtbMGQebWw8Y7Prj1wtYQC5m7DpGERWkm3XEv6BEvcW3IxXcBep6H5OzZwHDkSt UrsphbMAwfFX/0ItqYtH7q8xng41WMaxLTqZQM0m9lgkBDEcSrN2mcURgP4/40vSeuQx18+L/pg2Rd RYI9c2uxJudvukhoPKqyods1ijNIuhZksh6K4YXpKMPqIzbrdjR3HQE/ch3p4ZiOnQOGbi2ZA/OAJT oeinhCQUQ3a/OKTSpnH1IhjmjpKhSgeWZ5Tm6tdUuGzt6cI2MNlEJFuXSd8QNHil9YodwxGXn/Z2FP STNoSb+3KuxeX4wUzvHIQdG8zaqRWUgbXJuTn7tymGrmoP3A0qGa9P9yfbxqTIePhfAty/9/zpBCHP N2iJJa9npHPjiZa8nNx0KtnkKGs8f4VKBoT45/hIIC9d8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

Rather then restructuring the ARMv7M entrly logic per TODO, just move
NVIC to GENERIC_IRQ_MULTI_HANDLER.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/v7m.h  |  3 ++-
 arch/arm/kernel/entry-v7m.S | 10 +++------
 drivers/irqchip/Kconfig     |  1 +
 drivers/irqchip/irq-nvic.c  | 22 +++++---------------
 4 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 2cb00d15831b..4512f7e1918f 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -13,6 +13,7 @@
 #define V7M_SCB_ICSR_PENDSVSET			(1 << 28)
 #define V7M_SCB_ICSR_PENDSVCLR			(1 << 27)
 #define V7M_SCB_ICSR_RETTOBASE			(1 << 11)
+#define V7M_SCB_ICSR_VECTACTIVE			0x000001ff
 
 #define V7M_SCB_VTOR			0x08
 
@@ -38,7 +39,7 @@
 #define V7M_SCB_SHCSR_MEMFAULTENA		(1 << 16)
 
 #define V7M_xPSR_FRAMEPTRALIGN			0x00000200
-#define V7M_xPSR_EXCEPTIONNO			0x000001ff
+#define V7M_xPSR_EXCEPTIONNO			V7M_SCB_ICSR_VECTACTIVE
 
 /*
  * When branching to an address that has bits [31:28] == 0xf an exception return
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 7bde93c10962..520dd43e7e08 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -39,14 +39,10 @@ __irq_entry:
 	@
 	@ Invoke the IRQ handler
 	@
-	mrs	r0, ipsr
-	ldr	r1, =V7M_xPSR_EXCEPTIONNO
-	and	r0, r1
-	sub	r0, #16
-	mov	r1, sp
+	mov	r0, sp
 	stmdb	sp!, {lr}
-	@ routine called with r0 = irq number, r1 = struct pt_regs *
-	bl	nvic_handle_irq
+	@ routine called with r0 = struct pt_regs *
+	bl	generic_handle_arch_irq
 
 	pop	{lr}
 	@
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7038957f4a77..488eaa14d3a7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -58,6 +58,7 @@ config ARM_NVIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC
 	bool
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index ba4759b3e269..125f9c1cf0c3 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -37,25 +37,12 @@
 
 static struct irq_domain *nvic_irq_domain;
 
-static void __nvic_handle_irq(irq_hw_number_t hwirq)
+static void __irq_entry nvic_handle_irq(struct pt_regs *regs)
 {
-	generic_handle_domain_irq(nvic_irq_domain, hwirq);
-}
+	unsigned long icsr = readl_relaxed(BASEADDR_V7M_SCB + V7M_SCB_ICSR);
+	irq_hw_number_t hwirq = (icsr & V7M_SCB_ICSR_VECTACTIVE) - 16;
 
-/*
- * TODO: restructure the ARMv7M entry logic so that this entry logic can live
- * in arch code.
- */
-asmlinkage void __exception_irq_entry
-nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-
-	irq_enter();
-	old_regs = set_irq_regs(regs);
-	__nvic_handle_irq(hwirq);
-	set_irq_regs(old_regs);
-	irq_exit();
+	generic_handle_domain_irq(nvic_irq_domain, hwirq);
 }
 
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -141,6 +128,7 @@ static int __init nvic_of_init(struct device_node *node,
 	for (i = 0; i < irqs; i += 4)
 		writel_relaxed(0, nvic_base + NVIC_IPR + i);
 
+	set_handle_irq(nvic_handle_irq);
 	return 0;
 }
 IRQCHIP_DECLARE(armv7m_nvic, "arm,armv7m-nvic", nvic_of_init);
-- 
2.30.2

