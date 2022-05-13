Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FCC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384211AbiEMUXK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384222AbiEMUWq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3817857F
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c5767f0fso81488287b3.4
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pKueGfTY/goVznJAZHYRfYoVZQS7FwsuWNl2D1WQxOc=;
        b=AicD+aVMHbyUQgelDu/u1R/RkuImfZ3NGDh4a/dhInL4LzdUJxQBUWHXlNlcacf0eI
         CegXrZ2hbEYHxCUPYInEXPizy12BBQI2p1qyscoH6IJ4i67DbcWl83hZ0URoR1t83ocY
         c46yJ7P8M3Or0ilkvKBy91bhCu6kDnwYsiF04Im92neNmb6JP6jzyBds6Mv6f8qqAhbl
         oITe/nj0cScYIxxAw+C2IhHsj3Xs9ByKn4k4SHBna424pWvxrFdSR/60KXeg7yESas/W
         iOC1TWXB+03qjcnLDnZSLHddRJ8TkQYFlQZLdByDZojTADJhNpC7XlLuaG4fErPLqiX2
         soxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pKueGfTY/goVznJAZHYRfYoVZQS7FwsuWNl2D1WQxOc=;
        b=uKAzzVueUkgLzIy4xHetkgjIDS9pNrKVtMZujxt905J8tefF94bYZkSZ7Ko27CwUiD
         OlmxWn073zU0E2PuHsWejsb8n7GHv4Gi4svJmQ4hlkmNOzaUxZdrtmiYJSWkD5K4L3nq
         oGmaIkXujuvXVKN13K3yY9Cg9QQPHKSgoxoMXNUuHqRVkmSAt2/In0dDUF2SrXLKAOe3
         7kGCCNyLXmKVIpRTL/cf7oRNfaFUWfAGIHw/srFX6HFmd8JJ1TDvG5IB3e2KT8BWZEgV
         xpZwzdJs2qR2Qq2gFVpdmgVfQv0tygAonJPSzTanDB6D/Jtz/pjpOvn9IzAyky+CUgta
         3vOw==
X-Gm-Message-State: AOAM5317rxT0gXnJYrVY3Gr5ITfksqV5rFHwPeLEcHRiFNJ1z4CW/02W
        LwKYR019t4HwJK6EPIwgDjpV2MQCtn2vGG1etVA=
X-Google-Smtp-Source: ABdhPJy5NerZ1QnDRY0rssJnyjhliebRM5u8sYM6yAbU5xicftCyA+akr+zUPpxv5UkC8ZHwoVf/gQSETw7HtPBynIE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP
 id f127-20020a251f85000000b0064ba5fce881mr3747683ybf.514.1652473349990; Fri,
 13 May 2022 13:22:29 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:50 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=8359; h=from:subject;
 bh=GtdEXeDqgjL7YUExR6pdSdJ+hG7BYB7rjNpqb21+UBA=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3kPJP7OmlNlPlbiAOhG3bHnMXk3ULzMmONyfdc
 R6B9+SOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695AAKCRBMtfaEi7xW7gLlC/
 9ZqJK6Kjg5kn0Elz0CwXBy+P8cvualdfbnv3PcNfhsDu066XR3fGQzuwjfeTr0eiD/FRQZ7YUprO8d
 jcsKq+FhrcyaqCWDqG2iGCsZTMBWsYjsfakU0qhXmG3kTJCtm/tg09JcqIJW5CkA7k2lYo8c694yFt
 qbUJDc2cvKyZAXyO0EhZvHWc0I6H7b8rj1tpJmEgmEtCWqxAAyYAOdDsFBZC5tIEe41ao4EfDqxdd7
 kKSabDZgPqthIulZjR+830BQxel97CM4e522nqvu10rk5bVTjilOfbX5B9JxHNALN4a6NhBRNjHVi4
 iI04qnAKyKPXlXOoqvJuhTAthCuHBKhRTzqQ6yhQK3SBwxL37jqittFUoRUBzEQeGP2ufp6vVAn0dk
 NjiZ7sAd8rp2L4G0AzwgXsZPKJmuhj+8wexLnS8d8xz2eCFnz6WdTJB0s56pSbW7x9EJfbeoBjFsjd
 TxOe937WNZgFvk6Fl01Q4sJ7g6aZbD+3bgbs4x4K8HjEs=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 12/21] treewide: Drop function_nocfi
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

