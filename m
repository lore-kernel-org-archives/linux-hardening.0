Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF110CCA480
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350705AbiFJXgR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350691AbiFJXgC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2AD28E706
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v202-20020a6361d3000000b0040506cf75d7so206123pgb.15
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rfii40/61v5cAW11IoU+wuQWL/BtIJcdMkTll2YkzG0=;
        b=DdEBLjG/B562B1Mspam9oCQtwRzdUgieZ9469C801Jnw3ZPmDyNIfxtLp+6ManbUht
         aFb7Y1x8lcEyDL2+R1/JtG6z3PTGiCci4qcYnJY0zTULBwYSJyOTTTGm/XKenLemGWBf
         Q9ensg4yM7Eg48oEqkTidekc66/VA9gyRSyVwEoh2JSHTv2+7EVZxVciLKrR1B54r2rt
         UILMW4JYg4vySYNWiARyCUtUJ898DR3QEYthrKAeP6gmG3AdpMFlnmjywSfw3WkfWz5g
         2ZfS1n9yZ37r4DYygsUi7sivCt6QZgRIbaLqG7v2zcjp9tZyiB/A7I696CKinOWhL/IL
         gvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rfii40/61v5cAW11IoU+wuQWL/BtIJcdMkTll2YkzG0=;
        b=qjA9ahbaGz1NMK8pBuZZ702AQB0tqrGNhQgy/VSkRmRd2SPfCyYg/w9MuOpfJLGVmr
         Y14n7ZAV6gErn6Hb7FOFgFkBdcovberYP8K7yUMGzJF8CMFzzF8mpFMuXTDPAjdnyJvl
         k/m8b9vOJESd8Kg5I5M5e47lQJ+m88X1biMlCNeZ4VrvLEQPJPtFU1Nc5mBqmDBNz1PL
         o8ziY5/L7Y6Nze5TSYeg6S9isS6dRIBSId09/MnPnQoUYX0W9UdItk4ylEuNiYwnlSqL
         sF5O9/qLVjH/xRJPKsgMfaOuSpYmoke9FpugUGrx5BSI8w44LEWCh5w4LWe/7u0lLZTP
         22FQ==
X-Gm-Message-State: AOAM531/v+gi6kurjLe/WJgRN249TVkic2kpHcRZXj0yLO7gBrTVY3Pi
        igGrmHAcI3q8UttP6mzP5SDx0Uz3PabMME+QHqc=
X-Google-Smtp-Source: ABdhPJwvc5C8SM32c3tIzxlJ3Ggnghl42T32RMV09/53RLw3VMwyDzsXJNMiGUEwbzlIg69NE1XDrQ/CGU5jyZhapYY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with
 SMTP id t9-20020a17090a024900b001e0a8a33c6cmr5759pje.0.1654904137350; Fri, 10
 Jun 2022 16:35:37 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:02 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6529; h=from:subject;
 bh=IPkD/qOu+u2dCqBjYIeiP4g3Njh2fY2rj8noNEsYy9o=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Utx+nnnolHZB9v7bniHgiA4kkjCCihSSiuuDzI
 FxJNsiiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLQAKCRBMtfaEi7xW7oW3C/
 409MwpErRHzdbErqOlzs007G2/Ns9t9uuj3LjOoFw2GSdqbq4CAKcoClxCdFsMDS8ZXP+vPv99jEQJ
 I/jHGAeLOyUaY+uWPxY+RsLbg9jspVOcIy6LvKFo+MIMyV93Rqpzb38xpGdvHZN1K7W+gG+P1GWR6F
 eyVVpYAjKtY1Hfau1uZr6ffhFM0bYPziQrpWst1fhAYJnjvrRSNVuJpYd8317PlFZk1oRY+VTINWET
 VRDuwFOoQ2OuUelJkGDC0pFSkto8Dz9KsNlSSM5tc8yFeFfraiBgE0FPRgSog2hSzpF4GTkRWvM5wW
 77tHVqsIvXBE/90OkIABTnOKdzSfoRt8BQMw+fcZHe/TCBaaPfoEBFyKB3FZ0zbK5u4UahOI8n9zNV
 N6pLrG17J3NzAAdUEi4pcHaeppEkj8FpQz+S+oZmuJRdzuOsqGZ7LyzMWVRy95mMbwYA+c5HXbrqPZ
 WiGvJsMlRyMX2Y3xXpnmwtFX70bxhBQc1MVR/o7LGL18k=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 09/20] arm64: Add CFI error handling
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling CFI
failures. The registers containing the target address and the expected type
are encoded in the first ten bits of the ESR as follows:

 - 0-4: n, where the register Xn contains the target address
 - 5-9: m, where the register Wm contains the type hash

