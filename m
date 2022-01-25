Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE24EC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455514AbiAYJ1G (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48984 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457397AbiAYJPM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:15:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57B961520
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D4AC340EB;
        Tue, 25 Jan 2022 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102107;
        bh=7HlVD05SkXizpl7tEfj25ZvyZuQshFuhgIjqL7v4bgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KC02KkW2t1QVoqzIjpk6i6V6ybXuk2dJL+lVlysPSQ5Ap3/Q/Fp/YdA7mw9btVkf7
         8/CY17REUXSq8HtG9vPu8RMX2FpeLhJSBfTzdIaPIBLRMsjkiMp3YCaRCbPooG5CEf
         eaRZZnOyz23XbT9qqDj7wi8pMUvz7/dRe7HFIQV/AUp1y7KU6jj1fQLmHop8vrpwNH
         0G9wqmu9aPc2mXsqRpPf8fg2QimQ1c3jxST42U2oIF8bDYqv3qxPYPwBVJdUQnfTAT
         0K6UGHBvuuHEDSkmxF59nekz9fXI6xR7YAWh9P42tutmp9b6h8/Kyp4VURR9YmvY9v
         VQO6hwVnz8dDg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 2/8] ARM: assembler: define a Kconfig symbol for group relocation support
Date:   Tue, 25 Jan 2022 10:14:47 +0100
Message-Id: <20220125091453.1475246-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6264; h=from:subject; bh=7HlVD05SkXizpl7tEfj25ZvyZuQshFuhgIjqL7v4bgc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+A9sMUYkRtcYQMDCDYTp3v6UAQfQG1Xe70vKp8 hEtiV4CJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/gAAKCRDDTyI5ktmPJFbEC/ 4k1EsmzMc66Pc4yPvJaGOqqSL5TobZz/8CrobbYE3fgN+0/cK4SLF0o+PjUetSKpSt7gUFYli0MI1I exl+4dOFkiB8EKPiYwdSGu8xsnHo9XowPZZvXi0xfBNGW2xXtmOkIVllIntMCva9hPDL63uwbTKkz+ lTZrRHRBccHEsfQLK1lqepSBXIoQCA7gNdsvVjHBCLv13O7TSYml7Q67o6LCQEx83dcPpZ15tK9QwG rxiN9U4n9WcYxhOAFpUpz33Mq/mmO1387PSRR+TXqwdVC0jnG2jQm7avdyD+Yt936jolOtXEuFzUum KplkFrRFbIpKVeruNneASSWrjRJ7tbsOB1kFhkApOsmPwFe+bzBgzdPKWuJ0ZcOzn+wZHqGaokop9i zdu6DbYh+uG+MizsGTXDI6wHTzXO5MLERfu+ofSJR0O0NGojCWml6iiI3waxzkyi4Aw6F8JSAGTyhY Glbq0hxyIU2DChPeBYxUNjbTEIpEM1lRHcCwdJDWrUTnk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Nathan reports the group relocations go out of range in pathological
cases such as allyesconfig kernels, which have little chance of actually
booting but are still used in validation.

So add a Kconfig symbol for this feature, and make it depend on
!COMPILE_TEST.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/Kconfig                 | 13 ++++++++++++-
 arch/arm/include/asm/assembler.h |  8 ++++----
 arch/arm/include/asm/current.h   |  8 ++++----
 arch/arm/include/asm/percpu.h    |  4 ++--
 arch/arm/kernel/module.c         |  7 ++++++-
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 359a3b85c8b3..70ab8d807032 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -128,7 +128,7 @@ config ARM
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
-	select HAVE_ARCH_VMAP_STACK if MMU && (!LD_IS_LLD || LLD_VERSION >= 140000)
+	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
@@ -140,6 +140,17 @@ config ARM
 	  Europe.  There is an ARM Linux project with a web page at
 	  <http://www.arm.linux.org.uk/>.
 
+config ARM_HAS_GROUP_RELOCS
+	def_bool y
+	depends on !LD_IS_LLD || LLD_VERSION >= 140000
+	depends on !COMPILE_TEST
+	help
+	  Whether or not to use R_ARM_ALU_PC_Gn or R_ARM_LDR_PC_Gn group
+	  relocations, which have been around for a long time, but were not
+	  supported in LLD until version 14. The combined range is -/+ 256 MiB,
+	  which is usually sufficient, but not for allyesconfig, so we disable
+	  this feature when doing compile testing.
+
 config ARM_HAS_SG_CHAIN
 	bool
 
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 59d7b9e81934..9998718a49ca 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -656,8 +656,8 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 
 	.macro		__ldst_va, op, reg, tmp, sym, cond
 #if __LINUX_ARM_ARCH__ >= 7 || \
