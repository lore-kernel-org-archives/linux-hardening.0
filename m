Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4CBC63682
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbiAZRak (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiAZRak (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E38C06161C
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 09:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B5D61B2A
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185A6C340EB;
        Wed, 26 Jan 2022 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218239;
        bh=3HM7cQ/5N69Z4WxpXnGFX7UUgDMV0EwcZH/b3alT5MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM9U8MROkoJLF5koOvGfND8rtkARDS0xElyd8ZLZ1SeO+tt+C0gEkRQoxolW0A9GI
         GjzPwoNeXX1fTaPwP8QHByZ8g7ri6VwDer6HfOD1uDbE3O/EkgLQ3Npw2XEtG0MhUb
         7LMCYpQk0FXf64PycFyERMZo6B178hbbXsRPVl7c3asss8hxXBXEn8EUe7gH8Ikd43
         HBXXUj3UDGXriSrmd++xroGj+NM+QniWFIw1RzkawBF7k18HLCX/eGokA2RNtpd38d
         L+2W1yoGkH+gGnTAMUXND7BAuT5UB7Dq1M7GzAeQWWxgAVriGsEPsQ+rZqf+fI3d/f
         sBlDcGvouqG6Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, linux-hardening@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 07/12] arm64: mm: remap PTE level user page tables r/o in the linear region
Date:   Wed, 26 Jan 2022 18:30:06 +0100
Message-Id: <20220126173011.3476262-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; h=from:subject; bh=3HM7cQ/5N69Z4WxpXnGFX7UUgDMV0EwcZH/b3alT5MU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUZ1RR/n6TU46VHyO1VfjhX818sE8OO55BQ1a3R cttM4YyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFGQAKCRDDTyI5ktmPJAVUC/ 9sP1raif5eNZV8SPcUfEepaqcSdCHY9WgssrVKYXJxgfTrJajTRn3+i0Y3FydsD2+cxtG97P/jI07s rfCBDteJnj6WUQO0Lvc7TFFjaDjnPVFle7LzPqwU9IOPhwXDSBDJEpIowmibeunyIZNiZG5Aw+z05c l+IgEkdhEZdHn0nJfvi0q5DT3OxamA4/YPimDlA61Cywtl9y0RQ8w/a0tDNZoan/KbXNHE4V3EvvP8 ePqWl2lGthkj7wSnWopnQgN2OJaHHbMzuA9WOp9p8GBPCD+n0rylao06CuidkqhmqDqtr05gUREs55 YPUkWo5MW/WN43kmPTieytr0uEsMClfD3H08qHlzZqaBDbGih8rhzeIBdgMgJx6hejX6Wnoppe+E1l FcvCn3hlvYVz+1zbBEKReWDG+SRBHknt4H3dVFapaiBMkggdcz2n49nD1Ewsbi3YHRP+F62Zfm+Cvf tAV9RgZaj9+11f/gXa3AXAAG03JUP+ysfAL2uqnKisVDs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Now that all PTE manipulations for user space tables go via the fixmap,
we can remap these tables read-only in the linear region so they cannot
be corrupted inadvertently.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgalloc.h |  5 +++++
 arch/arm64/include/asm/tlb.h     |  2 ++
 arch/arm64/mm/mmu.c              | 23 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 63f9ae9e96fe..18a5bb0c9ee4 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -18,10 +18,15 @@
 #define __HAVE_ARCH_PUD_FREE
 #define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PMD_FREE
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#define __HAVE_ARCH_PTE_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
+pgtable_t pte_alloc_one(struct mm_struct *mm);
+void pte_free(struct mm_struct *mm, struct page *pte_page);
+
 #if CONFIG_PGTABLE_LEVELS > 2
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr);
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 0f54fbb59bba..e69a44160cce 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -75,6 +75,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
+	if (page_tables_are_ro())
+		set_pgtable_rw(page_address(pte));
 	pgtable_pte_page_dtor(pte);
 	tlb_remove_table(tlb, pte);
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e55d91a5f1ed..949846654797 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1686,3 +1686,26 @@ void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	free_page((u64)pmd);
 }
 #endif
+
+pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	pgtable_t pgt = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+
+	VM_BUG_ON(mm == &init_mm);
+
+	if (!pgt)
+		return NULL;
+	if (page_tables_are_ro())
+		set_pgtable_ro(page_address(pgt));
+	return pgt;
+}
+
+void pte_free(struct mm_struct *mm, struct page *pte_page)
+{
+	VM_BUG_ON(mm == &init_mm);
+
+	if (page_tables_are_ro())
+		set_pgtable_rw(page_address(pte_page));
+	pgtable_pte_page_dtor(pte_page);
+	__free_page(pte_page);
+}
-- 
2.30.2

