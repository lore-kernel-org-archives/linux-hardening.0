Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01878C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CAC61A02
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbhI3SHp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353098AbhI3SHk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA4C06176D
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 81-20020a251254000000b005b6220d81efso9545156ybs.12
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yQU12La/KcSmVBf8yylpekUFgOmt+PXL3oVr9qE0LoI=;
        b=pnTMN3fz++vB2Sf9sZZOcWzPPVW20xTtE3g0a3MCpfyP3dl4edEhM5M39xvNnN+KBo
         TB11zIdLXzr37SI94slGbWoDmz924atm9XmR9llxKsUYosrkJFca2AePhVEJ2KDrVV5w
         ZVK6bJw5MkirHnCrnUIrk/+3EtR1Vg3yjbCQjq71ZZbKtr+mHHB93rdjHoeaupu51wJx
         Hm/oiLabeYfCrQkI77o/vlLvl1ph5LHHZraQbPnZZQsHhfa7RzBJ2HhTFJYO2GfPVb3J
         kW3LIUHEV5ayen+WkY6BPJZT+ddZ5P3Md0XtJkc6cN0ZEsCieJ1nuAqT+22CrDtBhd7S
         QdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yQU12La/KcSmVBf8yylpekUFgOmt+PXL3oVr9qE0LoI=;
        b=fSVc8X7bKuN7hZ/Pk/QuLyVxK4ITI9GNNzDi5DvMoa+fYrjIdu8++2wIiMYGdMPKQj
         YQgDQCrblLoJXXXD5mHC5rZBCMDTObTtTbd8ctX65FaVhaVrrE8DKkxXA9eiEnIwxCpf
         v16pK2wYpq7+kQkQjVT0XKPsinIbMtIdJtmQTDSBQg2ygMixyBcExkvKGM29R8GGESIS
         7cXlzPa7UU9A3jx8LSThHQmgA0htW1uLFWoqtNhvxzs6ljD+kgY+7Cbx7R2aW44kx1vA
         Osk5IShu2cEmyWEO8Do70yTLGbuzzWu3hzglVJN9woHdYS8jcHsP/HQZWJdAGLLx8cb0
         PrIA==
X-Gm-Message-State: AOAM532fniG93mqmRE2cNa4vOcHBYgYm5rIzAA2tFSEnERiSMQWHyuzb
        oXY3fyUuewtWa6a4ytpIK3QEbCxns/j76Ak5+yc=
X-Google-Smtp-Source: ABdhPJznfmrqE91cvelw1V7oFVJ8N8612t77FEmRP1grMD+n+ILKJlOvgn1gcdjF4WvXOl343eChfkNX6jk2zU7uUtE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a25:bb8b:: with SMTP id
 y11mr700022ybg.384.1633025156793; Thu, 30 Sep 2021 11:05:56 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:25 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 09/15] x86: Use an opaque type for functions not callable
 from C
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The kernel has several assembly functions that are not directly callable
from C. Use an opaque type for these function prototypes to make misuse
harder, and to avoid the need to annotate references to these functions
for Clang's Control-Flow Integrity (CFI).

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Suggested-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/ftrace.h         |  2 +-
 arch/x86/include/asm/idtentry.h       | 10 +++++-----
 arch/x86/include/asm/page_64.h        |  7 ++++---
 arch/x86/include/asm/paravirt_types.h |  3 ++-
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/include/asm/proto.h          | 25 +++++++++++++------------
 arch/x86/include/asm/uaccess_64.h     |  9 +++------
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/ftrace.c              |  2 +-
 arch/x86/kernel/paravirt.c            |  4 ++--
 arch/x86/kvm/emulate.c                |  4 ++--
 arch/x86/kvm/kvm_emulate.h            |  9 ++-------
 arch/x86/xen/enlighten_pv.c           |  6 +++---
 arch/x86/xen/xen-ops.h                | 10 +++++-----
 14 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 9f3130f40807..54d23f421c16 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -17,7 +17,7 @@
 
 #ifndef __ASSEMBLY__
 extern atomic_t modifying_ftrace_code;
-extern void __fentry__(void);
+DECLARE_ASM_FUNC_SYMBOL(__fentry__);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..2f6d0528bdd2 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -27,8 +27,8 @@
  * as well which is used to emit the entry stubs in entry_32/64.S.
  */
 #define DECLARE_IDTENTRY(vector, func)					\
