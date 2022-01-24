Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A0C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiAXRtn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50832 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiAXRtm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 547F2B811AE
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB82C340E8;
        Mon, 24 Jan 2022 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046580;
        bh=jHWWpER0hrK/bud4ZT+WTnUvrZIJiAorsKw4xpiitIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chWkQz0R+HE3X8/zsI87jRrr01QbKy5MjgFL/yYiTt7RhEMCFtl5kb/owMPoDsivy
         Dv9jhg+4Q+kEiCm7c3zszQwvb/jcdip22yi1XGdyFXOlIK4xI1krXn+bYrDfj7Lv/M
         NsRGZ/Qp6eXPa4p07CICCmC5LSydDJ7l+sKYx1GySEeN3u+2+6R1L/y4X+vvHCeTQt
         xCPkUjHSXaABo2B4ak4rcQjZNy9Nu43lKPgBLj95mdpT/TyPUzmqfG3rtJHIQRVuWc
         TQfSgzav+TX9765tA/hbZqOzNf5GouR68wtmTeG1z44ioEXO4UiRwHd0876WmdQadM
         uGt5EDq8/aGvg==
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
Subject: [PATCH v5 32/32] ARM: implement support for vmap'ed stacks
Date:   Mon, 24 Jan 2022 18:47:44 +0100
Message-Id: <20220124174744.1054712-33-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18165; h=from:subject; bh=jHWWpER0hrK/bud4ZT+WTnUvrZIJiAorsKw4xpiitIM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uY/biOZhC2PsdpL5hxlXIuuk4sCxyWSWPNkEOIi 822oUzyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mPwAKCRDDTyI5ktmPJJ1KC/ 9YYcXTo3HDVzyH409W/7MQYf0c0xN8Fd8c2htLq9Qy6aMBHWN3RWxQjnlp3r8tzRSjrU9+uY/fvlkS EUDzHqJtsqSwh1cL8SpRKzBqgykn4+1o0SRS/scASzAyi7yHlEh2vS8Lb67QDdw4sfEXUmB7OJxcJW ZslnW0SZHFgHoRuQWDjCpYFmWEBclmrQUSBYuX/jKzIS7Z5rOvJpddDo706c8XtftuHRrsO7w0VRzj 3HvZ50SQE6c82ajr31QFnf8mFpgMK+bQ8JKBsdx4BXjs72JWIimn4mw9CAAB7KnDyFdwpSG79Md1ck pvw5AfxXXwWScxXUyOVCdWPRV1NtYqJQcx/9vebv8tp2E57CEzNk/bT8A6NSrMmojyubO+3o+Zz9UY I6Rv6XxGkA4SfslEs2TBg2Pr8i8F9jVW7X+M7hJ1Nv2ZDdH653+jsDGK1jFR7CsF3xO6GecKIhQnJJ VpReu/TOXNCIQ8yd2zh+vi7NeYqbBvY9+PmptjCsFvJpw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Wire up the generic support for managing task stack allocations via vmalloc,
and implement the entry code that detects whether we faulted because of a
stack overrun (or future stack overrun caused by pushing the pt_regs array)

While this adds a fair amount of tricky entry asm code, it should be
noted that it only adds a TST + branch to the svc_entry path. The code
implementing the non-trivial handling of the overflow stack is emitted
out-of-line into the .text section.

Since on !LPAE, we rely on do_translation_fault() to keep PMD level page
table entries that cover the vmalloc region up to date, we need to
ensure that we don't hit such a stale PMD entry when accessing the
stack, as the fault handler itself needs a stack to run as well. So
let's bump the vmalloc_seq counter when PMD level entries in the vmalloc
range are modified, so that the MM switch fetches the latest version of
the entries. To ensure that kernel threads executing with an active_mm
other than init_mm are up to date, add an implementation of
enter_lazy_tlb() to handle this case.

Note that the page table walker is not an ordinary observer in terms of
concurrency, which means that memory barriers alone are not sufficient
to prevent spurious translation faults from occurring when accessing the
stack after a context switch. For this reason, a dummy read from the new
stack is added to __switch_to() right before switching to it, so that
any faults can be dealt with by do_translation_fault() while the old
stack is still active.

