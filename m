Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD4CCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiFMSbJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbiFMSay (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102CB5796
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F056361425
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E20EC3411C;
        Mon, 13 Jun 2022 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131588;
        bh=cv6whgl2z7JZo6tnp1PQyUxOswH4dR7tCbdxED6uDp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNMtvfrDqcAcXoJ9oICvcIsZjui7tgR4BjI+2lZp6WJ5w9Fh0JK9zwmsZsgHq6qQh
         6u22N5eHwF4wQkqz47pNAu2TRqrwF6SYEsSuPj5ml71ntdzZCdXS1TiNbv3b0ICyZH
         B941SKgjedXPbZdgx3Pt5eBSXm4TxNbRI+B6PiaV6Rk2yhu4IiYc1mCffElQAvO8Zn
         aoGFbHk1qBWDhtPRyyCGMrzPUIxu55enSYwSFHUhA84iCY5ck/WJK8jxq+TkPHk/1T
         qXB7G2Rqu/bqsnlEoO03lpkoeWWmN1WvALcYTg4U0kvZQ6sNNQNpdWikMtugqAFJvn
         9GAQKMaZKSKlw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 10/26] arm64: mm: provide idmap pointer to cpu_replace_ttbr1()
Date:   Mon, 13 Jun 2022 16:45:34 +0200
Message-Id: <20220613144550.3760857-11-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4222; h=from:subject; bh=cv6whgl2z7JZo6tnp1PQyUxOswH4dR7tCbdxED6uDp8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip019pVTLm+BWPgAiR52i6nWrBSQlXyRlJcHCaoHW cw12nbWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNfQAKCRDDTyI5ktmPJK/PC/ sG4MFRLXkzIElAspzfePKPYR0XMxZElX3aV+5Hcp/iiBtDE8+j1ngeBdwnFeGuE+s2oy2h32vRnhBk tCExr6iQbQ1no+tCs4jTnTh4Lh57oE4Zr8N8IgbflAGuiRKUz9uN8wjHYb/64q9+PB9YsaOAQmbWqW Uc0hcdzU9TKQom8/Y3Dz/IdlDNwPDSqmnsopWlLfYLrc2Akyphi1Bvun8/PBSvNqCnwdZXRnMWnXb3 6ONQwP7WXfet+o63g+XHJkb1lAPumh3E8nHZgQnzixMxvP44VsuxjGqAaH/Rs0v8KBh+vPS8pCuyJG LYiTi4OuEjgiHicLHSZ+njrJvOTevkXcnNEzDKSZMBT4RnXU8lwLs94GeuKZUDubAzQuTzMzEFkCb3 j+LmBVaL01n9wAzjNOANL9GgAyHtsNdxJKGn9nEYIXS3BldFizIRpIF2bMjyb67UdkZfBwviAExqk0 +Ji/U6F1lR7ejC7d0W0/45CBZoF/ehHf8vguq18n8e24Y=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for changing the way we initialize the permanent ID map,
update cpu_replace_ttbr1() so we can use it with the initial ID map as
well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 13 +++++++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/suspend.c          |  2 +-
 arch/arm64/mm/kasan_init.c           |  4 ++--
 arch/arm64/mm/mmu.c                  |  2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 7b387c3b312a..c7ccd82db1d2 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -105,13 +105,18 @@ static inline void cpu_uninstall_idmap(void)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
-static inline void cpu_install_idmap(void)
+static inline void __cpu_install_idmap(pgd_t *idmap)
 {
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
 	cpu_set_idmap_tcr_t0sz();
 
-	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
+	cpu_switch_mm(lm_alias(idmap), &init_mm);
+}
+
+static inline void cpu_install_idmap(void)
+{
+	__cpu_install_idmap(idmap_pg_dir);
 }
 
 /*
@@ -142,7 +147,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
@@ -165,7 +170,7 @@ static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 
 	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
 
-	cpu_install_idmap();
+	__cpu_install_idmap(idmap);
 	replace_phys(ttbr1);
 	cpu_uninstall_idmap();
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c2a64c9e451e..f37d8f69c339 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3275,7 +3275,7 @@ subsys_initcall_sync(init_32bit_el0_mask);
 
 static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *cap)
 {
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 }
 
 /*
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 2b0887e58a7c..9135fe0f3df5 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -52,7 +52,7 @@ void notrace __cpu_suspend_exit(void)
 
 	/* Restore CnP bit in TTBR1_EL1 */
 	if (system_supports_cnp())
-		cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+		cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 
 	/*
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index c12cd700598f..e969e68de005 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -236,7 +236,7 @@ static void __init kasan_init_shadow(void)
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
-	cpu_replace_ttbr1(lm_alias(tmp_pg_dir));
+	cpu_replace_ttbr1(lm_alias(tmp_pg_dir), idmap_pg_dir);
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
@@ -280,7 +280,7 @@ static void __init kasan_init_shadow(void)
 				PAGE_KERNEL_RO));
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 }
 
 static void __init kasan_init_depth(void)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0f95c91e5a8e..74f9982c30a7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -792,7 +792,7 @@ void __init paging_init(void)
 
 	pgd_clear_fixmap();
 
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
 	init_mm.pgd = swapper_pg_dir;
 
 	memblock_phys_free(__pa_symbol(init_pg_dir),
-- 
2.30.2

