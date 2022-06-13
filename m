Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93415C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244819AbiFMSbB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245478AbiFMSas (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD01DB5265
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C3D3B80D3A
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F7C3411C;
        Mon, 13 Jun 2022 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131571;
        bh=MOxOXJnGpg5TUDUO2XlF3OzGJWdVrlbZIXIpJOjZyno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7zejOFJpvwxwWM63VreTuFtSXhabiQH2uf/y9NE0sXvz8Pdpif/cg85tvVYAih2C
         FMzhV01unP2jdD/ca5Z6G4HEG927Z8sVxMxPI5Tmt3WVTiKsRxyeTohhIy30rUJdmk
         mLZ4YdDwuB1wsj9fVGunqDzsspGSsR1atCrshyFR3UiYfuJxRpM8jrYCl+BtwbP3Bw
         tBDmfSfBSd+WJDp78FAoITEZpdv0TCCuPllCqoFqaRn+cijiZlZj+FZ16SbRGGMqrl
         GvoZdf44UMRXLl+v89y6iYbf3xJJL8/Md/WOPc/gzuT+5y5BbbiUTvTJt8yiGmiEen
         aAeGRGrvzlFNA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 03/26] arm64: head: move assignment of idmap_t0sz to C code
Date:   Mon, 13 Jun 2022 16:45:27 +0200
Message-Id: <20220613144550.3760857-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4319; h=from:subject; bh=MOxOXJnGpg5TUDUO2XlF3OzGJWdVrlbZIXIpJOjZyno=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip01wmAAjBZtg6NS/uQsi6pJqi5PtSQQLGqiAfksE N0IgHhaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNcAAKCRDDTyI5ktmPJPrQC/ 0bc6nQyj39dUx7Lm1z6C5RTayH1RZ98bJjCm6dA32gEfMRv6FicqwGvn6X9t2CrtisTYQ4spS1zVg3 RYD+vq5f/GtfQdViZE9EjSAxQ1JLe08XKrnI2ARZDjp1H5t+Ky9YWDDt22GdDstVnurC0Wxplyumj0 yaRlTXQlsaa8oI2xu/c5w65ZX9PPcr4T1l3YyJQvKZ6uLBTVsQB3HNiZZHd/eVAUPIcODJZ+2s6p1y 3MeIhhuVnCUyT+ATULbwnP6UmwVxQH4ZutZXSfxpHAVjMdb4VYzsrQImuyUGJ80AIyVZgjj2OelZbY 4eOOhdhvBOFGpRWbrXUMwxPL+P2CZwsWdJZYH3CEOkbWwVNjPG4CAA3O7nMcWNuHpntFTXQKuoDjoo MqeC68FqDgxah02yNIU+HrO2GAwYqeouOZMSXLQrAptpK1rMNls03vD5a+Bbblo8YlOwkr8hk8K78F 6G+OnO3hJaZNHMEyLJMCQQ1rEtS1g2q02bJD2Ip7jt198=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Setting idmap_t0sz involves fiddling with the caches if done with the
MMU off. Since we will be creating an initial ID map with the MMU and
caches off, and the permanent ID map with the MMU and caches on, let's
move this assignment of idmap_t0sz out of the startup code, and replace
it with a macro that simply issues the three instructions needed to
calculate the value wherever it is needed before the MMU is turned on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h   | 14 ++++++++++++++
 arch/arm64/include/asm/mmu_context.h |  2 +-
 arch/arm64/kernel/head.S             | 13 +------------
 arch/arm64/mm/mmu.c                  |  5 ++++-
 arch/arm64/mm/proc.S                 |  2 +-
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8c5a61aeaf8e..9468f45c07a6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -359,6 +359,20 @@ alternative_cb_end
 	bfi	\valreg, \t1sz, #TCR_T1SZ_OFFSET, #TCR_TxSZ_WIDTH
 	.endm
 
+/*
+ * idmap_get_t0sz - get the T0SZ value needed to cover the ID map
+ *
+ * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
+ * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
+ * this number conveniently equals the number of leading zeroes in
+ * the physical address of _end.
+ */
+	.macro	idmap_get_t0sz, reg
+	adrp	\reg, _end
+	orr	\reg, \reg, #(1 << VA_BITS_MIN) - 1
+	clz	\reg, \reg
+	.endm
+
 /*
  * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
  * ID_AA64MMFR0_EL1.PARange value
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 6770667b34a3..6ac0086ebb1a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -60,7 +60,7 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
  * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
  * physical memory, in which case it will be smaller.
  */
-extern u64 idmap_t0sz;
+extern int idmap_t0sz;
 extern u64 idmap_ptrs_per_pgd;
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index dc07858eb673..7f361bc72d12 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -299,22 +299,11 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * physical address space. So for the ID map, use an extended virtual
 	 * range in that case, and configure an additional translation level
 	 * if needed.
-	 *
-	 * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
-	 * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
-	 * this number conveniently equals the number of leading zeroes in
-	 * the physical address of __idmap_text_end.
 	 */
-	adrp	x5, __idmap_text_end
-	clz	x5, x5
+	idmap_get_t0sz x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
 
-	adr_l	x6, idmap_t0sz
-	str	x5, [x6]
-	dmb	sy
-	dc	ivac, x6		// Invalidate potentially stale cache line
-
 #if (VA_BITS < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17b339c1a326..103bf4ae408d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -43,7 +43,7 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
-u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
+int idmap_t0sz __ro_after_init;
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
 #if VA_BITS > 48
@@ -785,6 +785,9 @@ void __init paging_init(void)
 			       (u64)&vabits_actual + sizeof(vabits_actual));
 #endif
 
+	idmap_t0sz = min(63UL - __fls(__pa_symbol(_end)),
+			 TCR_T0SZ(VA_BITS_MIN));
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 972ce8d7f2c5..97cd67697212 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -470,7 +470,7 @@ SYM_FUNC_START(__cpu_setup)
 	add		x9, x9, #64
 	tcr_set_t1sz	tcr, x9
 #else
-	ldr_l		x9, idmap_t0sz
+	idmap_get_t0sz	x9
 #endif
 	tcr_set_t0sz	tcr, x9
 
-- 
2.30.2