-    (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS)) || \
-    (defined(CONFIG_LD_IS_LLD) && CONFIG_LLD_VERSION < 140000)
+    !defined(CONFIG_ARM_HAS_GROUP_RELOCS) || \
+    (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
 	mov_l		\tmp, \sym, \cond
 	\op\cond	\reg, [\tmp]
 #else
@@ -716,8 +716,8 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	 */
 	.macro		ldr_this_cpu, rd:req, sym:req, t1:req, t2:req
 #if __LINUX_ARM_ARCH__ >= 7 || \
-    (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS)) || \
-    (defined(CONFIG_LD_IS_LLD) && CONFIG_LLD_VERSION < 140000)
+    !defined(CONFIG_ARM_HAS_GROUP_RELOCS) || \
+    (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
 	this_cpu_offset	\t1
 	mov_l		\t2, \sym
 	ldr		\rd, [\t1, \t2]
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 2f9d79214b25..131a89bbec6b 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -37,8 +37,8 @@ static inline __attribute_const__ struct task_struct *get_current(void)
 #ifdef CONFIG_CPU_V6
 	    "1:							\n\t"
 	    "	.subsection 1					\n\t"
-#if !(defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS)) && \
-    !(defined(CONFIG_LD_IS_LLD) && CONFIG_LLD_VERSION < 140000)
+#if defined(CONFIG_ARM_HAS_GROUP_RELOCS) && \
+    !(defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
 	    "2: " LOAD_SYM_ARMV6(%0, __current) "		\n\t"
 	    "	b	1b					\n\t"
 #else
@@ -55,8 +55,8 @@ static inline __attribute_const__ struct task_struct *get_current(void)
 #endif
 	    : "=r"(cur));
 #elif __LINUX_ARM_ARCH__>= 7 || \
-      (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS)) || \
-      (defined(CONFIG_LD_IS_LLD) && CONFIG_LLD_VERSION < 140000)
+      !defined(CONFIG_ARM_HAS_GROUP_RELOCS) || \
+      (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
 	cur = __current;
 #else
 	asm(LOAD_SYM_ARMV6(%0, __current) : "=r"(cur));
diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index 28961d60877d..a09034ae45a1 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -38,8 +38,8 @@ static inline unsigned long __my_cpu_offset(void)
 #ifdef CONFIG_CPU_V6
 	    "1:							\n\t"
 	    "	.subsection 1					\n\t"
-#if !(defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS)) && \
-    !(defined(CONFIG_LD_IS_LLD) && CONFIG_LLD_VERSION < 140000)
+#if defined(CONFIG_ARM_HAS_GROUP_RELOCS) && \
+    !(defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
 	    "2: " LOAD_SYM_ARMV6(%0, __per_cpu_offset) "	\n\t"
 	    "	b	1b					\n\t"
 #else
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 4d33a7acf617..549abcedf795 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -68,6 +68,7 @@ bool module_exit_section(const char *name)
 		strstarts(name, ".ARM.exidx.exit");
 }
 
+#ifdef CONFIG_ARM_HAS_GROUP_RELOCS
 /*
  * This implements the partitioning algorithm for group relocations as
  * documented in the ARM AArch32 ELF psABI (IHI 0044).
@@ -103,6 +104,7 @@ static u32 get_group_rem(u32 group, u32 *offset)
 	} while (group--);
 	return shift;
 }
+#endif
 
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
@@ -118,7 +120,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		unsigned long loc;
 		Elf32_Sym *sym;
 		const char *symname;
+#ifdef CONFIG_ARM_HAS_GROUP_RELOCS
 		u32 shift, group = 1;
+#endif
 		s32 offset;
 		u32 tmp;
 #ifdef CONFIG_THUMB2_KERNEL
@@ -249,6 +253,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			*(u32 *)loc = __opcode_to_mem_arm(tmp);
 			break;
 
+#ifdef CONFIG_ARM_HAS_GROUP_RELOCS
 		case R_ARM_ALU_PC_G0_NC:
 			group = 0;
 			fallthrough;
@@ -296,7 +301,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			}
 			*(u32 *)loc = __opcode_to_mem_arm((tmp & ~0xfff) | offset);
 			break;
-
+#endif
 #ifdef CONFIG_THUMB2_KERNEL
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
-- 
2.30.2

