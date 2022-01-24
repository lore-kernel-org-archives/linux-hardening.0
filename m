Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F52DC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiAXRsG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49900 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbiAXRsG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5996EB811B1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401CBC340EA;
        Mon, 24 Jan 2022 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046484;
        bh=gxecdLt8rF6jDfs+RxXFFv8e21A23HTF4VhA40qVdPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsnkxAD+dPic6cSRme3qNM2JF4krQlm2d2+LrWCghOVC06Pm7CH20fvKOtGM9DeLm
         rppvO1UyFE+3VOMLftwT48Lf+jjp/hq5svkmuu76V0mgS63QMi2fvvsbwVaDVhxo5j
         Lk59VtUtJLvzLOvxqcFdQjCnIiF5DQ+qOcP7FBT5jhQ2bcPO+9hwTMMVGHoLaojBO5
         3matXOGCr16JltFo/YJXZNfyqsBi3p/g8oCluBUPOAAVDn5X/Hp9D7i77AYmi8uFKh
         FI+t5b/a55raFeKih5CkH7hqYVaNPdPdlZQY/ik3qw/pjuM379T0K3H6QqKlTqNGWX
         6qnZhprNW0BMw==
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
Subject: [PATCH v5 03/32] ARM: footbridge: use GENERIC_IRQ_MULTI_HANDLER
Date:   Mon, 24 Jan 2022 18:47:15 +0100
Message-Id: <20220124174744.1054712-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6395; i=ardb@kernel.org; h=from:subject; bh=YpVOH03SjU446m5no57bBl9lygnIPLQRBjksa7nMLhQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYH3B86fZFA7SfuWfpdNQQjVUTqd2cWNMrgfIjb SROk3FeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mBwAKCRDDTyI5ktmPJLWADA CLJ1kJiXVSMSMfDEZ0p3DmuE9EcaIpXc95q+pVSsZgXE12E+ZCxni4gCVx1DdskNiXW3BcF0h12njq 0stDshlAj+1oxzU19rxfqGtSq5yWxBpiv2I/i1vvzMBuTzlhDjvumkDrR94teFEfLReIzHz6S1USut 81N5x/rwqWfmqwETv+cCsMDY7kD+zrM4eqc4gZdGZUXgdni4w/Lj1Lkd9076VwiJuUnYFpUuXvhf6G MLT0xm/ioVxW8K06oVwi93nGpByfWAqKtmjrCGXn4rgASrlVlMZZfsYFrrxW1rCAUbOVh0ZL+Tn95j 9MNGbUDwScVV83TP53JqygKMRexb+wtuUVvnVXQ+A18daBkIfQXcQKPjT57w+02JwnvGuQAi4U3p3Z nbsMP4tqWIzichJxPktutayzyZwHsCMgafbUrHftn1Ys1m5U4pp6PjmZOmaLYJjhZTQ8nE66/IMPJf rVK4gjKF6N/y75E9e7+W+1dWRhgUeCaCLgBINsaEcv+eY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Footbridge still uses the classic IRQ entry path in assembler,
but this is easily converted into an equivalent C version.

In this case, the correlation between IRQ numbers and bits in
the status register is non-obvious, and the priorities are
handled by manually checking each bit in a static order,
re-reading the status register after each handled event.

I moved the code into the new file and edited the syntax without
changing this sequence to keep the behavior as close as possible
to what it traditionally did.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                    |   1 +
 arch/arm/mach-footbridge/common.c                   |  87 ++++++++++++++++
 arch/arm/mach-footbridge/include/mach/entry-macro.S | 107 --------------------
 3 files changed, 88 insertions(+), 107 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40193ec76f1a..bef5085f2ce7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -361,6 +361,7 @@ config ARCH_FOOTBRIDGE
 	select FOOTBRIDGE
 	select NEED_MACH_IO_H if !MMU
 	select NEED_MACH_MEMORY_H
