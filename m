Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC75C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiAXRsv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244120AbiAXRsu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1CC06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE86B811A5
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D6C340EA;
        Mon, 24 Jan 2022 17:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046527;
        bh=Yb8tR6lOHVkGzQnc98AxdPZmcB5pwY5zx+GTphZ6QKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfJcEf4hXd79+IjgD8PomGvttf0SVnsWCPGkHMUn7jvUxeKJu6533aErjrBuAeZvU
         ZmwdCO8hx0Dd40cZtPBsVrJQ4axmAW5ufdVf7HjmcQiqUEjhf4m0hZW2CahL+8xTOw
         kUa3boS2UbpJ87ZtgbUa67+40C5xgpMYExz7ivDcTwdPcDkb5dNNlcR/uiF9aJPHvN
         rsp9UQnenxIX+Yqv+kh0B4cq4FhziFl0iX5tS5qVbff6pxCUq1QxCkGyR4hQiozdqM
         3C/Dn/hhTW6yKjRQba0j8ZX4lBobILMOFXBMJazguILBpahVaHRxJneSL8h/pEMbx4
         a/5f1cJXk7XEQ==
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
Subject: [PATCH v5 16/32] ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
Date:   Mon, 24 Jan 2022 18:47:28 +0100
Message-Id: <20220124174744.1054712-17-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15215; h=from:subject; bh=Yb8tR6lOHVkGzQnc98AxdPZmcB5pwY5zx+GTphZ6QKE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYg/CW4esH63LbOUcp4w0r1VJe8PrDSlNe8q+rK VJM3HtSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mIAAKCRDDTyI5ktmPJHQDDA DChfYP6PVnga842iAW2Dt6ftkjOfcgJeQe4ZbiZfMfbEkDK29mW5utg7PAdqO1IOyqOnZzXdRrmBVP rexjaRySxUshVYhypXbQ320uOiukj9l5Ydhg9I5HwIYfrojCbr4/KZPrkPVx1rsl8ZgA1dN6kQBpDi c5LX1wHxoiABJ/z27/o+YSEua2ap+6zY3qGJa3NqanHatIkYp/jKfhHp6sr5MOzMrBzgMZpObDyRLw mUYPOxNoWe2lflx9yscyfAgrXQGkgSe5KAT1/h1Or2V7UqTAiKyPwJ+S5Q6PW/t0ntXAjgBDSMsDXb uMvEOZW8aa74hp8/1flUFQSEuIysantIdlPI/c4FIrYLe3IFsniJLi9jqExBTIcyyb8yuaIQcnPk8h xraDKw6PyRmbCTgNMsCudEhRjoV+rN/URVUfj0MhPt6XMULaJcV/CJ5MEVncDmefk5mlHQ81WDAEUK dyFgAmdmOyDdyzT6ygOi5McldD1jxO1O17YcM3wK1pjjc=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On UP systems, only a single task can be 'current' at the same time,
which means we can use a global variable to track it. This means we can
also enable THREAD_INFO_IN_TASK for those systems, as in that case,
thread_info is accessed via current rather than the other way around,
removing the need to store thread_info at the base of the task stack.
This, in turn, permits us to enable IRQ stacks and vmap'ed stacks on UP
systems as well.

To partially mitigate the performance overhead of this arrangement, use
a ADD/ADD/LDR sequence with the appropriate PC-relative group
relocations to load the value of current when needed. This means that
accessing current will still only require a single load as before,
avoiding the need for a literal to carry the address of the global
variable in each function. However, accessing thread_info will now
require this load as well.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig                   |  4 +-
 arch/arm/include/asm/assembler.h   | 83 +++++++++++++-------
 arch/arm/include/asm/current.h     | 47 +++++++----
 arch/arm/include/asm/switch_to.h   |  3 +-
 arch/arm/include/asm/thread_info.h | 27 -------
 arch/arm/kernel/asm-offsets.c      |  3 -
 arch/arm/kernel/entry-armv.S       |  9 ++-
 arch/arm/kernel/entry-header.S     |  2 +-
 arch/arm/kernel/entry-v7m.S        | 10 ++-
 arch/arm/kernel/head-common.S      |  4 +-
 arch/arm/kernel/process.c          |  7 +-
 arch/arm/kernel/smp.c              |  6 ++
 12 files changed, 115 insertions(+), 90 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0e1b93de10b4..108a7a872084 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -127,7 +127,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
-	select THREAD_INFO_IN_TASK if CURRENT_POINTER_IN_TPIDRURO
+	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
@@ -1612,7 +1612,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
 
 config STACKPROTECTOR_PER_TASK
 	bool "Use a unique stack canary value for each task"
