Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93224C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457454AbiAYJ1m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573024AbiAYJSj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 04:18:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99666C06177D
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 01:15:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C0DCB8173C
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 09:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A46C340E7;
        Tue, 25 Jan 2022 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643102115;
        bh=14Hmwc8lScA0KQlUzpYzyWjjgsdqpgUn2q4RimE1lsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pj6LsbSKKMgiCXVHxv0w4vNfFxEAy+12GMbw5w7sskCK09H/xP8avgmuhoPsAn12F
         nJap5wTtseUXwVGKmqbGG+zcXv5jtocxpemwSvYOGhjo5Cg44Lhplq5T/OkIeyYbTi
         kb3YHNPUSxZjhnyTDXBgYUN9eFszhbb8l8vNTZYMVXN0Bkuu7RKiAvAuKuK1S45kOT
         NqY3y1X8vRscHLTfmJ3eB8bLUIzkjYZXEwvneDylOG+dFiy6haIHPIV5CpTlITM2Tl
         sDVbWtJN78/FRiiQ08vK5SepixyDeqfE8YHzkwMijj/ynVPbA5xTR9b+lv+jlpdEaU
         BtpRdfC45ydnQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v6 5/8] ARM: mm: make vmalloc_seq handling SMP safe
Date:   Tue, 25 Jan 2022 10:14:50 +0100
Message-Id: <20220125091453.1475246-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125091453.1475246-1-ardb@kernel.org>
References: <20220125091453.1475246-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7628; h=from:subject; bh=14Hmwc8lScA0KQlUzpYzyWjjgsdqpgUn2q4RimE1lsc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh77+Gon/MXTuvZ21AtabZWtOSby6aw3idYj71VwdY 4LC6ih2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe+/hgAKCRDDTyI5ktmPJGI/C/ 0fbj+Lm4EBs+bgnH2b0+DFie769eX9I1JrluJ7i+LAr7YWW81qVouBV0XC5Ugj/MFHbfuB/TOBjYjx l61sdYbbxfQGfhWho8YZhgCGLPfMpcZJCTgxElYf9Ny1urJLw7RKIIJtQMXH1CyYeKIkuvzH1/ba23 0ohrJ6lXd4qhHObUgspg/OTrJCi81+yvtwzC5BZNnLNJiEBfD0ffNkIJfL5eUGgEaRcT6vqYsCJ/HV wIB9VLFpJ7sH2aCCEDNds9ycgZWb6JcMW1tt/NDdp+EJZTwBOXkCX9cLghgjil7JQ5PQ8O+rZ4T6Zq F0ZkJRncGHqLfMYQQ4riJFK52mC/WzfnrGMTrb2K5Dnxsw10p2DQvj/2GN/AlvyCzV65u+EurfYaRt vpp/n8GH6e84UtvM05uXIAuF1nJmppRumCfpWr2/FfeBMyldvLewgBWC8xBDfta5fwfEBmK9y+DVp2 thg5RTeueCul/ca80tOQaHAOM4CvhGn9+6V8LBDxJ2F5k=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Rework the vmalloc_seq handling so it can be used safely under SMP, as
we started using it to ensure that vmap'ed stacks are guaranteed to be
mapped by the active mm before switching to a task, and here we need to
ensure that changes to the page tables are visible to other CPUs when
they observe a change in the sequence count.

Since LPAE needs none of this, fold a check against it into the
vmalloc_seq counter check after breaking it out into a separate static
inline helper.

