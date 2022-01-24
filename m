Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF2C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbiAXRsN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiAXRsK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4327C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EAA9B811A5
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D72C340E8;
        Mon, 24 Jan 2022 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046487;
        bh=EiQVtdzvXgjyL0LmVL1EzAI/mo0NzKG3mqi/KHf8z0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaLOJM/0iChTAq9QSXvxWGqSHB9eJ8s1h0jBUWlEdO9Yp6b6h3qN1ad44oUiWUvwI
         e46l3zliWny0BPANfEw9rK/p1Qcsn4/Pg3S8Cya+1fd4U5013XOvyh6V0Oy9a4iyDT
         CwE6z6h40PjHyKHi2StQpzdobVG/Z8Jc3njQz/hmcmiX9IruTGaSSfVqvWRucbyfyu
         kfu7NoqffN6LRLeXQXs3hfA3fL+zfPCOxAKGaoz6IedNYRaNS5k7R9z6NcV3j7rQl0
         Zy8cAToaaPNIvw+jhx1mf2HPZOaHVdIPl/CwvK1wKv/ZRAZp5h/BhjS+YNYtB+/dhP
         wEqxoYKS8VLbw==
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
Subject: [PATCH v5 04/32] ARM: iop32x: offset IRQ numbers by 1
Date:   Mon, 24 Jan 2022 18:47:16 +0100
Message-Id: <20220124174744.1054712-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5281; i=ardb@kernel.org; h=from:subject; bh=TWotvNAxcAhiklui1EglJetBjAKAECMqx7SIUyPo0Gw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYJmVYJNoijGuYG34bxl/9AS+9/pLYzcuwpulMl f8Zq1HOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mCQAKCRDDTyI5ktmPJL2kC/ 9ipJlENH4qIC/TCUveonBsIbMxM+pqdzC0qWU+ObjNONxwE0thzanwwRCJIUFvyoTxpxRNQ11iVAiG JBXPzucWBDB5wjZVTsgoyUmEnOB3uxmD1PDsQ7WVrp1UpPlZRmqmPtM2sPNe3xbazAHrDUwS7zlfAv rsALH8JCeypYmo6dhXnig2XPEwSbtDTMYFhD0vwe+l7dA6C0iux09wo1VY5rJIYGqRGRMXb1uRyHqG FRxCY5ymbYWtZ7sQcrGGUJfXACeK0Bxhoq7x8mVaSagDP+l/rLIESOcBR/Bdqbrfs6vf96YcleqUO4 IWytHZMn6X+h7841dtMt2zN6D4Msb+/cZY1UaN0NivUay5WXxzPRhSCf2LjBXLh/ExOglogf5Dj46d ZLEeilQBvRsYUgrcRu+i2iTP1zhBEP0stEpRQHxp4K3sOc83XSrRq4NypoSkS1nxMlC3CJH6puWLkm ODeEzKG3IBx7KcFrGL/HR96RPX2Xk1+bbYP6L6CqYoV7U=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

iop32x is one of the last platforms to use IRQ 0, and this has apparently
stopped working in a 2014 cleanup without anyone noticing. This interrupt
is used for the DMA engine, so most likely this has not actually worked
in the past 7 years, but it's also not essential for using this board.

I'm splitting out this change from my GENERIC_IRQ_MULTI_HANDLER
conversion so it can be backported if anyone cares.

Fixes: a71b092a9c68 ("ARM: Convert handle_IRQ to use __handle_domain_irq")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ardb: take +1 offset into account in mask/unmask and init as well]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-iop32x/include/mach/entry-macro.S |  2 +-
 arch/arm/mach-iop32x/include/mach/irqs.h        |  2 +-
 arch/arm/mach-iop32x/irq.c                      |  6 +-
 arch/arm/mach-iop32x/irqs.h                     | 60 +++++++++++---------
 4 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-iop32x/include/mach/entry-macro.S b/arch/arm/mach-iop32x/include/mach/entry-macro.S
index 8e6766d4621e..341e5d9a6616 100644
--- a/arch/arm/mach-iop32x/include/mach/entry-macro.S
+++ b/arch/arm/mach-iop32x/include/mach/entry-macro.S
@@ -20,7 +20,7 @@
 	mrc     p6, 0, \irqstat, c8, c0, 0	@ Read IINTSRC
 	cmp     \irqstat, #0
 	clzne   \irqnr, \irqstat
-	rsbne   \irqnr, \irqnr, #31
+	rsbne   \irqnr, \irqnr, #32
 	.endm
 
 	.macro arch_ret_to_user, tmp1, tmp2
diff --git a/arch/arm/mach-iop32x/include/mach/irqs.h b/arch/arm/mach-iop32x/include/mach/irqs.h
index c4e78df428e8..e09ae5f48aec 100644
--- a/arch/arm/mach-iop32x/include/mach/irqs.h
+++ b/arch/arm/mach-iop32x/include/mach/irqs.h
@@ -9,6 +9,6 @@
 #ifndef __IRQS_H
 #define __IRQS_H
 
-#define NR_IRQS			32
+#define NR_IRQS			33
 
 #endif
