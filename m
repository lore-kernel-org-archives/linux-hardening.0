Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D148C8DC;
	Wed, 15 Jul 2026 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137956; cv=none; b=BtPRc5t2/n3msN10Zkv4yVdn+RC/tZIrAnNPbBpIOQjr6IGT03f5MqWXQdP+tK2EG9GsYX/Hui5dXLFqcF7qPMsQYwep+XdN77GEAX/ADrZRwJw/OAi+XfkU3OsNjtMtEkJo93hoG3oQ8JZAPc5LLn3R/XNyu1SGSbaV8Y+Oaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137956; c=relaxed/simple;
	bh=+1G8QPlUFuILDnO393TH65EL6dK2Ay6tH2J4v/o3ZwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LxP+MiIEY4NXNHh/ZjrR1YXQZ88ew9/FcwEN4TeZQ5lrHTL3vQBZdW97mJR08jyF+X/7gwKfrJFbafZyEI51J148YKqwVRkVotLN4TF5DKwUF5w6yh+oyHw0oh5eNUqZHrHF1hill5u7yErdvf3r5Ta78rq1cP2xZWjvRi7BfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWsYGyR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWsYGyR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7FE1F000E9;
	Wed, 15 Jul 2026 17:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784137954;
	bh=c4f1ZmkmR1O0A/LfhQpAbZrixZvj3u3dIvoVYNBSYh4=;
	h=From:To:Cc:Subject:Date;
	b=XWsYGyR489TIbiO60xP95miqy5Mz+ODVYQx6qB4rJ3C6GdOax3bmvzr/FKRhG+Iag
	 /CjsEaXrA6thWIGEy3tCpCsQr5sagu31+W1Pw3lyI5hfIiRpgRyh+N5n6f4iElRjb1
	 sU3wQ8iIll5AvaZ+LXHEXJ9uoJndNuk6iiy9hB9eQySpU3GeHy9J657OTD33BMkBRP
	 2xGkmXhd0jieoe1zOnt9LQxa7cDEg3FNsWG2LFDdaNLM1VaObItGo9Af1O+10y+Y/Z
	 H8WyoMVWWDC4r06kP0cUVZfmGEqu0Q+NdwPjUuGPi0cWwHdq0U8rM3yniPNHhKAUbm
	 +15G9QFnnmjKQ==
From: Kees Cook <kees@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Kees Cook <kees@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Micha=C5=82=20Pecio?= <michal.pecio@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] ARM: traps: Implement KCFI trap handler for ARM32
Date: Wed, 15 Jul 2026 10:52:27 -0700
Message-Id: <20260715175223.make.153-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12094; i=kees@kernel.org; h=from:subject:message-id; bh=+1G8QPlUFuILDnO393TH65EL6dK2Ay6tH2J4v/o3ZwI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnhJ26xlGVcs5hru5Bxs2Gp6tlFfHIPHD5f+yZY5//nx nau5cXrOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZyqZWRYW3cxOy4/dLX2gXz snjcDy35XzfNlV3s/q6jt/UYss3T/BgZNq2/GMZ3u7GnunvRRrVFUTNNJggb7b+56FmamCXj6x+ rGQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

ARM32 GCC KCFI[1] violations currently show as generic "Oops - undefined
instruction" errors, making debugging CFI failures difficult. Add a proper
KCFI trap handler similar to the aarch64 implementation to provide clear
CFI error messages, including the call target and the expected type.

Clang and GCC trap CFI failures differently on ARM32. Clang lowers
its checks to a BKPT, handled via the breakpoint/prefetch-abort path
in hw_breakpoint.c, which cannot recover the target or expected type
and so must report via report_cfi_failure_noaddr(). GCC instead lowers
KCFI checks to a UDF (undefined instruction) whose immediate encodes
the registers involved, so the handler can decode it and call the full
report_cfi_failure() with the target and expected type.