Given that vmap'ed stacks are now also supported on !SMP configurations,
let's drop the WARN() that could potentially now fire spuriously.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/mmu.h         |  2 +-
 arch/arm/include/asm/mmu_context.h | 22 +++++++++++++++--
 arch/arm/include/asm/page.h        |  3 +--
 arch/arm/kernel/traps.c            | 25 ++++++--------------
 arch/arm/mm/context.c              |  3 +--
 arch/arm/mm/ioremap.c              | 18 ++++++++------
 6 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 1592a4264488..e049723840d3 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -10,7 +10,7 @@ typedef struct {
 #else
 	int		switch_pending;
 #endif
-	unsigned int	vmalloc_seq;
+	atomic_t	vmalloc_seq;
 	unsigned long	sigpage;
 #ifdef CONFIG_VDSO
 	unsigned long	vdso;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 84e58956fcab..db2cb06aa8cf 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -23,6 +23,16 @@
 
 void __check_vmalloc_seq(struct mm_struct *mm);
 
+#ifdef CONFIG_MMU
+static inline void check_vmalloc_seq(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_ARM_LPAE) &&
+	    unlikely(atomic_read(&mm->context.vmalloc_seq) !=
+		     atomic_read(&init_mm.context.vmalloc_seq)))
+		__check_vmalloc_seq(mm);
+}
+#endif
+
 #ifdef CONFIG_CPU_HAS_ASID
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
@@ -52,8 +62,7 @@ static inline void a15_erratum_get_cpumask(int this_cpu, struct mm_struct *mm,
 static inline void check_and_switch_context(struct mm_struct *mm,
 					    struct task_struct *tsk)
 {
-	if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
-		__check_vmalloc_seq(mm);
+	check_vmalloc_seq(mm);
 
 	if (irqs_disabled())
 		/*
@@ -129,6 +138,15 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
index 7b871ed99ccf..5fcc8a600e36 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -147,11 +147,10 @@ extern void copy_page(void *to, const void *from);
 #include <asm/pgtable-3level-types.h>
 #else
 #include <asm/pgtable-2level-types.h>
-#endif
-
 #ifdef CONFIG_VMAP_STACK
 #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 #endif
+#endif
 
 #endif /* CONFIG_MMU */
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3f38357efc46..08612032aefe 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -885,6 +885,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 	die("kernel stack overflow", regs, 0);
 }
 
+#ifndef CONFIG_ARM_LPAE
 /*
  * Normally, we rely on the logic in do_translation_fault() to update stale PMD
  * entries covering the vmalloc space in a task's page tables when it first
@@ -895,26 +896,14 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
  * So we need to ensure that these PMD entries are up to date *before* the MM
  * switch. As we already have some logic in the MM switch path that takes care
  * of this, let's trigger it by bumping the counter every time the core vmalloc
- * code modifies a PMD entry in the vmalloc region.
+ * code modifies a PMD entry in the vmalloc region. Use release semantics on
+ * the store so that other CPUs observing the counter's new value are
+ * guaranteed to see the updated page table entries as well.
  */
 void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
-	if (start > VMALLOC_END || end < VMALLOC_START)
-		return;
-
-	/*
-	 * This hooks into the core vmalloc code to receive notifications of
-	 * any PMD level changes that have been made to the kernel page tables.
-	 * This means it should only be triggered once for every MiB worth of
-	 * vmalloc space, given that we don't support huge vmalloc/vmap on ARM,
-	 * and that kernel PMD level table entries are rarely (if ever)
-	 * updated.
-	 *
-	 * This means that the counter is going to max out at ~250 for the
-	 * typical case. If it overflows, something entirely unexpected has
-	 * occurred so let's throw a warning if that happens.
-	 */
-	WARN_ON(++init_mm.context.vmalloc_seq == UINT_MAX);
+	if (start < VMALLOC_END && end > VMALLOC_START)
+		atomic_inc_return_release(&init_mm.context.vmalloc_seq);
 }
-
+#endif
 #endif
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 48091870db89..4204ffa2d104 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -240,8 +240,7 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	unsigned int cpu = smp_processor_id();
 	u64 asid;
 
-	if (unlikely(mm->context.vmalloc_seq != init_mm.context.vmalloc_seq))
-		__check_vmalloc_seq(mm);
+	check_vmalloc_seq(mm);
 
 	/*
 	 * We cannot update the pgd and the ASID atomicly with classic
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 6e830b9418c9..8963c8c63471 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -117,16 +117,21 @@ EXPORT_SYMBOL(ioremap_page);
 
 void __check_vmalloc_seq(struct mm_struct *mm)
 {
-	unsigned int seq;
+	int seq;
 
 	do {
-		seq = init_mm.context.vmalloc_seq;
+		seq = atomic_read(&init_mm.context.vmalloc_seq);
 		memcpy(pgd_offset(mm, VMALLOC_START),
 		       pgd_offset_k(VMALLOC_START),
 		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
 					pgd_index(VMALLOC_START)));
-		mm->context.vmalloc_seq = seq;
-	} while (seq != init_mm.context.vmalloc_seq);
+		/*
+		 * Use a store-release so that other CPUs that observe the
+		 * counter's new value are guaranteed to see the results of the
+		 * memcpy as well.
+		 */
+		atomic_set_release(&mm->context.vmalloc_seq, seq);
+	} while (seq != atomic_read(&init_mm.context.vmalloc_seq));
 }
 
 #if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
@@ -157,7 +162,7 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 			 * Note: this is still racy on SMP machines.
 			 */
 			pmd_clear(pmdp);
-			init_mm.context.vmalloc_seq++;
+			atomic_inc_return_release(&init_mm.context.vmalloc_seq);
 
 			/*
 			 * Free the page table, if there was one.
@@ -174,8 +179,7 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 	 * Ensure that the active_mm is up to date - we want to
 	 * catch any use-after-iounmap cases.
 	 */
-	if (current->active_mm->context.vmalloc_seq != init_mm.context.vmalloc_seq)
-		__check_vmalloc_seq(current->active_mm);
+	check_vmalloc_seq(current->active_mm);
 
 	flush_tlb_kernel_range(virt, end);
 }
-- 
2.30.2