This produces the following oops on CFI failure (generated using lkdtm):

[   21.885179] CFI failure at lkdtm_indirect_call+0x2c/0x44 [lkdtm]
(target: lkdtm_increment_int+0x0/0x1c [lkdtm]; expected type: 0x7e0c52a)
[   21.886593] Internal error: Oops - CFI: 0 [#1] PREEMPT SMP
[   21.891060] Modules linked in: lkdtm
[   21.893363] CPU: 0 PID: 151 Comm: sh Not tainted
5.19.0-rc1-00021-g852f4e48dbab #1
[   21.895560] Hardware name: linux,dummy-virt (DT)
[   21.896543] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   21.897583] pc : lkdtm_indirect_call+0x2c/0x44 [lkdtm]
[   21.898551] lr : lkdtm_CFI_FORWARD_PROTO+0x3c/0x6c [lkdtm]
[   21.899520] sp : ffff8000083a3c50
[   21.900191] x29: ffff8000083a3c50 x28: ffff0000027e0ec0 x27: 0000000000000000
[   21.902453] x26: 0000000000000000 x25: ffffc2aa3d07e7b0 x24: 0000000000000002
[   21.903736] x23: ffffc2aa3d079088 x22: ffffc2aa3d07e7b0 x21: ffff000003379000
[   21.905062] x20: ffff8000083a3dc0 x19: 0000000000000012 x18: 0000000000000000
[   21.906371] x17: 000000007e0c52a5 x16: 000000003ad55aca x15: ffffc2aa60d92138
[   21.907662] x14: ffffffffffffffff x13: 2e2e2e2065707974 x12: 0000000000000018
[   21.909775] x11: ffffc2aa62322b88 x10: ffffc2aa62322aa0 x9 : c7e305fb5195d200
[   21.911898] x8 : ffffc2aa3d077e20 x7 : 6d20676e696c6c61 x6 : 43203a6d74646b6c
[   21.913108] x5 : ffffc2aa6266c9df x4 : ffffc2aa6266c9e1 x3 : ffff8000083a3968
[   21.914358] x2 : 80000000fffff122 x1 : 00000000fffff122 x0 : ffffc2aa3d07e8f8
[   21.915827] Call trace:
[   21.916375]  lkdtm_indirect_call+0x2c/0x44 [lkdtm]
[   21.918060]  lkdtm_CFI_FORWARD_PROTO+0x3c/0x6c [lkdtm]
[   21.919030]  lkdtm_do_action+0x34/0x4c [lkdtm]
[   21.919920]  direct_entry+0x170/0x1ac [lkdtm]
[   21.920772]  full_proxy_write+0x84/0x104
[   21.921759]  vfs_write+0x188/0x3d8
[   21.922387]  ksys_write+0x78/0xe8
[   21.922986]  __arm64_sys_write+0x1c/0x2c
[   21.923696]  invoke_syscall+0x58/0x134
[   21.924554]  el0_svc_common+0xb4/0xf4
[   21.925603]  do_el0_svc+0x2c/0xb4
[   21.926563]  el0_svc+0x2c/0x7c
[   21.927147]  el0t_64_sync_handler+0x84/0xf0
[   21.927985]  el0t_64_sync+0x18c/0x190
[   21.929133] Code: 728a54b1 72afc191 6b11021f 54000040 (d4304500)
[   21.930690] ---[ end trace 0000000000000000 ]---
[   21.930971] Kernel panic - not syncing: Oops - CFI: Fatal exception

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/brk-imm.h |  6 ++++
 arch/arm64/kernel/traps.c        | 47 ++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index ec7720dbe2c8..6e000113e508 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -17,6 +17,7 @@
  * 0x401: for compile time BRK instruction
  * 0x800: kernel-mode BUG() and WARN() traps
  * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
