Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350A9C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbiFMSbD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbiFMSat (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A140B5270
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D407FB8105C
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09ADC3411B;
        Mon, 13 Jun 2022 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131573;
        bh=TK0XDMFicoCubtMuGPUl7qGpaQR9mkGT6agzFlcYqVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSJPVioi2GTuicNvdduCenPGWetJFwLnWtN0bxt9krOuh8Eyyq0V3VYI0+Dl//V4m
         7OzpBjeoz40XeTQZgA6PlQrWbRDW2o8ujpCzxXA8bNZffI0HLss/5fUGElU/ci69vW
         xc5MFrdWKwWfyMbOsNBrdtYbYbjdw/WmztkiTdKTYn7Hnz0FFkZufkE0pa+tyOBTol
         hPpFgna47amTyeprBYxAeGiNRifkwfzcUAPtkEl3ksRHgmgAQpS84uEX0IiHRZH/ka
         3/rIBMsWB48zVjGewzyzU5GV08+Qj7U6XwjPnDbbphXb6U3lkgSkj6aT7Ypf5tuRyB
         dMeQFgIEdBIdw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 04/26] arm64: head: drop idmap_ptrs_per_pgd
Date:   Mon, 13 Jun 2022 16:45:28 +0200
Message-Id: <20220613144550.3760857-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2609; h=from:subject; bh=TK0XDMFicoCubtMuGPUl7qGpaQR9mkGT6agzFlcYqVU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip01yyP8epKxsVqgmgBlcH8pxg3ORPp2T64GlNKGs 4yCnl96JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNcgAKCRDDTyI5ktmPJP3vC/ 91ftbse8kWkkye9pYhMY9GsUsWt0naezTDmPTI/O51yz+aM9QHJ2PsP6rK+Gre1EkCPkJYJDZy1JHO fO6DOh6367q3VDwFUefeh2qpOyb9zswXqyKdEPN32/ZaMtk7RVy9PdVUZv/ydZ4QiMw8jGEjadz5Rr /+g3B1EYDUkOFOnpjO46+FI9YoIhdWdi/iGs9QqbvAmbFX4NRpfcm5YB7zhIbh07BdbwWgngqD4Eji 6pu6Wc7HHnK0A/lJFkAUQLtV9k79lQRouV6b+9o9S4BCAt/zbrB6WGlqMAZrNu6nObZtxWRAII1AXl gJNZx9eQe3siH5rA5WZhUiyoGxdHQiwEpT8VXcmZECMIk7UEkrqbArDo52zkiET+/KyFmrBV4GHm1H 4aDD4GyjOrZzJgFmYmiq6AHT+LQp0ygC+G3eY2W7PJNB6p/WdJ9PDy7MaBWnLrSeEWlUa9SxsXUacx jBXLO2gJAsmDzn5NL0vx/93y+tNEY8shq4V+fIpFRZhfo=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The assignment of idmap_ptrs_per_pgd lacks any cache invalidation, even
though it is updated with the MMU and caches disabled. However, we never
bother to read the value again except in the very next instruction, and
so we can just drop the variable entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 1 -
 arch/arm64/kernel/head.S             | 7 +++----
 arch/arm64/mm/mmu.c                  | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 6ac0086ebb1a..7b387c3b312a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -61,7 +61,6 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
  * physical memory, in which case it will be smaller.
  */
 extern int idmap_t0sz;
-extern u64 idmap_ptrs_per_pgd;
 
 /*
  * Ensure TCR.T0SZ is set to the provided value.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7f361bc72d12..53126a35d73c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -300,6 +300,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 * range in that case, and configure an additional translation level
 	 * if needed.
 	 */
+	mov	x4, #PTRS_PER_PGD
 	idmap_get_t0sz x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
@@ -319,18 +320,16 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
 
-	mov	x4, EXTRA_PTRS
-	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
+	mov	x2, EXTRA_PTRS
+	create_table_entry x0, x3, EXTRA_SHIFT, x2, x5, x6
 #else
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
 	 * translation level, but the top-level table has more entries.
 	 */
 	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
-	str_l	x4, idmap_ptrs_per_pgd, x5
 #endif
 1:
-	ldr_l	x4, idmap_ptrs_per_pgd
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
 
 	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 103bf4ae408d..0f95c91e5a8e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -44,7 +44,6 @@
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
 int idmap_t0sz __ro_after_init;
-u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
 #if VA_BITS > 48
 u64 vabits_actual __ro_after_init = VA_BITS_MIN;
-- 
2.30.2