Also note that we need to increase the per-mode stack by 1 word, to gain
some space to stash a GPR until we know it is safe to touch the stack.
However, due to the cacheline alignment of the struct, this does not
actually increase the memory footprint of the struct stack array at all.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Keith Packard <keithpac@amazon.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/mmu_context.h |  9 ++
 arch/arm/include/asm/page.h        |  3 +
 arch/arm/include/asm/thread_info.h |  8 ++
 arch/arm/kernel/entry-armv.S       | 91 ++++++++++++++++++--
 arch/arm/kernel/entry-header.S     | 37 ++++++++
 arch/arm/kernel/head.S             |  7 ++
 arch/arm/kernel/irq.c              |  9 +-
 arch/arm/kernel/setup.c            |  8 +-
 arch/arm/kernel/sleep.S            | 13 +++
 arch/arm/kernel/traps.c            | 69 ++++++++++++++-
 arch/arm/kernel/unwind.c           |  3 +-
 arch/arm/kernel/vmlinux.lds.S      |  4 +-
 13 files changed, 247 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b959249dd716..cbbe38f55088 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -130,6 +130,7 @@ config ARM
 	select THREAD_INFO_IN_TASK
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_SOFTIRQ_ON_OWN_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 71a26986efb9..db2cb06aa8cf 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -138,6 +138,15 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #endif
 }
 
+#ifdef CONFIG_VMAP_STACK
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (mm != &init_mm)
+		check_vmalloc_seq(mm);
+}
+#define enter_lazy_tlb enter_lazy_tlb
+#endif
+
 #include <asm-generic/mmu_context.h>
 
 #endif
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 11b058a72a5b..5fcc8a600e36 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -147,6 +147,9 @@ extern void copy_page(void *to, const void *from);
 #include <asm/pgtable-3level-types.h>
 #else
 #include <asm/pgtable-2level-types.h>
+#ifdef CONFIG_VMAP_STACK
+#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
+#endif
 #endif
 
 #endif /* CONFIG_MMU */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index e039d8f12d9b..aecc403b2880 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -25,6 +25,14 @@
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 #define THREAD_START_SP		(THREAD_SIZE - 8)
 
+#ifdef CONFIG_VMAP_STACK
+#define THREAD_ALIGN		(2 * THREAD_SIZE)
+#else
+#define THREAD_ALIGN		THREAD_SIZE
+#endif
+
+#define OVERFLOW_STACK_SIZE	SZ_4K
+
 #ifndef __ASSEMBLY__
 
 struct task_struct;
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 86be80159c14..e098cc4de426 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -49,6 +49,10 @@ UNWIND( .setfp	fpreg, sp		)
 	@
 	subs	r2, sp, r0		@ SP above bottom of IRQ stack?
 	rsbscs	r2, r2, #THREAD_SIZE	@ ... and below the top?
+#ifdef CONFIG_VMAP_STACK
+	ldr_va	r2, high_memory, cc	@ End of the linear region
+	cmpcc	r2, r0			@ Stack pointer was below it?
+#endif
 	movcs	sp, r0			@ If so, revert to incoming SP
 
 #ifndef CONFIG_UNWINDER_ARM
@@ -174,13 +178,18 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1
+	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1, overflow_check=1
  UNWIND(.fnstart		)
- UNWIND(.save {r0 - pc}		)
 	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole)
+ THUMB( add	sp, r1		)	@ get SP in a GPR without
+ THUMB( sub	r1, sp, r1	)	@ using a temp register
+
+	.if	\overflow_check
+ UNWIND(.save	{r0 - pc}	)
+	do_overflow_check (SVC_REGS_SIZE + \stack_hole)
+	.endif
+
 #ifdef CONFIG_THUMB2_KERNEL
-	add	sp, r1			@ get SP in a GPR without
-	sub	r1, sp, r1		@ using a temp register
 	tst	r1, #4			@ test stack pointer alignment
 	sub	r1, sp, r1		@ restore original R1
 	sub	sp, r1			@ restore original SP
@@ -814,16 +823,88 @@ ENTRY(__switch_to)
 #endif
 	mov	r0, r5
 	set_current r7, r8
-#if !defined(CONFIG_THUMB2_KERNEL)
+#if !defined(CONFIG_THUMB2_KERNEL) && \
+    !(defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE))
 	ldmia	r4, {r4 - sl, fp, sp, pc}	@ Load all regs saved previously
 #else
 	ldmia	r4, {r4 - sl, fp, ip, lr}	@ Thumb2 does not permit SP here
