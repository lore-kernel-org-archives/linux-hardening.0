Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D3FC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbiAXRss (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiAXRsp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BEC06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 619A96132D
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10D8C340E8;
        Mon, 24 Jan 2022 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046523;
        bh=R9pqoOjBSvtzFhQGDwKmU6TyA6fPIXCEUg/HRlbPQZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flUIHDk2cQsZJkCZyFOJlHV/335uoOIqmJfbsfULgQggyTh06Nya2ZaJaE2KA67mO
         Jw27joMgaOC9Otn038PmNnKUvBobGc5VNj+kQVGkURGtuCi36OAtvP4jEttNSbwul1
         hh8dgJXWHH2NBBonNOArgLQ0yVxxwhtrU4ycDbW6vRhauseWKhOIoVKKII/OI/Yr5f
         kBK8TSxjUQtI8yTMC3RT1xwSP/CakCtcqF4gA1tERaSVUOxD3oRgsBT1m/Eq+aop0U
         CACMsMgM30aLeRx2hVu2nGolWmzgrJIXimKudzVfftUTOzeQQMHVE/2VEuPIP+NT2M
         ZSMUuX8EXGQDg==
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
Subject: [PATCH v5 15/32] ARM: smp: defer TPIDRURO update for SMP v6 configurations too
Date:   Mon, 24 Jan 2022 18:47:27 +0100
Message-Id: <20220124174744.1054712-16-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819; h=from:subject; bh=R9pqoOjBSvtzFhQGDwKmU6TyA6fPIXCEUg/HRlbPQZg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYepZ0YFyw1WmCiJPoCd4Ph980LWSukwqcu41Gn oSbZXTaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mHgAKCRDDTyI5ktmPJDT+C/ 9K837OClZA+Cuoze++89Rb6b+NEBs5xeEJuWXYsIQwREHTlzhcNA2VgokOwM6UYFy9uJUdzC4IfWZk OTImA9bQb0lst+erchLWSgN2AJoGaNw+CrW4++uAhG0uq2CeR25Tbq1S2fCqxl9CQa0o36mP3YhdnS NyvreUGepHWoLzRyBPWM/LgnF1INW4RTFtTRPPfFh+Ml6nEn8IUHOcO7dGfExlfTTeeLhBv/4cfPqK FYBNzRflm+AzFlV53TjrJy6M8/5tQUE/SHbqF1P8N0VVwI6XxlBwEDuR/gOOOKmGvpGHIJE8y5U7v1 31DGWi2QB/NYtDn/0mrNm9FSqm2B06nM4aZNnqzXcMhk3crGo6SvPxMKrV9wTce/n/IJtM+tankQ3C cfEGZMGbf9GAT7+7lyHwWlwDumqL+li3ac66qhsnldqPLCurcNTAhew4jzFm8JKmos89ZKe3hrrA5w mvKGL+legaAbqjbzMGD7EmPkIudiMnZgSFLke7URO34Rs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Defer TPIDURO updates for user space until exit also for CPU_V6+SMP
configurations so that we can decide at runtime whether to use it to
carry the current pointer, provided that we are running on a CPU that
actually implements this register. This is needed for
THREAD_INFO_IN_TASK support for UP systems, which requires that all SMP
capable systems use the TPIDRURO based access to 'current' as the only
remaining alternative will be a global variable which only works on UP.

Given that SMP implies support for HWCAP_TLS, we can patch away the
hwcap test entirely from the context switch path rather than just the
TPIDRURO assignment when running on SMP hardware.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/tls.h     | 30 +++++++++++++-------
 arch/arm/kernel/entry-header.S |  8 +++++-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index c3296499176c..de254347acf6 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -18,21 +18,31 @@
 	.endm
 
 	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
-	ldr	\tmp1, =elf_hwcap
-	ldr	\tmp1, [\tmp1, #0]
+#ifdef CONFIG_SMP
+ALT_SMP(nop)
+ALT_UP_B(.L0_\@)
+	.subsection 1
+#endif
+.L0_\@: ldr_va	\tmp1, elf_hwcap
 	mov	\tmp2, #0xffff0fff
 	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
 	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
-	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
-	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
-	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
-	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
+	beq	.L2_\@
+	mcr	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
+#ifdef CONFIG_SMP
+	b	.L1_\@
+	.previous
+#endif
+.L1_\@: switch_tls_v6k \base, \tp, \tpuser, \tmp1, \tmp2
+.L2_\@:
 	.endm
 
 	.macro switch_tls_software, base, tp, tpuser, tmp1, tmp2
 	mov	\tmp1, #0xffff0fff
 	str	\tp, [\tmp1, #-15]		@ set TLS value at 0xffff0ff0
 	.endm
+#else
+#include <asm/smp_plat.h>
 #endif
 
 #ifdef CONFIG_TLS_REG_EMUL
@@ -43,7 +53,7 @@
 #elif defined(CONFIG_CPU_V6)
 #define tls_emu		0
 #define has_tls_reg		(elf_hwcap & HWCAP_TLS)
-#define defer_tls_reg_update	0
+#define defer_tls_reg_update	is_smp()
 #define switch_tls	switch_tls_v6
 #elif defined(CONFIG_CPU_32v6K)
 #define tls_emu		0
@@ -81,11 +91,11 @@ static inline void set_tls(unsigned long val)
 	 */
 	barrier();
 
-	if (!tls_emu && !defer_tls_reg_update) {
-		if (has_tls_reg) {
+	if (!tls_emu) {
+		if (has_tls_reg && !defer_tls_reg_update) {
 			asm("mcr p15, 0, %0, c13, c0, 3"
 			    : : "r" (val));
-		} else {
+		} else if (!has_tls_reg) {
 #ifdef CONFIG_KUSER_HELPERS
 			/*
 			 * User space must never try to access this
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index ae24dd54e9ef..da206bd4f194 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -292,12 +292,18 @@
 
 
 	.macro	restore_user_regs, fast = 0, offset = 0
-#if defined(CONFIG_CPU_32v6K) && !defined(CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_32v6K) && \
+    (!defined(CONFIG_CPU_V6) || defined(CONFIG_SMP))
+#ifdef CONFIG_CPU_V6
+ALT_SMP(nop)
+ALT_UP_B(.L1_\@)
+#endif
 	@ The TLS register update is deferred until return to user space so we
 	@ can use it for other things while running in the kernel
 	get_thread_info r1
 	ldr	r1, [r1, #TI_TP_VALUE]
 	mcr	p15, 0, r1, c13, c0, 3		@ set TLS register
+.L1_\@:
 #endif
 
 	uaccess_enable r1, isb=0
-- 
2.30.2

