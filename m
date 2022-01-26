Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B10C28CF5
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiAZRaf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:30:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiAZRae (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 12:30:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 798C561B14
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 17:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5052C340E7;
        Wed, 26 Jan 2022 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218233;
        bh=pO2QvUUsV5L71fd/N5ug5v8ZnpkBMeHmPsJTXFD+MSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4mWX3z03gi8sHlG0EWbH3tBlmtzj7tvg3DWAos6nt50rpnSz+y4Eo/8029jByzvN
         1QS6bxsqkew7z6/g9AMZR9VyY1rGyCZIpSGhsDL6MXG2ly75+IVJGMwbP5qQNQmnc5
         niDLO7NXIvS8SW/sS+Iu9RE0rgtq1yAVtlynnyHMK3kjdKVHWSzzxx/9fq5DpWQKYu
         uFouCpefIDGbxSjJ6uLwAvPlD+k/rnpTUE5yE4RTjHp/v/t7Y/50IOKA0+6mcFKqkS
         bDbWFaatfMikrY8xjz63C104GtDmitiWGq6t64sFVO6JZD8B1suaQ4ed7Ix0FOkLFJ
         ZqUY+QNom/i5Q==
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
Subject: [RFC PATCH 05/12] arm64: mm: remap PUD pages r/o in linear region
Date:   Wed, 26 Jan 2022 18:30:04 +0100
Message-Id: <20220126173011.3476262-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126173011.3476262-1-ardb@kernel.org>
References: <20220126173011.3476262-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; h=from:subject; bh=pO2QvUUsV5L71fd/N5ug5v8ZnpkBMeHmPsJTXFD+MSg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8YUVOOEJY4XVWRP3L+tY2Fd1rYmhhe86Q8f7AUSQ xXjIo1iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfGFFQAKCRDDTyI5ktmPJM0SC/ 9TJASSXr7BX76TnGrR6DVfOMgm4ePZMcUwkFtSUNvrQSheHkJ5Dhpn+wTwQ4G4uEaCrIvhsyhtOJXn gIAqHwx4C2T9W1b3QHf9d5i2c6OXAwWavoJbXb8Hc6W5hBuUylZ+Sb0Aksn1COSPDrNZKn8uB8hGIC /Qea52bWHMwHQdXM1FX2hlKl0SgwrSoyI5HhgMYMQSZJAm8smM6XDsjvXKXwerEg6thIIg3owWG3lp NDAgAmCQu7Se96JZUEYEQoTpGuVBpz4Z2RpNgEMGOCLwfvDDRV9g6cdh9xx+09jia6i0HYga3glYgY AkYpFuapogYWP+/BG6trhpDrEoW8nGh94AxbjdrhxuodEwdGEVg/uE4n4b7ytd6I6UmU5Uq2mUl6PC fhsWIcI82knyV4QIBwfu020onGbyrADdPL9XzuLKgXlr2lVwZmxWs342yn7MxpTq/Y6K5LZqFL6php ii5PZEXG/T7oY+AlBemmzo9R20Bdx0Xcgthq3RHGGaox4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Implement the arch specific PUD alloc/free helpers by wrapping the
generic code, and remapping the page read-only on allocation and
read-write on free.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgalloc.h |  5 +++++
 arch/arm64/include/asm/tlb.h     |  2 ++
 arch/arm64/mm/mmu.c              | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index d54ac9f8d6c7..737e9f32b199 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -14,6 +14,8 @@
 #include <asm/tlbflush.h>
 
 #define __HAVE_ARCH_PGD_FREE
+#define __HAVE_ARCH_PUD_ALLOC_ONE
+#define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
@@ -45,6 +47,9 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
+pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr);
+void pud_free(struct mm_struct *mm, pud_t *pud);
+
 static inline void __p4d_populate(p4d_t *p4dp, phys_addr_t pudp, p4dval_t prot)
 {
 	set_p4d(p4dp, __p4d(__phys_to_p4d_val(pudp) | prot));
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f..6557626752fc 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -94,6 +94,8 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
+	if (page_tables_are_ro())
+		set_pgtable_rw(pudp);
 	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a52c3162beae..03d77c4c3570 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1645,3 +1645,23 @@ static int __init prevent_bootmem_remove_init(void)
 }
 early_initcall(prevent_bootmem_remove_init);
 #endif
+
+#ifndef __PAGETABLE_PUD_FOLDED
+pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	pud_t *pud = __pud_alloc_one(mm, addr);
+
+	if (!pud)
+		return NULL;
+	if (page_tables_are_ro())
+		set_pgtable_ro(pud);
+	return pud;
+}
+
+void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	if (page_tables_are_ro())
+		set_pgtable_rw(pud);
+	free_page((u64)pud);
+}
+#endif
-- 
2.30.2

