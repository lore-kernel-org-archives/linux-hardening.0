Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795CCC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jan 2022 17:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiAXRtj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiAXRth (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C162C06173B
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 09:49:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A37361342
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 17:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B8AC340EB;
        Mon, 24 Jan 2022 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046576;
        bh=jU8c5g2WDlSn9v2Q9DGIfV+/kV2NVDFaFycyGk9Twqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rgxfhxySuIBkaqwY1+yY78fl5v3+cxN1pL6tYm1PmH9CqNrCg/cnk6e6I0S9GOopX
         /rJu+eLhfpS3pdTXrqX79DoDglabOpKKnJAUUkVNQlJv724h3RJ9XUhvEsVYjz2T52
         haP1dccSnmj29jmeY2khrJKJGtC2K8dPrWyI61Af9MHTWCiGvnmmYvlGUhn9kx0oy3
         mXEpDeHwbvB0/Aqp2rRRscnNRQT/ACy3GShh7jBdu8owGc7lcgPt3F4Tw8NLh7Ls63
         lVcOoSsr9ruFllduGkFdzQAolQWYoXrWt//SwKJ3CoCAGw9EG37uek7MNPi1IcP8ds
         ihXRfPRl7VzRw==
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
Subject: [PATCH v5 31/32] ARM: mm: prepare vmalloc_seq handling for use under SMP
Date:   Mon, 24 Jan 2022 18:47:43 +0100
Message-Id: <20220124174744.1054712-32-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124174744.1054712-1-ardb@kernel.org>
References: <20220124174744.1054712-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675; h=from:subject; bh=jU8c5g2WDlSn9v2Q9DGIfV+/kV2NVDFaFycyGk9Twqw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7uY9a1FStKiCLg0kjH4hSkqtT1XyOzh8RYH56pR0 9dazmzaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYe7mPQAKCRDDTyI5ktmPJA5rC/ 9qNSoF2/6hE3+ryWpWlkUofg7CgUuwTstIW0N8r6M7K6h8ypzpJGi9WuGQtp1Imv+DyhXpHSHyN4rt Xha/7nzmD5AEqjMJAD+eFimpg+P2v/zba2su8+DK2h6EYa0Ml3okOAektufsQ8gLtIxW/tHya/NFLS +lhyzBYUwUePOtVMfK2WAvCB/CzTcx4U5pDzdN8KqtaDhFc/Kp37gi7l7/6zgtok9e47lIKCsNT51y B0SBW+oZpLIgk2kPQuaejCAVkL5AieaYqjjvqu1S7t1WT5iKnAL/rQFa//MUnGl/iyYifMkg8fvqul EQH/A1y2E5XInz8HqlxgbTk/5JQd7UkUNbrHfpPNp0hDCY7eN1x6Yq+bYT0ngwCUGaoXtAd2vbi6Yh 1dDDhWPO2cRRjjAw1QxXJDpumz3V9YCeD3cjorBYol7IO1mkMce6NyUIwyL0S++dgWL7Z5giFlkFzm HcPsdfilSDlhgK2c9k1Iofqzj599K9LVTCcvng4f2Yw/4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, the vmalloc_seq counter is only used to keep track of changes
in the vmalloc region on !SMP builds, which means there is no need to
deal with concurrency explicitly.

However, in a subsequent patch, we will wire up this same mechanism for
ensuring that vmap'ed stacks are guaranteed to be mapped by the active
mm before switching to a task, and here we need to ensure that changes
to the page tables are visible to other CPUs when they observe a change
in the sequence count.

Since LPAE needs none of this, fold a check against it into the
vmalloc_seq counter check after breaking it out into a separate static
inline helper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/mmu.h         |  2 +-
 arch/arm/include/asm/mmu_context.h | 13 +++++++++++--
 arch/arm/mm/context.c              |  3 +--
 arch/arm/mm/ioremap.c              | 18 +++++++++++-------
 4 files changed, 24 insertions(+), 12 deletions(-)

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
index 84e58956fcab..71a26986efb9 100644
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
index 197f8eb3a775..aa08bcb72db9 100644
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