-	asmlinkage void asm_##func(void);				\
-	asmlinkage void xen_asm_##func(void);				\
+	DECLARE_ASM_FUNC_SYMBOL(asm_##func);				\
+	DECLARE_ASM_FUNC_SYMBOL(xen_asm_##func);				\
 	__visible void func(struct pt_regs *regs)
 
 /**
@@ -78,8 +78,8 @@ static __always_inline void __##func(struct pt_regs *regs)
  * C-handler.
  */
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
-	asmlinkage void asm_##func(void);				\
-	asmlinkage void xen_asm_##func(void);				\
+	DECLARE_ASM_FUNC_SYMBOL(asm_##func);				\
+	DECLARE_ASM_FUNC_SYMBOL(xen_asm_##func);				\
 	__visible void func(struct pt_regs *regs, unsigned long error_code)
 
 /**
@@ -386,7 +386,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * - The C handler called from the C shim
  */
 #define DECLARE_IDTENTRY_DF(vector, func)				\
-	asmlinkage void asm_##func(void);				\
+	DECLARE_ASM_FUNC_SYMBOL(asm_##func);				\
 	__visible void func(struct pt_regs *regs,			\
 			    unsigned long error_code,			\
 			    unsigned long address)
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4bde0dc66100..d6760b6773de 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -5,6 +5,7 @@
 #include <asm/page_64_types.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/linkage.h>
 #include <asm/alternative.h>
 
 /* duplicated to the one in bootmem.h */
@@ -40,9 +41,9 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 #define pfn_valid(pfn)          ((pfn) < max_pfn)
 #endif
 
-void clear_page_orig(void *page);
-void clear_page_rep(void *page);
-void clear_page_erms(void *page);
+DECLARE_ASM_FUNC_SYMBOL(clear_page_orig);
+DECLARE_ASM_FUNC_SYMBOL(clear_page_rep);
+DECLARE_ASM_FUNC_SYMBOL(clear_page_erms);
 
 static inline void clear_page(void *page)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index d9d6b0203ec4..dfaa50d20d6a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -38,6 +38,7 @@
 #include <asm/desc_defs.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
+#include <asm/proto.h>
 
 struct page;
 struct thread_struct;
@@ -271,7 +272,7 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
-extern void (*paravirt_iret)(void);
+extern asm_func_ptr paravirt_iret;
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 577f342dbfb2..02743d701fa8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -449,7 +449,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 
 DECLARE_PER_CPU(void *, hardirq_stack_ptr);
 DECLARE_PER_CPU(bool, hardirq_stack_inuse);
-extern asmlinkage void ignore_sysret(void);
+DECLARE_ASM_FUNC_SYMBOL(ignore_sysret);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 8c5d1910a848..a6aa64eb3657 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PROTO_H
 #define _ASM_X86_PROTO_H
 
+#include <linux/linkage.h>
 #include <asm/ldt.h>
 
 struct task_struct;
@@ -11,26 +12,26 @@ struct task_struct;
 void syscall_init(void);
 
 #ifdef CONFIG_X86_64
-void entry_SYSCALL_64(void);
-void entry_SYSCALL_64_safe_stack(void);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_64);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_64_safe_stack);
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
 #ifdef CONFIG_X86_32
-void entry_INT80_32(void);
-void entry_SYSENTER_32(void);
-void __begin_SYSENTER_singlestep_region(void);
-void __end_SYSENTER_singlestep_region(void);
+DECLARE_ASM_FUNC_SYMBOL(entry_INT80_32);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSENTER_32);
+DECLARE_ASM_FUNC_SYMBOL(__begin_SYSENTER_singlestep_region);
+DECLARE_ASM_FUNC_SYMBOL(__end_SYSENTER_singlestep_region);
 #endif
 
 #ifdef CONFIG_IA32_EMULATION
-void entry_SYSENTER_compat(void);
-void __end_entry_SYSENTER_compat(void);
-void entry_SYSCALL_compat(void);
-void entry_SYSCALL_compat_safe_stack(void);
-void entry_INT80_compat(void);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSENTER_compat);
+DECLARE_ASM_FUNC_SYMBOL(__end_entry_SYSENTER_compat);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_compat);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_compat_safe_stack);
+DECLARE_ASM_FUNC_SYMBOL(entry_INT80_compat);
 #ifdef CONFIG_XEN_PV
-void xen_entry_INT80_compat(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_entry_INT80_compat);
 #endif
 #endif
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 45697e04d771..df2be1efa35e 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -17,12 +17,9 @@
  */
 
 /* Handles exceptions in both to and from, but doesn't do access_ok */
