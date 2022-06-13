Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5852CCCA47D
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiFMSbH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245612AbiFMSau (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00962B578F
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82BCB612DF
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4047C341C0;
        Mon, 13 Jun 2022 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131585;
        bh=D3Y+z2CgwBqoekMxwkb2ucgC0FP7HG6601DhcDR2wzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0O4lD4oZJKpTEMOfItfl7FXqjRomLSyjzzQbZN78VmsBIMEtGXA6xWte6twJcgye
         HOukRgHDFk1iYWkKlaYTof9t30Be6BGWL8pKpw+Hnn5geFPao/tOiqN7RBWiMXFHkw
         383THsyqRmZpRmTZbiXSKi3w5MjKnWQsgcyjGmpBPfsYQ2u8oOzRfdm8fNKJIz3uVE
         jgjjWxXm1Z/G/V2NMrh1lG1rE4XKzSeJXUCxC6gjCMpvMvcuG3jm3K7B0jRp4lvb7l
         S4dfS7DxrZp7v1LSi6EcQmwLZaP1BoNJkyo5HrUJqYOk+V2s35N1ylt5E9r9hwfWzM
         SwKpmNhX5NUxA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 09/26] arm64: head: pass ID map root table address to __enable_mmu()
Date:   Mon, 13 Jun 2022 16:45:33 +0200
Message-Id: <20220613144550.3760857-10-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427; h=from:subject; bh=D3Y+z2CgwBqoekMxwkb2ucgC0FP7HG6601DhcDR2wzo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip018oirtDh7FaU7FC1agsn7FyZARnqEWUpzu1ICl 1mqkBjKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNfAAKCRDDTyI5ktmPJEp/C/ 0Wr1y2rv4V0wHa68qfUTovw6nrONaAxWuPrhImt/h9WekuY82giNcuVahBDT/DdedhQY4RMJswp07R 0hAXgvWc6FvQ6cccXB19S7Yxrh7AdLqfKzv+m6NmUA2+kba85aRo3ydMSXpaQsJ8jpUOK2ZTYWpOYj /LznKLFa9aBzbNMuO+WigMLDQbzc7VV4AiGcfzu43xyzpdm4xuJWRDQyekUCZTGdQppNmEPk9rLyJx ZY7vat+Mv5qCFoG4/HCkGxvKhJvDdayOlP1pV/H5Pe1tutbRG8hcmITzapClpMGAbOma063HU96LgJ sQrCWsm8GEKpTysV4GI4x1K2130k1g3569OQhhPPQvebTvTMc6Azh/qKAVQfHxG0X89MzrnghQ5qVX ywIYZ1an9l/LZ+SUmNHtOOeQ9vzbHZdvOR9MLCTNigoBxabaf6rjBKKcaWhckV0P2cGenV7qRvBsNI pqsZ4nrj0oshz4F0RY3c8UcOyBE45M7ObYrnZ1aNTk0bY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

We will be adding an initial ID map that covers the entire kernel image,
so we will pass the actual ID map root table to use to __enable_mmu(),
rather than hard code it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 14 ++++++++------
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1cbc52097bf9..70c462bbd6bf 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -595,6 +595,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	bl	__cpu_secondary_check52bitva
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
+	adrp	x2, idmap_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -648,6 +649,7 @@ SYM_FUNC_END(__secondary_too_slow)
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
  *  x1  = TTBR1_EL1 value
+ *  x2  = ID map root table address
  *
  * Returns to the caller via x30/lr. This requires the caller to be covered
  * by the .idmap.text section.
@@ -656,14 +658,13 @@ SYM_FUNC_END(__secondary_too_slow)
  * If it isn't, park the CPU
  */
 SYM_FUNC_START(__enable_mmu)
-	mrs	x2, ID_AA64MMFR0_EL1
-	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
+	mrs	x3, ID_AA64MMFR0_EL1
+	ubfx	x3, x3, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
 	b.lt    __no_granule_support
-	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
+	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
 	b.gt    __no_granule_support
-	update_early_cpu_boot_status 0, x2, x3
-	adrp	x2, idmap_pg_dir
+	update_early_cpu_boot_status 0, x3, x4
 	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
@@ -819,6 +820,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #endif
 
 	adrp	x1, init_pg_dir
+	adrp	x2, idmap_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 4ea9392f86e0..e36b09d942f7 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -104,6 +104,7 @@ SYM_CODE_START(cpu_resume)
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adrp	x1, swapper_pg_dir
+	adrp	x2, idmap_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-- 
2.30.2