The GCC ARM32 KCFI implementation uses UDF instructions with a specific
encoding pattern:
- UDF instruction format: cccc 0111 1111 imm12 1111 imm4
- 16-bit immediate reconstructed from bits 19-8 and 3-0
- KCFI encoding: 0x8000 | (type_reg_num << 5) | (target_reg_num & 31)
- Bit 15: KCFI trap identifier (0x8000)
- Bits 9-5: Type ID register field (0x1F when unavailable)
- Bits 4-0: Target address register number

When the type register field is 0x1F (the type was spilled rather than
kept in a register), the handler walks back up to 6 preceding
instructions to recover the 32-bit type ID from the four EOR-immediate
instructions the compiler emits, similar to x86 CFI trap reconstruction.

The handler is dispatched directly from do_undefinstr() rather than
through register_undef_hook(). A registered hook is only installed once
initcalls run, so any KCFI violation that fires earlier in boot would be
reported as a generic "undefined instruction"; calling the decoder from
the exception handler itself catches failures from the very first
instruction. Dispatching directly also lets the handler ignore
non-kernel-mode UDFs, preventing a user process from spoofing the KCFI
encoding.

Both the UDF handler and the Clang breakpoint handler in hw_breakpoint.c
act on the report_cfi_failure*() result identically (oops on a fatal
violation, or skip the trapping instruction under CFI permissive mode)
so factor that shared tail into arm_cfi_handle_failure(), declared in
asm/traps.h.

Link: https://inbox.sourceware.org/gcc-patches/20260618204539.824446-6-kees@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3:
  - rebased on https://lore.kernel.org/lkml/20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org/
  - drop initcall registration: potentially too late
  - share logic with hw_breakpoint.c
 v2: https://lore.kernel.org/lkml/20250904034656.3670313-9-kees@kernel.org/#r
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Michał Pecio" <michal.pecio@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm/include/asm/traps.h    |   3 +
 arch/arm/kernel/hw_breakpoint.c |  40 +++------
 arch/arm/kernel/traps.c         | 144 ++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 2621b9fb9b19..5f10af964774 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -2,6 +2,7 @@
 #ifndef _ASMARM_TRAP_H
 #define _ASMARM_TRAP_H
 
+#include <linux/bug.h>
 #include <linux/linkage.h>
 #include <linux/list.h>
 
@@ -20,6 +21,8 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
+bool arm_cfi_handle_failure(struct pt_regs *regs, enum bug_trap_type type);
+
 static inline int __in_irqentry_text(unsigned long ptr)
 {
 	extern char __irqentry_text_start[];
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 38feb30dfb5f..04755b4373f2 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -904,33 +904,6 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 	watchpoint_single_step_handler(addr);
 }
 
-#ifdef CONFIG_CFI
-static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
-{
-	/*
-	 * TODO: implementing target and type to pass to CFI using the more
-	 * elaborate report_cfi_failure() requires compiler work. To be able
-	 * to properly extract target information the compiler needs to
-	 * emit a stable instructions sequence for the CFI checks so we can
-	 * decode the instructions preceding the trap and figure out which
-	 * registers were used.
-	 */
-
-	switch (report_cfi_failure_noaddr(regs, instruction_pointer(regs))) {
-	case BUG_TRAP_TYPE_BUG:
-		die("Oops - CFI", regs, 0);
-		break;
-	case BUG_TRAP_TYPE_WARN:
-		/* Skip the breaking instruction */
-		instruction_pointer(regs) += 4;
-		break;
-	default:
-		die("Unknown CFI error", regs, 0);
-		break;
-	}
-}
-#endif
-
 /*
  * Called from either the Data Abort Handler [watchpoint] or the
  * Prefetch Abort Handler [breakpoint] with interrupts disabled.
@@ -962,10 +935,19 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 		break;
 #ifdef CONFIG_CFI
 	case ARM_ENTRY_CFI_BREAKPOINT:
+		/*
+		 * Clang lowers its CFI checks to a plain breakpoint that does not
+		 * encode the call target or expected type, so (unlike the GCC UDF
+		 * handler in traps.c) this can only report via
+		 * report_cfi_failure_noaddr(). Recovering the target would require
+		 * the compiler to emit a stable instruction sequence around the
+		 * check to decode the registers used.
+		 */
 		if (user_mode(regs))
 			ret = 1; /* Don't handle userspace BKPT */