diff --git a/arch/arm/mach-iop32x/irq.c b/arch/arm/mach-iop32x/irq.c
index 2d48bf1398c1..d1e8824cbd82 100644
--- a/arch/arm/mach-iop32x/irq.c
+++ b/arch/arm/mach-iop32x/irq.c
@@ -32,14 +32,14 @@ static void intstr_write(u32 val)
 static void
 iop32x_irq_mask(struct irq_data *d)
 {
-	iop32x_mask &= ~(1 << d->irq);
+	iop32x_mask &= ~(1 << (d->irq - 1));
 	intctl_write(iop32x_mask);
 }
 
 static void
 iop32x_irq_unmask(struct irq_data *d)
 {
-	iop32x_mask |= 1 << d->irq;
+	iop32x_mask |= 1 << (d->irq - 1);
 	intctl_write(iop32x_mask);
 }
 
@@ -65,7 +65,7 @@ void __init iop32x_init_irq(void)
 	    machine_is_em7210())
 		*IOP3XX_PCIIRSR = 0x0f;
 
-	for (i = 0; i < NR_IRQS; i++) {
+	for (i = 1; i < NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &ext_chip, handle_level_irq);
 		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
diff --git a/arch/arm/mach-iop32x/irqs.h b/arch/arm/mach-iop32x/irqs.h
index 69858e4e905d..e1dfc8b4e7d7 100644
--- a/arch/arm/mach-iop32x/irqs.h
+++ b/arch/arm/mach-iop32x/irqs.h
@@ -7,36 +7,40 @@
 #ifndef __IOP32X_IRQS_H
 #define __IOP32X_IRQS_H
 
+/* Interrupts in Linux start at 1, hardware starts at 0 */
+
+#define IOP_IRQ(x) ((x) + 1)
+
 /*
  * IOP80321 chipset interrupts
  */
-#define IRQ_IOP32X_DMA0_EOT	0
-#define IRQ_IOP32X_DMA0_EOC	1
-#define IRQ_IOP32X_DMA1_EOT	2
-#define IRQ_IOP32X_DMA1_EOC	3
-#define IRQ_IOP32X_AA_EOT	6
-#define IRQ_IOP32X_AA_EOC	7
-#define IRQ_IOP32X_CORE_PMON	8
-#define IRQ_IOP32X_TIMER0	9
-#define IRQ_IOP32X_TIMER1	10
-#define IRQ_IOP32X_I2C_0	11
-#define IRQ_IOP32X_I2C_1	12
-#define IRQ_IOP32X_MESSAGING	13
-#define IRQ_IOP32X_ATU_BIST	14
-#define IRQ_IOP32X_PERFMON	15
-#define IRQ_IOP32X_CORE_PMU	16
-#define IRQ_IOP32X_BIU_ERR	17
-#define IRQ_IOP32X_ATU_ERR	18
-#define IRQ_IOP32X_MCU_ERR	19
-#define IRQ_IOP32X_DMA0_ERR	20
-#define IRQ_IOP32X_DMA1_ERR	21
-#define IRQ_IOP32X_AA_ERR	23
-#define IRQ_IOP32X_MSG_ERR	24
-#define IRQ_IOP32X_SSP		25
-#define IRQ_IOP32X_XINT0	27
-#define IRQ_IOP32X_XINT1	28
-#define IRQ_IOP32X_XINT2	29
-#define IRQ_IOP32X_XINT3	30
-#define IRQ_IOP32X_HPI		31
+#define IRQ_IOP32X_DMA0_EOT	IOP_IRQ(0)
+#define IRQ_IOP32X_DMA0_EOC	IOP_IRQ(1)
+#define IRQ_IOP32X_DMA1_EOT	IOP_IRQ(2)
+#define IRQ_IOP32X_DMA1_EOC	IOP_IRQ(3)
+#define IRQ_IOP32X_AA_EOT	IOP_IRQ(6)
+#define IRQ_IOP32X_AA_EOC	IOP_IRQ(7)
+#define IRQ_IOP32X_CORE_PMON	IOP_IRQ(8)
+#define IRQ_IOP32X_TIMER0	IOP_IRQ(9)
+#define IRQ_IOP32X_TIMER1	IOP_IRQ(10)
+#define IRQ_IOP32X_I2C_0	IOP_IRQ(11)
+#define IRQ_IOP32X_I2C_1	IOP_IRQ(12)
+#define IRQ_IOP32X_MESSAGING	IOP_IRQ(13)
+#define IRQ_IOP32X_ATU_BIST	IOP_IRQ(14)
+#define IRQ_IOP32X_PERFMON	IOP_IRQ(15)
+#define IRQ_IOP32X_CORE_PMU	IOP_IRQ(16)
+#define IRQ_IOP32X_BIU_ERR	IOP_IRQ(17)
+#define IRQ_IOP32X_ATU_ERR	IOP_IRQ(18)
+#define IRQ_IOP32X_MCU_ERR	IOP_IRQ(19)
+#define IRQ_IOP32X_DMA0_ERR	IOP_IRQ(20)
+#define IRQ_IOP32X_DMA1_ERR	IOP_IRQ(21)
+#define IRQ_IOP32X_AA_ERR	IOP_IRQ(23)
+#define IRQ_IOP32X_MSG_ERR	IOP_IRQ(24)
+#define IRQ_IOP32X_SSP		IOP_IRQ(25)
+#define IRQ_IOP32X_XINT0	IOP_IRQ(27)
+#define IRQ_IOP32X_XINT1	IOP_IRQ(28)
+#define IRQ_IOP32X_XINT2	IOP_IRQ(29)
+#define IRQ_IOP32X_XINT3	IOP_IRQ(30)
+#define IRQ_IOP32X_HPI		IOP_IRQ(31)
 
 #endif
-- 
2.30.2

