Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF9C63682
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiAZRai (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiAZRah (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2658C06161C
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 09:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3759661B14
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E85AC340ED;
        Wed, 26 Jan 2022 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218236;
        bh=EdjKbvFKm2bAF1qMp2eKnJLC/EwKCIgrl7Fs4CE7aNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6lWSgQpcYxHmKLLY804nbtXsPIyZqGOarRd0i4z7R07rXwNMpD9/g1kZsrbUUzOj
         KL0ChMM9aIRXhIz15v3Q+P6A7sgYNuVJplCuZfkNotrqHzgo0E0JQXfskGB6ntUtcI
         we1F6cNzyT6bnrOH8rhKDNhAUlU2RpLrvfxqkP1L8sicboSpzy8+FkHxS35WdHHn+8
         KIB8LX5s0N5hoOqvt4WUyunQgLzuRQEAwhGNAcNshIpT0qltAy/EKjGe6jmNlCeuom
         BpzckJbqmN0647KSZ0FR5W6jRRiz9H6ZzQJ8iVNv1O5b2AjAclwLQBVyksmFPRSJ9K
         YWKWt2725E9IA==
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
Subject: [RFC PATCH 06/12] arm64: mm: remap PMD pages r/o in linear region
Date:   Wed, 26 Jan 2022 18:30:05 +0100
Message-Id: <20220126173011.3476262-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; h=from:subject; bh=EdjKbvFKm2bAF1qMp2eKnJLC/EwKCIgrl7Fs4CE7aNY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUXminiyVimuEy7o/9j5FK4FCDo9c8aQ+euoa+9 xZfUOg6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFFwAKCRDDTyI5ktmPJMcsDA C2XmwZEdc3cWvWVlY5OJKjSItfWPVhPyVtc2SVpON6oD8r6hvuOr9CH7TXILHnVwYZ8rLt85j2nrnv PG25exDWAAsn9cu4A3ctT878nXG+cDagm47FEQQSWXGD2rxWY3riF7EWbn2MPpRIezw9sY8Ufc3sSL Xo0V7ZI021PwTVaWobSY37WnwX6iLFuf7gVuZZp6Zl67b0tSC+PNCGdjEmfe/sFvvYNBbQfOdxS7T2 JN1bBts8FoqhfhSVMsB8w16JS2nJhLjvyvSOTxyzgOn8s5D/Uhs+HeBvZp1/KCkPmAxh5C2Sl8UUqL nj8hZTNhza/39pRqOfsFySKB+Nk+lSzb/bV9G96yR82mjhHskTJ1i8i651OjYNRsIq4i0qW3J6omuJ 40qrYd2l/E8Qf+FsiAsY+wdOdTD4QX1yLq7g57BUTnNFpEvHpCVpvSx57Oz35PdO3P/R1N8/sWFbww ISX+WkTd0VsakbUyb3xub95GUgB9dIE3ZGgtP1cwWOqOs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

PMD modifications all go through the fixmap update routine, so there is
no longer a need to keep it mapped read/write in the linear region.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgalloc.h |  5 +++++
 arch/arm64/include/asm/tlb.h     |  2 ++
 arch/arm64/mm/mmu.c              | 21 ++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 737e9f32b199..63f9ae9e96fe 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -16,12 +16,17 @@
 #define __HAVE_ARCH_PGD_FREE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
+#define __HAVE_ARCH_PMD_ALLOC_ONE
+#define __HAVE_ARCH_PMD_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
+pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr);
+void pmd_free(struct mm_struct *mm, pmd_t *pmd);
+
 static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 {
 	set_pud(pudp, __pud(__phys_to_pud_val(pmdp) | prot));
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 6557626752fc..0f54fbb59bba 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -85,6 +85,8 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct page *page = virt_to_page(pmdp);
 
+	if (page_tables_are_ro())
+		set_pgtable_rw(pmdp);
 	pgtable_pmd_page_dtor(page);
 	tlb_remove_table(tlb, page);
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 03d77c4c3570..e55d91a5f1ed 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1665,3 +1665,24 @@ void pud_free(struct mm_struct *mm, pud_t *pud)
 	free_page((u64)pud);
 }
 #endif
+
+#ifndef __PAGETABLE_PMD_FOLDED
+pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	pmd_t *pmd = __pmd_alloc_one(mm, addr);
+
+	if (!pmd)
+		return NULL;
+	if (page_tables_are_ro())
+		set_pgtable_ro(pmd);
+	return pmd;
+}
+
+void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	if (page_tables_are_ro())
+		set_pgtable_rw(pmd);
+	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	free_page((u64)pmd);
+}
+#endif
-- 
2.30.2

