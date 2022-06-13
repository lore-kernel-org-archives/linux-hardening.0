Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF7C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbiFMSbN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245640AbiFMSa4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECEB57B8
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C45FD61416
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F9EC3411C;
        Mon, 13 Jun 2022 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131598;
        bh=7beXEY+KBTc27ISfxObaHwnTrPVTfmi/8un0rUMxTzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNKIdDwzEXUG4oPyasOVCIkbt9JWod52V0UojtL8zjEpcLhti4P+0GG/YdiRgtHUQ
         gTH2I4qdpocZCUSpVmyULFhEyW9nQXk7CX+MuE1k+xxxs4CYgY3XsglTLawapIbTdA
         zhaBFKxAiTNAYITWZT68naKcUcED1FPNAeKVd8Kqnjg8Usx4Np6Itj0djr8Jx715f4
         ACXOMy6xT2lOIIk5EQ0EdRGF0zKUZb3L8khCHOPpzHBZhnVnlCTk/Bc09uOpahqyQo
         E+K0MRCaEG8bJnf9cyvPPXwc+qtMbTtxIQR/IhCTyzu2EkVj0oKR+QCZaFheMK5sOa
         cRMyLQYsSnDiA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 14/26] arm64: head: create a temporary FDT mapping in the initial ID map
Date:   Mon, 13 Jun 2022 16:45:38 +0200
Message-Id: <20220613144550.3760857-15-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; h=from:subject; bh=7beXEY+KBTc27ISfxObaHwnTrPVTfmi/8un0rUMxTzE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip02IYL10J7/TdsI+a0ICE7ToYeWDjwX1yKy0PNf9 kGHVvN+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNiAAKCRDDTyI5ktmPJDjeC/ 9S1MPIhA9zngXHFMlY8JVKU3QRCAEL0ocCBbqeSdhUvZBXrtMXgq2sdxgDpb2aZTnjKiyz3zWJKnSZ a1wjK6kI50HYTwCVL47VaLrL54BsIrg1DMcvyG6ZZh3xqtyjNktNito10c/0m4xu/Wg/k8b4SKJqcv nwHFVW0YFUVYnTt/vLV4ySTyYDbDM5GOqrbz9z53PDOdmh9MEMvfcRMSCw41SnG0ZERUj+u0aaZyyF DSY3Msu3I4YdMqG/LwyDvMEV/jyfmdW+Fo80P/EWkFtu5xEZHSdFhz9z+zQiICyEsV4HAN/IvhjA4H XW5ZeKu8BsNXLzFoPBC/tZmEoMKxjz9xgIC0ZwoiZj1nsTw427NOBpbWuE5+z4n92cBOxdIbaQ+HIR MrqXsBoPQYlYnc3sYsbXsb4z385smd1uWl4D4iP/tqUrS9YqWFHrX1z3uJDOxpWnzZ6Ynm7a74NV/u sDpyQ7XSUT3TSMS29PDWGCcPEoqmeNhHd7irwHNZLEg9A=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

We need to access the DT very early to get at the command line and the
KASLR seed, which currently means we rely on some hacks to call into the
kernel before really calling into the kernel, which is undesirable.

So instead, let's create a mapping for the FDT in the initial ID map,
which is feasible now that it has been extended to cover more than a
single page or block, and can be updated in place to remap other output
addresses.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h |  6 ++++--
 arch/arm64/kernel/head.S                | 14 +++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 5395e5a04f35..02e59fa8f293 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_KERNEL_PGTABLE_H
 #define __ASM_KERNEL_PGTABLE_H
 
+#include <asm/boot.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sparsemem.h>
 
@@ -88,10 +89,11 @@
 
 /* the initial ID map may need two extra pages if it needs to be extended */
 #if VA_BITS < 48
-#define INIT_IDMAP_DIR_SIZE	(INIT_DIR_SIZE + (2 * PAGE_SIZE))
+#define INIT_IDMAP_DIR_SIZE	((INIT_IDMAP_DIR_PAGES + 2) * PAGE_SIZE)
 #else
-#define INIT_IDMAP_DIR_SIZE	INIT_DIR_SIZE
+#define INIT_IDMAP_DIR_SIZE	(INIT_IDMAP_DIR_PAGES * PAGE_SIZE)
 #endif
+#define INIT_IDMAP_DIR_PAGES	EARLY_PAGES(KIMAGE_VADDR, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE)
 
 /* Initial memory map size */
 #if ARM64_KERNEL_USES_PMD_MAPS
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index f1497f7b4da0..8283ff848328 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -83,6 +83,7 @@
 	 *
 	 *  Register   Scope                      Purpose
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
+	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
 	 *  x28        clear_page_tables()                      callee preserved temp register
 	 *  x19/x20    __primary_switch()                       callee preserved temp registers
@@ -348,7 +349,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 #endif
 	adrp	x0, init_idmap_pg_dir
 	adrp	x3, _text
-	adrp	x6, _end
+	adrp	x6, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
 	mov	x7, SWAPPER_RX_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
@@ -362,6 +363,17 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	mov	x6, #SWAPPER_BLOCK_SHIFT
 	bl	remap_region
 
+	/* Remap the FDT after the kernel image */
+	adrp	x1, _text
+	adrp	x22, _end + SWAPPER_BLOCK_SIZE
+	bic	x2, x22, #SWAPPER_BLOCK_SIZE - 1
+	bfi	x22, x21, #0, #SWAPPER_BLOCK_SHIFT		// remapped FDT address
+	add	x3, x2, #MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
+	bic	x4, x21, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RW_MMUFLAGS
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
 	/*
 	 * Since the page tables have been populated with non-cacheable
 	 * accesses (MMU disabled), invalidate those tables again to
-- 
2.30.2