-__must_check unsigned long
-copy_user_enhanced_fast_string(void *to, const void *from, unsigned len);
-__must_check unsigned long
-copy_user_generic_string(void *to, const void *from, unsigned len);
-__must_check unsigned long
-copy_user_generic_unrolled(void *to, const void *from, unsigned len);
+DECLARE_ASM_FUNC_SYMBOL(copy_user_enhanced_fast_string);
+DECLARE_ASM_FUNC_SYMBOL(copy_user_generic_string);
+DECLARE_ASM_FUNC_SYMBOL(copy_user_generic_unrolled);
 
 static __always_inline __must_check unsigned long
 copy_user_generic(void *to, const void *from, unsigned len)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e9da3dc71254..0c60a7fa6fa5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -530,7 +530,7 @@ extern struct paravirt_patch_site __start_parainstructions[],
  * convention such that we can 'call' it from assembly.
  */
 
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
+DECLARE_ASM_FUNC_SYMBOL(int3_magic);
 
 asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1b3ce3b4a2a2..9e0c07a82b44 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -589,7 +589,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern void ftrace_graph_call(void);
+DECLARE_ASM_FUNC_SYMBOL(ftrace_graph_call);
 
 static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ebc45360ffd4..737437043e40 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -138,7 +138,7 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 }
 
 /* These are in entry.S */
-extern void native_iret(void);
+DECLARE_ASM_FUNC_SYMBOL(native_iret);
 
 static struct resource reserve_ioports = {
 	.start = 0,
@@ -403,7 +403,7 @@ struct paravirt_patch_template pv_ops = {
 #ifdef CONFIG_PARAVIRT_XXL
 NOKPROBE_SYMBOL(native_load_idt);
 
-void (*paravirt_iret)(void) = native_iret;
+asm_func_ptr paravirt_iret = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2837110e66ed..1f81f939d982 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -201,7 +201,7 @@ struct opcode {
 		const struct escape *esc;
 		const struct instr_dual *idual;
 		const struct mode_dual *mdual;
-		void (*fastop)(struct fastop *fake);
+		fastop_t fastop;
 	} u;
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
 };
@@ -322,7 +322,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	__FOP_RET(#name)
 
 #define FOP_START(op) \
-	extern void em_##op(struct fastop *fake); \
+	DECLARE_ASM_FUNC_SYMBOL(em_##op); \
 	asm(".pushsection .text, \"ax\" \n\t" \
 	    ".global em_" #op " \n\t" \
 	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 68b420289d7e..44c1a9324e1c 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -290,13 +290,8 @@ enum x86emul_mode {
 #define X86EMUL_SMM_MASK             (1 << 6)
 #define X86EMUL_SMM_INSIDE_NMI_MASK  (1 << 7)
 
-/*
- * fastop functions are declared as taking a never-defined fastop parameter,
- * so they can't be called from C directly.
- */
-struct fastop;
-
-typedef void (*fastop_t)(struct fastop *);
+/* fastop functions cannot be called from C directly. */
+typedef asm_func_ptr fastop_t;
 
 struct x86_emulate_ctxt {
 	void *vcpu;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 6cf3c379bbaa..62dd7ae00e3f 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -612,8 +612,8 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_machine_check)
 #endif
 
 struct trap_array_entry {
-	void (*orig)(void);
-	void (*xen)(void);
+	asm_func_ptr orig;
+	asm_func_ptr xen;
 	bool ist_okay;
 };
 
@@ -672,7 +672,7 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
 		struct trap_array_entry *entry = trap_array + nr;
 
 		if (*addr == entry->orig) {
-			*addr = entry->xen;
+			*addr = (void *)entry->xen;
 			ist_okay = entry->ist_okay;
 			found = true;
 			break;
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 8d7ec49a35fb..b5ceb3007cfe 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -8,12 +8,12 @@
 #include <xen/xen-ops.h>
 
 /* These are code, but not functions.  Defined in entry.S */
-extern const char xen_failsafe_callback[];
+DECLARE_ASM_FUNC_SYMBOL(xen_failsafe_callback);
 
-void xen_sysenter_target(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_sysenter_target);
 #ifdef CONFIG_X86_64
-void xen_syscall_target(void);
-void xen_syscall32_target(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_syscall_target);
+DECLARE_ASM_FUNC_SYMBOL(xen_syscall32_target);
 #endif
 
 extern void *xen_initial_gdt;
@@ -136,7 +136,7 @@ __visible unsigned long xen_read_cr2(void);
 __visible unsigned long xen_read_cr2_direct(void);
 
 /* These are not functions, and cannot be called normally */
-__visible void xen_iret(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_iret);
 
 extern int xen_panic_handler_init(void);
 
-- 
2.33.0.800.g4c38ced690-goog