With -fsanitize=kcfi, we no longer need function_nocfi() as
the compiler won't change function references to point to a
jump table. Remove all implementations and uses of the macro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/compiler.h         | 16 ----------------
 arch/arm64/include/asm/ftrace.h           |  2 +-
 arch/arm64/include/asm/mmu_context.h      |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/cpufeature.c            |  2 +-
 arch/arm64/kernel/ftrace.c                |  2 +-
 arch/arm64/kernel/machine_kexec.c         |  2 +-
 arch/arm64/kernel/psci.c                  |  2 +-
 arch/arm64/kernel/smp_spin_table.c        |  2 +-
 drivers/firmware/psci/psci.c              |  4 ++--
 drivers/misc/lkdtm/usercopy.c             |  2 +-
 include/linux/compiler.h                  | 10 ----------
 12 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index dc3ea4080e2e..6fb2e6bcc392 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -23,20 +23,4 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
 
-#ifdef CONFIG_CFI_CLANG
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function address
- * references with the address of the function's CFI jump table
- * entry. The function_nocfi macro always returns the address of the
- * actual function instead.
- */
-#define function_nocfi(x) ({						\
-	void *addr;							\
-	asm("adrp %0, " __stringify(x) "\n\t"				\
-	    "add  %0, %0, :lo12:" __stringify(x)			\
-	    : "=r" (addr));						\
-	addr;								\
-})
-#endif
-
 #endif /* __ASM_COMPILER_H */
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1494cfa8639b..c96d47cb8f46 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -26,7 +26,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
-#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
+#define MCOUNT_ADDR		((unsigned long)_mcount)
 #endif
 
 /* The BL at the callsite's adjusted rec->ip */
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index ca0140d0b8cf..8fa4cfbdda90 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -164,7 +164,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 		ttbr1 |= TTBR_CNP_BIT;
 	}
 
-	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
+	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
 	replace_phys(ttbr1);
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index bfeeb5319abf..b1990e38aed0 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -99,7 +99,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 	 * that read this address need to convert this address to the
 	 * Boot-Loader's endianness before jumping.
 	 */
-	writeq_relaxed(__pa_symbol(function_nocfi(secondary_entry)),
+	writeq_relaxed(__pa_symbol(secondary_entry),
 		       &mailbox->entry_point);
 	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af78dcacf9fe..5dbe381670a0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1619,7 +1619,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	if (arm64_use_ng_mappings)
 		return;
 
-	remap_fn = (void *)__pa_symbol(function_nocfi(idmap_kpti_install_ng_mappings));
+	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	cpu_install_idmap();
 	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 4506c4a90ac1..4128ca6ed485 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -56,7 +56,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned long pc;
 	u32 new;
 
-	pc = (unsigned long)function_nocfi(ftrace_call);
+	pc = (unsigned long)ftrace_call;
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e16b248699d5..4eb5388aa5a6 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -204,7 +204,7 @@ void machine_kexec(struct kimage *kimage)
 		typeof(cpu_soft_restart) *restart;
 
 		cpu_install_idmap();
-		restart = (void *)__pa_symbol(function_nocfi(cpu_soft_restart));
+		restart = (void *)__pa_symbol(cpu_soft_restart);
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ab7f4c476104..29a8e444db83 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -38,7 +38,7 @@ static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 
 static int cpu_psci_cpu_boot(unsigned int cpu)
 {
-	phys_addr_t pa_secondary_entry = __pa_symbol(function_nocfi(secondary_entry));
+	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
 	if (err)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7e1624ecab3c..49029eace3ad 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -66,7 +66,7 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
 static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
 	__le64 __iomem *release_addr;
-	phys_addr_t pa_holding_pen = __pa_symbol(function_nocfi(secondary_holding_pen));
+	phys_addr_t pa_holding_pen = __pa_symbol(secondary_holding_pen);
 
 	if (!cpu_release_addr[cpu])
 		return -ENODEV;
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 6554bf4b8c99..16a1daec8cd2 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -334,7 +334,7 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
-	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
 
 	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
@@ -359,7 +359,7 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
-	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+	phys_addr_t pa_cpu_resume = __pa_symbol(cpu_resume);
 
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
 			      pa_cpu_resume, 0, 0);
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 9161ce7ed47a..79a17b1c4885 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -318,7 +318,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
+	if (copy_to_user((void __user *)user_addr, vm_mmap,
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 9303f5fe5d89..80ed9644d129 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -203,16 +203,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
- * instrumented C code with jump table addresses. Architectures that
- * support CFI can define this macro to return the actual function address
- * when needed.
- */
-#ifndef function_nocfi
-#define function_nocfi(x) (x)
-#endif
-
 #endif /* __KERNEL__ */
 
 /*
-- 
2.36.0.550.gb090851708-goog

