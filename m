Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E3C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 02:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6910D611CC
	for <linux-hardening@archiver.kernel.org>; Sat, 11 Sep 2021 02:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhIKCag (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCaf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 22:30:35 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D0C061574
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 19:29:23 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4H5xX15kCwzQjdv;
        Sat, 11 Sep 2021 04:29:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   "Christopher M. Riedl" <cmr@bluescreens.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-hardening@vger.kernel.org
Subject: [PATCH v6 1/4] powerpc/64s: Introduce temporary mm for Radix MMU
Date:   Fri, 10 Sep 2021 21:29:01 -0500
Message-Id: <20210911022904.30962-2-cmr@bluescreens.de>
In-Reply-To: <20210911022904.30962-1-cmr@bluescreens.de>
References: <20210911022904.30962-1-cmr@bluescreens.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A68E726F
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

x86 supports the notion of a temporary mm which restricts access to
temporary PTEs to a single CPU. A temporary mm is useful for situations
where a CPU needs to perform sensitive operations (such as patching a
STRICT_KERNEL_RWX kernel) requiring temporary mappings without exposing
said mappings to other CPUs. Another benefit is that other CPU TLBs do
not need to be flushed when the temporary mm is torn down.

Mappings in the temporary mm can be set in the userspace portion of the
address-space.

Interrupts must be disabled while the temporary mm is in use. HW
breakpoints, which may have been set by userspace as watchpoints on
addresses now within the temporary mm, are saved and disabled when
loading the temporary mm. The HW breakpoints are restored when unloading
the temporary mm. All HW breakpoints are indiscriminately disabled while
the temporary mm is in use - this may include breakpoints set by perf.

Based on x86 implementation:

commit cefa929c034e
("x86/mm: Introduce temporary mm structs")

Signed-off-by: Christopher M. Riedl <cmr@bluescreens.de>

---

v6:  * Use {start,stop}_using_temporary_mm() instead of
       {use,unuse}_temporary_mm() as suggested by Christophe.

v5:  * Drop support for using a temporary mm on Book3s64 Hash MMU.

v4:  * Pass the prev mm instead of NULL to switch_mm_irqs_off() when
       using/unusing the temp mm as suggested by Jann Horn to keep
       the context.active counter in-sync on mm/nohash.
     * Disable SLB preload in the temporary mm when initializing the
       temp_mm struct.
     * Include asm/debug.h header to fix build issue with
       ppc44x_defconfig.
---
 arch/powerpc/include/asm/debug.h |  1 +
 arch/powerpc/kernel/process.c    |  5 +++
 arch/powerpc/lib/code-patching.c | 56 ++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 86a14736c76c..dfd82635ea8b 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -46,6 +46,7 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
 void __set_breakpoint(int nr, struct arch_hw_breakpoint *brk);
+void __get_breakpoint(int nr, struct arch_hw_breakpoint *brk);
 bool ppc_breakpoint_available(void);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..6aa1f5c4d520 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -865,6 +865,11 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 	return 0;
 }
 
+void __get_breakpoint(int nr, struct arch_hw_breakpoint *brk)
+{
+	memcpy(brk, this_cpu_ptr(&current_brk[nr]), sizeof(*brk));
+}
+
 void __set_breakpoint(int nr, struct arch_hw_breakpoint *brk)
 {
 	memcpy(this_cpu_ptr(&current_brk[nr]), brk, sizeof(*brk));
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f9a3019e37b4..8d61a7d35b89 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -17,6 +17,9 @@
 #include <asm/code-patching.h>
 #include <asm/setup.h>
 #include <asm/inst.h>
+#include <asm/mmu_context.h>
+#include <asm/debug.h>
+#include <asm/tlb.h>
 
 static int __patch_instruction(u32 *exec_addr, struct ppc_inst instr, u32 *patch_addr)
 {
@@ -45,6 +48,59 @@ int raw_patch_instruction(u32 *addr, struct ppc_inst instr)
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
+
+struct temp_mm {
+	struct mm_struct *temp;
+	struct mm_struct *prev;
+	struct arch_hw_breakpoint brk[HBP_NUM_MAX];
+};
+
+static inline void init_temp_mm(struct temp_mm *temp_mm, struct mm_struct *mm)
+{
+	/* We currently only support temporary mm on the Book3s64 Radix MMU */
+	WARN_ON(!radix_enabled());
+
+	temp_mm->temp = mm;
+	temp_mm->prev = NULL;
+	memset(&temp_mm->brk, 0, sizeof(temp_mm->brk));
+}
+
+static inline void start_using_temporary_mm(struct temp_mm *temp_mm)
+{
+	lockdep_assert_irqs_disabled();
+
+	temp_mm->prev = current->active_mm;
+	switch_mm_irqs_off(temp_mm->prev, temp_mm->temp, current);
+
+	WARN_ON(!mm_is_thread_local(temp_mm->temp));
+
+	if (ppc_breakpoint_available()) {
+		struct arch_hw_breakpoint null_brk = {0};
+		int i = 0;
+
+		for (; i < nr_wp_slots(); ++i) {
+			__get_breakpoint(i, &temp_mm->brk[i]);
+			if (temp_mm->brk[i].type != 0)
+				__set_breakpoint(i, &null_brk);
+		}
+	}
+}
+
+static inline void stop_using_temporary_mm(struct temp_mm *temp_mm)
+{
+	lockdep_assert_irqs_disabled();
+
+	switch_mm_irqs_off(temp_mm->temp, temp_mm->prev, current);
+
+	if (ppc_breakpoint_available()) {
+		int i = 0;
+
+		for (; i < nr_wp_slots(); ++i)
+			if (temp_mm->brk[i].type != 0)
+				__set_breakpoint(i, &temp_mm->brk[i]);
+	}
+}
+
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
 
 static int text_area_cpu_up(unsigned int cpu)
-- 
2.32.0

