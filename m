Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D2C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiFMSbI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiFMSaw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A2BB7155
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0931B81060
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C49C341CD;
        Mon, 13 Jun 2022 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131610;
        bh=GqDI23bSuiV8aYzgn42giIgtWXOc73XpeIzBwYddOkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nt4Batc9kDAMRfT/WhjeOZEfx3e8VY36mf9OFYvKudfb1G8gX7iJ4HHwPPD4P19qf
         q8iANDjweTNA6B9jKiaUZv0A/Mo+k4YjNQER6+GmHEgmO6EBmxUI8+l0EZVE9PS4lQ
         juEkY8XLUO0LWAXsHgWLCJ+UR6/wmE+eoA4XqX0gB+FgDQkWo8Mj2rljWwmWn0WdK/
         VRtkMA4zoeIX2v5y5fvelUjN1L5ShWdlkXGGJ9nLs6eiWU50x9etn1hAtKtBpOqCR2
         dsMCqCUSqEus2Ehxos30Nw/bS3mxm/LQnHEwy1Yv9Ujn0zBOW5hzNisuUdBazwEFnf
         a4pF0Mtr0x5sg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 19/26] arm64: kaslr: defer initialization to late initcall where permitted
Date:   Mon, 13 Jun 2022 16:45:43 +0200
Message-Id: <20220613144550.3760857-20-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5544; h=from:subject; bh=GqDI23bSuiV8aYzgn42giIgtWXOc73XpeIzBwYddOkU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02RAZvFmPNlcckOd1+veU8Pj7WFEY2kiZ3I1G5X T8XJNkyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNkQAKCRDDTyI5ktmPJCHHDA C80Pih93ozbmc5Ew17rEEPb0WV0HtFMvMXw/SQDMuRX3oguCYrVBlJ0oOiayKKZfPBI0nQiW3ZlhpV N+yYEbqBwBjM6Lgp8DUnGk2zvAMJRZ7XA/9ZohCKdnuMSuUd/H0z1w9Fd40OZlWTDtovsZYpZSAOvu f0IdfoyYzXSK+EumnU//1Iho0q3UnKcysEl596R2XZIAQhzPvhtSHE65GKir/JdTn6DLc/0fhUIClH 3QP08EvM9plM3j38Dfk/GSkjRQwL9zTJUdMsROmyPYKcdYDXfjS0zGmUYVqN3tG4y1Fkwhu3GNyMn/ eOGocaQbW6xoXuh3rp3R2wTZWaKfZQk24EsKcMB+1OoFYUBv++MrFkG7uSOK9wheLR4yS0Cr0dZsVB 2BFHl+zf1+5VYQwwhaaVVnan1dwg0ukpSefigHLNpDhpTSobLBLJ+TID3syu2G72YeE2xf+JzmrhwR Rxl+ho0PtW/Aw0SnDvWiguPcBNNmqkbX3jiUZXr/0h9l4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The early KASLR init code runs extremely early, and anything that could
be deferred until later should be. So let's defer the randomization of
the module region until much later - this also simplifies the
arithmetic, given that we no longer have to reason about the link time
vs load time placement of the core kernel explicitly. Also get rid of
the global status variable, and infer the status reported by the
diagnostic print from other KASLR related context.

While at it, get rid of the special case for KASAN without
KASAN_VMALLOC, which never occurs in practice.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/kaslr.c | 95 +++++++++-----------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index d5542666182f..af9ffe4d0f0f 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -20,14 +20,6 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 
-enum kaslr_status {
-	KASLR_ENABLED,
-	KASLR_DISABLED_CMDLINE,
-	KASLR_DISABLED_NO_SEED,
-	KASLR_DISABLED_FDT_REMAP,
-};
-
-static enum kaslr_status __initdata kaslr_status;
 u64 __ro_after_init module_alloc_base;
 u16 __initdata memstart_offset_seed;
 
