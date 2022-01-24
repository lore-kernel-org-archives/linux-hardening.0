Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFAC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiAXRsj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbiAXRsi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404FAC06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C43C661312
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B1EC340E8;
        Mon, 24 Jan 2022 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046517;
        bh=eMmzRcjpASAjkmFAFfmqCrwEHxj9li5uj93BJiQL2FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZPZ4rZnPVixnstg3xyDgLPdzqHbR3+rK3EtFDNeC/dl8Mc0ZIOj/8dfD8rOQnoJ1
         zWodRCcEkaSHF8gmZVoE2Tlf2Ke5yEhABGwVxrqq8zsHOBnk9x6st1e1puVqA4/owB
         LHLh23gGw/+akkCxHP5XdqWZg/SaEb/eWAeUFgr4eTWdpFlLV13EjXgilMyLK2IqVn
         ssIo19w0CZLmhw88C7a8dsjiTLZujSmI7gODC2iNBwRRY/yGeiuuzXp1aCZ1rRlZef
         omG9XHLcF8iOs5g8h/q30r732uPOMfgH+P+ZXLPZrssPUOIRh7CGGCxMOaWnByKLfz
         Wo0opXTl4yuAw==
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
Subject: [PATCH v5 13/32] ARM: percpu: add SMP_ON_UP support
Date:   Mon, 24 Jan 2022 18:47:25 +0100
Message-Id: <20220124174744.1054712-14-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6979; h=from:subject; bh=eMmzRcjpASAjkmFAFfmqCrwEHxj9li5uj93BJiQL2FM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYaZg1QGI5pD0MXxQZ7caxgDCmY2nuv0N5kOBth hd5bX8yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mGgAKCRDDTyI5ktmPJB/YC/ 4vLa3KaDIzczMLw6aSrkoI7UPf/AAiBgGV2bxUQagjI5QV4928PSjKQ4Vli5yt5kQqCKHQ1F6OEjQr kBc8MhQnuXrk3YNUgHfmKImd+6THXy9ChpOtuEiafy7LIFXZYHbMLZzdwrjeaMBAQRFmT+n7iehF1U 8VvqGSoT2YlxKWOXW/yjo5STbcq7n6I/mpc/gDQSzF4I8nKHvlzh4E9kfaxt/SvYBs13NG97Wqmjt3 FC7fUa7KmymkevEYNQTtaqlVa+0mD8dCtrhMR0nDx97KMhIOY7SN9JToqxuen8sExj2K2qiFFzblvz 3/q+16n0F+GP6LMjt8uv+eZsknEAAAxVKkDKdDzqF+JSXn3Zc11W50N9+jcXVnGDtkraGlNklEtRbW jT74Gga+WIZZ08gWAfJFqgZHPLMi8wCOPU8n2o4O6b/KFQFb+lR2/6zTnnIfilSH9apy+v7HwtYkaj lLZ3xEnSME/mnDSHF37DCmjyy9F6QSJh0kkDcbWz6GnaA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Permit the use of the TPIDRPRW system register for carrying the per-CPU
offset in generic SMP configurations that also target non-SMP capable
ARMv6 cores. This uses the SMP_ON_UP code patching framework to turn all
TPIDRPRW accesses into reads/writes of entry #0 in the __per_cpu_offset
array.

While at it, switch over some existing direct TPIDRPRW accesses in asm
code to invocations of a new helper that is patched in the same way when
necessary.

Note that CPU_V6+SMP without SMP_ON_UP results in a kernel that does not
boot on v6 CPUs without SMP extensions, so add this dependency to
Kconfig as well.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/assembler.h | 61 +++++++++++++++++++-
 arch/arm/include/asm/insn.h      | 17 ++++++
 arch/arm/include/asm/percpu.h    | 36 ++++++++++--
 arch/arm/mm/Kconfig              |  1 +
 4 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 7a4e292b68e4..30752c4427d4 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -216,9 +216,7 @@
 
 	.macro	reload_current, t1:req, t2:req
 #ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
-	adr_l	\t1, __entry_task		@ get __entry_task base address
-	mrc	p15, 0, \t2, c13, c0, 4		@ get per-CPU offset
-	ldr	\t1, [\t1, \t2]			@ load variable
+	ldr_this_cpu \t1, __entry_task, \t1, \t2
 	mcr	p15, 0, \t1, c13, c0, 3		@ store in TPIDRURO
 #endif
 	.endm
@@ -308,6 +306,26 @@
 #define ALT_UP_B(label) b label
 #endif
 
+	/*
+	 * this_cpu_offset - load the per-CPU offset of this CPU into
+	 * 		     register 'rd'
+	 */
+	.macro		this_cpu_offset, rd:req
+#ifdef CONFIG_SMP
+ALT_SMP(mrc		p15, 0, \rd, c13, c0, 4)
+#ifdef CONFIG_CPU_V6
+ALT_UP_B(.L0_\@)
+	.subsection	1
+.L0_\@: ldr_va		\rd, __per_cpu_offset
+	b		.L1_\@
+	.previous
+.L1_\@:
+#endif
+#else
+	mov		\rd, #0
+#endif
+	.endm
+
 /*
  * Instruction barrier
  */
@@ -647,6 +665,43 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	__ldst_va	str, \rn, \tmp, \sym
 	.endm
 