+#if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
+	@ Even though we take care to ensure that the previous task's active_mm
+	@ has the correct translation for next's task stack, the architecture
+	@ permits that a translation fault caused by a speculative access is
+	@ taken once the result of the access should become architecturally
+	@ visible. Usually, we rely on do_translation_fault() to fix this up
+	@ transparently, but that only works for the stack if we are not using
+	@ it when taking the fault. So do a dummy read from next's stack while
+	@ still running from prev's stack, so that any faults get taken here.
+	ldr	r2, [ip]
+#endif
 	mov	sp, ip
 	ret	lr
 #endif
  UNWIND(.fnend		)
 ENDPROC(__switch_to)
 
+#ifdef CONFIG_VMAP_STACK
+	.text
+	.align	2
+__bad_stack:
+	@
+	@ We've just detected an overflow. We need to load the address of this
+	@ CPU's overflow stack into the stack pointer register. We have only one
+	@ register available so let's switch to ARM mode and use the per-CPU
+	@ variable accessor that does not require any scratch registers.
+	@
+	@ We enter here with IP clobbered and its value stashed on the mode
+	@ stack.
+	@
+THUMB(	bx	pc		)
+THUMB(	nop			)
+THUMB(	.arm			)
+	ldr_this_cpu_armv6 ip, overflow_stack_ptr
+
+	str	sp, [ip, #-4]!			@ Preserve original SP value
+	mov	sp, ip				@ Switch to overflow stack
+	pop	{ip}				@ Original SP in IP
+
+#if defined(CONFIG_UNWINDER_FRAME_POINTER) && defined(CONFIG_CC_IS_GCC)
+	mov	ip, ip				@ mov expected by unwinder
+	push	{fp, ip, lr, pc}		@ GCC flavor frame record
+#else
+	str	ip, [sp, #-8]!			@ store original SP
+	push	{fpreg, lr}			@ Clang flavor frame record
+#endif
+UNWIND( ldr	ip, [r0, #4]	)		@ load exception LR
+UNWIND( str	ip, [sp, #12]	)		@ store in the frame record
+	ldr	ip, [r0, #12]			@ reload IP
+
+	@ Store the original GPRs to the new stack.
+	svc_entry uaccess=0, overflow_check=0
+
+UNWIND( .save   {sp, pc}	)
+UNWIND( .save   {fpreg, lr}	)
+UNWIND( .setfp  fpreg, sp	)
+
+	ldr	fpreg, [sp, #S_SP]		@ Add our frame record
+						@ to the linked list
+#if defined(CONFIG_UNWINDER_FRAME_POINTER) && defined(CONFIG_CC_IS_GCC)
+	ldr	r1, [fp, #4]			@ reload SP at entry
+	add	fp, fp, #12
+#else
+	ldr	r1, [fpreg, #8]
+#endif
+	str	r1, [sp, #S_SP]			@ store in pt_regs
+
+	@ Stash the regs for handle_bad_stack
+	mov	r0, sp
+
+	@ Time to die
+	bl	handle_bad_stack
+	nop
+UNWIND( .fnend			)
+ENDPROC(__bad_stack)
+#endif
+
 	__INIT
 
 /*
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9f01b229841a..347c975c5d9d 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -429,3 +429,40 @@ scno	.req	r7		@ syscall number
 tbl	.req	r8		@ syscall table pointer
 why	.req	r8		@ Linux syscall (!= 0)
 tsk	.req	r9		@ current thread_info
+
+	.macro	do_overflow_check, frame_size:req
+#ifdef CONFIG_VMAP_STACK
+	@
+	@ Test whether the SP has overflowed. Task and IRQ stacks are aligned
+	@ so that SP & BIT(THREAD_SIZE_ORDER + PAGE_SHIFT) should always be
+	@ zero.
+	@
+ARM(	tst	sp, #1 << (THREAD_SIZE_ORDER + PAGE_SHIFT)	)
+THUMB(	tst	r1, #1 << (THREAD_SIZE_ORDER + PAGE_SHIFT)	)
+THUMB(	it	ne						)
+	bne	.Lstack_overflow_check\@
+
+	.pushsection	.text
+.Lstack_overflow_check\@:
+	@
+	@ The stack pointer is not pointing to a valid vmap'ed stack, but it
+	@ may be pointing into the linear map instead, which may happen if we
+	@ are already running from the overflow stack. We cannot detect overflow
+	@ in such cases so just carry on.
+	@
+	str	ip, [r0, #12]			@ Stash IP on the mode stack
+	ldr_va	ip, high_memory			@ Start of VMALLOC space
+ARM(	cmp	sp, ip			)	@ SP in vmalloc space?
+THUMB(	cmp	r1, ip			)
+THUMB(	itt	lo			)
+	ldrlo	ip, [r0, #12]			@ Restore IP
+	blo	.Lout\@				@ Carry on
+
+THUMB(	sub	r1, sp, r1		)	@ Restore original R1
+THUMB(	sub	sp, r1			)	@ Restore original SP
+	add	sp, sp, #\frame_size		@ Undo svc_entry's SP change
+	b	__bad_stack			@ Handle VMAP stack overflow
+	.popsection
+.Lout\@:
+#endif
+	.endm
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index c04dd94630c7..500612d3da2e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -424,6 +424,13 @@ ENDPROC(secondary_startup)
 ENDPROC(secondary_startup_arm)
 
 ENTRY(__secondary_switched)
+#if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
+	@ Before using the vmap'ed stack, we have to switch to swapper_pg_dir
+	@ as the ID map does not cover the vmalloc region.
+	mrc	p15, 0, ip, c2, c0, 1	@ read TTBR1
+	mcr	p15, 0, ip, c2, c0, 0	@ set TTBR0
+	instr_sync
+#endif
 	adr_l	r7, secondary_data + 12		@ get secondary_data.stack
 	ldr	sp, [r7]
 	ldr	r0, [r7, #4]			@ get secondary_data.task
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 380376f55554..74a1c878bc7a 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -54,7 +54,14 @@ static void __init init_irq_stacks(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		stack = (u8 *)__get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
+		if (!IS_ENABLED(CONFIG_VMAP_STACK))
+			stack = (u8 *)__get_free_pages(GFP_KERNEL,
+						       THREAD_SIZE_ORDER);
+		else
+			stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
+					       THREADINFO_GFP, NUMA_NO_NODE,
+					       __builtin_return_address(0));
+
 		if (WARN_ON(!stack))
 			break;
 		per_cpu(irq_stack_ptr, cpu) = &stack[THREAD_SIZE];
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 284a80c0b6e1..039feb7cd590 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -141,10 +141,10 @@ EXPORT_SYMBOL(outer_cache);
 int __cpu_architecture __read_mostly = CPU_ARCH_UNKNOWN;
 
 struct stack {
-	u32 irq[3];
-	u32 abt[3];
-	u32 und[3];
-	u32 fiq[3];
+	u32 irq[4];
+	u32 abt[4];
+	u32 und[4];
+	u32 fiq[4];
 } ____cacheline_aligned;
 
 #ifndef CONFIG_CPU_V7M
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 43077e11dafd..a86a1d4f3461 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -67,6 +67,12 @@ ENTRY(__cpu_suspend)
 	ldr	r4, =cpu_suspend_size
 #endif
 	mov	r5, sp			@ current virtual SP
+#ifdef CONFIG_VMAP_STACK
+	@ Run the suspend code from the overflow stack so we don't have to rely
+	@ on vmalloc-to-phys conversions anywhere in the arch suspend code.
+	@ The original SP value captured in R5 will be restored on the way out.
+	ldr_this_cpu sp, overflow_stack_ptr, r6, r7
+#endif
 	add	r4, r4, #12		@ Space for pgd, virt sp, phys resume fn
 	sub	sp, sp, r4		@ allocate CPU state on stack
 	ldr	r3, =sleep_save_sp
@@ -113,6 +119,13 @@ ENTRY(cpu_resume_mmu)
 ENDPROC(cpu_resume_mmu)
 	.popsection
 cpu_resume_after_mmu:
+#if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
+	@ Before using the vmap'ed stack, we have to switch to swapper_pg_dir
+	@ as the ID map does not cover the vmalloc region.
+	mrc	p15, 0, ip, c2, c0, 1	@ read TTBR1
+	mcr	p15, 0, ip, c2, c0, 0	@ set TTBR0
+	instr_sync
+#endif
 	bl	cpu_init		@ restore the und/abt/irq banked regs
 	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1b8bef286fbc..8b076eaeaf61 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -123,7 +123,8 @@ void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
 static int verify_stack(unsigned long sp)
 {
 	if (sp < PAGE_OFFSET ||
-	    (sp > (unsigned long)high_memory && high_memory != NULL))
+	    (!IS_ENABLED(CONFIG_VMAP_STACK) &&
+	     sp > (unsigned long)high_memory && high_memory != NULL))
 		return -EFAULT;
 
 	return 0;
@@ -293,7 +294,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
-			 ALIGN(regs->ARM_sp, THREAD_SIZE));
+			 ALIGN(regs->ARM_sp - THREAD_SIZE, THREAD_ALIGN)
+			 + THREAD_SIZE);
 		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
@@ -840,3 +842,66 @@ void __init early_trap_init(void *vectors_base)
 	 */
 #endif
 }
+
+#ifdef CONFIG_VMAP_STACK
+
+DECLARE_PER_CPU(u8 *, irq_stack_ptr);
+
+asmlinkage DEFINE_PER_CPU(u8 *, overflow_stack_ptr);
+
+static int __init allocate_overflow_stacks(void)
+{
+	u8 *stack;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		stack = (u8 *)__get_free_page(GFP_KERNEL);
+		if (WARN_ON(!stack))
+			return -ENOMEM;
+		per_cpu(overflow_stack_ptr, cpu) = &stack[OVERFLOW_STACK_SIZE];
+	}
+	return 0;
+}
+early_initcall(allocate_overflow_stacks);
+
+asmlinkage void handle_bad_stack(struct pt_regs *regs)
+{
+	unsigned long tsk_stk = (unsigned long)current->stack;
+	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
+	unsigned long ovf_stk = (unsigned long)this_cpu_read(overflow_stack_ptr);
+
+	console_verbose();
+	pr_emerg("Insufficient stack space to handle exception!");
+
+	pr_emerg("Task stack:     [0x%08lx..0x%08lx]\n",
+		 tsk_stk, tsk_stk + THREAD_SIZE);
+	pr_emerg("IRQ stack:      [0x%08lx..0x%08lx]\n",
+		 irq_stk - THREAD_SIZE, irq_stk);
+	pr_emerg("Overflow stack: [0x%08lx..0x%08lx]\n",
+		 ovf_stk - OVERFLOW_STACK_SIZE, ovf_stk);
+
+	die("kernel stack overflow", regs, 0);
+}
+
+#ifndef CONFIG_ARM_LPAE
+/*
+ * Normally, we rely on the logic in do_translation_fault() to update stale PMD
+ * entries covering the vmalloc space in a task's page tables when it first
+ * accesses the region in question. Unfortunately, this is not sufficient when
+ * the task stack resides in the vmalloc region, as do_translation_fault() is a
+ * C function that needs a stack to run.
+ *
+ * So we need to ensure that these PMD entries are up to date *before* the MM
+ * switch. As we already have some logic in the MM switch path that takes care
+ * of this, let's trigger it by bumping the counter every time the core vmalloc
+ * code modifies a PMD entry in the vmalloc region. Use release semantics on
+ * the store so that other CPUs observing the counter's new value are
+ * guaranteed to see the updated page table entries as well.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	if (start < VMALLOC_END && end > VMALLOC_START)
+		atomic_inc_return_release(&init_mm.context.vmalloc_seq);
+}
+#endif
+#endif
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index e8d729975f12..c5ea328c428d 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -389,7 +389,8 @@ int unwind_frame(struct stackframe *frame)
 
 	/* store the highest address on the stack to avoid crossing it*/
 	ctrl.sp_low = frame->sp;
-	ctrl.sp_high = ALIGN(ctrl.sp_low, THREAD_SIZE);
+	ctrl.sp_high = ALIGN(ctrl.sp_low - THREAD_SIZE, THREAD_ALIGN)
+		       + THREAD_SIZE;
 
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index f02d617e3359..aa12b65a7fd6 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -138,12 +138,12 @@ SECTIONS
 #ifdef CONFIG_STRICT_KERNEL_RWX
 	. = ALIGN(1<<SECTION_SHIFT);
 #else
-	. = ALIGN(THREAD_SIZE);
+	. = ALIGN(THREAD_ALIGN);
 #endif
 	__init_end = .;
 
 	_sdata = .;
-	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 	_edata = .;
 
 	BSS_SECTION(0, 0, 0)
-- 
2.30.2