@@ -63,15 +55,9 @@ struct arm64_ftr_override kaslr_feature_override __initdata;
 u64 __init kaslr_early_init(void)
 {
 	void *fdt;
-	u64 seed, offset, mask, module_range;
+	u64 seed, offset, mask;
 	unsigned long raw;
 
-	/*
-	 * Set a reasonable default for module_alloc_base in case
-	 * we end up running with module randomization disabled.
-	 */
-	module_alloc_base = (u64)_etext - MODULES_VSIZE;
-
 	/*
 	 * Try to map the FDT early. If this fails, we simply bail,
 	 * and proceed with KASLR disabled. We will make another
@@ -79,7 +65,6 @@ u64 __init kaslr_early_init(void)
 	 */
 	fdt = get_early_fdt_ptr();
 	if (!fdt) {
-		kaslr_status = KASLR_DISABLED_FDT_REMAP;
 		return 0;
 	}
 
@@ -93,7 +78,6 @@ u64 __init kaslr_early_init(void)
 	 * return 0 if that is the case.
 	 */
 	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
-		kaslr_status = KASLR_DISABLED_CMDLINE;
 		return 0;
 	}
 
@@ -106,7 +90,6 @@ u64 __init kaslr_early_init(void)
 		seed ^= raw;
 
 	if (!seed) {
-		kaslr_status = KASLR_DISABLED_NO_SEED;
 		return 0;
 	}
 
@@ -126,19 +109,43 @@ u64 __init kaslr_early_init(void)
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
 
-	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
-	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
-	     IS_ENABLED(CONFIG_KASAN_SW_TAGS)))
-		/*
-		 * KASAN without KASAN_VMALLOC does not expect the module region
-		 * to intersect the vmalloc region, since shadow memory is
-		 * allocated for each module at load time, whereas the vmalloc
-		 * region is shadowed by KASAN zero pages. So keep modules
-		 * out of the vmalloc region if KASAN is enabled without
-		 * KASAN_VMALLOC, and put the kernel well within 4 GB of the
-		 * module region.
-		 */
-		return offset % SZ_2G;
+	return offset;
+}
+
+static int __init kaslr_init(void)
+{
+	u64 module_range;
+	u32 seed;
+
+	/*
+	 * Set a reasonable default for module_alloc_base in case
+	 * we end up running with module randomization disabled.
+	 */
+	module_alloc_base = (u64)_etext - MODULES_VSIZE;
+
+	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
+		pr_info("KASLR disabled on command line\n");
+		return 0;
+	}
+
+	if (!kaslr_offset()) {
+		pr_warn("KASLR disabled due to lack of seed\n");
+		return 0;
+	}
+
+	pr_info("KASLR enabled\n");
+
+	/*
+	 * KASAN without KASAN_VMALLOC does not expect the module region to
+	 * intersect the vmalloc region, since shadow memory is allocated for
+	 * each module at load time, whereas the vmalloc region will already be
+	 * shadowed by KASAN zero pages.
+	 */
+	BUILD_BUG_ON((IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	              IS_ENABLED(CONFIG_KASAN_SW_TAGS)) &&
+		     !IS_ENABLED(CONFIG_KASAN_VMALLOC));
+
+	seed = get_random_u32();
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
 		/*
@@ -150,8 +157,7 @@ u64 __init kaslr_early_init(void)
 		 * resolved normally.)
 		 */
 		module_range = SZ_2G - (u64)(_end - _stext);
-		module_alloc_base = max((u64)_end + offset - SZ_2G,
-					(u64)MODULES_VADDR);
+		module_alloc_base = max((u64)_end - SZ_2G, (u64)MODULES_VADDR);
 	} else {
 		/*
 		 * Randomize the module region by setting module_alloc_base to
@@ -163,33 +169,12 @@ u64 __init kaslr_early_init(void)
 		 * when ARM64_MODULE_PLTS is enabled.
 		 */
 		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
-		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
 	}
 
 	/* use the lower 21 bits to randomize the base of the module region */
 	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
 	module_alloc_base &= PAGE_MASK;
 
-	return offset;
-}
-
-static int __init kaslr_init(void)
-{
-	switch (kaslr_status) {
-	case KASLR_ENABLED:
-		pr_info("KASLR enabled\n");
-		break;
-	case KASLR_DISABLED_CMDLINE:
-		pr_info("KASLR disabled on command line\n");
-		break;
-	case KASLR_DISABLED_NO_SEED:
-		pr_warn("KASLR disabled due to lack of seed\n");
-		break;
-	case KASLR_DISABLED_FDT_REMAP:
-		pr_warn("KASLR disabled due to FDT remapping failure\n");
-		break;
-	}
-
 	return 0;
 }
-core_initcall(kaslr_init)
+late_initcall(kaslr_init)
-- 
2.30.2

