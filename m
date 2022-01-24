Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1ADC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiAXRsD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbiAXRsC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12830C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE0261301
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB386C340E8;
        Mon, 24 Jan 2022 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046480;
        bh=MBdnzrhS7Inw7mEJXXZQkmN30h0TVnJLnhelzR+UmgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehgvbaUAWFWg5+sNDOmmDpf0Vg+WpznpFgfXvCJBxpo1Pg88gCfnLC1H/G2Hdqha6
         0EZtcrf1Fi29DG2dNQUl4GHck3C8/l2u0TeNBMaRxuI7R7GEgTWxwck4IBPgSGp7Wf
         iDvgC8afrY8DoV63s3EZe3Fd0lrmAGu+v1Ov5cbgve9TSr1KUieTVEQjY6abE6ZTW7
         WXbAaeSu65ULAzln8PSEmgENXDZq6mX+EoE0LcrNf4B1hvS3eUgrmjPE2Uv0nAN4ul
         OaDwDsmJEZIXQ4H4ZE/5o1FHBxp/WFIXW45TV+J4qn7jEjnNNhlgUtlzOoMRiEud1R
         zAnQ4wKxDivwQ==
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
Subject: [PATCH v5 02/32] ARM: riscpc: use GENERIC_IRQ_MULTI_HANDLER
Date:   Mon, 24 Jan 2022 18:47:14 +0100
Message-Id: <20220124174744.1054712-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10826; i=ardb@kernel.org; h=from:subject; bh=zdFFow6a3Tw2jiMBmFTU9djJXqPwMnPVJeEnOQrcc7c=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYFWfCNbC/vrCf1xhcCT5uNvyj9RU0a/tsCTonS o07/v5GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mBQAKCRDDTyI5ktmPJM81C/ 0eAmRswPeuBFIJ3rPgoVONaIYcsAkQ6hJK9IV8rbshE6/cnPKNDZmtNP2Zcz7kYCSM9dtJdl7gPOlG ZIF/ZugJzPO7H7AGntCpLDvRZGP9nSB87TdwQriv9eHDlTGZTE4IG7fMo6xYFqE+C/+Bm7WL9cXOG4 eqSJmVr4XwKGOaEUFxGUvaLiAEE6iUh0x9e9OrFEA2vN/rHCCYZH6jCW8fiysxTawK0HmoDh/abu7v N1r6vcwB4Tewupk5X04vdpFLif1p9hcqWPD+K18k6s44xyZdoCMfd9APYXl3zNfavzeCOY1Rdi2MtA brawCmxQV9bTBU23Ib4FzK89jHHNTLVTNDnK6hziqCMNo0mJukUvbZvzbM5MtuJFhHg7OSEBo5KLu7 p7me/z0f53xk6dY/NKpEphiZZQ4U3TQ6k6BygroBQjBExZVQS56Rafc6c08iRXO1mSAnJqHkOFOWky dRqEBRROFybCcCBD26tqz4v0PX/8KRii/9Kyz2Z4put5I=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is one of the last platforms using the old entry path.
While this code path is spread over a few files, it is fairly
straightforward to convert it into an equivalent C version,
leaving the existing algorithm and all the priority handling
the same.

Unlike most irqchip drivers, this means reading the status
register(s) in a loop and always handling the highest-priority
irq first.

The IOMD_IRQREQC and IOMD_IRQREQD registers are not actaully
used here, but I left the code in place for the time being,
to keep the conversion as direct as possible. It could be
removed in a cleanup on top.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ardb: drop obsolete IOMD_IRQREQC/IOMD_IRQREQD handling]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig                                 |  1 +
 arch/arm/include/asm/hardware/entry-macro-iomd.S | 84 -----------------
 arch/arm/mach-rpc/fiq.S                          |  5 +-
 arch/arm/mach-rpc/include/mach/entry-macro.S     | 13 ---
 arch/arm/mach-rpc/irq.c                          | 95 ++++++++++++++++++++
 5 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fabe39169b12..40193ec76f1a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -443,6 +443,7 @@ config ARCH_RPC
 	select ARM_HAS_SG_CHAIN
 	select CPU_SA110
 	select FIQ
+	select GENERIC_IRQ_MULTI_HANDLER
 	select HAVE_PATA_PLATFORM
 	select ISA_DMA_API
 	select LEGACY_TIMER_TICK
