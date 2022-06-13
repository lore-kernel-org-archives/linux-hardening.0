Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125BC43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiFMSa5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245373AbiFMSam (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB16B5254
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5671761361
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A90C341C0;
        Mon, 13 Jun 2022 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131568;
        bh=71drfAk0ZiRHT9DmLxq6w4tXz3uG2lrwOupTfjSIhXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ar6NvvUTfqHUvhAvGfnsUyeEi3nnPJ1XUs2gWu7qZbIKTu8IrQXqy0a0N5V8yf3tW
         X6GcIsKuDGn2FbE47SPsZYcBjF/2RYb1pHNDlfWcHoIRk3bvEFCvvpnc86jOz7nnMg
         yaIntrUGiG5HjScjvS2DUnR+4Fiz8zAGwLGf59SHiAuY5SHNQsoVw8CqSDDoNng6l+
         ar/8zr4EA42E7pv+RSNYvwlj4rhVCQKjWpZbrUUJ4vg8IAkxGXUoC94eIyvHaktpbB
         BnzAtC/dUW2t1q1mpKci/mRl1mWzkw//eFLAqfF/P11nDnx8SOlqPKR7Svak6Mr5ik
         YThSwf8YHz5tw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 02/26] arm64: mm: make vabits_actual a build time constant if possible
Date:   Mon, 13 Jun 2022 16:45:26 +0200
Message-Id: <20220613144550.3760857-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103; h=from:subject; bh=71drfAk0ZiRHT9DmLxq6w4tXz3uG2lrwOupTfjSIhXk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip01u8HecTAOs/yp5NG1JWI0ajj/hBLCBcYafsUHI pYcScK+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNbgAKCRDDTyI5ktmPJBy5C/ 0UC1oE7lq0AGLBUWI1eIYOq98EdZA++pq1MdrizOK8D6hU6QBBkrAILGiHa6b7/i2IEZoQNj0f7rG2 FfSrbV5yyZaocOi5XlxSHvTBabamDtC4YHmQkSovTiNNJA0bX5OD3vrDTiG2PRq21XCTjS2PA0KK8S gxrdlEkWMFkbRY5ZTl6zIlna6tbGmabl4sJxckUha99kxCClQW+9flTKnm/aVRmw/OdT6w9/ba45DF 0Qv3DFNrK9BCqq4mtqOtCH+Oq/0tklwL1lfSdNLRwIWAEPnTWm4yIYbUt/MQt8td/wrWFsVTbo6wWS ATyfPVVwSsxvGwc8SsIdsdHVXCsSCH/q9/zZVbJxkQbpT8m2WsZFbhm77lx8usEkwDJRLjiCFAnYCq qGOco/bueMiFDo3RweCsFIw6/JndPvmRVvcDnzGqgOEpJNghtsMQTB+PpTxZk9PdjB4W0Jyhcr02r9 6UAJ/eDV35EQRpTWKm2Dk5vChIEbenP8dZnlFn3+g1g1s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, we only support 52-bit virtual addressing on 64k pages
configurations, and in all other cases, vabits_actual is guaranteed to
equal VA_BITS (== VA_BITS_MIN). So get rid of the variable entirely in
that case.

While at it, move the assignment out of the asm entry code - it has no
need to be there.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h |  4 ++++
 arch/arm64/kernel/head.S        | 15 +--------------
 arch/arm64/mm/mmu.c             | 15 ++++++++++++++-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..c751cd9b94f8 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -174,7 +174,11 @@
 #include <linux/types.h>
 #include <asm/bug.h>
 
+#if VA_BITS > 48
 extern u64			vabits_actual;
+#else
+#define vabits_actual		((u64)VA_BITS)
+#endif
 
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1cdecce552bb..dc07858eb673 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -293,19 +293,6 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
-#ifdef CONFIG_ARM64_VA_BITS_52
-	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
-	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
-	mov	x5, #52
-	cbnz	x6, 1f
-#endif
-	mov	x5, #VA_BITS_MIN
-1:
-	adr_l	x6, vabits_actual
-	str	x5, [x6]
-	dmb	sy
-	dc	ivac, x6		// Invalidate potentially stale cache line
-
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
 	 * that covers system RAM if that is located sufficiently high in the
@@ -713,7 +700,7 @@ SYM_FUNC_START(__enable_mmu)
 SYM_FUNC_END(__enable_mmu)
 
 SYM_FUNC_START(__cpu_secondary_check52bitva)
-#ifdef CONFIG_ARM64_VA_BITS_52
+#if VA_BITS > 48
 	ldr_l	x0, vabits_actual
 	cmp	x0, #52
 	b.ne	2f
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7148928e3932..17b339c1a326 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -46,8 +46,10 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+#if VA_BITS > 48
+u64 vabits_actual __ro_after_init = VA_BITS_MIN;
 EXPORT_SYMBOL(vabits_actual);
+#endif
 
 u64 kimage_vaddr __ro_after_init = (u64)&_text;
 EXPORT_SYMBOL(kimage_vaddr);
@@ -772,6 +774,17 @@ void __init paging_init(void)
 {
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
 
+#if VA_BITS > 48
+	if (cpuid_feature_extract_unsigned_field(
+				read_sysreg_s(SYS_ID_AA64MMFR2_EL1),
+				ID_AA64MMFR2_LVA_SHIFT))
+		vabits_actual = VA_BITS;
+
+	/* make the variable visible to secondaries with the MMU off */
+	dcache_clean_inval_poc((u64)&vabits_actual,
+			       (u64)&vabits_actual + sizeof(vabits_actual));
+#endif
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
-- 
2.30.2