+ * 0x8xxx: Control-Flow Integrity traps
  */
 #define KPROBES_BRK_IMM			0x004
 #define UPROBES_BRK_IMM			0x005
@@ -28,4 +29,9 @@
 #define KASAN_BRK_IMM			0x900
 #define KASAN_BRK_MASK			0x0ff
 
+#define CFI_BRK_IMM_TARGET		GENMASK(4, 0)
+#define CFI_BRK_IMM_TYPE		GENMASK(9, 5)
+#define CFI_BRK_IMM_BASE		0x8000
+#define CFI_BRK_IMM_MASK		(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
+
 #endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 9ac7a81b79be..7547d3abf0f5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
 #include <linux/kasan.h>
+#include <linux/cfi.h>
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
@@ -991,6 +992,38 @@ static struct break_hook bug_break_hook = {
 	.imm = BUG_BRK_IMM,
 };
 
+#ifdef CONFIG_CFI_CLANG
+static int cfi_handler(struct pt_regs *regs, unsigned long esr)
+{
+	unsigned long target;
+	u32 type;
+
+	target = pt_regs_read_reg(regs, FIELD_GET(CFI_BRK_IMM_TARGET, esr));
+	type = (u32)pt_regs_read_reg(regs, FIELD_GET(CFI_BRK_IMM_TYPE, esr));
+
+	switch (report_cfi_failure(regs, regs->pc, &target, type)) {
+	case BUG_TRAP_TYPE_BUG:
+		die("Oops - CFI", regs, 0);
+		break;
+
+	case BUG_TRAP_TYPE_WARN:
+		break;
+
+	default:
+		return DBG_HOOK_ERROR;
+	}
+
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	return DBG_HOOK_HANDLED;
+}
+
+static struct break_hook cfi_break_hook = {
+	.fn = cfi_handler,
+	.imm = CFI_BRK_IMM_BASE,
+	.mask = CFI_BRK_IMM_MASK,
+};
+#endif /* CONFIG_CFI_CLANG */
+
 static int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
 {
 	pr_err("%s generated an invalid instruction at %pS!\n",
@@ -1052,6 +1085,9 @@ static struct break_hook kasan_break_hook = {
 };
 #endif
 
+
+#define esr_comment(esr) ((esr) & ESR_ELx_BRK64_ISS_COMMENT_MASK)
+
 /*
  * Initial handler for AArch64 BRK exceptions
  * This handler only used until debug_traps_init().
@@ -1059,10 +1095,12 @@ static struct break_hook kasan_break_hook = {
 int __init early_brk64(unsigned long addr, unsigned long esr,
 		struct pt_regs *regs)
 {
+#ifdef CONFIG_CFI_CLANG
+	if ((esr_comment(esr) & ~CFI_BRK_IMM_MASK) == CFI_BRK_IMM_BASE)
+		return cfi_handler(regs, esr) != DBG_HOOK_HANDLED;
+#endif
 #ifdef CONFIG_KASAN_SW_TAGS
-	unsigned long comment = esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
-
-	if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
+	if ((esr_comment(esr) & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
 		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
@@ -1071,6 +1109,9 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
 void __init trap_init(void)
 {
 	register_kernel_break_hook(&bug_break_hook);
+#ifdef CONFIG_CFI_CLANG
+	register_kernel_break_hook(&cfi_break_hook);
+#endif
 	register_kernel_break_hook(&fault_break_hook);
 #ifdef CONFIG_KASAN_SW_TAGS
 	register_kernel_break_hook(&kasan_break_hook);
-- 
2.36.1.476.g0c4daa206d-goog

