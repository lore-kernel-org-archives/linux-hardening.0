Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D9C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiAXRtK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43938 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiAXRtI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7774261301
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ED4C340E8;
        Mon, 24 Jan 2022 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046546;
        bh=SWdoDEnsMcjRQFC3Qk0Dc49/nleMsaddzmvP9xDhShA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrXXiewELlgI72/YMhwroRyiXR4KsyGGLKi2XuLnVQEK4qePNcwpbU415i+rTyUqA
         YkYnnwWkbVOhxTTk6bOfK3dJbbTfCgRgylFRTplFlcRtCccmQvNKUW087zYMShTuaw
         DFE6Gqs9VJFIhEJ80LnDTHUH59+vb8ACnz66Re+xllIT/lwX6CAcF5A6nAqgOkLRHm
         m4QqlMkjsylZ6QViGr3KeA53Gy3D6dyByfvybLB7GdVOxiSLIz39K2Fi4PwTV5J54n
         fQLv2rxSjFBX+X2v2Ab5JREwSDEDrrbOMFIrgECub3IlEF45o6dnorPaZUMNusoyUn
         q15NbYKjXgB0A==
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
Subject: [PATCH v5 22/32] ARM: implement IRQ stacks
Date:   Mon, 24 Jan 2022 18:47:34 +0100
Message-Id: <20220124174744.1054712-23-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7809; h=from:subject; bh=SWdoDEnsMcjRQFC3Qk0Dc49/nleMsaddzmvP9xDhShA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uYrFzeWRCzdRcxcPS38KFgfnSYtiOqNbDxC8g4U 1x11FdGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mKwAKCRDDTyI5ktmPJNo9DA CebUazuC66eR+xqLEDI/ByH22N/dqLkHgxqh041SLJvUeD6FGUbyHPFinGmGSaQSh42zmxeAiphFhT JI5/nDZLApCTWGb/0317ujO7ujTht6+wmW6qcZ+gZ5UMyClnbCMwspZY2vJCyptmD237PzAIqijB5H 24l/kxhO3htowP80pVUBvjJbLVb86mbjyiYvNqlJcI4mLfeHvOkrUqbS8ymCPJ10JC59cpLKH5gCdP cM8h9upy4zUKKUTz/oz9ZlBogqUd3OUPbRtQZbTccHag7VBAZlNwnOKUCOlFlsYuJHMtQ31K57X4hX M+pYoT6t7BV84BQIPG+hGO/ffB6+i3ftkuv6L/VcqH3g0m5AIsls2GJOuRK8meV4A/FzMxZxPjK2LN KjLrgCsVBnP7cHSOxLvhXG/BDjfldoYBlZQ/huqNe5tOHRCQ+dI63PO3bywOCUGnS8Yj6rIVP7qNXt YmE/h0OXXc7+mTHnlM1ejFqKlLhgRak2ID2bShfY486Jw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Now that we no longer rely on the stack pointer to access the current
task struct or thread info, we can implement support for IRQ stacks
cleanly as well.

Define a per-CPU IRQ stack and switch to this stack when taking an IRQ,
provided that we were not already using that stack in the interrupted
context. This is never the case for IRQs taken from user space, but ones
taken while running in the kernel could fire while one taken from user
space has not completed yet.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/include/asm/assembler.h |  4 ++
 arch/arm/kernel/entry-armv.S     | 48 ++++++++++++++++++--
 arch/arm/kernel/entry-v7m.S      | 17 ++++++-
 arch/arm/kernel/irq.c            | 17 +++++++
 arch/arm/kernel/traps.c          | 15 +++++-
 arch/arm/lib/backtrace-clang.S   |  7 +++
 arch/arm/lib/backtrace.S         |  7 +++
 7 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 7242e9a56650..f961f99721dd 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -86,6 +86,10 @@
 
 #define IMM12_MASK 0xfff
 
+/* the frame pointer used for stack unwinding */
+ARM(	fpreg	.req	r11	)
+THUMB(	fpreg	.req	r7	)
+
 /*
  * Enable and disable interrupts
  */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 2f912c509e0d..38e3978a50a9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -32,9 +32,51 @@
 /*
  * Interrupt handling.
  */
-	.macro	irq_handler
+	.macro	irq_handler, from_user:req
 	mov	r0, sp
+#ifdef CONFIG_UNWINDER_ARM
+	mov	fpreg, sp		@ Preserve original SP
+#else
+	mov	r7, fp			@ Preserve original FP
+	mov	r8, sp			@ Preserve original SP
+#endif
+	ldr_this_cpu sp, irq_stack_ptr, r2, r3
+	.if	\from_user == 0
+UNWIND( .setfp	fpreg, sp		)
+	@
+	@ If we took the interrupt while running in the kernel, we may already
+	@ be using the IRQ stack, so revert to the original value in that case.
+	@
+	subs	r2, sp, r0		@ SP above bottom of IRQ stack?
+	rsbscs	r2, r2, #THREAD_SIZE	@ ... and below the top?
+	movcs	sp, r0			@ If so, revert to incoming SP
+
+#ifndef CONFIG_UNWINDER_ARM
+	@
+	@ Inform the frame pointer unwinder where the next frame lives
+	@
+	movcc	lr, pc			@ Make LR point into .entry.text so
+					@ that we will get a dump of the
+					@ exception stack for this frame.
+#ifdef CONFIG_CC_IS_GCC
+	movcc	ip, r0			@ Store the old SP in the frame record.
+	stmdbcc	sp!, {fp, ip, lr, pc}	@ Push frame record
+	addcc	fp, sp, #12
+#else
+	stmdbcc	sp!, {fp, lr}		@ Push frame record
+	movcc	fp, sp
+#endif // CONFIG_CC_IS_GCC
+#endif // CONFIG_UNWINDER_ARM
+	.endif
+
 	bl	generic_handle_arch_irq