-		else
-			hw_breakpoint_cfi_handler(regs);
+		else if (!arm_cfi_handle_failure(regs,
+				report_cfi_failure_noaddr(regs, instruction_pointer(regs))))
+			die("Unknown CFI error", regs, 0);
 		break;
 #endif
 	default:
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index afbd2ebe5c39..adaa6170963b 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -27,6 +27,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
+#include <linux/cfi.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -40,6 +41,7 @@
 #include <asm/stacktrace.h>
 #include <asm/system_misc.h>
 #include <asm/opcodes.h>
+#include <linux/bitfield.h>
 
 
 static const char *handler[]= {
@@ -442,6 +444,141 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 	return fn ? fn(regs, instr) : 1;
 }
 
+#ifdef CONFIG_CFI
+/**
+ * arm_cfi_handle_failure() - Act on a report_cfi_failure() result
+ * @regs: registers at the trapping instruction
+ * @type: the bug_trap_type returned by report_cfi_failure*()
+ *
+ * Shared by the GCC UDF handler in this file and the Clang breakpoint handler
+ * in hw_breakpoint.c: oops on a fatal violation, or under CFI permissive mode
+ * skip the (4-byte, ARM state) trapping instruction and continue.
+ *
+ * Return: true if @type was a recognized CFI failure and has been handled;
+ * false otherwise, so the caller can escalate.
+ */
+bool arm_cfi_handle_failure(struct pt_regs *regs, enum bug_trap_type type)
+{
+	switch (type) {
+	case BUG_TRAP_TYPE_BUG:
+		die("Oops - CFI", regs, 0);
+		break;
+	case BUG_TRAP_TYPE_WARN:
+		/* Permissive mode: skip the trapping instruction and continue. */
+		instruction_pointer(regs) += 4;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * ARM32 KCFI trap handler.
+ * UDF instruction format: cccc 0111 1111 imm12 1111 imm4
+ * Immediate is reconstructed from bits 19-8 (12 bits) and bits 3-0 (4 bits)
+ * KCFI immediate encoding: 0x8000 | (0x1F << 5) | (target_reg_num & 31)
+ * - Bit 15: KCFI trap identifier (0x8000)
+ * - Bits 9-5: Type ID register field (0x1F when invalid due to stack spilling)
+ * - Bits 4-0: Target address register number
+ */
+#define CFI_UDF_KCFI_BIT    BIT(15)	  /* KCFI identifier bit (0x8000) */
+#define CFI_UDF_IMM_TARGET  GENMASK(4, 0) /* Target register (bits 4:0) */
+#define CFI_UDF_IMM_TYPE    GENMASK(9, 5) /* Type register (bits 9:5) */
+
+/* UDF base pattern with KCFI bit: cond=0xe, 0x7f, xxxx, 1xxx, 0xf, xxxx */
+#define CFI_UDF_IMM_BASE    0xe7f008f0
+#define CFI_UDF_IMM_MASK    0xfff008f0	/* Mask for UDF + KCFI bit matching */
+
+/**
+ * cfi_udf_handler() - Decode and report a GCC KCFI UDF trap
+ * @regs: registers at the trapping instruction
+ * @instr: the trapping instruction word
+ *
+ * Called for every kernel-mode undefined instruction. If @instr is a GCC
+ * KCFI UDF, decode its target and expected type and hand them to
+ * report_cfi_failure(), which oopses (fatal) or, under CFI permissive mode,
+ * warns and skips the instruction.
+ *
+ * Return: 0 if this was a KCFI failure and has been handled (the caller
+ * should return to the interrupted context); 1 otherwise when the UDF was not
+ * a KCFI trap (user mode, non-KCFI encoding, malformed operands, or an
+ * unrecognized report), so the caller should keep looking for a handler.
+ */
+static int cfi_udf_handler(struct pt_regs *regs, unsigned int instr)
+{
+	unsigned long target;
+	u32 target_reg, type_reg, type, imm16;
+
+	/*
+	 * KCFI checks are only emitted in kernel code, so ignore user-mode UDFs
+	 * (this also stops a user process spoofing the KCFI encoding), and only
+	 * handle UDFs carrying the KCFI pattern.
+	 */
+	if (processor_mode(regs) != SVC_MODE)
+		return 1;
+	if ((instr & CFI_UDF_IMM_MASK) != CFI_UDF_IMM_BASE)
+		return 1;
+
+	/* Reconstruct 16-bit immediate from bits 19-8 and 3-0 */
+	imm16 = ((instr >> 4) & 0xfff0) | (instr & 0x0f);
+
+	target_reg = FIELD_GET(CFI_UDF_IMM_TARGET, imm16);
+	type_reg = FIELD_GET(CFI_UDF_IMM_TYPE, imm16);
+
+	if (target_reg >= 16) {
+		pr_err("CFI UDF handler: invalid target register %u\n", target_reg);
+		return 1;
+	}
+
+	target = regs->uregs[target_reg];
+
+	/* Type register field is set to all 1s (0x1F) when spilled; extract from EOR sequence */
+	if (type_reg == 0x1F) {
+		u32 *pc = (u32 *)regs->ARM_pc;
+		int eor_count = 0;
+		int i;
+
+		type = 0;
+		/* Walk back up to 6 instructions to find EOR sequence for type ID */
+		for (i = 1; i <= 6 && eor_count < 4; i++) {
+			u32 instr_prev = __mem_to_opcode_arm(pc[-i]);
+
+			/* Check for EOR/EORS immediate: cccc 0010 0x1n Rn Rd immediate */
+			if ((instr_prev & 0x0fe00000) == 0x02200000) {
+				/* Extract EOR immediate value and XOR to reconstruct type */
+				u32 rotate = (instr_prev >> 8) & 0xf;
+				u32 imm8 = instr_prev & 0xff;
+				u32 imm32 = (imm8 >> (rotate * 2)) | (imm8 << (32 - rotate * 2));
+				type ^= imm32;
+				eor_count++;
+			}
+		}
+		if (eor_count != 4)
+			pr_err("CFI UDF handler: found %d EOR instructions, expected 4\n", eor_count);
+	} else {
+		if (type_reg >= 16) {
+			pr_err("CFI UDF handler: invalid type register %u\n", type_reg);
+			return 1;
+		}
+
+		type = regs->uregs[type_reg];
+	}
+
+	if (!arm_cfi_handle_failure(regs,
+			report_cfi_failure(regs, regs->ARM_pc, &target, type)))
+		return 1;
+
+	return 0;
+}
+#else
+static inline int cfi_udf_handler(struct pt_regs *regs, unsigned int instr)
+{
+	return 1;
+}
+#endif /* CONFIG_CFI */
+
 asmlinkage void do_undefinstr(struct pt_regs *regs)
 {
 	unsigned int instr;
@@ -478,6 +615,13 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 		instr = __mem_to_opcode_arm(instr);
 	}
 
+	/*
+	 * Decode KCFI failures directly (not via register_undef_hook) so they
+	 * are diagnosed even when they fire before initcalls have run.
+	 */
+	if (cfi_udf_handler(regs, instr) == 0)
+		return;
+
 	if (call_undef_hook(regs, instr) == 0)
 		return;
 
-- 
2.34.1