diff --git a/arch/arm/include/asm/hardware/entry-macro-iomd.S b/arch/arm/include/asm/hardware/entry-macro-iomd.S
deleted file mode 100644
index 81441dfa5282..000000000000
--- a/arch/arm/include/asm/hardware/entry-macro-iomd.S
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * arch/arm/include/asm/hardware/entry-macro-iomd.S
- *
- * Low-level IRQ helper macros for IOC/IOMD based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-/* IOC / IOMD based hardware */
-#include <asm/hardware/iomd.h>
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldrb	\irqstat, [\base, #IOMD_IRQREQB]	@ get high priority first
-		ldr	\tmp, =irq_prio_h
-		teq	\irqstat, #0
-#ifdef IOMD_BASE
-		ldrbeq	\irqstat, [\base, #IOMD_DMAREQ]	@ get dma
-		addeq	\tmp, \tmp, #256		@ irq_prio_h table size
-		teqeq	\irqstat, #0
-		bne	2406f
-#endif
-		ldrbeq	\irqstat, [\base, #IOMD_IRQREQA]	@ get low priority
-		addeq	\tmp, \tmp, #256		@ irq_prio_d table size
-		teqeq	\irqstat, #0
-2406:		ldrbne	\irqnr, [\tmp, \irqstat]	@ get IRQ number
-		.endm
-
-/*
- * Interrupt table (incorporates priority).  Please note that we
- * rely on the order of these tables (see above code).
- */
-		.align	5
-irq_prio_h:	.byte	 0, 8, 9, 8,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	12, 8, 9, 8,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	14,14,14,14,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	14,14,14,14,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-		.byte	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10
-#ifdef IOMD_BASE
-irq_prio_d:	.byte	 0,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	20,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	23,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	23,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-		.byte	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16
-#endif
-irq_prio_l:	.byte	 0, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3
-		.byte	 4, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3
-		.byte	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
-		.byte	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
-		.byte	 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3
-		.byte	 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3
-		.byte	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
-		.byte	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
-		.byte	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
diff --git a/arch/arm/mach-rpc/fiq.S b/arch/arm/mach-rpc/fiq.S
index 0de83e9b0b39..087bdf4bc093 100644
--- a/arch/arm/mach-rpc/fiq.S
+++ b/arch/arm/mach-rpc/fiq.S
@@ -2,10 +2,11 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <mach/hardware.h>
-#include <mach/entry-macro.S>
 
-	.text
+	.equ	ioc_base_high, IOC_BASE & 0xff000000
+	.equ	ioc_base_low, IOC_BASE & 0x00ff0000
 
+	.text
 	.global	rpc_default_fiq_end
 ENTRY(rpc_default_fiq_start)
 	mov	r12, #ioc_base_high
diff --git a/arch/arm/mach-rpc/include/mach/entry-macro.S b/arch/arm/mach-rpc/include/mach/entry-macro.S
deleted file mode 100644
index a6d1a9f4bb79..000000000000
--- a/arch/arm/mach-rpc/include/mach/entry-macro.S
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <mach/hardware.h>
-#include <asm/hardware/entry-macro-iomd.S>
-
-	.equ	ioc_base_high, IOC_BASE & 0xff000000
-	.equ	ioc_base_low, IOC_BASE & 0x00ff0000
-
-	.macro  get_irqnr_preamble, base, tmp
-	mov	\base, #ioc_base_high		@ point at IOC
-	.if	ioc_base_low
-	orr	\base, \base, #ioc_base_low
-	.endif
-	.endm
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index 803aeb126f0e..dc29384b6ef8 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -14,6 +14,99 @@
 #define CLR	0x04
 #define MASK	0x08
 
+static const u8 irq_prio_h[256] = {
+	 0, 8, 9, 8,10,10,10,10,11,11,11,11,10,10,10,10,
+	12, 8, 9, 8,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	14,14,14,14,10,10,10,10,11,11,11,11,10,10,10,10,
+	14,14,14,14,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
+	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
+	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
+};
+
+static const u8 irq_prio_d[256] = {
+	 0,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	20,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	23,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	23,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
+};
+
+static const u8 irq_prio_l[256] = {
+	 0, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
+	 4, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
+	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
+	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
+	 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3,
+	 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3,
+	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
+	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
+};
+
+static int iomd_get_irq_nr(void)
+{
+	int irq;
+	u8 reg;
+
+	/* get highest priority first */
+	reg = readb(IOC_BASE + IOMD_IRQREQB);
+	irq = irq_prio_h[reg];
+	if (irq)
+		return irq;
+
+	/* get DMA  */
+	reg = readb(IOC_BASE + IOMD_DMAREQ);
+	irq = irq_prio_d[reg];
+	if (irq)
+		return irq;
+
+	/* get low priority */
+	reg = readb(IOC_BASE + IOMD_IRQREQA);
+	irq = irq_prio_l[reg];
+	if (irq)
+		return irq;
+	return 0;
+}
+
+static void iomd_handle_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	do {
+		irq = iomd_get_irq_nr();
+		if (irq)
+			generic_handle_irq(irq);
+	} while (irq);
+}
+
 static void __iomem *iomd_get_base(struct irq_data *d)
 {
 	void *cd = irq_data_get_irq_chip_data(d);
@@ -82,6 +175,8 @@ void __init rpc_init_irq(void)
 	set_fiq_handler(&rpc_default_fiq_start,
 		&rpc_default_fiq_end - &rpc_default_fiq_start);
 
+	set_handle_irq(iomd_handle_irq);
+
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		clr = IRQ_NOREQUEST;
 		set = 0;
-- 
2.30.2