+
+#ifdef CONFIG_UNWINDER_ARM
+	mov	sp, fpreg		@ Restore original SP
+#else
+	mov	fp, r7			@ Restore original FP
+	mov	sp, r8			@ Restore original SP
+#endif // CONFIG_UNWINDER_ARM
 	.endm
 
 	.macro	pabt_helper
@@ -191,7 +233,7 @@ ENDPROC(__dabt_svc)
 	.align	5
 __irq_svc:
 	svc_entry
-	irq_handler
+	irq_handler from_user=0
 
 #ifdef CONFIG_PREEMPTION
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
@@ -418,7 +460,7 @@ ENDPROC(__dabt_usr)
 __irq_usr:
 	usr_entry
 	kuser_cmpxchg_check
-	irq_handler
+	irq_handler from_user=1
 	get_thread_info tsk
 	mov	why, #0
 	b	ret_to_user_from_irq
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 4e0d318b67c6..de8a60363c85 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -40,11 +40,24 @@ __irq_entry:
 	@ Invoke the IRQ handler
 	@
 	mov	r0, sp
-	stmdb	sp!, {lr}
+	ldr_this_cpu sp, irq_stack_ptr, r1, r2
+
+	@
+	@ If we took the interrupt while running in the kernel, we may already
+	@ be using the IRQ stack, so revert to the original value in that case.
+	@
+	subs	r2, sp, r0		@ SP above bottom of IRQ stack?
+	rsbscs	r2, r2, #THREAD_SIZE	@ ... and below the top?
+	movcs	sp, r0
+
+	push	{r0, lr}		@ preserve LR and original SP
+
 	@ routine called with r0 = struct pt_regs *
 	bl	generic_handle_arch_irq
 
-	pop	{lr}
+	pop	{r0, lr}
+	mov	sp, r0
+
 	@
 	@ Check for any pending work if returning to user
 	@
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 5a1e52a4ee11..92ae80a8e5b4 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -43,6 +43,21 @@
 
 unsigned long irq_err_count;
 
+asmlinkage DEFINE_PER_CPU_READ_MOSTLY(u8 *, irq_stack_ptr);
+
+static void __init init_irq_stacks(void)
+{
+	u8 *stack;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		stack = (u8 *)__get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
+		if (WARN_ON(!stack))
+			break;
+		per_cpu(irq_stack_ptr, cpu) = &stack[THREAD_SIZE];
+	}
+}
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 #ifdef CONFIG_FIQ
@@ -84,6 +99,8 @@ void __init init_IRQ(void)
 {
 	int ret;
 
+	init_irq_stacks();
+
 	if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
 		irqchip_init();
 	else
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index c51b87f6fc3e..1b8bef286fbc 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -66,6 +66,19 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 {
 	unsigned long end = frame + 4 + sizeof(struct pt_regs);
 
+	if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER) &&
+	    IS_ENABLED(CONFIG_CC_IS_GCC) &&
+	    end > ALIGN(frame, THREAD_SIZE)) {
+		/*
+		 * If we are walking past the end of the stack, it may be due
+		 * to the fact that we are on an IRQ or overflow stack. In this
+		 * case, we can load the address of the other stack from the
+		 * frame record.
+		 */
+		frame = ((unsigned long *)frame)[-2] - 4;
+		end = frame + 4 + sizeof(struct pt_regs);
+	}
+
 #ifndef CONFIG_KALLSYMS
 	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
 		loglvl, where, from);
@@ -280,7 +293,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+			 ALIGN(regs->ARM_sp, THREAD_SIZE));
 		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 5b4bca85d06d..1f0814b41bcf 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -197,6 +197,13 @@ finished_setup:
 
 		cmp	sv_fp, frame		@ next frame must be
 		mov	frame, sv_fp		@ above the current frame
+
+		@
+		@ Kernel stacks may be discontiguous in memory. If the next
+		@ frame is below the previous frame, accept it as long as it
+		@ lives in kernel memory.
+		@
+		cmpls	sv_fp, #PAGE_OFFSET
 		bhi	for_each_frame
 
 1006:		adr	r0, .Lbad
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index e8408f22d4dc..e6e8451c5cb3 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -98,6 +98,13 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 
 		cmp	sv_fp, frame		@ next frame must be
 		mov	frame, sv_fp		@ above the current frame
+
+		@
+		@ Kernel stacks may be discontiguous in memory. If the next
+		@ frame is below the previous frame, accept it as long as it
+		@ lives in kernel memory.
+		@
+		cmpls	sv_fp, #PAGE_OFFSET
 		bhi	for_each_frame
 
 1006:		adr	r0, .Lbad
-- 
2.30.2

