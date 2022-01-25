Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC93C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457384AbiAYJ1Q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49020 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457403AbiAYJPM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E1D6151D
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C675DC340E6;
        Tue, 25 Jan 2022 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102109;
        bh=S3pwYCt2gSUeW+29vY6nfD17RKQePaxvX9y2g6JFmnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eh6q96gqh3K5giFBqlNOFbHMwajihgn+8h+EF9uz+zwjRzXHjSiLYgfODCqu8CZVg
         xqNESrMoPNaRV9BHU4HH72R1ejlD14BF5ugMSyRtLCuaidCjuCNil0CZCtcLzmDts5
         745YhE7nrd44JSAzKbwTH6oR1UCGliGTwt+8YOkXxxO85ksFNZGsc21mDtmKOiHANE
         j+qmHMitrf0GAf/OBgbsyltSMFS0m9rNAq3MsZerWPQO5Xv6L7cW6aXdmA95HhWp9e
         /2fSLVWWqPvDNvdUOj6u8YjMJt6Vfd6VSRJhymb4l295GbLWTd5xXM02V8Q8qGagr3
         aaW+r75YhVkKw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 3/8] ARM: smp: elide HWCAP_TLS checks or __entry_task updates on SMP+v6
Date:   Tue, 25 Jan 2022 10:14:48 +0100
Message-Id: <20220125091453.1475246-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; h=from:subject; bh=S3pwYCt2gSUeW+29vY6nfD17RKQePaxvX9y2g6JFmnA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+Cxdx7lEyA/ZN3qwguA6+yWbFjqZiykNHtkO4u YjWO+a+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/ggAKCRDDTyI5ktmPJLh4DA CoXxEfTwJoCboPeMXM3u9sMH3RUogpUz3vXIK86H6ZFzXqEmXQEVPAU1+WJ+6v6CLijNyjL7gPRcP6 P5C1nrrsOUzHFqISLATNTJG9U0fkgy7qT3zfrurjsqbcZq1JwO/lkiyeOSLX6cmHrRSE3AdMvoy0Zd PZwDXgUaf+QfiEv0GYV0D+9bln0yg0+/26GdV0pgoMabfRXm4eZlgZJmzuQhWvn0LkQSe0Z7poOgaX Tre3KHE+Ejs6EhQVkZNszhjgDw/FHHXGxM/JuBc39IdUYgyRDYxOzKzE/sQjvyDnlB9XnKSwSKbGx6 dAXtPc0BnYixQlA06tOF1Uxd5PBTRxHjpyCBZPgT/xQD2eY2Wtx1U0auML3iuOsNL85T5g1y82Dw68 CGqiy2xQvyu9Uf6d717RXYbjLaWXWxZ8I3OzI8Q8d8wp+1bLO3HcnRz9P7IEJwD7GTuNsL1KleSXuz e4J1vqWXGyZU9PzZqU6FFEPxyr/0+UW2COPZ0uPybmBmI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use the SMP_ON_UP patching framework to elide HWCAP_TLS tests from the
context switch and return to userspace code paths, as SMP systems are
guaranteed to have this h/w capability.

At the same time, omit the update of __entry_task if the system is
detected to be UP at runtime, as in that case, the value is never used.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/switch_to.h |  4 ++--
 arch/arm/include/asm/tls.h       | 22 ++++++++++++++------
 arch/arm/kernel/entry-header.S   | 17 +++++++--------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index a482c99934ff..f67ae946a3c6 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -3,6 +3,7 @@
 #define __ASM_ARM_SWITCH_TO_H
 
 #include <linux/thread_info.h>
+#include <asm/smp_plat.h>
 
 /*
  * For v7 SMP cores running a preemptible kernel we may be pre-empted
@@ -40,8 +41,7 @@ static inline void set_ti_cpu(struct task_struct *p)
 do {									\
 	__complete_pending_tlbi();					\
 	set_ti_cpu(next);						\
-	if (IS_ENABLED(CONFIG_CURRENT_POINTER_IN_TPIDRURO) ||		\
-	    IS_ENABLED(CONFIG_SMP))					\
+	if (IS_ENABLED(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || is_smp())	\
 		__this_cpu_write(__entry_task, next);			\
 	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
 } while (0)
diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index d712c170c095..3dcd0f71a0da 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -18,22 +18,32 @@
 	.endm
 
 	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
+#ifdef CONFIG_SMP
+ALT_SMP(nop)
+ALT_UP_B(.L0_\@)
+	.subsection 1
+#endif
+.L0_\@:
 	ldr_va	\tmp1, elf_hwcap
 	mov	\tmp2, #0xffff0fff
 	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
 	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
-	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
-#ifndef CONFIG_SMP
-	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
+	beq	.L2_\@
+	mcr	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
+#ifdef CONFIG_SMP
+	b	.L1_\@
+	.previous
 #endif
-	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
-	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
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
@@ -44,7 +54,7 @@
 #elif defined(CONFIG_CPU_V6)
 #define tls_emu		0
 #define has_tls_reg		(elf_hwcap & HWCAP_TLS)
-#define defer_tls_reg_update	IS_ENABLED(CONFIG_SMP)
+#define defer_tls_reg_update	is_smp()
 #define switch_tls	switch_tls_v6
 #elif defined(CONFIG_CPU_32v6K)
 #define tls_emu		0
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index cb82ff5adec1..9a1dc142f782 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -292,21 +292,18 @@
 
 
 	.macro	restore_user_regs, fast = 0, offset = 0
-#if defined(CONFIG_CPU_32v6K) || defined(CONFIG_SMP)
-#if defined(CONFIG_CPU_V6) && defined(CONFIG_SMP)
-ALT_SMP(b	.L1_\@	)
-ALT_UP( nop		)
-	ldr_va	r1, elf_hwcap
-	tst	r1, #HWCAP_TLS			@ hardware TLS available?
-	beq	.L2_\@
-.L1_\@:
+#if defined(CONFIG_CPU_32v6K) && \
+    (!defined(CONFIG_CPU_V6) || defined(CONFIG_SMP))
+#ifdef CONFIG_CPU_V6
+ALT_SMP(nop)
+ALT_UP_B(.L1_\@)
 #endif
 	@ The TLS register update is deferred until return to user space so we
 	@ can use it for other things while running in the kernel
-	get_thread_info r1
+	mrc	p15, 0, r1, c13, c0, 3		@ get current_thread_info pointer
 	ldr	r1, [r1, #TI_TP_VALUE]
 	mcr	p15, 0, r1, c13, c0, 3		@ set TLS register
-.L2_\@:
+.L1_\@:
 #endif
 
 	uaccess_enable r1, isb=0
-- 
2.30.2