+	/*
+	 * ldr_this_cpu_armv6 - Load a 32-bit word from the per-CPU variable 'sym',
+	 *			without using a temp register. Supported in ARM mode
+	 *			only.
+	 */
+	.macro		ldr_this_cpu_armv6, rd:req, sym:req
+	this_cpu_offset	\rd
+	.globl		\sym
+	.reloc		.L0_\@, R_ARM_ALU_PC_G0_NC, \sym
+	.reloc		.L1_\@, R_ARM_ALU_PC_G1_NC, \sym
+	.reloc		.L2_\@, R_ARM_LDR_PC_G2, \sym
+	add		\rd, \rd, pc
+.L0_\@: sub		\rd, \rd, #4
+.L1_\@: sub		\rd, \rd, #0
+.L2_\@: ldr		\rd, [\rd, #4]
+	.endm
+
+	/*
+	 * ldr_this_cpu - Load a 32-bit word from the per-CPU variable 'sym'
+	 *		  into register 'rd', which may be the stack pointer,
+	 *		  using 't1' and 't2' as general temp registers. These
+	 *		  are permitted to overlap with 'rd' if != sp
+	 */
+	.macro		ldr_this_cpu, rd:req, sym:req, t1:req, t2:req
+#ifndef CONFIG_SMP
+	ldr_va		\rd, \sym,, \t1			@ CPU offset == 0x0
+#elif __LINUX_ARM_ARCH__ >= 7 || \
+      !defined(CONFIG_ARM_HAS_GROUP_RELOCS) || \
+      (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
+	this_cpu_offset	\t1
+	mov_l		\t2, \sym
+	ldr		\rd, [\t1, \t2]
+#else
+	ldr_this_cpu_armv6 \rd, \sym
+#endif
+	.endm
+
 	/*
 	 * rev_l - byte-swap a 32-bit value
 	 *
diff --git a/arch/arm/include/asm/insn.h b/arch/arm/include/asm/insn.h
index 5475cbf9fb6b..faf3d1c28368 100644
--- a/arch/arm/include/asm/insn.h
+++ b/arch/arm/include/asm/insn.h
@@ -2,6 +2,23 @@
 #ifndef __ASM_ARM_INSN_H
 #define __ASM_ARM_INSN_H
 
+#include <linux/types.h>
+
+/*
+ * Avoid a literal load by emitting a sequence of ADD/LDR instructions with the
+ * appropriate relocations. The combined sequence has a range of -/+ 256 MiB,
+ * which should be sufficient for the core kernel as well as modules loaded
+ * into the module region. (Not supported by LLD before release 14)
+ */
+#define LOAD_SYM_ARMV6(reg, sym)					\
+	"	.globl	" #sym "				\n\t"	\
+	"	.reloc	10f, R_ARM_ALU_PC_G0_NC, " #sym "	\n\t"	\
+	"	.reloc	11f, R_ARM_ALU_PC_G1_NC, " #sym "	\n\t"	\
+	"	.reloc	12f, R_ARM_LDR_PC_G2, " #sym "		\n\t"	\
+	"10:	sub	" #reg ", pc, #8			\n\t"	\
+	"11:	sub	" #reg ", " #reg ", #4			\n\t"	\
+	"12:	ldr	" #reg ", [" #reg ", #0]		\n\t"
+
 static inline unsigned long
 arm_gen_nop(void)
 {
diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index e2fcb3cfd3de..7feba9d65e85 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,20 +5,27 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+#include <asm/insn.h>
+
 register unsigned long current_stack_pointer asm ("sp");
 
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
  */
-#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
+#ifdef CONFIG_SMP
 static inline void set_my_cpu_offset(unsigned long off)
 {
+	extern unsigned int smp_on_up;
+
+	if (IS_ENABLED(CONFIG_CPU_V6) && !smp_on_up)
+		return;
+
 	/* Set TPIDRPRW */
 	asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
 }
 
-static inline unsigned long __my_cpu_offset(void)
+static __always_inline unsigned long __my_cpu_offset(void)
 {
 	unsigned long off;
 
@@ -27,8 +34,29 @@ static inline unsigned long __my_cpu_offset(void)
 	 * We want to allow caching the value, so avoid using volatile and
 	 * instead use a fake stack read to hazard against barrier().
 	 */
-	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off)
-		: "Q" (*(const unsigned long *)current_stack_pointer));
+	asm("0:	mrc p15, 0, %0, c13, c0, 4			\n\t"
+#ifdef CONFIG_CPU_V6
+	    "1:							\n\t"
+	    "	.subsection 1					\n\t"
+#if defined(CONFIG_ARM_HAS_GROUP_RELOCS) && \
+    !(defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
+	    "2: " LOAD_SYM_ARMV6(%0, __per_cpu_offset) "	\n\t"
+	    "	b	1b					\n\t"
+#else
+	    "2: ldr	%0, 3f					\n\t"
+	    "	ldr	%0, [%0]				\n\t"
+	    "	b	1b					\n\t"
+	    "3:	.long	__per_cpu_offset			\n\t"
+#endif
+	    "	.previous					\n\t"
+	    "	.pushsection \".alt.smp.init\", \"a\"		\n\t"
+	    "	.align	2					\n\t"
+	    "	.long	0b - .					\n\t"
+	    "	b	. + (2b - 0b)				\n\t"
+	    "	.popsection					\n\t"
+#endif
+	    : "=r" (off)
+	    : "Q" (*(const unsigned long *)current_stack_pointer));
 
 	return off;
 }
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 58afba346729..a91ff22c6c2e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -386,6 +386,7 @@ config CPU_V6
 	select CPU_PABRT_V6
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
+	select SMP_ON_UP if SMP
 
 # ARMv6k
 config CPU_V6K
-- 
2.30.2