-	depends on STACKPROTECTOR && THREAD_INFO_IN_TASK && !XIP_DEFLATED_DATA
+	depends on STACKPROTECTOR && CURRENT_POINTER_IN_TPIDRURO && !XIP_DEFLATED_DATA
 	depends on GCC_PLUGINS || CC_HAVE_STACKPROTECTOR_TLS
 	select GCC_PLUGIN_ARM_SSP_PER_TASK if !CC_HAVE_STACKPROTECTOR_TLS
 	default y
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 30752c4427d4..bf304596f87e 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -199,41 +199,12 @@
 	.endm
 	.endr
 
-	.macro	get_current, rd
-#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
-	mrc	p15, 0, \rd, c13, c0, 3		@ get TPIDRURO register
-#else
-	get_thread_info \rd
-	ldr	\rd, [\rd, #TI_TASK]
-#endif
-	.endm
-
-	.macro	set_current, rn
-#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
-	mcr	p15, 0, \rn, c13, c0, 3		@ set TPIDRURO register
-#endif
-	.endm
-
-	.macro	reload_current, t1:req, t2:req
-#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
-	ldr_this_cpu \t1, __entry_task, \t1, \t2
-	mcr	p15, 0, \t1, c13, c0, 3		@ store in TPIDRURO
-#endif
-	.endm
-
 /*
  * Get current thread_info.
  */
 	.macro	get_thread_info, rd
-#ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* thread_info is the first member of struct task_struct */
 	get_current \rd
-#else
- ARM(	mov	\rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
- THUMB(	mov	\rd, sp			)
- THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
-	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
-#endif
 	.endm
 
 /*
@@ -326,6 +297,60 @@ ALT_UP_B(.L0_\@)
 #endif
 	.endm
 
+	/*
+	 * set_current - store the task pointer of this CPU's current task
+	 */
+	.macro		set_current, rn:req, tmp:req
+#if defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
+9998:	mcr		p15, 0, \rn, c13, c0, 3		@ set TPIDRURO register
+#ifdef CONFIG_CPU_V6
+ALT_UP_B(.L0_\@)
+	.subsection	1
+.L0_\@: str_va		\rn, __current, \tmp
+	b		.L1_\@
+	.previous
+.L1_\@:
+#endif
+#else
+	str_va		\rn, __current, \tmp
+#endif
+	.endm
+
+	/*
+	 * get_current - load the task pointer of this CPU's current task
+	 */
+	.macro		get_current, rd:req
+#if defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
+9998:	mrc		p15, 0, \rd, c13, c0, 3		@ get TPIDRURO register
+#ifdef CONFIG_CPU_V6
+ALT_UP_B(.L0_\@)
+	.subsection	1
+.L0_\@: ldr_va		\rd, __current
+	b		.L1_\@
+	.previous
+.L1_\@:
+#endif
+#else
+	ldr_va		\rd, __current
+#endif
+	.endm
+
+	/*
+	 * reload_current - reload the task pointer of this CPU's current task
+	 *		    into the TLS register
+	 */
+	.macro		reload_current, t1:req, t2:req
+#if defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
+#ifdef CONFIG_CPU_V6
+ALT_SMP(nop)
+ALT_UP_B(.L0_\@)
+#endif
+	ldr_this_cpu	\t1, __entry_task, \t1, \t2
+	mcr		p15, 0, \t1, c13, c0, 3		@ store in TPIDRURO
+.L0_\@:
+#endif
+	.endm
+
 /*
  * Instruction barrier
  */
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 6bf0aad672c3..c03706869384 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -8,25 +8,18 @@
 #define _ASM_ARM_CURRENT_H
 
 #ifndef __ASSEMBLY__
+#include <asm/insn.h>
 
 struct task_struct;
 
-static inline void set_current(struct task_struct *cur)
-{
-	if (!IS_ENABLED(CONFIG_CURRENT_POINTER_IN_TPIDRURO))
-		return;
-
-	/* Set TPIDRURO */
-	asm("mcr p15, 0, %0, c13, c0, 3" :: "r"(cur) : "memory");
-}
-
-#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
+extern struct task_struct *__current;
 
-static inline struct task_struct *get_current(void)
+static __always_inline __attribute_const__ struct task_struct *get_current(void)
 {
 	struct task_struct *cur;
 
 #if __has_builtin(__builtin_thread_pointer) && \
+    defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) && \
     !(defined(CONFIG_THUMB2_KERNEL) && \
       defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 130001)
 	/*
@@ -39,16 +32,40 @@ static inline struct task_struct *get_current(void)
 	 * https://github.com/ClangBuiltLinux/linux/issues/1485
 	 */
 	cur = __builtin_thread_pointer();
+#elif defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
+	asm("0:	mrc p15, 0, %0, c13, c0, 3			\n\t"
+#ifdef CONFIG_CPU_V6
+	    "1:							\n\t"
+	    "	.subsection 1					\n\t"
+#if defined(CONFIG_ARM_HAS_GROUP_RELOCS) && \
+    !(defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
+	    "2: " LOAD_SYM_ARMV6(%0, __current) "		\n\t"
+	    "	b	1b					\n\t"
 #else
-	asm("mrc p15, 0, %0, c13, c0, 3" : "=r"(cur));
+	    "2:	ldr	%0, 3f					\n\t"
+	    "	ldr	%0, [%0]				\n\t"
+	    "	b	1b					\n\t"
+	    "3:	.long	__current				\n\t"
+#endif
+	    "	.previous					\n\t"
+	    "	.pushsection \".alt.smp.init\", \"a\"		\n\t"
+	    "	.align	2					\n\t"
+	    "	.long	0b - .					\n\t"
+	    "	b	. + (2b - 0b)				\n\t"
+	    "	.popsection					\n\t"
+#endif
+	    : "=r"(cur));
+#elif __LINUX_ARM_ARCH__>= 7 || \
+      !defined(CONFIG_ARM_HAS_GROUP_RELOCS) || \
+      (defined(MODULE) && defined(CONFIG_ARM_MODULE_PLTS))
+	cur = __current;
+#else
+	asm(LOAD_SYM_ARMV6(%0, __current) : "=r"(cur));
 #endif
 	return cur;
 }
 
 #define current get_current()
-#else
-#include <asm-generic/current.h>
-#endif /* CONFIG_CURRENT_POINTER_IN_TPIDRURO */
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/switch_to.h b/arch/arm/include/asm/switch_to.h
index 61e4a3c4ca6e..9372348516ce 100644
--- a/arch/arm/include/asm/switch_to.h
+++ b/arch/arm/include/asm/switch_to.h
@@ -3,6 +3,7 @@
 #define __ASM_ARM_SWITCH_TO_H
 
 #include <linux/thread_info.h>
+#include <asm/smp_plat.h>
 
 /*
  * For v7 SMP cores running a preemptible kernel we may be pre-empted
@@ -26,7 +27,7 @@ extern struct task_struct *__switch_to(struct task_struct *, struct thread_info
 #define switch_to(prev,next,last)					\
 do {									\
 	__complete_pending_tlbi();					\
-	if (IS_ENABLED(CONFIG_CURRENT_POINTER_IN_TPIDRURO))		\
+	if (IS_ENABLED(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || is_smp())	\
 		__this_cpu_write(__entry_task, next);			\
 	last = __switch_to(prev,task_thread_info(prev), task_thread_info(next));	\
 } while (0)
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 164e15f26485..e039d8f12d9b 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -54,9 +54,6 @@ struct cpu_context_save {
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
-#ifndef CONFIG_THREAD_INFO_IN_TASK
-	struct task_struct	*task;		/* main task structure */
-#endif
 	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
 	struct cpu_context_save	cpu_context;	/* cpu context */
@@ -72,39 +69,15 @@ struct thread_info {
 
 #define INIT_THREAD_INFO(tsk)						\
 {									\
-	INIT_THREAD_INFO_TASK(tsk)					\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 }
 
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-#define INIT_THREAD_INFO_TASK(tsk)
-
 static inline struct task_struct *thread_task(struct thread_info* ti)
 {
 	return (struct task_struct *)ti;
 }
 
-#else
-#define INIT_THREAD_INFO_TASK(tsk)	.task = &(tsk),
-
-static inline struct task_struct *thread_task(struct thread_info* ti)
-{
-	return ti->task;
-}
-
-/*
- * how to get the thread information struct from C
- */
-static inline struct thread_info *current_thread_info(void) __attribute_const__;
-
-static inline struct thread_info *current_thread_info(void)
-{
-	return (struct thread_info *)
-		(current_stack_pointer & ~(THREAD_SIZE - 1));
-}
-#endif
-
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
 #define thread_saved_sp(tsk)	\
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 645845e4982a..2c8d76fd7c66 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -43,9 +43,6 @@ int main(void)
   BLANK();
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
-#ifndef CONFIG_THREAD_INFO_IN_TASK
-  DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-#endif
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 5e01a34369a0..2f912c509e0d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -746,12 +746,13 @@ ENTRY(__switch_to)
 	switch_tls r1, r4, r5, r3, r7
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP) && \
     !defined(CONFIG_STACKPROTECTOR_PER_TASK)
-	ldr	r9, [r2, #TI_TASK]
 	ldr	r8, =__stack_chk_guard
 	.if (TSK_STACK_CANARY > IMM12_MASK)
-	add	r9, r9, #TSK_STACK_CANARY & ~IMM12_MASK
-	.endif
+	add	r9, r2, #TSK_STACK_CANARY & ~IMM12_MASK
 	ldr	r9, [r9, #TSK_STACK_CANARY & IMM12_MASK]
+	.else
+	ldr	r9, [r2, #TSK_STACK_CANARY & IMM12_MASK]
+	.endif
 #endif
 	mov	r7, r2				@ Preserve 'next'
 #ifdef CONFIG_CPU_USE_DOMAINS
@@ -768,7 +769,7 @@ ENTRY(__switch_to)
 #endif
  THUMB(	mov	ip, r4			   )
 	mov	r0, r5
-	set_current r7
+	set_current r7, r8
  ARM(	ldmia	r4, {r4 - sl, fp, sp, pc}  )	@ Load all regs saved previously
  THUMB(	ldmia	ip!, {r4 - sl, fp}	   )	@ Load all regs saved previously
  THUMB(	ldr	sp, [ip], #4		   )
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index da206bd4f194..9f01b229841a 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -300,7 +300,7 @@ ALT_UP_B(.L1_\@)
 #endif
 	@ The TLS register update is deferred until return to user space so we
 	@ can use it for other things while running in the kernel
-	get_thread_info r1
+	mrc	p15, 0, r1, c13, c0, 3		@ get current_thread_info
 	ldr	r1, [r1, #TI_TP_VALUE]
 	mcr	p15, 0, r1, c13, c0, 3		@ set TLS register
 .L1_\@:
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 520dd43e7e08..4e0d318b67c6 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -97,15 +97,17 @@ ENTRY(__switch_to)
 	str	sp, [ip], #4
 	str	lr, [ip], #4
 	mov	r5, r0
+	mov	r6, r2			@ Preserve 'next'
 	add	r4, r2, #TI_CPU_SAVE
 	ldr	r0, =thread_notify_head
 	mov	r1, #THREAD_NOTIFY_SWITCH
 	bl	atomic_notifier_call_chain
-	mov	ip, r4
 	mov	r0, r5
-	ldmia	ip!, {r4 - r11}		@ Load all regs saved previously
-	ldr	sp, [ip]
-	ldr	pc, [ip, #4]!
+	mov	r1, r6
+	ldmia	r4, {r4 - r12, lr}	@ Load all regs saved previously
+	set_current r1, r2
+	mov	sp, ip
+	bx	lr
 	.fnend
 ENDPROC(__switch_to)
 
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index da18e0a17dc2..42cae73fcc19 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -105,10 +105,8 @@ __mmap_switched:
 	mov	r1, #0
 	bl	__memset			@ clear .bss
 
-#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
 	adr_l	r0, init_task			@ get swapper task_struct
-	set_current r0
-#endif
+	set_current r0, r1
 
 	ldmia	r4, {r0, r1, r2, r3}
 	str	r9, [r0]			@ Save processor ID
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d47159f3791c..0617af11377f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -36,7 +36,7 @@
 
 #include "signal.h"
 
-#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRURO
+#if defined(CONFIG_CURRENT_POINTER_IN_TPIDRURO) || defined(CONFIG_SMP)
 DEFINE_PER_CPU(struct task_struct *, __entry_task);
 #endif
 
@@ -46,6 +46,11 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
+#ifndef CONFIG_CURRENT_POINTER_IN_TPIDRURO
+asmlinkage struct task_struct *__current;
+EXPORT_SYMBOL(__current);
+#endif
+
 static const char *processor_modes[] __maybe_unused = {
   "USER_26", "FIQ_26" , "IRQ_26" , "SVC_26" , "UK4_26" , "UK5_26" , "UK6_26" , "UK7_26" ,
   "UK8_26" , "UK9_26" , "UK10_26", "UK11_26", "UK12_26", "UK13_26", "UK14_26", "UK15_26",
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ed2b168ff46c..73fc645fc4c7 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -400,6 +400,12 @@ static void smp_store_cpu_info(unsigned int cpuid)
 	check_cpu_icache_size(cpuid);
 }
 
+static void set_current(struct task_struct *cur)
+{
+	/* Set TPIDRURO */
+	asm("mcr p15, 0, %0, c13, c0, 3" :: "r"(cur) : "memory");
+}
+
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
-- 
2.30.2