+	select GENERIC_IRQ_MULTI_HANDLER
 	help
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index eee095f0e2f6..322495df271d 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -27,6 +27,91 @@
 
 #include "common.h"
 
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <asm/hardware/dec21285.h>
+
+static int dc21285_get_irq(void)
+{
+	void __iomem *irqstatus = (void __iomem *)CSR_IRQ_STATUS;
+	u32 mask = readl(irqstatus);
+
+	if (mask & IRQ_MASK_SDRAMPARITY)
+		return IRQ_SDRAMPARITY;
+
+	if (mask & IRQ_MASK_UART_RX)
+		return IRQ_CONRX;
+
+	if (mask & IRQ_MASK_DMA1)
+		return IRQ_DMA1;
+
+	if (mask & IRQ_MASK_DMA2)
+		return IRQ_DMA2;
+
+	if (mask & IRQ_MASK_IN0)
+		return IRQ_IN0;
+
+	if (mask & IRQ_MASK_IN1)
+		return IRQ_IN1;
+
+	if (mask & IRQ_MASK_IN2)
+		return IRQ_IN2;
+
+	if (mask & IRQ_MASK_IN3)
+		return IRQ_IN3;
+
+	if (mask & IRQ_MASK_PCI)
+		return IRQ_PCI;
+
+	if (mask & IRQ_MASK_DOORBELLHOST)
+		return IRQ_DOORBELLHOST;
+
+	if (mask & IRQ_MASK_I2OINPOST)
+		return IRQ_I2OINPOST;
+
+	if (mask & IRQ_MASK_TIMER1)
+		return IRQ_TIMER1;
+
+	if (mask & IRQ_MASK_TIMER2)
+		return IRQ_TIMER2;
+
+	if (mask & IRQ_MASK_TIMER3)
+		return IRQ_TIMER3;
+
+	if (mask & IRQ_MASK_UART_TX)
+		return IRQ_CONTX;
+
+	if (mask & IRQ_MASK_PCI_ABORT)
+		return IRQ_PCI_ABORT;
+
+	if (mask & IRQ_MASK_PCI_SERR)
+		return IRQ_PCI_SERR;
+
+	if (mask & IRQ_MASK_DISCARD_TIMER)
+		return IRQ_DISCARD_TIMER;
+
+	if (mask & IRQ_MASK_PCI_DPERR)
+		return IRQ_PCI_DPERR;
+
+	if (mask & IRQ_MASK_PCI_PERR)
+		return IRQ_PCI_PERR;
+
+	return 0;
+}
+
+static void dc21285_handle_irq(struct pt_regs *regs)
+{
+	int irq;
+	do {
+		irq = dc21285_get_irq();
+		if (!irq)
+			break;
+
+		generic_handle_irq(irq);
+	} while (1);
+}
+
+
 unsigned int mem_fclk_21285 = 50000000;
 
 EXPORT_SYMBOL(mem_fclk_21285);
@@ -108,6 +193,8 @@ static void __init __fb_init_irq(void)
 
 void __init footbridge_init_irq(void)
 {
+	set_handle_irq(dc21285_handle_irq);
+
 	__fb_init_irq();
 
 	if (!footbridge_cfn_mode())
diff --git a/arch/arm/mach-footbridge/include/mach/entry-macro.S b/arch/arm/mach-footbridge/include/mach/entry-macro.S
deleted file mode 100644
index dabbd5c54a78..000000000000
--- a/arch/arm/mach-footbridge/include/mach/entry-macro.S
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- * arch/arm/mach-footbridge/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for footbridge-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>
-
-		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
-		.equ	dc21285_low, ARMCSR_BASE & 0x00ffffff
-
-		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #dc21285_high
-		.if	dc21285_low
-		orr	\base, \base, #dc21285_low
-		.endif
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, [\base, #0x180]	@ get interrupts
-
-		mov	\irqnr, #IRQ_SDRAMPARITY
-		tst	\irqstat, #IRQ_MASK_SDRAMPARITY
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_UART_RX
-		movne	\irqnr, #IRQ_CONRX
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_DMA1
-		movne	\irqnr, #IRQ_DMA1
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_DMA2
-		movne	\irqnr, #IRQ_DMA2
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_IN0
-		movne	\irqnr, #IRQ_IN0
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_IN1
-		movne	\irqnr, #IRQ_IN1
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_IN2
-		movne	\irqnr, #IRQ_IN2
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_IN3
-		movne	\irqnr, #IRQ_IN3
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_PCI
-		movne	\irqnr, #IRQ_PCI
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_DOORBELLHOST
-		movne	\irqnr, #IRQ_DOORBELLHOST
-		bne     1001f
-
-		tst	\irqstat, #IRQ_MASK_I2OINPOST
-		movne	\irqnr, #IRQ_I2OINPOST
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_TIMER1
-		movne	\irqnr, #IRQ_TIMER1
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_TIMER2
-		movne	\irqnr, #IRQ_TIMER2
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_TIMER3
-		movne	\irqnr, #IRQ_TIMER3
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_UART_TX
-		movne	\irqnr, #IRQ_CONTX
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_PCI_ABORT
-		movne	\irqnr, #IRQ_PCI_ABORT
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_PCI_SERR
-		movne	\irqnr, #IRQ_PCI_SERR
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_DISCARD_TIMER
-		movne	\irqnr, #IRQ_DISCARD_TIMER
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_PCI_DPERR
-		movne	\irqnr, #IRQ_PCI_DPERR
-		bne	1001f
-
-		tst	\irqstat, #IRQ_MASK_PCI_PERR
-		movne	\irqnr, #IRQ_PCI_PERR
-1001:
-		.endm
-
-- 
2.30.2

